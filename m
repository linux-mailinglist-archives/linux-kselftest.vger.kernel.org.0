Return-Path: <linux-kselftest+bounces-12909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B29591B67E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2B9B21B94
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 05:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEBB44C8F;
	Fri, 28 Jun 2024 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHnVU5YN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A934545;
	Fri, 28 Jun 2024 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553699; cv=none; b=clVjywV00rFWlZaTWTBygvP/CiMoz51SVJkE4dVMtWAKVedA3ileV8A2fBsW9ySbPw60hCL0pFhPDvTATgDaKOa8cA2onOsDSfR3CZkrHJX6k75tKV1ANOaRKfbSQBMSyzrvEm/vKRNc6uTjoNYp3TLqWNIrNBmTapaPPVC+Xf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553699; c=relaxed/simple;
	bh=cf7aEeq4KITc+GrG7B52DGuFkqEwTB5DygtXePdWYGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI+t5Ra8wkh0YeTLaYmg6tqT7cVFdtnPJVate3R6WCfip5ElnWXsymwdzfpWF8lOQwZPdefFBRjwev0fvI7+vYA6TNEk8p523TsTeWiLIY3OHHgbIi7+bL4/KayQwWGgdInL43kGOhER8kJzh92dJ5bf3xbVdsq4KpjO3G+84oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHnVU5YN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F4EC32781;
	Fri, 28 Jun 2024 05:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719553699;
	bh=cf7aEeq4KITc+GrG7B52DGuFkqEwTB5DygtXePdWYGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHnVU5YNbTt0BIbpY+C/Hj4mZScLvhJFv572M3LfRI2GXwPpYg2EGzB3qy4B0m+23
	 McRMknbQJOCAxT9NqrAxlF86tCzIuywPv4ZBivh/OJeHk8vAsWG5fmQaWvXpNy2V76
	 3ds5ebgM8fWd1VxkATDiDqx2V7OZaKh4ptgYueKuzHK98GNRPfFFGtMLQ4VgxgfaOp
	 XTLcmQowzTX0AtfnB+PO14IzEF3Dt3F34o3eVUxtgevsl5X2ZtbNTrzir1Ioqmw+Eq
	 r38g2IM1hVZ2wvLM9vHQmV3VhVBFiGoUpY9yMaMFHgjJ6rlVbBbD5ZiPbo04QG5wjl
	 bfcBsb0ojjNZw==
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
Subject: [PATCH net v3 1/2] skmsg: prevent empty ingress skb from enqueuing
Date: Fri, 28 Jun 2024 13:47:47 +0800
Message-ID: <5b6a55017ab616131f7de1268b60cb34e99941a1.1719553101.git.tanggeliang@kylinos.cn>
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

Run this BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
platform, a Kernel panic occurs:

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
sk_msg_recvmsg(). Due to the difference in architecture, page_address(0)
will not trigger a panic on the X86 platform but will panic on the
Loogarch platform. So this bug was hidden on the x86 platform, but now
it is exposed on the Loogarch platform.

The root cause is an empty skb (skb->len == 0) is put on the queue.

In this case, in sk_psock_skb_ingress_enqueue(), num_sge is zero, and no
page is put to this sge (see sg_set_page in sg_set_page), but this empty
sge is queued into ingress_msg list.

And in sk_msg_recvmsg(), this empty sge is used, and a NULL page is
got by sg_page(sge). Pass this NULL-page to copy_page_to_iter(), it
passed to kmap_local_page() and page_address(), then kernel panics.

To solve this, we should prevent empty skb from putting on the queue. So
in sk_psock_verdict_recv(), if the skb->len is zero, drop this skb.

Fixes: ef5659280eb1 ("bpf, sockmap: Allow skipping sk_skb parser program")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/core/skmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..44952cdd1425 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1184,7 +1184,7 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 
 	rcu_read_lock();
 	psock = sk_psock(sk);
-	if (unlikely(!psock)) {
+	if (unlikely(!psock || !len)) {
 		len = 0;
 		tcp_eat_skb(sk, skb);
 		sock_drop(sk, skb);
-- 
2.43.0


