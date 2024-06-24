Return-Path: <linux-kselftest+bounces-12556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E9914E6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817B91F222AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537413D8B2;
	Mon, 24 Jun 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMZZYA4e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783E1311A1;
	Mon, 24 Jun 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235702; cv=none; b=O8q68ZnfS3hkoulFhScNPdeRap5aDiQwsTILjxJJ7z9Bu4+5Z8c+9XsDiXA/H7+JJFSZUyZ0M+hohn8DbnJPHbNNPyc1pjg9w5Cvdi+VPQY2fEhOk4Q8bmes1Si5NvieE42n1ASwTttQV09gU0y2ECkgA4JsKzPV55NrbRk3mU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235702; c=relaxed/simple;
	bh=5Ddt6qeq/cry8dPpV4780GUeJDB/yqbUatiugsUhPSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQfZQnGtU3O63XNBKU2a3uXDporXagSjBs1sX/YtgGQ8N/ZL3L3UNFW0zdGLC7d+BP4Hy8ptLyCWl9uXk0Q2B958K6mMFNzUKUDK0O19s68lTwErBtwhag/baK/Psjl1vtjd7LX72kp8UjDDQ5kbH/se7g31VUB6vcw1rd+Vnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMZZYA4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0473C4AF12;
	Mon, 24 Jun 2024 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719235701;
	bh=5Ddt6qeq/cry8dPpV4780GUeJDB/yqbUatiugsUhPSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMZZYA4ekNe03y5MbivdPdW+01znzLqwtftHEzl2vhjgG8eAjxhF3LlXYnw5Ldm1C
	 gdGQ5ae5j971St3QcT8OMOgwU4NlcLTcxNHNf7h51hm46sqUr1AFWJ8Rdt5UTsEXBQ
	 0WRYPWtk3kzNChzJ8kbsnd7XN7XApr9xznPajmU05ekqLWtsOUrGNho3d/A6c/3Vsu
	 aOMQtSy83VsXlZvoH8gWBV8e1E6Cir1F8+jzsqCNCfxgbcB8tlh7xJzYA+4/CVYJJX
	 /Tiv7V19rTTOwi1tRTph1LA9CX8TM1RM9P6B8FPoQ3865hFqEobzLUbmEgDTx6h0rj
	 HWyE5II+AdVKw==
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
Subject: [PATCH net 2/3] inet: null check for close in inet_release
Date: Mon, 24 Jun 2024 21:27:56 +0800
Message-ID: <7b0b49dff962845b26918fce56cbe4444175db4f.1719234744.git.tanggeliang@kylinos.cn>
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

Run the following BPF selftests on loongarch:

# ./test_progs -t sockmap_listen

A Kernel panic occurs:

'''
 Oops[#1]:
 CPU: 49 PID: 233429 Comm: new_name Tainted: G           OE      6.10.0-rc2+ #20
 Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018-V4.0.11
 pc 0000000000000000 ra 90000000051ea4a0 tp 900030008549c000 sp 900030008549fe00
 a0 9000300152524a00 a1 0000000000000000 a2 900030008549fe38 a3 900030008549fe30
 a4 900030008549fe30 a5 90003000c58c8d80 a6 0000000000000000 a7 0000000000000039
 t0 0000000000000000 t1 90003000c58c8d80 t2 0000000000000001 t3 0000000000000000
 t4 0000000000000001 t5 900000011a1bf580 t6 900000011a3aff60 t7 000000000000006b
 t8 00000fffffffffff u0 0000000000000000 s9 00007fffbbe9e930 s0 9000300152524a00
 s1 90003000c58c8d00 s2 9000000006c81568 s3 0000000000000000 s4 90003000c58c8d80
 s5 00007ffff236a000 s6 00007ffffbc292b0 s7 00007ffffbc29998 s8 00007fffbbe9f180
    ra: 90000000051ea4a0 inet_release+0x60/0xc0
   ERA: 0000000000000000 0x0
  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
  PRMD: 0000000c (PPLV0 +PIE +PWE)
  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
 ESTAT: 00030000 [PIF] (IS= ECode=3 EsubCode=0)
  BADV: 0000000000000000
  PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
 Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp
 Process new_name (pid: 233429, threadinfo=00000000b9196405, task=00000000c01df45b)
 Stack : 0000000000000000 90003000c58c8e20 90003000c58c8d00 900000000505960c
         0000000000000000 9000000101c6ad20 9000300086524540 00000000082e0003
         900030008bf57400 90000000050596bc 900030008bf57400 900000000434acac
         0000000000000016 00007ffff224e060 00007fffbbe9f180 900030008bf57400
         0000000000000000 9000000004341ce0 00007fffbbe9f180 00007ffff2369000
         900030008549fec0 90000000054476ec 000000000000006b 9000000003f71da4
         000000000000003a 00007ffff22b8a44 00007fffbbe9f8e0 00007fffbbe9e680
         ffffffffffffffda 0000000000000000 0000000000000000 0000000000000000
         00007fffbbe9f288 0000000000000000 0000000000000000 0000000000000039
         84c2431493ceab6e 84c23ceb2827425e 0000000000000007 00007ffff2271600
         ...
 Call Trace:
 [<900000000505960c>] __sock_release+0x4c/0xe0
 [<90000000050596bc>] sock_close+0x1c/0x40
 [<900000000434acac>] __fput+0xec/0x2e0
 [<9000000004341ce0>] sys_close+0x40/0xa0
 [<90000000054476ec>] do_syscall+0x8c/0xc0
 [<9000000003f71da4>] handle_syscall+0xc4/0x160

 Code: (Bad address in era)

 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Fatal exception
 Kernel relocated by 0x3d50000
  .text @ 0x9000000003f50000
  .data @ 0x90000000055b0000
  .bss  @ 0x9000000006ca9400
 ---[ end Kernel panic - not syncing: Fatal exception ]---
'''

This is because "close" is NULL in that case. This patch adds null
check for it in inet_release() to fix this error.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/af_inet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b24d74616637..8e926018d011 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -434,7 +434,8 @@ int inet_release(struct socket *sock)
 		if (sock_flag(sk, SOCK_LINGER) &&
 		    !(current->flags & PF_EXITING))
 			timeout = sk->sk_lingertime;
-		sk->sk_prot->close(sk, timeout);
+		if (sk->sk_prot && sk->sk_prot->close)
+			sk->sk_prot->close(sk, timeout);
 		sock->sk = NULL;
 	}
 	return 0;
-- 
2.43.0


