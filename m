Return-Path: <linux-kselftest+bounces-12845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49691A088
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 09:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E633B20DB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C23950291;
	Thu, 27 Jun 2024 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn/b8jWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCA4206E;
	Thu, 27 Jun 2024 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473933; cv=none; b=as5aiRMRD/tEGeLVZ+WJmx2XD3T3SfxM0nfRyjlnV0O3KE0ho5pa8gDMIOzzkXliA6YycqYCtjQIx2a9q6/sBgPMseo7rjOU1h5xyKuuMmjaozsmCrdUV7xrSfg3U9o4o6Axlw7cdJrV4v7khMW7mh4bBNlgh5sLDfLdTECGybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473933; c=relaxed/simple;
	bh=J0sI8ItZ6ejz9OYXPT1/pmqvzHNcX9kTLBQaCvk3Gvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RuIwH62cS9EULqAYHzDrfO9FpVI5piNVt/ZkMqKSc38j6NggGWkXQZB3sfCqZNjmTIi/qIicbWvuH9Y7ly1nsee+et45YgVmvycOv7FdH7I9zE4OKW60k7f+QfeuaEzoolBI/77NTJawbnb5pIPq8yJ1LKMPqtXKJ50M6lZzU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn/b8jWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B819DC32786;
	Thu, 27 Jun 2024 07:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719473933;
	bh=J0sI8ItZ6ejz9OYXPT1/pmqvzHNcX9kTLBQaCvk3Gvw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Hn/b8jWN67dx9I6u0riHfot/pdGmMh0DDJm3iCaWi1wv/VaPcUqeoI9gxClXsqIZG
	 +NZIx68ADWC7tAIXpyPJ/P1fjzue7P+HxfssHMWVawl//JRzm9BKzLhSLECTvNcHpP
	 7SKnkvvh47B9oSUcezd/Cbiev4zNoBl6MJwotD3aES9bJT+8+n1cA5yD1MxRGl7Uwl
	 qX5ELikrXy+466p3XIjLf6CQLoihyDv8lPLgXL9YFsCbIAJKyWskDMq51ckxl7IWg8
	 8YjAuYX29iEJhdDnAMHRLq6RF+Y7lnAO5KUrPj7mn8WnDXm0HpcGwBJ1R7g8VhJGI8
	 mjqF9am0uN5GA==
Message-ID: <ae28b0bc62c76db342c7d5c552eedb1dbc143e49.camel@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/4] skmsg: null check for sg_page in
 sk_msg_recvmsg
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Eric Dumazet
 <edumazet@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko
 <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>, Yuran Pereira
 <yuran.pereira@hotmail.com>, Huacai Chen <chenhuacai@kernel.org>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, Geliang Tang <tanggeliang@kylinos.cn>, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 27 Jun 2024 15:38:43 +0800
In-Reply-To: <c94c939ffe846c7f86daaddaef8661cdfe3f0b8f.camel@kernel.org>
References: <cover.1719302367.git.tanggeliang@kylinos.cn>
	 <072709ce77b04dc77523d4e8763c1fb47bf0913d.1719302367.git.tanggeliang@kylinos.cn>
	 <CANn89i+ET4U+4viDPq2vZhxeUT90kZz5mdh3XVqQhaAXnbs=rw@mail.gmail.com>
	 <667b1c8325bf1_54242089e@john.notmuch>
	 <c94c939ffe846c7f86daaddaef8661cdfe3f0b8f.camel@kernel.org>
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

