#include "set_associative_cache.h"
#include <math.h>
#include <climits>
#include <fstream>
#include "string"

using namespace std;

struct cache_content{
    bool valid;
    unsigned int tag;
    int index_of_block;
};

double log_2(double n) {
    return log(n) / log(2);
}

float set_associative(string filename, int way, int block_size, int cache_size)
{
    int total_num = 0;
    int hit_num = 0;

    //part1 : 先算變數+創建快取
    int offset_size = (int)round(log_2(block_size));
    int index_size = (int)round(log_2(cache_size / (block_size*way)));
    int row_num = cache_size / (block_size*way);
    cache_content *cache = new cache_content[row_num*way];
    for(int i=0;i<row_num;i++){
        for(int j=0;j<way;j++){
            cache[i*way+j].valid = false;
        }
    }

    //part2 : 一個一個位址讀進來丟進快取
    unsigned int address, tag, index;
    FILE *fp = fopen("testcase.txt", "r");
    while (fscanf(fp, "%x", &address) != EOF) {
        index = (address >> offset_size) & (row_num - 1); 
        tag = address >> (index_size + offset_size);

        int flag = 0;
        for(int i=0;i<way;i++){
            int current_index = index*way+i;
            if (cache[current_index].valid && cache[current_index].tag == tag) { //hit
                cache[current_index].valid = true;
                cache[current_index].index_of_block = total_num;
                hit_num++;
                total_num++;
                flag = 1;
                break;
            }else if(!cache[current_index].valid){ //miss但有位置存進去
                cache[current_index].valid = true;
                cache[current_index].tag = tag;
                cache[current_index].index_of_block = total_num; //給index
                total_num++;
                flag = 1;
                break;
            }
        }

        if(flag == 0){ //miss且要LRU
            int lru = INT_MAX;
            int replace;
            for(int j=0;j<way;j++){
                int current_index = index*way+j;
                if (cache[current_index].valid && cache[current_index].index_of_block < lru){
                    lru = cache[current_index].index_of_block;
                    replace = current_index;
                }
            }
            cache[replace].tag = tag;
            cache[replace].index_of_block = total_num;
            total_num++;
        }  
    }
    fclose(fp);
    delete[] cache;
    return (float)hit_num/total_num;
}
