Return-Path: <linux-kselftest+bounces-10649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8338CDFB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 05:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E4AB2128C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F34F12E4A;
	Fri, 24 May 2024 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce8XiSpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149CD1BF53;
	Fri, 24 May 2024 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520973; cv=none; b=D2GJrmcNPPVqE/UOif0RqeXuNCsrpyhLHdzHJ47v/5Q31sMbbVNXVAEao2tROdJmytgdk9pbBfH48xzrmTjuIwwU3cNEmBfytKqj2/9QBJwqXA+257d42YQPUUkk/4YYykpWtjtUWYnMCmhfuvOdcoubGbuDbC1zZOqHwR3a4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520973; c=relaxed/simple;
	bh=4gFrJjn73No2Tb27jEAkn6v78eXxc4YltjWezwMOPYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9FExzigrXSFREVby1/qY06ChTUgaLQZZDPtL3NtFv/JIX9LkxKk1EhvQuZ+H2EhhihChRJFEVvJebsg1dat/9VDj4qFkOsVKCbuLsh+ty0zxw5QxGXvwXE+yFjVvOnzw93WFaxxRQdD8PbibOMFJZa/lMqXfRpwAHy13pFt3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce8XiSpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01501C2BD10;
	Fri, 24 May 2024 03:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520972;
	bh=4gFrJjn73No2Tb27jEAkn6v78eXxc4YltjWezwMOPYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ce8XiSpedDhL3WFPT35xoSjTPAohi3UuM5q3U9qezsRP+NUCx0qFesF7z59SKCNmG
	 1jxegRI7ZjZORehjXi68YpwDpQrc1QrkrZR+W6mUItrHO1v8CwV3OPtX/snzacqKlr
	 AjR6jDEuIkmFnGkXCsjL8SKGAX8JoNeVf5CLAUxnR93Q6/0sZbmUP4/cHODIWF9CWJ
	 K2T4PaBicLGEP3oBpBzQYZWP88m/ZsS07lKnUVphEU+xUEd+gpRGh9YLoOAi4P2DDs
	 op+2wvxyYsbZDg1Rc2rudrIg2vVUd0PR9Uc2wxkv7SN5KjAlAq+d0bC4nf/OMMz7oM
	 02fkbgX4Wg9wQ==
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
Subject: [PATCH bpf-next v4 4/6] selftests/bpf: Use start_server_str in bpf_tcp_ca
Date: Fri, 24 May 2024 11:21:52 +0800
Message-ID: <7c462740879edc7356608e392a1a7b736af82bbd.1716520609.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716520609.git.tanggeliang@kylinos.cn>
References: <cover.1716520609.git.tanggeliang@kylinos.cn>
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
index c9dd2a3d3218..123fcd5a0af6 100644
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
+	lfd = start_server_str(AF_INET6, SOCK_STREAM, NULL, 0, opts);
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


