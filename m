Return-Path: <linux-kselftest+bounces-12442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8BF91228C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0503A1F21C6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A042A172767;
	Fri, 21 Jun 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0YJ+4CY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F017166A;
	Fri, 21 Jun 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966163; cv=none; b=FkDKyYJfmYWqIVvS0pjsY2jytOtJYJQTyqLuFa/g+4t1o4A8IVPuVP2jR7KZjxvOrVLqWXO22RPztgCVqScnjY5QiBkKFdv2aO8xt1Ex6II4RWtrG+h+G3QGmY/lgj0QgCV47oJUp3l/mdTY7NziEKjUw+ORK2P8PZtQUEVVXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966163; c=relaxed/simple;
	bh=obi93RcFYsnTiQvAxwes3xclDEbY46BXn9dP7uPO/qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGvjldXI60Mfdf4Grge1Uk/7Z1fvd0gHsOf4Q0v6JQZv2OcfMuMB0nfyo94U5yvAwuJQZuy9utP3C3rWYE+X1+MdD382JbCfZPRYJ5J34XZszc95mCe+1AQ+X9QZxeUipK4W4qBxewxlF08Gm7wLzDcE0HUUo5haxcb/jJJAKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0YJ+4CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4FDC2BBFC;
	Fri, 21 Jun 2024 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966163;
	bh=obi93RcFYsnTiQvAxwes3xclDEbY46BXn9dP7uPO/qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0YJ+4CYvgubvKXRVHJv1GycVNbidpmzcDXiJIyA2UVyKXSAbJ4gF1gACC13kHRW1
	 v/xuoOc10lBYbQyO0qTJGGieHZ6mdxfAj6lrvzri9+AqMDw2i/vwjG453EKaLoKN5K
	 rko2C0GlXGZOMRYUup+5+j5XEoG9jkqQ6XgnmYaShbdsOZ+ssBPStSVJGbX9Vnc9zv
	 3g/HYJ31/BuYwMkTx8sROtxyjeyQHagbOGV96Ce/Hi8vGACnMwzqXFEJ9SN3NMn++8
	 RVW3TaaovJ5+JBAzLVZLfENQvx0jFRWcq9a0LGAx42jy8ncpC2YpEZD/zLedhCYzT+
	 J5u4x0LnE6T8g==
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
Subject: [PATCH bpf-next 4/6] selftests/bpf: Drop inetaddr_len in sk_lookup
Date: Fri, 21 Jun 2024 18:35:27 +0800
Message-ID: <13aec50e1faa04dc497e9394fd4ff5384532c7fc.1718965270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new parameter "len" for make_socket() to get the length
of the address by make_sockaddr(), then local helper inetaddr_len() can be
dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ba73b56f4484..2fc2b928e168 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -108,20 +108,14 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
 	return 0;
 }
 
-static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
-{
-	return (addr->ss_family == AF_INET ? sizeof(struct sockaddr_in) :
-		addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) : 0);
-}
-
 static int make_socket(int sotype, const char *ip, int port,
-		       struct sockaddr_storage *addr)
+		       struct sockaddr_storage *addr, socklen_t *len)
 {
 	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
 	int err, family, fd;
 
 	family = is_ipv6(ip) ? AF_INET6 : AF_INET;
-	err = make_sockaddr(family, ip, port, addr, NULL);
+	err = make_sockaddr(family, ip, port, addr, len);
 	if (CHECK(err, "make_address", "failed\n"))
 		return -1;
 
@@ -231,13 +225,14 @@ static int make_server(int sotype, const char *ip, int port,
 static int make_client(int sotype, const char *ip, int port)
 {
 	struct sockaddr_storage addr = {0};
+	socklen_t len;
 	int err, fd;
 
-	fd = make_socket(sotype, ip, port, &addr);
+	fd = make_socket(sotype, ip, port, &addr, &len);
 	if (fd < 0)
 		return -1;
 
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
+	err = connect(fd, (void *)&addr, len);
 	if (CHECK(err, "make_client", "connect")) {
 		log_err("failed to connect client socket");
 		goto fail;
@@ -876,6 +871,7 @@ static void drop_on_lookup(const struct test *t)
 	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
+	socklen_t len;
 	ssize_t n;
 
 	lookup_link = attach_lookup_prog(t->lookup_prog);
@@ -888,11 +884,11 @@ static void drop_on_lookup(const struct test *t)
 		goto detach;
 
 	client_fd = make_socket(t->sotype, t->connect_to.ip,
-				t->connect_to.port, &dst);
+				t->connect_to.port, &dst, &len);
 	if (client_fd < 0)
 		goto close_srv;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = connect(client_fd, (void *)&dst, len);
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
 		if (err)
@@ -990,6 +986,7 @@ static void drop_on_reuseport(const struct test *t)
 	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
+	socklen_t len;
 	ssize_t n;
 
 	lookup_link = attach_lookup_prog(t->lookup_prog);
@@ -1012,11 +1009,11 @@ static void drop_on_reuseport(const struct test *t)
 		goto close_srv1;
 
 	client = make_socket(t->sotype, t->connect_to.ip,
-			     t->connect_to.port, &dst);
+			     t->connect_to.port, &dst, &len);
 	if (client < 0)
 		goto close_srv2;
 
-	err = connect(client, (void *)&dst, inetaddr_len(&dst));
+	err = connect(client, (void *)&dst, len);
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
 		if (err)
@@ -1230,6 +1227,7 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
+	socklen_t len;
 
 	map_fd = bpf_map__fd(t->run_map);
 
@@ -1259,11 +1257,11 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst);
+	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst, &len);
 	if (client_fd < 0)
 		goto out_close_server;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = connect(client_fd, (void *)&dst, len);
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
 		goto out_close_client;
-- 
2.43.0


