Return-Path: <linux-kselftest+bounces-13281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A78929428
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1446282898
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004C13AA27;
	Sat,  6 Jul 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJrG/kMv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994413A88D;
	Sat,  6 Jul 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277233; cv=none; b=NgeOj5HlrTUP8NtPS1VME1MsXznSO0AKk9nFD+5bwK6bpr1ZTj0ajWN1K5PICffAEFqk+dL3FpWrSIW5IPdB8MrApQ0BBxT8ZorqUNase+jF9kAEhKiCvce14/CsHjAMQZTU4G65+h6TBaHahqAuybeBLlt7FFOXF+LFqEYm5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277233; c=relaxed/simple;
	bh=HmXOdU8AvXotdcvvc/YDpHs6DrXYIXQa6FQSAA6yhPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/EPA9U15fCGV0xwNhnnlxk0tAgkcbU+nS15chUYvWb+Q4351RcKv/rEBUZGHBfH+SJ89Ajhq8bi89teGHyOAikn0+bjwT+TILLJlXm+HayxA4Iz1qyA7DZrX3mQnK6AYxJoVeBOBtbQ2I+q3D62wzd+MUwJmEEDcCXQj2wOSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJrG/kMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCEEC3277B;
	Sat,  6 Jul 2024 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720277232;
	bh=HmXOdU8AvXotdcvvc/YDpHs6DrXYIXQa6FQSAA6yhPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJrG/kMvLKdxbp+KCk1dcjowGWZWVIpg+JYTiCx0/r1zSKmZ9vId/KsCS4DiO1UJu
	 z2qWqYutpdjcZS7P23R1QPLvPfEeOuo/+S2MOatbPG3/LXvA61u1Jlc2ExG3ZPdLDn
	 bCYEWZEpX24d7eQjq8/kYFTk9n6Zeutk8olJT35onVZlrZqyViHkKX+R/pFGqwZI3u
	 mFysBNsMl30+2v36ueGQ7s+JXQflTVuOYzU8vWb8/M0e19hHSNkehchGhUUIkbvM1g
	 osgxZvN4LfC/lu5Fmp9GV9jMmf+w8IyVkLpRhvT8CHj2ahbcV0Q4ujP2MMjZ9wlnS0
	 2r543GU3oDrKw==
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
Subject: [PATCH bpf-next v9 05/11] selftests/bpf: Add network_helper_opts for connect_fd_to_fd
Date: Sat,  6 Jul 2024 22:45:50 +0800
Message-ID: <7b0985069599970cb45187a1590670372ed1579b.1720276189.git.tanggeliang@kylinos.cn>
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


