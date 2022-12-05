#include <log>
#include <zmq>

logger.is_out_file := true
logger.is_use_editor := false
zmq_version(&a := 0, &b := 0, &c := 0)
logger.info("版本: ", a, b, c)

ctx := zmq_ctx_new()
socket := zmq_socket(ctx, ZMQ_PUB)
rtn := zmq_bind(socket, "inproc://main")
Sleep(1000)



a := Worker('#include 8.inprocess_thread.ah2', ctx)
b := Worker('#include 8.inprocess_thread.ah2', ctx)
c := Worker('#include 8.inprocess_thread.ah2', ctx)
d := Worker('#include 8.inprocess_thread.ah2', ctx)
loop
{ 
}until(a.Ready && b.Ready && c.Ready && d.Ready) 

loop
{
    zmq_send_string(socket, A_Index)
    logger.info(A_Index)
    Sleep(1000)
}

zmq_close(socket)
zmq_ctx_shutdown(ctx)
