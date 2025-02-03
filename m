Return-Path: <linux-kselftest+bounces-25617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97164A266D8
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3340E7A2DC6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02732116FA;
	Mon,  3 Feb 2025 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5AGptMl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C7F211298
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622363; cv=none; b=eB0u6/wCk6+FuWn2CRstTrShDrLrI0yA5w0vR+Y06ye4Xgav85XaQX41qT6YJQ6bbPHKw0mvYtEf9kVRj7A1S1lT3mMumdAuWs6t+RKc6/VtLyRNcff0Mv3fFNjJ9AgeL+8tBBBuxn+HxGWbX+QE5v24xoRFIseRRWUXYwoQxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622363; c=relaxed/simple;
	bh=B57kW1yvNRnK7o9wBpD56b5z9WEFuoFDqC2vAcf1tIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hDJ/yBBeqbYKDJ+SGNrgW4nelQay0hwugLFjrOs3d18pywW1A8yRBIIdppISrTj0oKUIeFNbV66ETTWkh3X4t5NIpEeLnraSx4PUIn1o59Fz+zXncmmxrdPPUFGdATaOWCGrnUfzK7Yz8W/6NTkdmc8C0dMLJd8c1MkU2U6Xj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5AGptMl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9b9981f1so13747356a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 14:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738622361; x=1739227161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NoumIr2NWF7hd9cn5yHj8D4DJ+Pk9SACiZ5SNvWOoS0=;
        b=g5AGptMl4tKdkZWjobe84lufY8UY4s6jO6iwbwLhsdl29pah3qsDtFAxefJVXtheFx
         MsZoqQRDGTo455QQOJamVs/JjucC4SlLeiBfOTfiRvr/Hvz3/MkBCtnYJ/wlwEmcy+M+
         U6xvpS/tXL/QLcSu7nSJ7gdM5ovZdgIy7aXnzJPo6jbX5AwfO/KXnx70OH8LHZEGHuR0
         Ls5F90D15ZL6/TmTM+p/o/G2GgLKOUerIBzervnS2C7LMhhW+u5q07tdgIvLhcipY7KE
         quUIVMeVkXoB7NjNEb4NADEDHKLNYILz0jPRYFV9i2O07k+aEky0PjhyinsZuvWL9pBP
         F8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622361; x=1739227161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoumIr2NWF7hd9cn5yHj8D4DJ+Pk9SACiZ5SNvWOoS0=;
        b=SoPQK4Yge9HAbah4j0sfRRbpCxPQ+TXWoV6kzv9OTGyUJbwBgHrEo6tYhFm4eLUJdQ
         CbaLNDo8GfBxByMuGUwjBX2/MkVjgv90eCC2Y48JBCOftW+o6Y7vGBRpNvw1Wj4lmaH2
         7/MzhykfdwSxTIH4olRo3gzcr8nSqzlC3uGcif66gUKjDzsfLBDWVcTAsU1ut2hDtGxP
         8CIF+ce79hI/JtTXnAawW5ZbqY4Aiq48VrKtYRsZ5qEiGNtpjN684p22WObNr6xojC0v
         mi9m0sdlENx1DYUQW97Uy0TTkK4vgX/I5N0oxeh5IPta2u6FeDskyRFEAHKlA2uB4ONN
         Dg1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqs1rNdqfT0SA0+126XzaLw9xUkvFqxPfco1Qp93InFs/0FsZsmirBgenBbtxD7MAC2Ki2/yZ8W8sRyrrzbaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDFYh2cEOSbU/yy5hZgaOQtH49fdtIQFa1kCJNxiY2iqmEBoul
	1W9HraYIIm/WzicBPP+qSMPB9OPgcXOc+RvKHMqLxkfbLfhtUIylpi/IRwlhy4JvZiHuxT/pn/u
	oe/I45IJnRFswVxCEss6RkA==