On Wed, 2024-06-26 at 21:05 +0800, Geliang Tang wrote:
> On Tue, 2024-06-25 at 12:37 -0700, John Fastabend wrote:
> > Eric Dumazet wrote:
> > > On Tue, Jun 25, 2024 at 10:25 AM Geliang Tang
> > > <geliang@kernel.org>
> > > wrote:
> > > > 
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > Run the following BPF selftests on Loongarch:
> > > > 
> > > > ./test_progs -t sockmap_basic
> > > > 
> > > > A Kernel panic occurs:
> > > > 
> > > > '''
> > > >  Oops[#1]:
> > > >  CPU: 22 PID: 2824 Comm: test_progs Tainted: G          
> > > > OE     
> > > > 6.10.0-rc2+ #18
> > > >  Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS
> > > > Loongson-UDK2018-V4.0.11
> > > >  pc 9000000004162774 ra 90000000048bf6c0 tp 90001000aa16c000 sp
> > > > 90001000aa16fb90
> > > >  a0 0000000000000000 a1 0000000000000000 a2 0000000000000000 a3
> > > > 90001000aa16fd70
> > > >  a4 0000000000000800 a5 0000000000000000 a6 000055557b63aae8 a7
> > > > 00000000000000cf
> > > >  t0 0000000000000000 t1 0000000000004000 t2 0000000000000048 t3
> > > > 0000000000000000
> > > >  t4 0000000000000001 t5 0000000000000002 t6 0000000000000001 t7
> > > > 0000000000000002
> > > >  t8 0000000000000018 u0 9000000004856150 s9 0000000000000000 s0
> > > > 0000000000000000
> > > >  s1 0000000000000000 s2 90001000aa16fd70 s3 0000000000000000 s4
> > > > 0000000000000000
> > > >  s5 0000000000004000 s6 900010009284dc00 s7 0000000000000001 s8
> > > > 900010009284dc00
> > > >     ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
> > > >    ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
> > > >   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
> > > >   PRMD: 0000000c (PPLV0 +PIE +PWE)
> > > >   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> > > >   ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> > > >  ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
> > > >   BADV: 0000000000000040
> > > >   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
> > > >  Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE
> > > > xt_conntrack
> > > >  Process test_progs (pid: 2824, threadinfo=0000000000863a31,
> > > > task=000000001cba0874)
> > > >  Stack : 0000000000000001 fffffffffffffffc 0000000000000000
> > > > 0000000000000000
> > > >          0000000000000018 0000000000000000 0000000000000000
> > > > 90000000048bf6c0
> > > >          90000000052cd638 90001000aa16fd70 900010008bf51580
> > > > 900010009284f000
> > > >          90000000049f2b90 900010009284f188 900010009284f178
> > > > 90001000861d4780
> > > >          9000100084dccd00 0000000000000800 0000000000000007
> > > > fffffffffffffff2
> > > >          000000000453e92f 90000000049aae34 90001000aa16fd60
> > > > 900010009284f000
> > > >          0000000000000000 0000000000000000 900010008bf51580
> > > > 90000000049f2b90
> > > >          0000000000000001 0000000000000000 9000100084dc3a10
> > > > 900010009284f1ac
> > > >          90001000aa16fd40 0000555559953278 0000000000000001
> > > > 0000000000000000
> > > >          90001000aa16fdc8 9000000005a5a000 90001000861d4780
> > > > 0000000000000800
> > > >          ...
> > > >  Call Trace:
> > > >  [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
> > > >  [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
> > > >  [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
> > > >  [<90000000049aae34>] inet_recvmsg+0x54/0x100
> > > >  [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
> > > >  [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
> > > >  [<900000000481e27c>] sys_recvfrom+0x1c/0x40
> > > >  [<9000000004c076ec>] do_syscall+0x8c/0xc0
> > > >  [<9000000003731da4>] handle_syscall+0xc4/0x160
> > > > 
> > > >  Code: 0010b09b  440125a0  0011df8d <28c10364> 0012b70c 
> > > > 00133305  0013b1ac  0010dc84  00151585
> > > > 
> > > >  ---[ end trace 0000000000000000 ]---
> > > >  Kernel panic - not syncing: Fatal exception
> > > >  Kernel relocated by 0x3510000
> > > >   .text @ 0x9000000003710000
> > > >   .data @ 0x9000000004d70000
> > > >   .bss  @ 0x9000000006469400
> > > >  ---[ end Kernel panic - not syncing: Fatal exception ]---
> > > > '''
> > > > 
> > > > This is because "sg_page(sge)" is NULL in that case. This patch
> > > > adds null
> > > > check for it in sk_msg_recvmsg() to fix this error.
> > > > 
> > > > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg
> > > > interface")
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > ---
> > > >  net/core/skmsg.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > > > index fd20aae30be2..bafcc1e2eadf 100644
> > > > --- a/net/core/skmsg.c
> > > > +++ b/net/core/skmsg.c
> > > > @@ -432,6 +432,8 @@ int sk_msg_recvmsg(struct sock *sk, struct
> > > > sk_psock *psock, struct msghdr *msg,
> > > >                         sge = sk_msg_elem(msg_rx, i);
> > > >                         copy = sge->length;
> > > >                         page = sg_page(sge);
> > > > +                       if (!page)
> > > > +                               goto out;
> > > >                         if (copied + copy > len)
> > > >                                 copy = len - copied;
> > > >                         copy = copy_page_to_iter(page, sge-
> > > > > offset, copy, iter);
> > > > --
> > > > 2.43.0
> > > > 
> > > 
> > > This looks pretty much random to me.
> > > 
> > > Please find the root cause, instead of desperately trying to fix
> > > 'tests'.
> > 
> > If this happens then either we put a bad msg_rx on the queue see a
> > few lines
> > up and we need to sort out why that msg_rx was built. Or we walked

I think I have figured out the issue. It's caused by this, an empty skb
(skb->len == 0) is put on the queue.

In this case, in sk_psock_skb_ingress_enqueue(), num_sge is zero, and
no page is put to this sge (see sg_set_page in sg_set_page), but this
empty sge is queued into ingress_msg list.

And in sk_msg_recvmsg(), this empty sge is dequeued, and a NULL page is
got by sg_page(sge). Pass this NULL-page to copy_page_to_iter(), then
kernel panics.

To solve this, I think we should prevent empty skb from putting on the
queue. My new modification is as follows:

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..44952cdd1425 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1184,7 +1184,7 @@ static int sk_psock_verdict_recv(struct sock *sk,
struct sk_buff *skb)
 
        rcu_read_lock();
        psock = sk_psock(sk);
-       if (unlikely(!psock)) {
+       if (unlikely(!psock || !len)) {
                len = 0;
                tcp_eat_skb(sk, skb);
                sock_drop(sk, skb);
-- 

WDYT? I'd like to hear your opinion.

Thanks,
-Geliang

> > off the
> > end of a scatter gather list and need to see why this test isn't
> > sufficient?
> > 
> >   } while ((i != msg_rx->sg.end) && !sg_is_last(sge))
> > 
> > is this happening every time you run the command or did you run
> > this
> > for
> > a long iteration and eventually hit this? I don't see why this
> > would
> > be
> 
> This happens every time when run test_sockmap_skb_verdict_shutdown
> test
> in sockmap_basic. It hits this null page case on X86_64 platform too.
> 
> > specific to your arch though.
> 
> Kernel panics when a null page is passed to kmap_local_page() on
> Loongarch only, and this function is an arch specific one. I think
> this
> issue is somehow related to Loongarch's memory management.
> 
> Thanks,
> -Geliang
> 
> 
> 


