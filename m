Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178687E61A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 02:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjKIBAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 20:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjKIBAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 20:00:46 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029CD2118
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 17:00:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc2575dfc7so2343885ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 17:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1699491643; x=1700096443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+m1/eec3BAI+VxQgeWP5nozlTdhs+GvhhRREFgPtnw=;
        b=twBcydj177gEe6trQmjXVoEAVUA814gQxanP2tNi0bC3WYu6GFBi1NTJRuGFMc7qcb
         N1KFTTsThKZvuYzaT5/e43BdLn98gA4KcYLDiodnOM9uamizS8mZ9pXr73tQHJjWEjHi
         g9H1P6xpegWWj9yuDLHtWitsfInUyguJwyoGEy8ZNIbkP0BgIllWYEhtXdtsjPAqaAV7
         5jjzjuj9NNgm7m2bXKd8/ghLRdWG1Lf80THlMHFiVTNR9MpuDFRZUIrpZDMmqvafM0jH
         rzsw88LY2cGiakpGyVwhgep1rMZP8RoXur38b63NkiS9x71ETQvVDbUGwbahhix27iXP
         W6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699491643; x=1700096443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+m1/eec3BAI+VxQgeWP5nozlTdhs+GvhhRREFgPtnw=;
        b=sPZJHPVQPwdoBmOyKr243CwfuyhToFfGJouo3RDNxtshg65jkTT6ufkjJtDTauUM+e
         NorhYnUwRN+xbhmJR/+6xpw+56ksLfX/6ekoDYhbgi0PkNesXA0tO0kbGU42u/cHp7I5
         1CTZP2lF+dIWNAjyPeXsej+oY9lDOwEywrUhNaZ7sT0klPsnDUKbgWr/T4O5Z+6Zm6w/
         L2vcvz1oFmXRXXjxfBL0eZYuILtBxa5csdFj+9ozmTXMe+KVi3tbsvr7/Z8xeNrtzm0J
         xkoekO1PvohtY5jCu4KnVrnPg3r8oglXkW+2HB4Q2HANDRv9E07Md6pPhBIubA/OWUF/
         lnnA==
X-Gm-Message-State: AOJu0Yyvm3lYvPFsK4JsUUet0q6RW0NtAT9SiVEqXKIHY64vIZSCspP7
        iDzt0Q4wHCJXDp/QKBC34muEkg==
X-Google-Smtp-Source: AGHT+IGqOk5pLGreahWyU5Tyhch5OGepp+ms2LPYRQxo1oPkx1W4LYvgzN77Bieh5CFVk1MoPdYbhQ==
X-Received: by 2002:a17:902:d2cf:b0:1cc:6acc:8fa4 with SMTP id n15-20020a170902d2cf00b001cc6acc8fa4mr4025647plc.32.1699491643400;
        Wed, 08 Nov 2023 17:00:43 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:887f])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b001b0358848b0sm2287468plp.161.2023.11.08.17.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 17:00:43 -0800 (PST)
Message-ID: <b1476f8e-1b4b-497a-9e80-aff679ca8b4b@davidwei.uk>
Date:   Wed, 8 Nov 2023 17:00:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
Content-Language: en-GB
To:     David Ahern <dsahern@kernel.org>,
        Mina Almasry <almasrymina@google.com>
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
From:   David Wei <dw@davidwei.uk>
In-Reply-To: <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-11-07 14:55, David Ahern wrote:
> On 11/7/23 3:10 PM, Mina Almasry wrote:
>> On Mon, Nov 6, 2023 at 3:44 PM David Ahern <dsahern@kernel.org> wrote:
>>>
>>> On 11/5/23 7:44 PM, Mina Almasry wrote:
>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>> index eeeda849115c..1c351c138a5b 100644
>>>> --- a/include/linux/netdevice.h
>>>> +++ b/include/linux/netdevice.h
>>>> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
>>>>  };
>>>>
>>>>  #ifdef CONFIG_DMA_SHARED_BUFFER
>>>> +struct page_pool_iov *
>>>> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
>>>> +void netdev_free_devmem(struct page_pool_iov *ppiov);
>>>
>>> netdev_{alloc,free}_dmabuf?
>>>
>>
>> Can do.
>>
>>> I say that because a dmabuf can be host memory, at least I am not aware
>>> of a restriction that a dmabuf is device memory.
>>>
>>
>> In my limited experience dma-buf is generally device memory, and
>> that's really its use case. CONFIG_UDMABUF is a driver that mocks
>> dma-buf with a memfd which I think is used for testing. But I can do
>> the rename, it's more clear anyway, I think.
> 
> config UDMABUF
>         bool "userspace dmabuf misc driver"
>         default n
>         depends on DMA_SHARED_BUFFER
>         depends on MEMFD_CREATE || COMPILE_TEST
>         help
>           A driver to let userspace turn memfd regions into dma-bufs.
>           Qemu can use this to create host dmabufs for guest framebuffers.
> 
> 
> Qemu is just a userspace process; it is no way a special one.
> 
> Treating host memory as a dmabuf should radically simplify the io_uring
> extension of this set. That the io_uring set needs to dive into
> page_pools is just wrong - complicating the design and code and pushing
> io_uring into a realm it does not need to be involved in.

I think our io_uring proposal will already be vastly simplified once we
rebase onto Kuba's page pool memory provider API. Using udmabuf means
depending on a driver designed for testing, vs io_uring's registered
buffers API that's been tried and tested.

I don't have an intuitive understanding of the trade offs yet, and would
need to try out udmabuf and compare vs say using our own page pool
memory provider.

> 
> Most (all?) of this patch set can work with any memory; only device
> memory is unreadable.
> 
> 
