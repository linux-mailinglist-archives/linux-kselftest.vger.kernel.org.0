Return-Path: <linux-kselftest+bounces-10695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380428CEED7
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82B41F21577
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527542072;
	Sat, 25 May 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfC3oGaU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E540847;
	Sat, 25 May 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638933; cv=none; b=eDqFO2QYWxriBjTvdDNUMRd3iGIWGbhKOj4woQK8uhE2waZ0WJujtqfWLv7GPbk++t3kkibDZ1SPKSHN01x23kPjswtzVqlrHI0ofjyXodJ8b8H2MZE1mab5ZqClarPfNKvcLoMNFhIn41OpvY8lkFXG1Pe5S/YLKYqJ5mWC/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638933; c=relaxed/simple;
	bh=EtxyYSK83NhyzeEAez981bC5nUgC2AJ4WLsWfneVf/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhP6zkD70JMyKZ5HLSTxxQP2uBevrcQRmWY2CS3FmdkEqzvgYeoi5nD6yLz6qvX3PdqfiuDeA8d/tf3supi9L8xMSsmTPkCf4FqPbDxtoh0BdIjYkJ2Q16qh9TMEOm+j2BFFIjJ7L1P4nvgM1K7tqjXS2wwW/9z2BLDKSj2VJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfC3oGaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6CBC32789;
	Sat, 25 May 2024 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638933;
	bh=EtxyYSK83NhyzeEAez981bC5nUgC2AJ4WLsWfneVf/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfC3oGaUXnbcQivOu6fH6vtY1wEtGTBHgA2hlaaCoryPbB2QILYuJQeLfgNfdiPJM
	 wFxhH3WEn9xGi0OO/KeNiP1y/t+mDiNqpRvmP5TFwvW0tcBudq9u3ZRB7yPRdzCgEt
	 nqmwFYUkwyRFYqTqUvboNsZDIQRzsUcJElN6NolSCvcmGRugG15bE5yGeeYnw1bCn7
	 7Wrew+KRoToT/aTtm3VTdA5N8USjMi3tBrkxcbHZIv8f98KRKZR+cDoU1ld8g1ddQ1
	 cvMXGOfp2duAJ3BpZlb1anwoUNTGokQfWJAeTiD3BCPwt9wa3u+n3i2ukwlmZ+Vq5H
	 u4+Hx9N2Qqagg==
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
Subject: [PATCH bpf-next v5 5/7] selftests/bpf: Use start_server_str in do_test in bpf_tcp_ca
Date: Sat, 25 May 2024 20:08:19 +0800
Message-ID: <6e1b6555e3284e77c8aa60668c61a66c5f99aa37.1716638248.git.tanggeliang@kylinos.cn>
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

This patch uses new helper start_server_str() in do_test() in bpf_tcp_ca.c
to accept a struct network_helper_opts argument instead of using
start_server() and settcpca(). Then change the type of the first paramenter
of do_test() into a struct network_helper_opts one.

Define its own cb_opts and opts for each test, set its own cc name into
cb_opts.cc, and cc_cb() into post_socket_cb callback, then pass it to
do_test().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 66 +++++++++++++++----
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 7a523c7a0c6a..ebc7d4616880 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -38,12 +38,14 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
-static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
+static void do_test(const struct network_helper_opts *opts,
+		    const struct bpf_map *sk_stg_map)
 {
+	struct cb_opts *cb_opts = (struct cb_opts *)opts->cb_opts;
 	int lfd = -1, fd = -1;
 	int err;
 
-	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	lfd = start_server_str(AF_INET6, SOCK_STREAM, NULL, 0, opts);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
@@ -53,7 +55,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 		return;
 	}
 
