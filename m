Return-Path: <linux-kselftest+bounces-39869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B7B349B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5159C1B23F61
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853B3093DB;
	Mon, 25 Aug 2025 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIIhiHMh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC33093BD;
	Mon, 25 Aug 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145097; cv=none; b=QP7eQPyTfIJNs0FUTP5m7Doy3NVoC8tclTqgNe+/LkBPgNz9cqE+bvR2CrpdBFDL/qK2+VOH2Ri/qIud2wnYGw3K7uT+DCHSTMAQKn54QWwGdCzadSAgX+QKhyXh4jko2xXvRiW2rraLSf6i60xzs+9IyWZLX2RS5qnW9pCzYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145097; c=relaxed/simple;
	bh=0f8UPWyLiw1lj2Cool1kdXCiCfhBfVs/sCttOas0FcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/g5/OuRbjj7/nxaaoFXQ73J+GQwugWCQVvzF71X0ylq9mVjjQaECawTZTOSWijIdhaHhI2v/r21ArHWtcRzH6p0S7bVf1oQpg8B1vai94amGWkxUQ/s0zsGIDNS5l7VChOe3oj7elDW29dUqcJNsvLeZdfp6PfflShvec49SdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIIhiHMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACFEC116D0;
	Mon, 25 Aug 2025 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145096;
	bh=0f8UPWyLiw1lj2Cool1kdXCiCfhBfVs/sCttOas0FcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIIhiHMhpB59/hhk50IhkZEnNBKIbpiIGCZnyy1F6W0jGtThQeWh1JYKA/a9NMpuy
	 BaHKiseoOqTdkZGJnJkdMnO1fkmcYD9X86DHGuAXF505CfQSXEqt4WrRESF6e7s5L/
	 ohmrunc2wm+3VKtgIYf60fSRLb9N4RjDDyFM7y/5cr6sFcWMb7QEHcjS/m+UC3zoJX
	 ZggOgIrTKYDSEKy48ES+fY0ByEQ1kO1wEX8kO4r7zkuci2mXdNQgW5PfRYz/uQvuY4
	 VfjmihsnBf/ramvW/NgxFzQMwjNvGA8BjMkAPbhdPvRNykF+VnkrrfFeWU0ACZ0b3u
	 efOsPHVw6xh0Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/5] selftests: drv-net: ncdevmem: remove use of error()
Date: Mon, 25 Aug 2025 11:04:43 -0700
Message-ID: <20250825180447.2252977-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825180447.2252977-1-kuba@kernel.org>
References: <20250825180447.2252977-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using error() makes it impossible for callers to unwind their
changes. Replace error() calls with proper error handling.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 528 ++++++++++++------
 1 file changed, 364 insertions(+), 164 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 71961a7688e6..e75adfed33ac 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -115,6 +115,21 @@ struct memory_provider {
 				   size_t off, int n);
 };
 
