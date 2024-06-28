Return-Path: <linux-kselftest+bounces-12910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F78691B680
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 07:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065231F239A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055AB46453;
	Fri, 28 Jun 2024 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdvJB7KS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB4249F5;
	Fri, 28 Jun 2024 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553708; cv=none; b=F3cPbFrrT1xNlTo6v/Wg57CZhFuy4OR0+OjgxbTdhDFGGno30cNcZBcbr2p+Mhlj0yKKK7ow1lzBwUQayW8XHRXFFnS0doOgv/+7SOhgEJWwz8jgWeVO80xOnBHVSL/sv13KGciLeHfZH7OgV/th1HUD1TW3e1cpYzdtDhP+F5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553708; c=relaxed/simple;
	bh=OwRJINa0VpSHf4btc8behed4mXZR6PARmtNNKKc9ul8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOBgOLjxFjaD9wUU9EtwJ83eGgBHFjBJndddEz1umkJuu0uuoaYe0Q6lEof71TM3cniAqCtNzQrEwbF1vZmUn9Oe3G5wa5HrwLb5/iYa+9A2PUtSqCz9mC/APVxx24EVCoxSlRm20Jg8SzbBbGGRBN2CGTHDMLjLt79A6Bbo2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdvJB7KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1335EC116B1;
	Fri, 28 Jun 2024 05:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719553708;
	bh=OwRJINa0VpSHf4btc8behed4mXZR6PARmtNNKKc9ul8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdvJB7KSj7DVi4U5dVFIZWaR0+Kc305E8R9meKJdhm6/hYAuOdmWrJeSsibO13wLA
	 PwPCr+lTnw8H9QmDdLsap+f/FCr57hQNlWNQR7rki0mwVF9+XwLzgjY6uMFL0+E8b+
	 shB0fiPFrmsSyndjAhiypoxV1R0qFEiSeJvFhhGfYU/nNdsWQJug9SUdPcaBQxs/6u
	 wu4DZhdD82fOrxF+nU5Zq1wm+cqTkE9ZN78Yqpd1uK+oFDvZY86Sp/CF7aAGy2Ug8Q
	 Vs4ItS4DBozZJjZ6zpAJjAHksCUVxGszyF979SfC8Uvv+ZpgrnG/Z6fHk7i0EGqFs6
	 qM5AY+iWQ86Ow==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	David Ahern <dsahern@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
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
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/2] skmsg: bugfix for sk_msg sge iteration
Date: Fri, 28 Jun 2024 13:47:48 +0800
Message-ID: <56d8ec28df901432e7bde4953795166ce2edd472.1719553101.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719553101.git.tanggeliang@kylinos.cn>
References: <cover.1719553101.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Every time run this BPF selftests (./test_sockmap) on a Loongarch platform,
a Kernel panic occurs:

'''
 Oops[#1]:
 CPU: 20 PID: 23245 Comm: test_sockmap Tainted: G     OE 6.10.0-rc2+ #32
 Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
 ... ...
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
 Process test_sockmap (pid: 23245, threadinfo=00000000aeb68043, task=...)
 Stack : ... ...
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

 Code: ...

 ---[ end trace 0000000000000000 ]---
'''

This crash is because a NULL pointer is passed to page_address() in
sk_msg_memcopy_from_iter(). Due to the difference in architecture,
page_address(0) will not trigger a panic on the X86 platform but will panic
on the Loogarch platform. So this bug was hidden on the x86 platform, but
now it is exposed on the Loogarch platform.

This bug is a logic error indeed. In sk_msg_memcopy_from_iter(), an invalid
"sge" is always used:

	if (msg->sg.copybreak >= sge->length) {
		msg->sg.copybreak = 0;
		sk_msg_iter_var_next(i);
		if (i == msg->sg.end)
			break;
		sge = sk_msg_elem(msg, i);
	}

If the value of i is 2, msg->sg.end is also 2 when entering this if block.
sk_msg_iter_var_next() increases i by 1, and now i is 3, which is no longer
equal to msg->sg.end. The break will not be triggered, and the next sge
obtained by sk_msg_elem(3) will be an invalid one.

The correct approach is to check (i == msg->sg.end) first, and then invoke
sk_msg_iter_var_next() if they are not equal.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/core/skmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 44952cdd1425..1906d0d0eeac 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -378,9 +378,9 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 		/* This is possible if a trim operation shrunk the buffer */
 		if (msg->sg.copybreak >= sge->length) {
 			msg->sg.copybreak = 0;
-			sk_msg_iter_var_next(i);
 			if (i == msg->sg.end)
 				break;
+			sk_msg_iter_var_next(i);
 			sge = sk_msg_elem(msg, i);
 		}
 
-- 
2.43.0


