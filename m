Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636FC7E61D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 02:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjKIBmO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 20:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjKIBmN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 20:42:13 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CD9269D
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 17:42:11 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7b9ff2b6f9bso122851241.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699494130; x=1700098930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtXvJMS7/3Fgi+LpB6nuDO1GbZPELeIfXynT/oP6gbw=;
        b=pte8zQkMQ+/0wqzuA5lFv1GZ/lyHdSNgr4p7SbREBf9dolQE99OPtDF1uQbqi5A7wz
         L16PQRM6VdeIbhQ4n+3JN5QN6cwTGf2BlIwwFKWpyFaEpzv33Rags+tgwjtX4pROh/x8
         ACPiFtN7FvjLkD6uKebnroFsZRoMDYSry8gP7P9/TJFE+Jyb92HyZ5zd0Wi1PHEziu7W
         +w8ULc2V8vg/WVf0bx2yVfXc/jKsQjk3G2MbXsU6R6tk9Yakq7HjE4tY4G27+N28n+Wy
         ymH75pQdUwgpLl8598nL5W9x7rk5NHjoc+k/UNLVjsmL8DJD6yaP8SvmxUkNrkCvR28x
         JVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699494130; x=1700098930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtXvJMS7/3Fgi+LpB6nuDO1GbZPELeIfXynT/oP6gbw=;
        b=N8+KNxfvmSqq62tn5Iq9k56NelB8JDRjvB4e4GdR/XWiUsjAnfttGptDtl0r4oWMXX
         hMpgBJV+HSdBpOz5z031H1vArnRv6dh60a+fAMsX/holFDMKiDPjLC+12f95aXPgjcKU
         m4EUoHOEhUKI3EZ9HvIjK0lI3asIfSFwL4Zh+oLF62OGP7DUoDCv/y8qHcH0c0czpREK
         fOsH/tnzY2paxNTRijGt5yzwNi2IfYpRksL3ZYVI6p5mnbQgzlrQ+mFemJQ1enZdYmCL
         fWx+DBOI1iti7FeHuM/RblcdeR0Jj8pO220vgkybas4HD2/xOk0hFb6wmrbTvfW66HXP
         h8jQ==
X-Gm-Message-State: AOJu0YznxglGpUGwrJBAejYpj1Dr+KxqZu9KnohVHJ1CbxTxTjdm3wqd
        c4GNCIEUovio2DpAZc9RMJPE+eG1CgrW6G+bI8d1Bw==
X-Google-Smtp-Source: AGHT+IEgdcG0qqqXy9cIxFiAolh/hrZOW6JAOB3Io/o+JJsEAX7J8FeEEaKDW9kJyXKjNOuzCBypENaeQVzYpVq+vos=
X-Received: by 2002:a05:6102:2082:b0:45d:8660:b91 with SMTP id
 h2-20020a056102208200b0045d86600b91mr3660311vsr.9.1699494130078; Wed, 08 Nov
 2023 17:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com> <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
 <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com> <6c629d6d-6927-3857-edaa-1971a94b6e93@huawei.com>
In-Reply-To: <6c629d6d-6927-3857-edaa-1971a94b6e93@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 8 Nov 2023 17:41:56 -0800
Message-ID: <CAHS8izPgioCzFGadNFNFWr_tqi--YBF8qrNqi8ELgixA9ZX0rQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
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

> > On Mon, Nov 6, 2023 at 11:45=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/11/6 10:44, Mina Almasry wrote:
> >>> +
> >>> +void netdev_free_devmem(struct page_pool_iov *ppiov)
> >>> +{
> >>> +     struct netdev_dmabuf_binding *binding =3D page_pool_iov_binding=
(ppiov);
> >>> +
> >>> +     refcount_set(&ppiov->refcount, 1);
> >>> +
> >>> +     if (gen_pool_has_addr(binding->chunk_pool,
> >>> +                           page_pool_iov_dma_addr(ppiov), PAGE_SIZE)=
)
> >>
> >> When gen_pool_has_addr() returns false, does it mean something has gon=
e
> >> really wrong here?
> >>
> >
> > Yes, good eye. gen_pool_has_addr() should never return false, but then
> > again, gen_pool_free()  BUG_ON()s if it doesn't find the address,
> > which is an extremely severe reaction to what can be a minor bug in
> > the accounting. I prefer to leak rather than crash the machine. It's a
> > bit of defensive programming that is normally frowned upon, but I feel
> > like in this case it's maybe warranted due to the very severe reaction
> > (BUG_ON).
>
> I would argue that why is the above defensive programming not done in the
> gen_pool core:)
>

