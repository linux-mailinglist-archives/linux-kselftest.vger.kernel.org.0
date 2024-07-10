Return-Path: <linux-kselftest+bounces-13462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB8C92D25D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840261F2391B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3356192490;
	Wed, 10 Jul 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3Z+O9SY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96ED18FDDB;
	Wed, 10 Jul 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617035; cv=none; b=MLpP6weK+bopIWG3HDLiXp/ghlM1c3RuwhXGBn0zKanHOeeFQvpqMKbFTkmcJ/8eTp5HpgOzhnq+FxNx7BiokZ7vzmUdtpw1dUotCiUwCufaCUwNhmcg2bINbNp0vfEH4HKHl2XTOHxsMAavDyScxxhcK9RLM7otML+JS4vI0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617035; c=relaxed/simple;
	bh=tMPMUPmLUyGqhVJvWJd5X+BiJbuh4kK/CTkm+wP4660=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVxv9LR4/1WpUyI3m4ckjtPe0tNfFTfOfIQ6ZNIQUvHAygi9O62vgA/7SQtwMqOaMgaCsrJhZx57VzEX1VCnQe6b2PP7OpFtesZEIdCQyGEUzxz7dRWTKQc10CB4exR9rozVjAEHvYMfmSDAeUl/AfdC4+f3p3oEjpcgDpw/5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3Z+O9SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9D7C32782;
	Wed, 10 Jul 2024 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720617035;
	bh=tMPMUPmLUyGqhVJvWJd5X+BiJbuh4kK/CTkm+wP4660=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3Z+O9SYCcmDqdXo5g7WRw874JVJWuox2dTd+oVLBdxnzSMHqWIwEsdZSHH9Nbaja
	 SJkW11u2hSoBwiUjnRvneshktBn1CSNNfaEP0aUDanGy5odQnAapdJfcphDJA6K7rG
	 Ll+9yHSBz8aDOWM9Pj27nlHZOMZLnS8aEHYgLPe/lefnx6o2090IyT08CGNOSta0wy
	 6l8hK97psgzTesUDMypaeudyRSj3xty4PZ8UZVrWLm0oFxS57VI1cXUNXWjPKOt5Mp
	 kSuCtFkh6YN+0xcjtdYcwH81uMNZfuYpzLaTfmjK2Z0n79Qw97SwsSAsi8FtncD3KB
	 b35m7mScQ+e7Q==
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
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Null checks for links in bpf_tcp_ca
Date: Wed, 10 Jul 2024 21:10:16 +0800
Message-ID: <b4c841492bd4ed97964e4e61e92827ce51bf1dc9.1720615848.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720615848.git.tanggeliang@kylinos.cn>
References: <cover.1720615848.git.tanggeliang@kylinos.cn>
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

This is because BPF trampoline is not implemented on Loongarch yet,
"link" returned by bpf_map__attach_struct_ops() is NULL. test_progs
crashs when this NULL link passes to bpf_link__update_map(). This
patch adds NULL checks for all links in bpf_tcp_ca to fix these errors.
If "link" is NULL, goto the newly added label "out" to destroy the skel.

v2:
 - use "goto out" instead of "return" as Eduard suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c        | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index bceff5900016..63422f4f3896 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -411,7 +411,8 @@ static void test_update_ca(void)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto out;
 
 	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
@@ -425,6 +426,7 @@ static void test_update_ca(void)
 	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
 
 	bpf_link__destroy(link);
+out:
 	tcp_ca_update__destroy(skel);
 }
 
@@ -447,7 +449,8 @@ static void test_update_wrong(void)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto out;
 
 	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
@@ -460,6 +463,7 @@ static void test_update_wrong(void)
 	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 
 	bpf_link__destroy(link);
+out:
 	tcp_ca_update__destroy(skel);
 }
 
@@ -481,7 +485,8 @@ static void test_mixed_links(void)
 		return;
 
 	link_nl = bpf_map__attach_struct_ops(skel->maps.ca_no_link);
-	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
+	if (!ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl"))
+		goto out;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
@@ -494,6 +499,7 @@ static void test_mixed_links(void)
 
 	bpf_link__destroy(link);
 	bpf_link__destroy(link_nl);
+out:
 	tcp_ca_update__destroy(skel);
 }
 
@@ -536,7 +542,8 @@ static void test_link_replace(void)
 	bpf_link__destroy(link);
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
-	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops_2nd"))
+		goto out;
 
 	/* BPF_F_REPLACE with a wrong old map Fd. It should fail!
 	 *
@@ -559,6 +566,7 @@ static void test_link_replace(void)
 
 	bpf_link__destroy(link);
 
+out:
 	tcp_ca_update__destroy(skel);
 }
 
-- 
2.43.0


