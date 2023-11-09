Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992CE7E621B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 03:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjKICWc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 21:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjKICWc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 21:22:32 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F926A6
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 18:22:30 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45f08657f0bso190392137.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 18:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699496549; x=1700101349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSPMpbnqaJyO3ODc5clIYENUiJuL1UHQWRmXr36pztw=;
        b=RlyDzmSOWrFr2afjl1LMHYfOrfjAq/WxdLFn/kSO6f/ZQtOEw3Rf7b3uNFdoM3NrJ+
         Ard2qe0iR6mXwfz0+70E/pK+NvnMlhGPVAHhAZBWL63PoKS0SbHu8Zjxaghp7j59tCHq
         qjsRyTS4EePECuSsp4s91yH1nG3exRl4U7lPVnbzU4lMVhXCulPTm7JmkxXaPRBXwMyX
         nwo4urL1D9ltIMRWul9nNlU7AwBYIXGwzS5+StuAoIhEUH3RjzfIGgh7akbjrj80aDit
         zmBxk8xGrciLKlnBbS0orzy/XLs2F3QaVUL8wDqFbE48bNY6COpU1yuPiuuviInS10SI
         vl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699496549; x=1700101349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSPMpbnqaJyO3ODc5clIYENUiJuL1UHQWRmXr36pztw=;
        b=DcbG+ZWqjClF/kpNF5GWuVxUzNtNp6gvKYqzhxHhjhDEac1MBS41Q5jh4mSOw8mH/e
         mr/nmOxYpfhstgp+uh6kdlZ+V1+UpohI6Eo3s59EqZUiYyoyR4kTBwH2oJ17/e2m1ho+
         9L2OzMH+8KyvADeWgXc10beBGnhXShaMgGS1EMGi06/tyA8DN8bvmVmbXxUFYw3xK44p
         yD1/KcteRO497fvuAddVn0VN/3C8rSvKhg9NdUbaZtcCGF+UQ0dUlc+O0AJpe7UgTfST
         nDGPUR+dX7drlbEW4+JVNSTd5aVAiHsTfmsNldEJwRbCXcRXiE/n7bBDdbpQncRNV+69
         KP0A==
X-Gm-Message-State: AOJu0Yxfq2thgt5lVqOIIxDdbdFgJXh7sx8AgBzvHeImlxEm6YKTuVGl
        maqziw6xSKA2Slm00uLRtlLR0pgUZdnUsA4dTLLtbA==
X-Google-Smtp-Source: AGHT+IEbBLd4OCYTD+BfgjfRtM1GreJwxjpgz5yBDiudeMGW3y2SaeG7nGhsX8PgjqXOfiWkFQ0hU/lXsKFFFArEvCc=
X-Received: by 2002:a05:6102:104f:b0:45d:a05f:8d7d with SMTP id
 h15-20020a056102104f00b0045da05f8d7dmr3347254vsq.22.1699496548881; Wed, 08
 Nov 2023 18:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com> <1fee982f-1e96-4ae8-ede0-7e57bf84c5f7@huawei.com>
 <CAHS8izPV3isMWyjFnr7bJDDPANg-zm_M=UbHyuhYWv1Viy7fRw@mail.gmail.com> <c1b689bd-a05b-85e9-0ce4-7264c818c2dc@huawei.com>
In-Reply-To: <c1b689bd-a05b-85e9-0ce4-7264c818c2dc@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 8 Nov 2023 18:22:17 -0800
Message-ID: <CAHS8izMXkaGE_jqYJJk9KpfxWEYDu95XAJNqajws57QWV2yRJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
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
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 7, 2023 at 7:40=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/11/8 5:59, Mina Almasry wrote:
> > On Mon, Nov 6, 2023 at 11:46=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/11/6 10:44, Mina Almasry wrote:
> >>> +
> >>> +void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *bind=
ing)
> >>> +{
> >>> +     size_t size, avail;
> >>> +
> >>> +     gen_pool_for_each_chunk(binding->chunk_pool,
> >>> +                             netdev_devmem_free_chunk_owner, NULL);
> >>> +
> >>> +     size =3D gen_pool_size(binding->chunk_pool);
> >>> +     avail =3D gen_pool_avail(binding->chunk_pool);
> >>> +
> >>> +     if (!WARN(size !=3D avail, "can't destroy genpool. size=3D%lu, =
avail=3D%lu",
> >>> +               size, avail))
> >>> +             gen_pool_destroy(binding->chunk_pool);
> >>
> >>
> >> Is there any other place calling the gen_pool_destroy() when the above
> >> warning is triggered? Do we have a leaking for binding->chunk_pool?
> >>
> >
> > gen_pool_destroy BUG_ON() if it's not empty at the time of destroying.
> > Technically that should never happen, because
> > __netdev_devmem_binding_free() should only be called when the refcount
> > hits 0, so all the chunks have been freed back to the gen_pool. But,
> > just in case, I don't want to crash the server just because I'm
> > leaking a chunk... this is a bit of defensive programming that is
> > typically frowned upon, but the behavior of gen_pool is so severe I
> > think the WARN() + check is warranted here.
>
> It seems it is pretty normal for the above to happen nowadays because of
> retransmits timeouts, NAPI defer schemes mentioned below:
>
> https://lkml.kernel.org/netdev/168269854650.2191653.8465259808498269815.s=
tgit@firesoul/
>
> And currently page pool core handles that by using a workqueue.

Forgive me but I'm not understanding the concern here.

__netdev_devmem_binding_free() is called when binding->ref hits 0.

binding->ref is incremented when an iov slice of the dma-buf is
allocated, and decremented when an iov is freed. So,
__netdev_devmem_binding_free() can't really be called unless all the
iovs have been freed, and gen_pool_size() =3D=3D gen_pool_avail(),
regardless of what's happening on the page_pool side of things, right?

--=20
Thanks,
Mina
