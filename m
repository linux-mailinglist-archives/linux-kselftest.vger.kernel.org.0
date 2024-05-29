Return-Path: <linux-kselftest+bounces-10838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F18D3D4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42ED6B23BF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890F1A38F7;
	Wed, 29 May 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OahVjF+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FD1A0B1F
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003225; cv=none; b=pVx6u+mIWuwA6iZxxYKcU1w6vhYsTglY0MjYhMDRpJ+SDdw3ymy4GL+o2f8BBOi65085Ul/sF1jwYY/zXL6TjuEGLisNKwC/o/zV2vZRftDjczD6Rxf+G+990Pu4+17J8JBHm6kTed/v4eKIFjBlNy4X/QVmG31qZa16B/Rn+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003225; c=relaxed/simple;
	bh=7Dvlwp3cj9kBhnrZACSLGYw+fDrt3VMF9KkgcqNKF7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRuOv58JPd/NHGUS/Zv61BUdxsDc0dEpLoVsB7f6+BdjRRx6K6HVRD8+ZbcssKPgW5m/HpbbaZSF7hK1N90rWmCQf88UK4vCq5TV/IJ/dnj1uFSNV4rNDl/VznOkPBjA7kV0fMnHK3QPimAMkbR5JjtXWCTEr9FLSz3mePdmo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OahVjF+u; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-579cd80450fso407031a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717003220; x=1717608020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6S92XYKao8zmEwYTt3a/Nczc/mks5grdh4+BnfyPTc=;
        b=OahVjF+uze/S9Yn0R/e+72J80Eo14Ndb0JX3BX7MdTwFUtnWHqryLwOZV9e/HwNRn/
         KCzJSttyBaVlcSU8Aii7iGYJnLXOnG/vYNoV9ub7xA++Wb/uaDy335X6NZe/d0MZ4KmA
         Yemfy5Zcudp9/S6EY/5hs9Z0auOiK+7PZnIHC97KPZtxaRwTe04/w8S7LccXPI7E7tWD
         PEuSnKcy5PguqBJ+VJOY+H20C1JqxCF7VOzCbyV9PZf5dOwX7ILRV2T4KIDbhzzMEIgf
         F2HFp+dgVFKGX0yDYiaEGS6Kw/9n2i+uyrYYhyw+0lo+xD51tEUpd0vb5ywrXcox0zmZ
         d3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717003220; x=1717608020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6S92XYKao8zmEwYTt3a/Nczc/mks5grdh4+BnfyPTc=;
        b=wtRwa8GKNszWmyIqUmvCx5LPqjCW7VM+aC6Bf9TrgRay+L9BCmnNNlU4LlP7KXkCsK
         wAc//TMYLRJ8CZNyPkFnMJhIXQcrNfqDnQYSDrhY6bS6jy3U/9w6Dzu3xrkAW+5S39eV
         yxFobzo8M6wrWe4ZYI2WV1azfIkn+scptyK6kEjLcltHN1lWkhGd0cfHGPtaK69FX80i
         sMCDwGMocb6ejjwkn+754QnOB6wNZq+OtI2FTyn/JnzOhCYq75v2NuOnfe9uwOXGp3ub
         LojlBPszHZDGu6KOZSw2Bn+UljOk37V4C2Jsz20P41lsKfo0ng1Le+omti/eLC01hbYm
         neqA==
X-Forwarded-Encrypted: i=1; AJvYcCXw8lJY4plPv4T2lJBuk7/v1sSxJkxjhwiSOGMl6uixu0hWJmBt+gm8gmqeWfOT+VT6aTJcu1HxRthHESeRfKPzE4m5RZRVkA9eKMc9L4K0
X-Gm-Message-State: AOJu0YzWnVpB/a8bzs46fBcGLw7vLg5bC3+aVZkEA8A4jKXACFVZ0u17
	uj+Qq32JA1oB29dyLKo3GngZYOG1Ta5T44bcmG0GblXHD52BK5G8sLr/vARl5IXIALLx8CCcNXn
	RIZ3m2ARZeHE8QwgmzwuXtLkDIgq/E6w+JhY2
X-Google-Smtp-Source: AGHT+IFAhIhHvER4srrkWNvWRV5ZrC6gug/SN6NLXzcRRgpzDjuVBSfERRb5LBk6wrj7S1gKnfcF1nodGURXGds/8UM=
X-Received: by 2002:a17:906:2dc2:b0:a62:c41d:c25f with SMTP id
 a640c23a62f3a-a642d6b1573mr258384666b.21.1717003219656; Wed, 29 May 2024
 10:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-12-almasrymina@google.com> <9097e78d-0e7d-43bd-bafd-e53a4872a4d1@davidwei.uk>
 <CAHS8izOe-uYjm0ttQgHOFpvp_Tj4_oRHV6d1Y1sWJAZJdCdCBA@mail.gmail.com> <29464e46-e196-47aa-9ff5-23173099c95e@gmail.com>
