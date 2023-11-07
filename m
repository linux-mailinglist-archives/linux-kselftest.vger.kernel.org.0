Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E67E4B8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 23:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKGWLT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 17:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjKGWLJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 17:11:09 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DC810FE
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 14:11:07 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7bac330d396so2293503241.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 14:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699395067; x=1699999867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbbSAsuabIr4BwrZEqK8c8XYZufkR++Mr7B/MiPJA0o=;
        b=H2HecGuAWdWApGZBswfYfMpGXm37AHw0nDvVqm0SK9guPY+f0qGNJ0wkKZx8aLgTpo
         vBs3T24Ecqc0Wla336n8sIuuCmk1YdXARx9cbiod0i2TpLLJ7Nbkw8GApOJL16QliGH7
         FP9GGvHGIkMpUO15nRlrhFUyyLfiGzX2HpBos7EL/qmRRvxkLvHv8T0yGEOAh9PvqHs9
         Iq1B9Px5nVuxQ6JJp+2tone3XdgSZcvI3yM/DkdANDnWnk1FL3lVtXRgGTcT/UDbllZo
         91D44aUcO0xSc8+WM/cA0n0cNcar08uF69AgMMR9mRSw3ylGOJgpku2pqp9f3GQVGmT9
         N0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699395067; x=1699999867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbbSAsuabIr4BwrZEqK8c8XYZufkR++Mr7B/MiPJA0o=;
        b=tPDWafxMkez0KmBagHq87MlaTdZJvgEQeogpb6aV/v6NGvPHAxBalcx6jGhwO49OfE
         BddYoMGojfpnl0gzQX50sqp1mcfzsYiOwD0P+Cd1l8meUmC0fQQfwj2YgR54TgPKHyfS
         VNqqusTNW6HVzJj55uJOlDwBNtIE+MMkViAl3BIM2aCPAV+LDYPcrwu6NO3Eqi8FhTlK
         GzePfw/Jb/8eOB7m3FJqAqrdkTZsmAWN8U4cBVJGhqKWAPpskJ9Ie8t6E7ElKro0+zra
         Gp/u/hxjB9RC3/1rwb0uJwuTh6ZCSAjtHheASL2n51gUqT1FFltSg/okT8CsaDypVteg
         YE1A==
X-Gm-Message-State: AOJu0YzL5Q6/u8FFHslp+egZE/3p5+fe6o2jsHfTa8WJwOtD8eYDNQU2
        k1jriFxckkGhA2BR1404aE0PMz/2gLG5wtu+HQ0ReQ==
X-Google-Smtp-Source: AGHT+IGk2R54zWB6aRa4RbSeBT9Z8J5T4TXiyB4Vle9bwzR5GqISmJH2OZCPqY1SUXwwMEpn8Stt8en869yrOvH8V6Y=
X-Received: by 2002:a05:6102:474b:b0:45f:4e55:9c4b with SMTP id
 ej11-20020a056102474b00b0045f4e559c4bmr5313415vsb.31.1699395066619; Tue, 07
 Nov 2023 14:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com> <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
In-Reply-To: <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 7 Nov 2023 14:10:52 -0800
Message-ID: <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
To:     David Ahern <dsahern@kernel.org>
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
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 6, 2023 at 3:44=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/5/23 7:44 PM, Mina Almasry wrote:
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index eeeda849115c..1c351c138a5b 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
> >  };
> >
> >  #ifdef CONFIG_DMA_SHARED_BUFFER
> > +struct page_pool_iov *
> > +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
> > +void netdev_free_devmem(struct page_pool_iov *ppiov);
>
> netdev_{alloc,free}_dmabuf?
>

Can do.

> I say that because a dmabuf can be host memory, at least I am not aware
> of a restriction that a dmabuf is device memory.
>

In my limited experience dma-buf is generally device memory, and
that's really its use case. CONFIG_UDMABUF is a driver that mocks
dma-buf with a memfd which I think is used for testing. But I can do
the rename, it's more clear anyway, I think.

On Mon, Nov 6, 2023 at 11:45=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/6 10:44, Mina Almasry wrote:
> > +
> > +void netdev_free_devmem(struct page_pool_iov *ppiov)
> > +{
> > +     struct netdev_dmabuf_binding *binding =3D page_pool_iov_binding(p=
piov);
> > +
> > +     refcount_set(&ppiov->refcount, 1);
> > +
> > +     if (gen_pool_has_addr(binding->chunk_pool,
> > +                           page_pool_iov_dma_addr(ppiov), PAGE_SIZE))
>
> When gen_pool_has_addr() returns false, does it mean something has gone
> really wrong here?
>

Yes, good eye. gen_pool_has_addr() should never return false, but then
again, gen_pool_free()  BUG_ON()s if it doesn't find the address,
which is an extremely severe reaction to what can be a minor bug in
the accounting. I prefer to leak rather than crash the machine. It's a
bit of defensive programming that is normally frowned upon, but I feel
like in this case it's maybe warranted due to the very severe reaction
(BUG_ON).

--=20
Thanks,
Mina
