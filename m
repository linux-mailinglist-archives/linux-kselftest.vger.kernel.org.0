Return-Path: <linux-kselftest+bounces-6003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7F873CE6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B2C1F24353
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E773013BADD;
	Wed,  6 Mar 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGPSFtgj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116EC137935
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744711; cv=none; b=Zl56OGs17cZQa2PbK7Ugp3Ne7enc832CpWPpWZpE/qzqgX0WZwWPOZXykq4lZQpJj8Pp3q+35MwA5/2l2zERVN2A358MEPrEJSEUiFh8u0SJyP2Z7H2eZhyKHE61ofPTqDdW5yxfH+fwWPtoK93gObuJsjc9uKHjeqFeh1moG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744711; c=relaxed/simple;
	bh=f1WmBqp+S6Tcw7A8Oq9HJf0VJDtBrJ0ATA6lz8ebmoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsF4Iyjb+MQfUTBVWsEB9X78dU/tUSC7ehSwQ81fMFAVhsoFDMEDTRHINkOliybf/gy6o6VxOAuCcT89Ohdahjx0Jf/QGrTStyoQDJrEcE9xLmXBMX1IzLAy0Hxuu/Oycwzm+7x0/9h9JOv8t2t21FRHIIFIVZ7xrEzMag7Iauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGPSFtgj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44628725e3so2304566b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Mar 2024 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709744707; x=1710349507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1xSBjsofT/9pZS7Yx9G3XGpR9XoFLam+fQU7TnybVs=;
        b=YGPSFtgjiZCZ2/fuo+t9hwJeE6OWJF42MA00e/1bbwxL4sNb2/4OygmNqZk6G1kDV3
         SmmGm7Z2FiRELYmj/mWtsxnVBpHGTCMFWS1a0BaKZalgzAxl0ni/yS8mqyV38GnbNBRr
         yb5Mb8zHgmrFvODzq1rVBfG+fJ0WfZROjkaIjECLEAnstyK2x++QDjrxpzz75DILwvqm
         D5Cn45O4ZK52+wqd/abE/c7vgFqhD1Zn4HWJNk7RFSxd2bjYfoz+Yz3CXo5qaYUpaxL9
         2HSwptCAvjycaff/WigX2F0Ns/pl/6wmEn3v/qS4GPz1tpIuvc7rj5x9lhqJqzb8U0GW
         nGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709744707; x=1710349507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1xSBjsofT/9pZS7Yx9G3XGpR9XoFLam+fQU7TnybVs=;
        b=A3pg3NXPkFLDIRK5py7453R+0qTzdT+ophbgWXi2A05Sm80GQ0shlOr6oj9pbAUUB2
         cHMKY4cIN1uZjM7wcktjPMSS9wXIxVZLqZTZshJatfNMfqpLd5XynWVQTZ1cEI5/7Tr5
         4QPmyyrlx6FAE6l6zATBTcN9vVR8dAkC2qbZgAl9WTodshXUZEPdotsFG8UwgQeQavT9
         0jGM1jYHzkhh1BwmvlHauBB1ZZKfvXOcC3UvpAVLJmNeB19EO151n2rV9zTFvcnsDUb2
         JbkiXp7ajI3mYqv3Ao6rsiXg0Lme/ojSislUfbBOHujEDfaHWrFa4ZBBjaIeyVkRstKG
         Pbxw==
X-Forwarded-Encrypted: i=1; AJvYcCXQbHJ76zkaw/oXtV0u2R0XqIbGHpNaPOIFW9Rm+1f1/fBkqm3esGaVhoop1fBRd3CvA8o0fElSCrDZm2l13Sl0rdCNooKabxbVvFpfVp+Q
X-Gm-Message-State: AOJu0YxDFECduP4Ag/WUFyQuGOClTvksV99WjNOFc2l99WG8vnfIUGH8
	E++sDq8Tbz+qhcLtLZJ5GO0AzhcyCD2biIPtPGpV1s3XbwA5lfl/7DV8FUxn2OwWkSVBlOKcMYa
	g2Un3XqFBJow67iOE0TVTNpdHzASPYs02R3zv
X-Google-Smtp-Source: AGHT+IEFAot1sqpMocgXEq0iHPu0SbjnF94L+Z+kSlPfTE1HrQ8kPH2Z8oVY6d8041os4lHMCzDMgHeBjBfnC6a+Now=
X-Received: by 2002:a17:906:b00b:b0:a44:c583:dfc8 with SMTP id
 v11-20020a170906b00b00b00a44c583dfc8mr9370474ejy.48.1709744706904; Wed, 06
 Mar 2024 09:05:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com> <1b57dac2-4b04-4bec-b2d7-d0edb4fcabbc@davidwei.uk>
 <CAHS8izM5O39mnTQ8mhcQE75amDT4G-3vcgozzjcYsAdd_-he1g@mail.gmail.com> <417f293a-848e-4eb2-b690-c8696079b452@gmail.com>