In-Reply-To: <29464e46-e196-47aa-9ff5-23173099c95e@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 29 May 2024 10:20:03 -0700
Message-ID: <CAHS8izOnD3J3i+z1nxg=AZQW9dm0w2JBtbg2=oouiER8xqeRPA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 11/14] tcp: RX path for devmem TCP
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
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
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 7:42=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 5/28/24 18:36, Mina Almasry wrote:
> > On Wed, May 22, 2024 at 11:02=E2=80=AFPM David Wei <dw@davidwei.uk> wro=
te:
> ...
> >>> +                      */
> >>> +                     if (!skb_frag_net_iov(frag)) {
> >>> +                             net_err_ratelimited("Found non-dmabuf s=
kb with net_iov");
> >>> +                             err =3D -ENODEV;
> >>> +                             goto out;
> >>> +                     }
> >>> +
> >>> +                     niov =3D skb_frag_net_iov(frag);
> >>
> >> Sorry if we've already discussed this.
> >>
> >> We have this additional hunk:
> >>
> >> + if (niov->pp->mp_ops !=3D &dmabuf_devmem_ops) {
> >> +       err =3D -ENODEV;
> >> +       goto out;
> >> + }
> >>
> >> In case one of our skbs end up here, skb_frag_is_net_iov() and
> >> !skb_frags_readable(). Does this even matter? And if so then is there =
a
> >> better way to distinguish between our two types of net_iovs?
> >
> > Thanks for bringing this up, yes, maybe we do need a way to
> > distinguish, but it's not 100% critical, no? It's mostly for debug
> > checking?
>
> Not really. io_uring definitely wouldn't want the devmem completion path
> taking an iov and basically stashing it into a socket (via refcount),
> that's a lifetime problem. Nor we'd have all the binding/chunk_owner
> parts you have and probably use there.
>
> Same the other way around, you don't want io_uring grabbing your iov
> and locking it up, it won't even be possible to return it back. We
> also may want to have access to backing pages for different fallback
> purposes, for which we need to know the iov came from this particular
> ring.
>
> It shouldn't happen for a behaving user, but most of it would likely
> be exploitable one way or another.
>
> > I would say add a helper, like net_iov_is_dmabuf() or net_iov_is_io_uri=
ng().
>
> We're verifying that the context the iov bound to is the current
> context (e.g. io_uring instance) we're executing from. If we can
> agree that mp_priv should be a valid pointer, the check would look
> like:
>
> if (pp->mp_priv =3D=3D io_uring_ifq)
>
> > Checking for niov->pp->mp_ops seems a bit hacky to me, and may be
> > outright broken. IIRC niov's can be disconnected from the page_pool
> > via page_pool_clear_pp_info(), and niov->pp may be null. Abstractly
>
> It's called in the release path like page_pool_return_page(),
> I can't imagine someone can sanely clear it while inflight ...
>

Ah, yes, I wasn't sure what happens to the inflight pages when the pp
gets destroyed. I thought maybe the pp would return the inflight
pages, but it looks to me like the pp just returns the free pages in
the alloc cache and the ptr_ring, and the pp stays alive until all the
inflight pages are freed. So indeed niov->pp should always be valid
while it's in flight. I still prefer to have the memory type to be
part of the niov itself, but I don't feel strongly at this point; up
to you.

> > speaking the niov type maybe should be a property of the niov itself,
> > and not the pp the niov is attached to.
>
> ... but I can just stash all that in niov->owner,
> struct dmabuf_genpool_chunk_owner you have. That might be even
> cleaner. And regardless of it I'll be making some minor changes
> to the structure to make it generic.
>
> > It is not immediately obvious to me what the best thing to do here is,
> > maybe it's best to add a flag to niov or to use niov->pp_magic for
> > this.
> >
> > I would humbly ask that your follow up patchset takes care of this
> > bit, if possible. I think mine is doing quite a bit of heavy lifting
> > as is (and I think may be close to ready?), when it comes to concerns
> > of devmem + io_uring coexisting if you're able to take care, awesome,
> > if not, I can look into squashing some fix.
>
> Let it be this way then. It's not a problem while there is
> only one such a provider.
>

Thank you!

--=20
Thanks,
Mina

