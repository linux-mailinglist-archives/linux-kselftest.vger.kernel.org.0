Return-Path: <linux-kselftest+bounces-13228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D9928136
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 06:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5821C23FE4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 04:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA450A63;
	Fri,  5 Jul 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYCejJHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7622F52;
	Fri,  5 Jul 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720153525; cv=none; b=SksWQ7mPyqUlQC3tPz+FqbBKy/8lCquiewbxgDXgcGUXcbjmQVwTNQsKMchBaA0nDVCM0wkMCBXwA+2IW4c421JQPNbRlmv7ANdcvC3z9pKR2zTBvvYaoB4Ll4Somb6ieori0pbwVrYFA+zFRgdMibvap962+EfSza0BKosWeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720153525; c=relaxed/simple;
	bh=GhMpJ3vHZjb1nmV7C8oXvAqQiDF7EenMBX7wu4OZvNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Njr1ilROhG29uKXeSUfITzsL6zfJp6okK3YAR6CEEBxjqzEchi6dj6PQFjREyoh1SWYpKL0lb5yYlLOdTcPZ4rcgIPI6Piby9SYTubjgQB5IhBBzNC4KMbE9E6M9MalMg0keQvNCPirLkFMH8kE5YQCEYM9jaKDEqPhAuw7ZmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYCejJHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7375FC116B1;
	Fri,  5 Jul 2024 04:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720153525;
	bh=GhMpJ3vHZjb1nmV7C8oXvAqQiDF7EenMBX7wu4OZvNY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WYCejJHE5p0xasVRz4cw7IAKi92LKVvqzNHTr9oomoysYxjfFLsLtpIf1KHG6i2eA
	 jHjMGJRiptGv3+Kq4zU4xEdU1FPqjQi7iZKBpmGHTOwrHchGc51FyGTqR/kTWwl5rp
	 D2kxyJ8ThJAEQy5pS4Bn4jVTPhQPhkuWNKyjvUC7v16WUZHNziIxdXY0vnSouVQaXm
	 ltOuaAjAnyi3quT1Rk8tXzMBCm5Iy2nNH+D3WBhpZfXo8vL2vVsGY5hfXbwAxyXXtu
	 xxvBxStCW+VgdFinVMFluF1HDeEZKJp20Fa4sgtMZH3BI2OjUjgHCAObIScBP9N425
	 AVKnhLgqg2p5Q==
Message-ID: <d73d54adc5402773ba96871960deeb3defd930ba.camel@kernel.org>
Subject: Re: [PATCH net v3 1/2] skmsg: prevent empty ingress skb from
 enqueuing
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, David Ahern <dsahern@kernel.org>,
  Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko
 <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>, Yuran Pereira
 <yuran.pereira@hotmail.com>, Huacai Chen <chenhuacai@kernel.org>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Date: Fri, 05 Jul 2024 12:25:14 +0800
In-Reply-To: <18bcfc640612f459143faa01b0d921f7c4f4ace1.camel@kernel.org>
References: <cover.1719553101.git.tanggeliang@kylinos.cn>
	 <5b6a55017ab616131f7de1268b60cb34e99941a1.1719553101.git.tanggeliang@kylinos.cn>
	 <6684a34ac2143_403d2087e@john.notmuch>
	 <18bcfc640612f459143faa01b0d921f7c4f4ace1.camel@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John,

