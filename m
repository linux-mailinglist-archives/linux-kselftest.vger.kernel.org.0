Return-Path: <linux-kselftest+bounces-10095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EA8C2F55
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 05:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AD01F22A70
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9E36AEF;
	Sat, 11 May 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3SPX7uT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974F2D7A8;
	Sat, 11 May 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397426; cv=none; b=Z3sWuFaDwwMM1bB/SPFu18hWZMsHRlHEnx1Ip9TuHOE4TKVYhxFmw4TH5n/jaXOAhJpk7Yja4ghyq+3JTcb/Pbs3s1AS6TF1EwUAlxe2ZJiEnbRxIYMY+vzxY+7j93/tvObXmW0Hs1028FNkexK4ciFqd5YXAL2ZGcpkxVWPvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397426; c=relaxed/simple;
	bh=ujYqDjMkiMlOcOnstTDDhc9seHskWrj4BUtZbN7bV3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsnV0JDao9zfG9aw9XSdm51L+L+CfsByklQbsKNQbLK461/cc+x/eOMRzX9IWNu0XdcxEnSYsPBacOoVvWnIV2q3CiJqfQXzdu5RSAPSDEiy/VnxMXehK26/H1FVdHWAjGyDS6KW8djZZQ+DPEcHTnkJEZMDPcJEzeCy5XSOWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3SPX7uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A3FC32782;
	Sat, 11 May 2024 03:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715397426;
	bh=ujYqDjMkiMlOcOnstTDDhc9seHskWrj4BUtZbN7bV3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3SPX7uTYmcPI+PxIdmgYh3kV50eWrfC2NkcqeJ3g0ypGxid6+VMPgp0a+wzRJcqK
	 IBhQ50A4oPrPGY48/5et5onK0KZoQirbl44JS+BgUtbSD7HBgwM7OJBe27M4vwx8KB
	 NfV31uJuaDmxtpi8YQ3Ctdfjd1NU+PCFn2hlb0BZp+59gJd4vTEGcBlKi5OYNoYWQB
	 yOArFtKnSOL1dtAJeT5KBV4OGVqwWGgtBoj8KvUR6ZQIJZDwFAn8Lsq9Nm0GV1hNmj
	 FVl7uLH8XWcqcL+Ob2LRCAKzx+XQnVuDR3SQmQ9vjPLpgil+9rPL6DoTXaCB8Oo6pw
	 WAvRqGDbuKbZg==
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
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add post_connect_cb callback
Date: Sat, 11 May 2024 11:16:28 +0800
Message-ID: <2da67a207bfd53057db219e13bd68a7ee82d5d30.1715396405.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 41 ++++++++++---------
 3 files changed, 27 insertions(+), 21 deletions(-)

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
index bca30c32b819..0801b0c39cfe 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -33,13 +33,11 @@ static int settcpca(int fd, const char *tcp_ca)
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
@@ -53,16 +51,6 @@ static void do_test(const struct network_helper_opts *opts,
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
@@ -95,7 +83,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -113,11 +101,24 @@ static int stg_post_socket_cb(int fd, const struct post_socket_opts *opts)
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
@@ -133,7 +134,7 @@ static void test_dctcp(void)
 	}
 
 	opts.cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
-	do_test(&opts, dctcp_skel->maps.sk_stg_map);
+	do_test(&opts);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
@@ -328,14 +329,14 @@ static void test_update_ca(void)
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
 
@@ -361,14 +362,14 @@ static void test_update_wrong(void)
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
@@ -395,7 +396,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
-- 
2.43.0


