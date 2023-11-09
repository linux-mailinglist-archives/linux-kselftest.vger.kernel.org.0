Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBA7E6668
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 10:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjKIJPf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 04:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjKIJPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 04:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019E926B1
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 01:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699521283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlxAh75JGCxuVSjk/DiobkLepAxu5g+JZPGhaCfgbCo=;
        b=g8SWf5T5KQhsMCNRpnKP337QbtoffTbXYNZ2hm897463pyLRVGy0vGnrokcH1/cgbk+RwW
        QcOVpdrHsnyg7Z2lWcOOMdFZROTsV9RTFxNAz7HSBb32vZ7ti7Nj96H4iM+49GaoltZXZG
        g2wSY5UgZcugITOr6chcsGGXrN7gf7A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-bYWVIVLoN3aC-yXmP98YMw-1; Thu, 09 Nov 2023 04:14:41 -0500
X-MC-Unique: bYWVIVLoN3aC-yXmP98YMw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9dd4e40349bso16368966b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Nov 2023 01:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521280; x=1700126080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlxAh75JGCxuVSjk/DiobkLepAxu5g+JZPGhaCfgbCo=;
        b=v/821+hHrEvtZESsvpjqRvStGKrN1/7EoZ1A5LMoHgvgZDwzOfmkUc6ZXf9sfSwEeU
         J3AC49fEQMLaYDGRnJhbheuFxKNDgvc4BcMPoY9xJSbL8vC/p8TsZlcn4PHrArnoRy95
         hvT/+jjXF0gHR4TyFIUomlrFa6/DnHsi+78wZGY1vmGuWs3h0GgyNwqOurhRgdDfQbnH
         6fyA7b04W+tGAvhWExNNGiNl2EZYFEbvpIVoPkir2oKn0sJKniwKRS0nnkIHs7JTWAaC
         vJAV3WQo+xXkaA6YDSplY1OXVyPgGbjmJIti5uQnvgIy4ciMFvsYR9/LuWG/F9J3rMJr
         f6ew==
X-Gm-Message-State: AOJu0YzVkYCVD3wtcvXdzad8RtZeu7rUybGbLMNRHDc0GXG0Z8Wi9zKD
        MWlIdJ1h3vKI0Ay9iC21yhMsky09bV10NXL+0MNhyYWj0xoXWePrjaMz+hUnTlwo1vGrnyirOap
        cFOnM5TxkgLMPYsORoARmncS84EQ/
X-Received: by 2002:a17:906:e84:b0:9e3:a1a9:3db3 with SMTP id p4-20020a1709060e8400b009e3a1a93db3mr3052478ejf.0.1699521280328;
        Thu, 09 Nov 2023 01:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrN7rWZV1LJySiH/LlJHce45p7c2N1o4c7lFbPUX87ekT7bdY/faJ0o5ksbIAqMgIYGTojqQ==
X-Received: by 2002:a17:906:e84:b0:9e3:a1a9:3db3 with SMTP id p4-20020a1709060e8400b009e3a1a93db3mr3052473ejf.0.1699521280043;
        Thu, 09 Nov 2023 01:14:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id dv16-20020a170906b81000b009a1c05bd672sm2252071ejb.127.2023.11.09.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:14:39 -0800 (PST)
Message-ID: <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
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
        Praveen Kaligineedi <pkaligineedi@google.com>
Date:   Thu, 09 Nov 2023 10:14:37 +0100
In-Reply-To: <20231106024413.2801438-9-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
         <20231106024413.2801438-9-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> @@ -3421,7 +3446,7 @@ static inline struct page *skb_frag_page(const skb_=
frag_t *frag)
>   */
>  static inline void __skb_frag_ref(skb_frag_t *frag)
>  {
> -	get_page(skb_frag_page(frag));
> +	page_pool_page_get_many(frag->bv_page, 1);

I guess the above needs #ifdef CONFIG_PAGE_POOL guards and explicit
skb_frag_is_page_pool_iov() check ?


Cheers,

Paolo

