Return-Path: <linux-kselftest+bounces-21110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260C79B65C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26AA2825EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338B1F4FB7;
	Wed, 30 Oct 2024 14:27:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954E1F4284;
	Wed, 30 Oct 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298450; cv=none; b=iwEBnWnM9d6Z0OdLZaLDLVy0SZkuKCq8yM8xtVFhb2rEmu97LouCAlndKM5fta8R/ZaNOXP5pWoXQc3R5lFUZRYK6PppaoCdpIKzKijFbCfOCuYdXjW+B0gJOSL3Bn50VFpddwdljejlF07BAzTNng4JjhQ3y3tinH1LgTkhCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298450; c=relaxed/simple;
	bh=uDxOm844VsAsi9UnMdkeV0AtSZv36ezRQCbCtTNGPfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvoopnw3n7GdKXF8vkelrNUHGKQ4U7suu55igGPPpEWOKsQKCcWetSFelmWU3HbHRuA2D5341ffybtsRnPBYo6x13aAjGVfdKQfyg60Lyk9FA1JtLeg2OwQ8JTE4uLl6wiUCmfR3Ebj0oXa3aE0JLTeCNEvV4d0+TJKbYbhvssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c9978a221so72946555ad.1;
        Wed, 30 Oct 2024 07:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298447; x=1730903247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJEggviDo9R4Ek8kHMFcfr5AkXM+HxfAn8Vpwc2O0pc=;
        b=rwe5a9GiyNJwkxtBHFJbPBBU4q6iMiPSSkZewE5aGWta88m5O4P2fCHDd3e8Js/F6N
         7a6jZ6j++R8LWJ9RtjXugO56PYyYd63WU0o5e0MElpJCN0Y45OIk8BZV/aJjFg4pRL2C
         Jy0fvTohS9YDGqZcvrnPP9dIUQWfGycJvUmLt11UPGNfx0EHMjViZ9/i0HbYnrKtYPeO
         UA23yQfE2/oE4boI5kCnRedhizvPNInvrjgptoIdN7hb5mIw40Y+mzHeIXQCofrlUXYW
         JzVRMVooQRvcigIk+iWjIXeyoH4w8KxbloudEGakiv8Zkd9vM710e4tJGgppk/KNw2mj
         c9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+KJ873H3xSykFwFIM5CL1GvW4dIvZiEuVOhk8luuBNTGEDx1Ie+LUlZtxBYszJ5t0GTe/uU7hsl0OBA1WZkV1@vger.kernel.org, AJvYcCX4Er3qQ+cExisULsaBWHTHmAzrzpNXK7VqHcSvhCW+7YmEr3RFsu+qvWX9UoeU9eFuoWxbhDbPEsQTfEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhehUiyVbvQieIpPwA6s0boV0aFYS13SgHz0UyClrvDtKTf2Xh
	Zr73PlJOVAk2tkuJT47OaLBy4BTwlRq3CUJeu3TQZl5GLr+uwKrrLBzZxAc=
X-Google-Smtp-Source: AGHT+IH+aBTpxou2cWtxON0T1GS9tyqrhYHHsSwrYDeYk2RB3Pt6s6NRmwCpoWrtj8BzIS1XG44lWw==
X-Received: by 2002:a17:902:e890:b0:20c:8abc:733a with SMTP id d9443c01a7336-210c6ca8b77mr203336935ad.53.1730298446612;
        Wed, 30 Oct 2024 07:27:26 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc01791bsm81834775ad.145.2024.10.30.07.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:26 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 02/12] selftests: ncdevmem: Separate out dmabuf provider