I think gen_pool is not really not that new, and suggesting removing
the BUG_ONs must have been proposed before and rejected. I'll try to
do some research and maybe suggest downgrading the BUG_ON to WARN_ON,
but my guess is there is some reason the maintainer wants it to be a
BUG_ON.

On Wed, Nov 8, 2023 at 5:00=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2023-11-07 14:55, David Ahern wrote:
> > On 11/7/23 3:10 PM, Mina Almasry wrote:
> >> On Mon, Nov 6, 2023 at 3:44=E2=80=AFPM David Ahern <dsahern@kernel.org=
> wrote:
> >>>
> >>> On 11/5/23 7:44 PM, Mina Almasry wrote:
> >>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>>> index eeeda849115c..1c351c138a5b 100644
> >>>> --- a/include/linux/netdevice.h
> >>>> +++ b/include/linux/netdevice.h
> >>>> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
> >>>>  };
> >>>>
> >>>>  #ifdef CONFIG_DMA_SHARED_BUFFER
> >>>> +struct page_pool_iov *
> >>>> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
> >>>> +void netdev_free_devmem(struct page_pool_iov *ppiov);
> >>>
> >>> netdev_{alloc,free}_dmabuf?
> >>>
> >>
> >> Can do.
> >>
> >>> I say that because a dmabuf can be host memory, at least I am not awa=
re
> >>> of a restriction that a dmabuf is device memory.
> >>>
> >>
> >> In my limited experience dma-buf is generally device memory, and
> >> that's really its use case. CONFIG_UDMABUF is a driver that mocks
> >> dma-buf with a memfd which I think is used for testing. But I can do
> >> the rename, it's more clear anyway, I think.
> >
> > config UDMABUF
> >         bool "userspace dmabuf misc driver"
> >         default n
> >         depends on DMA_SHARED_BUFFER
> >         depends on MEMFD_CREATE || COMPILE_TEST
> >         help
> >           A driver to let userspace turn memfd regions into dma-bufs.
> >           Qemu can use this to create host dmabufs for guest framebuffe=
rs.
> >
> >
> > Qemu is just a userspace process; it is no way a special one.
> >
> > Treating host memory as a dmabuf should radically simplify the io_uring
> > extension of this set. That the io_uring set needs to dive into
> > page_pools is just wrong - complicating the design and code and pushing
> > io_uring into a realm it does not need to be involved in.
>
> I think our io_uring proposal will already be vastly simplified once we
> rebase onto Kuba's page pool memory provider API. Using udmabuf means
> depending on a driver designed for testing, vs io_uring's registered
> buffers API that's been tried and tested.
>

FWIW I also get an impression that udmabuf is mostly targeting
testing, but I'm not aware of any deficiency that makes it concretely
unsuitable for you. You be the judge.

The only quirk of udmabuf I'm aware of is that it seems to cap the max
dma-buf size to 16000 pages. Not sure if that's due to a genuine
technical limitation or just convenience.

> I don't have an intuitive understanding of the trade offs yet, and would
> need to try out udmabuf and compare vs say using our own page pool
> memory provider.
>


On Wed, Nov 8, 2023 at 5:15=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
> How would TCP devmem change if we no longer assume that dmabuf is device
> memory?

It wouldn't. The code already never assumes that dmabuf is device
memory. Any dma-buf should work, as far as I can tell. I'm also quite
confident udmabuf works, I use it for testing.

(Jason Gunthrope is much more of an expert and may chime in to say
'some dma-buf will not work'. My primitive understanding is that we're
using dma-bufs without any quirks and any dma-buf should work. I of
course haven't tested all dma-bufs :D)

> Pavel will know more on the perf side, but I wouldn't want to
> put any if/else on the hot path if we can avoid it. I could be wrong,
> but right now in my mind using different memory providers solves this
> neatly and the driver/networking stack doesn't need to care.
>
> Mina, I believe you said at NetDev conf that you already had an udmabuf
> implementation for testing. I would like to see this (you can send
> privately) to see how TCP devmem would handle both user memory and
> device memory.
>

There is nothing to send privately. The patch series you're looking at
supports udma-buf as-is, and the kselftest included with the series
demonstrates devmem TCP working with udmabuf.

The only thing missing from this series is the driver support. You can
see the GVE driver support for devmem TCP here:

https://github.com/torvalds/linux/compare/master...mina:linux:tcpdevmem-v3

You may need to implement devmem TCP for your driver before you can
reproduce udmabuf working for yourself, though.

--=20
Thanks,
Mina
