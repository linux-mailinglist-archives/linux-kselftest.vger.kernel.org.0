Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CE7E4C0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 23:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjKGWz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 17:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKGWz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 17:55:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E4118C;
        Tue,  7 Nov 2023 14:55:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75129C433C7;
        Tue,  7 Nov 2023 22:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699397724;
        bh=iB5WIQwRWCJ62sSwm7rVVjSX4KNeifY96+WD+ljQo7A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CwzKn3MLIlLci2fLlpr0m0pOk173vFyYAGolRpAoKUQY79y3Gsz/ZTWTY9UNQp0aT
         j3/uplXmQpqgMLpDUu+RzQD5rtH7NsPAK+YwQhsxHqxCoHd5KNx7iYjk3XekAeOLqW
         dmA44Lv3QYzFJDV6a7/X/M0Sk6Ch3fPiTogIrlEAa85Bytb2V42KPPN6Cu81fvUdHw
         NNBLdE0C7ah0RV48znH8Y18XD6UzmkAh0ggCZjl9ZrKnrdnYH7YVhCnv6wk7IYHWDT
         zTGv+xK1Anj9erQ5elOkREzeOde6rdEcp7w2E0bvGgmeVKep1IfXdMijuOwOs9FgO9
         VYN0GSclxC51A==
Message-ID: <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
Date:   Tue, 7 Nov 2023 15:55:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
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
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com>
 <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
 <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/23 3:10 PM, Mina Almasry wrote:
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

config UDMABUF
        bool "userspace dmabuf misc driver"
        default n
        depends on DMA_SHARED_BUFFER
        depends on MEMFD_CREATE || COMPILE_TEST
        help
          A driver to let userspace turn memfd regions into dma-bufs.
          Qemu can use this to create host dmabufs for guest framebuffers.


Qemu is just a userspace process; it is no way a special one.

Treating host memory as a dmabuf should radically simplify the io_uring
extension of this set. That the io_uring set needs to dive into
page_pools is just wrong - complicating the design and code and pushing
io_uring into a realm it does not need to be involved in.

Most (all?) of this patch set can work with any memory; only device
memory is unreadable.


