Return-Path: <linux-kselftest+bounces-7677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0151B8A07DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF41F2116A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 05:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580713C9D1;
	Thu, 11 Apr 2024 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoOkRg6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED2EADD;
	Thu, 11 Apr 2024 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814221; cv=none; b=qEjkjeldtjMGqY+XHqEljdUJCcPEupN9JltRhUEqyxNaYjZbZWjqfYzcJnl+HwnaJLlszE1f8aQUpyjSY3vLdrIFg7U1qWfLw782oWDALT4vhJB4aspHLokKUsCBbXjxezm2XLREr1itInD3h9uVHSBTtYMlrGNaK1LrXYeJRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814221; c=relaxed/simple;
	bh=P2QlzZZXD/atcoF2vwTJ7B2lr4396SBnG+qkncx9yvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnyq9CeqFtw937gcllRfYCcgg6YQWeuUE6CpZ0v1VSZ17xgLJDfedbouc4GmYVjzvhjp4lfyMlD6uXREhiLcD8LR1bAmpHboklxmnAHhKSf9eq3I+kqMWmjCOVwJxwFeek9H1AfhX/aIYNl4diN9147hvgF4WydTnMEJOFEHMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoOkRg6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6061BC433F1;
	Thu, 11 Apr 2024 05:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814221;
	bh=P2QlzZZXD/atcoF2vwTJ7B2lr4396SBnG+qkncx9yvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoOkRg6pFfzdUhTYJlOZQnh2weRLhSGbYir0EBnkXFUFQeb7nRMyTX2p4c/5ay7Tj
	 3tRHbt6UCm6h0jVU67ZXkYH3DUyhIjMWBDb6TQYOERmupbVCLrFp2AWQFqHdqg8CZV
	 Qj2X4vGdjTf+GMwcUYIvGdtprdRT7wNMFvEdPRxtnEdwsXzR7CCLlJc4WIFIB25zBj
	 wOhm0+msD/0GhHnd8qLGG7ZdYy3VuOq/a9JJBnEVfLnYQqpA7mW7X3EoYMX5zA24FS
	 222Uy2h+ZrC8wbmDrvHzqFsQs3yK8oTavx4Iv0uXdX/nZmO5aK0Oa3MrE/+ktNwByU
	 KBFuKkaXYCoRA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Export send_recv_data helper
Date: Thu, 11 Apr 2024 13:43:12 +0800
Message-Id: <5231103be91fadcce3674a589542c63b6a5eedd4.1712813933.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712813933.git.tanggeliang@kylinos.cn>
References: <cover.1712813933.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts the code to send and receive data into a new
helper named send_recv_data() in network_helpers.c and export it
in network_helpers.h.

This helper will be used for MPTCP BPF selftests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 96 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 81 +---------------
 3 files changed, 98 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 04175e16195a..bb72cbb6c9ee 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -545,3 +545,99 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	close(sockfd);
 	return 0;
 }