-	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca))
+	if (settcpca(fd, cb_opts->cc))
 		goto done;
 
 	if (sk_stg_map) {
@@ -94,6 +96,13 @@ static int cc_cb(int fd, void *opts)
 
 static void test_cubic(void)
 {
+	struct cb_opts cb_opts = {
+		.cc = "bpf_cubic",
+	};
+	struct network_helper_opts opts = {
+		.post_socket_cb	= cc_cb,
+		.cb_opts	= &cb_opts,
+	};
 	struct bpf_cubic *cubic_skel;
 	struct bpf_link *link;
 
@@ -107,7 +116,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test("bpf_cubic", NULL);
+	do_test(&opts, NULL);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -117,6 +126,13 @@ static void test_cubic(void)
 
 static void test_dctcp(void)
 {
+	struct cb_opts cb_opts = {
+		.cc = "bpf_dctcp",
+	};
+	struct network_helper_opts opts = {
+		.post_socket_cb	= cc_cb,
+		.cb_opts	= &cb_opts,
+	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link;
 
@@ -130,7 +146,7 @@ static void test_dctcp(void)
 		return;
 	}
 
-	do_test("bpf_dctcp", dctcp_skel->maps.sk_stg_map);
+	do_test(&opts, dctcp_skel->maps.sk_stg_map);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
@@ -315,6 +331,13 @@ static void test_unsupp_cong_op(void)
 
 static void test_update_ca(void)
 {
+	struct cb_opts cb_opts = {
+		.cc = "tcp_ca_update",
+	};
+	struct network_helper_opts opts = {
+		.post_socket_cb	= cc_cb,
+		.cb_opts	= &cb_opts,
+	};
 	struct tcp_ca_update *skel;
 	struct bpf_link *link;
 	int saved_ca1_cnt;
@@ -327,14 +350,14 @@ static void test_update_ca(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test("tcp_ca_update", NULL);
+	do_test(&opts, NULL);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
 	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_update_2);
 	ASSERT_OK(err, "update_map");
 
-	do_test("tcp_ca_update", NULL);
+	do_test(&opts, NULL);
 	ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
 
@@ -344,6 +367,13 @@ static void test_update_ca(void)
 
 static void test_update_wrong(void)
 {
+	struct cb_opts cb_opts = {
+		.cc = "tcp_ca_update",
+	};
+	struct network_helper_opts opts = {
+		.post_socket_cb	= cc_cb,
+		.cb_opts	= &cb_opts,
+	};
 	struct tcp_ca_update *skel;
 	struct bpf_link *link;
 	int saved_ca1_cnt;
@@ -356,14 +386,14 @@ static void test_update_wrong(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test("tcp_ca_update", NULL);
+	do_test(&opts, NULL);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
 	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_wrong);
 	ASSERT_ERR(err, "update_map");
 
-	do_test("tcp_ca_update", NULL);
+	do_test(&opts, NULL);
 	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 
 	bpf_link__destroy(link);
@@ -372,6 +402,13 @@ static void test_update_wrong(void)
 
 static void test_mixed_links(void)
 {
+	struct cb_opts cb_opts = {
+		.cc = "tcp_ca_update",
+	};
+	struct network_helper_opts opts = {
+		.post_socket_cb	= cc_cb,
+		.cb_opts	= &cb_opts,
+	};
 	struct tcp_ca_update *skel;
 	struct bpf_link *link, *link_nl;
 	int err;
@@ -386,7 +423,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test("tcp_ca_update", NULL);
+	do_test(&opts, NULL);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
@@ -473,6 +510,13 @@ static void test_tcp_ca_kfunc(void)
 
 static void test_cc_cubic(void)
 {
+	struct cb_opts cb_opts = {
+		.cc = "bpf_cc_cubic",
+	};
+	struct network_helper_opts opts = {
+		.post_socket_cb	= cc_cb,
+		.cb_opts	= &cb_opts,
+	};
 	struct bpf_cc_cubic *cc_cubic_skel;
 	struct bpf_link *link;
 
@@ -486,7 +530,7 @@ static void test_cc_cubic(void)
 		return;
 	}
 
-	do_test("bpf_cc_cubic", NULL);
+	do_test(&opts, NULL);
 
 	bpf_link__destroy(link);
 	bpf_cc_cubic__destroy(cc_cubic_skel);
-- 
2.43.0


