Return-Path: <linux-kselftest+bounces-10901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082AC8D463A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35781F21EED
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7854D8BB;
	Thu, 30 May 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzQAmxOk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797C4D8A0;
	Thu, 30 May 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054897; cv=none; b=arGEF2XQ7lwjNY4fFRhDn0XE82uSz8UVYWkZTaJ6WqDdoC8pXJjAF3qU9xGLLkDRXrKiPrUl083KkjeRikRrYTyKVs3kMtNUD7ViM0W+4nW/Y49A4gZOkDWDytaDCNypWOYzBhiaYtrXGp2CB+vB6gk2k5ufRZPUJVEh/x6vzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054897; c=relaxed/simple;
	bh=BgsQtSOrjFmCzmohu12UWx7OxLVMZC6IWrQE+vtEJAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMwS66jH4//mpqgb/2F7GQpwDkLvaKCq0Be6NGaiCk89CBC9/a6y4uCQeKE7xxa0GtjjlKFJV3lFJNMsJxiWKF7GPuk1tKu6XOGnLM3M8F4Mtx1mAx7HiZUwkKRonV4D04nn7pqEFUsEQsn1l0dqqOaOAv+PbXx5Ojf2YPoPDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzQAmxOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298DFC32789;
	Thu, 30 May 2024 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717054897;
	bh=BgsQtSOrjFmCzmohu12UWx7OxLVMZC6IWrQE+vtEJAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzQAmxOklPHgUURvBzgp+aVtRilluMtKAOMOYMVB+Y+9ZD/P1tlrOjFT5XAgLP/aE
	 xlnNtrVIfL3eL5D5p2TF0AoiIP8JDfRjJp+9ElY7AgbkBhW7RnJo2krCPhCCStTq1M
	 bVvr2M1I3DspxGxEyZRbfIdjFlU1fsxGmORttkii7SkfcBkUFg84fJqmixuDkSZbYF
	 vbN9DLCJIQYnJp9zjxIVvnb4XFWbMMxKmnID9ACnzxM8z+Op5YUxr4Fmk2SEjM8mW1
	 PANDhqMa8PK99ep72dLG5SgZOm4wkIqyQJ6CX1aRNGwRXvfaS25Aj8xyZalb+L92Re
	 z4ZFwrA5YwGaQ==
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
Subject: [PATCH bpf-next 2/5] selftests/bpf: Add start_test helper in bpf_tcp_ca
Date: Thu, 30 May 2024 15:41:09 +0800
Message-ID: <48f2921ff9be958f5d3d28fe6bb7269a61cafa9f.1717054461.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1717054461.git.tanggeliang@kylinos.cn>
References: <cover.1717054461.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

For moving the "if (sk_stg_map)" block out of do_test(), extract the
code before this block as a new function start_test(). It creates
server-side and client-side sockets and returns them to the caller.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 42 +++++++++++++++----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 2f9d373feb0a..794651ce0629 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -39,6 +39,34 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
+static bool start_test(char *addr_str,
+		       const struct network_helper_opts *srv_opts,
+		       const struct network_helper_opts *cli_opts,
+		       int *srv_fd, int *cli_fd)
+{
+	*srv_fd = start_server_str(AF_INET6, SOCK_STREAM, addr_str, 0, srv_opts);
+	if (!ASSERT_NEQ(*srv_fd, -1, "start_server_str"))
+		goto err;
+
+	/* connect to server */
+	*cli_fd = connect_to_fd_opts(*srv_fd, cli_opts);
+	if (!ASSERT_NEQ(*cli_fd, -1, "connect_to_fd_opts"))
+		goto err;
+
+	return true;
+
+err:
+	if (*srv_fd != -1) {
+		close(*srv_fd);
+		*srv_fd = -1;
+	}
+	if (*cli_fd != -1) {
+		close(*cli_fd);
+		*cli_fd = -1;
+	}
+	return false;
+}
+
 static void do_test(const struct network_helper_opts *opts,
 		    const struct network_helper_opts *cli_opts,
 		    const struct bpf_map *sk_stg_map)
@@ -46,13 +74,7 @@ static void do_test(const struct network_helper_opts *opts,
 	int lfd = -1, fd = -1;
 	int err;
 
-	lfd = start_server_str(AF_INET6, SOCK_STREAM, NULL, 0, opts);
-	if (!ASSERT_NEQ(lfd, -1, "socket"))
-		return;
-
-	/* connect to server */
-	fd = connect_to_fd_opts(lfd, cli_opts);
-	if (!ASSERT_NEQ(fd, -1, "connect_to_fd_opts"))
+	if (!start_test(NULL, opts, cli_opts, &lfd, &fd))
 		goto done;
 
 	if (sk_stg_map) {
@@ -68,8 +90,10 @@ static void do_test(const struct network_helper_opts *opts,
 	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
 
 done:
-	close(lfd);
-	close(fd);
+	if (lfd != -1)
+		close(lfd);
+	if (fd != -1)
+		close(fd);
 }
 
 static int cc_cb(int fd, void *opts)
-- 
2.43.0


