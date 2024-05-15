Return-Path: <linux-kselftest+bounces-10226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838138C5FB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50481C214E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B42E38DC8;
	Wed, 15 May 2024 04:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7cczszD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B77383A1;
	Wed, 15 May 2024 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746857; cv=none; b=iSqW5wH2d0QMV5q0OPFcOj9fsqMN0OtfMHbJtP1z9h9S3CH3H/L0/Rnr/LDGC8rM9yPNs50RnZjmuspfMvHt6Gk/rDfTuLgVynoBwv8mH0erY12OfgzcT5lH1qK6jS+Ap4HcJ0QY+5yqntle1ffdBIy38rR2GMpOG7PB49utLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746857; c=relaxed/simple;
	bh=HkzV+4jolSuOdg1n7+5S6ok0t8H/Yn2aEB0nuV0GCzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3AhJKCxu07CwjN2i23rNFdGwZLC529rKKBWgebmJfmOZtR4TA6eBrkhtKKweBu07bcAmfYKkFpbtlN/eLwfFSloTXIbHOW9AyirJwX+wTvFw11kpT6o47vvQZ0ogl7WJ8dOz6jJf1wX2nJYMgAOkg/mTJNyB6AIL+UjJW4a38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7cczszD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5548DC2BD11;
	Wed, 15 May 2024 04:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715746856;
	bh=HkzV+4jolSuOdg1n7+5S6ok0t8H/Yn2aEB0nuV0GCzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7cczszDnNut1F87MM3kpBysmmzZXIjhihUvIfzAw0WgB05VAqApk7EGGRfkVWj2U
	 htHOh36BRVbdANaeKW6/8gZKZbsC9F/BcFUH5col4qsyLH+cgRm43Ota3FbPYMoQLq
	 X666TjfLF90JdpWCDS+dqHYh+YeurUMDHqb1kClw8MZf2doz4DYp0awxziBQsdnvVW
	 Lbcz5tzYaOIKyVkE657E2O0trJkqJ5ICBY79QpuP9E/uIzDmKZdU0jDgdcyPPCyx/f
	 XGG3zqMXHFYhBK1BWtjrACaed8OaDugvHlexHyGRrwzByxceqP20QbKP9Kj0ATy0dd
	 FapbQuP0j9/5g==
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
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
Date: Wed, 15 May 2024 12:20:23 +0800
Message-ID: <c6c173dc814486cb3d3da5eadff38154c307f6e6.1715745588.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715745588.git.tanggeliang@kylinos.cn>
References: <cover.1715745588.git.tanggeliang@kylinos.cn>
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
index 25961ce850cb..7c9c79e35551 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -49,25 +49,9 @@ static void do_test(const struct network_helper_opts *opts,
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
@@ -120,11 +104,21 @@ static void test_cubic(void)
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
@@ -139,6 +133,7 @@ static void test_dctcp(void)
 		return;
 	}
 
+	opts.cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
 	do_test(&opts, dctcp_skel->maps.sk_stg_map);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
-- 
2.43.0


