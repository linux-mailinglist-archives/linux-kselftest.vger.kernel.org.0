Return-Path: <linux-kselftest+bounces-31853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1ECAA007D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 05:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32F01B62DA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 03:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEBE27978C;
	Tue, 29 Apr 2025 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0/vOse7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A812777FC
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897227; cv=none; b=CkZ1mqOuWjKKrbIUk2mxvOpUoGRgT6IR3GvY9YF6upmYo89vJ19AG2+y/9A7p9prO8j4cDABTgRmiOggZiImhi7mb9mV2sIXpEQER/88VdiGTWYzail7dtcBFke7WIZ5KIw/rqMqJ61Lool7Q86jiqQG9zTQ8a6oiKHANLDRgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897227; c=relaxed/simple;
	bh=QtSO5nlVXPkCRK88VhahUHwkbHyxPNFISaazexycgu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=USHlIh+iq6aibknLZmUbooIIcGbNIf92cRDF0jF0FVj3mT5yHyDdlMMxo6A6FekmojsEU9r5QNLGtI95zn6EEr0J+LiOpqWP4mA76ikB18LwfsdiNQzTwb2JM9MX6pnqhxhaBUUKJcykn4zdMnLbxEHiz7e38z1d4mrDqF4z9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0/vOse7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af972dd0cd6so3179318a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 20:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745897224; x=1746502024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLRFIGt2Ey1m50gqrm2J+sBnLuvF3wbxV6n2FoXWwZk=;
        b=g0/vOse7Z2AFPLN8PhEG7zUlJZc8+Q8RK+Z+uIh+GikCwXwKuQQ4iqxFyzDyDC7vte
         XznM22JtOYT5al8aQpw+Gw91z4nq7ci/QYP0NSOcvAyF5N9ymaGBp6MYa4HWEDVvnpS9
         lpaF3siSzWrz7LSX+Xourh5Zk+WnM8TkQsrAGTybjxCtifT8pa4cctLn8XRifEE5CGfu
         z1LWL3flbXFnlv7TTQX+JMUSByCdSJ97jIZ1MpZnHPHjGQ0VZqW5k+rt8T+9vukyWmvl
         E/sHOZtSbcUJ2RkRyWor5YCH4r0bypyvpxb3P9yRGixATIzWpUi3r8V6WAdtrObKdOcX
         KLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897224; x=1746502024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLRFIGt2Ey1m50gqrm2J+sBnLuvF3wbxV6n2FoXWwZk=;
        b=TwgC/EtVuwZFUQgDpI244nspK/SsLjAOZAlG2rXe/0BhO8LJb5ch8DBPE2ea8CZUQh
         zJ+l0MG7y3mitF3xTJBk8eOofQrJDOpW89SzZiK/DpnZwWqltz+S2o1Udf9u4sp6iiyE
         iPmwMimg/Zh+3KcxkYVGBgozwy5UUCpUHFECmEVkjHioWvMhenFy7MVA+eSoK5E/7Ez3
         GQxuiCLOVUTTHl3o94IJysTp49lLDoMa1l3E30WgHivJV/ED6wFFhj6m4Zrh+6+ZBDPM
         kg7xJrmMkOQB2Ygr85YEvFLZhrJvAHhfH+4k03qFzwoJgAUrh+cA4zFivvAYz95pmlCV
         1gsg==
X-Forwarded-Encrypted: i=1; AJvYcCWdE3tywltIEcvV+WG82URuN89tfCFZk8Kbtc+tQ6/+JsVp+UUcUgVPVyiPrFnKpu5hO5Z7ost5PW4iQty90RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp38XyLUwJajvrjzB0IyD3xQGukWjhY0vJayCCpjXNYB4wewCS
	exhMd4PLXsNxKBJKYl8lZllTwEiUqr3PCPS4WPHFWJtW33gIXkBf3DoZJIH83tLBbzP2/T3x/V4
	xJE+dA83a3BARPTsrhDSdwg==
X-Google-Smtp-Source: AGHT+IExMbhMRAF+/sgY1RYdUT/6sqcYfgIryFakw88y7rmYQ9+58dk1gS5dnNa4851+6m4YzqL48EPK9e4SQX2MNw==
X-Received: from pgbfq27.prod.google.com ([2002:a05:6a02:299b:b0:af2:357f:4269])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:31c8:b0:1f5:520d:fb93 with SMTP id adf61e73a8af0-2093cb057e0mr2955575637.24.1745897223714;
 Mon, 28 Apr 2025 20:27:03 -0700 (PDT)
Date: Tue, 29 Apr 2025 03:26:45 +0000
In-Reply-To: <20250429032645.363766-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250429032645.363766-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429032645.363766-10-almasrymina@google.com>
Subject: [PATCH net-next v13 9/9] selftests: ncdevmem: Implement devmem TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for devmem TX in ncdevmem.

