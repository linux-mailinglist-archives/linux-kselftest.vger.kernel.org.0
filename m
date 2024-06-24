Return-Path: <linux-kselftest+bounces-12543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F524914127
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499A31C2130D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041FDDBC;
	Mon, 24 Jun 2024 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjW6cImh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AFD272;
	Mon, 24 Jun 2024 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203716; cv=none; b=bmLhNaFnm84yJT7YVHzCSn1bLWilG9mGXjhgQ6Oe1iNXmrf+0oPbWMuNwLr05Vzgfvmf1nj/WF6tWBJFXa++BeKvtdDRbKQIyU+cRx82+tDfcY2CSbmMYlIqRcm3HQ9A9SAazcQtzoPuE6L7aCrgKoTzVYtpbhvaCvH0EwSSXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203716; c=relaxed/simple;
	bh=NUcvhzvIWuSrzj8jF97gJxnz+3HAHz0QSs+9uEknrlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbFIqqcns0huv79BIIcFT/xlBffZ5y76YKZ/qv+8QrjzfJ408YG0odFGoV+qUFyHUXxGe5blt1sANoFcHjaWPjPGfe0YUM/ztCGihWrGyfzkyXZfZoByIqs8z3yNILanjhd7UwAnEqI1J/3Y7KejIkKmc7WTNHvef40OvjehN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjW6cImh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50FAC32789;
	Mon, 24 Jun 2024 04:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203716;
	bh=NUcvhzvIWuSrzj8jF97gJxnz+3HAHz0QSs+9uEknrlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MjW6cImhrOikhmDQNuEWN5epW0uK8J7QiQL5O4sb9lkm4gGt6P97LONCOF0tpoJiO
	 3WgxmlUfotpKDVBdr9thKceve1Ov8VjGQAqdIYhqhKNaXAwzc9w8/iqgHS7t70srBj
	 QUrv8mot4n0P3aYIbsoZCuQ20JqTxJ8n81ZHRo4ZUBAntFOXvZu+zW7RAtV1Dmv8rK
	 8n9JOaIS3ArMCTInBrvOp8LtFjr8ZkDpNHZgpwsd637t5Q1i4Zord/ePTl5j0NkvIw
	 m4JPZtdLFMshjJyF51W6eTap+3lrHZE6PMhGnnHgxfLduYTxXoNPo0zdLccZHmj47z
	 x8yva6NPuqQAg==
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Mon, 24 Jun 2024 12:33:56 +0800
Message-ID: <26ad08128e97ad9a2647edc4714e182460a56394.1719203293.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719203293.git.tanggeliang@kylinos.cn>
References: <cover.1719203293.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use public network helpers make_sockaddr() and connect_to_addr() instead
of using make_socket() + connect() or make_client().

Now local defined functions inetaddr_len(), make_socket() and make_client()
all can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 83 ++++---------------
 1 file changed, 16 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index e1c5b7d1fb3a..5556796068f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -108,46 +108,6 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
 	return 0;
 }
 
-static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
-{
-	return (addr->ss_family == AF_INET ? sizeof(struct sockaddr_in) :
-		addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) : 0);
-}
-
-static int make_socket(int sotype, const char *ip, int port,
-		       struct sockaddr_storage *addr)
-{
-	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
-	int err, family, fd;
-
-	family = is_ipv6(ip) ? AF_INET6 : AF_INET;
-	err = make_sockaddr(family, ip, port, addr, NULL);
-	if (CHECK(err, "make_address", "failed\n"))
-		return -1;
-
-	fd = socket(addr->ss_family, sotype, 0);
-	if (CHECK(fd < 0, "socket", "failed\n")) {
-		log_err("failed to make socket");
-		return -1;
-	}
-
-	err = setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo, sizeof(timeo));
-	if (CHECK(err, "setsockopt(SO_SNDTIMEO)", "failed\n")) {
-		log_err("failed to set SNDTIMEO");
-		close(fd);
-		return -1;
-	}
-
-	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
-	if (CHECK(err, "setsockopt(SO_RCVTIMEO)", "failed\n")) {
-		log_err("failed to set RCVTIMEO");
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
 static int setsockopts(int fd, void *opts)
 {
 	struct cb_opts *co = (struct cb_opts *)opts;
@@ -195,27 +155,6 @@ static int setsockopts(int fd, void *opts)
 	return err;
 }
 
-static int make_client(int sotype, const char *ip, int port)
-{
-	struct sockaddr_storage addr = {0};
-	int err, fd;
-
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
-		return -1;
-
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "make_client", "connect")) {
-		log_err("failed to connect client socket");
-		goto fail;
-	}
-
-	return fd;
-fail:
-	close(fd);
-	return -1;
-}
-
 static __u64 socket_cookie(int fd)
 {
 	__u64 cookie;
@@ -584,8 +523,13 @@ static void run_lookup_prog(const struct test *t)
 		.post_socket_cb = setsockopts,
 		.cb_opts	= &cb_opts,
 	};
+	struct network_helper_opts cli_opts = {
+		.timeout_ms = IO_TIMEOUT_SEC,
+	};
 	int server_fds[] = { [0 ... MAX_SERVERS - 1] = -1 };
 	int client_fd, reuse_conn_fd = -1;
+	struct sockaddr_storage addr = {};
+	socklen_t len = sizeof(addr);
 	struct bpf_link *lookup_link;
 	int i, err;
 
@@ -616,9 +560,6 @@ static void run_lookup_prog(const struct test *t)
 	 * BPF socket lookup.
 	 */
 	if (t->reuseport_has_conns) {
-		struct sockaddr_storage addr = {};
-		socklen_t len = sizeof(addr);
-
 		/* Add an extra socket to reuseport group */
 		reuse_conn_fd = start_server_str(family, t->sotype, t->listen_at.ip,
 						 t->listen_at.port, &srv_opts);
@@ -635,7 +576,9 @@ static void run_lookup_prog(const struct test *t)
 			goto close;
 	}
 
-	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port);
+	if (make_sockaddr(family, t->connect_to.ip, t->connect_to.port, &addr, &len))
+		goto close;
+	client_fd = connect_to_addr(t->sotype, &addr, len, &cli_opts);
 	if (client_fd < 0)
 		goto close;
 
@@ -1263,10 +1206,14 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 		.post_socket_cb = setsockopts,
 		.cb_opts	= &cb_opts,
 	};
+	struct network_helper_opts cli_opts = {
+		.timeout_ms = IO_TIMEOUT_SEC,
+	};
 	struct sockaddr_storage dst = {};
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
+	socklen_t len;
 
 	map_fd = bpf_map__fd(t->run_map);
 
@@ -1296,11 +1243,13 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst);
+	if (make_sockaddr(AF_INET, EXT_IP4, EXT_PORT, &dst, &len))
+		goto out_close_server;
+	client_fd = connect_to_addr(SOCK_STREAM, &dst, len, &cli_opts);
 	if (client_fd < 0)
 		goto out_close_server;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = 0;
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
 		goto out_close_client;
-- 
2.43.0


