Return-Path: <linux-kselftest+bounces-10572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804938CBDC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36050280D3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC180C1C;
	Wed, 22 May 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILK+9PIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4052F7A;
	Wed, 22 May 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369870; cv=none; b=h/2XhxJDWezuxMhtFcGpSSJHRVRK2lu1C8QNGGfKxtuRztmGkmueCZc13JaAiStkVAr1dSBcnRLXU+H9iHcezf4i8S2JiEQ++izY7gpfUhzaGu8lDP2sApV9Q7ogOBAOFVDh1rrWczajjM4XdmtfsvMfnhpiy/Id32ufFpIhVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369870; c=relaxed/simple;
	bh=m3eJxMY93EofUeax/nDvC7+IU5f6NpmmZwJW3UpwAVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nP5bZHZyW5UW88OkilRUYqJ3sfaRRQ5YJMyOs6NA8TdIQC3LGWtarwQEPlDlpWjyIm0bfc+8DgMUXWa2PfCrLaTp6y1Z6mLAhPAePhfqFm66YAqYMpyQBPjj64CueKa/5ffaGkF/l1BfHxLaKvOEdejwYaTm6ohXITwGQB5be9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILK+9PIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB96C2BD11;
	Wed, 22 May 2024 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716369870;
	bh=m3eJxMY93EofUeax/nDvC7+IU5f6NpmmZwJW3UpwAVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILK+9PIByLOp2pojkNaqyBVjlB/pDaiP5HiKOBK59+tlNdBJRK9o/756J3mNZoivg
	 daOAHu5AvosEd7QwfAfwALhAC9AJxP49OR8P3f17hywEGUK4UW+n1kTEvbneBW+vXv
	 BWf2Xt4CUUu15NYZB9J3yVZmTf7+7szOyrVwSq2pS+EB/rp2kOfqG6HoYG42F7Oc1H
	 2uOIzAd1phJB4DFhS6VCmHh9wq0jdc1x2wIhhD79Lei34qpS93w7XyN/Sh/EpQg/wc
	 9aa+ohGpxjO/nDV7eYfSZKJHd1kfUp6yg4NWJtWO0Fttv0S3kERaOaJtQM0+YZ+kvm
	 460dB3H59xdFg==
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
Subject: [PATCH bpf-next v3 6/8] selftests/bpf: Use start_server_str in bpf_tcp_ca
Date: Wed, 22 May 2024 17:23:48 +0800
Message-ID: <f3ad0ebd5c09e6bbfc2381c5f8203686bfe30349.1716369375.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716369375.git.tanggeliang@kylinos.cn>
References: <cover.1716369375.git.tanggeliang@kylinos.cn>
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

opts->cb_opts needs to be passed to post_socket_cb() in __start_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c |  3 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 66 +++++++++++++++----
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6f80c0285464..fae4add78f4d 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -95,7 +95,8 @@ static int __start_server(const struct sockaddr *addr, socklen_t addrlen,
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (opts->post_socket_cb && opts->post_socket_cb(fd, NULL)) {
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, opts->cb_opts)) {
 		log_err("Failed to call post_socket_cb");
 		goto error_close;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index c9dd2a3d3218..d37364c5beac 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -38,12 +38,14 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
-static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
+static void do_test(const struct network_helper_opts *opts,
+		    const struct bpf_map *sk_stg_map)
 {
+	struct cb_opts *co = (struct cb_opts *)opts->cb_opts;
 	int lfd = -1, fd = -1;
 	int err;
 
-	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	lfd = start_server_str(AF_INET6, NULL, 0, opts);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
@@ -53,7 +55,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 		return;
 	}
 
-	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca))
+	if (settcpca(fd, co->cc))
 		goto done;
 
 	if (sk_stg_map) {
@@ -95,6 +97,13 @@ static int cc_cb(int fd, void *opts)
 
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
 
@@ -108,7 +117,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test("bpf_cubic", NULL);
+	do_test(&opts, NULL);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -118,6 +127,13 @@ static void test_cubic(void)
 
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
 
@@ -131,7 +147,7 @@ static void test_dctcp(void)
 		return;
 	}
 
-	do_test("bpf_dctcp", dctcp_skel->maps.sk_stg_map);
+	do_test(&opts, dctcp_skel->maps.sk_stg_map);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
@@ -313,6 +329,13 @@ static void test_unsupp_cong_op(void)
 
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
@@ -325,14 +348,14 @@ static void test_update_ca(void)
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
 
@@ -342,6 +365,13 @@ static void test_update_ca(void)
 
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
@@ -354,14 +384,14 @@ static void test_update_wrong(void)
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
@@ -370,6 +400,13 @@ static void test_update_wrong(void)
 
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
@@ -384,7 +421,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test("tcp_ca_update", NULL);
+	do_test(&opts, NULL);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
@@ -471,6 +508,13 @@ static void test_tcp_ca_kfunc(void)
 
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
 
@@ -484,7 +528,7 @@ static void test_cc_cubic(void)
 		return;
 	}
 
-	do_test("bpf_cc_cubic", NULL);
+	do_test(&opts, NULL);
 
 	bpf_link__destroy(link);
 	bpf_cc_cubic__destroy(cc_cubic_skel);
-- 
2.43.0