This is a combination of the ncdevmem from the devmem TCP series RFCv1
which included the TX path, and work by Stan to include the netlink API
and refactored on top of his generic memory_provider support.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v5:
- Remove unnecassyr socat bindings (Stan).
- Add exit_wait=True (Stan)
- Remove unnecessary -c arg to ncdevmem in check_tx.

v4:
- Add TX test to devmem.py (Paolo).

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
 .../selftests/drivers/net/hw/devmem.py        |  26 +-
 .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
 2 files changed, 311 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 3947e91571159..7fc686cf47a2d 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -1,6 +1,7 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+from os import path
 from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, KsftSkipEx
 from lib.py import NetDrvEpEnv
@@ -10,8 +11,7 @@ from lib.py import ksft_disruptive
 
 def require_devmem(cfg):
     if not hasattr(cfg, "_devmem_probed"):
-        port = rand_port()
-        probe_command = f"./ncdevmem -f {cfg.ifname}"
+        probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
         cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
         cfg._devmem_probed = True
 
@@ -25,7 +25,7 @@ def check_rx(cfg) -> None:
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
 
     with bkg(listen_cmd) as socat:
         wait_port_listen(port)
@@ -34,9 +34,27 @@ def check_rx(cfg) -> None:
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
+@ksft_disruptive
+def check_tx(cfg) -> None:
+    cfg.require_ipver("6")
+    require_devmem(cfg)
+
+    port = rand_port()
+    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
+
+    with bkg(listen_cmd, exit_wait=True) as socat:
+        wait_port_listen(port)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}", host=cfg.remote, shell=True)
+
+    ksft_eq(socat.stdout.strip(), "hello\nworld")
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
-        ksft_run([check_rx],
+        cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+        ksft_run([check_rx, check_tx],
                  args=(cfg, ))
     ksft_exit()
 
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 2bf14ac2b8c62..f801a1b3545f0 100644
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
 #include <linux/types.h>
 #include <linux/netlink.h>
@@ -79,6 +91,8 @@ static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
+static uint32_t tx_dmabuf_id;
+static int waittime_ms = 500;
 
 struct memory_buffer {
 	int fd;
@@ -92,6 +106,8 @@ struct memory_buffer {
 struct memory_provider {
 	struct memory_buffer *(*alloc)(size_t size);
 	void (*free)(struct memory_buffer *ctx);
+	void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
+				 void *src, int n);
 	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
 				   size_t off, int n);
 };
@@ -152,6 +168,20 @@ static void udmabuf_free(struct memory_buffer *ctx)
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
@@ -169,6 +199,7 @@ static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
 static struct memory_provider udmabuf_memory_provider = {
 	.alloc = udmabuf_alloc,
 	.free = udmabuf_free,
+	.memcpy_to_device = udmabuf_memcpy_to_device,
 	.memcpy_from_device = udmabuf_memcpy_from_device,
 };
 
@@ -187,14 +218,16 @@ void validate_buffer(void *line, size_t size)
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
@@ -393,6 +426,49 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
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
@@ -431,7 +507,7 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
 	return 0;
 }
 
-int do_server(struct memory_buffer *mem)
+static int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
@@ -685,6 +761,206 @@ void run_devmem_tests(void)
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
+	char ctrl_data[CMSG_SPACE(sizeof(__u32))];
+	struct sockaddr_in6 server_sin;
+	struct sockaddr_in6 client_sin;
+	struct ynl_sock *ys = NULL;
+	struct msghdr msg = {};
+	ssize_t line_size = 0;
+	struct cmsghdr *cmsg;
+	struct iovec iov[2];
+	char *line = NULL;
+	unsigned long mid;
+	size_t len = 0;
+	int socket_fd;
+	__u32 ddmabuf;
+	int opt = 1;
+	int ret;
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
+		cmsg->cmsg_len = CMSG_LEN(sizeof(__u32));
+
+		ddmabuf = tx_dmabuf_id;
+
+		*((__u32 *)CMSG_DATA(cmsg)) = ddmabuf;
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
@@ -728,6 +1004,8 @@ int main(int argc, char *argv[])
 
 	ifindex = if_nametoindex(ifname);
 
+	fprintf(stderr, "using ifindex=%u\n", ifindex);
+
 	if (!server_ip && !client_ip) {
 		if (start_queue < 0 && num_queues < 0) {
 			num_queues = rxq_num(ifindex);
@@ -778,7 +1056,7 @@ int main(int argc, char *argv[])
 		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
-	ret = is_server ? do_server(mem) : 1;
+	ret = is_server ? do_server(mem) : do_client(mem);
 	provider->free(mem);
 
 	return ret;
-- 
2.49.0.901.g37484f566f-goog


