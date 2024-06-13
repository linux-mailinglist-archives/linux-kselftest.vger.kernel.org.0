Return-Path: <linux-kselftest+bounces-11859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFFA907505
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C67B288017
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA78145FFE;
	Thu, 13 Jun 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLfBRN3D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7B1459EA
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288322; cv=none; b=JH6o8AjkpnVgbgczQvG+2KSQXz8xaPFZ0sYJBNr0OhkjDX8XkbwzuSzw8eQ++yt5KpikjJBJ0/5GMACYdK0Poc+T/Ey3ynfewu/vQKNsxwsRVRCPEK1EYDFnFpUXk6frkgxWgecpe3AUxi1m86JyPpQhfwaxTt3sdB9JdNhuRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288322; c=relaxed/simple;
	bh=85JEwVuIKe/KftRkpLke8Aoka5Lgv+YCkT+qp2fOU5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSh80vcouVR9nWTLAfZUhqnHrf6bPuXxRATZHFIeJJKPjNvPLJaXnJJ/mqvoYQBipCcQDW9u2u2LYByAzFYp1XQdz7NALfXA7CvqoKITAKG4oMzO2eIvdJQjKXDHiDptX7xv3YxNzpvs40oZ/qfH8HYQqzqjNDcjeKCiIOU71zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLfBRN3D; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so1106695a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718288318; x=1718893118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wBzmun2RrCaRgPyNcy89ODI4aX7kCqGzkCYxhF3xnY=;
        b=tLfBRN3Dc1oy1HFX8sK76unqXkHeH+h9HBReZv3Q03XfyneTzXEpmxqZuXj3OJpMJs
         /cF+4VNYMJLhFVe01YGDWuPfin/BkU6gr7jT22cQg9tglgb8YhZXhfcOZkPytPNegntY
         Kn9udAXQrzL8npscipfJvALpRmhC8t5rlmdbjb4FkIaeeBGNhGvs4xGiTsmxECEObLuO
         0ynMDUeaBMEdjP0eUpR0/VFW69fM9H/H/3Xpsz7l5vmq1LdHU5MXpkFwpFF6FuVVQvL5
         6I8pclo/9YZxE0ZqnUd2Pe6I7H9WOhxFVpEB4yRowEmIBTQTokXlP0jePi3B0o5E35RY
         18dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718288318; x=1718893118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wBzmun2RrCaRgPyNcy89ODI4aX7kCqGzkCYxhF3xnY=;
        b=SP/ue+/G1tzF0ixMeqRM9/pPOcFFVDycKztpgLpMk9BPXqpWs7+kQKw5YXD4FJQPlD
         FioH6v2OOxtsNJaz037aDuG9x73aJ0HPK5RiwI9mpQH7HWlOnK1ZnyDEMbh0QIn+Egp5
         xMsP5n4zIi1mW/KgSdymqbH45rdY/n5DF3C5aVgqlIa4Svgz8vTi3jlxb8icEwnA/D5C
         uyhNHjr83oORvYCkPXvaJywaSNnrna9ycaugw2fPTUHsyjtRdg/nt5Ku1NzHiRK2Gkxs
         FWa7lYA/uG1v4dZz9Wj8kK9Tqbynv4A36dSh/X8TeadocynXzGvUa0Ec8AHbOkKxI96t
         efpw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Sql8PjL/Dm4b/8wsfzutXpmk2vsayfxQazn7bzceufFb10m7uaH0xKhcDlcHr+r8JIVnAmKdF9gd0ZPAD7qtYYzHnmu4sycvtPiwnEo5
X-Gm-Message-State: AOJu0YxAJYs0b1TmQq+cI2CUF2THlXNZkS8QFSrAqepCKB8NlSbl0Q47
	ZK53d0F+gB4HK71xTMySk3XBqhd+l4idLLKxvmJFn6ifVGs/xM5q7jirtG0pCdendrOS6j4yNOo
	xKXG5SDxQsaob0n0YJZHjWnHh1LTiK6KPoa06
