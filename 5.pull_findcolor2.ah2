#include <log>
#include <zmq>
logger.is_out_file := true
logger.is_use_editor := false
zmq_version(&a := 0, &b := 0, &c := 0)
logger.info("版本: ", a, b, c)

ctx := zmq_ctx_new()
socket := zmq_socket(ctx, ZMQ_PULL)
rtn := zmq_connect(socket, "tcp://localhost:5555")

req := zmq_socket(ctx, ZMQ_REQ)
rnt := zmq_connect(REQ, "tcp://localhost:5556")

rtn := zmq_recv_string(socket, &recv_str := '')
logger.info("任务", recv_str)
sleep(3000)

zmq_send_string(req, "没找到")
zmq_recv_string(req, &recv_str := '')
logger.info(recv_str)

zmq_close(socket)
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