On Wed, 2024-07-03 at 09:54 +0800, Geliang Tang wrote:
> On Tue, 2024-07-02 at 18:03 -0700, John Fastabend wrote:
> > Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > Run this BPF selftests (./test_progs -t sockmap_basic) on a
> > > Loongarch
> > > platform, a Kernel panic occurs:
> > > 
> > > '''
> > > Oops[#1]:
> > > CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE 
> > > 6.10.0-
> > > rc2+ #18
> > > Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS
> > > Loongson-
> > > UDK2018
> > >    ... ...
> > >    ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
> > >   ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
> > >  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
> > >  PRMD: 0000000c (PPLV0 +PIE +PWE)
> > >  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> > >  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> > > ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
> > >  BADV: 0000000000000040
> > >  PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
> > > Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE
> > > xt_conntrack
> > > Process test_progs (pid: 2824, threadinfo=0000000000863a31,
> > > task=...)
> > > Stack : ...
> > >         ...
> > > Call Trace:
> > > [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
> > > [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
> > > [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
> > > [<90000000049aae34>] inet_recvmsg+0x54/0x100
> > > [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
> > > [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
> > > [<900000000481e27c>] sys_recvfrom+0x1c/0x40
> > > [<9000000004c076ec>] do_syscall+0x8c/0xc0
> > > [<9000000003731da4>] handle_syscall+0xc4/0x160
> > > 
> > > Code: ...
> > > 
> > > ---[ end trace 0000000000000000 ]---
> > > Kernel panic - not syncing: Fatal exception
> > > Kernel relocated by 0x3510000
> > >  .text @ 0x9000000003710000
> > >  .data @ 0x9000000004d70000
> > >  .bss  @ 0x9000000006469400
> > > ---[ end Kernel panic - not syncing: Fatal exception ]---
> > > '''
> > > 
> > > This crash happens every time when running
> > > sockmap_skb_verdict_shutdown
> > > subtest in sockmap_basic.
> > > 
> > > This crash is because a NULL pointer is passed to page_address()
> > > in
> > > sk_msg_recvmsg(). Due to the difference in architecture,
> > > page_address(0)
> > > will not trigger a panic on the X86 platform but will panic on
> > > the
> > > Loogarch platform. So this bug was hidden on the x86 platform,
> > > but
> > > now
> > > it is exposed on the Loogarch platform.
> > > 
> > > The root cause is an empty skb (skb->len == 0) is put on the
> > > queue.
> > > 
> > > In this case, in sk_psock_skb_ingress_enqueue(), num_sge is zero,
> > > and no
> > > page is put to this sge (see sg_set_page in sg_set_page), but
> > > this
> > > empty
> > > sge is queued into ingress_msg list.
> > > 
> > > And in sk_msg_recvmsg(), this empty sge is used, and a NULL page
> > > is
> > > got by sg_page(sge). Pass this NULL-page to copy_page_to_iter(),
> > > it
> > > passed to kmap_local_page() and page_address(), then kernel
> > > panics.
> > > 
> > > To solve this, we should prevent empty skb from putting on the
> > > queue. So
> > > in sk_psock_verdict_recv(), if the skb->len is zero, drop this
> > > skb.
> > > 
> > > Fixes: ef5659280eb1 ("bpf, sockmap: Allow skipping sk_skb parser
> > > program")
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > >  net/core/skmsg.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > index fd20aae30be2..44952cdd1425 100644
> > > --- a/net/core/skmsg.c
> > > +++ b/net/core/skmsg.c
> > > @@ -1184,7 +1184,7 @@ static int sk_psock_verdict_recv(struct
> > > sock
> > > *sk, struct sk_buff *skb)
> > >  
> > >  	rcu_read_lock();
> > >  	psock = sk_psock(sk);
> > > -	if (unlikely(!psock)) {
> > > +	if (unlikely(!psock || !len)) {
> > >  		len = 0;
> > >  		tcp_eat_skb(sk, skb);
> > >  		sock_drop(sk, skb);
> > 
> > The skb->len == 0 here is the FIN pkt right? We are using the
> > EFAULT
> > return
> > triggered by copy_page_to_iter to check for is_fin in tcp_bpf.c.

I added some logs for debugging and found that this FIN packet do hit
is_fin check in tcp_bpf.c.

> > 
> > The concern I have here is if we don't have the skb fin pkt on the
> > recv
> > queue we might go into wait_data and block instead of return to
> > user
> > when
> > rcvmsg() is called from user. I wonder if we can write a test for
> > this if
> > we don't already have one we probably should create one.

In test_sockmap_skb_verdict_shutdown(), the FIN packet is sent by

	shutdown(p1, SHUT_WR);

and received by

	n = recv(c1, &b, 1, SOCK_NONBLOCK);
	ASSERT_EQ(n, 0, "recv_timeout(fin)");

I think this test has covered the FIN packet scenario already. No need
to add a new one. WDYT?

> > 
> > Maybe a better fix assuming my assumption about fin being skb-
> > >len=0
> > is
> > correct?
> 
> Thanks John. Your fix is much better than mine. I'll use this as v5
> and
> update the commit log. I'll add your "Suggested-by" tag in it.

Anyway, this v5 (skmsg: skip zero length skb in sk_msg_recvmsg) seems
ready to be merged.

Thanks,
-Geliang

> 
> -Geliang
> 
> > 
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index fd20aae30be2..bbf40b999713 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -434,7 +434,8 @@ int sk_msg_recvmsg(struct sock *sk, struct
> > sk_psock *psock, struct msghdr *msg,
> >                         page = sg_page(sge);
> >                         if (copied + copy > len)
> >                                 copy = len - copied;
> > -                       copy = copy_page_to_iter(page, sge->offset,
> > copy, iter);
> > +                       if (copy)
> > +                               copy = copy_page_to_iter(page, sge-
> > > offset, copy, iter);
> >                         if (!copy) {
> >                                 copied = copied ? copied : -EFAULT;
> >                                 goto out;
> > 
> > Thanks,
> > John
> 
> 


