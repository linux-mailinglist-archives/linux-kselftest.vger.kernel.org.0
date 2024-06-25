Return-Path: <linux-kselftest+bounces-12623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D7916107
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 10:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F094B1F2291E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17639148307;
	Tue, 25 Jun 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAwZY4P5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A31474A0;
	Tue, 25 Jun 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303911; cv=none; b=lfn5toCX72oa0r+p4VxfUQrWYrS91qeRAYUi2cZYGORRdDZnG1vQ9Q7tBt9VVIyQ7qv0uQ6gbkxIcSmh79noBQWxBcM8pZh2qLe4+4L2Yz5Yio9MEl79CGEUXNC0k+Go5z2bYG8feX6duy96ajJ7iyEhqfxUGacOWvNM6VHk/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303911; c=relaxed/simple;
	bh=GV6RzNRiu+NFo0nRbcqXXn65F5CbOzF0HE2HroGeUgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6IAmCD0aw9ZbJ6ImTiImegRxfGgXLMkJscvmSDJPrsOuX4RfOE1O5Jbsdj/knFQOFldognp7HSAacyKT9X+9uCag150ZwRkVyayMB9ZfKqdqZl9WqBxlNBmQv+UmW58kWi9CVudSP+bj4GwqEPnRZk9QmgwCI3piuS7KslCsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAwZY4P5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1580C32789;
	Tue, 25 Jun 2024 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719303909;
	bh=GV6RzNRiu+NFo0nRbcqXXn65F5CbOzF0HE2HroGeUgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAwZY4P5qnXs2cHBEiga+yj3iGNMFi82pL8hcLO4Z/X9mfIlAfJP3ikVng5IqjOw/
	 Q5CiSd7an7Rj/WKCXer4As5VbEOF9/02bh/dnme43GzluUPsjN3pyXQGpkQaFsDHLR
	 fHD1dfLFhbF8QnjXwZHCTl3qDES+49dgr646WyzBhMtDpfl6HkviUoA4ctf76nS5w8
	 dx8WXRWWbU2djtRuKkCjwVxUPhvX/tyzKuX2nj0yqXsqzR1iRNzmEN2myZXBBGYrhC
	 tgAmSZHcTIDtWrjzNc7vie/YN2bHF1UCMv7ScDhQvGXsdSST6KqDkWFxv3ZZfoTnsJ
	 7OPqDpfkWvtcw==
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
Subject: [PATCH bpf-next v2 1/4] skmsg: null check for sg_page in sk_msg_recvmsg
Date: Tue, 25 Jun 2024 16:24:36 +0800
Message-ID: <072709ce77b04dc77523d4e8763c1fb47bf0913d.1719302367.git.tanggeliang@kylinos.cn>
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

Run the following BPF selftests on Loongarch:

./test_progs -t sockmap_basic

A Kernel panic occurs:

'''
 Oops[#1]:
 CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE      6.10.0-rc2+ #18
 Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018-V4.0.11
 pc 9000000004162774 ra 90000000048bf6c0 tp 90001000aa16c000 sp 90001000aa16fb90
 a0 0000000000000000 a1 0000000000000000 a2 0000000000000000 a3 90001000aa16fd70
 a4 0000000000000800 a5 0000000000000000 a6 000055557b63aae8 a7 00000000000000cf
 t0 0000000000000000 t1 0000000000004000 t2 0000000000000048 t3 0000000000000000
 t4 0000000000000001 t5 0000000000000002 t6 0000000000000001 t7 0000000000000002
 t8 0000000000000018 u0 9000000004856150 s9 0000000000000000 s0 0000000000000000
 s1 0000000000000000 s2 90001000aa16fd70 s3 0000000000000000 s4 0000000000000000
 s5 0000000000004000 s6 900010009284dc00 s7 0000000000000001 s8 900010009284dc00
    ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
   ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
  PRMD: 0000000c (PPLV0 +PIE +PWE)
  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
 ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
  BADV: 0000000000000040
  PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
 Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrack
 Process test_progs (pid: 2824, threadinfo=0000000000863a31, task=000000001cba0874)
 Stack : 0000000000000001 fffffffffffffffc 0000000000000000 0000000000000000
         0000000000000018 0000000000000000 0000000000000000 90000000048bf6c0
         90000000052cd638 90001000aa16fd70 900010008bf51580 900010009284f000
         90000000049f2b90 900010009284f188 900010009284f178 90001000861d4780
         9000100084dccd00 0000000000000800 0000000000000007 fffffffffffffff2
         000000000453e92f 90000000049aae34 90001000aa16fd60 900010009284f000
         0000000000000000 0000000000000000 900010008bf51580 90000000049f2b90
         0000000000000001 0000000000000000 9000100084dc3a10 900010009284f1ac
         90001000aa16fd40 0000555559953278 0000000000000001 0000000000000000
         90001000aa16fdc8 9000000005a5a000 90001000861d4780 0000000000000800
         ...
 Call Trace:
 [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
 [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
 [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
 [<90000000049aae34>] inet_recvmsg+0x54/0x100
 [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
 [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
 [<900000000481e27c>] sys_recvfrom+0x1c/0x40
 [<9000000004c076ec>] do_syscall+0x8c/0xc0
 [<9000000003731da4>] handle_syscall+0xc4/0x160

 Code: 0010b09b  440125a0  0011df8d <28c10364> 0012b70c  00133305  0013b1ac  0010dc84  00151585

 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Fatal exception
 Kernel relocated by 0x3510000
  .text @ 0x9000000003710000
  .data @ 0x9000000004d70000
  .bss  @ 0x9000000006469400
 ---[ end Kernel panic - not syncing: Fatal exception ]---
'''

This is because "sg_page(sge)" is NULL in that case. This patch adds null
check for it in sk_msg_recvmsg() to fix this error.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/core/skmsg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..bafcc1e2eadf 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -432,6 +432,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			sge = sk_msg_elem(msg_rx, i);
 			copy = sge->length;
 			page = sg_page(sge);
+			if (!page)
+				goto out;
 			if (copied + copy > len)
 				copy = len - copied;
 			copy = copy_page_to_iter(page, sge->offset, copy, iter);
-- 
2.43.0


