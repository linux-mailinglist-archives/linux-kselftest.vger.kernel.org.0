Return-Path: <linux-kselftest+bounces-10651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A68CDFBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 05:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7FE281D76
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523B21EB2A;
	Fri, 24 May 2024 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtlAbsa1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B091DA4E;
	Fri, 24 May 2024 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520986; cv=none; b=VMvkNlJ+8qm6uKzB2LuFclZyzLJs5ILRGXBUOs1je23bNyKltsWT0sXTtkOcp7HtUqkGn6MtZuBpG2lBu0/c05R0BSGHFbZUSQqpEg4xLnT4qvrkZRzGgX6FnoFa0b9jhhz7DhLsAkGDsqEA3uvktufmfRso0lB38N0Cuiv4Pvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520986; c=relaxed/simple;
	bh=zYQ/Nf8RsYjrjdtiVDNHYzDvXVz4aQsUcEHXVFX7htc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZamJKqYVkEJNVcNDpTQq0Mno/x+8eOVD2msHHISo5+T018Iub88rQk+R3Gm+cMRrVw5ZLGFY6gkSNHTRbseQ1pPPQhm09reZn3lQxWDEp0r6SLTtfS0D/YVU6tK1NRUEtpuk6w1w5LGWOqNhRn4te0t0D7imlvow1qrkBgWzvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtlAbsa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E81C32781;
	Fri, 24 May 2024 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520986;
	bh=zYQ/Nf8RsYjrjdtiVDNHYzDvXVz4aQsUcEHXVFX7htc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtlAbsa1dvhwifQieYoiFMiXlZMMWS30f4GbUu1I+P9jwhRFCjF/9lFO4zDQ0isfC
	 +C4tHP/iieDqcrj/VPPuojshsgXUvCCjkaaqf95wc+LxapuLQoh7+PajdiLLG+eOkk
	 9QFg9hjGqbb7utJdTE06iEhmfR62WkxGbTXcxhT2HCBAC/mDcnUFvu2F9WTwqaiOzc
	 nL+SnZuoibs/DRzUmT8SzykqxNTqTFAODHksjcmIqfTgNK4JXRnZ2sBzTL1LhwoR0C
	 7cE1RVCf8mz7ulmzQjsnT7F6ABxesPZjnVeiGf8EX60IDC2iUDUYVTWjkWnATXuqMq
	 /UwMgz30Gj0fQ==
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
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Add post_connect_cb callback
Date: Fri, 24 May 2024 11:21:54 +0800
Message-ID: <d112fc05a838d2cbc744314af12fab14d95eb442.1716520609.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 44 ++++++++++---------
 3 files changed, 30 insertions(+), 22 deletions(-)

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
index cde796f82206..a2501e5aaa7d 100644
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
@@ -101,7 +89,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -120,6 +108,19 @@ static int stg_post_socket_cb(int fd, void *opts)
 	return bpf_map_update_elem(cb_opts->map_fd, &fd, &expected_stg, BPF_NOEXIST);
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
+	return 0;
+}
+
 static void test_dctcp(void)
 {
 	struct cb_opts cb_opts = {
@@ -127,6 +128,7 @@ static void test_dctcp(void)
 	};
 	struct network_helper_opts opts = {
 		.post_socket_cb	= stg_post_socket_cb,
+		.post_connect_cb = stg_post_connect_cb,
 		.cb_opts	= &cb_opts,
 	};
 	struct bpf_dctcp *dctcp_skel;
@@ -143,7 +145,7 @@ static void test_dctcp(void)
 	}
 
 	cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
-	do_test(&opts, dctcp_skel->maps.sk_stg_map);
+	do_test(&opts);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
@@ -344,14 +346,14 @@ static void test_update_ca(void)
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
 
@@ -380,14 +382,14 @@ static void test_update_wrong(void)
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
@@ -417,7 +419,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
@@ -524,7 +526,7 @@ static void test_cc_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts);
 
 	bpf_link__destroy(link);
 	bpf_cc_cubic__destroy(cc_cubic_skel);
-- 
2.43.0


