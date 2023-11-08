Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB17E5576
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjKHL0K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 06:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344373AbjKHLZ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 06:25:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338D01BFA;
        Wed,  8 Nov 2023 03:25:54 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SQN3h1ypLzrTq2;
        Wed,  8 Nov 2023 19:22:40 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 8 Nov
 2023 19:25:17 +0800
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
To:     Mina Almasry <almasrymina@google.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-9-almasrymina@google.com>
 <7e851882-9a85-3672-c3d5-73b47599873c@huawei.com>
 <CAHS8izPGa99LyEc=AeqNaK8X68b7dovxCHOLbR=hnbaybN_zgQ@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e9c9b58d-4b78-fe2d-4511-b0ffa744a994@huawei.com>
Date:   Wed, 8 Nov 2023 19:25:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izPGa99LyEc=AeqNaK8X68b7dovxCHOLbR=hnbaybN_zgQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/11/8 5:19, Mina Almasry wrote:
>>
>>
> 
> My personal immediate reaction is that this may just introduce code
> churn without significant benefit. If an unsuspecting caller call
> skb_frag_page() on devmem frag and doesn't correctly handle NULL
> return, it will crash or error out anyway, and likely in some obvious
> way, so maybe the BUG_ON() isn't so useful that it's worth changing

If it will always crash or error out, then I agree that BUG_ON() is
unnecessary.

> all the call sites. But if there is consensus on adding a change like
> you propose, I have no problem adding it.

One obvious benefit I forget to mention is that, it provides a better
semantic that if a caller need to do the return checking:
1. For the old helper, the semantic is not to do the checking if the caller
   has ensure that it has passed a readable frag to skb_frag_page(), which
   avoid adding some overhead for non-devmen supported drivers.
2. For the new helper, the semantic is to do the checking and we may provide
   a compiler '__must_check' function-attribute to ensure the caller to do
   the checking.


> 