Date: Wed, 30 Oct 2024 07:27:12 -0700
Message-ID: <20241030142722.2901744-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So we can plug the other ones in the future if needed.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 198 +++++++++++++++----------
 1 file changed, 117 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 9245d3f158dd..9b3ca6398a9d 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -71,17 +71,101 @@ static char *ifname = "eth1";
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 
-void print_bytes(void *ptr, size_t size)
+struct memory_buffer {
+	int fd;
+	size_t size;
+
+	int devfd;
+	int memfd;
+	char *buf_mem;
+};
+
+struct memory_provider {
+	struct memory_buffer *(*alloc)(size_t size);
+	void (*free)(struct memory_buffer *ctx);
+	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
+				   size_t off, int n);
+};
+
+static struct memory_buffer *udmabuf_alloc(size_t size)
 {
-	unsigned char *p = ptr;
-	int i;
+	struct udmabuf_create create;
+	struct memory_buffer *ctx;
+	int ret;
 
-	for (i = 0; i < size; i++)
-		printf("%02hhX ", p[i]);
-	printf("\n");
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx)
+		error(1, ENOMEM, "malloc failed");
+
+	ctx->size = size;
+
+	ctx->devfd = open("/dev/udmabuf", O_RDWR);
+	if (ctx->devfd < 0)
+		error(1, errno,
+		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+		      TEST_PREFIX);
+
+	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	if (ctx->memfd < 0)
+		error(1, errno, "%s: [skip,no-memfd]\n", TEST_PREFIX);
+
+	ret = fcntl(ctx->memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0)
+		error(1, errno, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+
+	ret = ftruncate(ctx->memfd, size);
+	if (ret == -1)
+		error(1, errno, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+
+	memset(&create, 0, sizeof(create));
+
+	create.memfd = ctx->memfd;
+	create.offset = 0;
+	create.size = size;
+	ctx->fd = ioctl(ctx->devfd, UDMABUF_CREATE, &create);
+	if (ctx->fd < 0)
+		error(1, errno, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
+
+	ctx->buf_mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			    ctx->fd, 0);
+	if (ctx->buf_mem == MAP_FAILED)
+		error(1, errno, "%s: [FAIL, map udmabuf]\n", TEST_PREFIX);
+
+	return ctx;
+}
+
+static void udmabuf_free(struct memory_buffer *ctx)
+{
+	munmap(ctx->buf_mem, ctx->size);
+	close(ctx->fd);
+	close(ctx->memfd);
+	close(ctx->devfd);
+	free(ctx);
 }
 
-void print_nonzero_bytes(void *ptr, size_t size)
+static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
+				       size_t off, int n)
+{
+	struct dma_buf_sync sync = {};
+
+	sync.flags = DMA_BUF_SYNC_START;
+	ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
+
+	memcpy(dst, src->buf_mem + off, n);
+
+	sync.flags = DMA_BUF_SYNC_END;
+	ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
+}
+
+static struct memory_provider udmabuf_memory_provider = {
+	.alloc = udmabuf_alloc,
+	.free = udmabuf_free,
+	.memcpy_from_device = udmabuf_memcpy_from_device,
+};
+
+static struct memory_provider *provider = &udmabuf_memory_provider;
+
+static void print_nonzero_bytes(void *ptr, size_t size)
 {
 	unsigned char *p = ptr;
 	unsigned int i;
@@ -201,42 +285,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
-static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmabuf_size)
-{
-	struct udmabuf_create create;
-	int ret;
-
-	*devfd = open("/dev/udmabuf", O_RDWR);
-	if (*devfd < 0) {
-		error(70, 0,
-		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
-		      TEST_PREFIX);
-	}
-
-	*memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
-	if (*memfd < 0)
-		error(70, 0, "%s: [skip,no-memfd]\n", TEST_PREFIX);
-
-	/* Required for udmabuf */
-	ret = fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
-	if (ret < 0)
-		error(73, 0, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
-
-	ret = ftruncate(*memfd, dmabuf_size);
-	if (ret == -1)
-		error(74, 0, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
-
-	memset(&create, 0, sizeof(create));
-
-	create.memfd = *memfd;
-	create.offset = 0;
-	create.size = dmabuf_size;
-	*buf = ioctl(*devfd, UDMABUF_CREATE, &create);
-	if (*buf < 0)
-		error(75, 0, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
-}
-
-int do_server(void)
+int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
@@ -244,23 +293,18 @@ int do_server(void)
 	struct sockaddr_in client_addr;
 	struct sockaddr_in server_sin;
 	size_t page_aligned_frags = 0;
-	int devfd, memfd, buf, ret;
 	size_t total_received = 0;
 	socklen_t client_addr_len;
 	bool is_devmem = false;
-	char *buf_mem = NULL;
+	char *tmp_mem = NULL;
 	struct ynl_sock *ys;
-	size_t dmabuf_size;
 	char iobuf[819200];
 	char buffer[256];
 	int socket_fd;
 	int client_fd;
 	size_t i = 0;
 	int opt = 1;
-
-	dmabuf_size = getpagesize() * NUM_PAGES;
-
-	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+	int ret;
 
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
@@ -284,13 +328,12 @@ int do_server(void)
 		queues[i].id = start_queue + i;
 	}
 
-	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
-	buf_mem = mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
-		       buf, 0);
-	if (buf_mem == MAP_FAILED)
-		error(1, 0, "mmap()");
+	tmp_mem = malloc(mem->size);
+	if (!tmp_mem)
+		error(1, ENOMEM, "malloc failed");
 
 	server_sin.sin_family = AF_INET;
 	server_sin.sin_port = htons(atoi(port));
@@ -341,7 +384,6 @@ int do_server(void)
 		struct iovec iov = { .iov_base = iobuf,
 				     .iov_len = sizeof(iobuf) };
 		struct dmabuf_cmsg *dmabuf_cmsg = NULL;
-		struct dma_buf_sync sync = { 0 };
 		struct cmsghdr *cm = NULL;
 		struct msghdr msg = { 0 };
 		struct dmabuf_token token;
@@ -410,22 +452,17 @@ int do_server(void)
 			else
 				page_aligned_frags++;
 
-			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
-			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+			provider->memcpy_from_device(tmp_mem, mem,
+						     dmabuf_cmsg->frag_offset,
+						     dmabuf_cmsg->frag_size);
 
 			if (do_validation)
 				validate_buffer(
-					((unsigned char *)buf_mem) +
+					((unsigned char *)tmp_mem) +
 						dmabuf_cmsg->frag_offset,
 					dmabuf_cmsg->frag_size);
 			else
-				print_nonzero_bytes(
-					((unsigned char *)buf_mem) +
-						dmabuf_cmsg->frag_offset,
-					dmabuf_cmsg->frag_size);
-
-			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
-			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+				print_nonzero_bytes(tmp_mem, dmabuf_cmsg->frag_size);
 
 			ret = setsockopt(client_fd, SOL_SOCKET,
 					 SO_DEVMEM_DONTNEED, &token,
@@ -450,12 +487,9 @@ int do_server(void)
 
 cleanup:
 
-	munmap(buf_mem, dmabuf_size);
+	free(tmp_mem);
 	close(client_fd);
 	close(socket_fd);
-	close(buf);
-	close(memfd);
-	close(devfd);
 	ynl_sock_destroy(ys);
 
 	return 0;
@@ -464,14 +498,11 @@ int do_server(void)
 void run_devmem_tests(void)
 {
 	struct netdev_queue_id *queues;
-	int devfd, memfd, buf;
+	struct memory_buffer *mem;
 	struct ynl_sock *ys;
-	size_t dmabuf_size;
 	size_t i = 0;
 
-	dmabuf_size = getpagesize() * NUM_PAGES;
-
-	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+	mem = provider->alloc(getpagesize() * NUM_PAGES);
 
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
@@ -482,7 +513,7 @@ void run_devmem_tests(void)
 	if (configure_headersplit(1))
 		error(1, 0, "Failed to configure header split\n");
 
-	if (!bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
 		error(1, 0, "Binding empty queues array should have failed\n");
 
 	for (i = 0; i < num_queues; i++) {
@@ -495,7 +526,7 @@ void run_devmem_tests(void)
 	if (configure_headersplit(0))
 		error(1, 0, "Failed to configure header split\n");
 
-	if (!bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
 		error(1, 0, "Configure dmabuf with header split off should have failed\n");
 
 	if (configure_headersplit(1))
@@ -508,7 +539,7 @@ void run_devmem_tests(void)
 		queues[i].id = start_queue + i;
 	}
 
-	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
 	/* Deactivating a bound queue should not be legal */
@@ -517,11 +548,15 @@ void run_devmem_tests(void)
 
 	/* Closing the netlink socket does an implicit unbind */
 	ynl_sock_destroy(ys);
+
+	provider->free(mem);
 }
 
 int main(int argc, char *argv[])
 {
+	struct memory_buffer *mem;
 	int is_server = 0, opt;
+	int ret;
 
 	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:")) != -1) {
 		switch (opt) {
@@ -562,8 +597,9 @@ int main(int argc, char *argv[])
 
 	run_devmem_tests();
 
-	if (is_server)
-		return do_server();
+	mem = provider->alloc(getpagesize() * NUM_PAGES);
+	ret = is_server ? do_server(mem) : 1;
+	provider->free(mem);
 
-	return 0;
+	return ret;
 }
-- 
2.47.0


