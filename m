Return-Path: <linux-kselftest+bounces-25444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC46A2366E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 22:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D693A4DDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA321F2363;
	Thu, 30 Jan 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3l0sL/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFE1F150E
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271749; cv=none; b=SJ5OpKxB5XFFbT2F72Jhdvg6F5ODohN1Im7xEX+nqpGstIgBgNknnOBamCGXd492mj1oCgujORWgynl5MsjO9E1az1a70RqNGZ8wwYm4jIPcJ9I3uj1xD99E3FSsSZvP+48BORSsMw93Zm1IBPngsLt/a9vI+sKs/Z/zgdLFlok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271749; c=relaxed/simple;
	bh=66rLAwnUv7rphgDJMF+7euFwFkLHnlg56rVm7MMIEb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AzzpIVs0JFimRga2n4dKSNZL6SjyKNkm7H6DMS4aV2S2Ut7cwhk+fljhaHUGBKzdh1NhqtEo1UUH94lYChORfDtWZkVF9u3azc/Pg2QPd7oYDjhZaCKy+gFTnKg/2fa2zG8GtQh92a6on0dHUDKjsCknR0jGgpFLATQNmYL8pPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3l0sL/1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163dc0f689so37679425ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738271746; x=1738876546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4JyUAFzTAYUC0Df8KEcLXbVKxtOHohKpnphfTgnZKU=;
        b=c3l0sL/1rBNUmsWHa5wLfT5qZL8+qDETeR/QeLM3XhzGgAQ8Ce71j8ue0Th4wTSV8M
         W5pBSt9Zuc8A5L03Ior1+RzdzpwZCUqVVum1Uc3sa+oIpFr/r9txkh2eGP1+8ql/Mvs8
         l8Ce4a/gb+7oPS3V072fwEGi7CWIP3tSpyoNeEadxLc+h6fTNT9ti+BUyHM6D83egbDm
         IXuQyns6f8rN03PmOTTixFPD1PXzw2q0zyEm19WFe6gRxTAG9gfW0Sv/6JDpE1LFWDbo
         tRSpLejrtnTvZcOUEzZ92x5TL6HdblmGcLQk+j8Orz7ZALO8OiKXKWufyP7/ZLYZhqQX
         HCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271746; x=1738876546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4JyUAFzTAYUC0Df8KEcLXbVKxtOHohKpnphfTgnZKU=;
        b=tCHnbel713KRV7Tyd/c32WEsCj8aoVKlxTW+Cum8Gx38Yuo3wnK6uV9oaA11trHXae
         yekkVDe5AGUKa/p1AkO1dFxEdmGsP3WTH1uILaB5iyxarpi3WUFth4+0X6Ohm7T5Kzvp
         IaXWoSYw5kzz/tpsDzRWH6pTi0KNLWviI9LxY5ieeVbSrXT11cGmcVwYgyi4SXcAaIs7
         TR1Er7qSq+1Kzw/MepC54VSB6gzS/AcNapv1RZ4uhpfR8XlVeeazgkiLLiThzuHtKbkG
         VSLKP0cozzqdhowB+Q24ZiCGtrDzrF04wdGMlS6ieO4vSD+Sgdw9fDE9mJ9FXzVV+y68
         87DA==
X-Forwarded-Encrypted: i=1; AJvYcCWVzPJBymCgtH5fbSyr2Df+s0IHsFHhT42RUL1/tUOmNVARppkSEw/OEbMiS8XLdwGpWmUu0phT//3HG0HWI/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/CekcQPwk8/KrRs4p2twjvpavU9Rqm8gavm1nBDOwTveeT4LR
	O0g2YTq5uEIzIpKj6nKwZuo3/SdMgqrmA7qScX2MP4Yv8fLqoLQfDJasT7nzRApu38+j/PRzEMs
	v79MRrwqyfjygQ12hRHNHaA==
X-Google-Smtp-Source: AGHT+IGEXyT3j04bY/5ZNHe8pdFbFw8I9+JyrJY9uf1FZOjYzwUxuAtpHqu/TWcN6Zdk9Uk0syDHlmNub4OfHCJGYw==
X-Received: from pjtu8.prod.google.com ([2002:a17:90a:c888:b0:2f7:f660:cfe7])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5d0:b0:216:42fd:79d2 with SMTP id d9443c01a7336-21dd7de4684mr138116805ad.49.1738271746028;
 Thu, 30 Jan 2025 13:15:46 -0800 (PST)
Date: Thu, 30 Jan 2025 21:15:35 +0000
In-Reply-To: <20250130211539.428952-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130211539.428952-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130211539.428952-3-almasrymina@google.com>
Subject: [PATCH RFC net-next v2 2/6] selftests: ncdevmem: Implement devmem TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

