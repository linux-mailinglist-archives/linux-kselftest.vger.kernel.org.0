Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE617E4A74
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 22:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjKGVTu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 16:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjKGVTu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 16:19:50 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE1EA3
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 13:19:47 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7b9f08482c8so2753516241.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699391987; x=1699996787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6vtB6oGNeNraeO1yfc6WDVHQCGu06A7XkYHqu97D2c=;
        b=0qCpusB5cgJsovyh+pflw6eb7M0+rxhkXqUUV57dWxTspNfOyvZJzzSCqvkW+N1FrS
         KiR8RmuRy7bxGqZE4qdy3tCGanjdKdDgC7beNnOEoYptIBik1gKxC/6ON4ZOg/Z2hNyj
         DAKipbvHGVeOHp7RyWj2RS9aE30t0vT836lR/ctBajfm2ZrzTmX7Lakc7QhXGOqyElwC
         c/WVUv+dUkQ7kX/oL9GKWoos1K2b9SkmmQiKLGchPwdr8JV1bGaQz8B+g5PVoxIHPTze
         4X8Gy+wOTF2R+6DUDjmTO+pHw/79tXdvy3SFPimRaaJC0d/M9p2BbWGdKUeRDi2ltsZx
         ebMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699391987; x=1699996787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6vtB6oGNeNraeO1yfc6WDVHQCGu06A7XkYHqu97D2c=;
        b=qrLi1MIqqbylqY/jSlV805EAh2Pmeg2HjWjtaysq437Ko2DOLE5gDDQWQX3No8WWQ9
         EVvt4SGdY2d+3cxBp3nu2XfOSYYQpgE3SK2BtL1nu0a3TFkwIEH3tyIaRInx5a2Szr0x
         Iikulz0ANZtimlZ3Rhi5T3GmDlubeAlKhEbymJzBesBQLolKfxJTq77pUOXasrE6dHki
         3dAauMy8yy+UCoe2AGF8nKQFajSE2n5qEEdIiyJaDpv3Bz0VBC2TYvfXLV2JJwL9Itwm
         MkAIAnHV0ek5EKPE4d4ZIxnYUW3WrXy+/fqJ4TrRcQSJt6tf5v0Q11WYwsjoZvd1KJ6c
         QGFg==
X-Gm-Message-State: AOJu0Yx9G1dVv8qfTKa9s0xa9LESTa5w2TGdJBDIllxTKTt0VaapxiWb
        SS0GXI+mFzqMIQEHzXu2YP1wmGaHhPHabkT4LVzGNg==
X-Google-Smtp-Source: AGHT+IGP/CXPxw/3EMz20UnoxCfjtef8X0h1zK6Yh6FlZoE34oBHf9lsr5FmmVHSCxlfjvy68G8o2l++xlKxI0QUgP0=
X-Received: by 2002:a05:6102:4712:b0:45d:91b3:74b7 with SMTP id
 ei18-20020a056102471200b0045d91b374b7mr12087084vsb.27.1699391986590; Tue, 07
 Nov 2023 13:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-9-almasrymina@google.com> <7e851882-9a85-3672-c3d5-73b47599873c@huawei.com>
In-Reply-To: <7e851882-9a85-3672-c3d5-73b47599873c@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 7 Nov 2023 13:19:32 -0800
Message-ID: <CAHS8izPGa99LyEc=AeqNaK8X68b7dovxCHOLbR=hnbaybN_zgQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
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

On Tue, Nov 7, 2023 at 1:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/11/6 10:44, Mina Almasry wrote:
> > Make skb_frag_page() fail in the case where the frag is not backed
> > by a page, and fix its relevent callers to handle this case.
> >
> > Correctly handle skb_frag refcounting in the page_pool_iovs case.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
>
> ...
>
> >  /**
> >   * skb_frag_page - retrieve the page referred to by a paged fragment
> >   * @frag: the paged fragment
> >   *
> > - * Returns the &struct page associated with @frag.
> > + * Returns the &struct page associated with @frag. Returns NULL if thi=
s frag
> > + * has no associated page.
> >   */
> >  static inline struct page *skb_frag_page(const skb_frag_t *frag)
> >  {
> > -     return frag->bv_page;
> > +     if (!page_is_page_pool_iov(frag->bv_page))
> > +             return frag->bv_page;
> > +
> > +     return NULL;
>
> It seems most of callers don't expect NULL returning for skb_frag_page(),
> and this patch only changes a few relevant callers to handle the NULL cas=
e.
>

Yes, I did not change code that I guessed was not likely to be
affected or enable the devmem TCP case. Here is my breakdown:

=E2=9E=9C  cos-kernel git:(tcpdevmem) =E2=9C=97 ack -i "skb_frag_page\("
--ignore-dir=3Ddrivers -t cc -l
net/core/dev.c
net/core/datagram.c
net/core/xdp.c
net/core/skbuff.c
net/core/filter.c
net/core/gro.c
net/appletalk/ddp.c
net/wireless/util.c
net/tls/tls_device.c
net/tls/tls_device_fallback.c
net/ipv4/tcp.c
net/ipv4/tcp_output.c
net/bpf/test_run.c
include/linux/skbuff.h

I'm ignoring ank skb_frag_page() calls in drivers because drivers need
to add support for devmem TCP, and handle these calls at time of
adding support, I think that's reasonable.

net/core/dev.c:
I think I missed ilegal_highdma()

net/core/datagram.c:
__skb_datagram_iter() protected by not_readable(skb) check.

net/core/skbuff.c:
protected by not_readable(skb) check.

net/core/filter.c:
bpf_xdp_frags_shrink_tail seems like xdp specific, not sure it's relevant h=
ere.

net/core/gro.c:
skb_gro_reset_offset: protected by NULL check

net/ipv4/tcp.c:
tcp_zerocopy_receive protected by NULL check.

net/ipv4/tcp_output.c:
tcp_clone_payload: handles NULL return fine.

net/bpf/test_run.c:
seems xdp specific and not sure if it can run into devmem issues.

include/linux/skbuff.h:
I think the multiple calls here are being handled correctly, but let
me know if not.

All the calls in these files, I think, are code paths not possible to
hit devmem TCP with the current support, I think:
net/core/xdp.c
net/appletalk/ddp.c
net/wireless/util.c
net/tls/tls_device.c
net/tls/tls_device_fallback.c

All in all I think maybe all in all I missed illegal_highdma(). I'll
fix it in the next iteration.

> It may make more sense to add a new helper to do the above checking, and
> add a warning in skb_frag_page() to catch any missing NULL checking for
> skb_frag_page() caller, something like below?
>
>  static inline struct page *skb_frag_page(const skb_frag_t *frag)
>  {
> -       return frag->bv_page;
> +       struct page *page =3D frag->bv_page;
> +
> +       BUG_ON(page_is_page_pool_iov(page));
> +
> +       return page;
> +}
> +
> +static inline struct page *skb_frag_readable_page(const skb_frag_t *frag=
)
> +{
> +       struct page *page =3D frag->bv_page;
> +
> +       if (!page_is_page_pool_iov(page))
> +               return page;
> +
> +       return NULL;
>  }
>
>

My personal immediate reaction is that this may just introduce code
churn without significant benefit. If an unsuspecting caller call
skb_frag_page() on devmem frag and doesn't correctly handle NULL
return, it will crash or error out anyway, and likely in some obvious
way, so maybe the BUG_ON() isn't so useful that it's worth changing
all the call sites. But if there is consensus on adding a change like
you propose, I have no problem adding it.

--=20
Thanks,
Mina
