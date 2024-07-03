Return-Path: <linux-kselftest+bounces-13129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5611D92558D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 10:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F361F22CD3
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1C13AA3B;
	Wed,  3 Jul 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EofhSv7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5231A89;
	Wed,  3 Jul 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995986; cv=none; b=N1/FXtYOrVb3etq350qfu7PxLFhVphOorThiEFxrbHeq3NnUmxbjD5nIvAxBzWh/y3k4cwa806QWLGBdlS0zTMB3HdJ+svlWD/KjtvlugmWjwu/6ypuzFGmgZwZH5psB/eHG4jtK4rJepUvX+ifMCYlMAzJd67Vickvhb3x0Iks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995986; c=relaxed/simple;
	bh=lbbO2Mjjk3C5FS60AtyK2KRk/mhWt/0lX7ynZChERpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWz9L+mnL3v5ECj1x8DJKAanes6OUycebsUWLGl/urdi9c62yKf0V3FqW5tHg7NVb5MAUONElUHyjfbb8pOvdN2WKYldXfzp3MZ6YDYoTH/Yvx059PBtTxrFzf01qMBhPdY+ftiN+aTDc6/FiwO9gxybxdfYa5b4Vj6xfSV/fGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EofhSv7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C076DC2BD10;
	Wed,  3 Jul 2024 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719995986;
	bh=lbbO2Mjjk3C5FS60AtyK2KRk/mhWt/0lX7ynZChERpg=;
	h=From:To:Cc:Subject:Date:From;
	b=EofhSv7oZoF7lvMXoOmA3s+tKwPh1UvvnoR12UgcUDNbFAUwHdS+AAxqCJFOALCZr
	 AAN8LNG7zVwhjPM6+QeUlaxT2DAxalPQU4yJB2zeOLzb9Qe/4aqqFJhHXCxyjRBC03
	 WgO3aK62tYI3E1d8uFk5PRvXQ5yxGXBeBe52Nwr52HeS/XUDLkdm/QH31Vtu4KnvI1
	 4WdiE4k+Oi6/6LKcHEsSDGmoi6LA1L8MZeLvNPfVa2Gel55UgOlLlDpLjDUv47w78c
	 haV6Upoui0WELXPiq2zBIzofIygwCItgPSYJe+3u2Bd2Iq4gALLEo2UDM3y4BdUL8S
	 NEMWYIGC8TNWQ==
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
	"D . Wythe" <alibuda@linux.alibaba.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v5] skmsg: skip zero length skb in sk_msg_recvmsg
Date: Wed,  3 Jul 2024 16:39:31 +0800
Message-ID: <e3a16eacdc6740658ee02a33489b1b9d4912f378.1719992715.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Run this BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
platform, a kernel panic occurs:

'''
Oops[#1]:
CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE  6.10.0-rc2+ #18
Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
   ... ...
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
Process test_progs (pid: 2824, threadinfo=0000000000863a31, task=...)
Stack : ...
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

Code: ...

---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Fatal exception
Kernel relocated by 0x3510000
 .text @ 0x9000000003710000
 .data @ 0x9000000004d70000
 .bss  @ 0x9000000006469400
---[ end Kernel panic - not syncing: Fatal exception ]---
'''

This crash happens every time when running sockmap_skb_verdict_shutdown
subtest in sockmap_basic.

This crash is because a NULL pointer is passed to page_address() in
sk_msg_recvmsg(). Due to the difference implementations depending on the
architecture, page_address(NULL) will trigger a panic on Loongarch
platform but not on X86 platform. So this bug was hidden on X86 platform
for a while, but now it is exposed on Loongarch platform.

The root cause is a zero length skb (skb->len == 0) is put on the queue.

This zero length skb is a TCP FIN packet, which is sent by shutdown(),
invoked in test_sockmap_skb_verdict_shutdown():

	shutdown(p1, SHUT_WR);

In this case, in sk_psock_skb_ingress_enqueue(), num_sge is zero, and no
page is put to this sge (see sg_set_page in sg_set_page), but this empty
sge is queued into ingress_msg list.

And in sk_msg_recvmsg(), this empty sge is used, and a NULL page is got by
sg_page(sge). Pass this NULL page to copy_page_to_iter(), which passes it
to kmap_local_page() and to page_address(), then kernel panics.

To solve this, we should skip this zero length skb. So in sk_msg_recvmsg(),
if copy is zero, that means it's a zero length skb, skip invoking
copy_page_to_iter(). We are using the EFAULT return triggered by
copy_page_to_iter to check for is_fin in tcp_bpf.c.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v5:
 - update v5 as John suggested.
 - skmsg: skip zero length skb in sk_msg_recvmsg

v4:
 - skmsg: skip empty sge in sk_msg_recvmsg

v3:
 - skmsg: prevent empty ingress skb from enqueuing
   
v2:
 - skmsg: null check for sg_page in sk_msg_recvmsg
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..bbf40b999713 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -434,7 +434,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			page = sg_page(sge);
 			if (copied + copy > len)
 				copy = len - copied;
-			copy = copy_page_to_iter(page, sge->offset, copy, iter);
+			if (copy)
+				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy) {
 				copied = copied ? copied : -EFAULT;
 				goto out;
-- 
2.43.0