+static void pr_err(const char *fmt, ...)
+{
+	va_list args;
+
+	fprintf(stderr, "%s: ", TEST_PREFIX);
+
+	va_start(args, fmt);
+	vfprintf(stderr, fmt, args);
+	va_end(args);
+
+	if (errno != 0)
+		fprintf(stderr, ": %s", strerror(errno));
+	fprintf(stderr, "\n");
+}
+
 static struct memory_buffer *udmabuf_alloc(size_t size)
 {
 	struct udmabuf_create create;
@@ -123,27 +138,33 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 
 	ctx = malloc(sizeof(*ctx));
 	if (!ctx)
-		error(1, ENOMEM, "malloc failed");
+		return NULL;
 
 	ctx->size = size;
 
 	ctx->devfd = open("/dev/udmabuf", O_RDWR);
-	if (ctx->devfd < 0)
-		error(1, errno,
-		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
-		      TEST_PREFIX);
+	if (ctx->devfd < 0) {
+		pr_err("[skip,no-udmabuf: Unable to access DMA buffer device file]");
+		goto err_free_ctx;
+	}
 
 	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
-	if (ctx->memfd < 0)
-		error(1, errno, "%s: [skip,no-memfd]\n", TEST_PREFIX);
+	if (ctx->memfd < 0) {
+		pr_err("[skip,no-memfd]");
+		goto err_close_dev;
+	}
 
 	ret = fcntl(ctx->memfd, F_ADD_SEALS, F_SEAL_SHRINK);
-	if (ret < 0)
-		error(1, errno, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+	if (ret < 0) {
+		pr_err("[skip,fcntl-add-seals]");
+		goto err_close_memfd;
+	}
 
 	ret = ftruncate(ctx->memfd, size);
-	if (ret == -1)
-		error(1, errno, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+	if (ret == -1) {
+		pr_err("[FAIL,memfd-truncate]");
+		goto err_close_memfd;
+	}
 
 	memset(&create, 0, sizeof(create));
 
@@ -151,15 +172,29 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 	create.offset = 0;
 	create.size = size;
 	ctx->fd = ioctl(ctx->devfd, UDMABUF_CREATE, &create);
-	if (ctx->fd < 0)
-		error(1, errno, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
+	if (ctx->fd < 0) {
+		pr_err("[FAIL, create udmabuf]");
+		goto err_close_fd;
+	}
 
 	ctx->buf_mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
 			    ctx->fd, 0);
-	if (ctx->buf_mem == MAP_FAILED)
-		error(1, errno, "%s: [FAIL, map udmabuf]\n", TEST_PREFIX);
+	if (ctx->buf_mem == MAP_FAILED) {
+		pr_err("[FAIL, map udmabuf]");
+		goto err_close_fd;
+	}
 
 	return ctx;
+
+err_close_fd:
+	close(ctx->fd);
+err_close_memfd:
+	close(ctx->memfd);
+err_close_dev:
+	close(ctx->devfd);
+err_free_ctx:
+	free(ctx);
+	return NULL;
 }
 
 static void udmabuf_free(struct memory_buffer *ctx)
@@ -217,7 +252,7 @@ static void print_nonzero_bytes(void *ptr, size_t size)
 		putchar(p[i]);
 }
 
-void validate_buffer(void *line, size_t size)
+int validate_buffer(void *line, size_t size)
 {
 	static unsigned char seed = 1;
 	unsigned char *ptr = line;
@@ -232,8 +267,10 @@ void validate_buffer(void *line, size_t size)
 				"Failed validation: expected=%u, actual=%u, index=%lu\n",
 				expected, ptr[i], i);
 			errors++;
-			if (errors > 20)
-				error(1, 0, "validation failed.");
+			if (errors > 20) {
+				pr_err("validation failed");
+				return -1;
+			}
 		}
 		seed++;
 		if (seed == do_validation)
@@ -241,6 +278,7 @@ void validate_buffer(void *line, size_t size)
 	}
 
 	fprintf(stdout, "Validated buffer\n");
+	return 0;
 }
 
 static int rxq_num(int ifindex)
@@ -279,7 +317,7 @@ static int rxq_num(int ifindex)
 		system(command);                                        \
 	})
 
