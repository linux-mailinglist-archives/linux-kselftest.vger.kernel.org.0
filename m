Return-Path: <linux-kselftest+bounces-13286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDACE929433
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D13B20DDD
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6413A86E;
	Sat,  6 Jul 2024 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUc1WSHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEE13A41D;
	Sat,  6 Jul 2024 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277270; cv=none; b=WDB2S5w6O1sS0u2tO1lYR7gAO6SoFeFaLZd8Ql2EykxzsQH1C0f46jkx4M6hmkD/0aJXMDfiTkLGardpuW0uJ2d9K/+/tLTIXXFBjaWBi+V07ZEVYkYS1nifmOgFLz39SkZVya7t9+D3pOGeesAL7xbaZK/vFlnqvgR9LWX7Vt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277270; c=relaxed/simple;
	bh=UP3dewuIjoA5sjTgTdYbHvbUObaH3wdxvkdyENKJ+bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQlOkO8tovC3uQKVX8+BGOqWEz3L7Gg1NZ27sj4MLDBfPl6UoCo5jvNiviGwVUVHy/8Miek+5TiUics7bIWGxC7u/UpjjdFi+Q6NV/oGHWr6bUQSOrEhRB4gjvCV9CX4CfXVgMv2/T77uOqjI0J9ghtXZ2Q6Ov6T9VvDYq48j60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUc1WSHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DDAC2BD10;
	Sat,  6 Jul 2024 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720277270;
	bh=UP3dewuIjoA5sjTgTdYbHvbUObaH3wdxvkdyENKJ+bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUc1WSHkTKX31/kYvIDMnDT2+uYXhmPba3j+LXv2ZKPIJAt8ryjN1GPZDb5o9g/6P
	 kyEhz2PNLRojTBc3NW9NR5r33kQ6sYvRwlE3ILoDiHO+egawOtMvjwX5NqkV0NTHdg
	 Zw+bUJ9A9ocUtBOIgYi0Gz299qXP17EzWs3M9wY+GCIrByvsJMW+d46aZubrNy4r8E
	 t2S7gf0p6eibLdbrjrwLCo0kYKZWcP/5yCWNVQBBKa+k6m2XAgxAiMiSCpP0A1S3Lk
	 QSWbuWGzDw6XR1uWlmaxghpxPC5zwkvYIQThnR26abphOuiSlTn0g/lXbC8blVxDqc
	 NIq/lM1/v937g==
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
Subject: [PATCH bpf-next v9 10/11] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Sat,  6 Jul 2024 22:45:55 +0800
Message-ID: <96086c85a032f8846c1bd642dd48c4c952ab2168.1720276189.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720276189.git.tanggeliang@kylinos.cn>
References: <cover.1720276189.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index d03ea3e64a2e..f9b8415c16a6 100644
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
@@ -658,7 +660,7 @@ static void run_lookup_prog(const struct test *t)
 			goto close;
 	}
 
-	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port);
+	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port, 0);
 	if (client_fd < 0)
 		goto close;
 
@@ -874,7 +876,6 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_lookup(const struct test *t)
 {
-	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -888,12 +889,12 @@ static void drop_on_lookup(const struct test *t)
 	if (server_fd < 0)
 		goto detach;
 
-	client_fd = make_socket(t->sotype, t->connect_to.ip,
-				t->connect_to.port, &dst);
+	client_fd = make_client(t->sotype, t->connect_to.ip,
+				t->connect_to.port, ECONNREFUSED);
 	if (client_fd < 0)
 		goto close_srv;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = -1;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
 		if (err)
@@ -988,7 +989,6 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
-	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -1012,12 +1012,12 @@ static void drop_on_reuseport(const struct test *t)
 	if (server2 < 0)
 		goto close_srv1;
 
-	client = make_socket(t->sotype, t->connect_to.ip,
-			     t->connect_to.port, &dst);
+	client = make_client(t->sotype, t->connect_to.ip,
+			     t->connect_to.port, ECONNREFUSED);
 	if (client < 0)
 		goto close_srv2;
 
-	err = connect(client, (void *)&dst, inetaddr_len(&dst));
+	err = -1;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
 		if (err)
@@ -1164,7 +1164,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1178,7 +1178,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