X-Google-Smtp-Source: AGHT+IGGR91TbvvdCO5M/lcoYEexAy68BO6MkHDSEDuQZJK4BYVHQSKOXB6UDTw4lBZYreUPv3qYPyzkPkZtS6UL4po=
X-Received: by 2002:a17:907:94d1:b0:a6f:4bd5:16bb with SMTP id
 a640c23a62f3a-a6f4bd51782mr329005366b.56.1718288317233; Thu, 13 Jun 2024
 07:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-6-almasrymina@google.com> <322e7317-61dc-4f1e-8706-7db6f5f7a030@bp.renesas.com>
In-Reply-To: <322e7317-61dc-4f1e-8706-7db6f5f7a030@bp.renesas.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 13 Jun 2024 07:18:23 -0700
Message-ID: <CAHS8izO6T-CSgdfGFw8nMu1EMLz7ZOa_t9v+YCO8jXEM_=iT7A@mail.gmail.com>
Subject: Re: [PATCH net-next v12 05/13] page_pool: convert to use netmem
To: Paul Barker <paul.barker.ct@bp.renesas.com>
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
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:36=E2=80=AFAM Paul Barker
<paul.barker.ct@bp.renesas.com> wrote:
>
> On 13/06/2024 02:35, Mina Almasry wrote:
> > Abstrace the memory type from the page_pool so we can later add support
>
> s/Abstrace/Abstract/
>

Thanks, will do.

