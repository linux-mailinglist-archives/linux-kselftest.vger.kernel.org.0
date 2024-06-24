Return-Path: <linux-kselftest+bounces-12541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D0914124
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB9B225EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAED529;
	Mon, 24 Jun 2024 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BByVBVf7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1605D272;
	Mon, 24 Jun 2024 04:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203707; cv=none; b=ReiZPC7vt8cjPWkQBh0ZEUhGrCfhaycnMxfzvMp8gJo56Ttx1dgMEqTlq6FxGOAtzwWaewGknIIqLq7Lc1P+snEPQq7iKRokT71SKtunrtC8l6MSZbPySuTZKwHdLnrPLvaBkT1VtDgxwemjnRCE2h3D3B2XbMJ0vZGYWz4oPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203707; c=relaxed/simple;
	bh=uJQBUbS6RPM4Xxdn++RhzaL/J0PbD/chkKcS3w7EuFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRgiq2bS3l15U+3R4Op5CuZhj4Pt3Tqh8tUIh2cAMBRWHCocB27uZaxZKsUmVIG6bRQ2Q+qzbEpeVm0jyRbINy/MGS6Ac9slck74ZYZCSs7upZzxoRieEeuNB7+37IZzFIkfr7K8tM/oBTkNaHhZvkNdNZDP43CiKjhyZAYwTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BByVBVf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D8FC4AF0B;
	Mon, 24 Jun 2024 04:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203706;
	bh=uJQBUbS6RPM4Xxdn++RhzaL/J0PbD/chkKcS3w7EuFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BByVBVf7StKiXAfVQWodAfEUlV0e94DKmbSPm7ehQawzBErY5E77iemRE2IFSQ1d+
	 FJitXoA3YBoC08ZF/G1hER5e+MmSZ9zJ/9BJC2k2AUY2k4Qz2LqSgBI8qCfJPV4TdB
	 5bGAHRfmE7K3kRXhQ0Fk1rHSCWLDSR5b7JmeHwnB12teHYQeAXdJ+khaPcM5fDLVJn
	 0H/u3qTkCwV4mU6GVs8JMnlhIxNBPV/UAxU2PH8F2i2eXildaqPM3ze0gCdxHAH11n
	 6hKEx2mZUS3uEpIkdbK/TntR1NDi0zQ1+E+nVUNIUGeSo64FGFeI0FylY7NK1m3wrE
	 eowJEvngnd9sA==
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
Subject: [PATCH bpf-next v4 7/9] selftests/bpf: Use start_server_str in sk_lookup
Date: Mon, 24 Jun 2024 12:33:54 +0800
Message-ID: <e9168f313fc288997f5030d068be4e557ac552a4.1719203293.git.tanggeliang@kylinos.cn>
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

This patch uses public helper start_server_addr() instead of local
defined function make_server() in prog_tests/sk_lookup.c to avoid
duplicate code.

Add a helper setsockopts() to set SOL_CUSTOM sockopt looply, set
it to setsockopt pointer of struct network_helper_opts, and pass it
to start_server_addr().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 141 ++++++++++++------
 1 file changed, 96 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index d87dfcf5db07..634c2ac0595e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -77,6 +77,12 @@ struct test {
 	bool reuseport_has_conns; /* Add a connected socket to reuseport group */
 };
 
+struct cb_opts {
+	int family;
+	int sotype;
+	bool reuseport;
+};
+
 static __u32 duration;		/* for CHECK macro */
 
 static bool is_ipv6(const char *ip)
@@ -142,19 +148,14 @@ static int make_socket(int sotype, const char *ip, int port,
 	return fd;
 }
 
