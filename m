Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4532B7E61BD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 02:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjKIBPm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 20:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjKIBPm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 20:15:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E52684
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 17:15:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc30bf9e22so2668825ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 17:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1699492539; x=1700097339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJB2HzPFVnzl6OnBO06iUXlf1dFeMFQcQCJyWfsLLCM=;
        b=oU+zW1JdlEDddCtLn2Vwe03LgnZG04PA20yor1yaYAokCZTbKT1vInggEJz6JAEUnZ
         L02aVFp1o9bISNJJb72JekUAEvK5o+pfsrq47kqm0tBzlv3k2g5DdT4q3qhkpHnFu6/E
         AlR9eBSyJ4cdrGi4+Nuw8VTSP0LY89X1e4JwL2SMYCvqisD+T1Mhw03J7FrPr7O2yVMa
         hYZp4PFEX3I9Mqh6JpY1icCt4KBOjvjB8a5P4FgJQBZ5S8BNfkvI8afBg2nRmf4+SX3w
         C2tD45LgTM7YX6zqix0odVOIls6rxx7DZUbIyYaZpKU3TGO7ER2/zsnhAarefMFAkiU2
         rcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699492539; x=1700097339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJB2HzPFVnzl6OnBO06iUXlf1dFeMFQcQCJyWfsLLCM=;
        b=IlaxTggRD9uSk6UbHItbfkklGzKhDmozNsahInl7it/mfZL+KbQeM4uHVKa4wSo7GW
         3bkC0OFs5yRIujdQOcm8gDR9/ybHFI4o7CoBO0DwDyqPuUkaMrOoEHrdjw4XGLJgdwQ+
         CV2fdsns04qYvxHpnd2+mYPLyR3L3a7N4wpfHAOApngfZJOU2rQ9DfhMjaNfTUOit6h1
         YHf4ywUqOnkCuBfvvckslYsNb8aQLpDihfUGVBmNXGaKtIugMPpZ4/hftI338irkM8OZ
         hk4fs/bxXvOQJ0a3Sjv1/ZIvkUVaZuajLwQU34N/0EWFWaTM/1Uw0naopgrQkl1Z0t80
         At9g==
X-Gm-Message-State: AOJu0YxddGnJxGDtGAHQGCJb1SfIr5Tn/SoLGe0WU3eFAhpca8Nc3CeB
        jTn2o1F35ao372GXrQPbwYRE2g==
X-Google-Smtp-Source: AGHT+IEppdvik8GMA+ADUF0nvc93yMlmYp9AyXurMTUDu1ruiRbNSJ04wmW0jrxiNpH9ub52AlowNw==
X-Received: by 2002:a17:902:d487:b0:1cc:4d4e:bfb4 with SMTP id c7-20020a170902d48700b001cc4d4ebfb4mr10863357plg.12.1699492539395;
        Wed, 08 Nov 2023 17:15:39 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:887f])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001ae0152d280sm2268962plg.193.2023.11.08.17.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 17:15:39 -0800 (PST)
Message-ID: <cdf21548-8c95-448e-88a4-701727ad7538@davidwei.uk>
Date:   Wed, 8 Nov 2023 17:15:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
Content-Language: en-GB
To:     Mina Almasry <almasrymina@google.com>,
        David Ahern <dsahern@kernel.org>
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
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com>
 <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
 <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
 <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
 <CAHS8izMKDOw5_y2MLRfuJHs=ai+sZ6GF7Rg1NuR_JqONg-5u5Q@mail.gmail.com>
From:   David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izMKDOw5_y2MLRfuJHs=ai+sZ6GF7Rg1NuR_JqONg-5u5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-11-07 15:03, Mina Almasry wrote:
> On Tue, Nov 7, 2023 at 2:55 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 11/7/23 3:10 PM, Mina Almasry wrote:
>>> On Mon, Nov 6, 2023 at 3:44 PM David Ahern <dsahern@kernel.org> wrote:
>>>>
>>>> On 11/5/23 7:44 PM, Mina Almasry wrote:
>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>> index eeeda849115c..1c351c138a5b 100644
>>>>> --- a/include/linux/netdevice.h
>>>>> +++ b/include/linux/netdevice.h
>>>>> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
>>>>>  };
>>>>>
>>>>>  #ifdef CONFIG_DMA_SHARED_BUFFER
>>>>> +struct page_pool_iov *
>>>>> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
>>>>> +void netdev_free_devmem(struct page_pool_iov *ppiov);
>>>>
>>>> netdev_{alloc,free}_dmabuf?
>>>>
>>>
>>> Can do.
>>>
>>>> I say that because a dmabuf can be host memory, at least I am not aware
>>>> of a restriction that a dmabuf is device memory.
>>>>
>>>
>>> In my limited experience dma-buf is generally device memory, and
>>> that's really its use case. CONFIG_UDMABUF is a driver that mocks
>>> dma-buf with a memfd which I think is used for testing. But I can do
>>> the rename, it's more clear anyway, I think.
>>
>> config UDMABUF
>>         bool "userspace dmabuf misc driver"
>>         default n
>>         depends on DMA_SHARED_BUFFER
>>         depends on MEMFD_CREATE || COMPILE_TEST
>>         help
>>           A driver to let userspace turn memfd regions into dma-bufs.
>>           Qemu can use this to create host dmabufs for guest framebuffers.
>>
>>
>> Qemu is just a userspace process; it is no way a special one.
>>
>> Treating host memory as a dmabuf should radically simplify the io_uring
>> extension of this set.
> 
> I agree actually, and I was about to make that comment to David Wei's
> series once I have the time.
> 
> David, your io_uring RX zerocopy proposal actually works with devmem
> TCP, if you're inclined to do that instead, what you'd do roughly is
> (I think):
> 
> - Allocate a memfd,
> - Use CONFIG_UDMABUF to create a dma-buf out of that memfd.
> - Bind the dma-buf to the NIC using the netlink API in this RFC.
> - Your io_uring extensions and io_uring uapi should work as-is almost
> on top of this series, I think.
> 
> If you do this the incoming packets should land into your memfd, which
> may or may not work for you. In the future if you feel inclined to use
> device memory, this approach that I'm describing here would be more
> extensible to device memory, because you'd already be using dma-bufs
> for your user memory; you'd just replace one kind of dma-buf (UDMABUF)
> with another.
> 

How would TCP devmem change if we no longer assume that dmabuf is device
memory? Pavel will know more on the perf side, but I wouldn't want to
put any if/else on the hot path if we can avoid it. I could be wrong,
but right now in my mind using different memory providers solves this
neatly and the driver/networking stack doesn't need to care.

Mina, I believe you said at NetDev conf that you already had an udmabuf
implementation for testing. I would like to see this (you can send
privately) to see how TCP devmem would handle both user memory and
device memory.

>> That the io_uring set needs to dive into
>> page_pools is just wrong - complicating the design and code and pushing
>> io_uring into a realm it does not need to be involved in.
>>
>> Most (all?) of this patch set can work with any memory; only device
>> memory is unreadable.
>>
>>
> 
> 
