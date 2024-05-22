Return-Path: <linux-kselftest+bounces-10568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D08CBDBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 11:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD291C220C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7763580BF8;
	Wed, 22 May 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnPGESlu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9980BE5;
	Wed, 22 May 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369852; cv=none; b=NpBoznD6UZx9rX+YFKEpxw5T0ofs8rATZ3OKaHehtERKEt2aPvnJFREAxVCMujfNQguxUerGGhqE7eDMFJzwGZVVfcgRr2/ZjJVwLyhxESaCZP7X50NiCTiTdr5Il182zz7ZlwaN+DaNj3jNMwyV3k6xeSTe3Tk+hSsqIHrIspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369852; c=relaxed/simple;
	bh=aw4b+dSxu58yXyiIl+8w1U5H7G3nx61BwulciyQj4jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rufBy1jzM2DpO5SMBa/D/n1rxzGjv+0Ti/2GRiwnSaZ6DTame3s9iHcuy54QU/+1VB68JtIdgIQoL6NH7qy/qrPlZm8NtzPBf1b8ToeGPaPk4dy7+7gVbDJwua7rPjbeHKXA7Hsg7VK879sHiVpNdp3yClThqf+wT7WREZQ09aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnPGESlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F176DC32781;
	Wed, 22 May 2024 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716369852;
	bh=aw4b+dSxu58yXyiIl+8w1U5H7G3nx61BwulciyQj4jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnPGESlux6DZLdL0FXxG+5amQAxZRApbI/sAIu5KAhe4oJE8rH0dBn4bZzjPd00EH
	 gyU0h6Okj/OtVf/71pWikgqYzYeu4eisQPri3gtoRR1MGt5329R4NMU5gFskmIftHP
	 UYYD77rrwwWAqLNvo4crlfFla72DtjzV9LVfk0VhWrVoHf6kWaJr3F0Uj8VYyuU3Qr
	 PGO68EVTxTg6Qx7/SqFMmINxy53ihwh99yxw48/gU6CdMLyjypiTNc54tt/wCXEBzr
	 HPMbsBw9/89PeJKtQKSDbNr/XXXLd41mXjueoWVbUJOz4Ispg04F+QT0BJqdWaquaT
	 lXLGH7bYlOtmA==
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
Subject: [PATCH bpf-next v3 2/8] selftests/bpf: Drop type parameter of start_server_addr
Date: Wed, 22 May 2024 17:23:44 +0800
Message-ID: <65dd42dd91d678740e9c05e32852f5e01ba2b7bc.1716369375.git.tanggeliang@kylinos.cn>
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
to drop the "type" parameter of start_server_addr() and __start_server()
helpers, using opts->type instead in the helpers.

