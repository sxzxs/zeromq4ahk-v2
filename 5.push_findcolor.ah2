#include <log>
#include <zmq>
logger.is_out_file := true
logger.is_use_editor := false
zmq_version(&a := 0, &b := 0, &c := 0)
logger.info("版本: ", a, b, c)

ctx := zmq_ctx_new()
socket := zmq_socket(ctx, ZMQ_PUSH)
rtn := zmq_bind(socket, "tcp://*:5555")

;recv := zmq_socket(ctx, ZMQ_REP)
;rtn := zmq_bind(recv, "tcp://*:5556")

color := ['0x000000', '0xffffff']

for k,v in color
{
    zmq_send_string(socket, v)
    logger.info(v)
}

/*
for k,v in color
{
    rtn := zmq_recv_string(recv, &recv_str := '')
    if(rtn == -1)
    {
        logger.info("超时")
        continue
    }
    logger.info("worker 的结果", recv_str)
    zmq_send_string(recv, "我收到了你的结果")
}
*/

zmq_close(socket)
;zmq_close(recv)
zmq_ctx_shutdown(ctx)


; 返回包含字符串的缓冲对象.
StrBuf(str, encoding := 'UTF-8')
{
    ; 计算所需的大小并分配缓冲.
    buf := Buffer(StrPut(str, encoding))
    ; 复制或转换字符串.
    StrPut(str, buf, encoding)
    return buf
}