-static int reset_flow_steering(void)
+static void reset_flow_steering(void)
 {
 	/* Depending on the NIC, toggling ntuple off and on might not
 	 * be allowed. Additionally, attempting to delete existing filters
@@ -292,7 +330,6 @@ static int reset_flow_steering(void)
 	run_command(
 		"ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
 		ifname, ifname);
-	return 0;
 }
 
 static const char *tcp_data_split_str(int val)
@@ -354,6 +391,11 @@ static int configure_rss(void)
 	return run_command("ethtool -X %s equal %d >&2", ifname, start_queue);
 }
 
+static void reset_rss(void)
+{
+	run_command("ethtool -X %s default >&2", ifname, start_queue);
+}
+
 static int configure_channels(unsigned int rx, unsigned int tx)
 {
 	struct ethtool_channels_get_req *gchan;
@@ -479,6 +521,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 
 	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
 	if (!*ys) {
+		netdev_queue_id_free(queues);
 		fprintf(stderr, "YNL: %s\n", yerr.msg);
 		return -1;
 	}
@@ -557,18 +600,24 @@ static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
-static void enable_reuseaddr(int fd)
+static int enable_reuseaddr(int fd)
 {
 	int opt = 1;
 	int ret;
 
 	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
-	if (ret)
-		error(1, errno, "%s: [FAIL, SO_REUSEPORT]\n", TEST_PREFIX);
+	if (ret) {
+		pr_err("SO_REUSEPORT failed");
+		return -1;
+	}
 
 	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
-	if (ret)
-		error(1, errno, "%s: [FAIL, SO_REUSEADDR]\n", TEST_PREFIX);
+	if (ret) {
+		pr_err("SO_REUSEADDR failed");
+		return -1;
+	}
+
+	return 0;
 }
 
 static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
@@ -622,54 +671,70 @@ static int do_server(struct memory_buffer *mem)
 	char *tmp_mem = NULL;
 	struct ynl_sock *ys;
 	char iobuf[819200];
+	int ret, err = -1;
 	char buffer[256];
 	int socket_fd;
 	int client_fd;
-	int ret;
 
 	ret = parse_address(server_ip, atoi(port), &server_sin);
-	if (ret < 0)
-		error(1, 0, "parse server address");
+	if (ret < 0) {
+		pr_err("parse server address");
+		return -1;
+	}
 
-	if (reset_flow_steering())
-		error(1, 0, "Failed to reset flow steering\n");
+	reset_flow_steering();
 
-	if (configure_headersplit(1))
-		error(1, 0, "Failed to enable TCP header split\n");
+	if (configure_headersplit(1)) {
+		pr_err("Failed to enable TCP header split");
+		return -1;
+	}
 
 	/* Configure RSS to divert all traffic from our devmem queues */
-	if (configure_rss())
-		error(1, 0, "Failed to configure rss\n");
+	if (configure_rss()) {
+		pr_err("Failed to configure rss");
+		goto err_reset_headersplit;
+	}
 
 	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering(&server_sin))
-		error(1, 0, "Failed to configure flow steering\n");
+	if (configure_flow_steering(&server_sin)) {
+		pr_err("Failed to configure flow steering");
+		goto err_reset_rss;
+	}
 
 	sleep(1);
 
-	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
-		error(1, 0, "Failed to bind\n");
+	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
+		pr_err("Failed to bind");
+		goto err_reset_flow_steering;
+	}
 
 	tmp_mem = malloc(mem->size);
 	if (!tmp_mem)
-		error(1, ENOMEM, "malloc failed");
+		goto err_unbind;
 
 	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (socket_fd < 0)
-		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+	if (socket_fd < 0) {
+		pr_err("Failed to create socket");
+		goto err_free_tmp;
+	}
 
-	enable_reuseaddr(socket_fd);
+	if (enable_reuseaddr(socket_fd))
+		goto err_close_socket;
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
 		ntohs(server_sin.sin6_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
-	if (ret)
-		error(1, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
+	if (ret) {
+		pr_err("Failed to bind");
+		goto err_close_socket;
+	}
 
 	ret = listen(socket_fd, 1);
-	if (ret)
-		error(1, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
+	if (ret) {
+		pr_err("Failed to listen");
+		goto err_close_socket;
+	}
 
 	client_addr_len = sizeof(client_addr);
 
@@ -678,6 +743,10 @@ static int do_server(struct memory_buffer *mem)
 	fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
 		ntohs(server_sin.sin6_port));
 	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
+	if (client_fd < 0) {
+		pr_err("Failed to accept");
+		goto err_close_socket;
+	}
 
 	inet_ntop(AF_INET6, &client_addr.sin6_addr, buffer,
 		  sizeof(buffer));
@@ -708,7 +777,8 @@ static int do_server(struct memory_buffer *mem)
 			continue;
 		}
 		if (ret == 0) {
-			fprintf(stderr, "client exited\n");
+			errno = 0;
+			pr_err("client exited");
 			goto cleanup;
 		}
 
@@ -746,9 +816,10 @@ static int do_server(struct memory_buffer *mem)
 				dmabuf_cmsg->frag_size, dmabuf_cmsg->frag_token,
 				total_received, dmabuf_cmsg->dmabuf_id);
 
