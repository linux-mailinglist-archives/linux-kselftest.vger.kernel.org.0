Return-Path: <linux-kselftest+bounces-13096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0C924CF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 03:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC831C2231E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 01:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAFF139D;
	Wed,  3 Jul 2024 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsbvG4iA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5865C;
	Wed,  3 Jul 2024 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968591; cv=none; b=eq3R4LFtDkqGJ7JSHwC6uyZ+c1pZsy1fBGWZxOFqi2099utnejUdK/I1rXui8NT7d1bMhfdabf+8aIr7nwx1TTHbMyvm0UZ8sNKwGtLi4GxONBTeNRR4HtvdNpBxB/ADBPOKfbt+ecQfCdnATR5bpmd5Or1SIPnjIXZ92/I0fW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968591; c=relaxed/simple;
	bh=4wo2lD1y6lyr3yKDc0DhpPbhMH4zSy9uV7XKRPXC/Aw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YNQfIN8ZdxqkJGUMjXCJa4+UzL6lo7rgRCmg07R+e4052QWQsIH5VRqU9M/oFx/NL+E00gKkBCKwlrd1JNYIuH4tGaFzjlcHWZWqREage+yEW91ACbynuEaiy5S6ac1mC5Jqce3Kr1dkO2zstdft4AXyEQdxdrymG0xgeL0Hkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsbvG4iA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066a3229f4so3200887b3a.2;
        Tue, 02 Jul 2024 18:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719968589; x=1720573389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6n8lv4fymMg3QNDwFo2o+d5Auk2Egz8lr4w2J+CDP8=;
        b=HsbvG4iA+sc/3spAzDTAz83BGrcUOxlWGei0LaGt7I7YCWmTSmn2IurvMlRxOs8ODx
         C4zaevsCGTcZzHl7uiSW2w+edRmKlenIocN1NCrRIctTvnTHJ7HmKC27OpZyRyNVkPHN
         OI2LU4xQ4K7sqRc1phD60T7InLAz4kDoonclXbyCufYOZ/rq4kgvy52BuUsZw35Q6bXt
         owphacrwjic0iPUaZ5CFSktYbC5ZokIMXC7a8l8Q19Dr3L8daLFpABdOlmjVPrsDZawl
         V2M4ZeTGwbdkZ1LbYHgGMQowA0TDL1B/HK5aOTflKRBwwrvGv5c5wxtfZRCKIwbKzhEK
         IacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719968589; x=1720573389;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H6n8lv4fymMg3QNDwFo2o+d5Auk2Egz8lr4w2J+CDP8=;
        b=iWMBke5c9EVEsQVv+AO2RZQfPNfAgM2OIvXxqPsASiInoLTIAIgauYL7TxumYax28P
         jNaVM+YHojfQYOrWMU9epwh/kB7xdPP+hJwGWCnysuJxFRmop/bc1Frn6CqVMviCUh8d
         Xhfj+ggWiHFp1jViE7gVl8fgRhi3kvikJ5oAR8ld4KOzKTAb/995ymx+SfSuylIsAuae
         0hxuWzCfpCabT1gAnJfARi7NtgLvCMgtM03uPJCV7ZprU77RD/t0j+YTId2JCAE7k8v1
         srukSs4h4HbSRUoep7TAaFIeGvkjkgQgOMO1vloxar8jC2UGVMrAxePAEqxFXfK+5aBw
         iqLA==
X-Forwarded-Encrypted: i=1; AJvYcCU9TUVXqp39hijx9f+z1IuhghdRfCgNaO55I6/s3B2RYphvAD8ctzzUWeI7TBM01W40IuP6v/5pbOHXN5eku6EO30GzFMcU//qjOMzag3klVHGhf1LnnGK8B9vtKFb8eJA6aVe/CDZmTv4UBzPx4zDBL19AaGzgY5FNPc3M
X-Gm-Message-State: AOJu0YzWixSVZefNyS9jwF2qqUlW6uVmsToQGDUVGWVS2oJ/OukslosF
	e4Sn75FsYjdoOmGeCgUjYLBgnhO7WzspAzyPgt+2tRmtq2wwXOLE
X-Google-Smtp-Source: AGHT+IE6J2a7lgggM31jC/Jp/P8ov/n84ZefQHuucZrHhVRX7SLL79nZoA4PvethuTvgQ12krsUyUw==
X-Received: by 2002:a05:6a00:3c8d:b0:706:67c9:16d0 with SMTP id d2e1a72fcca58-70aaaee4715mr10390881b3a.26.1719968588301;
        Tue, 02 Jul 2024 18:03:08 -0700 (PDT)
Received: from localhost ([98.97.33.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246e1d9sm9198259b3a.71.2024.07.02.18.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 18:03:07 -0700 (PDT)
Date: Tue, 02 Jul 2024 18:03:06 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Geliang Tang <geliang@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
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
Message-ID: <6684a34ac2143_403d2087e@john.notmuch>
In-Reply-To: <5b6a55017ab616131f7de1268b60cb34e99941a1.1719553101.git.tanggeliang@kylinos.cn>
References: <cover.1719553101.git.tanggeliang@kylinos.cn>
 <5b6a55017ab616131f7de1268b60cb34e99941a1.1719553101.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH net v3 1/2] skmsg: prevent empty ingress skb from
 enqueuing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Run this BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
> platform, a Kernel panic occurs:
> 
> '''
> Oops[#1]:
> CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE  6.10.0-rc2+ #18
> Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
>    ... ...
>    ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
>   ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
>  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>  PRMD: 0000000c (PPLV0 +PIE +PWE)
>  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
>  BADV: 0000000000000040
>  PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
> Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrack
> Process test_progs (pid: 2824, threadinfo=0000000000863a31, task=...)
> Stack : ...
>         ...
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
>  .text @ 0x9000000003710000
>  .data @ 0x9000000004d70000
>  .bss  @ 0x9000000006469400
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
>  net/core/skmsg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index fd20aae30be2..44952cdd1425 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1184,7 +1184,7 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
>  
>  	rcu_read_lock();
>  	psock = sk_psock(sk);
> -	if (unlikely(!psock)) {
> +	if (unlikely(!psock || !len)) {
>  		len = 0;
>  		tcp_eat_skb(sk, skb);
>  		sock_drop(sk, skb);

The skb->len == 0 here is the FIN pkt right? We are using the EFAULT return
triggered by copy_page_to_iter to check for is_fin in tcp_bpf.c.

The concern I have here is if we don't have the skb fin pkt on the recv
queue we might go into wait_data and block instead of return to user when
rcvmsg() is called from user. I wonder if we can write a test for this if
we don't already have one we probably should create one.

Maybe a better fix assuming my assumption about fin being skb->len=0 is
correct?

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..bbf40b999713 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -434,7 +434,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
                        page = sg_page(sge);
                        if (copied + copy > len)
                                copy = len - copied;
-                       copy = copy_page_to_iter(page, sge->offset, copy, iter);
+                       if (copy)
+                               copy = copy_page_to_iter(page, sge->offset, copy, iter);
                        if (!copy) {
                                copied = copied ? copied : -EFAULT;
                                goto out;

Thanks,
John

