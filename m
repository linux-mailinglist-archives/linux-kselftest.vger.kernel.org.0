Return-Path: <linux-kselftest+bounces-10696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF478CEED9
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8B1C209B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447A43687;
	Sat, 25 May 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYu3Fpl+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B840847;
	Sat, 25 May 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638938; cv=none; b=udGGZwlMaEnryb9bxzy1Q9KqBYIpDF+TmyaBNOYAviTyWPcxuk7iDllvnM6ORnSlNTkzrdKYjFj2oUB5mkR2P6rpHngQyJjwWgzmG26YbMCuCEqEF1SVvclfvq258jlNoqdnL46BF6QPl4wFvzU2rPUMkU12BC0hyizSVqFkQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638938; c=relaxed/simple;
	bh=Qf86i3oXSIEJ67dO1n7U88T7pZ+CuJwy0+8D6xSAk7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9nrsPym884oXqgOmeXvTepBxEMlZQpk3UAXbyIW31P2yL4JJB1FU1Xm2n5cwYsqkS6v1FVv0YMQXpO10Jkm9M1NjKatSACsSuiqYRlLVT56L0cYgttw/zCPcJpbAQf9kUUjimRialsoV5GyOLcVlNLwxii+FxatWY2B6JG+y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYu3Fpl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F1EC2BD11;
	Sat, 25 May 2024 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638937;
	bh=Qf86i3oXSIEJ67dO1n7U88T7pZ+CuJwy0+8D6xSAk7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYu3Fpl+5Hc2WXlADvCLb1xy1XmX3sdseZEnFtNC0K+AQnJ+m4MAhvOXRzVjgPXOf
	 QtqUXM+JvXRsbfnuOPtCoHw8Rw8DCs5UIyD1aknrNQCVUrH+SBzqHAFwfpDI6u0AMg
	 9OwpHf5oEwbG8rfpHgPyEDGbZFMQtNs03vUiuitEf8x6nUJLmKyj7YyULLGVgLwW+5
	 FUiBdgLSO39W8Hdb5klYy81iW7EsxCPcsDPYZEwJXaGKMpLhqkGxiUEWyy2d+pviL7
	 uk/BTQ4T6dNPN6m7wMHpy6sG4t9aR+WuXKVcx4KIqlWBqsUNxfEqkZM8WmcrfNpekZ
	 uEF1YOCMvYsDQ==
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
Subject: [PATCH bpf-next v5 6/7] selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
Date: Sat, 25 May 2024 20:08:20 +0800
Message-ID: <bd55a421ab8e8b8bce4658840bc028d9aa6965c5.1716638248.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716638248.git.tanggeliang@kylinos.cn>
References: <cover.1716638248.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses connect_to_fd_opts() instead of using connect_fd_to_fd()
and settcpca() in do_test() in prog_tests/bpf_tcp_ca.c to accept a struct
network_helper_opts argument.

Then define a dctcp dedicated post_socket_cb callback stg_post_socket_cb(),
invoking both cc_cb() and bpf_map_update_elem() in it, and set it in
test_dctcp(). For passing map_fd into stg_post_socket_cb() callback, a new
member map_fd is added in struct cb_opts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 42 ++++++++++---------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index ebc7d4616880..9a7c3dc39008 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -25,6 +25,7 @@ static int expected_stg = 0xeB9F;
 
 struct cb_opts {
 	const char *cc;
+	int map_fd;
 };
 
 static int settcpca(int fd, const char *tcp_ca)
@@ -41,7 +42,6 @@ static int settcpca(int fd, const char *tcp_ca)
 static void do_test(const struct network_helper_opts *opts,
 		    const struct bpf_map *sk_stg_map)
 {
-	struct cb_opts *cb_opts = (struct cb_opts *)opts->cb_opts;
 	int lfd = -1, fd = -1;
 	int err;
 
@@ -49,25 +49,9 @@ static void do_test(const struct network_helper_opts *opts,
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (!ASSERT_NEQ(fd, -1, "socket")) {
-		close(lfd);
-		return;
-	}
-
-	if (settcpca(fd, cb_opts->cc))
-		goto done;
-
-	if (sk_stg_map) {
-		err = bpf_map_update_elem(bpf_map__fd(sk_stg_map), &fd,
-					  &expected_stg, BPF_NOEXIST);
-		if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
-			goto done;
-	}
-
 	/* connect to server */
-	err = connect_fd_to_fd(fd, lfd, 0);
-	if (!ASSERT_NEQ(err, -1, "connect"))
+	fd = connect_to_fd_opts(lfd, opts);
+	if (!ASSERT_NEQ(fd, -1, "connect_to_fd_opts"))
 		goto done;
 
 	if (sk_stg_map) {
@@ -124,13 +108,30 @@ static void test_cubic(void)
 	bpf_cubic__destroy(cubic_skel);
 }
 
+static int stg_post_socket_cb(int fd, void *opts)
+{
+	struct cb_opts *cb_opts = (struct cb_opts *)opts;
+	int err;
+
+	err = settcpca(fd, cb_opts->cc);
+	if (err)
+		return err;
+
+	err = bpf_map_update_elem(cb_opts->map_fd, &fd,
+				  &expected_stg, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
+		return err;
+
+	return 0;
+}
+
 static void test_dctcp(void)
 {
 	struct cb_opts cb_opts = {
 		.cc = "bpf_dctcp",
 	};
 	struct network_helper_opts opts = {
-		.post_socket_cb	= cc_cb,
+		.post_socket_cb	= stg_post_socket_cb,
 		.cb_opts	= &cb_opts,
 	};
 	struct bpf_dctcp *dctcp_skel;
@@ -146,6 +147,7 @@ static void test_dctcp(void)
 		return;
 	}
 
+	cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
 	do_test(&opts, dctcp_skel->maps.sk_stg_map);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
-- 
2.43.0


