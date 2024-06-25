Return-Path: <linux-kselftest+bounces-12626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87FB916110
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 10:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBE7281C22
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3493D14830F;
	Tue, 25 Jun 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC/xyqyF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D91482F2;
	Tue, 25 Jun 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303933; cv=none; b=sk/x8VOWkTaJwABg2qQACCtx4ALEhOWu8eXUI2sJCTw5gcr2KZqYCa/VmgKptU78h9skMI52GMTWUO9ty87iL/ZNPqfPa+UaRuh6MZqRzcko/TDvnEW6SeKmQ9p5ZvRcI13WPGoqooVpQnyybgoLYdQ/MHQlocZF/mWRwJjlyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303933; c=relaxed/simple;
	bh=tBalyMn0K8HmbEL6jGFiP34fqQRyhZIXI4Wg/9jC9X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVbpAwT6Ho5HAPvDS5E2HbAxA41swjgKn1sFztop0jjIkBKuqbJ0VuFfS9WmfRRcvaUQ/2JnTJgkr1LWud1wa4M9JWF09F1ZRs7sXG5a+EMj0l828b6zhy8Sjc2ievtVSGNhN/pDNv9vpPK6UbXtAs4CjZeBi0QSBT3pySI9Gcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC/xyqyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE92C4AF16;
	Tue, 25 Jun 2024 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719303932;
	bh=tBalyMn0K8HmbEL6jGFiP34fqQRyhZIXI4Wg/9jC9X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZC/xyqyF9yIzcsOMPI4Shba8DtrGdkxgfoPUhZe2ZotISZ8xfyEI8PgBOWDD5UZgL
	 E28KvsvKnYUaNfMKagsueU1X5M9EVRuoI+6+TVLWAjMdLd8cLZJjGguoGcr13e8Mvt
	 I0lCP5FNHUwabVTSfamFNGGNdfAPDSTBL1p/LgWtBRRuwP2FbinkuebqQmbprNeJeB
	 lxCKnJE/K0j2yotcrogul2ZdCOVBoddZKVU+S60ejSMwPbWfciI/QqnPLMoTGs4WK3
	 WE2Th/gP9fVekKC7GFoHxn/kSjgbuZpEitSb+z9mBOkYRbl+Ss8971pBcNaASWI31O
	 XZo3DImfyRsFg==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Miao Xu <miaxu@meta.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Null checks for link in bpf_tcp_ca
Date: Tue, 25 Jun 2024 16:24:39 +0800
Message-ID: <633184f4e207aff9f2539c2b6a2929f0891aee4f.1719302367.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719302367.git.tanggeliang@kylinos.cn>
References: <cover.1719302367.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Run BPF selftests bpf_tcp_ca on Loongarch:

./test_progs -t bpf_tcp_ca

A "Segmentation fault" error occurs:

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
 settcpca:FAIL:setsockopt unexpected setsockopt: actual -1 == expected -1
 (network_helpers.c:99: errno: No such file or directory) Failed to call post_socket_cb
 start_test:FAIL:start_server_str unexpected start_server_str: actual -1 == expected -1
 test_update_ca:FAIL:ca1_ca1_cnt unexpected ca1_ca1_cnt: actual 0 <= expected 0
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

This is because "link" is NULL in that case. This patch adds null
checks for link in bpf_tcp_ca to fix this error.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c        | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index bceff5900016..e920ecf0e888 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -411,7 +411,8 @@ static void test_update_ca(void)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto err;
 
 	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
@@ -425,6 +426,7 @@ static void test_update_ca(void)
 	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
 
 	bpf_link__destroy(link);
+err:
 	tcp_ca_update__destroy(skel);
 }
 
@@ -447,7 +449,8 @@ static void test_update_wrong(void)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto err;
 
 	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
@@ -460,6 +463,7 @@ static void test_update_wrong(void)
 	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 
 	bpf_link__destroy(link);
+err:
 	tcp_ca_update__destroy(skel);
 }
 
@@ -484,7 +488,8 @@ static void test_mixed_links(void)
 	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto err;
 
 	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
@@ -493,6 +498,7 @@ static void test_mixed_links(void)
 	ASSERT_ERR(err, "update_map");
 
 	bpf_link__destroy(link);
+err:
 	bpf_link__destroy(link_nl);
 	tcp_ca_update__destroy(skel);
 }
@@ -536,7 +542,8 @@ static void test_link_replace(void)
 	bpf_link__destroy(link);
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
-	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops_2nd"))
+		goto err;
 
 	/* BPF_F_REPLACE with a wrong old map Fd. It should fail!
 	 *
@@ -559,6 +566,7 @@ static void test_link_replace(void)
 
 	bpf_link__destroy(link);
 
+err:
 	tcp_ca_update__destroy(skel);
 }
 
-- 
2.43.0