X-Google-Smtp-Source: AGHT+IFY5oJEaEe/sPoO/XYQkh/VUAJ2yDKDeukpK+zFchJO8a0EcIJDLprjVo/YUe8JqQL4TV0kfjYLAlixoIbEwQ==
X-Received: from pjbsi11.prod.google.com ([2002:a17:90b:528b:b0:2ea:4139:e72d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f8c:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-2f83abd7da8mr37215866a91.10.1738622361011;
 Mon, 03 Feb 2025 14:39:21 -0800 (PST)
Date: Mon,  3 Feb 2025 22:39:12 +0000
In-Reply-To: <20250203223916.1064540-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203223916.1064540-3-almasrymina@google.com>
Subject: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for devmem TX in ncdevmem.

This is a combination of the ncdevmem from the devmem TCP series RFCv1
which included the TX path, and work by Stan to include the netlink API
and refactored on top of his generic memory_provider support.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

---

v3:
- Update ncdevmem docs to run validation with RX-only and RX-with-TX.
- Fix build warnings (Stan).
- Make the validation expect new lines in the pattern so we can have the
  TX path behave like netcat (Stan).
- Change ret to errno in error() calls (Stan).
- Handle the case where client_ip is not provided (Stan).
- Don't assume mid is <= 2000 (Stan).

v2:
- make errors a static variable so that we catch instances where there
  are less than 20 errors across different buffers.
- Fix the issue where the seed is reset to 0 instead of its starting
  value 1.
- Use 1000ULL instead of 1000 to guard against overflow (Willem).
- Do not set POLLERR (Willem).
- Update the test to use the new interface where iov_base is the
  dmabuf_offset.
- Update the test to send 2 iov instead of 1, so we get some test
  coverage over sending multiple iovs at once.
- Print the ifindex the test is using, useful for debugging issues where
  maybe the test may fail because the ifindex of the socket is different
  from the dmabuf binding.
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
 1 file changed, 289 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 19a6969643f4..a5ac78ed007e 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -9,22 +9,31 @@
  *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201
  *
  *     On client:
- *     echo -n "hello\nworld" | nc -s <server IP> 5201 -p 5201
+ *     echo -n "hello\nworld" | \
+ *		ncdevmem -s <server IP> [-c <client IP>] -p 5201 -f eth1
  *
- * Test data validation:
+ * Note this is compatible with regular netcat. i.e. the sender or receiver can
+ * be replaced with regular netcat to test the RX or TX path in isolation.
+ *
+ * Test data validation (devmem TCP on RX only):
  *
  *     On server:
  *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201 -v 7
  *
  *     On client:
  *     yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
- *             tr \\n \\0 | \
- *             head -c 5G | \
+ *             head -c 1G | \
  *             nc <server IP> 5201 -p 5201
  *
+ * Test data validation (devmem TCP on RX and TX, validation happens on RX):
  *
- * Note this is compatible with regular netcat. i.e. the sender or receiver can
- * be replaced with regular netcat to test the RX or TX path in isolation.
+ *	On server:
+ *	ncdevmem -s <server IP> [-c <client IP>] -l -p 5201 -v 8 -f eth1
+ *
+ *	On client:
+ *	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06\\x07) | \
+ *		head -c 1M | \
+ *		ncdevmem -s <server IP> [-c <client IP>] -p 5201 -f eth1
  */
 #define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
@@ -40,15 +49,18 @@
 #include <fcntl.h>
 #include <malloc.h>
 #include <error.h>
+#include <poll.h>
 
 #include <arpa/inet.h>
 #include <sys/socket.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
+#include <sys/time.h>
 
 #include <linux/memfd.h>
 #include <linux/dma-buf.h>
+#include <linux/errqueue.h>
 #include <linux/udmabuf.h>
 #include <libmnl/libmnl.h>
 #include <linux/types.h>
@@ -80,6 +92,8 @@ static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
+static uint32_t tx_dmabuf_id;
+static int waittime_ms = 500;
 
 struct memory_buffer {
 	int fd;
@@ -93,6 +107,8 @@ struct memory_buffer {
 struct memory_provider {
 	struct memory_buffer *(*alloc)(size_t size);
 	void (*free)(struct memory_buffer *ctx);
+	void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
+				 void *src, int n);
 	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
 				   size_t off, int n);
 };
@@ -153,6 +169,20 @@ static void udmabuf_free(struct memory_buffer *ctx)
 	free(ctx);
 }
 
