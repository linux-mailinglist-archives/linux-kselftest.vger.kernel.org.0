Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936F7E4B57
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 23:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbjKGWB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 17:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjKGWBh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 17:01:37 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9582112
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 13:59:54 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d0ceba445so35235386d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699394394; x=1699999194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PqaUmI2qs4cLDwl2i5pZd/bBUshC/jimD2IW3jRBHQ=;
        b=0gVfz8KalPjgblFZOXAbcpyzLc9BmNmEpFXDcildKc7o0K/fILzLgDnG7PUv3VdMMG
         VIcmMhQCdbPSPBtp00KzhOO7TKJstCRY6j5nEnW+XbXXj9SNlrnEfcs8MUVYwZ+TXg84
         xXP1c0C2xs2FQxncZ6UVrnW6kRR8MlSOk+y+gsCdm+FQ4yT0RD5jMDpMdrFRo86u3sGA
         UhQcbSPohGI3HGdSfd6C5ROOuiYu8iEGpm4jtA7pGrR3742gGsYBUkVabAZhQuDRfdLe
         lV+i7tMG6qN3WX2n7EV+U3SZVnPU65Rz1YEyTFzhnn+kRGknLdv2VmBPpVB3Rj0fURP7
         u/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394394; x=1699999194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PqaUmI2qs4cLDwl2i5pZd/bBUshC/jimD2IW3jRBHQ=;
        b=R9+65wEf40HlUC6Ec5OL6POVvzcKtX1IXDc2UjFm9RibLZCpM40cY2g68TPvN4LI3n
         C4QfmpG7gwg7K69OaLR5mfvpX1zVa7i16+1xacJCdryIARBmEeDYtxsMz57+MzZ5+/I2
         mWoMH0+VMFHYctyC5ylskbImqUpDkSmevUqvkum6fnQbTa5ZoLge3h6nt4zXkyq3D6w1
         3nyQQ3x40T+dREbq56jOap1RXj9jrRxGiXAQuwIhhcmLqYwtj0zl8tuPRV8RiWZHarPA
         61fwNAgWMKPBO7eqkI3dqelEHr4pnQ+mivapLe7ka1NxnmBv/JaWqKsjpEATPHEf+JNS
         NC6g==
X-Gm-Message-State: AOJu0YyuTy5hcmpJjQzTxcD+n0+THu4Eexg2CghqNbUaInUwSzENmSZw
        k5QdJzUwRbdIVCJhgi5YJ9qZ8dJPfuVCh78leTTkiQ==
X-Google-Smtp-Source: AGHT+IHVrgEKfASjC5rH9bq4RglRT8VPoPtK4Z4u/BPe0YLNL57TLwT+bbLdmq9/ZlUZX9/zJmxQ+t+E7PsoyRnnNeQ=
X-Received: by 2002:ad4:5be2:0:b0:66d:a22a:464f with SMTP id
 k2-20020ad45be2000000b0066da22a464fmr79490qvc.16.1699394393800; Tue, 07 Nov
 2023 13:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com> <1fee982f-1e96-4ae8-ede0-7e57bf84c5f7@huawei.com>
In-Reply-To: <1fee982f-1e96-4ae8-ede0-7e57bf84c5f7@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 7 Nov 2023 13:59:40 -0800
Message-ID: <CAHS8izPV3isMWyjFnr7bJDDPANg-zm_M=UbHyuhYWv1Viy7fRw@mail.gmail.com>
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

On Mon, Nov 6, 2023 at 11:46=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/6 10:44, Mina Almasry wrote:
> > +
> > +void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *bindin=
g)
> > +{
> > +     size_t size, avail;
> > +
> > +     gen_pool_for_each_chunk(binding->chunk_pool,
> > +                             netdev_devmem_free_chunk_owner, NULL);
> > +
> > +     size =3D gen_pool_size(binding->chunk_pool);
> > +     avail =3D gen_pool_avail(binding->chunk_pool);
> > +
> > +     if (!WARN(size !=3D avail, "can't destroy genpool. size=3D%lu, av=
ail=3D%lu",
> > +               size, avail))
> > +             gen_pool_destroy(binding->chunk_pool);
>
>
> Is there any other place calling the gen_pool_destroy() when the above
> warning is triggered? Do we have a leaking for binding->chunk_pool?
>

gen_pool_destroy BUG_ON() if it's not empty at the time of destroying.
Technically that should never happen, because
__netdev_devmem_binding_free() should only be called when the refcount
hits 0, so all the chunks have been freed back to the gen_pool. But,
just in case, I don't want to crash the server just because I'm
leaking a chunk... this is a bit of defensive programming that is
typically frowned upon, but the behavior of gen_pool is so severe I
think the WARN() + check is warranted here.

> > +
> > +     dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> > +                              DMA_BIDIRECTIONAL);
> > +     dma_buf_detach(binding->dmabuf, binding->attachment);
> > +     dma_buf_put(binding->dmabuf);
> > +     kfree(binding);
> > +}
> > +
>
>


--=20
Thanks,
Mina
