Return-Path: <linux-kselftest+bounces-10227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297C8C5FB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA12A282FDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66DB38DCD;
	Wed, 15 May 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsylV6p6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8443838A;
	Wed, 15 May 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746863; cv=none; b=g5MRbjILpim8aX4hfRxHu+SXqkGYI2fjLylGPs/rtzbvMeDSlv9peLFHBkyUVM7Bf12ms1onprBBwJvt7njSwJBj7QheV0s2zUTTxJtKlOlXBcXiWQ5tJM7VUy6vJ3SVVo44aCfphgiosPfVhvNs0cnUCTxsenGXDyw806CxT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746863; c=relaxed/simple;
	bh=uqqq8xHZEu3FsErv+gXQyhiJdQiI3eJ/IXas1Dknud8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb5IHmK1SKqaEwDZFa8+Ow+aT5s7dx3agSbeI1TkHU4NPGhw5NVUfIkn1OAcqQ6kMlrEsB3AZHob3GKtvxpwXFpHACf0wiDZtb7ECJ2KSTkXoMUQhDBRe1JFKrAQv4YFp22L946KJu/99uEnZ0mXgrvnVpRb0u1kCXbrdUXYm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsylV6p6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACD5C32781;
	Wed, 15 May 2024 04:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715746863;
	bh=uqqq8xHZEu3FsErv+gXQyhiJdQiI3eJ/IXas1Dknud8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsylV6p6imbr4f3rK4oSSyf63FaJ7SlwnbG166UfU/lry+Tqjl13kRGHwSh6GrBrH
	 H1gJXBWzcYP6BmOV7cxGFbP8EJfoa7yadsxY/eqLRHswyJJqknBbcf3o9ak6Uogx4T
	 haePx/nhbbr1ZVyGQvuKZiroksMIQ4/dJqCGlJm/AhbIAFTltblWZd2fPlV30CF/NY
	 f8eVqbJ48dbgEdrT3USfaEvxepFrmmBZovocp7Tbtlkg+ZSKQXM0n2XN+EStf3FntS
	 p4dzBOoWtcMIJSEM7KLt+NfFXK94hM0DyAPvM4uGlMix8zAfTXRWK+iPb104yMrN+0
	 wvr8DzxN09Ijw==
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
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add post_connect_cb callback
Date: Wed, 15 May 2024 12:20:24 +0800
Message-ID: <f092af05e77d3bab8cf55602b1df4ae00ae90cd5.1715745588.git.tanggeliang@kylinos.cn>
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

For getting rid of the second parameter of do_test(), this patch adds a
new callback post_connect_cb in struct network_helper_opts, it will be
invoked after connect_fd_to_addr() in connect_to_fd_opts().

Then define a dctcp dedicated post_connect_cb callback, invoking
bpf_map_lookup_elem() in it, named stg_post_connect_cb() and set it in
test_dctcp().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c |  6 ++-
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 43 ++++++++++---------
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6864af665508..5636488dfb42 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -342,10 +342,14 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 	    opts->post_socket_cb(fd, &opts->cb_opts))
 		goto error_close;
 
-	if (!opts->noconnect)
+	if (!opts->noconnect) {
 		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
 			goto error_close;
 
+		if (opts->post_connect_cb && opts->post_connect_cb(fd, &opts->cb_opts))
+			goto error_close;
+	}
+
 	return fd;
 
 error_close:
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 62dd40095cf2..0c8859651e7a 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -33,6 +33,7 @@ struct network_helper_opts {
 	int type;
 	int proto;
 	int (*post_socket_cb)(int fd, const struct post_socket_opts *opts);
+	int (*post_connect_cb)(int fd, const struct post_socket_opts *opts);
 	struct post_socket_opts cb_opts;
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 7c9c79e35551..05bcdb4830fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -34,13 +34,11 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
-static void do_test(const struct network_helper_opts *opts,
-		    const struct bpf_map *sk_stg_map)
+static void do_test(const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
 	int lfd = -1, fd = -1;
 	socklen_t addrlen;
-	int err;
 
 	if (make_sockaddr(AF_INET6, NULL, 0, &addr, &addrlen))
 		return;
@@ -54,16 +52,6 @@ static void do_test(const struct network_helper_opts *opts,
 	if (!ASSERT_NEQ(fd, -1, "connect_to_fd_opts"))
 		goto done;
 
-	if (sk_stg_map) {
-		int tmp_stg;
-
-		err = bpf_map_lookup_elem(bpf_map__fd(sk_stg_map), &fd,
-					  &tmp_stg);
-		if (!ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)") ||
-				!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
-			goto done;
-	}
-
 	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
 
 done:
@@ -96,7 +84,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -114,11 +102,24 @@ static int stg_post_socket_cb(int fd, const struct post_socket_opts *opts)
 	return bpf_map_update_elem(opts->map_fd, &fd, &expected_stg, BPF_NOEXIST);
 }
 
+static int stg_post_connect_cb(int fd, const struct post_socket_opts *opts)
+{
+	int tmp_stg;
+	int err;
+
+	err = bpf_map_lookup_elem(opts->map_fd, &fd, &tmp_stg);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)") ||
+			!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
+		return err;
+	return 0;
+}
+
 static void test_dctcp(void)
 {
 	struct network_helper_opts opts = {
 		.cb_opts.cc = "bpf_dctcp",
 		.post_socket_cb = stg_post_socket_cb,
+		.post_connect_cb = stg_post_connect_cb,
 	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link;
@@ -134,7 +135,7 @@ static void test_dctcp(void)
 	}
 
 	opts.cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
-	do_test(&opts, dctcp_skel->maps.sk_stg_map);
+	do_test(&opts);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
@@ -329,14 +330,14 @@ static void test_update_ca(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
 	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_update_2);
 	ASSERT_OK(err, "update_map");
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 	ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
 
@@ -362,14 +363,14 @@ static void test_update_wrong(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
 	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_wrong);
 	ASSERT_ERR(err, "update_map");
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 
 	bpf_link__destroy(link);
@@ -396,7 +397,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
@@ -500,7 +501,7 @@ static void test_cc_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 
 	bpf_link__destroy(link);
 	bpf_cc_cubic__destroy(cc_cubic_skel);
-- 
2.43.0


