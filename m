Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584A07E628D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 04:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjKIDUl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 22:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjKIDUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 22:20:40 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBDF26AD
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 19:20:38 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7b9dc928868so120968241.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 19:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699500037; x=1700104837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq3WEnd44vE8jgZXHpA4QQ1qmbAmdjZD/UBm9ibEcLQ=;
        b=Uk1880h0LxRYdfJR9fy6Atdf9CACkGBgxRCp01IpQYyd+nU6+KJJDOpwnYc9o5qAE9
         6Pt4HHohk6wj9OCfsW2Y9mn9yBFqZoFPOuYVRdahMuPzTZat0RSLgUTl/M/kQErinbHH
         k27a0w586gTuLMhHGJOxDk6fqkFnyEw1RPzFlKVJkvp6/1WGqnvSFrlQvXTtdA08vu8X
         EdYget2xOBgZp+Mc94R1RGvt9CsT7oH6FwM/pg3g7l1ZwFQlRM1gPnsMVI7gsO8H4o+6
         0e8l6hUuYeIkk3Spso+/cfYxjGWNxmajeRh1HQ9J1BtoLF5v/MvOx+UCtXd1fnNuADEt
         xT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699500037; x=1700104837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq3WEnd44vE8jgZXHpA4QQ1qmbAmdjZD/UBm9ibEcLQ=;
        b=cj3fweG+ac18lXMf7syr2hyr8Wl59gIF+NnqOoQw+8iY2SNM5W3DshG+GKON8u0XO1
         FxBIwKWQrAUJxYA1QiMtrCbI9y8nrRh1JTVK/76jcdgAQrH3RESen19XPUXbkUmelxgG
         f9YAwds8sLrLVshZqzLLkuk2FsRZS2X7nsOdKW25pBhCKvZst5VXUK1uU8EHGeZRGyjw
         osKG1tU/0PQGNh9euQIc3Y9JdjiKPBHSB8zJrGuDHdGKTOLjLwnsQD3Tpon3LyY2lXDG
         dopxrKNwKCPp0wVdT4aKMtv9kUxhbEkrtilCaEm11H6emp9R5NupVnlFzUUGcgrXHhPb
         2vsQ==
X-Gm-Message-State: AOJu0YxFgaABer5d5v0SRyoFXyw5Zu5OwlLh6sb2XSukUaMW+v5Vzypm
        MHNr82oGQg6zQpROB5kG1N5SHyN1gD9tTp3g4erriDewkxsCI8cB/9Eklg==
X-Google-Smtp-Source: AGHT+IEuh5NgxjrKua8SvctN+++crxKQK/Bd5CzKUuAJSFOtKWUj/OMgQExzWsLLGvFYvuGXIORZ65hgBJVAlS0Att4=
X-Received: by 2002:a05:6102:3d8c:b0:45f:1bed:cec9 with SMTP id
 h12-20020a0561023d8c00b0045f1bedcec9mr3696662vsv.34.1699500037125; Wed, 08
 Nov 2023 19:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-8-almasrymina@google.com> <4a0e9d53-324d-e19b-2a30-ba86f9e5569e@huawei.com>
 <CAHS8izNbw7vAGo2euQGA+TF9CgQ8zwrDqTVGsOSxh22_uo0R1w@mail.gmail.com> <d4309392-711a-75b0-7bf0-9e7de8fd527e@huawei.com>
In-Reply-To: <d4309392-711a-75b0-7bf0-9e7de8fd527e@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 8 Nov 2023 19:20:21 -0800
Message-ID: <CAHS8izM1P6d8jgyWE9wFJUJah2YFsjHP2uikDwA0vR=3QA+BXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/12] page-pool: device memory support
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 8, 2023 at 2:56=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/11/8 5:56, Mina Almasry wrote:
> > On Tue, Nov 7, 2023 at 12:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/11/6 10:44, Mina Almasry wrote:
> >>> Overload the LSB of struct page* to indicate that it's a page_pool_io=
v.
> >>>
> >>> Refactor mm calls on struct page* into helpers, and add page_pool_iov
> >>> handling on those helpers. Modify callers of these mm APIs with calls=
 to
