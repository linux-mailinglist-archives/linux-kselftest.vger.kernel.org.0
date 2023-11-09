Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C067E6550
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 09:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjKIIao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 03:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjKIIan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 03:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696F2D50
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 00:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699518599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qGu6ReB5a+EcqdKKJhEiSap1D12mNLXKF1UNlxFd2w=;
        b=D79jnct0+p49WHZIvBrLM3eviXDg+AaGwi4+1oZuvnw03Pr4cTNXGl34/igvzMPASFb7AD
        ToN6OTXBXgt/rcWBi1Y677PMfBceNbOYPqLzw9QytUXS80YmLidqpHXMuPv9Kn/mm+KWSG
        V04TssdwWyUTo0DWJ2J0V6T7ohPJ9qs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-ycmFnedUO9m1EzqZEnBb-A-1; Thu, 09 Nov 2023 03:29:58 -0500
X-MC-Unique: ycmFnedUO9m1EzqZEnBb-A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c45a6a8832so11662866b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Nov 2023 00:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699518597; x=1700123397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qGu6ReB5a+EcqdKKJhEiSap1D12mNLXKF1UNlxFd2w=;
        b=nknHy1FxLyeklMOLj0v/yI1/yi+IARteXTeWCDQlfOXqXoTobIh7SVNGotUIIfJ5Jg
         KxNEKFWFkE0nHRRMK1WyycCUSRIXvTkhuNVaKw7Eog+GFNus4xC/nKaowSY18SUWII2O
         rp6pfvghzFWyFLIRMPXXuDnwEWqnvgex/edLFf304W/6cUrkadHDbh8Z3KWUBxHsVAZh
         PD9dRPIL9OOcYPMh7pY474s2O5A4zgWSDyrcM7EsZXD0rF76VaxGP3PTkAZoMtxp1RqV
         Ll6dIQdeGWe5lIVg7LV5HoSGwt1dqGKQR0kkoH6Q3ZL0UomakdAXVfSbOoKkxKYxcszd
         X2qA==
X-Gm-Message-State: AOJu0YxikGKz78/4m2nX1QvcvI33yshc6i1lS0WGQzuOpBSIZzW8jty2
        fmduNUxHdcIy/l4qyVwQsAPiy4BohgamIzaEZwFZnCPPEKWRV1lgyueUBzCNZIvd8A1n52rkTen
        cseBcnjqEihvgmo3Rsq1N7m2cafUJ
X-Received: by 2002:a17:907:9725:b0:9dd:b624:dea9 with SMTP id jg37-20020a170907972500b009ddb624dea9mr3415530ejc.7.1699518597404;
        Thu, 09 Nov 2023 00:29:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFQLHA2HdtAUf7yiWJ3zu6Jf15htwDL4OIcB2ox9NPft2Q3sVGGotT9BWcb+BUEytSXl5ggw==
X-Received: by 2002:a17:907:9725:b0:9dd:b624:dea9 with SMTP id jg37-20020a170907972500b009ddb624dea9mr3415493ejc.7.1699518597043;
        Thu, 09 Nov 2023 00:29:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id v25-20020a170906381900b009dfd3b80ba3sm2221221ejc.35.2023.11.09.00.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:29:56 -0800 (PST)
Message-ID: <076fa6505f3e1c79cc8acdf9903809fad6c2fd31.camel@redhat.com>
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to
 netdevice
From:   Paolo Abeni <pabeni@redhat.com>
To:     Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Date:   Thu, 09 Nov 2023 09:29:54 +0100
In-Reply-To: <20231106024413.2801438-5-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
         <20231106024413.2801438-5-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> +int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +		       struct netdev_dmabuf_binding **out)
> +{
> +	struct netdev_dmabuf_binding *binding;
> +	struct scatterlist *sg;
> +	struct dma_buf *dmabuf;
> +	unsigned int sg_idx, i;
> +	unsigned long virtual;
> +	int err;
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	dmabuf =3D dma_buf_get(dmabuf_fd);
> +	if (IS_ERR_OR_NULL(dmabuf))
> +		return -EBADFD;
> +
> +	binding =3D kzalloc_node(sizeof(*binding), GFP_KERNEL,
> +			       dev_to_node(&dev->dev));
> +	if (!binding) {
> +		err =3D -ENOMEM;
> +		goto err_put_dmabuf;
> +	}
> +
> +	xa_init_flags(&binding->bound_rxq_list, XA_FLAGS_ALLOC);
> +
> +	refcount_set(&binding->ref, 1);
> +
> +	binding->dmabuf =3D dmabuf;
> +
> +	binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.parent=
);
> +	if (IS_ERR(binding->attachment)) {
> +		err =3D PTR_ERR(binding->attachment);
> +		goto err_free_binding;
> +	}
> +
> +	binding->sgt =3D dma_buf_map_attachment(binding->attachment,
> +					      DMA_BIDIRECTIONAL);
> +	if (IS_ERR(binding->sgt)) {
> +		err =3D PTR_ERR(binding->sgt);
> +		goto err_detach;
> +	}
> +
> +	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> +	 * binding can be much more flexible than that. We may be able to
> +	 * allocate MTU sized chunks here. Leave that for future work...
> +	 */
> +	binding->chunk_pool =3D gen_pool_create(PAGE_SHIFT,
> +					      dev_to_node(&dev->dev));
> +	if (!binding->chunk_pool) {
> +		err =3D -ENOMEM;
> +		goto err_unmap;
> +	}
> +
> +	virtual =3D 0;
> +	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
> +		dma_addr_t dma_addr =3D sg_dma_address(sg);
> +		struct dmabuf_genpool_chunk_owner *owner;
> +		size_t len =3D sg_dma_len(sg);
> +		struct page_pool_iov *ppiov;
> +
> +		owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> +				     dev_to_node(&dev->dev));
> +		owner->base_virtual =3D virtual;
> +		owner->base_dma_addr =3D dma_addr;
> +		owner->num_ppiovs =3D len / PAGE_SIZE;
> +		owner->binding =3D binding;
> +
> +		err =3D gen_pool_add_owner(binding->chunk_pool, dma_addr,
> +					 dma_addr, len, dev_to_node(&dev->dev),
> +					 owner);
> +		if (err) {
> +			err =3D -EINVAL;
> +			goto err_free_chunks;
> +		}
> +
> +		owner->ppiovs =3D kvmalloc_array(owner->num_ppiovs,
> +					       sizeof(*owner->ppiovs),
> +					       GFP_KERNEL);
> +		if (!owner->ppiovs) {
> +			err =3D -ENOMEM;
> +			goto err_free_chunks;
> +		}
> +
> +		for (i =3D 0; i < owner->num_ppiovs; i++) {
> +			ppiov =3D &owner->ppiovs[i];
> +			ppiov->owner =3D owner;
> +			refcount_set(&ppiov->refcount, 1);
> +		}
> +
> +		dma_addr +=3D len;

I'm trying to wrap my head around the whole infra... the above line is
confusing. Why do you increment dma_addr? it will be re-initialized in
the next iteration.

Cheers,

Paolo

