Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805677E4DB9
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 01:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjKHAKO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 19:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKHAKN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 19:10:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8710C3;
        Tue,  7 Nov 2023 16:10:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBF6C433C7;
        Wed,  8 Nov 2023 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699402210;
        bh=49/18eui175XW6NzFUiZghmKR051RlPOSAcbSznIRN0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ICoTurgjXoU7vBaB5nU3XnpCuGXUGM/Lg+7nx9Zg5c9Vx2xHyr8NmLns0KLqXONdI
         R8LCfCS/mHRDjwxTSoVe+sj1cDEttA8Y0JuKSpm6lLw1n/qSIvaHCleQRX+/QjqfLB
         9Bnfw+85Cc/QjVXk/VLdQ1jhn6eKkRkQigB0ZLL0MOdSoiV/erOA1zHYVxiYbjmu34
         FBxFuBnpvV+HFTIqWMpFB8XBpikQNZwbiRDQ+p87uOEkTycDU3xckJomKwbrGlJPDI
         Tua1FNCNa4KtRmoEEFxhCTAEpwuhMRfvnw4geJfz4mItNfTxdevbQPqdoQT+SaaD4C
         6UXbF+jG51x8A==
Message-ID: <674f6ae2-d88e-4203-83f9-e9a9322393d9@kernel.org>
Date:   Tue, 7 Nov 2023 17:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory
 provider
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
 <20231106024413.2801438-7-almasrymina@google.com>
 <583db67b-96c6-4e17-bea0-b5a14799db4a@kernel.org>
 <CAHS8izME7NixQrrh+qKnMR4+FyTzKW=B2pYyNffJ+igiehe-7g@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izME7NixQrrh+qKnMR4+FyTzKW=B2pYyNffJ+igiehe-7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/23 5:02 PM, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 1:02 PM Stanislav Fomichev <sdf@google.com> wrote:
>>
>> On 11/05, Mina Almasry wrote:
>>> +static inline bool page_is_page_pool_iov(const struct page *page)
>>> +{
>>> +     return (unsigned long)page & PP_DEVMEM;
>>> +}
>>
>> Speaking of bpf: one thing that might be problematic with this PP_DEVMEM
>> bit is that it will make debugging with bpftrace a bit (more)
>> complicated. If somebody were trying to get to that page_pool_iov from
>> the frags, they will have to do the equivalent of page_is_page_pool_iov,
>> but probably not a big deal? (thinking out loud)
> 
> Good point, but that doesn't only apply to bpf I think. I'm guessing
> even debugger drgn access to the bv_page in the frag will have trouble
> if it's actually accessing an iov with LSB set.
> 
> But this is not specific to this use for LSB pointer trick. I think
> all code that currently uses LSB pointer trick will have similar
> troubles. In this context my humble vote is that we get such big
> upside from reducing code churn that it's reasonable to tolerate such
> side effects.

+1

> 
> I could alleviate some of the issues by teaching drgn to do the right
> thing for devmem/iovs... time permitting.
> 
Tools like drgn and crash have to know when the LSB trick is used  -
e.g., dst_entry - and handle it when dereferencing pointers.