If no network_helper_opts is set, use SOCK_STREAM as default socket type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c     | 15 +++++++++------
 tools/testing/selftests/bpf/network_helpers.h     |  2 +-
 .../selftests/bpf/prog_tests/cls_redirect.c       |  5 ++++-
 tools/testing/selftests/bpf/prog_tests/mptcp.c    |  2 +-
 .../testing/selftests/bpf/prog_tests/sk_assign.c  |  8 +++++---
 .../selftests/bpf/prog_tests/sockopt_inherit.c    |  2 +-
 .../selftests/bpf/test_tcp_check_syncookie_user.c |  6 +++---
 7 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 4d776b78929c..129ac90e4528 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -80,9 +80,10 @@ int settimeo(int fd, int timeout_ms)
 
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
-static int __start_server(int type, const struct sockaddr *addr, socklen_t addrlen,
+static int __start_server(const struct sockaddr *addr, socklen_t addrlen,
 			  const struct network_helper_opts *opts)
 {
+	int type = opts->type ? : SOCK_STREAM;
 	int fd;
 
 	fd = socket(addr->sa_family, type, opts->proto);
@@ -122,6 +123,7 @@ int start_server(int family, int type, const char *addr_str, __u16 port,
 		 int timeout_ms)
 {
 	struct network_helper_opts opts = {
+		.type		= type,
 		.timeout_ms	= timeout_ms,
 	};
 	struct sockaddr_storage addr;
@@ -130,7 +132,7 @@ int start_server(int family, int type, const char *addr_str, __u16 port,
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
 
-	return __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+	return __start_server((struct sockaddr *)&addr, addrlen, &opts);
 }
 
 static int reuseport_cb(int fd, void *opts)
@@ -144,6 +146,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms, unsigned int nr_listens)
 {
 	struct network_helper_opts opts = {
+		.type = type,
 		.timeout_ms = timeout_ms,
 		.post_socket_cb = reuseport_cb,
 	};
@@ -162,7 +165,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	if (!fds)
 		return NULL;
 
-	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+	fds[0] = __start_server((struct sockaddr *)&addr, addrlen, &opts);
 	if (fds[0] == -1)
 		goto close_fds;
 	nr_fds = 1;
@@ -171,7 +174,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 		goto close_fds;
 
 	for (; nr_fds < nr_listens; nr_fds++) {
-		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+		fds[nr_fds] = __start_server((struct sockaddr *)&addr, addrlen, &opts);
 		if (fds[nr_fds] == -1)
 			goto close_fds;
 	}
@@ -183,13 +186,13 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	return NULL;
 }
 
-int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
+int start_server_addr(const struct sockaddr_storage *addr, socklen_t len,
 		      const struct network_helper_opts *opts)
 {
 	if (!opts)
 		opts = &default_opts;
 
-	return __start_server(type, (struct sockaddr *)addr, len, opts);
+	return __start_server((struct sockaddr *)addr, len, opts);
 }
 
 void free_fds(int *fds, unsigned int nr_close_fds)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 40011e0f584b..9de84a8d00fd 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -53,7 +53,7 @@ int start_server(int family, int type, const char *addr, __u16 port,
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
-int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
+int start_server_addr(const struct sockaddr_storage *addr, socklen_t len,
 		      const struct network_helper_opts *opts);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 34b59f6baca1..53b81651a6fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -62,11 +62,14 @@ static bool fill_addr_port(const struct sockaddr *sa, struct addr_port *ap)
 static bool set_up_conn(const struct sockaddr *addr, socklen_t len, int type,
 			int *server, int *conn, struct tuple *tuple)
 {
+	struct network_helper_opts opts = {
+		.type = type,
+	};
 	struct sockaddr_storage ss;
 	socklen_t slen = sizeof(ss);
 	struct sockaddr *sa = (struct sockaddr *)&ss;
 
-	*server = start_server_addr(type, (struct sockaddr_storage *)addr, len, NULL);
+	*server = start_server_addr((struct sockaddr_storage *)addr, len, &opts);
 	if (*server < 0)
 		return false;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4472aa404da0..eff1adf8cbc9 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -110,7 +110,7 @@ static int start_mptcp_server(int family, const char *addr_str, __u16 port,
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
 
-	return start_server_addr(SOCK_STREAM, &addr, addrlen, &opts);
+	return start_server_addr(&addr, addrlen, &opts);
 }
 
 static int verify_tsk(int map_fd, int client_fd)
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 0b9bd1d6f7cc..517d1186e386 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -255,6 +255,9 @@ void test_sk_assign(void)
 
 	for (i = 0; i < ARRAY_SIZE(tests) && !READ_ONCE(stop); i++) {
 		struct test_sk_cfg *test = &tests[i];
+		struct network_helper_opts opts = {
+			.type = test->type,
+		};
 		const struct sockaddr *addr;
 		const int zero = 0;
 		int err;
@@ -263,9 +266,8 @@ void test_sk_assign(void)
 			continue;
 		prepare_addr(test->addr, test->family, BIND_PORT, false);
 		addr = (const struct sockaddr *)test->addr;
-		server = start_server_addr(test->type,
-					   (const struct sockaddr_storage *)addr,
-					   test->len, NULL);
+		server = start_server_addr((const struct sockaddr_storage *)addr,
+					   test->len, &opts);
 		if (server == -1)
 			goto close;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 7cd8be2780ca..d2b2e0924bc4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -121,7 +121,7 @@ static void run_test(int cgroup_fd)
 	if (!ASSERT_OK_PTR(link_setsockopt, "cg-attach-setsockopt"))
 		goto close_bpf_object;
 
-	server_fd = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr,
+	server_fd = start_server_addr((struct sockaddr_storage *)&addr,
 				      sizeof(addr), &opts);
 	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto close_bpf_object;
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index aebc58c24dc5..6265f44ae3a4 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -197,19 +197,19 @@ int main(int argc, char **argv)
 	addr6dual.sin6_addr = in6addr_any;
 	addr6dual.sin6_port = 0;
 
-	server = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr4,
+	server = start_server_addr((struct sockaddr_storage *)&addr4,
 				   sizeof(addr4), NULL);
 	if (server == -1)
 		goto err;
 
 	opts.post_socket_cb = v6only_true;
-	server_v6 = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6,
+	server_v6 = start_server_addr((struct sockaddr_storage *)&addr6,
 				      sizeof(addr6), &opts);
 	if (server_v6 == -1)
 		goto err;
 
 	opts.post_socket_cb = v6only_false;
-	server_dual = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6dual,
+	server_dual = start_server_addr((struct sockaddr_storage *)&addr6dual,
 					sizeof(addr6dual), &opts);
 	if (server_dual == -1)
 		goto err;
-- 
2.43.0


