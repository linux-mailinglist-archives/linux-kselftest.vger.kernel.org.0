Return-Path: <linux-kselftest+bounces-23706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD29F9D7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 01:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2CD7A4008
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 00:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272EAAD51;
	Sat, 21 Dec 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZvVG6xt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936B25765
	for <linux-kselftest@vger.kernel.org>; Sat, 21 Dec 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734742300; cv=none; b=JaoNCTRwt+5n+rcFXImacR68qERtvdL2BiCcZMVtCUBt5ZNgUeG+EvmqYHG3Iy/Qwu5njNsfYlhyoZBv8OFGOGzrA5gSrtflLWkLvZkKBY2HQ1Sf2Vx5FNJC042lvWyVHsuB/aGOZYP/iyiZYW/5A/K9tzWHcdwBFPYu2UV+vHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734742300; c=relaxed/simple;
	bh=oM9VPB9o+HoOhFQ2jKZEYqU0zOMOqiBju5kW7kCY7hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TYdyu/8Dh+gGW+ap9vB0V10dAuIQ5Zsl6VsmT5dmL2rWLSiFNUgNGOCpbMNq314BCh7MSQdzDAuLo3XlUvaAENWilKXjHMy6yebBP7o1Aq6zazL4oXKlM6q+/kKucI/tBPaj89Wn3j9EJ05LobBSWD2dDMYb61Qb6yMiUwUWPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZvVG6xt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7e9fb5352dfso2291358a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 16:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734742297; x=1735347097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvRhxm0PfanRMhR9AWSahUuI027dbnG0NIDTqQqY9zM=;
        b=LZvVG6xt17QgIKJq9ytXGwuWgp0dYkwSuYljJriPi30A22etdSyik1HzkoV/S26EEC
         5FijQR0h1LG04lz7rSLrjPLDnh9eotBwb2vxEZNTX08GymJDa6iiFX1H7kx5tzORUQtQ
         tdyCNGPddSJw91kA0r1LjVPgIZkZO2B2rfdxeaYKBj8UL/OsLpQZrBxkeG/2/8SW+T6g
         mz3NQUBpIoR6RY4OXMHfKc2A2g56LSXpFb8mXhF/ue1fqkxLNJBJ4WUHW3kqfNwQRSqB
         HaSCszZJyW3KL5zqM80YDFgDtobgbRUlzyjo0ArTcwYL2VDZW3zlCaoTYHLNzfI5W3D6
         7rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734742297; x=1735347097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvRhxm0PfanRMhR9AWSahUuI027dbnG0NIDTqQqY9zM=;
        b=SGsO640g7nPKa29Bp1Z+9/TMSkXnqJiGleqSZaESpI1rVouIUQCHpeWu9g9bmIw4nj
         W3kQUdW2TgVZO2UFIiMitGzJ8BauRTOzB1HCxPm3Q7rovywzEFkBi5jbgNxeCVk8kPn0
         ahYLuxhfy5Oi9+kwh9jPulhPvyJ7VZ8UBMp5HCP2yZ3UO8Rna/wSlfKokUcxSuyyRji7
         b/VZSqDhPhPXv0mebKlBgonYWKkY3RKmGVOmZCpvuZiIPYsC1EJQuzswNH+tV67faxB8
         0D9y5wp1vFFb3nqgz3LkTkUXWhUHngATij3wHdoTC0e+ekTkV+t6c1W+YazmnaW5BecZ
         xHag==
X-Forwarded-Encrypted: i=1; AJvYcCX9UGjH5SOXJUfSatmsfxfHiEBGmWBeAQgB+P7ivZxAwMgfNGUegOCLB2lNpK9QFEjqqH1PXm7yj4gG33IsCzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEW1eeIPomvVbQ0HylpVGVNgay7kja0YPsTS5szuFRR83Bs9+A
	KfZ+12yDD2DtRMrb3hWJG3nAtwGPKK8IsUAmTfP7pmYNuMSHoQkbA7dJIF2/mT2UWbW32+s74W+
	NU4FBXIAwGR8arFz+6xYu+Q==
X-Google-Smtp-Source: AGHT+IE9+UzLSddcELfZ2mgl0mh/RGerBHIeMvNiWYQCp1XxXSrcI+ut917KM8tfbtPFabOJFM2yXHBxSI1aokLf1g==
X-Received: from pgwb8.prod.google.com ([2002:a65:6688:0:b0:801:e378:a64a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3115:b0:1e1:aef4:9cd0 with SMTP id adf61e73a8af0-1e5e044e423mr8605246637.3.1734742297348;
 Fri, 20 Dec 2024 16:51:37 -0800 (PST)
Date: Sat, 21 Dec 2024 00:42:33 +0000
In-Reply-To: <20241221004236.2629280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241221004236.2629280-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221004236.2629280-3-almasrymina@google.com>
Subject: [PATCH RFC net-next v1 2/5] selftests: ncdevmem: Implement devmem TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"

Add support for devmem TX in ncdevmem.

This is a combination of the ncdevmem from the devmem TCP series RFCv1
which included the TX path, and work by Stan to include the netlink API
and refactored on top of his generic memory_provider support.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 261 +++++++++++++++++-
 1 file changed, 259 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 19a6969643f4..c1cbe2e11230 100644
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
@@ -686,6 +751,198 @@ void run_devmem_tests(void)
 	provider->free(mem);
 }
 
+static unsigned long gettimeofday_ms(void)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
+}
+
+static int do_poll(int fd)
+{
+	struct pollfd pfd;
+	int ret;
+
+	pfd.events = POLLERR;
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
+	uint64_t off = 100;
+	char *line = NULL;
+	struct iovec iov;
+	size_t len = 0;
+	int socket_fd;
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
+		line_size = getline(&line, &len, stdin);
+
+		if (line_size < 0)
+			break;
+
+		provider->memcpy_to_device(mem, off, line, line_size);
+
+		while (line_size) {
+			fprintf(stderr, "read line_size=%ld off=%d\n",
+				line_size, off);
+
+			iov.iov_base = NULL;
+			iov.iov_len = line_size;
+
+			msg.msg_iov = &iov;
+			msg.msg_iovlen = 1;
+
+			msg.msg_control = ctrl_data;
+			msg.msg_controllen = sizeof(ctrl_data);
+
+			cmsg = CMSG_FIRSTHDR(&msg);
+			cmsg->cmsg_level = SOL_SOCKET;
+			cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
+			cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
+
+			ddmabuf.dmabuf_id = tx_dmabuf_id;
+			ddmabuf.dmabuf_offset = off;
+
+			*((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;
+
+			ret = sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
+			if (ret < 0)
+				error(1, errno, "Failed sendmsg");
+
+			fprintf(stderr, "sendmsg_ret=%d\n", ret);
+
+			off += ret;
+			line_size -= ret;
+
+			wait_compl(socket_fd);
+		}
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
@@ -779,7 +1036,7 @@ int main(int argc, char *argv[])
 		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
-	ret = is_server ? do_server(mem) : 1;
+	ret = is_server ? do_server(mem) : do_client(mem);
 	provider->free(mem);
 
 	return ret;
-- 
2.47.1.613.gc27f4b7a9f-goog


