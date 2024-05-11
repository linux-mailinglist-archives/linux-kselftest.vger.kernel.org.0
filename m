Return-Path: <linux-kselftest+bounces-10094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24388C2F53
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 05:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E1283574
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028F38382;
	Sat, 11 May 2024 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFip1oKn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9D24B5B;
	Sat, 11 May 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397421; cv=none; b=D+gO1NcoPSExQ2ovRL0fise4nUsji57P+hedhfNA964qBB0bU8wUSQyospasqmrzSQs003ObsvZp7ASJd/LrRFx/A3ijCDlueLrM+tGUfgBHzkSHgDkV0y6FVoewB+U+4drfIgjoqLbWqgFQQdhP1UWtLKFVcP0XM9nxcvuP4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397421; c=relaxed/simple;
	bh=0vxgv25QFjc3cMV5VMfE90vkRVesX+DuyKQNxuqx5EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRRrhJ5JBx1Rz5rRZwpyoKErWakPUsHB+GIy9peAh7WKn7Wh9zwlGM7SBGyHhy9kcVn0VFytlKcCxN3sfeO3Uy0NEzDCkLcmj96FJKz32ZfLnQhlUlLYgb/YQpBNl2P/vfnD+Au0OobRwpyiaDjavC0LtTBdQiOC1ZfqnrmjkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFip1oKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E4C113CC;
	Sat, 11 May 2024 03:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715397420;
	bh=0vxgv25QFjc3cMV5VMfE90vkRVesX+DuyKQNxuqx5EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFip1oKnOl745yjEiGegO8P/nYgGsUsnqvXluXZp2ozNvZ+Zm7hZ04SlA9rje7y9E
	 Iw7TmDl71jib7U3TVBN5HIEBIUjEqPX2f50iUjzufqY9iSR4ew2OOlDYSV7R6otEsj
	 D3UUGvuLMzDc2ee3E5OqLAuPvJUmLkVhQ9uRiQluUKApeLAq/szkvBbP9QjFIipd2m
	 NIsUHolnhKd+p6ICO01TqQGrnY2ZZtdaZwiqanX/ibyMqCQsgl1xS8AGwx9AFH/yMA
	 yXQbj9ieCAIohs3l0THqbfDNEtHPWlK/UfOkhtWfMVp7rmKo14mDrlCuz3chD5szdv
	 sW2c2fheTPTUg==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
Date: Sat, 11 May 2024 11:16:27 +0800
Message-ID: <983d40625775a3f330df5ad556ec2eba931ee51a.1715396405.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715396405.git.tanggeliang@kylinos.cn>
References: <cover.1715396405.git.tanggeliang@kylinos.cn>
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
member map_fd is added in struct post_socket_opts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 33 ++++++++-----------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index e44a6e5d8344..62dd40095cf2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -23,6 +23,7 @@ typedef __u16 __sum16;
 
 struct post_socket_opts {
 	const char *cc;
+	int map_fd;
 };
 
 struct network_helper_opts {
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index f50832b7838e..bca30c32b819 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -48,25 +48,9 @@ static void do_test(const struct network_helper_opts *opts,
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (!ASSERT_NEQ(fd, -1, "socket")) {
-		close(lfd);
-		return;
-	}
-
-	if (settcpca(fd, opts->cb_opts.cc))
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
@@ -119,11 +103,21 @@ static void test_cubic(void)
 	bpf_cubic__destroy(cubic_skel);
 }
 
+static int stg_post_socket_cb(int fd, const struct post_socket_opts *opts)
+{
+	int err;
+
+	err = cc_cb(fd, opts);
+	if (err)
+		return err;
+	return bpf_map_update_elem(opts->map_fd, &fd, &expected_stg, BPF_NOEXIST);
+}
+
 static void test_dctcp(void)
 {
 	struct network_helper_opts opts = {
 		.cb_opts.cc = "bpf_dctcp",
-		.post_socket_cb = cc_cb,
+		.post_socket_cb = stg_post_socket_cb,
 	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link;
@@ -138,6 +132,7 @@ static void test_dctcp(void)
 		return;
 	}
 
+	opts.cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
 	do_test(&opts, dctcp_skel->maps.sk_stg_map);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
-- 
2.43.0


