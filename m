Return-Path: <linux-kselftest+bounces-10569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5EA8CBDBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1BA1F231EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350880C02;
	Wed, 22 May 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWtPhZv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B280628;
	Wed, 22 May 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369857; cv=none; b=eQd0aXGma30eGqTE/kNhZY1ioKhcjoeft4N1wqsdJEBMG+NjWvDcmFFyjJGTVVqe0bKtmpn9DB0Kh7//8eRmqbM6IkC+VpSrH8+cp+60hTfG7RiAdlciQJ2mnZeO7jBilmwObXMWXeVMF6++E7+t29YOLu8/6MrsneXwLxBxvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369857; c=relaxed/simple;
	bh=S/fDyRS/qFaLSf3W47dPHYaUIN1UVdtWS1DjVLUGGMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKl2SaODwCbRkt/4aAI9uYClBEoI2Nbxi4mYXfH/tyFUrnk5atRL1NGjf0p7FQBXFIRG3z69FMW8ICrJyYbUxBWm0Kb1hTejDGhe8gp1Dl/LyL0C8vl/t+SAxmoSVePzIfnxxEBozfTAWk1uRDyT1sVXhxgm2J/UjU2ZLnoSnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWtPhZv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B62C4AF07;
	Wed, 22 May 2024 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716369856;
	bh=S/fDyRS/qFaLSf3W47dPHYaUIN1UVdtWS1DjVLUGGMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWtPhZv5JE/bfXW0sE2/pzyAhpejRLf6vl73zBka2PhqwFup7001S8apU2reQ555H
	 FsaDpBI41SRbGxksVml2UrfIEmpq1OL5moSMXLDqhhfqbPzb2HSQ0Y4UNdctP25e/b
	 wMgooEWDllXapfPrDPGDHEEWLHQemGR8eUEhIEbVRM6d7ymVEDYjjD/EgHKDGNNVdC
	 L2G+eAp019q0YEdd6Pu/+Ec2S0fNTgF7FuaKthuotx1N091ibsVlKIWvA0l+GYaseK
	 BsVfSRs6b0Df7zc+Wb/aEEL+kEjvuFIcEttMP4fwMNli6UwCkQ/lakihyaVRT//6CV
	 0q1HSDm0aCT8Q==
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
Subject: [PATCH bpf-next v3 3/8] selftests/bpf: Drop type parameter of connect_to_addr
Date: Wed, 22 May 2024 17:23:45 +0800
Message-ID: <3a0ac6ce2cfd09df244dff1766af57861bc7598c.1716369375.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716369375.git.tanggeliang@kylinos.cn>
References: <cover.1716369375.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since "type" is a struct member of network_helper_opts, it makes sense
to drop the "type" parameter of connect_to_addr() helper, using opts->type
instead in this helper.

If no network_helper_opts is set, use SOCK_STREAM as default socket type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c |  4 ++--
 tools/testing/selftests/bpf/network_helpers.h |  2 +-
 .../selftests/bpf/prog_tests/cls_redirect.c   |  2 +-
 .../selftests/bpf/prog_tests/sk_assign.c      |  5 +++-
 .../selftests/bpf/prog_tests/sock_addr.c      | 23 ++++++++++++-------
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 129ac90e4528..49e807ffcccb 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -268,7 +268,7 @@ static int connect_fd_to_addr(int fd,
 	return 0;
 }
 
