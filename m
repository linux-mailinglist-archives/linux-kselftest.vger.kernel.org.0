Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFE33174F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 20:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCHTbY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 14:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231362AbhCHTaz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 14:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615231854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jT4Hj8BeYnoF98JbUFi2MpJbJ0BKhyhcjPIfynVz8ls=;
        b=YUog9A2B57F4N8HMumS69W9y7UY4W2bZtM4X1kW5olWRNMTmPIKIL/Xs1WYqY55BVaSJxI
        IEqNKKNscjqp/Kz6DnFVHtBeQjxAVodZ4sCV6DIdP3jhzKJGXvAsYKKGV5rWpyxA0ugMZX
        KfoWSCnHfTBdfEJTMKr5uAHgttaw8gY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-JoIuuXzyPTujjwvPCg_RtA-1; Mon, 08 Mar 2021 14:30:50 -0500
X-MC-Unique: JoIuuXzyPTujjwvPCg_RtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CDC657;
        Mon,  8 Mar 2021 19:30:48 +0000 (UTC)
Received: from [10.36.113.123] (ovpn-113-123.ams2.redhat.com [10.36.113.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 576AF5D6D5;
        Mon,  8 Mar 2021 19:30:46 +0000 (UTC)
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
To:     Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
References: <20210308152221.28555-1-zi.yan@sent.com>
 <79458c46-b4b9-332b-77f7-44371502cbeb@redhat.com>
 <AD0AFA61-8DCF-467D-B961-ACFA1D33828C@nvidia.com>
 <8039e1d7-3442-f133-f4f6-fe934f02122e@redhat.com>
 <9A4EF5F7-1BFF-4F8D-80B8-B559C05635BE@nvidia.com>
 <CAHbLzkofsc4_wEGmMFKwkUrc1pg4Y7iZZ9QKAXggiyg8RuOMqA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c530e051-9292-1b2c-3036-70fc1eac3bfa@redhat.com>
Date:   Mon, 8 Mar 2021 20:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkofsc4_wEGmMFKwkUrc1pg4Y7iZZ9QKAXggiyg8RuOMqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08.03.21 20:11, Yang Shi wrote:
> On Mon, Mar 8, 2021 at 11:01 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 8 Mar 2021, at 13:11, David Hildenbrand wrote:
>>
>>> On 08.03.21 18:49, Zi Yan wrote:
>>>> On 8 Mar 2021, at 11:17, David Hildenbrand wrote:
>>>>
>>>>> On 08.03.21 16:22, Zi Yan wrote:
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>>>>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with the
>>>>>> given pid and virtual address range are split. It is used to test
>>>>>> split_huge_page function. In addition, a selftest program is added to
>>>>>> tools/testing/selftests/vm to utilize the interface by splitting
>>>>>> PMD THPs and PTE-mapped THPs.
>>>>>
>>>>> Won't something like
>>>>>
>>>>> 1. MADV_HUGEPAGE
>>>>>
>>>>> 2. Access memory
>>>>>
>>>>> 3. MADV_NOHUGEPAGE
>>>>>
>>>>> Have a similar effect? What's the benefit of this?
>>>>
>>>> Thanks for checking the patch.
>>>>
>>>> No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE,
>>>> nothing else will be done.
>>>
>>> Ah, okay - maybe my memory was tricking me. There is some s390x KVM code that forces MADV_NOHUGEPAGE and force-splits everything.
>>>
>>> I do wonder, though, if this functionality would be worth a proper user interface (e.g., madvise), though. There might be actual benefit in having this as a !debug interface.
>>>
>>> I think you aware of the discussion in https://lkml.kernel.org/r/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com
>>
>> Yes. Thanks for bringing this up.
>>
>>>
>>> If there will be an interface to collapse a THP -- "this memory area is worth extra performance now by collapsing a THP if possible" -- it might also be helpful to have the opposite functionality -- "this memory area is not worth a THP, rather use that somehwere else".
>>>
>>> MADV_HUGE_COLLAPSE vs. MADV_HUGE_SPLIT
>>
>> I agree that MADV_HUGE_SPLIT would be useful as the opposite of COLLAPSE when user might just want PAGESIZE mappings.
>> Right now, HUGE_SPLIT is implicit from mapping changes like mprotect or MADV_DONTNEED.
> 
> IMHO, it sounds not very useful. MADV_DONTNEED would split PMD for any
> partial THP. If the range covers the whole THP, the whole THP is going
> to be freed anyway. All other places in kernel which need split THP
> have been covered. So I didn't realize any usecase from userspace for
> just splitting PMD to PTEs.

THP are a limited resource. So indicating which virtual memory regions 
are not performance sensitive right now (e.g., cold pages in a databse) 
and not worth a THP might be quite valuable, no?

-- 
Thanks,

David / dhildenb

