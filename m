Return-Path: <linux-kselftest+bounces-13303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF4F929AE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D837DB20BD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0237816;
	Mon,  8 Jul 2024 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQzpq7kX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889F3FC2;
	Mon,  8 Jul 2024 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405875; cv=none; b=KbyVf9koTIQbd6Aly7xUu5PjqhycEGkVLPk4i9NT+Bwi9fi0cICta+UVvqAfzMXli5AqGUs4JiApDKZ8sa5v0rp/4/14l4Cz/QEf4OjyPHQuNWvks2xMiv5VjQZINdfrBqjSmrYeU/3GqlXGqCLD0bJyz/BavSWf3+EpWGmLqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405875; c=relaxed/simple;
	bh=/V6c1yuMC1EczJD4hdOVaOvhn62H4BXQjA2cI5wRGPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8TABOIry0nt5xWQb2gHTeShB7L+fP/LOwDVT/2+2pMmdMnNppSevm4aMij8UmCc9zkSnS5cINZjhmsnAzQKj8E7rULO/cju2VhOtCb8OSztDFTH7bmr0FSI+5iMWWHbc89yRymWuFwCjZFWX8YlCXmwbmtGYXDgPTwvYjqExgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQzpq7kX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B47CC3277B;
	Mon,  8 Jul 2024 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405875;
	bh=/V6c1yuMC1EczJD4hdOVaOvhn62H4BXQjA2cI5wRGPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQzpq7kX9miy8h3Q2wgVfv2Af4AMTg9gtfivjU56SJy1auvc68fLrlJc0u+OnLLih
	 EY8Fg58+9tggzMiAi1vm/y8aLbIaUjrzSkT8OfB4Lrgtr9WhhSchZ7mmOjIQEkojPn
	 bIuCLUOvFu+wrGYRcd9bhhAarolL0PfxRg1vzqBvN5J54pQFb6Q4GO0fClItRqk9Va
	 A9qgUNf5770tErlBjtRP8D/Bt92N3Pt4hzNJpJAe/k3IvXNVh1lSg2neAyRUM3TpEi
	 bvQj7nVmbIIA/C1j8F5AhIwQdp7c2rLMy+tewpb+z+rJL0uez70Do/QBa0BAK/ZI0T
	 F7uSW7//wgM1Q==
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
Subject: [PATCH bpf-next v10 11/12] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Mon,  8 Jul 2024 10:29:49 +0800
Message-ID: <396cb73d1db1ab0eb7adba73fdedb08600e51fda.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a new parameter expect_errno for make_client(), and use public network
helpers make_sockaddr() + connect_to_addr() in it instead of using local
defined function make_socket() + connect(). This local function can be
dropped latter.

A new parameter "expect_errno" is added for make_client() too to allow
different "expect_errno" is passed to make_client() and set as
"opts->expect_errno", then passed this opts to connect_to_addr().

connect_to_addr() returns normal "fd" instead of "-1" when connect() fails
but "expect_errno" matched. So "err = -errno" are needed to get the real
error numbers before checking values of "err" in both drop_on_lookup() and
drop_on_reuseport().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 184b838a9872..5e013e0f8136 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -229,25 +229,27 @@ static int make_server(int sotype, const char *ip, int port,
 	return -1;
 }
 
-static int make_client(int sotype, const char *ip, int port)
+static int make_client(int sotype, const char *ip, int port,
+		       const int expect_errno)
 {
-	struct sockaddr_storage addr = {0};
+	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
+	struct network_helper_opts opts = {
+		.timeout_ms	= IO_TIMEOUT_SEC,
+		.expect_errno	= expect_errno,
+	};
+	struct sockaddr_storage addr;
+	socklen_t len;
 	int err, fd;
 
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
+	err = make_sockaddr(family, ip, port, &addr, &len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
 		return -1;
 
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "make_client", "connect")) {
-		log_err("failed to connect client socket");
-		goto fail;
-	}
+	fd = connect_to_addr(sotype, &addr, len, &opts);
+	if (!ASSERT_GE(fd, 0, "connect_to_addr"))
+		return -1;
 
 	return fd;
-fail:
-	close(fd);
-	return -1;
 }
 
 static __u64 socket_cookie(int fd)
@@ -651,7 +653,7 @@ static void run_lookup_prog(const struct test *t)
 			goto close;
 	}
 
-	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port);
+	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port, 0);
 	if (client_fd < 0)
 		goto close;
 
@@ -867,7 +869,6 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_lookup(const struct test *t)
 {
-	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -881,12 +882,12 @@ static void drop_on_lookup(const struct test *t)
 	if (server_fd < 0)
 		goto detach;
 
-	client_fd = make_socket(t->sotype, t->connect_to.ip,
-				t->connect_to.port, &dst);
+	client_fd = make_client(t->sotype, t->connect_to.ip,
+				t->connect_to.port, ECONNREFUSED);
 	if (client_fd < 0)
 		goto close_srv;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = -errno;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
 		if (err)
@@ -981,7 +982,6 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
-	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -1005,12 +1005,12 @@ static void drop_on_reuseport(const struct test *t)
 	if (server2 < 0)
 		goto close_srv1;
 
-	client = make_socket(t->sotype, t->connect_to.ip,
-			     t->connect_to.port, &dst);
+	client = make_client(t->sotype, t->connect_to.ip,
+			     t->connect_to.port, ECONNREFUSED);
 	if (client < 0)
 		goto close_srv2;
 
-	err = connect(client, (void *)&dst, inetaddr_len(&dst));
+	err = -errno;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
 		if (err)
@@ -1157,7 +1157,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1171,7 +1171,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