-int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
+int connect_to_addr(const struct sockaddr_storage *addr, socklen_t addrlen,
 		    const struct network_helper_opts *opts)
 {
 	int fd;
@@ -276,7 +276,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	if (!opts)
 		opts = &default_opts;
 
-	fd = socket(addr->ss_family, type, opts->proto);
+	fd = socket(addr->ss_family, opts->type ? : SOCK_STREAM, opts->proto);
 	if (fd < 0) {
 		log_err("Failed to create client socket");
 		return -1;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9de84a8d00fd..c925c771bd98 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -56,7 +56,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 int start_server_addr(const struct sockaddr_storage *addr, socklen_t len,
 		      const struct network_helper_opts *opts);
 void free_fds(int *fds, unsigned int nr_close_fds);
-int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
+int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 53b81651a6fa..1f1b9f0c2ffc 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -76,7 +76,7 @@ static bool set_up_conn(const struct sockaddr *addr, socklen_t len, int type,
 	if (CHECK_FAIL(getsockname(*server, sa, &slen)))
 		goto close_server;
 
-	*conn = connect_to_addr(type, (struct sockaddr_storage *)sa, slen, NULL);
+	*conn = connect_to_addr((struct sockaddr_storage *)sa, slen, &opts);
 	if (*conn < 0)
 		goto close_server;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 517d1186e386..91f65b407f3a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -109,12 +109,15 @@ rcv_msg(int srv_client, int type)
 static int
 run_test(int server_fd, const struct sockaddr *addr, socklen_t len, int type)
 {
+	struct network_helper_opts opts = {
+		.type = type,
+	};
 	int client = -1, srv_client = -1;
 	char buf[] = "testing";
 	in_port_t port;
 	int ret = 1;
 
-	client = connect_to_addr(type, (struct sockaddr_storage *)addr, len, NULL);
+	client = connect_to_addr((struct sockaddr_storage *)addr, len, &opts);
 	if (client == -1) {
 		perror("Cannot connect to server");
 		goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index b880c564a204..244686d582cb 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -224,12 +224,12 @@ static int kernel_getpeername(int fd, struct sockaddr *addr, socklen_t *addrlen)
 	return sock_addr_op("kernel_getpeername", addr, addrlen, true);
 }
 
-int kernel_connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
+int kernel_connect_to_addr(const struct sockaddr_storage *addr, socklen_t addrlen,
 			   const struct network_helper_opts *opts)
 {
 	int err;
 
-	if (!ASSERT_OK(kernel_init_sock(addr->ss_family, type, 0),
+	if (!ASSERT_OK(kernel_init_sock(addr->ss_family, opts->type, 0),
 		       "kernel_init_sock"))
 		goto err;
 
@@ -278,7 +278,7 @@ int kernel_start_server(int family, int type, const char *addr_str, __u16 port,
 }
 
 struct sock_ops {
-	int (*connect_to_addr)(int type, const struct sockaddr_storage *addr,
+	int (*connect_to_addr)(const struct sockaddr_storage *addr,
 			       socklen_t addrlen,
 			       const struct network_helper_opts *opts);
 	int (*start_server)(int family, int type, const char *addr_str,
@@ -2284,6 +2284,9 @@ static int test_bind(struct sock_addr_test *test)
 {
 	struct sockaddr_storage expected_addr;
 	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
+	struct network_helper_opts opts = {
+		.type = test->socket_type,
+	};
 	int serv = -1, client = -1, err;
 
 	serv = test->ops->start_server(test->socket_family, test->socket_type,
@@ -2306,7 +2309,7 @@ static int test_bind(struct sock_addr_test *test)
 		goto cleanup;
 
 	/* Try to connect to server just in case */
-	client = connect_to_addr(test->socket_type, &expected_addr, expected_addr_len, NULL);
+	client = connect_to_addr(&expected_addr, expected_addr_len, &opts);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -2327,6 +2330,9 @@ static int test_connect(struct sock_addr_test *test)
 	socklen_t addr_len = sizeof(struct sockaddr_storage),
 		  expected_addr_len = sizeof(struct sockaddr_storage),
 		  expected_src_addr_len = sizeof(struct sockaddr_storage);
+	struct network_helper_opts opts = {
+		.type = test->socket_type,
+	};
 	int serv = -1, client = -1, err;
 
 	serv = start_server(test->socket_family, test->socket_type,
@@ -2339,8 +2345,7 @@ static int test_connect(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = test->ops->connect_to_addr(test->socket_type, &addr, addr_len,
-					    NULL);
+	client = test->ops->connect_to_addr(&addr, addr_len, &opts);
 	if (client < 0) {
 		err = errno;
 		goto err;
@@ -2519,6 +2524,9 @@ static int test_getpeername(struct sock_addr_test *test)
 	struct sockaddr_storage addr, expected_addr;
 	socklen_t addr_len = sizeof(struct sockaddr_storage),
 		  expected_addr_len = sizeof(struct sockaddr_storage);
+	struct network_helper_opts opts = {
+		.type = test->socket_type,
+	};
 	int serv = -1, client = -1, err;
 
 	serv = start_server(test->socket_family, test->socket_type,
@@ -2531,8 +2539,7 @@ static int test_getpeername(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = test->ops->connect_to_addr(test->socket_type, &addr, addr_len,
-					    NULL);
+	client = test->ops->connect_to_addr(&addr, addr_len, &opts);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
-- 
2.43.0