> > for new memory types. Convert the page_pool to use the new netmem type
> > abstraction, rather than use struct page directly.
> >
> > As of this patch the netmem type is a no-op abstraction: it's always a
> > struct page underneath. All the page pool internals are converted to
> > use struct netmem instead of struct page, and the page pool now exports
> > 2 APIs:
> >
> > 1. The existing struct page API.
> > 2. The new struct netmem API.
> >
> > Keeping the existing API is transitional; we do not want to refactor al=
l
> > the current drivers using the page pool at once.
> >
> > The netmem abstraction is currently a no-op. The page_pool uses
> > page_to_netmem() to convert allocated pages to netmem, and uses
> > netmem_to_page() to convert the netmem back to pages to pass to mm APIs=
,
> >
> > Follow up patches to this series add non-paged netmem support to the
> > page_pool. This change is factored out on its own to limit the code
> > churn to this 1 patch, for ease of code review.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v12:
> > - Fix allmodconfig build error. Very recently renesas/ravb_main.c added
> >   a dependency on page_pool that I missed in my rebase. The dependency
> >   calls page_pool_alloc() directly as it wants to set a custom gfp_mask=
,
> >   which is unique as all other drivers call a wrapper to that function.
> >   Fix it by adding netmem_to_page() in the driver.> - Fix printing netm=
em trace printing (Pavel).
> >
> > v11:
> > - Fix typing to remove sparse warning. (Paolo/Steven)
> >
> > v9:
> > - Fix sparse error (Simon).
> >
> > v8:
> > - Fix napi_pp_put_page() taking netmem instead of page to fix
> >   patch-by-patch build error.
> > - Add net/netmem.h include in this patch to fix patch-by-patch build
> >   error.
> >
> > v6:
> >
> > - Rebased on top of the merged netmem_ref type.
> >
> > Cc: linux-mm@kvack.org
> > Cc: Matthew Wilcox <willy@infradead.org>
> >
> > ---
> >  drivers/net/ethernet/renesas/ravb_main.c |   5 +-
> >  include/linux/skbuff_ref.h               |   4 +-
> >  include/net/netmem.h                     |  15 ++
> >  include/net/page_pool/helpers.h          | 120 ++++++---
> >  include/net/page_pool/types.h            |  14 +-
> >  include/trace/events/page_pool.h         |  30 +--
> >  net/bpf/test_run.c                       |   5 +-
> >  net/core/page_pool.c                     | 304 ++++++++++++-----------
> >  net/core/skbuff.c                        |   8 +-
> >  9 files changed, 305 insertions(+), 200 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/eth=
ernet/renesas/ravb_main.c
> > index c1546b916e4ef..093236ebfeecb 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -303,8 +303,9 @@ ravb_alloc_rx_buffer(struct net_device *ndev, int q=
, u32 entry, gfp_t gfp_mask,
> >
> >       rx_buff =3D &priv->rx_buffers[q][entry];
> >       size =3D info->rx_buffer_size;
> > -     rx_buff->page =3D page_pool_alloc(priv->rx_pool[q], &rx_buff->off=
set,
> > -                                     &size, gfp_mask);
> > +     rx_buff->page =3D netmem_to_page(page_pool_alloc(priv->rx_pool[q]=
,
> > +                                                    &rx_buff->offset,
> > +                                                    &size, gfp_mask));
> >       if (unlikely(!rx_buff->page)) {
> >               /* We just set the data size to 0 for a failed mapping wh=
ich
> >                * should prevent DMA from happening...
>
> [snip]
>
> >
> > -static inline struct page *page_pool_alloc(struct page_pool *pool,
> > -                                        unsigned int *offset,
> > -                                        unsigned int *size, gfp_t gfp)
> > +static inline netmem_ref page_pool_alloc(struct page_pool *pool,
> > +                                      unsigned int *offset,
> > +                                      unsigned int *size, gfp_t gfp)
> >  {
> >       unsigned int max_size =3D PAGE_SIZE << pool->p.order;
> > -     struct page *page;
> > +     netmem_ref netmem;
> >
> >       if ((*size << 1) > max_size) {
> >               *size =3D max_size;
> >               *offset =3D 0;
> > -             return page_pool_alloc_pages(pool, gfp);
> > +             return page_pool_alloc_netmem(pool, gfp);
> >       }
> >
> > -     page =3D page_pool_alloc_frag(pool, offset, *size, gfp);
> > -     if (unlikely(!page))
> > -             return NULL;
> > +     netmem =3D page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
> > +     if (unlikely(!netmem))
> > +             return 0;
> >
> >       /* There is very likely not enough space for another fragment, so=
 append
> >        * the remaining size to the current fragment to avoid truesize
> > @@ -140,7 +142,7 @@ static inline struct page *page_pool_alloc(struct p=
age_pool *pool,
> >               pool->frag_offset =3D max_size;
> >       }
> >
> > -     return page;
> > +     return netmem;
> >  }
> >
> >  /**
> > @@ -154,7 +156,7 @@ static inline struct page *page_pool_alloc(struct p=
age_pool *pool,
> >   * utilization and performance penalty.
> >   *
> >   * Return:
> > - * Return allocated page or page fragment, otherwise return NULL.
> > + * Return allocated page or page fragment, otherwise return 0.
> >   */
> >  static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
> >                                              unsigned int *offset,
> > @@ -162,7 +164,7 @@ static inline struct page *page_pool_dev_alloc(stru=
ct page_pool *pool,
> >  {
> >       gfp_t gfp =3D (GFP_ATOMIC | __GFP_NOWARN);
> >
> > -     return page_pool_alloc(pool, offset, size, gfp);
> > +     return netmem_to_page(page_pool_alloc(pool, offset, size, gfp));
> >  }
>
> I find this API change confusing - why should page_pool_alloc() return a
> netmem_ref but page_pool_dev_alloc() return a struct page *?
>
> Is there any reason to change page_pool_alloc() anyway? It calls
> page_pool_alloc_pages() or page_pool_alloc_frag() as appropriate, both
> of which your patch already converts to wrappers around the appropriate
> _netmem() functions. In all instances where page_pool_alloc() is called
> in this patch, you wrap it with netmem_to_page() anyway, there are no
> calls to page_pool_alloc() added which actually want a netmem_ref.
>

The general gist is that the page_pool API is being converted to use
netmem_ref instead of page. The existing API, which uses struct page,
is kept around transitionally, but meant to be removed and everything
moved to netmem.

APIs that current drivers depend on, like page_pool_dev_alloc(), I've
kept as struct page and added netmem versions when needed. APIs that
had no external users, like page_pool_alloc(), I took the opportunity
to move them to netmem immediately. But you recently depended on that.

I thought page_pool_alloc() was an internal function to the page_pool
not meant to be called from drivers, but the documentation actually
mentions it. Seems like I need to keep it as page* function
transitionally as well. I'll look into making this change you
suggested, there is
no needed page_pool_alloc() caller at the moment.


--
Thanks,
Mina