+
+struct send_recv_arg {
+	int		fd;
+	uint32_t	bytes;
+	int		stop;
+};
+
+static void *send_recv_server(void *arg)
+{
+	struct send_recv_arg *a = (struct send_recv_arg *)arg;
+	ssize_t nr_sent = 0, bytes = 0;
+	char batch[1500];
+	int err = 0, fd;
+
+	fd = accept(a->fd, NULL, NULL);
+	while (fd == -1) {
+		if (errno == EINTR)
+			continue;
+		err = -errno;
+		goto done;
+	}
+
+	if (settimeo(fd, 0)) {
+		err = -errno;
+		goto done;
+	}
+
+	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
+		nr_sent = send(fd, &batch,
+			       MIN(a->bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent == -1 && errno == EINTR)
+			continue;
+		if (nr_sent == -1) {
+			err = -errno;
+			break;
+		}
+		bytes += nr_sent;
+	}
+
+	if (bytes != a->bytes)
+		log_err("Failed to send");
+
+done:
+	if (fd >= 0)
+		close(fd);
+	if (err) {
+		WRITE_ONCE(a->stop, 1);
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+int send_recv_data(int lfd, int fd, uint32_t total_bytes)
+{
+	ssize_t nr_recv = 0, bytes = 0;
+	struct send_recv_arg arg = {
+		.fd	= lfd,
+		.bytes	= total_bytes,
+		.stop	= 0,
+	};
+	pthread_t srv_thread;
+	void *thread_ret;
+	char batch[1500];
+	int err = 0;
+
+	err = pthread_create(&srv_thread, NULL, send_recv_server, (void *)&arg);
+	if (err) {
+		log_err("Failed to pthread_create");
+		return err;
+	}
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
+		nr_recv = recv(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv == -1 && errno == EINTR)
+			continue;
+		if (nr_recv == -1) {
+			err = -errno;
+			break;
+		}
+		bytes += nr_recv;
+	}
+
+	if (bytes != total_bytes)
+		log_err("Failed to recv");
+
+	WRITE_ONCE(arg.stop, 1);
+	pthread_join(srv_thread, &thread_ret);
+	if (IS_ERR(thread_ret) && !err) {
+		log_err("Failed to thread_ret");
+		err = PTR_ERR(thread_ret);
+	}
+
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 6457445cc6e2..70f4e4c92733 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -76,6 +76,7 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+int send_recv_data(int lfd, int fd, uint32_t total_bytes);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 8f23b59574ff..0d811d08504a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -32,75 +32,15 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
-struct send_recv_arg {
-	int		fd;
-	uint32_t	bytes;
-	int		stop;
-};
-
-static void *server(void *arg)
-{
-	struct send_recv_arg *a = (struct send_recv_arg *)arg;
-	ssize_t nr_sent = 0, bytes = 0;
-	char batch[1500];
-	int err = 0, fd;
-
-	fd = accept(a->fd, NULL, NULL);
-	while (fd == -1) {
-		if (errno == EINTR)
-			continue;
-		err = -errno;
-		goto done;
-	}
-
-	if (settimeo(fd, 0)) {
-		err = -errno;
-		goto done;
-	}
-
-	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
-		nr_sent = send(fd, &batch,
-			       MIN(a->bytes - bytes, sizeof(batch)), 0);
-		if (nr_sent == -1 && errno == EINTR)
-			continue;
-		if (nr_sent == -1) {
-			err = -errno;
-			break;
-		}
-		bytes += nr_sent;
-	}
-
-	ASSERT_EQ(bytes, a->bytes, "send");
-
-done:
-	if (fd >= 0)
-		close(fd);
-	if (err) {
-		WRITE_ONCE(a->stop, 1);
-		return ERR_PTR(err);
-	}
-	return NULL;
-}
-
 static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 {
-	ssize_t nr_recv = 0, bytes = 0;
-	struct send_recv_arg arg = {
-		.bytes	= total_bytes,
-		.stop	= 0,
-	};
 	int lfd = -1, fd = -1;
-	pthread_t srv_thread;
-	void *thread_ret;
-	char batch[1500];
 	int err;
 
 	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
-	arg.fd = lfd;
-
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_NEQ(fd, -1, "socket")) {
 		close(lfd);
@@ -132,26 +72,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 			goto done;
 	}
 
-	err = pthread_create(&srv_thread, NULL, server, (void *)&arg);
-	if (!ASSERT_OK(err, "pthread_create"))
-		goto done;
-
-	/* recv total_bytes */
-	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
-		nr_recv = recv(fd, &batch,
-			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_recv == -1 && errno == EINTR)
-			continue;
-		if (nr_recv == -1)
-			break;
-		bytes += nr_recv;
-	}
-
-	ASSERT_EQ(bytes, total_bytes, "recv");
-
-	WRITE_ONCE(arg.stop, 1);
-	pthread_join(srv_thread, &thread_ret);
-	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
 
 done:
 	close(lfd);
-- 
2.40.1


