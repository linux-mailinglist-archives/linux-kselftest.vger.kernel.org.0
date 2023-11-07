Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7B7E3713
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 10:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjKGJAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 04:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGJAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 04:00:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928DD101;
        Tue,  7 Nov 2023 01:00:41 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SPhtd20XRzrTwF;
        Tue,  7 Nov 2023 16:57:29 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 7 Nov
 2023 17:00:07 +0800
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
To:     Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
CC:     "David S. Miller" <davem@davemloft.net>,
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-9-almasrymina@google.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <7e851882-9a85-3672-c3d5-73b47599873c@huawei.com>
Date:   Tue, 7 Nov 2023 17:00:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231106024413.2801438-9-almasrymina@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/11/6 10:44, Mina Almasry wrote:
> Make skb_frag_page() fail in the case where the frag is not backed
> by a page, and fix its relevent callers to handle this case.
> 
> Correctly handle skb_frag refcounting in the page_pool_iovs case.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 

...

>  /**
>   * skb_frag_page - retrieve the page referred to by a paged fragment
>   * @frag: the paged fragment
>   *
> - * Returns the &struct page associated with @frag.
> + * Returns the &struct page associated with @frag. Returns NULL if this frag
> + * has no associated page.
>   */
>  static inline struct page *skb_frag_page(const skb_frag_t *frag)
>  {
> -	return frag->bv_page;
> +	if (!page_is_page_pool_iov(frag->bv_page))
> +		return frag->bv_page;
> +
> +	return NULL;

It seems most of callers don't expect NULL returning for skb_frag_page(),
and this patch only changes a few relevant callers to handle the NULL case.

It may make more sense to add a new helper to do the above checking, and
add a warning in skb_frag_page() to catch any missing NULL checking for
skb_frag_page() caller, something like below?

 static inline struct page *skb_frag_page(const skb_frag_t *frag)
 {
-       return frag->bv_page;
+       struct page *page = frag->bv_page;
+
+       BUG_ON(page_is_page_pool_iov(page));
+
+       return page;
+}
+
+static inline struct page *skb_frag_readable_page(const skb_frag_t *frag)
+{
+       struct page *page = frag->bv_page;
+
+       if (!page_is_page_pool_iov(page))
+               return page;
+
+       return NULL;
 }


