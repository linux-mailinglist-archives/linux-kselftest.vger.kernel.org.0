Return-Path: <linux-kselftest+bounces-10697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F18CEEDB
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411BD1F215C8
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E242073;
	Sat, 25 May 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMxcX0JV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429254204B;
	Sat, 25 May 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638942; cv=none; b=HE+VPfaJgbamozjKEaWEZAN2RR3FotpUmjp1PMqe7i/f8dM46cUoPzEjkj3oVN4/ip527Tz/3jMNEVuCr3hzCM1wWo4XuW+dTiGKBfa+hwQ7LPZm9yXDBBqZg88KfOCcmRE8TMHdBMU6NIfceZw2WZ56O9FZZujLwVHZomZD1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638942; c=relaxed/simple;
	bh=Z9oReom4OcpwOIk6DSXKNHCUKdLqN5YiEZpEcZFsHrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s55SuEsfOLL9YDRG1dIcYJbCeetbie7oWDU1fnknqQGy62FPrP7lCQUEvdqrIhw8UI99+NpsMkwEWKw3UUDpmCW86HvFW73Y7rf/poQ2dE6HcoU1YF8+Ppbpd1lT8MANNhh9okflmeMrn4Fl/dVXTD0MPyTYVrI50n/K8xeAoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMxcX0JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F375C3277B;
	Sat, 25 May 2024 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638942;
	bh=Z9oReom4OcpwOIk6DSXKNHCUKdLqN5YiEZpEcZFsHrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMxcX0JVREIg0peQmaMg44VKTutYxxwT/8ym1tE2cpH/LTvKjfadIv0tLYIllBezz
	 k561DIEQBjmxCKn6XD1pO4DCG/uM/Wtf4OCpjbuXSprHp7YfNdQfY7Nc1c04nkrZKG
	 iTv1tL5W/DipOuqgfoqaWrZV3KSkChIbFt3bqkhsce9jYCXQemw8UE6YzF6etkNIvK
	 YnSXUjn/BzLB1FNqf1yfpBbDhPYNgKSBSA/7GPYsoWs1Gy72TCVa1kL6OJYWKWnclR
	 EUSyjGPgY4yJUbFPMrjHAAGJfx6wcksfQfL0WAw/1AFzV+WKCkmH6SbzhwMaRb6BnI
	 HugxxJbuDmp/Q==
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
Subject: [PATCH bpf-next v5 7/7] selftests/bpf: Add post_connect_cb callback
Date: Sat, 25 May 2024 20:08:21 +0800
Message-ID: <3c5e8bd6c38cbe233daee6e0359a99d8d22ed821.1716638248.git.tanggeliang@kylinos.cn>
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

For getting rid of the second parameter of do_test(), this patch adds a
new callback post_connect_cb in struct network_helper_opts, it will be
invoked after connect_fd_to_addr() in connect_to_fd_opts().

Then define a dctcp dedicated post_connect_cb callback, invoking
bpf_map_lookup_elem() in it, named stg_post_connect_cb() and set it in
test_dctcp().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c |  7 ++-
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 45 ++++++++++---------
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e20caef06aae..75589597c17e 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -353,10 +353,15 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 	    opts->post_socket_cb(fd, opts->cb_opts))
 		goto error_close;
 
-	if (!opts->noconnect)
+	if (!opts->noconnect) {
 		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
 			goto error_close;
 
+		if (opts->post_connect_cb &&
+		    opts->post_connect_cb(fd, opts->cb_opts))
+			goto error_close;
+	}
+
 	return fd;
 
 error_close:
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 11eea8e2e4f1..b387e8142f3c 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -28,6 +28,7 @@ struct network_helper_opts {
 	int type;
 	int proto;
 	int (*post_socket_cb)(int fd, void *opts);
+	int (*post_connect_cb)(int fd, void *opts);
 	void *cb_opts;
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 9a7c3dc39008..e6fc6dfbcb7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -39,11 +39,9 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
-static void do_test(const struct network_helper_opts *opts,
-		    const struct bpf_map *sk_stg_map)
+static void do_test(const struct network_helper_opts *opts)
 {
 	int lfd = -1, fd = -1;
-	int err;
 
 	lfd = start_server_str(AF_INET6, SOCK_STREAM, NULL, 0, opts);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
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
@@ -100,7 +88,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -125,6 +113,20 @@ static int stg_post_socket_cb(int fd, void *opts)
 	return 0;
 }
 
+static int stg_post_connect_cb(int fd, void *opts)
+{
+	struct cb_opts *cb_opts = (struct cb_opts *)opts;
+	int tmp_stg;
+	int err;
+
+	err = bpf_map_lookup_elem(cb_opts->map_fd, &fd, &tmp_stg);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)") ||
+			!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
+		return err;
+
+	return 0;
+}
+
 static void test_dctcp(void)
 {
 	struct cb_opts cb_opts = {
@@ -132,6 +134,7 @@ static void test_dctcp(void)
 	};
 	struct network_helper_opts opts = {
 		.post_socket_cb	= stg_post_socket_cb,
+		.post_connect_cb = stg_post_connect_cb,
 		.cb_opts	= &cb_opts,
 	};
 	struct bpf_dctcp *dctcp_skel;
@@ -148,7 +151,7 @@ static void test_dctcp(void)
 	}
 
 	cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
-	do_test(&opts, dctcp_skel->maps.sk_stg_map);
+	do_test(&opts);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
@@ -352,14 +355,14 @@ static void test_update_ca(void)
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
 
@@ -388,14 +391,14 @@ static void test_update_wrong(void)
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
@@ -425,7 +428,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
@@ -532,7 +535,7 @@ static void test_cc_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 
 	bpf_link__destroy(link);
 	bpf_cc_cubic__destroy(cc_cubic_skel);
-- 
2.43.0


