Return-Path: <linux-kselftest+bounces-10093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB508C2F51
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 05:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F44E1C21CF7
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D485733CFC;
	Sat, 11 May 2024 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5XSOjzN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09D21A04;
	Sat, 11 May 2024 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397413; cv=none; b=txpAEjfqJCHT2HyOGwB1CM0FHvI017OltNdtv5SBY+Afno7zDmgChEpGwrhNSsshJoxRZUsrYshJU8vY55ZMGMUAa+SFhsIwPQJoOeps/Snr6HXGlVJpmT83FHdUPXY7/UIL+hETHSxZn5k+1UbLtKOQreEZMMBukAakAxGib5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397413; c=relaxed/simple;
	bh=mVxa3ZAgx8qoD/ZUT5ME2rgJsMq3QfeaJ05szvCjf7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxKPvxDDKcFgIbw32FCjmbgnFccuILj5h77leTCi+YweYXYsg+Bozfah86bRxV4BXnP09DzmCcM+7ZH0T6siklvAQYdD/d3AoD7EleNccEt13WsEqnkjOGfrOsBtzcCipmCpp5bIIRsXi1ebaM7AHTPKbECiuAOnAUfF9jL1xkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5XSOjzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCBAC113CC;
	Sat, 11 May 2024 03:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715397413;
	bh=mVxa3ZAgx8qoD/ZUT5ME2rgJsMq3QfeaJ05szvCjf7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5XSOjzNlP4h0qURWs93K4+yRGUJC+6gu6EPnXMgarMyJ81ov6GxI7XS9A0E1tyDF
	 S6k+sKhP7jniYBbqK7PhhlGOMwHw7iXgrYwB6+xQCUb2RL9ok3konJE5YgIgFDSiDC
	 V+c+IRchslM26cdAAO1cTGPsncHfq1eLS3Y8XP0sQM8Vabc0Z2Zci+b9nOnaKGx62p
	 okiVb9VroWkEagr2StcGPG1T4hlXYPWCwQUxCMoKWLET8FnlOm/cUeT+/nRNmcdtJ6
	 z2lanyqQgcq3is+mVLDIonLsgp32T+1DWaRbPjWCicdkaxf2XaQr2IzgpUziQzlY9u
	 WdcPjJ4PkHQLQ==
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
Subject: [PATCH bpf-next 2/4] selftests/bpf: Use start_server_addr in bpf_tcp_ca
Date: Sat, 11 May 2024 11:16:26 +0800
Message-ID: <eec9b0b6e0de12f6317318b38003bc2053840cc3.1715396405.git.tanggeliang@kylinos.cn>
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

This patch uses start_server_addr() in do_test() in prog_tests/bpf_tcp_ca.c
to accept a struct network_helper_opts argument instead of using
start_server() and settcpca(). Then change the type of the first paramenter
of do_test() into a struct network_helper_opts one.

Define its own opts for each test, set its own cc name into cb_opts.cc, and
cc_cb() into post_socket_cb callback, then pass it to do_test().

opts->cb_opts needs to be passed to post_socket_cb() in __start_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c |  2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 46 +++++++++++++++----
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index d97f8a669b38..6864af665508 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -94,7 +94,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (opts->post_socket_cb && opts->post_socket_cb(fd, NULL)) {
+	if (opts->post_socket_cb && opts->post_socket_cb(fd, &opts->cb_opts)) {
 		log_err("Failed to call post_socket_cb");
 		goto error_close;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 4eedc161b5b3..f50832b7838e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -33,12 +33,18 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
-static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
+static void do_test(const struct network_helper_opts *opts,
+		    const struct bpf_map *sk_stg_map)
 {
+	struct sockaddr_storage addr;
 	int lfd = -1, fd = -1;
+	socklen_t addrlen;
 	int err;
 
-	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (make_sockaddr(AF_INET6, NULL, 0, &addr, &addrlen))
+		return;
+
+	lfd = start_server_addr(SOCK_STREAM, &addr, addrlen, opts);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
@@ -48,7 +54,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 		return;
 	}
 
-	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca))
+	if (settcpca(fd, opts->cb_opts.cc))
 		goto done;
 
 	if (sk_stg_map) {
@@ -88,6 +94,10 @@ static int cc_cb(int fd, const struct post_socket_opts *opts)
 
 static void test_cubic(void)
 {
+	struct network_helper_opts opts = {
+		.cb_opts.cc = "bpf_cubic",
+		.post_socket_cb = cc_cb,
+	};
 	struct bpf_cubic *cubic_skel;
 	struct bpf_link *link;
 
@@ -101,7 +111,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test("bpf_cubic", NULL);
+	do_test(&opts, NULL);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -111,6 +121,10 @@ static void test_cubic(void)
 
 static void test_dctcp(void)
 {
+	struct network_helper_opts opts = {
+		.cb_opts.cc = "bpf_dctcp",
+		.post_socket_cb = cc_cb,
+	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link;
 
@@ -124,7 +138,7 @@ static void test_dctcp(void)
 		return;
 	}
 
-	do_test("bpf_dctcp", dctcp_skel->maps.sk_stg_map);
+	do_test(&opts, dctcp_skel->maps.sk_stg_map);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
@@ -303,6 +317,10 @@ static void test_unsupp_cong_op(void)
 
 static void test_update_ca(void)
 {
+	struct network_helper_opts opts = {
+		.cb_opts.cc = "tcp_ca_update",
+		.post_socket_cb = cc_cb,
+	};
 	struct tcp_ca_update *skel;
 	struct bpf_link *link;
 	int saved_ca1_cnt;
@@ -315,14 +333,14 @@ static void test_update_ca(void)
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
 
@@ -332,6 +350,10 @@ static void test_update_ca(void)
 
 static void test_update_wrong(void)
 {
+	struct network_helper_opts opts = {
+		.cb_opts.cc = "tcp_ca_update",
+		.post_socket_cb = cc_cb,
+	};
 	struct tcp_ca_update *skel;
 	struct bpf_link *link;
 	int saved_ca1_cnt;
@@ -344,14 +366,14 @@ static void test_update_wrong(void)
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
@@ -360,6 +382,10 @@ static void test_update_wrong(void)
 
 static void test_mixed_links(void)
 {
+	struct network_helper_opts opts = {
+		.cb_opts.cc = "tcp_ca_update",
+		.post_socket_cb = cc_cb,
+	};
 	struct tcp_ca_update *skel;
 	struct bpf_link *link, *link_nl;
 	int err;
@@ -374,7 +400,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test("tcp_ca_update", NULL);
+	do_test(&opts, NULL);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
-- 
2.43.0


