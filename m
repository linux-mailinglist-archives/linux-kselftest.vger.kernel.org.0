Return-Path: <linux-kselftest+bounces-13363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E9F92B5AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17C6283DF1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4CF15821A;
	Tue,  9 Jul 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u89TQQcF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAF01581FF;
	Tue,  9 Jul 2024 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521939; cv=none; b=oFFdhPsbg41S1KQNYh4wXdY5jwToACEtBbXLfWfO5IwLF0mtlWD9TFoqXaGbw7yIdniEF44c0TfsXDqJZBATnzW5tnIqUIdcS4dn2chItyXKf30QnozbzxzC/tuyrTts+U5emkPW/tylLrarQzqImFkxzNCWX85SJU6zwytogSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521939; c=relaxed/simple;
	bh=zWDobaG8+4Fp9/magr7yNxdMa1X/mKRHFTpGE9mDP2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIaolhKWYg5JHEXfc53s+tR3lJ02ecnkyBvTgLZWZC/0IVfZ8RiieXDUwKJADvynN3+KvIPN7N2+PO1wqhIinme8MBX94jJm8tsxMbx9ZUTI/A+RDc0O0j3jFUdHXdhZpFvrV9I1TIGMBp1V8eYrUuKOFWHChX0/jD3Vb2OWJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u89TQQcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1022C4AF0C;
	Tue,  9 Jul 2024 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720521938;
	bh=zWDobaG8+4Fp9/magr7yNxdMa1X/mKRHFTpGE9mDP2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u89TQQcFek8y/8h/614eArzcNyIaagStnvaN9Sk8/jPwdLdkoliglDzbfdmsDMbH2
	 q/kdFrjEZjP9sHEEhVD55QGe0RBIST0Akm11JxOoFTGxRcDMHhirWEeYimm859+R3u
	 AuOerM5TD2f5NkPIPd5kPjS7+EbbyFFA1ogBaUbob9OmV/6se4bCGUNIWMsfei4tx/
	 nOSF/DVh7Dct6yzzwKHknZeTmpI+sznhCAo5ueILijYkgabRNi46fzeNbZMV8MvvdJ
	 C+amNvIdf/xxofdSXvNtZit3NKrveXz3JMggLwfXxnwrD0Tp+u/+yQS03uIF48U5nj
	 fr1v6ycgCUn9Q==
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
Subject: [PATCH bpf-next 1/3] selftests/bpf: Null checks for links in bpf_tcp_ca
Date: Tue,  9 Jul 2024 18:45:06 +0800
Message-ID: <3ac5d24825bdf666eae4089a8c69d8e97a6194d2.1720521482.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720521482.git.tanggeliang@kylinos.cn>
References: <cover.1720521482.git.tanggeliang@kylinos.cn>
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
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index d842ff64bc2a..efc1bf2ff7de 100644
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
@@ -460,11 +463,13 @@ static void test_update_wrong(void)
 	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 
 	bpf_link__destroy(link);
+out:
 	tcp_ca_update__destroy(skel);
 }
 
 static void test_mixed_links(void)
 {
+	struct bpf_link *link = NULL, *link_nl = NULL;
 	struct cb_opts cb_opts = {
 		.cc = "tcp_ca_update",
 	};
@@ -473,7 +478,6 @@ static void test_mixed_links(void)
 		.cb_opts	= &cb_opts,
 	};
 	struct tcp_ca_update *skel;
-	struct bpf_link *link, *link_nl;
 	int err;
 
 	skel = tcp_ca_update__open_and_load();
@@ -481,10 +485,12 @@ static void test_mixed_links(void)
 		return;
 
 	link_nl = bpf_map__attach_struct_ops(skel->maps.ca_no_link);
-	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
+	if (!ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl"))
+		goto out;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto out;
 
 	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
@@ -492,6 +498,7 @@ static void test_mixed_links(void)
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
 	ASSERT_ERR(err, "update_map");
 
+out:
 	bpf_link__destroy(link);
 	bpf_link__destroy(link_nl);
 	tcp_ca_update__destroy(skel);
@@ -536,7 +543,8 @@ static void test_link_replace(void)
 	bpf_link__destroy(link);
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
-	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops_2nd"))
+		goto out;
 
 	/* BPF_F_REPLACE with a wrong old map Fd. It should fail!
 	 *
@@ -559,6 +567,7 @@ static void test_link_replace(void)
 
 	bpf_link__destroy(link);
 
+out:
 	tcp_ca_update__destroy(skel);
 }
 
-- 
2.43.0


