Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABA27E658B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 09:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjKIIpR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 03:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjKIIpP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 03:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023012717
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 00:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699519465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTFEp4CMLoFdUcZdEGfmISXt6fDITsZHDJnL/kZD0Z4=;
        b=ENvSeuu0qeJ6uNbqWmkbYQv2TqkNw6PJamE6VVAT4KYan7mbYrI1NHQNvv6LUjQOef6aNr
        ufJWxgDbai29IuO4BDx8NxwOAB6S5AjynVmznUcztPulBsmlozAPO1UerD5b2/feDqJ7Rg
        JEB/8G+AkqD2Nz4DMVfiS0S4MPFRMWg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-nbGhmA2TN4mOVvOj73bQJQ-1; Thu, 09 Nov 2023 03:44:22 -0500
X-MC-Unique: nbGhmA2TN4mOVvOj73bQJQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9bfacbcabb1so8611266b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Nov 2023 00:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699519461; x=1700124261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTFEp4CMLoFdUcZdEGfmISXt6fDITsZHDJnL/kZD0Z4=;
        b=wWQEOyvTIecaXEp+AXbJ3/9Oq3lhSnoHyEGftPPCl4fUNrDMt/p2Jh7FQadtlyHvGa
         LAWO+r5LF9+AvPfjCUns7P7KdfHn1SgWlkcQELp2w5/GZZP/EbT0XmQJ7/Duj8WFx2mk
         9caN8cUgiPksr17gFJXexZIojzXMuvK05JCWORiJ3mKHmZd/dsOMFeEboqDtdl7xkUlz
         v85/q/57mTp04bVgfR/n6jBMiQe238kxAzdAUshtGs/Pe2vgEa6y14BZpN8MYl6SAqSM
         Wz2xY9OENr5ulSy4/gdrPGFP5Y+7An2EsY25Y0rZN6ZHIqxgxgoefisyaLGpWInBtJhm
         1EgA==
X-Gm-Message-State: AOJu0YyXZKOmcuvTfbQjXhetwuqenf4C+DmY8BXzFfRNGtSRmeC2xh41
        3uc4aZQkRyVb1+5utdQGQh+rQ/V7I2gyV2zBJadOMmv7ISLzb6pge1rmQfrz43wOylOmzIzNuS/
        39BO6MajhdKFmmsAYqu1gNmGX4G13
X-Received: by 2002:a17:906:6a0e:b0:9ae:50de:1aaf with SMTP id qw14-20020a1709066a0e00b009ae50de1aafmr3323734ejc.4.1699519461244;
        Thu, 09 Nov 2023 00:44:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpt6f4OXVKtH4i3m412g4H1Y1OUcpmAtKJLGhLybamCWeX8G1/7ze6DLbaN+L9dFmPNZ/PZg==
X-Received: by 2002:a17:906:6a0e:b0:9ae:50de:1aaf with SMTP id qw14-20020a1709066a0e00b009ae50de1aafmr3323714ejc.4.1699519460914;
        Thu, 09 Nov 2023 00:44:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id ha12-20020a170906a88c00b0099d804da2e9sm2235687ejb.225.2023.11.09.00.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:44:20 -0800 (PST)
Message-ID: <21e4ef7d4a1b4ad298b0688f2b9ce8f5572e1e69.camel@redhat.com>
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
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
Date:   Thu, 09 Nov 2023 09:44:18 +0100
In-Reply-To: <20231106024413.2801438-6-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
         <20231106024413.2801438-6-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> +void netdev_free_devmem(struct page_pool_iov *ppiov)
> +{
> +	struct netdev_dmabuf_binding *binding =3D page_pool_iov_binding(ppiov);
> +
> +	refcount_set(&ppiov->refcount, 1);
> +
> +	if (gen_pool_has_addr(binding->chunk_pool,
> +			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE))
> +		gen_pool_free(binding->chunk_pool,
> +			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE);

Minor nit: what about caching the dma_addr value to make the above more
readable?

Cheers,

Paolo

