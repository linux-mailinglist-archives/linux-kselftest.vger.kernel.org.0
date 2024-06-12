Return-Path: <linux-kselftest+bounces-11764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9E905568
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66536B211A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8517E8E0;
	Wed, 12 Jun 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRp158UH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3417DE39;
	Wed, 12 Jun 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203287; cv=none; b=hVopSYRctZRCudon0Fp3EKw1UHystcdu/FG8vACdylyWMdinTzzX4rBNZzR+/8u91GpyHflc9mhlAZwyc45lzcZfNynAKiXRRrQCXVzVX2cRPyIz3u2oI5UXWTBY8M//UGdYdmsn1CiaTx0qRBX6bksb/VqDXDlFQtZhPgblfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203287; c=relaxed/simple;
	bh=mLbZtJt5FvZqk6vpvI8dwKyF0qLGlC/FKOoK0PJI6AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czisg0a0/m32bS9R9IhI6sO4L4CrzLEKkA4TLSstxAHa0w2dhbcT9VZktvrOBfXjXdaDrBgIyDE7ZYuYQtBjEpkkZ13/QHFvuS7xejFa4cVBYOL0r6mmxwlYT+kiqsa0M23aYxJ5S+aYI9WERhVeoQnUV5Yf7CfbnzcZAW7d8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRp158UH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07D6C116B1;
	Wed, 12 Jun 2024 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718203286;
	bh=mLbZtJt5FvZqk6vpvI8dwKyF0qLGlC/FKOoK0PJI6AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRp158UHNl759dXivCzTOI56zlJaPM9rX4JY4V2XrzzbL3gWigDbwAtHGopTraKfM
	 vYeodHitVYbj56cDtYawyPTxgKHxALtBUKKVBgw1kOwzqfqlNP7igfDj7kSZ50yzPn
	 fuxiR6dTxFdqpqgwXXPqsPqVVv2xTxcaopBpsHRgQRh23SaJk4PdrW4y3CUiIV41mQ
	 0JySJjTbDW+1IylqzLfBqFWfkAw1Cl4Alzr30LHvYx/q2FuKPgIw+/SQsYmMV3WGrY
	 vC5R61rvUEB7IVKUY8+1Q9yCIiKFpC6xeH0lSN9+u0XtAGWkrgAMU62mJH6z13snIY
	 Z6hxM2vr2jifQ==
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
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Drop noconnect from network_helper_opts
Date: Wed, 12 Jun 2024 22:41:04 +0800
Message-ID: <f6480e76b220f64a8310d2c4fed951778a770d46.1718202986.git.tanggeliang@kylinos.cn>
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

This patch extracts a new helper start_client() from connect_to_fd_opts()
to create the client socket, but don't connect to the server. Then
connect_to_fd_opts() can be implemented using start_client() and
connect_fd_to_addr().

In test_bpf_ip_check_defrag_ok(), the new helper can be used to replace
connect_to_fd_opts() with "noconnect" opts, and the strcut member
"noconnect" of network_helper_opts can be dropped now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 38 ++++++++++++++++---
 tools/testing/selftests/bpf/network_helpers.h |  3 +-
 .../bpf/prog_tests/ip_check_defrag.c          |  6 +--
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 0e52105ae563..8736b564939a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -303,8 +303,8 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
-int connect_to_fd_opts(int server_fd, int type,
-		       const struct network_helper_opts *opts)
+int start_client(int server_fd, int type,
+		 const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
 	struct sockaddr_in *addr_in;
@@ -352,9 +352,37 @@ int connect_to_fd_opts(int server_fd, int type,
 	    opts->post_socket_cb(fd, opts->cb_opts))
 		goto error_close;
 
-	if (!opts->noconnect)
-		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
-			goto error_close;
+	return fd;
+
+error_close:
+	save_errno_close(fd);
+	return -1;
+}
+
+int connect_to_fd_opts(int server_fd, int type,
+		       const struct network_helper_opts *opts)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
+	int fd;
+
+	if (!opts)
+		opts = &default_opts;
+
+	addrlen = sizeof(addr);
+	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
+		log_err("Failed to get server addr");
+		return -1;
+	}
+
+	fd = start_client(server_fd, type, opts);
+	if (fd < 0) {
+		log_err("Failed to create client socket");
+		return -1;
+	}
+
+	if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
+		goto error_close;
 
 	return fd;
 
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 6b7e333d266b..bb5465ad79a9 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -24,7 +24,6 @@ typedef __u16 __sum16;
 struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
-	bool noconnect;
 	int proto;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
@@ -60,6 +59,8 @@ void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
+int start_client(int server_fd, int type,
+		 const struct network_helper_opts *opts);
 int connect_to_fd_opts(int server_fd, int type,
 		       const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index e46fc3ec0a40..3ec8fdf5c4f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -160,12 +160,10 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 {
 	struct network_helper_opts rx_opts = {
 		.timeout_ms = 1000,
-		.noconnect = true,
 	};
 	struct network_helper_opts tx_ops = {
 		.timeout_ms = 1000,
 		.proto = IPPROTO_RAW,
-		.noconnect = true,
 	};
 	struct sockaddr_storage caddr;
 	struct ip_check_defrag *skel;
@@ -200,7 +198,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_tx_fd = connect_to_fd_opts(srv_fd, SOCK_RAW, &tx_ops);
+	client_tx_fd = start_client(srv_fd, SOCK_RAW, &tx_ops);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
 		goto out;
@@ -209,7 +207,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_rx_fd = connect_to_fd_opts(srv_fd, 0, &rx_opts);
+	client_rx_fd = start_client(srv_fd, 0, &rx_opts);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
 		goto out;
-- 
2.43.0


