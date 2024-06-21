Return-Path: <linux-kselftest+bounces-12462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE66912D7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFBB283863
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834017B4F5;
	Fri, 21 Jun 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ep4qjsFk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97A179203
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995728; cv=none; b=Y6B6+D9ky4jAo96c6gbusn09Jt42WtQJM/Rxin5RRsJt/d1U1RsswRdyGeYDdP8cLTLnKmkPB+NiCq8cJVgC4TLGA+u6C4xcVpeQksQZw1Dxfo123tg1/X9dRX3EM8LWJcimoLwRNLdOR1PRq8RmoCnmnRfSwXHQg31JY4hyLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995728; c=relaxed/simple;
	bh=OSlxMUbH1cjP63rf/i9A5OnYZ1MoT2re527p17lrMmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQfH7VHhIU8Xf9B4ssysKv1cWA7DWJog65eDYXt9Irr7uxjc4NT1/q8VaRMkiEFBqU+hIqXNjhaOydY4HwLA9yCFY8qTz2imXArDmEnyXnX66Tzbo8JErT3JxqJUDZt+sNU/HkKoiBv1ALTR3+GhLiB+51c52FO8tFxmbUIa6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ep4qjsFk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f0e153eddso300908866b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718995724; x=1719600524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlvzkk98R2AMG0Z6R+7nntNyc9a9ODPBi8r4EwCvbRQ=;
        b=ep4qjsFklEFqpVJUKWocum5m/Io13lGRq4EdyZT2oV2jz2VRFNLFt8t0MBi0IBPJnr
         jTAkMIfj2nMJb/FnGlSYVFbFSKkwzFxEsH401JxThJZJ4Q1OqDVTYTun8UGcgBg4BXLD
         pDtpH/J7194OprEHFUy1tgWVSqfPoP9Qcw2wzPPgoS6znpxnWW2RYg3Ik481uFXByHur
         8t1R8AucQu05yVQZxgfYqKr31+T+yw8tdIwe74GztkEsz3utwTPtu9muIve8NgwRtL9l
         Wd4wCdN9Kn3pLEt0YBYb1lBp5zl9qLpVPm1rqI4Zhjhc4VMoBaxUKeleB9XZx9PLURO9
         2QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995724; x=1719600524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlvzkk98R2AMG0Z6R+7nntNyc9a9ODPBi8r4EwCvbRQ=;
        b=nLTjR6hVkcMmPeuaZJVHNg8NZX/eFATmH0tWLhmrufQSlfAgFFaiYk6zX26HSnQ3x/
         0VwIDnxuHKWdX2tzUyKfqygvbu7YDAekdm/e4SeNyrSzg+UOJbXUFkXQ6hIRQaUJtTCL
         SoL0bZel0pIkLGWJ0cfne7Cgqc5FpWaqE6dLcuHDCtRwslcjf258IxAHFkzvBpnLGtJ2
         IymEwgaMT3/7uiMUOiqeBesq/GiwIcCRR3fYJq6r/5Yx/6sQqWxGim3GLz6d+75ICd2/
         92k4ylAajwaPqo5dtPbWrOHH6D0pZ36Jy5tr3oODluo75qvZNWy3nfvjTpNVNdIZonB6
         Jf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGO77F3vec0QvVGOVVVYFn68Cc2t22Yf4iavp9e68WyHZvd4ncpgzXCyN/ip1MyibCcqSfLfp38d7FOpXTfjbW6R4OE6yvSO/cP0ndHSIE
X-Gm-Message-State: AOJu0YwhGnkKPnumsodHL1dNJDgkV4PGWlNusmaHuAxtLpgMp0koh5/d
	HiXdeUMamyO9aKB1GbtXV846oc5zBun/vS5qxwnT2XMuj41sE47Gj4Qe3fUqaT8UHKbQPsobx74
	NHc75soTU69cFhD7cWkH/itJspFviJ6FT8JfE
X-Google-Smtp-Source: AGHT+IFB0A55nMGApv5jFWmOQotPDfRzqqPIQ74RIyN5NL9KIVshccHHA4pJlBegEvYv4fDuzVclwWQ3R4BpwgBCJ4w=
X-Received: by 2002:a17:907:a644:b0:a6f:b60c:2c08 with SMTP id
 a640c23a62f3a-a6fb60c2f79mr565339266b.24.1718995723769; Fri, 21 Jun 2024
 11:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-7-almasrymina@google.com> <439590d4-0f05-4f5e-80ec-e7fdf214e307@gmail.com>