-			if (dmabuf_cmsg->dmabuf_id != dmabuf_id)
-				error(1, 0,
-				      "received on wrong dmabuf_id: flow steering error\n");
+			if (dmabuf_cmsg->dmabuf_id != dmabuf_id) {
+				pr_err("received on wrong dmabuf_id: flow steering error");
+				goto err_close_client;
+			}
 
 			if (dmabuf_cmsg->frag_size % getpagesize())
 				non_page_aligned_frags++;
@@ -759,22 +830,27 @@ static int do_server(struct memory_buffer *mem)
 						     dmabuf_cmsg->frag_offset,
 						     dmabuf_cmsg->frag_size);
 
-			if (do_validation)
-				validate_buffer(tmp_mem,
-						dmabuf_cmsg->frag_size);
-			else
+			if (do_validation) {
+				if (validate_buffer(tmp_mem,
+						    dmabuf_cmsg->frag_size))
+					goto err_close_client;
+			} else {
 				print_nonzero_bytes(tmp_mem,
 						    dmabuf_cmsg->frag_size);
+			}
 
 			ret = setsockopt(client_fd, SOL_SOCKET,
 					 SO_DEVMEM_DONTNEED, &token,
 					 sizeof(token));
-			if (ret != 1)
-				error(1, 0,
-				      "SO_DEVMEM_DONTNEED not enough tokens");
+			if (ret != 1) {
+				pr_err("SO_DEVMEM_DONTNEED not enough tokens");
+				goto err_close_client;
+			}
+		}
+		if (!is_devmem) {
+			pr_err("flow steering error");
+			goto err_close_client;
 		}
-		if (!is_devmem)
-			error(1, 0, "flow steering error\n");
 
 		fprintf(stderr, "total_received=%lu\n", total_received);
 	}
@@ -785,54 +861,112 @@ static int do_server(struct memory_buffer *mem)
 		page_aligned_frags, non_page_aligned_frags);
 
 cleanup:
+	err = 0;
 
-	free(tmp_mem);
+err_close_client:
 	close(client_fd);
+err_close_socket:
 	close(socket_fd);
+err_free_tmp:
+	free(tmp_mem);
+err_unbind:
 	ynl_sock_destroy(ys);
-
-	return 0;
+err_reset_flow_steering:
+	reset_flow_steering();
+err_reset_rss:
+	reset_rss();
+err_reset_headersplit:
+	configure_headersplit(0);
+	return err;
 }
 
-void run_devmem_tests(void)
+int run_devmem_tests(void)
 {
+	struct netdev_queue_id *queues;
 	struct memory_buffer *mem;
 	struct ynl_sock *ys;
+	int err = -1;
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
+	if (!mem) {
+		pr_err("Failed to allocate memory buffer");
+		return -1;
+	}
 
 	/* Configure RSS to divert all traffic from our devmem queues */
-	if (configure_rss())
-		error(1, 0, "rss error\n");
+	if (configure_rss()) {
+		pr_err("rss error");
+		goto err_free_mem;
+	}
 
-	if (configure_headersplit(1))
-		error(1, 0, "Failed to configure header split\n");
+	if (configure_headersplit(1)) {
+		pr_err("Failed to configure header split");
+		goto err_reset_rss;
+	}
 
-	if (!bind_rx_queue(ifindex, mem->fd,
-			   calloc(num_queues, sizeof(struct netdev_queue_id)),
-			   num_queues, &ys))
-		error(1, 0, "Binding empty queues array should have failed\n");
+	queues = netdev_queue_id_alloc(num_queues);
+	if (!queues) {
+		pr_err("Failed to allocate empty queues array");
+		goto err_reset_headersplit;
+	}
 
-	if (configure_headersplit(0))
-		error(1, 0, "Failed to configure header split\n");
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+		pr_err("Binding empty queues array should have failed");
+		goto err_unbind;
+	}
 