+static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t off,
+				     void *src, int n)
+{
+	struct dma_buf_sync sync = {};
+
+	sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
+	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
+
+	memcpy(dst->buf_mem + off, src, n);
+
+	sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
+	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
+}
+
 static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
 				       size_t off, int n)
 {
@@ -170,6 +200,7 @@ static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
 static struct memory_provider udmabuf_memory_provider = {
 	.alloc = udmabuf_alloc,
 	.free = udmabuf_free,
+	.memcpy_to_device = udmabuf_memcpy_to_device,
 	.memcpy_from_device = udmabuf_memcpy_from_device,
 };
 
@@ -188,14 +219,16 @@ void validate_buffer(void *line, size_t size)
 {
 	static unsigned char seed = 1;
 	unsigned char *ptr = line;
-	int errors = 0;
+	unsigned char expected;
+	static int errors;
 	size_t i;
 
 	for (i = 0; i < size; i++) {
-		if (ptr[i] != seed) {
+		expected = seed ? seed : '\n';
+		if (ptr[i] != expected) {
 			fprintf(stderr,
 				"Failed validation: expected=%u, actual=%u, index=%lu\n",
-				seed, ptr[i], i);
+				expected, ptr[i], i);
 			errors++;
 			if (errors > 20)
 				error(1, 0, "validation failed.");
@@ -394,6 +427,49 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
+static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
+			 struct ynl_sock **ys)
+{
+	struct netdev_bind_tx_req *req = NULL;
+	struct netdev_bind_tx_rsp *rsp = NULL;
+	struct ynl_error yerr;
+
+	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!*ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = netdev_bind_tx_req_alloc();
+	netdev_bind_tx_req_set_ifindex(req, ifindex);
+	netdev_bind_tx_req_set_fd(req, dmabuf_fd);
+
+	rsp = netdev_bind_tx(*ys, req);
+	if (!rsp) {
+		perror("netdev_bind_tx");
+		goto err_close;
+	}
+
+	if (!rsp->_present.id) {
+		perror("id not present");
+		goto err_close;
+	}
+
+	fprintf(stderr, "got tx dmabuf id=%d\n", rsp->id);
+	tx_dmabuf_id = rsp->id;
+
+	netdev_bind_tx_req_free(req);
+	netdev_bind_tx_rsp_free(rsp);
+
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
+	netdev_bind_tx_req_free(req);
+	ynl_sock_destroy(*ys);
+	return -1;
+}
+
 static void enable_reuseaddr(int fd)
 {
 	int opt = 1;
@@ -432,7 +508,7 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
 	return 0;
 }
 
-int do_server(struct memory_buffer *mem)
+static int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
@@ -686,6 +762,206 @@ void run_devmem_tests(void)
 	provider->free(mem);
 }
 
+static uint64_t gettimeofday_ms(void)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	return (tv.tv_sec * 1000ULL) + (tv.tv_usec / 1000ULL);
+}
+
+static int do_poll(int fd)
+{
+	struct pollfd pfd;
+	int ret;
+
+	pfd.revents = 0;
+	pfd.fd = fd;
+
+	ret = poll(&pfd, 1, waittime_ms);
+	if (ret == -1)
+		error(1, errno, "poll");
+
+	return ret && (pfd.revents & POLLERR);
+}
+
+static void wait_compl(int fd)
+{
+	int64_t tstop = gettimeofday_ms() + waittime_ms;
+	char control[CMSG_SPACE(100)] = {};
+	struct sock_extended_err *serr;
+	struct msghdr msg = {};
+	struct cmsghdr *cm;
+	__u32 hi, lo;
+	int ret;
+
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	while (gettimeofday_ms() < tstop) {
+		if (!do_poll(fd))
+			continue;
+
+		ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				continue;
+			error(1, errno, "recvmsg(MSG_ERRQUEUE)");
+			return;
+		}
+		if (msg.msg_flags & MSG_CTRUNC)
+			error(1, 0, "MSG_CTRUNC\n");
+
+		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+			if (cm->cmsg_level != SOL_IP &&
+			    cm->cmsg_level != SOL_IPV6)
+				continue;
+			if (cm->cmsg_level == SOL_IP &&
+			    cm->cmsg_type != IP_RECVERR)
+				continue;
+			if (cm->cmsg_level == SOL_IPV6 &&
+			    cm->cmsg_type != IPV6_RECVERR)
+				continue;
+
+			serr = (void *)CMSG_DATA(cm);
+			if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY)
+				error(1, 0, "wrong origin %u", serr->ee_origin);
+			if (serr->ee_errno != 0)
+				error(1, 0, "wrong errno %d", serr->ee_errno);
+
+			hi = serr->ee_data;
+			lo = serr->ee_info;
+
+			fprintf(stderr, "tx complete [%d,%d]\n", lo, hi);
+			return;
+		}
+	}
+
+	error(1, 0, "did not receive tx completion");
+}
+
+static int do_client(struct memory_buffer *mem)
+{
+	char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
+	struct sockaddr_in6 server_sin;
+	struct sockaddr_in6 client_sin;
+	struct dmabuf_tx_cmsg ddmabuf;
+	struct ynl_sock *ys = NULL;
+	struct msghdr msg = {};
+	ssize_t line_size = 0;
+	struct cmsghdr *cmsg;
+	struct iovec iov[2];
+	char *line = NULL;
+	unsigned long mid;
+	size_t len = 0;
+	int socket_fd;
+	int ret;
+	int opt = 1;
+
+	ret = parse_address(server_ip, atoi(port), &server_sin);
+	if (ret < 0)
+		error(1, 0, "parse server address");
+
+	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (socket_fd < 0)
+		error(1, socket_fd, "create socket");
+
+	enable_reuseaddr(socket_fd);
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
+			 strlen(ifname) + 1);
+	if (ret)
+		error(1, errno, "bindtodevice");
+
+	if (bind_tx_queue(ifindex, mem->fd, &ys))
+		error(1, 0, "Failed to bind\n");
+
+	if (client_ip) {
+		ret = parse_address(client_ip, atoi(port), &client_sin);
+		if (ret < 0)
+			error(1, 0, "parse client address");
+
+		ret = bind(socket_fd, &client_sin, sizeof(client_sin));
+		if (ret)
+			error(1, errno, "bind");
+	}
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+	if (ret)
+		error(1, errno, "set sock opt");
+
+	fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
+		ntohs(server_sin.sin6_port), ifname);
+
+	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
+	if (ret)
+		error(1, errno, "connect");
+
+	while (1) {
+		free(line);
+		line = NULL;
+		line_size = getline(&line, &len, stdin);
+
+		if (line_size < 0)
+			break;
+
+		mid = (line_size / 2) + 1;
+
+		iov[0].iov_base = (void *)1;
+		iov[0].iov_len = mid;
+		iov[1].iov_base = (void *)(mid + 2);
+		iov[1].iov_len = line_size - mid;
+
+		provider->memcpy_to_device(mem, (size_t)iov[0].iov_base, line,
+					   iov[0].iov_len);
+		provider->memcpy_to_device(mem, (size_t)iov[1].iov_base,
+					   line + iov[0].iov_len,
+					   iov[1].iov_len);
+
+		fprintf(stderr,
+			"read line_size=%ld iov[0].iov_base=%lu, iov[0].iov_len=%lu, iov[1].iov_base=%lu, iov[1].iov_len=%lu\n",
+			line_size, (unsigned long)iov[0].iov_base,
+			iov[0].iov_len, (unsigned long)iov[1].iov_base,
+			iov[1].iov_len);
+
+		msg.msg_iov = iov;
+		msg.msg_iovlen = 2;
+
+		msg.msg_control = ctrl_data;
+		msg.msg_controllen = sizeof(ctrl_data);
+
+		cmsg = CMSG_FIRSTHDR(&msg);
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
+
+		ddmabuf.dmabuf_id = tx_dmabuf_id;
+
+		*((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;
+
+		ret = sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
+		if (ret < 0)
+			error(1, errno, "Failed sendmsg");
+
+		fprintf(stderr, "sendmsg_ret=%d\n", ret);
+
+		if (ret != line_size)
+			error(1, errno, "Did not send all bytes");
+
+		wait_compl(socket_fd);
+	}
+
+	fprintf(stderr, "%s: tx ok\n", TEST_PREFIX);
+
+	free(line);
+	close(socket_fd);
+
+	if (ys)
+		ynl_sock_destroy(ys);
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	struct memory_buffer *mem;
@@ -729,6 +1005,8 @@ int main(int argc, char *argv[])
 
 	ifindex = if_nametoindex(ifname);
 
+	fprintf(stderr, "using ifindex=%u\n", ifindex);
+
 	if (!server_ip && !client_ip) {
 		if (start_queue < 0 && num_queues < 0) {
 			num_queues = rxq_num(ifindex);
@@ -779,7 +1057,7 @@ int main(int argc, char *argv[])
 		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
-	ret = is_server ? do_server(mem) : 1;
+	ret = is_server ? do_server(mem) : do_client(mem);
 	provider->free(mem);
 
 	return ret;
-- 
2.48.1.362.g079036d154-goog