In-Reply-To: <439590d4-0f05-4f5e-80ec-e7fdf214e307@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Jun 2024 11:48:30 -0700
Message-ID: <CAHS8izNr4x6SW0oY_VJDPZOsrBQEAyJO1qVJQbu8VNJQMtX9Sg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 06/13] page_pool: devmem support
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:17=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 6/13/24 02:35, Mina Almasry wrote:
> > Convert netmem to be a union of struct page and struct netmem. Overload
> > the LSB of struct netmem* to indicate that it's a net_iov, otherwise
> > it's a page.
> >
> > Currently these entries in struct page are rented by the page_pool and
> > used exclusively by the net stack:
> >
> > struct {
> >       unsigned long pp_magic;
> >       struct page_pool *pp;
> >       unsigned long _pp_mapping_pad;
> >       unsigned long dma_addr;
> >       atomic_long_t pp_ref_count;
> > };
> >
> > Mirror these (and only these) entries into struct net_iov and implement
> > netmem helpers that can access these common fields regardless of
> > whether the underlying type is page or net_iov.
> >
> > Implement checks for net_iov in netmem helpers which delegate to mm
> > APIs, to ensure net_iov are never passed to the mm stack.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> Apart from small comments below
>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>
>
> > ---
> >   include/net/netmem.h            | 137 ++++++++++++++++++++++++++++++-=
-
> >   include/net/page_pool/helpers.h |  25 +++---
> >   net/core/devmem.c               |   3 +
> >   net/core/page_pool.c            |  26 +++---
> >   net/core/skbuff.c               |  22 +++--
> >   5 files changed, 168 insertions(+), 45 deletions(-)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 664df8325ece5..35ad237fdf29e 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> ...
> > -/* Converting from page to netmem is always safe, because a page can a=
lways be
> > - * a netmem.
> > - */
> >   static inline netmem_ref page_to_netmem(struct page *page)
> >   {
> >       return (__force netmem_ref)page;
> > @@ -68,17 +107,103 @@ static inline netmem_ref page_to_netmem(struct pa=
ge *page)
> >
> >   static inline int netmem_ref_count(netmem_ref netmem)
> >   {
> > +     /* The non-pp refcount of net_iov is always 1. On net_iov, we onl=
y
> > +      * support pp refcounting which uses the pp_ref_count field.
> > +      */
> > +     if (netmem_is_net_iov(netmem))
> > +             return 1;
> > +
> >       return page_ref_count(netmem_to_page(netmem));
> >   }
> >
> >   static inline unsigned long netmem_to_pfn(netmem_ref netmem)
> >   {
> > +     if (netmem_is_net_iov(netmem))
> > +             return 0;
>
> IIRC 0 is a valid pfn. Not much of a concern since it's
> used only for tracing, but might make sense to pass some
> invalid pfn if there is one
>

AFAIU all non-negative pfns are technically valid pfns if the machine
is big enough.

I could have this function return long long instead of unsigned long
so I can return a negative number for errors, and then cast to
unsigned long when I figure out it's actually a pfn. Seemed like such
a hassle especially since the call site is just tracing that I figured
it's not that worth it.

> > +
> >       return page_to_pfn(netmem_to_page(netmem));
> >   }
> >
> ...
> >   static inline netmem_ref netmem_compound_head(netmem_ref netmem)
> >   {
> > +     /* niov are never compounded */
> > +     if (netmem_is_net_iov(netmem))
> > +             return netmem;
> > +
> >       return page_to_netmem(compound_head(netmem_to_page(netmem)));
> >   }
> >
> > +static inline void *netmem_address(netmem_ref netmem)
>
> I don't think it's used anywhere, do I miss it?
>

Ah, It's used by the GVE devmem implementation:
https://github.com/mina/linux/commit/da89baa81873d457cbf7b49ee6b4f0d66855b2=
05

I could leave it out of this patch, then add it with the follow up GVE
devmem implementation, but I figured almost for sure drivers are going
to need this eventually, and it's small, so just put it here.

> > +{
> > +     if (netmem_is_net_iov(netmem))
> > +             return NULL;
> > +
> > +     return page_address(netmem_to_page(netmem));
> > +}
> > +
> ...
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index a5957d3359762..1152e3547795a 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -26,6 +26,8 @@
> ...
> >
> >   /* If the page refcnt =3D=3D 1, this will try to recycle the page.
> > @@ -714,7 +713,7 @@ __page_pool_put_page(struct page_pool *pool, netmem=
_ref netmem,
> >        * refcnt =3D=3D 1 means page_pool owns page, and can recycle it.
> >        *
> >        * page is NOT reusable when allocated when system is under
> > -      * some pressure. (page_is_pfmemalloc)
> > +      * some pressure. (page_pool_page_is_pfmemalloc)
>
> There is no page_pool_page_is_pfmemalloc()
>

Thanks done. I implemented most of your other comments on all the
patches btw. I'm only responding to the ones I didn't apply for
various reasons. Thanks for the review!


--=20
Thanks,
Mina

