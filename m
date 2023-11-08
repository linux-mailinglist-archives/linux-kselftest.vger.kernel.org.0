Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455A67E4FA4
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 05:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjKHEK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 23:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHEK1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 23:10:27 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D236129;
        Tue,  7 Nov 2023 20:10:25 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SQBMj57xdzMmh5;
        Wed,  8 Nov 2023 12:05:53 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 8 Nov
 2023 11:48:49 +0800
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
To:     Mina Almasry <almasrymina@google.com>,
        David Ahern <dsahern@kernel.org>
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
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com>
 <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
 <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6c629d6d-6927-3857-edaa-1971a94b6e93@huawei.com>
Date:   Wed, 8 Nov 2023 11:48:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/11/8 6:10, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 3:44 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 11/5/23 7:44 PM, Mina Almasry wrote:
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index eeeda849115c..1c351c138a5b 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
>>>  };
>>>
>>>  #ifdef CONFIG_DMA_SHARED_BUFFER
>>> +struct page_pool_iov *
>>> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
>>> +void netdev_free_devmem(struct page_pool_iov *ppiov);
>>
>> netdev_{alloc,free}_dmabuf?
>>
> 
> Can do.
> 
>> I say that because a dmabuf can be host memory, at least I am not aware
>> of a restriction that a dmabuf is device memory.
>>
> 
> In my limited experience dma-buf is generally device memory, and
> that's really its use case. CONFIG_UDMABUF is a driver that mocks
> dma-buf with a memfd which I think is used for testing. But I can do
> the rename, it's more clear anyway, I think.
> 
> On Mon, Nov 6, 2023 at 11:45 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/11/6 10:44, Mina Almasry wrote:
>>> +
>>> +void netdev_free_devmem(struct page_pool_iov *ppiov)
>>> +{
>>> +     struct netdev_dmabuf_binding *binding = page_pool_iov_binding(ppiov);
>>> +
>>> +     refcount_set(&ppiov->refcount, 1);
>>> +
>>> +     if (gen_pool_has_addr(binding->chunk_pool,
>>> +                           page_pool_iov_dma_addr(ppiov), PAGE_SIZE))
>>
>> When gen_pool_has_addr() returns false, does it mean something has gone
>> really wrong here?
>>
> 
> Yes, good eye. gen_pool_has_addr() should never return false, but then
> again, gen_pool_free()  BUG_ON()s if it doesn't find the address,
> which is an extremely severe reaction to what can be a minor bug in
> the accounting. I prefer to leak rather than crash the machine. It's a
> bit of defensive programming that is normally frowned upon, but I feel
> like in this case it's maybe warranted due to the very severe reaction
> (BUG_ON).

I would argue that why is the above defensive programming not done in the
gen_pool core:)

> 
