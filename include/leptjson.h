#ifndef LEPTJSON_H__
#define LEPTJSON_H__
#include <stddef.h>
/*
 * JSON 的 6 种数据类型
 */
typedef enum
{
	LEPT_NULL,
	LEPT_FALSE,
	LEPT_TRUE,
	LEPT_NUMBER,
	LEPT_STRING,
	LEPT_ARRAY,
	LEPT_OBJECT
} lept_type;

/*
 * JSON 的数据结构，每个节点使用 lept_value 结构体表示
 */
typedef struct
{
	union {
		struct {char *s; size_t len;}; /* string */
		double n; /* value */
	};
	lept_type type;
} lept_value;

enum
{
	LEPT_PARSE_OK = 0, // 无错误
	LEPT_PARSE_EXPECT_VALUE, // 
	LEPT_PARSE_INVALID_VALUE, // 非法
	LEPT_PARSE_ROOT_NOT_SINGULAR, 
	LEPT_PARSE_NUMBER_TOO_BIG // 数字超出可表示范围
};
/*
 * 解析 JSON
 */
int lept_parse(lept_value *v, const char *json);

lept_type lept_get_type(const lept_value *v);

double lept_get_number(const lept_value* v);

#endif /* LEPTJSON_H__ */
