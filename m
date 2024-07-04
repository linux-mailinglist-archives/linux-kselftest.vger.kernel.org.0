Return-Path: <linux-kselftest+bounces-13168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDE926FF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 08:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8909284B6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 06:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D711A08CC;
	Thu,  4 Jul 2024 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw3zmwCo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AB1BC4E;
	Thu,  4 Jul 2024 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075725; cv=none; b=U7l3SkVTBZE+wSrykS1xvxFfGQQpOXO9UcrwJdrV/LPaGOya6ayPnky99v0tXlUl1aHY1dcWrqnM+E/c+zc6FFinPeB/8sI77JCdGTcV8iw+2ly1TywOG5ygYG1Zbob1cJudDNVcNu0cCdXALuOSx0GJ+57mJam9wvjMnCjVj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075725; c=relaxed/simple;
	bh=Mb8k4zWoJ3BhIpD2KKINFF2veb6v9T7oCfAwzClcDKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT8U5m3xzW/PTH9ieVhTVNORSoqQIFnkBzi4l0iGV871wQp5PHnINrNv9Go9ElX6lp5y9trR//fouCaeQJNeGcMLp5BgT+eWiKXSEZ2EcdnO5kzC3nc2j8lBeDloS8Q7nipQtJyxS6PnUgbMNwMuu24/AYV3wCPJR+GT6m1PXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw3zmwCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E76AC3277B;
	Thu,  4 Jul 2024 06:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075724;
	bh=Mb8k4zWoJ3BhIpD2KKINFF2veb6v9T7oCfAwzClcDKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nw3zmwCoPdWbH9zM9j2+iyf0n9tgDm9uVm4PbW3frlBvPTvyTGeseaF0+wfeQmFT1
	 lGk8bHut8dSDLbz8kGJN3VPDv+vuKF/o9vu7Z8Da+NeZrsrZ91P3tlXV7Frvm2b5F6
	 Bt3Tli5tW1/ONktSKBwwJ6nHI7zpACJ+rq0zUcLiSyoLfA1ozev5tHSpEzq45T7TIZ
	 NItuH3vdFtt7DYtoOhzdQsEizM/cJTsVlGc7zehgCM2AUHRZT5Z7sQoMHVSlcg6VNv
	 /CR0Oh78anHe6a8pFfDoYk/HIrNDaPcOdGtaYnb/kEwNN7m8p1wUeOtwFL1W59T1lP
	 RNSs7rFBfcbmQ==
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
Subject: [PATCH 4/6] selftests/bpf: Null checks for link in bpf_tcp_ca
Date: Thu,  4 Jul 2024 14:48:04 +0800
Message-ID: <ee0a61f5fd6dd88233b7a9dd32abf80f7e22b2af.1720075006.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720075006.git.tanggeliang@kylinos.cn>
References: <cover.1720075006.git.tanggeliang@kylinos.cn>
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
index fa2efb246d3b..45a21a064437 100644
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