-	if (!bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
-		error(1, 0, "Configure dmabuf with header split off should have failed\n");
+	if (configure_headersplit(0)) {
+		pr_err("Failed to configure header split");
+		goto err_reset_rss;
+	}
 
-	if (configure_headersplit(1))
-		error(1, 0, "Failed to configure header split\n");
+	queues = create_queues();
+	if (!queues) {
+		pr_err("Failed to create queues");
+		goto err_reset_rss;
+	}
 
-	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
-		error(1, 0, "Failed to bind\n");
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+		pr_err("Configure dmabuf with header split off should have failed");
+		goto err_unbind;
+	}
+
+	if (configure_headersplit(1)) {
+		pr_err("Failed to configure header split");
+		goto err_reset_rss;
+	}
+
+	queues = create_queues();
+	if (!queues) {
+		pr_err("Failed to create queues");
+		goto err_reset_headersplit;
+	}
+
+	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+		pr_err("Failed to bind");
+		goto err_reset_headersplit;
+	}
 
 	/* Deactivating a bound queue should not be legal */
-	if (!configure_channels(num_queues, num_queues))
-		error(1, 0, "Deactivating a bound queue should be illegal.\n");
+	if (!configure_channels(num_queues, num_queues)) {
+		pr_err("Deactivating a bound queue should be illegal");
+		goto err_reset_channels;
+	}
 
-	/* Closing the netlink socket does an implicit unbind */
+	err = 0;
+	goto err_unbind;
+
+err_reset_channels:
+	/* TODO */
+err_unbind:
 	ynl_sock_destroy(ys);
-
+err_reset_headersplit:
+	configure_headersplit(0);
+err_reset_rss:
+	reset_rss();
+err_free_mem:
 	provider->free(mem);
+	return err;
 }
 
 static uint64_t gettimeofday_ms(void)
@@ -852,13 +986,15 @@ static int do_poll(int fd)
 	pfd.fd = fd;
 
 	ret = poll(&pfd, 1, waittime_ms);
-	if (ret == -1)
-		error(1, errno, "poll");
+	if (ret == -1) {
+		pr_err("poll");
+		return -1;
+	}
 
 	return ret && (pfd.revents & POLLERR);
 }
 
-static void wait_compl(int fd)
+static int wait_compl(int fd)
 {
 	int64_t tstop = gettimeofday_ms() + waittime_ms;
 	char control[CMSG_SPACE(100)] = {};
@@ -872,18 +1008,23 @@ static void wait_compl(int fd)
 	msg.msg_controllen = sizeof(control);
 
 	while (gettimeofday_ms() < tstop) {
-		if (!do_poll(fd))
+		ret = do_poll(fd);
+		if (ret < 0)
+			return ret;
+		if (!ret)
 			continue;
 
 		ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
 		if (ret < 0) {
 			if (errno == EAGAIN)
 				continue;
-			error(1, errno, "recvmsg(MSG_ERRQUEUE)");
-			return;
+			pr_err("recvmsg(MSG_ERRQUEUE)");
+			return -1;
+		}
+		if (msg.msg_flags & MSG_CTRUNC) {
+			pr_err("MSG_CTRUNC");
+			return -1;
 		}
-		if (msg.msg_flags & MSG_CTRUNC)
-			error(1, 0, "MSG_CTRUNC\n");
 
 		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
 			if (cm->cmsg_level != SOL_IP &&
@@ -897,20 +1038,25 @@ static void wait_compl(int fd)
 				continue;
 
 			serr = (void *)CMSG_DATA(cm);
-			if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY)
-				error(1, 0, "wrong origin %u", serr->ee_origin);
-			if (serr->ee_errno != 0)
-				error(1, 0, "wrong errno %d", serr->ee_errno);
+			if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY) {
+				pr_err("wrong origin %u", serr->ee_origin);
+				return -1;
+			}
+			if (serr->ee_errno != 0) {
+				pr_err("wrong errno %d", serr->ee_errno);
+				return -1;
+			}
 
 			hi = serr->ee_data;
 			lo = serr->ee_info;
 
 			fprintf(stderr, "tx complete [%d,%d]\n", lo, hi);
-			return;
+			return 0;
 		}
 	}
 
