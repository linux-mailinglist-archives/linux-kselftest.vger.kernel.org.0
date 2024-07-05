Return-Path: <linux-kselftest+bounces-13213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB1A928083
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 04:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532371C22ADB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 02:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63067219ED;
	Fri,  5 Jul 2024 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiyhMWjd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FE7219EB;
	Fri,  5 Jul 2024 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147133; cv=none; b=NYGtzAl+/l2Z4ekUTb97CK99e6817w6xnGcy200UExT4whx1rFjtABmsdmYO8QypYEUu5k4HKqFOkUYcCCxxPBBmeGlm4EC/5gJS9XD5iruSQ2cQkc2BHyktnDcHX5uxgpi+4EUujHbUyJ+20rAofSLvzlFJAkWyUh25S3UusNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147133; c=relaxed/simple;
	bh=n1NyZ6eGDBxEo2vY6L1+foPngaXNx5u6a5ZIUTsKSmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz4Ur5y4LamNWXagA/6k34rQHEyfqXii1RiN0htLR1IaGhdib3e9bvFNfkew76J8JzuhgeJsdajn96RScNe+Vi2w+WopDuyAHUD8kf149xS4LNPqDfRKB8iXcpC7XH+L9YRiUGUF7KGueyIuUyGp2LpBtkwQzTlGdErrppqzhKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiyhMWjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F1DC3277B;
	Fri,  5 Jul 2024 02:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720147132;
	bh=n1NyZ6eGDBxEo2vY6L1+foPngaXNx5u6a5ZIUTsKSmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aiyhMWjdh26ChbNIhf1HdQYQaQev8wZvcQ2hze56wHrY0EyE9odXrFkgxSr8jPPLk
	 uGf3DMcY4wSR83cS2vPK/qPCyrnco1LHNmY+l5Di9RF1tFOUjBsQuRo3OoJpUhEsr3
	 oCv+Mlxk9Ja2XoVhpzJM6PB5yu5ZMRPC2BdLjhJ4fOCLhyIS+YWk+u4zV14PTgIul3
	 YwQQi/wYKRj15s7bYX4osAdJvVsvE14KZnCihyKUmeFfYgqIuaNbmvWzuXRUouPQXU
	 1FN9nXXqzLz5+XDf1Hogyn+PD9xatQUdqfb5a5UaM4I9CJH/jgQ5AlgSO6PFruVpmM
	 OeOqlr9ObJbdQ==
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
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: Null checks for link in bpf_tcp_ca
Date: Fri,  5 Jul 2024 10:38:22 +0800
Message-ID: <06755f462ddb7bc9f734f105e18c1d77c03811cb.1720146231.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720146231.git.tanggeliang@kylinos.cn>
References: <cover.1720146231.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Run bpf_tcp_ca selftests (./test_progs -t bpf_tcp_ca) on a Loongarch
platform, some "Segmentation fault" errors occur:

'''
 test_dctcp:PASS:bpf_dctcp__open_and_load 0 nsec
 test_dctcp:FAIL:bpf_map__attach_struct_ops unexpected error: -524
 #29/1    bpf_tcp_ca/dctcp:FAIL
 test_cubic:PASS:bpf_cubic__open_and_load 0 nsec
 test_cubic:FAIL:bpf_map__attach_struct_ops unexpected error: -524
 #29/2    bpf_tcp_ca/cubic:FAIL
 test_dctcp_fallback:PASS:dctcp_skel 0 nsec
 test_dctcp_fallback:PASS:bpf_dctcp__load 0 nsec
 test_dctcp_fallback:FAIL:dctcp link unexpected error: -524
 #29/4    bpf_tcp_ca/dctcp_fallback:FAIL
 test_write_sk_pacing:PASS:open_and_load 0 nsec
 test_write_sk_pacing:FAIL:attach_struct_ops unexpected error: -524
 #29/6    bpf_tcp_ca/write_sk_pacing:FAIL
 test_update_ca:PASS:open 0 nsec
 test_update_ca:FAIL:attach_struct_ops unexpected error: -524
 settcpca:FAIL:setsockopt unexpected setsockopt: \
					actual -1 == expected -1
 (network_helpers.c:99: errno: No such file or directory) \
					Failed to call post_socket_cb
 start_test:FAIL:start_server_str unexpected start_server_str: \
					actual -1 == expected -1
 test_update_ca:FAIL:ca1_ca1_cnt unexpected ca1_ca1_cnt: \
					actual 0 <= expected 0
 #29/9    bpf_tcp_ca/update_ca:FAIL
 #29      bpf_tcp_ca:FAIL
 Caught signal #11!
 Stack trace:
 ./test_progs(crash_handler+0x28)[0x5555567ed91c]
 linux-vdso.so.1(__vdso_rt_sigreturn+0x0)[0x7ffffee408b0]
 ./test_progs(bpf_link__update_map+0x80)[0x555556824a78]
 ./test_progs(+0x94d68)[0x5555564c4d68]
 ./test_progs(test_bpf_tcp_ca+0xe8)[0x5555564c6a88]
 ./test_progs(+0x3bde54)[0x5555567ede54]
 ./test_progs(main+0x61c)[0x5555567efd54]
 /usr/lib64/libc.so.6(+0x22208)[0x7ffff2aaa208]
 /usr/lib64/libc.so.6(__libc_start_main+0xac)[0x7ffff2aaa30c]
 ./test_progs(_start+0x48)[0x55555646bca8]
 Segmentation fault
'''

This is because "link" returned by bpf_map__attach_struct_ops() is
NULL in this case. test_progs crashs when this NULL link passes to
bpf_link__update_map(). This patch adds NULL checks for all links
in bpf_tcp_ca to fix these errors. If "link" is NULL, goto the newly
added label "err" to destroy the skel.

v2:
 - use "goto err" instead of "return" as Eduard suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c        | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 5909c1f82f3b..9effdfb1a5ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -407,7 +407,8 @@ static void test_update_ca(void)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto err;
 
 	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
@@ -421,6 +422,7 @@ static void test_update_ca(void)
 	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
 
 	bpf_link__destroy(link);
+err:
 	tcp_ca_update__destroy(skel);
 }
 
@@ -443,7 +445,8 @@ static void test_update_wrong(void)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto err;
 
 	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
@@ -456,6 +459,7 @@ static void test_update_wrong(void)
 	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 
 	bpf_link__destroy(link);
+err:
 	tcp_ca_update__destroy(skel);
 }
 
@@ -480,7 +484,8 @@ static void test_mixed_links(void)
 	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto err;
 
 	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
@@ -489,6 +494,7 @@ static void test_mixed_links(void)
 	ASSERT_ERR(err, "update_map");
 
 	bpf_link__destroy(link);
+err:
 	bpf_link__destroy(link_nl);
 	tcp_ca_update__destroy(skel);
 }
@@ -532,7 +538,8 @@ static void test_link_replace(void)
 	bpf_link__destroy(link);
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
-	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops_2nd"))
+		goto err;
 
 	/* BPF_F_REPLACE with a wrong old map Fd. It should fail!
 	 *
@@ -555,6 +562,7 @@ static void test_link_replace(void)
 
 	bpf_link__destroy(link);
 
+err:
 	tcp_ca_update__destroy(skel);
 }
 
-- 
2.43.0


