Return-Path: <linux-kselftest+bounces-11763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B334905565
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B15283BE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DE117E8E1;
	Wed, 12 Jun 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9Cg2lpy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300317E46F;
	Wed, 12 Jun 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203281; cv=none; b=XXDeZbrWBKstdJdCVClrZQkf+dIjeUKB0iFVde+/K5AT3ukzOWSIPNk7HSVI6l6mctoeCzfZvzakqnZ+siX9DaFl3WB/YjYty3skSNJ4tb1KTNedeU57ccoHbWz0fVfnJN14WRQdaZztS8F4hPZ3NrWAlb5gTa2dVeYe9iqJtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203281; c=relaxed/simple;
	bh=t857AQ32+0WrHvy2BQlLRYPSgRi9WGUcKdJujyBKiaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cchkuo/hbVLVtcnQbmg+GjSn1JOKrWQtMRSp6mPBQeP5xB3Vs2RgMrjvp2qQnfPcix1M8PC3vyjQexygrEkda6IKJrTRrIB0QVmRP+2VG0pWFgaTf9ctg+n2AE2ArLkuz5btWnCICGnFgVVrxn2G5NlyXNs9fBQwTFpNnlK2ne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9Cg2lpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4F8C3277B;
	Wed, 12 Jun 2024 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718203281;
	bh=t857AQ32+0WrHvy2BQlLRYPSgRi9WGUcKdJujyBKiaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9Cg2lpyHELOnokC3FcHKoCrMhoLmjdf8g1aEVe62DkWwr1O2dEOG8QKNVXrSrZWT
	 ANvJsu6DA5HWTYzEZLOKrWG/HG5MV1GsJACTvlV6qBD4806Pybi/f5XPdmUX4HJRhh
	 GgKJwXEUlBPgYOZ+Xok7iRfsGmdrwog3243IfSDI3xOUMvHByknfBuefQiGzbnyWhW
	 2m2/8IkXzPZmuP4SRLCrzPULI89k6EQbBicIbYIjneal2bmA6BapR+BD1nLpITpslK
	 FSM4PFyZUX1ej9hiwu3c7OkKrHYfeSrzZgc1XcfS732fmpgMyUoLyGzVfsN/gmHqmQ
	 NCwD0SoCc5MOw==
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
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: Drop type from network_helper_opts
Date: Wed, 12 Jun 2024 22:41:03 +0800
Message-ID: <673f09dc8b8d25661ca21111e42b5790d2136dce.1718202986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718202986.git.tanggeliang@kylinos.cn>
References: <cover.1718202986.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The opts.{type, noconnect, must_fail} is at least a bit non intuitive or
unnecessary. The only use case now is in test_bpf_ip_check_defrag_ok which
ends up bypassing most (or at least some) of the connect_to_fd_opts()
logic. It's much better that test should have its own connect_to_fd_opts()
instead.

This patch adds a new "type" parameter for connect_to_fd_opts(), then
opts->type can be replaced by "type" parameter in it.

In test_bpf_ip_check_defrag_ok, different types are passed to it. And the
strcut member "type" of network_helper_opts can be dropped now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c         | 11 +++++------
 tools/testing/selftests/bpf/network_helpers.h         |  4 ++--
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c   |  2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c  |  4 ++--
 .../selftests/bpf/prog_tests/ip_check_defrag.c        |  5 ++---
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e20caef06aae..0e52105ae563 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -303,21 +303,20 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
-int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
+int connect_to_fd_opts(int server_fd, int type,
+		       const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
 	struct sockaddr_in *addr_in;
 	socklen_t addrlen, optlen;
-	int fd, type, protocol;
+	int fd, protocol;
 
 	if (!opts)
 		opts = &default_opts;
 
 	optlen = sizeof(type);
 
-	if (opts->type) {
-		type = opts->type;
-	} else {
+	if (!type) {
 		if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
 			log_err("getsockopt(SOL_TYPE)");
 			return -1;
@@ -370,7 +369,7 @@ int connect_to_fd(int server_fd, int timeout_ms)
 		.timeout_ms = timeout_ms,
 	};
 
-	return connect_to_fd_opts(server_fd, &opts);
+	return connect_to_fd_opts(server_fd, 0, &opts);
 }
 
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 11eea8e2e4f1..6b7e333d266b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,7 +25,6 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	bool noconnect;
-	int type;
 	int proto;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
@@ -61,7 +60,8 @@ void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
-int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
+int connect_to_fd_opts(int server_fd, int type,
+		       const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 		     int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 67358adf5db3..175ced753a52 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -49,7 +49,7 @@ static bool start_test(char *addr_str,
 		goto err;
 
 	/* connect to server */
-	*cli_fd = connect_to_fd_opts(*srv_fd, cli_opts);
+	*cli_fd = connect_to_fd_opts(*srv_fd, 0, cli_opts);
 	if (!ASSERT_NEQ(*cli_fd, -1, "connect_to_fd_opts"))
 		goto err;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index addf720428f7..1292ced67616 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -32,7 +32,7 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
 		goto out;
 	}
 
-	fd = connect_to_fd_opts(server_fd, &opts);
+	fd = connect_to_fd_opts(server_fd, 0, &opts);
 	if (fd < 0)
 		err = -1;
 	else
@@ -52,7 +52,7 @@ void test_cgroup_v1v2(void)
 	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
 	if (!ASSERT_GE(server_fd, 0, "server_fd"))
 		return;
-	client_fd = connect_to_fd_opts(server_fd, &opts);
+	client_fd = connect_to_fd_opts(server_fd, 0, &opts);
 	if (!ASSERT_GE(client_fd, 0, "client_fd")) {
 		close(server_fd);
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 284764e7179f..e46fc3ec0a40 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -164,7 +164,6 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	};
 	struct network_helper_opts tx_ops = {
 		.timeout_ms = 1000,
-		.type = SOCK_RAW,
 		.proto = IPPROTO_RAW,
 		.noconnect = true,
 	};
@@ -201,7 +200,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_tx_fd = connect_to_fd_opts(srv_fd, &tx_ops);
+	client_tx_fd = connect_to_fd_opts(srv_fd, SOCK_RAW, &tx_ops);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
 		goto out;
@@ -210,7 +209,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_rx_fd = connect_to_fd_opts(srv_fd, &rx_opts);
+	client_rx_fd = connect_to_fd_opts(srv_fd, 0, &rx_opts);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
 		goto out;
-- 
2.43.0