-	error(1, 0, "did not receive tx completion");
+	pr_err("did not receive tx completion");
+	return -1;
 }
 
 static int do_client(struct memory_buffer *mem)
@@ -924,50 +1070,69 @@ static int do_client(struct memory_buffer *mem)
 	ssize_t line_size = 0;
 	struct cmsghdr *cmsg;
 	char *line = NULL;
+	int ret, err = -1;
 	size_t len = 0;
 	int socket_fd;
 	__u32 ddmabuf;
 	int opt = 1;
-	int ret;
 
 	ret = parse_address(server_ip, atoi(port), &server_sin);
-	if (ret < 0)
-		error(1, 0, "parse server address");
-
-	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (socket_fd < 0)
-		error(1, socket_fd, "create socket");
-
-	enable_reuseaddr(socket_fd);
-
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
-			 strlen(ifname) + 1);
-	if (ret)
-		error(1, errno, "bindtodevice");
-
-	if (bind_tx_queue(ifindex, mem->fd, &ys))
-		error(1, 0, "Failed to bind\n");
+	if (ret < 0) {
+		pr_err("parse server address");
+		return -1;
+	}
 
 	if (client_ip) {
 		ret = parse_address(client_ip, atoi(port), &client_sin);
-		if (ret < 0)
-			error(1, 0, "parse client address");
+		if (ret < 0) {
+			pr_err("parse client address");
+			return ret;
+		}
+	}
 
+	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (socket_fd < 0) {
+		pr_err("create socket");
+		return -1;
+	}
+
+	if (enable_reuseaddr(socket_fd))
+		goto err_close_socket;
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
+			 strlen(ifname) + 1);
+	if (ret) {
+		pr_err("bindtodevice");
+		goto err_close_socket;
+	}
+
+	if (bind_tx_queue(ifindex, mem->fd, &ys)) {
+		pr_err("Failed to bind");
+		goto err_close_socket;
+	}
+
+	if (client_ip) {
 		ret = bind(socket_fd, &client_sin, sizeof(client_sin));
-		if (ret)
-			error(1, errno, "bind");
+		if (ret) {
+			pr_err("bind");
+			goto err_unbind;
+		}
 	}
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
-	if (ret)
-		error(1, errno, "set sock opt");
+	if (ret) {
+		pr_err("set sock opt");
+		goto err_unbind;
+	}
 
 	fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
 		ntohs(server_sin.sin6_port), ifname);
 
 	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