-static int make_server(int sotype, const char *ip, int port,
-		       struct bpf_program *reuseport_prog)
+static int setsockopts(int fd, void *opts)
 {
-	struct sockaddr_storage addr = {0};
+	struct cb_opts *co = (struct cb_opts *)opts;
 	const int one = 1;
-	int err, fd = -1;
-
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
-		return -1;
+	int err = 0;
 
 	/* Enabled for UDPv6 sockets for IPv4-mapped IPv6 to work. */
-	if (sotype == SOCK_DGRAM) {
+	if (co->sotype == SOCK_DGRAM) {
 		err = setsockopt(fd, SOL_IP, IP_RECVORIGDSTADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(IP_RECVORIGDSTADDR)", "failed\n")) {
@@ -163,7 +164,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (sotype == SOCK_DGRAM && addr.ss_family == AF_INET6) {
+	if (co->sotype == SOCK_DGRAM && co->family == AF_INET6) {
 		err = setsockopt(fd, SOL_IPV6, IPV6_RECVORIGDSTADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(IPV6_RECVORIGDSTADDR)", "failed\n")) {
@@ -172,7 +173,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (sotype == SOCK_STREAM) {
+	if (co->sotype == SOCK_STREAM) {
 		err = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(SO_REUSEADDR)", "failed\n")) {
@@ -181,7 +182,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (reuseport_prog) {
+	if (co->reuseport) {
 		err = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(SO_REUSEPORT)", "failed\n")) {
@@ -190,24 +191,8 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	err = bind(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "bind", "failed\n")) {
-		log_err("failed to bind listen socket");
-		goto fail;
-	}
-
-	if (sotype == SOCK_STREAM) {
-		err = listen(fd, SOMAXCONN);
-		if (CHECK(err, "make_server", "listen")) {
-			log_err("failed to listen on port %d", port);
-			goto fail;
-		}
-	}
-
-	return fd;
 fail:
-	close(fd);
-	return -1;
+	return err;
 }
 
 static int make_client(int sotype, const char *ip, int port)
@@ -588,6 +573,17 @@ static void query_lookup_prog(struct test_sk_lookup *skel)
 
 static void run_lookup_prog(const struct test *t)
 {
+	int family = is_ipv6(t->listen_at.ip) ? AF_INET6 : AF_INET;
+	struct cb_opts cb_opts = {
+		.family = family,
+		.sotype = t->sotype,
+		.reuseport = t->reuseport_prog,
+	};
+	struct network_helper_opts srv_opts = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts,
+	};
 	int server_fds[] = { [0 ... MAX_SERVERS - 1] = -1 };
 	int client_fd, reuse_conn_fd = -1;
 	struct bpf_link *lookup_link;
@@ -598,9 +594,8 @@ static void run_lookup_prog(const struct test *t)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(server_fds); i++) {
-		server_fds[i] = make_server(t->sotype, t->listen_at.ip,
-					    t->listen_at.port,
-					    t->reuseport_prog);
+		server_fds[i] = start_server_str(family, t->sotype, t->listen_at.ip,
+						 t->listen_at.port, &srv_opts);
 		if (server_fds[i] < 0 ||
 		    attach_reuseport(server_fds[i], t->reuseport_prog))
 			goto close;
@@ -625,9 +620,8 @@ static void run_lookup_prog(const struct test *t)
 		socklen_t len = sizeof(addr);
 
 		/* Add an extra socket to reuseport group */
-		reuse_conn_fd = make_server(t->sotype, t->listen_at.ip,
-					    t->listen_at.port,
-					    t->reuseport_prog);
+		reuse_conn_fd = start_server_str(family, t->sotype, t->listen_at.ip,
+						 t->listen_at.port, &srv_opts);
 		if (reuse_conn_fd < 0 ||
 		    attach_reuseport(reuse_conn_fd, t->reuseport_prog))
 			goto close;
@@ -857,6 +851,16 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_lookup(const struct test *t)
 {
+	struct cb_opts cb_opts = {
+		.family = is_ipv6(t->listen_at.ip) ? AF_INET6 : AF_INET,
+		.sotype = t->sotype,
+		.reuseport = t->reuseport_prog,
+	};
+	struct network_helper_opts opts = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts,
+	};
 	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
@@ -866,8 +870,8 @@ static void drop_on_lookup(const struct test *t)
 	if (!lookup_link)
 		return;
 
-	server_fd = make_server(t->sotype, t->listen_at.ip, t->listen_at.port,
-				t->reuseport_prog);
+	server_fd = start_server_str(cb_opts.family, t->sotype, t->listen_at.ip,
+				     t->listen_at.port, &opts);
 	if (server_fd < 0)
 		goto detach;
 
@@ -974,6 +978,25 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
+	struct cb_opts cb_opts1 = {
+		.family = is_ipv6(t->listen_at.ip) ? AF_INET6 : AF_INET,
+		.sotype = t->sotype,
+		.reuseport = t->reuseport_prog,
+	};
+	struct network_helper_opts opts1 = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts1,
+	};
+	struct cb_opts cb_opts2 = {
+		.family = is_ipv6(t->connect_to.ip) ? AF_INET6 : AF_INET,
+		.sotype = t->sotype,
+	};
+	struct network_helper_opts opts2 = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts2,
+	};
 	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
@@ -983,8 +1006,8 @@ static void drop_on_reuseport(const struct test *t)
 	if (!lookup_link)
 		return;
 
-	server1 = make_server(t->sotype, t->listen_at.ip, t->listen_at.port,
-			      t->reuseport_prog);
+	server1 = start_server_str(cb_opts1.family, t->sotype, t->listen_at.ip,
+				   t->listen_at.port, &opts1);
 	if (server1 < 0)
 		goto detach;
 
@@ -996,8 +1019,8 @@ static void drop_on_reuseport(const struct test *t)
 		goto close_srv1;
 
 	/* second server on destination address we should never reach */
-	server2 = make_server(t->sotype, t->connect_to.ip, t->connect_to.port,
-			      NULL /* reuseport prog */);
+	server2 = start_server_str(cb_opts2.family, t->sotype, t->connect_to.ip,
+				   t->connect_to.port, &opts2);
 	if (server2 < 0)
 		goto close_srv1;
 
@@ -1082,6 +1105,15 @@ static void run_sk_assign(struct test_sk_lookup *skel,
 			  struct bpf_program *lookup_prog,
 			  const char *remote_ip, const char *local_ip)
 {
+	struct cb_opts cb_opts = {
+		.family = is_ipv6(local_ip) ? AF_INET6 : AF_INET,
+		.sotype = SOCK_STREAM,
+	};
+	struct network_helper_opts srv_opts = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts,
+	};
 	int server_fds[] = { [0 ... MAX_SERVERS - 1] = -1 };
 	struct bpf_sk_lookup ctx;
 	__u64 server_cookie;
@@ -1100,7 +1132,8 @@ static void run_sk_assign(struct test_sk_lookup *skel,
 	ctx.protocol = IPPROTO_TCP;
 
 	for (i = 0; i < ARRAY_SIZE(server_fds); i++) {
-		server_fds[i] = make_server(SOCK_STREAM, local_ip, 0, NULL);
+		server_fds[i] = start_server_str(cb_opts.family, SOCK_STREAM,
+						 local_ip, 0, &srv_opts);
 		if (server_fds[i] < 0)
 			goto close_servers;
 
@@ -1146,10 +1179,19 @@ static void run_sk_assign_v6(struct test_sk_lookup *skel,
 static void run_sk_assign_connected(struct test_sk_lookup *skel,
 				    int sotype)
 {
+	struct cb_opts cb_opts = {
+		.family = AF_INET,
+		.sotype = sotype,
+	};
+	struct network_helper_opts opts = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts,
+	};
 	int err, client_fd, connected_fd, server_fd;
 	struct bpf_link *lookup_link;
 
-	server_fd = make_server(sotype, EXT_IP4, EXT_PORT, NULL);
+	server_fd = start_server_str(AF_INET, sotype, EXT_IP4, EXT_PORT, &opts);
 	if (server_fd < 0)
 		return;
 
@@ -1216,6 +1258,15 @@ struct test_multi_prog {
 
 static void run_multi_prog_lookup(const struct test_multi_prog *t)
 {
+	struct cb_opts cb_opts = {
+		.family = is_ipv6(t->listen_at.ip) ? AF_INET6 : AF_INET,
+		.sotype = SOCK_STREAM,
+	};
+	struct network_helper_opts srv_opts = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts,
+	};
 	struct sockaddr_storage dst = {};
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
@@ -1240,8 +1291,8 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (!link2)
 		goto out_unlink1;
 
-	server_fd = make_server(SOCK_STREAM, t->listen_at.ip,
-				t->listen_at.port, NULL);
+	server_fd = start_server_str(cb_opts.family, SOCK_STREAM, t->listen_at.ip,
+				     t->listen_at.port, &srv_opts);
 	if (server_fd < 0)
 		goto out_unlink2;
 
-- 
2.43.0


