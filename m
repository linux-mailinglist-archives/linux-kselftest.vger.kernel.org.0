Return-Path: <linux-kselftest+bounces-12557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC3914E72
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 15:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA7C1F23106
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4A413DDB9;
	Mon, 24 Jun 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALYDvSoD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0E13DBB1;
	Mon, 24 Jun 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235708; cv=none; b=Fi+Q+cCzoReAEeaUO7ATvEv0ye+soTlbE3NMLbm/0PO9b/JUH2rkC/oiqO/Ifr/E7Ohl0EZooxyA+fzYIkIl/F8dND/+EQNWkY15fe8ok/3Ox0AUu/xursvHEetOgB4dt8YmN8k7NDufXhaTpw1gu40M24xRYxfyS7x3NtMOOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235708; c=relaxed/simple;
	bh=7tbsczf0PnCDywXyYKxY9m9ikEjYKv17QDMOEKE013s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUGwGvrlHuEVHHjFkQjaUR/M5Vv/oUSsYoULm/YLF46JtYPMxqEssSQWW7qJzez7CVZEdPLQACtr8HcwhQvDLkTK13gcchKi3YZ1vVEQaEAb4p51UAYnfT1bM1qasWncgaswWfqO0JPOex2XAcM5YM3bowNlMdw9y1v+cT/oRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALYDvSoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65197C2BBFC;
	Mon, 24 Jun 2024 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719235708;
	bh=7tbsczf0PnCDywXyYKxY9m9ikEjYKv17QDMOEKE013s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALYDvSoDguX6hkvidoP/m8vFAK/hTQU0da2pxIYiQ0rW+zGM3SP1mAaP7/pD67twv
	 TbqeYIDXzMTivwN1CeOYklU98jEWYG39vJbKgoJRm0X2kWdvDVC8rRerIfaEG6vZve
	 7WM8lGoMtqzWsygD+/jTtHkG2ty0EQrJi8jhiOIWUH+oTcj7jguxrfsRY1eOtE5qO2
	 bHeKj1HP2yMRNp+EA2S7SSuNjffiuQv+TK56WT+Tg0stfDZSlbYZBKpmusv/sQLmfV
	 iF9mGb8IcKlhFP7NpOtKeTSLysVVggeZJFy1BfSATP7AYpBJjgqiL9K47JWLcI7lQ+
	 wxz1SqMJ2KvWg==
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
	Yuran Pereira <yuran.pereira@hotmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/3] selftests/bpf: Null checks for link in bpf_tcp_ca
Date: Mon, 24 Jun 2024 21:27:57 +0800
Message-ID: <0f91336b3f464b63ef2f223bba7759adc81affdb.1719234744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719234744.git.tanggeliang@kylinos.cn>
References: <cover.1719234744.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Run BPF selftests bpf_tcp_ca on loongarch:

# ./test_progs -t bpf_tcp_ca

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
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index bceff5900016..8c0306f344e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -411,7 +411,8 @@ static void test_update_ca(void)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		return;
 
 	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
@@ -447,7 +448,8 @@ static void test_update_wrong(void)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		return;
 
 	do_test(&opts);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
@@ -484,7 +486,8 @@ static void test_mixed_links(void)
 	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
-	ASSERT_OK_PTR(link, "attach_struct_ops");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		return;
 
 	do_test(&opts);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
@@ -536,7 +539,8 @@ static void test_link_replace(void)
 	bpf_link__destroy(link);
 
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
-	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops_2nd"))
+		return;
 
 	/* BPF_F_REPLACE with a wrong old map Fd. It should fail!
 	 *
-- 
2.43.0


