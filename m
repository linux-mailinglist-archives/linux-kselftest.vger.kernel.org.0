Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481A07E319F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 00:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjKFXt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 18:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjKFXtZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 18:49:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F392;
        Mon,  6 Nov 2023 15:49:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E181EC433C8;
        Mon,  6 Nov 2023 23:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699314562;
        bh=vxZh7uQV/qwyCfhEVz7KfEgklD4PUHvJkzFT4Xt+7Io=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TFosqqH0vuGDxkFCsh+y8Th4LUHgwk30AfF75ljEHSTXLtMUk2YpH/GAXfDeG1cB3
         EzzTqqwD10r+HNVDCDGMl/N9V+DlnnlaMlnsdhCSKRXW7kiDd6ZX/CfRV6Cct4HtiQ
         wzhiUJixHByChVm0W6BzlMoNriYyTYKbS8P7oxUmWSqfycy8waSYkgLZ8G7l6DcUb9
         yRu6v2+nPnJJ/LEhXXMhAppXHfuR2Ot211vqmVt2x0dQ0FQD/LjomoseKxhd4IkmfI
         nO3xKT4vKQZHAedO3bH2w68OluwUQn9mgzPzFUjOGKBQBQdEfJLpsI+oxYPSbYpJ42
         d4M9M97iHVSYw==
Message-ID: <583db67b-96c6-4e17-bea0-b5a14799db4a@kernel.org>
Date:   Mon, 6 Nov 2023 16:49:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory
 provider
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc:     "David S. Miller" <davem@davemloft.net>,
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
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-7-almasrymina@google.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231106024413.2801438-7-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/23 7:44 PM, Mina Almasry wrote:
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 78cbb040af94..b93243c2a640 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -111,6 +112,45 @@ page_pool_iov_binding(const struct page_pool_iov *ppiov)
>  	return page_pool_iov_owner(ppiov)->binding;
>  }
>  
> +static inline int page_pool_iov_refcount(const struct page_pool_iov *ppiov)
> +{
> +	return refcount_read(&ppiov->refcount);
> +}
> +
> +static inline void page_pool_iov_get_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	refcount_add(count, &ppiov->refcount);
> +}
> +
> +void __page_pool_iov_free(struct page_pool_iov *ppiov);
> +
> +static inline void page_pool_iov_put_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	if (!refcount_sub_and_test(count, &ppiov->refcount))
> +		return;
> +
> +	__page_pool_iov_free(ppiov);
> +}
> +
> +/* page pool mm helpers */
> +
> +static inline bool page_is_page_pool_iov(const struct page *page)
> +{
> +	return (unsigned long)page & PP_DEVMEM;

This is another one where the code can be more generic to not force a
lot changes later.  e.g., PP_CUSTOM or PP_NO_PAGE. Then io_uring use
case with host memory can leverage the iov pool in a similar manner.

That does mean skb->devmem needs to be a flag on the page pool and not
just assume iov == device memory.