-	if (ret)
-		error(1, errno, "connect");
+	if (ret) {
+		pr_err("connect");
+		goto err_unbind;
+	}
 
 	while (1) {
 		free(line);
@@ -980,10 +1145,11 @@ static int do_client(struct memory_buffer *mem)
 		if (max_chunk) {
 			msg.msg_iovlen =
 				(line_size + max_chunk - 1) / max_chunk;
-			if (msg.msg_iovlen > MAX_IOV)
-				error(1, 0,
-				      "can't partition %zd bytes into maximum of %d chunks",
-				      line_size, MAX_IOV);
+			if (msg.msg_iovlen > MAX_IOV) {
+				pr_err("can't partition %zd bytes into maximum of %d chunks",
+				       line_size, MAX_IOV);
+				goto err_free_line;
+			}
 
 			for (int i = 0; i < msg.msg_iovlen; i++) {
 				iov[i].iov_base = (void *)(i * max_chunk);
@@ -1014,34 +1180,40 @@ static int do_client(struct memory_buffer *mem)
 		*((__u32 *)CMSG_DATA(cmsg)) = ddmabuf;
 
 		ret = sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
-		if (ret < 0)
-			error(1, errno, "Failed sendmsg");
+		if (ret < 0) {
+			pr_err("Failed sendmsg");
+			goto err_free_line;
+		}
 
 		fprintf(stderr, "sendmsg_ret=%d\n", ret);
 
-		if (ret != line_size)
-			error(1, errno, "Did not send all bytes %d vs %zd", ret,
-			      line_size);
+		if (ret != line_size) {
+			pr_err("Did not send all bytes %d vs %zd", ret, line_size);
+			goto err_free_line;
+		}
 
-		wait_compl(socket_fd);
+		if (wait_compl(socket_fd))
+			goto err_free_line;
 	}
 
 	fprintf(stderr, "%s: tx ok\n", TEST_PREFIX);
 
+	err = 0;
+
+err_free_line:
 	free(line);
+err_unbind:
+	ynl_sock_destroy(ys);
+err_close_socket:
 	close(socket_fd);
-
-	if (ys)
-		ynl_sock_destroy(ys);
-
-	return 0;
+	return err;
 }
 
 int main(int argc, char *argv[])
 {
 	struct memory_buffer *mem;
 	int is_server = 0, opt;
-	int ret;
+	int ret, err = 1;
 
 	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:")) != -1) {
 		switch (opt) {
@@ -1078,8 +1250,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!ifname)
-		error(1, 0, "Missing -f argument\n");
+	if (!ifname) {
+		pr_err("Missing -f argument");
+		return 1;
+	}
 
 	ifindex = if_nametoindex(ifname);
 
@@ -1088,33 +1262,41 @@ int main(int argc, char *argv[])
 	if (!server_ip && !client_ip) {
 		if (start_queue < 0 && num_queues < 0) {
 			num_queues = rxq_num(ifindex);
-			if (num_queues < 0)
-				error(1, 0, "couldn't detect number of queues\n");
-			if (num_queues < 2)
-				error(1, 0,
-				      "number of device queues is too low\n");
+			if (num_queues < 0) {
+				pr_err("couldn't detect number of queues");
+				return 1;
+			}
+			if (num_queues < 2) {
+				pr_err("number of device queues is too low");
+				return 1;
+			}
 			/* make sure can bind to multiple queues */
 			start_queue = num_queues / 2;
 			num_queues /= 2;
 		}
 
-		if (start_queue < 0 || num_queues < 0)
-			error(1, 0, "Both -t and -q are required\n");
+		if (start_queue < 0 || num_queues < 0) {
+			pr_err("Both -t and -q are required");
+			return 1;
+		}
 
-		run_devmem_tests();
-		return 0;
+		return run_devmem_tests();
 	}
 
 	if (start_queue < 0 && num_queues < 0) {
 		num_queues = rxq_num(ifindex);
-		if (num_queues < 2)
-			error(1, 0, "number of device queues is too low\n");
+		if (num_queues < 2) {
+			pr_err("number of device queues is too low");
+			return 1;
+		}
 
 		num_queues = 1;
 		start_queue = rxq_num(ifindex) - num_queues;
 
-		if (start_queue < 0)
-			error(1, 0, "couldn't detect number of queues\n");
+		if (start_queue < 0) {
+			pr_err("couldn't detect number of queues");
+			return 1;
+		}
 
 		fprintf(stderr, "using queues %d..%d\n", start_queue, start_queue + num_queues);
 	}
@@ -1122,21 +1304,39 @@ int main(int argc, char *argv[])
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-	if (start_queue < 0)
-		error(1, 0, "Missing -t argument\n");
+	if (start_queue < 0) {
+		pr_err("Missing -t argument");
+		return 1;
+	}
 
-	if (num_queues < 0)
-		error(1, 0, "Missing -q argument\n");
+	if (num_queues < 0) {
+		pr_err("Missing -q argument");
+		return 1;
+	}
 
-	if (!server_ip)
-		error(1, 0, "Missing -s argument\n");
+	if (!server_ip) {
+		pr_err("Missing -s argument");
+		return 1;
+	}
 
-	if (!port)
-		error(1, 0, "Missing -p argument\n");
+	if (!port) {
+		pr_err("Missing -p argument");
+		return 1;
+	}
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
-	ret = is_server ? do_server(mem) : do_client(mem);
-	provider->free(mem);
+	if (!mem) {
+		pr_err("Failed to allocate memory buffer");
+		return 1;
+	}
 
-	return ret;
+	ret = is_server ? do_server(mem) : do_client(mem);
+	if (ret)
+		goto err_free_mem;
+
+	err = 0;
+
+err_free_mem:
+	provider->free(mem);
+	return err;
 }
-- 
2.51.0


