Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6D7E362B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 09:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjKGIBs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 03:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjKGIBs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 03:01:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F2E8;
        Tue,  7 Nov 2023 00:01:45 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SPgf74yFYzvQS6;
        Tue,  7 Nov 2023 16:01:35 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 7 Nov
 2023 16:00:33 +0800
Subject: Re: [RFC PATCH v3 07/12] page-pool: device memory support
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
 <20231106024413.2801438-8-almasrymina@google.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <4a0e9d53-324d-e19b-2a30-ba86f9e5569e@huawei.com>
Date:   Tue, 7 Nov 2023 16:00:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231106024413.2801438-8-almasrymina@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/11/6 10:44, Mina Almasry wrote:
> Overload the LSB of struct page* to indicate that it's a page_pool_iov.
> 
> Refactor mm calls on struct page* into helpers, and add page_pool_iov
> handling on those helpers. Modify callers of these mm APIs with calls to
> these helpers instead.
> 
> In areas where struct page* is dereferenced, add a check for special
> handling of page_pool_iov.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  include/net/page_pool/helpers.h | 74 ++++++++++++++++++++++++++++++++-
>  net/core/page_pool.c            | 63 ++++++++++++++++++++--------
>  2 files changed, 118 insertions(+), 19 deletions(-)
> 
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index b93243c2a640..08f1a2cc70d2 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -151,6 +151,64 @@ static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
>  	return NULL;
>  }
>  
> +static inline int page_pool_page_ref_count(struct page *page)
> +{
> +	if (page_is_page_pool_iov(page))
> +		return page_pool_iov_refcount(page_to_page_pool_iov(page));

We have added a lot of 'if' for the devmem case, it would be better to
make it more generic so that we can have more unified metadata handling
for normal page and devmem. If we add another memory type here, do we
need another 'if' here?
That is part of the reason I suggested using a more unified metadata for
all the types of memory chunks used by page_pool.