> >>> these helpers instead.
> >>>
> >>> In areas where struct page* is dereferenced, add a check for special
> >>> handling of page_pool_iov.
> >>>
> >>> Signed-off-by: Mina Almasry <almasrymina@google.com>
> >>>
> >>> ---
> >>>  include/net/page_pool/helpers.h | 74 +++++++++++++++++++++++++++++++=
+-
> >>>  net/core/page_pool.c            | 63 ++++++++++++++++++++--------
> >>>  2 files changed, 118 insertions(+), 19 deletions(-)
> >>>
> >>> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/=
helpers.h
> >>> index b93243c2a640..08f1a2cc70d2 100644
> >>> --- a/include/net/page_pool/helpers.h
> >>> +++ b/include/net/page_pool/helpers.h
> >>> @@ -151,6 +151,64 @@ static inline struct page_pool_iov *page_to_page=
_pool_iov(struct page *page)
> >>>       return NULL;
> >>>  }
> >>>
> >>> +static inline int page_pool_page_ref_count(struct page *page)
> >>> +{
> >>> +     if (page_is_page_pool_iov(page))
> >>> +             return page_pool_iov_refcount(page_to_page_pool_iov(pag=
e));
> >>
> >> We have added a lot of 'if' for the devmem case, it would be better to
> >> make it more generic so that we can have more unified metadata handlin=
g
> >> for normal page and devmem. If we add another memory type here, do we
> >> need another 'if' here?
> >
> > Maybe, not sure. I'm guessing new memory types will either be pages or
> > iovs, so maybe no new if statements needed.
> >
> >> That is part of the reason I suggested using a more unified metadata f=
or
> >> all the types of memory chunks used by page_pool.
> >
> > I think your suggestion was to use struct pages for devmem. That was
> > thoroughly considered and intensely argued about in the initial
> > conversations regarding devmem and the initial RFC, and from the
> > conclusions there it's extremely clear to me that devmem struct pages
> > are categorically a no-go.
>
> Not exactly, I was wondering if adding a more abstract structure specific=
ly
> for page pool makes any sense, and each mem type can add its own specific
> fields, net stack only see and handle the common fields so that it does n=
ot
> care about specific mem type, and each provider only see the and handle t=
he
> specific fields belonging to it most of the time.
>
> Ideally something like beleow:
>
> struct netmem {
>         /* common fields */
>         refcount_t refcount;
>         struct page_pool *pp;
>         ......
>
>         union {
>                 struct devmem{
>                         struct dmabuf_genpool_chunk_owner *owner;
>                 };
>
>                 struct other_mem{
>                         ...
>                         ...
>                 };
>         };
> };
>
> But untill we completely decouple the 'struct page' from the net stack,
> the above seems undoable in the near term.

Agreed everything above is undoable.

> But we might be able to do something as folio is doing now, mm subsystem
> is still seeing 'struct folio/page', but other subsystem like slab is usi=
ng
> 'struct slab', and there is still some common fields shared between
> 'struct folio' and 'struct slab'.
>

In my eyes this is almost exactly what I suggested in RFC v1 and got
immediately nacked with no room to negotiate. What we did for v1 is to
allocate struct pages for dma-buf to make dma-bufs look like struct
page to mm subsystem. Almost exactly what you're describing above.
It's a no-go. I don't think renaming struct page to netmem is going to
move the needle (it also re-introduces code-churn). What I feel like I
learnt is that dma-bufs are not struct pages and can't be made to look
like one, I think.

> As the netmem patchset, is devmem able to reuse the below 'struct netmem'
> and rename it to 'struct page_pool_iov'?

I don't think so. For the reasons above, but also practically it
immediately falls apart. Consider this field in netmem:

+ * @flags: The same as the page flags.  Do not use directly.

dma-buf don't have or support page-flags, and making dma-buf looks
like they support page flags or any page-like features (other than
dma_addr) seems extremely unacceptable to mm folks.

> So that 'struct page' for normal
> memory and 'struct page_pool_iov' for devmem share the common fields used
> by page pool and net stack?

Are you suggesting that we'd cast a netmem* to a page* and call core
mm APIs on it? It's basically what was happening with RFC v1, where
things that are not struct pages were made to look like struct pages.

Also, there isn't much upside for what you're suggesting, I think. For
example I can align the refcount variable in struct page_pool_iov with
the refcount in struct page so that this works:

put_page((struct page*)ppiov);

but it's a disaster. Because put_page() will call __put_page() if the
page is freed, and __put_page() will try to return the page to the
buddy allocator!

>  And we might be able to reuse the 'flags',
> '_pp_mapping_pad' and '_mapcount' for specific mem provider, which is eno=
ugh
> for the devmem only requiring a single pointer to point to it's
> owner?
>

All the above seems quite similar to RFC v1 again, using netmem
instead of struct page. In RFC v1 we re-used zone_device_data() for
the dma-buf owner equivalent.

> https://lkml.kernel.org/netdev/20230105214631.3939268-2-willy@infradead.o=
rg/
>
> +/**
> + * struct netmem - A memory allocation from a &struct page_pool.
> + * @flags: The same as the page flags.  Do not use directly.
> + * @pp_magic: Magic value to avoid recycling non page_pool allocated pag=
es.
> + * @pp: The page pool this netmem was allocated from.
> + * @dma_addr: Call netmem_get_dma_addr() to read this value.
> + * @dma_addr_upper: Might need to be 64-bit on 32-bit architectures.
> + * @pp_frag_count: For frag page support, not supported in 32-bit
> + *   architectures with 64-bit DMA.
> + * @_mapcount: Do not access this member directly.
> + * @_refcount: Do not access this member directly.  Read it using
> + *   netmem_ref_count() and manipulate it with netmem_get() and netmem_p=
ut().
> + *
> + * This struct overlays struct page for now.  Do not modify without a
> + * good understanding of the issues.
> + */
> +struct netmem {
> +       unsigned long flags;
> +       unsigned long pp_magic;
> +       struct page_pool *pp;
> +       /* private: no need to document this padding */
> +       unsigned long _pp_mapping_pad;  /* aliases with folio->mapping */
> +       /* public: */
> +       unsigned long dma_addr;
> +       union {
> +               unsigned long dma_addr_upper;
> +               atomic_long_t pp_frag_count;
> +       };
> +       atomic_t _mapcount;
> +       atomic_t _refcount;
> +};
>
> If we do that, it seems we might be able to allow net stack and page pool=
 to see
> the metadata for devmem chunk as 'struct page', and may be able to aovid =
most of
> the 'if' checking in net stack and page pool?
>
> >
> > --
> > Thanks,
> > Mina
> >
> > .
> >



--=20
Thanks,
Mina
