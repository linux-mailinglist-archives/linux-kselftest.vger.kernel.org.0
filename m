Return-Path: <linux-kselftest+bounces-12624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB2091610B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 10:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54813B20A01
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2951482FC;
	Tue, 25 Jun 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goChjrcn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70091474A0;
	Tue, 25 Jun 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303918; cv=none; b=DT7faVaY34D2i/X23qHApkZJg8luA9cTFJClcpQh7iX1gPYvgribvXTH7BZadThLFCocGvUUR1XW0fCf7B4alVSb3hcJlB38m/NUjjA8qX37mEueuXcU55fItTlktt5ySABoK3h2nV7Tx5ve+1lESJedCtS+7xVxZVpeLhnQfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303918; c=relaxed/simple;
	bh=NOh5xw0s5xNDDvjS0rvhfb6yCX/QDWEsU9TJBuvxigs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coI3V4BZu7t3o5UtZ6aFlYwKmXpFcu5wr0Is9v96RMddqDpSjP+y/x2mRV9UoyvTh2I2Pi0jSPa3X1jVrhdc4UYzzjFy+FtIrPJQdCujvinBvsYrID0peNF8xLDrE73eLQagizqa1C5VMa2z79sbSqpVo1nrq3M7nkeQYskY/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goChjrcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F73C4AF0C;
	Tue, 25 Jun 2024 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719303917;
	bh=NOh5xw0s5xNDDvjS0rvhfb6yCX/QDWEsU9TJBuvxigs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=goChjrcnB8iLgq2ptTk2wa5SxCBcW/vtGmXBjhsdevBg7Qm4CAyvj22IfsQfuSpA0
	 aloQAlDXSuRdGEK7kjXH2Ci/J1TdElCkLFoyFipTjnSNqM9GH80zI/DoCpxXl3DPo/
	 KNM57PiqDrYYI746jxRqM9QLARCfG/DhHTo/84ATwtMfkIp0XMWtBApWAL69Avj3FN
	 6rt1EvB/hVPj44EVd3YnXrQ2f6CRTeG2a5qxm0ltUYsYo2RaPn+RTw2R+pR8adPCzk
	 Cdk/+eR88uGU6jaOL0nGo+JMP/17O2gbmBCFTR95EcRR/NIhnAH61oywrcef/SSFeH
	 AmrcLp1JvttFA==
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
Subject: [PATCH bpf-next v2 2/4] skmsg: null check for sg_page in sk_msg_memcopy_from_iter
Date: Tue, 25 Jun 2024 16:24:37 +0800
Message-ID: <3643756b626bf18fdc38dd50fc41c5acca61e9b3.1719302367.git.tanggeliang@kylinos.cn>
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

./test_sockmap

A Kernel panic occurs:

'''
 Oops[#1]:
 CPU: 20 PID: 23245 Comm: test_sockmap Tainted: G           OE      6.10.0-rc2+ #32
 Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018-V4.0.11
 pc 900000000426cd1c ra 90000000043a315c tp 900010008bfbc000 sp 900010008bfbf8a0
 a0 ffffffffffffffe4 a1 900010008bfbfe20 a2 9000100089cd9400 a3 0000000000000003
 a4 900010008bfbfb80 a5 900010008bfbfe20 a6 0000000000000000 a7 00000000000000d3
 t0 0000000000000000 t1 0000000000000000 t2 0000000000008000 t3 0000000000000000
 t4 0000000000000000 t5 0000000000000000 t6 0000000000000006 t7 fffffef1fea12c80
 t8 fffffffffffffffc u0 0000000400000005 s9 0000000000000003 s0 0000000000000000
 s1 0000000000000012 s2 900010008b9bbc00 s3 0000000000000018 s4 0000020000000000
 s5 fffffffffffffffc s6 000000007fffffff s7 0000000000000002 s8 9000100089cd9400
    ra: 90000000043a315c tcp_bpf_sendmsg+0x23c/0x420
   ERA: 900000000426cd1c sk_msg_memcopy_from_iter+0xbc/0x220
  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
  PRMD: 0000000c (PPLV0 +PIE +PWE)
  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
 ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
  BADV: 0000000000000040
  PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
 Modules linked in: tls xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
 Process test_sockmap (pid: 23245, threadinfo=00000000aeb68043, task=00000000781bb2f1)
 Stack : 0000000000000000 900010008bfbfe20 0000000000000000 0000000000000003
         0000000000000000 900010008bfbf94c 900010008bfbf950 0000000000000000
         0000000000000003 0000000000000003 900010008bfbfe10 900010008beeb400
         9000100089cd9400 0000000000000003 900010008b9bbc00 90000000043a315c
         0000000000084000 900010008bfbfe20 900010008bfbf958 900010008beeb5ac
         900010087fffd500 0000000000000000 7fffffffffffffff 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         ...
 Call Trace:
 [<900000000426cd1c>] sk_msg_memcopy_from_iter+0xbc/0x220
 [<90000000043a315c>] tcp_bpf_sendmsg+0x23c/0x420
 [<90000000041cafc8>] __sock_sendmsg+0x68/0xe0
 [<90000000041cc4bc>] ____sys_sendmsg+0x2bc/0x360
 [<90000000041cea18>] ___sys_sendmsg+0xb8/0x120
 [<90000000041cf1f8>] __sys_sendmsg+0x98/0x100
 [<90000000045b76ec>] do_syscall+0x8c/0xc0
 [<90000000030e1da4>] handle_syscall+0xc4/0x160

 Code: 001532f7  0014f210  001036ed <28c10204> 298043ed  28c8632c  0010c5ef  0010bc84  0014ed8c

 ---[ end trace 0000000000000000 ]---
'''

This is because "sg_page(sge)" is NULL in that case. This patch adds null
check for it in sk_msg_memcopy_from_iter() to fix this error.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/core/skmsg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index bafcc1e2eadf..495b18b5dce5 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -375,6 +375,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 
 	do {
 		sge = sk_msg_elem(msg, i);
+		if (!sg_page(sge))
+			goto out;
 		/* This is possible if a trim operation shrunk the buffer */
 		if (msg->sg.copybreak >= sge->length) {
 			msg->sg.copybreak = 0;
-- 
2.43.0


