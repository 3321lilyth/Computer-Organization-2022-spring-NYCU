#include "direct_mapped_cache.h"
#include <math.h>
#include <fstream>
#include "string"
using namespace std;

struct cache_content {  // per row
    bool valid;
    unsigned int tag;
    // unsigned int data[16]; //不需要，因為只是要算 hit 數
};
double log2(double n) {
    return log(n) / log(2);
}
float direct_mapped(string filename, int block_size, int cache_size) {
    int total_num = 0;
    int hit_num = 0;

    //part1 : 先算那些+創建快取
    int offset_size = (int)round(log2(block_size));
    int index_size = (int)round(log2(cache_size / block_size));
    int row_num = cache_size / block_size;
    cache_content *cache = new cache_content[row_num];
    for (int j = 0; j < row_num; j++)
        cache[j].valid = false;

    //part2 : 一個一個位址讀進來丟進快取
    unsigned int address, tag, index;
    FILE *fp = fopen("testcase.txt", "r");
    while (fscanf(fp, "%x", &address) != EOF) {
        index = (address >> offset_size) & (row_num - 1); 
        tag = address >> (index_size + offset_size);
        if (cache[index].valid && cache[index].tag == tag) {
            cache[index].valid = true;
            hit_num++;
            total_num++;
        } else {
            cache[index].valid = true;
            cache[index].tag = tag;
            total_num++;
        }
    }
    fclose(fp);
    delete[] cache;
    return (float)hit_num / total_num;
}