Add support for devmem TX in ncdevmem.

This is a combination of the ncdevmem from the devmem TCP series RFCv1
which included the TX path, and work by Stan to include the netlink API
and refactored on top of his generic memory_provider support.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

---

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
 .../selftests/drivers/net/hw/ncdevmem.c       | 276 +++++++++++++++++-
 1 file changed, 272 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 19a6969643f4..8455f19ecd1a 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -40,15 +40,18 @@
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
@@ -80,6 +83,8 @@ static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
+static uint32_t tx_dmabuf_id;
+static int waittime_ms = 500;
 
 struct memory_buffer {
 	int fd;
@@ -93,6 +98,8 @@ struct memory_buffer {
 struct memory_provider {
 	struct memory_buffer *(*alloc)(size_t size);
 	void (*free)(struct memory_buffer *ctx);
+	void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
+				 void *src, int n);
 	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
 				   size_t off, int n);
 };
@@ -153,6 +160,20 @@ static void udmabuf_free(struct memory_buffer *ctx)
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
@@ -170,6 +191,7 @@ static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
 static struct memory_provider udmabuf_memory_provider = {
 	.alloc = udmabuf_alloc,
 	.free = udmabuf_free,
+	.memcpy_to_device = udmabuf_memcpy_to_device,
 	.memcpy_from_device = udmabuf_memcpy_from_device,
 };
 
@@ -188,7 +210,7 @@ void validate_buffer(void *line, size_t size)
 {
 	static unsigned char seed = 1;
 	unsigned char *ptr = line;
-	int errors = 0;
+	static int errors;
 	size_t i;
 
 	for (i = 0; i < size; i++) {
@@ -202,7 +224,7 @@ void validate_buffer(void *line, size_t size)
 		}
 		seed++;
 		if (seed == do_validation)
-			seed = 0;
+			seed = 1;
 	}
 
 	fprintf(stdout, "Validated buffer\n");
@@ -394,6 +416,49 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
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
@@ -432,7 +497,7 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
 	return 0;
 }
 
-int do_server(struct memory_buffer *mem)
+static int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
@@ -686,6 +751,207 @@ void run_devmem_tests(void)
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
+	int retries = 10;
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
+			error(1, ret, "recvmsg(MSG_ERRQUEUE)");
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
+	uint64_t off = 100;
+	char *line = NULL;
+	size_t len = 0;
+	int socket_fd;
+	int ret, mid;
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
+		error(1, ret, "bindtodevice");
+
+	if (bind_tx_queue(ifindex, mem->fd, &ys))
+		error(1, 0, "Failed to bind\n");
+
+	ret = parse_address(client_ip, atoi(port), &client_sin);
+	if (ret < 0)
+		error(1, 0, "parse client address");
+
+	ret = bind(socket_fd, &client_sin, sizeof(client_sin));
+	if (ret)
+		error(1, ret, "bind");
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+	if (ret)
+		error(1, ret, "set sock opt");
+
+	fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
+		ntohs(server_sin.sin6_port), ifname);
+
+	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
+	if (ret)
+		error(1, ret, "connect");
+
+	while (1) {
+		free(line);
+		line = NULL;
+		/* Subtract 1 from line_size to remove trailing newlines that
+		 * get_line are surely to parse...
+		 */
+		line_size = getline(&line, &len, stdin) - 1;
+
+		if (line_size < 0)
+			break;
+
+		mid = (line_size / 2) + 1;
+
+		iov[0].iov_base = (void *)100;
+		iov[0].iov_len = mid;
+		iov[1].iov_base = (void *)2000;
+		iov[1].iov_len = line_size - mid;
+
+		provider->memcpy_to_device(mem, (size_t)iov[0].iov_base, line,
+					   iov[0].iov_len);
+		provider->memcpy_to_device(mem, (size_t)iov[1].iov_base,
+					   line + iov[0].iov_len,
+					   iov[1].iov_len);
+
+		fprintf(stderr,
+			"read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
+			line_size, off, iov[0].iov_base, iov[0].iov_len,
+			iov[1].iov_base, iov[1].iov_len);
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
@@ -729,6 +995,8 @@ int main(int argc, char *argv[])
 
 	ifindex = if_nametoindex(ifname);
 
+	fprintf(stderr, "using ifindex=%u\n", ifindex);
+
 	if (!server_ip && !client_ip) {
 		if (start_queue < 0 && num_queues < 0) {
 			num_queues = rxq_num(ifindex);
@@ -779,7 +1047,7 @@ int main(int argc, char *argv[])
 		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
-	ret = is_server ? do_server(mem) : 1;
+	ret = is_server ? do_server(mem) : do_client(mem);
 	provider->free(mem);
 
 	return ret;
-- 
2.48.1.362.g079036d154-goog


