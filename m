Return-Path: <linux-kselftest+bounces-10694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F68CEED5
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72CCB2105C
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B5041C65;
	Sat, 25 May 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr7qE+ZI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5C18044;
	Sat, 25 May 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638929; cv=none; b=A/Y2aLpSlJtXZ8IKUuJ/vG34sNshUtvhSCL+hh5hQBHkDmE09vkAmtoXqPw5bjr7Omp2R1BdUDdaeViBD1jkIkq8jHM1s/+v9qI/Ih1E9Aolh3KxzGmbTLnb23B/SjDZGI+NQ7sxfLYNcEynAMAzO/yBXc1EGPIJK2CV85KBRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638929; c=relaxed/simple;
	bh=NjhjhJNshQw1hqZI+zM9sQqjX08SVQvguj3u4AqOLQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFiv47irtWYeAfyL+p7jx/4Xxs20pb1LHDIDPfMoRdWwdUnoQjOPIQYCCRgydOft/nWKhk0rzkRqZNmsST4APtZ7qCcnDAnlfAV+VmlExrCJygNblKBYtOZAjhbo/niOlRNjqt8B1Y7bZUHYr9X6Iyr5wq2gFXnZMG5SOJa5J6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr7qE+ZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB3EC3277B;
	Sat, 25 May 2024 12:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638928;
	bh=NjhjhJNshQw1hqZI+zM9sQqjX08SVQvguj3u4AqOLQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mr7qE+ZIIjqXUW8KessRhLp5nLmIBUCAWl0hVzNeyQHzvYYmzM/96jndrKQ4TWxIf
	 cYbLY0NtgXr8uS5PZ1BY0ycPW3BRAngMrgFPW525G5YTwQWpdIN2Z6G3h6cYBaAT1j
	 jan2ALpA3mQ4MYZ/H1bEzzc++0Xkd7EnxmywshpcVEt0yCSJizzFOvu93VoNl7DnA/
	 xuskAebYxinr7/h13hMAukjHZb6D/0X0FAjrou0miTt1SrqHWcsWY1Y9eS88YEgLAy
	 +9qofMBaRfjKt59MZhI7NPM9G8RvGXkQ+nK6+n/DLieHDgoPIw6T6BhhTlruvZBNRs
	 ieP/u8eNyo4HQ==
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
Subject: [PATCH bpf-next v5 4/7] selftests/bpf: Use post_socket_cb in start_server_str
Date: Sat, 25 May 2024 20:08:18 +0800
Message-ID: <414c749321fa150435f7fe8e12c80fec8b447c78.1716638248.git.tanggeliang@kylinos.cn>
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

This patch uses start_server_str() helper in test_dctcp_fallback() in
bpf_tcp_ca.c, instead of using start_server() and settcpca(). For
support opts in start_server_str() helper, opts->cb_opts needs to be
passed to post_socket_cb() in __start_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c       | 3 ++-
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 8502917b6c7b..e20caef06aae 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -94,7 +94,8 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (opts->post_socket_cb && opts->post_socket_cb(fd, NULL)) {
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, opts->cb_opts)) {
 		log_err("Failed to call post_socket_cb");
 		goto error_close;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 6f034059888a..7a523c7a0c6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -187,6 +187,9 @@ static void test_dctcp_fallback(void)
 	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link = NULL;
+	struct cb_opts dctcp = {
+		.cc = "bpf_dctcp",
+	};
 	struct cb_opts cubic = {
 		.cc = "cubic",
 	};
@@ -204,9 +207,9 @@ static void test_dctcp_fallback(void)
 	if (!ASSERT_OK_PTR(link, "dctcp link"))
 		goto done;
 
-	lfd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
-	if (!ASSERT_GE(lfd, 0, "lfd") ||
-	    !ASSERT_OK(settcpca(lfd, "bpf_dctcp"), "lfd=>bpf_dctcp"))
+	opts.cb_opts = &dctcp;
+	lfd = start_server_str(AF_INET6, SOCK_STREAM, "::1", 0, &opts);
+	if (!ASSERT_GE(lfd, 0, "lfd"))
 		goto done;
 
 	opts.cb_opts = &cubic;
-- 
2.43.0


