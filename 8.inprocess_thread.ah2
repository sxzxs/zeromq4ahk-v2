;thread.ah2
#include <log>
#include <zmq>
thread_var := 100
logger.info("i am thread!")

logger.info(A_Args[1])


ctx := A_Args[1]
socket := zmq_socket(A_Args[1], ZMQ_SUB)
rtn := zmq_connect(socket, "inproc://main")
logger.info(rtn)
rtn := zmq_setsockopt(socket, ZMQ_SUBSCRIBE, buf := StrBuf(''), buf.Size - 1)

loop(50)
{
    rtn := zmq_recv_string(socket, &recv_str := '')
    logger.info(recv_str)
}

zmq_close(socket)
zmq_ctx_shutdown(ctx)




thread_func(a, b)
{
    logger.info(A_ThreadID " >thread func", a, b)
    return b
}
; 返回包含字符串的缓冲对象.
StrBuf(str, encoding := 'UTF-8')
{
    ; 计算所需的大小并分配缓冲.
    buf := Buffer(StrPut(str, encoding))
    ; 复制或转换字符串.
    StrPut(str, buf, encoding)
    return buf
}