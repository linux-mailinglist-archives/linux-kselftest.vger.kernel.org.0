Return-Path: <linux-kselftest+bounces-13962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F793810C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF9E1C215AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B56127B56;
	Sat, 20 Jul 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTTmx3sj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5C5CDE9;
	Sat, 20 Jul 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721475649; cv=none; b=hUvKUyo77sRWtFT1XBBp+ucrQsZY6NhILCyVP4/B6YVHnDAWObndfo87JqqM6juwG5aqqd7qQwiV76w9TRdntIVpKwPKYf5amZhPntPRxZ36BPu+z99b3/5iuvI8V8vbqnSzjbtnYgnEMTkw2oDuQ1LR1L3KKpTPJVAdQY7HALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721475649; c=relaxed/simple;
	bh=ymOxyTJNDeP01Xw3MU6AS7hSYqG64TrobZgfiA/a/CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwnCB2LU7p3RRMgIpW1MNi0TOgh0Gwimzn3+WaPDn2D3rrsOZoV2fLykYws6IvrGp/I8kgSytZ8AvFhonMn3WspMdh9+Vr8cx/9GqUKEdKb6cx+3Fvf4W0+dYDM6apdiZZrpoOdQY4x8jDq58CmV8EIUA27Zkm4LAbegihnkjXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTTmx3sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB154C4AF0C;
	Sat, 20 Jul 2024 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721475649;
	bh=ymOxyTJNDeP01Xw3MU6AS7hSYqG64TrobZgfiA/a/CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTTmx3sjCuYdBkDXlNUp2CDoNQZwqn+ii1YzhbEucgw53axHbSRpLGROipTOHpklK
	 +4KU+wRRD6xkOcT4nJ3gsY3EVKM4dUmrJhWd5WHzwbChPKvj4Qfmt6MwgjCSbJMHuR
	 MJ3xhvzpAnEu2RvccPe+7/fpddRtvY+bpH/VUCbt+jGu1KVlLWbDpvYACA66EkJfRD
	 iD/GWGgWgHCtO5MPhpGcC7RbRFlm0fcb/vqZQbA3Sj5aJQUpjjzXtZJwzL3FNjDPTK
	 JkKb+ymkcFdWFuOAE7CDsRum+133XEOhXVFhL2kMibCKv0DPU1Rn8o+tBF5UZhAmix
	 5upncMZub/1Tw==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/4] selftests/bpf: Drop make_socket in sk_lookup
Date: Sat, 20 Jul 2024 19:40:04 +0800
Message-ID: <588771977ac48c27f73526d8421a84b91d7cf218.1721475357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721475357.git.tanggeliang@kylinos.cn>
References: <cover.1721475357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the public network helers client_socket() + make_sockaddr()
in sk_lookup.c to create the client socket, set the timeout sockopts, and
make the connecting address. The local defined function make_socket()
can be dropped then.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 61 ++++++-------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 9510a3f83787..88f2f9efeea5 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -47,8 +47,6 @@
 #define INT_IP6		"fd00::2"
 #define INT_PORT	8008
 
-#define IO_TIMEOUT_SEC	3
-
 enum server {
 	SERVER_A = 0,
 	SERVER_B = 1,
@@ -114,40 +112,6 @@ static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
 		addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) : 0);
 }
 
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
@@ -842,6 +806,7 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_lookup(const struct test *t)
 {
+	int family = is_ipv6(t->connect_to.ip) ? AF_INET6 : AF_INET;
 	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
@@ -856,11 +821,13 @@ static void drop_on_lookup(const struct test *t)
 	if (server_fd < 0)
 		goto detach;
 
-	client_fd = make_socket(t->sotype, t->connect_to.ip,
-				t->connect_to.port, &dst);
-	if (client_fd < 0)
+	client_fd = client_socket(family, t->sotype, NULL);
+	if (!ASSERT_OK_FD(client_fd, "client_socket"))
 		goto close_srv;
 
+	err = make_sockaddr(family, t->connect_to.ip, t->connect_to.port, &dst, NULL);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		goto close_all;
 	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
@@ -956,6 +923,7 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
+	int family = is_ipv6(t->connect_to.ip) ? AF_INET6 : AF_INET;
 	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
@@ -980,11 +948,13 @@ static void drop_on_reuseport(const struct test *t)
 	if (server2 < 0)
 		goto close_srv1;
 
-	client = make_socket(t->sotype, t->connect_to.ip,
-			     t->connect_to.port, &dst);
-	if (client < 0)
+	client = client_socket(family, t->sotype, NULL);
+	if (!ASSERT_OK_FD(client, "client_socket"))
 		goto close_srv2;
 
+	err = make_sockaddr(family, t->connect_to.ip, t->connect_to.port, &dst, NULL);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		goto close_all;
 	err = connect(client, (void *)&dst, inetaddr_len(&dst));
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
@@ -1228,10 +1198,13 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst);
-	if (client_fd < 0)
+	client_fd = client_socket(AF_INET, SOCK_STREAM, NULL);
+	if (!ASSERT_OK_FD(client_fd, "client_socket"))
 		goto out_close_server;
 
+	err = make_sockaddr(AF_INET, EXT_IP4, EXT_PORT, &dst, NULL);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		goto out_close_client;
 	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
-- 
2.43.0


