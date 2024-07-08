Return-Path: <linux-kselftest+bounces-13297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07585929AD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1487281190
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAC9184F;
	Mon,  8 Jul 2024 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKSfc0HJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998FA94B;
	Mon,  8 Jul 2024 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405839; cv=none; b=t4yvWxgYPnZcp2hQrpuFBVVSDGuaaKYVo4SecFLqjbbZbNGW4jttwvgFwh2ojYK4TLVJr2+jgKYH2EasmzOdmLwBDyT+WxcCuc0f5fDFweNBByztylSRUeczlYA5JwOv/esFdQQeKLtCrxKJDPpSRPVWvQE2lNEwLXIKzbFR610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405839; c=relaxed/simple;
	bh=HmXOdU8AvXotdcvvc/YDpHs6DrXYIXQa6FQSAA6yhPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sra1CMgvNviuX8RFkR9snyXBLJ2fGbcbnsIIQ088rnN9mvgjxL8KEjm71F0q9lq9MgvqWSLtFdS68f1cs5900c0p0bnAx+VQP3adBW7dqSqVpagjbFdaqj7MVARIpiAhpCSQQd2EBZEJdxiRIx3byENo7PunXjyxrXRulNWMlzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKSfc0HJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DDEC4AF0E;
	Mon,  8 Jul 2024 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405838;
	bh=HmXOdU8AvXotdcvvc/YDpHs6DrXYIXQa6FQSAA6yhPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKSfc0HJbse2jIutHgAXtSdK4C7nRYgL7SfD9/vgbfFxCfqtkAlfwkGYmGklL2I2V
	 /EdLTb/ETyHvpV25UKiyBhGTns+obkaBsMM+6x7R4XVQB96sZcjZ6lrf+TtRpuWG1j
	 OWTU/rDniDlAbwxIQ8UCHr/I5CLHmgh1osNJi91NHsMfCaryeXTCHByK3u9urtHPvT
	 KdacFkIYEsQF+DnbRF+0PhwUhLeEtRO+x1VSHsXDsJNhf+wVdYQV+ohSs9gy/q0Bua
	 TK9sPB0j1SD5SBV93Mx5pLIE7A6V8IyEUsK6yEDvkCT06/fjPdDQH1ZWxNwOEBagqj
	 4PLdJq/6eDFMQ==
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
Subject: [PATCH bpf-next v10 05/12] selftests/bpf: Add network_helper_opts for connect_fd_to_fd
Date: Mon,  8 Jul 2024 10:29:43 +0800
Message-ID: <efd3cd03b3eceb3173bc5cf70267ff831a281bd1.1720405046.git.tanggeliang@kylinos.cn>
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

To make connect_fd_to_fd() more flexible, use a struct network_helper_opts
parameter "opts" instead of timeout_ms. With this change, other opts like
"must_fail" can be used in connect_fd_to_fd() too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c          | 10 +++++++---
 tools/testing/selftests/bpf/network_helpers.h          |  3 ++-
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c        |  5 ++++-
 .../selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c    |  5 ++++-
 .../testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c  |  4 ++--
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e0cba4178e41..475a5a04e61e 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -369,12 +369,16 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	return connect_to_fd_opts(server_fd, type, &opts);
 }
 
-int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
+int connect_fd_to_fd(int client_fd, int server_fd,
+		     const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
 
-	if (settimeo(client_fd, timeout_ms))
+	if (!opts)
+		opts = &default_opts;
+
+	if (settimeo(client_fd, opts->timeout_ms))
 		return -1;
 
 	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
@@ -382,7 +386,7 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
 		return -1;
 	}
 
-	if (connect_fd_to_addr(client_fd, &addr, len, false))
+	if (connect_fd_to_addr(client_fd, &addr, len, opts->must_fail))
 		return -1;
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 4f26bfc2dbf5..fcda6b2333ad 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -66,7 +66,8 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts);
-int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
+int connect_fd_to_fd(int client_fd, int server_fd,
+		     const struct network_helper_opts *opts);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 		     int timeout_ms);
 int make_sockaddr(int family, const char *addr_str, __u16 port,
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index a4a1f93878d4..cd4dce5bd7f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -33,13 +33,16 @@ enum {
 
 static int connect_to_server(int srv_fd)
 {
+	struct network_helper_opts opts = {
+		.timeout_ms = TIMEOUT_MS,
+	};
 	int fd = -1;
 
 	fd = socket(AF_INET, SOCK_STREAM, 0);
 	if (!ASSERT_GE(fd, 0, "socket"))
 		goto out;
 
-	if (!ASSERT_EQ(connect_fd_to_fd(fd, srv_fd, TIMEOUT_MS), 0, "connect_fd_to_fd")) {
+	if (!ASSERT_EQ(connect_fd_to_fd(fd, srv_fd, &opts), 0, "connect_fd_to_fd")) {
 		close(fd);
 		fd = -1;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
index b9dc4ec655b5..bcf142779cc6 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
@@ -8,6 +8,9 @@
 
 static void run_lookup_test(__u16 *g_serv_port, int out_sk)
 {
+	struct network_helper_opts opts = {
+		.timeout_ms	= 1000,
+	};
 	int serv_sk = -1, in_sk = -1, serv_in_sk = -1, err;
 	struct sockaddr_in6 addr = {};
 	socklen_t addr_len = sizeof(addr);
@@ -24,7 +27,7 @@ static void run_lookup_test(__u16 *g_serv_port, int out_sk)
 	*g_serv_port = addr.sin6_port;
 
 	/* Client outside of test cgroup should fail to connect by timeout. */
-	err = connect_fd_to_fd(out_sk, serv_sk, 1000);
+	err = connect_fd_to_fd(out_sk, serv_sk, &opts);
 	if (CHECK(!err || errno != EINPROGRESS, "connect_fd_to_fd",
 		  "unexpected result err %d errno %d\n", err, errno))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
index a1542faf7873..f35a9897db24 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
@@ -86,7 +86,7 @@ static int talk_to_cgroup(int *client_fd, int *listen_fd, int *service_fd,
 	skel->bss->g_sock_port = ntohs(port);
 
 	/* Connect client to server */
-	err = connect_fd_to_fd(*client_fd, *listen_fd, 0);
+	err = connect_fd_to_fd(*client_fd, *listen_fd, NULL);
 	if (!ASSERT_OK(err, "connect_fd_to_fd"))
 		return -1;
 	*service_fd = accept(*listen_fd, NULL, NULL);
@@ -136,7 +136,7 @@ static int talk_to_outside(int *client_fd, int *listen_fd, int *service_fd,
 	skel->bss->g_sock_port = ntohs(port);
 
 	/* Connect client to server */
-	err = connect_fd_to_fd(*client_fd, *listen_fd, 0);
+	err = connect_fd_to_fd(*client_fd, *listen_fd, NULL);
 	if (!ASSERT_OK(err, "connect_fd_to_fd"))
 		return -1;
 	*service_fd = accept(*listen_fd, NULL, NULL);
-- 
2.43.0


