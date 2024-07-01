Return-Path: <linux-kselftest+bounces-13000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721E91DCCF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 12:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F5C1C2032B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7659914AD36;
	Mon,  1 Jul 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSaJi1vN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03314387F;
	Mon,  1 Jul 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829764; cv=none; b=iqzV5xKs3Mt8cp4njULZFtltmaVQYCq+P1qmO7WBh2PF9rYKEShbWA13/vLyPj4DJ/ldBEIZuUS30lZYWKhNaJjzJ12pd90t9TcV734SqWwBJYKYaeV+0Sk3Us5wiDmE/21ACfnEztSPFPO2PnlQZ9ZPplH4vrCM4Zu6uIxl+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829764; c=relaxed/simple;
	bh=UG9o16jvyYS4+6xoB60HfYP2wt5ic6/O85OeYKXQS0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlsgGMVNLxEC9bNK5YzyEtuuivGhf4WzSgEG5L5RUUOVWB9rlQuiHaJ1WAmsgHScSyGPdqvx56dhNoqmlryJYRmWBiBN4O7z0S9W2XuPj1vygqyKoz3jfnDvh9u233+wQXic+JU1jYVxee+dd2cie+LFJbI0/BfgVf51gyBJMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSaJi1vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DB1C116B1;
	Mon,  1 Jul 2024 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829763;
	bh=UG9o16jvyYS4+6xoB60HfYP2wt5ic6/O85OeYKXQS0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BSaJi1vNmbuyc0kWf2ru3JDxxcQJlD9a9Zv/culpuD7pbcDxaI8LryxVZ2uKNVdO4
	 TsD64ED6Y6VjrtrLbP/iXme8i7ZK6J98wJJoVViVchC7orKeKk6wdMqMPs7jO92L+J
	 MyffL3AWD1bMVPk4RblgfEeQbwTLftvUM+62qWsjAAdmbfKf1asAxoIaArgEJylH9L
	 pqSKXYKkK9guLGMEpypaKABk/RdmmKzCVR/1xcAIzwDRiMi7nmFKarMJWuJMrnyzGG
	 bncK5kSJCNtt+B7gyL6ewH7Cfx0yUF7ZeHtDnvBTxIcYj8xllcujRRBhgTpOCcHOjn
	 PguEUbiLleXbA==
Message-ID: <9f5c3a9e10f46ef193abdd1c490972147b83a978.camel@kernel.org>
Subject: Re: [PATCH net v3 2/2] skmsg: bugfix for sk_msg sge iteration
From: Geliang Tang <geliang@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
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
Date: Mon, 01 Jul 2024 18:29:12 +0800
In-Reply-To: <70d94a71-2654-4647-97f3-1017adee1fd4@linux.alibaba.com>
References: <cover.1719553101.git.tanggeliang@kylinos.cn>
	 <56d8ec28df901432e7bde4953795166ce2edd472.1719553101.git.tanggeliang@kylinos.cn>
	 <70d94a71-2654-4647-97f3-1017adee1fd4@linux.alibaba.com>
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

Hello,

On Mon, 2024-07-01 at 17:00 +0800, D. Wythe wrote:
> 
> 
> On 6/28/24 1:47 PM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Every time run this BPF selftests (./test_sockmap) on a Loongarch
> > platform,
> > a Kernel panic occurs:
> > 
> > '''
> >   Oops[#1]:
> >   CPU: 20 PID: 23245 Comm: test_sockmap Tainted: G     OE 6.10.0-
> > rc2+ #32
> >   Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS
> > Loongson-UDK2018
> >   ... ...
> >      ra: 90000000043a315c tcp_bpf_sendmsg+0x23c/0x420
> >     ERA: 900000000426cd1c sk_msg_memcopy_from_iter+0xbc/0x220
> >    CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
> >    PRMD: 0000000c (PPLV0 +PIE +PWE)
> >    EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> >    ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> >   ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
> >    BADV: 0000000000000040
> >    PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
> >   Modules linked in: tls xt_CHECKSUM xt_MASQUERADE xt_conntrack
> > ipt_REJECT
> >   Process test_sockmap (pid: 23245, threadinfo=00000000aeb68043,
> > task=...)
> >   Stack : ... ...
> >           ...
> >   Call Trace:
> >   [<900000000426cd1c>] sk_msg_memcopy_from_iter+0xbc/0x220
> >   [<90000000043a315c>] tcp_bpf_sendmsg+0x23c/0x420
> >   [<90000000041cafc8>] __sock_sendmsg+0x68/0xe0
> >   [<90000000041cc4bc>] ____sys_sendmsg+0x2bc/0x360
> >   [<90000000041cea18>] ___sys_sendmsg+0xb8/0x120
> >   [<90000000041cf1f8>] __sys_sendmsg+0x98/0x100
> >   [<90000000045b76ec>] do_syscall+0x8c/0xc0
> >   [<90000000030e1da4>] handle_syscall+0xc4/0x160
> > 
> >   Code: ...
> > 
> >   ---[ end trace 0000000000000000 ]---
> > '''
> > 
> > This crash is because a NULL pointer is passed to page_address() in
> > sk_msg_memcopy_from_iter(). Due to the difference in architecture,
> > page_address(0) will not trigger a panic on the X86 platform but
> > will panic
> > on the Loogarch platform. So this bug was hidden on the x86
> > platform, but
> > now it is exposed on the Loogarch platform.
> > 
> > This bug is a logic error indeed. In sk_msg_memcopy_from_iter(), an
> > invalid
> > "sge" is always used:
> > 
> > 	if (msg->sg.copybreak >= sge->length) {
> > 		msg->sg.copybreak = 0;
> > 		sk_msg_iter_var_next(i);
> > 		if (i == msg->sg.end)
> > 			break;
> > 		sge = sk_msg_elem(msg, i);
> > 	}
> > 
> > If the value of i is 2, msg->sg.end is also 2 when entering this if
> > block.
> > sk_msg_iter_var_next() increases i by 1, and now i is 3, which is
> > no longer
> > equal to msg->sg.end. The break will not be triggered, and the next
> > sge
> > obtained by sk_msg_elem(3) will be an invalid one.
> > 
> > The correct approach is to check (i == msg->sg.end) first, and then
> > invoke
> > sk_msg_iter_var_next() if they are not equal.
> > 
> > Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg
> > interface")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >   net/core/skmsg.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 44952cdd1425..1906d0d0eeac 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -378,9 +378,9 @@ int sk_msg_memcopy_from_iter(struct sock *sk,
> > struct iov_iter *from,
> >   		/* This is possible if a trim operation shrunk the
> > buffer */
> >   		if (msg->sg.copybreak >= sge->length) {
> >   			msg->sg.copybreak = 0;
> > -			sk_msg_iter_var_next(i);
> >   			if (i == msg->sg.end)
> >   				break;
> > +			sk_msg_iter_var_next(i);
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>

Thanks for your review.

But this change breaks test_sockmap. Will send a v4 to fix this.

Changes Requested.

-Geliang

> >   			sge = sk_msg_elem(msg, i);
> >   		}
> >   
> 
> 
> 


