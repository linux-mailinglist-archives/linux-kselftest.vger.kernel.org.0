Return-Path: <linux-kselftest+bounces-12995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAEA91DB11
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 11:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A7B1C216D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C08684A5E;
	Mon,  1 Jul 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HX8xRUjL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73084A39;
	Mon,  1 Jul 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824891; cv=none; b=OFjbGYcuLPjCfGrsaNVp0B4/lX60XoFjVDY+ZkO8XjHzVbbQobwedSYvkTo6jBs8FODY+D/g+oBP0IqhzVdOed3Rctk+NIq5Gp47l7+u/3RrgF8Yo0sgw03Nt6O8uUnQM3Sr57ZEtne/tJDuuOFt1T31lXP+x49VvabopC+02QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824891; c=relaxed/simple;
	bh=UGbdqgf/9Fvo9l2zX/CGYhdGSnuNCps876YVS1NTX9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARe1t+LB1AFopbpbRILY/4t7kvNSrrsKqSbJfhOai5uf8obrb1WjZ2Qt+b5dozataiXF7+x0kwb5QV5cUq7ejSyMJfY5t56ww4j5hijYpdMyUZCQ72xnoXuYc1bH4+x8Q7O7ZM8Th8DpCdoEG8rEAFtnG7Lz4S1IhUqtH6cjwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HX8xRUjL; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719824886; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FRI1Dyi5c7hnorQrmeEYTjeSPUtzZqzzroY7gFiFk8s=;
	b=HX8xRUjLPs6W4cmJQ1ztNB0NysfB+OSgNgnX/XyyCo94FEas0rdfZwx9lAeGTQ8BEw2dJqMhpqi5mrabPiWDV9OFUurkkcb1YYHzHc8KBo5WjBfpdXvZmkPZ4HNe1MlPvcHWPhts/3JN/SnQwUsoGDOk84aM9IBb82ai6L7jm8Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0W9cYRWS_1719824883;
Received: from 30.221.145.205(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W9cYRWS_1719824883)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 17:08:04 +0800
Message-ID: <ead4fbea-dfee-4454-b89a-a03166cde0db@linux.alibaba.com>
Date: Mon, 1 Jul 2024 17:08:02 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] skmsg: prevent empty ingress skb from
 enqueuing
To: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, David Ahern <dsahern@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1719553101.git.tanggeliang@kylinos.cn>
 <5b6a55017ab616131f7de1268b60cb34e99941a1.1719553101.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <5b6a55017ab616131f7de1268b60cb34e99941a1.1719553101.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/28/24 1:47 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Run this BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
> platform, a Kernel panic occurs:
>
> '''
> Oops[#1]:
> CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE  6.10.0-rc2+ #18
> Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
>     ... ...
>     ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
>    ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
>   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>   PRMD: 0000000c (PPLV0 +PIE +PWE)
>   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>   ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
>   BADV: 0000000000000040
>   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
> Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrack
> Process test_progs (pid: 2824, threadinfo=0000000000863a31, task=...)
> Stack : ...
>          ...
> Call Trace:
> [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
> [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
> [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
> [<90000000049aae34>] inet_recvmsg+0x54/0x100
> [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
> [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
> [<900000000481e27c>] sys_recvfrom+0x1c/0x40
> [<9000000004c076ec>] do_syscall+0x8c/0xc0
> [<9000000003731da4>] handle_syscall+0xc4/0x160
>
> Code: ...
>
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Fatal exception
> Kernel relocated by 0x3510000
>   .text @ 0x9000000003710000
>   .data @ 0x9000000004d70000
>   .bss  @ 0x9000000006469400
> ---[ end Kernel panic - not syncing: Fatal exception ]---
> '''
>
> This crash happens every time when running sockmap_skb_verdict_shutdown
> subtest in sockmap_basic.
>
> This crash is because a NULL pointer is passed to page_address() in
> sk_msg_recvmsg(). Due to the difference in architecture, page_address(0)
> will not trigger a panic on the X86 platform but will panic on the
> Loogarch platform. So this bug was hidden on the x86 platform, but now
> it is exposed on the Loogarch platform.

Maybe Loongarch ?  Besides that, LGTM.
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>

>
> The root cause is an empty skb (skb->len == 0) is put on the queue.
>
> In this case, in sk_psock_skb_ingress_enqueue(), num_sge is zero, and no
> page is put to this sge (see sg_set_page in sg_set_page), but this empty
> sge is queued into ingress_msg list.
>
> And in sk_msg_recvmsg(), this empty sge is used, and a NULL page is
> got by sg_page(sge). Pass this NULL-page to copy_page_to_iter(), it
> passed to kmap_local_page() and page_address(), then kernel panics.
>
> To solve this, we should prevent empty skb from putting on the queue. So
> in sk_psock_verdict_recv(), if the skb->len is zero, drop this skb.
>
> Fixes: ef5659280eb1 ("bpf, sockmap: Allow skipping sk_skb parser program")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   net/core/skmsg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index fd20aae30be2..44952cdd1425 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1184,7 +1184,7 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
>   
>   	rcu_read_lock();
>   	psock = sk_psock(sk);
> -	if (unlikely(!psock)) {
> +	if (unlikely(!psock || !len)) {
>   		len = 0;
>   		tcp_eat_skb(sk, skb);
>   		sock_drop(sk, skb);