In-Reply-To: <417f293a-848e-4eb2-b690-c8696079b452@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 09:04:54 -0800
Message-ID: <CAHS8izNPtHb2GnEMviiJTFT_dPxsxgYsNw5V9s-gSC2YnJRPRg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, shakeel.butt@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:30=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 3/5/24 22:36, Mina Almasry wrote:
> > On Tue, Mar 5, 2024 at 1:55=E2=80=AFPM David Wei <dw@davidwei.uk> wrote=
:
> >>
> >> On 2024-03-04 18:01, Mina Almasry wrote:
> >>> +struct memory_provider_ops {
> >>> +     int (*init)(struct page_pool *pool);
> >>> +     void (*destroy)(struct page_pool *pool);
> >>> +     struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
> >>> +     bool (*release_page)(struct page_pool *pool, struct page *page)=
;
> >>
> >> For ZC Rx we added a scrub() function to memory_provider_ops that is
> >> called from page_pool_scrub(). Does TCP devmem not custom behaviour
> >> waiting for all netmem_refs to return before destroying the page pool?
> >> What happens if e.g. application crashes?
> >
> > (sorry for the long reply, but he refcounting is pretty complicated to
> > explain and I feel like we need to agree on how things currently work)
> >
> > Yeah, the addition of the page_pool_scrub() function is a bit of a
> > head scratcher for me. Here is how the (complicated) refcounting works
> > for devmem TCP (assuming the driver is not doing its own recycling
> > logic which complicates things further):
> >
> > 1. When a netmem_ref is allocated by the page_pool (from dmabuf or
> > page), the netmem_get_pp_ref_count_ref()=3D=3D1 and belongs to the page
> > pool as long as the netmem is waiting in the pool for driver
> > allocation.
> >
> > 2. When a netmem is allocated by the driver, no refcounting is
> > changed, but the ownership of the netmem_get_pp_ref_count_ref() is
> > implicitly transferred from the page pool to the driver. i.e. the ref
> > now belongs to the driver until an skb is formed.
> >
> > 3. When the driver forms an skb using skb_rx_add_frag_netmem(), no
> > refcounting is changed, but the ownership of the
> > netmem_get_pp_ref_count_ref() is transferred from the driver to the
> > TCP stack.
> >
> > 4. When the TCP stack hands the skb to the application, the TCP stack
> > obtains an additional refcount, so netmem_get_pp_ref_count_ref()=3D=3D2=
,
> > and frees the skb using skb_frag_unref(), which drops the
> > netmem_get_pp_ref_count_ref()=3D=3D1.
> >
> > 5. When the user is done with the skb, the user calls the
> > DEVMEM_DONTNEED setsockopt which calls napi_pp_put_netmem() which
> > recycles the netmem back to the page pool. This doesn't modify any
> > refcounting, but the refcount ownership transfers from the userspace
> > back to the page pool, and we're back at step 1.
> >
> > So all in all netmem can belong either to (a) the page pool, or (b)
> > the driver, or (c) the TCP stack, or (d) the application depending on
> > where exactly it is in the RX path.
> >
> > When an application running devmem TCP crashes, the netmem that belong
> > to the page pool or driver are not touched, because the page pool is
> > not tied to the application in our case really. However, the TCP stack
> > notices the devmem socket of the application close, and when it does,
> > the TCP stack will:
> >
> > 1. Free all the skbs in the sockets receive queue. This is not custom
> > behavior for devmem TCP, it's just standard for TCP to free all skbs
> > waiting to be received by the application.
> > 2. The TCP stack will free references that belong to the application.
> > Since the application crashed, it will not call the DEVMEM_DONTNEED
> > setsockopt, so we need to free those on behalf of the application.
> > This is done in this diff:
> >
> > @@ -2498,6 +2498,15 @@ static void tcp_md5sig_info_free_rcu(struct
> > rcu_head *head)
> >   void tcp_v4_destroy_sock(struct sock *sk)
> >   {
> >    struct tcp_sock *tp =3D tcp_sk(sk);
> > + __maybe_unused unsigned long index;
> > + __maybe_unused void *netmem;
> > +
> > +#ifdef CONFIG_PAGE_POOL
> > + xa_for_each(&sk->sk_user_frags, index, netmem)
> > + WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem, false));
> > +#endif
> > +
> > + xa_destroy(&sk->sk_user_frags);
> >
> >    trace_tcp_destroy_sock(sk);
> >
> > To be honest, I think it makes sense for the TCP stack to be
> > responsible for putting the references that belong to it and the
> > application. To me, it does not make much sense for the page pool to
> > be responsible for putting the reference that belongs to the TCP stack
> > or driver via a page_pool_scrub() function, as those references do not
> > belong to the page pool really. I'm not sure why there is a diff
> > between our use cases here because I'm not an io_uring expert. Why do
> > you need to scrub all the references on page pool destruction? Don't
> > these belong to non-page pool components like io_uring stack or TCP
> > stack ol otherwise?
>
> That one is about cleaning buffers that are in b/w 4 and 5, i.e.
> owned by the user, which devmem does at sock destruction. io_uring
> could get by without scrub, dropping user refs while unregistering
> ifq, but then it'd need to wait for all requests to finish so there
> is no step 4 in the meantime. Might change, can be useful, but it
> was much easier to hook into the pp release loop.
>
> Another concern is who and when can reset ifq / kill pp outside
> of io_uring/devmem. I assume it can happen on a whim, which is
> hard to handle gracefully.
>

If this is about dropping application refs in step 4 & step 5, then
from devmem TCP perspective it must be done on socket close & skb
freeing AFAIU, and not delayed until page_pool destruction. Think
about a stupid or malicious user that does something like:

1. Set up dmabuf binding using netlink api.
2. While (100000):
3.   create devmem TCP socket.
4.   receive some devmem data on TCP socket.
5.   close TCP socket without calling DEVMEM_DONTNEED.
6. clean up dmabuf binding using netlink api.

In this case, we need to drop the references in step 5 when the socket
is destroyed, so the memory is freed to the page pool and available
for the next socket in step 3. We cannot delay the freeing until step
6 when the rx queue is recreated and the page pool is destroyed,
otherwise the net_iovs would leak in the loop and eventually the NIC
would fail to find available memory. The same bug would be
reproducible with io_uring unless you're creating a new page pool for
each new io_uring socket equivalent.

But even outside of this, I think it's a bit semantically off to ask
the page_pool to drop references that belong to the application IMO,
because those references are not the page_pool's.

> --
> Pavel Begunkov

--=20
Thanks,
Mina

