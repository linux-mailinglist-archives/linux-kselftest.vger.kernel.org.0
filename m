Return-Path: <linux-kselftest+bounces-13867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9529347FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 08:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F07A1C21941
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 06:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A157CB4;
	Thu, 18 Jul 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJEWNc0d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280E26ACF;
	Thu, 18 Jul 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283796; cv=none; b=tkwCNCCZxW3Om2ovqdV3ogrFpDkxfkwpl3AM+VpPSjuYLNWlhXHoUoEjvnGbWrK7tJ9g1IUkYEYn/KgkqI/2rl9laiiP4B3Ub/gHzf8UjCju4NzRe1HyTAZA9IGukQo+WSSvmjF6++mDLHrUbqElu7qz2QlfwcaXHJ3OvPq7xGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283796; c=relaxed/simple;
	bh=jQxuy3jS5q4uYp2ek18QbkEdKwp0RfC9loCP6oGS0uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPflSNOYLbgC9tol67D2brEuRGqbksoUpxqxxokcNlnb3WjJTjrNf4LM+2oA1D+Re0oemI/7HmGnkcpEOOP2hzlnIpCUJky0yKLZMoLVOV2BbyiBPshdt9VwNWU4MAvPm/agac6wIJ01XB3pipkfhrr44VbC1d9Odv2E6TxV34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJEWNc0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4A1C4AF0C;
	Thu, 18 Jul 2024 06:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721283796;
	bh=jQxuy3jS5q4uYp2ek18QbkEdKwp0RfC9loCP6oGS0uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJEWNc0dSQjnvHDoONZeYwK7gfFWwYArizOj44jc10sqPlU92xqpOt/fdJoH3WiRL
	 ki6VMiTQ50ulCPfpbB8wjV909CtBBJJhgPRXNNM1AynydcOnSpQQuLReco0mCriYnE
	 h4z1Xr5EqL94M9tj1ReRPmV+ih2priF/C0pHKAkpaLK+uNRee/P6EDIjmXllp1JOa4
	 bd8KvYBWA/YHd4LQwd6luS2Q4LJwmXRqP9oNXjuCFjYd3Gm1LeKUVpaLEV4Kc+kPML
	 a9YIdl2zX+FlFI2+5VEFxSVqMSp2763BV0qMIvQywUCBMQ6S5d/9GmnpkvMvJdT8rI
	 /PGIZgrzoX0cg==
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
	linux-kselftest@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/5] selftests/bpf: Drop type of connect_to_fd_opts
Date: Thu, 18 Jul 2024 14:22:29 +0800
Message-ID: <50d8ce7ab7ab0c0f4d211fc7cc4ebe3d3f63424c.1721282219.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721282219.git.tanggeliang@kylinos.cn>
References: <cover.1721282219.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The "type" parameter of connect_to_fd_opts() is redundant of "server_fd".
Since the "type" can be obtained inside by invoking getsockopt(SO_TYPE),
without passing it in as a parameter.

This patch drops the "type" parameter of connect_to_fd_opts() and updates
its callers.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 21 ++++++++++---------
 tools/testing/selftests/bpf/network_helpers.h |  2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |  4 ++--
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e0cba4178e41..15e0e0bb7553 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -328,14 +328,21 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
-int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts)
+int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
-	socklen_t addrlen;
+	socklen_t addrlen, optlen;
+	int type;
 
 	if (!opts)
 		opts = &default_opts;
 
+	optlen = sizeof(type);
+	if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
+		log_err("getsockopt(SOL_TYPE)");
+		return -1;
+	}
+
 	addrlen = sizeof(addr);
 	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
 		log_err("Failed to get server addr");
@@ -350,14 +357,8 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	struct network_helper_opts opts = {
 		.timeout_ms = timeout_ms,
 	};
-	int type, protocol;
 	socklen_t optlen;
-
-	optlen = sizeof(type);
-	if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
-		log_err("getsockopt(SOL_TYPE)");
-		return -1;
-	}
+	int protocol;
 
 	optlen = sizeof(protocol);
 	if (getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen)) {
@@ -366,7 +367,7 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	}
 	opts.proto = protocol;
 
-	return connect_to_fd_opts(server_fd, type, &opts);
+	return connect_to_fd_opts(server_fd, &opts);
 }
 
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index aac5b94d6379..5b548c0c60de 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -71,7 +71,7 @@ int client_socket(int family, int type,
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
-int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts);
+int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 		     int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 63422f4f3896..1d494b4453f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -49,7 +49,7 @@ static bool start_test(char *addr_str,
 		goto err;
 
 	/* connect to server */
-	*cli_fd = connect_to_fd_opts(*srv_fd, SOCK_STREAM, cli_opts);
+	*cli_fd = connect_to_fd_opts(*srv_fd, cli_opts);
 	if (!ASSERT_NEQ(*cli_fd, -1, "connect_to_fd_opts"))
 		goto err;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index 9709c8db7275..addf720428f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -32,7 +32,7 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
 		goto out;
 	}
 
-	fd = connect_to_fd_opts(server_fd, SOCK_STREAM, &opts);
+	fd = connect_to_fd_opts(server_fd, &opts);
 	if (fd < 0)
 		err = -1;
 	else
@@ -52,7 +52,7 @@ void test_cgroup_v1v2(void)
 	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
 	if (!ASSERT_GE(server_fd, 0, "server_fd"))
 		return;
-	client_fd = connect_to_fd_opts(server_fd, SOCK_STREAM, &opts);
+	client_fd = connect_to_fd_opts(server_fd, &opts);
 	if (!ASSERT_GE(client_fd, 0, "client_fd")) {
 		close(server_fd);
 		return;
-- 
2.43.0


