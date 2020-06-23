Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D8E2047AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 04:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgFWCv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 22:51:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:8474 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731434AbgFWCv3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:29 -0400
IronPort-SDR: 4fbRkBhI0456nAQ2Bh7NG9bIu3yjvSMzVHIXGINkMdblffyF5QwuUh4Xsfw0xXUIFpbwy05fjw
 +XLsug8z7FCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="143920307"
X-IronPort-AV: E=Sophos;i="5.75,269,1589266800"; 
   d="scan'208";a="143920307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 19:51:27 -0700
IronPort-SDR: stMi4x4u0lGE9oF6INyqSIVVZASuHoTY6RLBNhZfKd1cGfjSj+eDTH/4My3zENuLBHRiWuxxoE
 C4MywkOnf8rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,269,1589266800"; 
   d="scan'208";a="275201085"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2020 19:51:24 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
        Zi Yan <ziy@nvidia.com>, <nouveau@lists.freedesktop.org>,
        <linux-rdma@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 13/16] mm: support THP migration to device private memory
References: <20200619215649.32297-1-rcampbell@nvidia.com>
        <20200619215649.32297-14-rcampbell@nvidia.com>
        <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com>
        <b6eed976-c515-72d6-a7be-2296cab8f0d4@nvidia.com>
        <C7BEB563-3698-442C-A188-1B66CBE4CF63@nvidia.com>
        <a5f502f8-70cd-014b-8066-bbaeb8024a29@nvidia.com>
        <4C364E23-0716-4D59-85A1-0C293B86BC2C@nvidia.com>
        <CAHbLzkqe50+KUsRH92O4Be2PjuwAYGw9nK+d-73syxi2Xnf9-Q@mail.gmail.com>
        <CAHbLzko=BqtPhxgf7f1bKKqoQxK9XCCPdp4YdL80K_uXFfcETQ@mail.gmail.com>
        <fa056e5e-ca87-aef1-e66e-58e8ebe5403e@nvidia.com>
        <CAHbLzkrR4-s+ye1F3XDV_0q+iyZOcyMQNHTggDY3Mn_e2yOZ7g@mail.gmail.com>
        <a778dcec-045b-85c0-2dd3-ac700e4208c5@nvidia.com>
Date:   Tue, 23 Jun 2020 10:51:23 +0800
In-Reply-To: <a778dcec-045b-85c0-2dd3-ac700e4208c5@nvidia.com> (Ralph
        Campbell's message of "Mon, 22 Jun 2020 17:05:37 -0700")
Message-ID: <87zh8uze8k.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ralph Campbell <rcampbell@nvidia.com> writes:

> On 6/22/20 4:54 PM, Yang Shi wrote:
>> On Mon, Jun 22, 2020 at 4:02 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>
>>> On 2020-06-22 15:33, Yang Shi wrote:
>>>> On Mon, Jun 22, 2020 at 3:30 PM Yang Shi <shy828301@gmail.com> wrote:
>>>>> On Mon, Jun 22, 2020 at 2:53 PM Zi Yan <ziy@nvidia.com> wrote:
>>>>>> On 22 Jun 2020, at 17:31, Ralph Campbell wrote:
>>>>>>> On 6/22/20 1:10 PM, Zi Yan wrote:
>>>>>>>> On 22 Jun 2020, at 15:36, Ralph Campbell wrote:
>>>>>>>>> On 6/21/20 4:20 PM, Zi Yan wrote:
>>>>>>>>>> On 19 Jun 2020, at 17:56, Ralph Campbell wrote:
>>> ...
>>>>>> Ying(cc’d) developed the code to swapout and swapin THP in one piece: https://lore.kernel.org/linux-mm/20181207054122.27822-1-ying.huang@intel.com/.
>>>>>> I am not sure whether the patchset makes into mainstream or not. It could be a good technical reference
>>>>>> for swapping in device private pages, although swapping in pages from disk and from device private
>>>>>> memory are two different scenarios.
>>>>>>
>>>>>> Since the device private memory swapin impacts core mm performance, we might want to discuss your patches
>>>>>> with more people, like the ones from Ying’s patchset, in the next version.
>>>>>
>>>>> I believe Ying will give you more insights about how THP swap works.
>>>>>
>>>>> But, IMHO device memory migration (migrate to system memory) seems
>>>>> like THP CoW more than swap.
>>>
>>>
>>> A fine point: overall, the desired behavior is "migrate", not CoW.
>>> That's important. Migrate means that you don't leave a page behind, even
>>> a read-only one. And that's exactly how device private migration is
>>> specified.
>>>
>>> We should try to avoid any erosion of clarity here. Even if somehow
>>> (really?) the underlying implementation calls this THP CoW, the actual
>>> goal is to migrate pages over to the device (and back).
>>>
>>>
>>>>>
>>>>> When migrating in:
>>>>
>>>> Sorry for my fat finger, hit sent button inadvertently, let me finish here.
>>>>
>>>> When migrating in:
>>>>
>>>>           - if THP is enabled: allocate THP, but need handle allocation
>>>> failure by falling back to base page
>>>>           - if THP is disabled: fallback to base page
>>>>
>>>
>>> OK, but *all* page entries (base and huge/large pages) need to be cleared,
>>> when migrating to device memory, unless I'm really confused here.
>>> So: not CoW.
>>
>> I realized the comment caused more confusion. I apologize for the
>> confusion. Yes, the trigger condition for swap/migration and CoW are
>> definitely different. Here I mean the fault handling part of migrating
>> into system memory.
>>
>> Swap-in just needs to handle the base page case since THP swapin is
>> not supported in upstream yet and the PMD is split in swap-out phase
>> (see shrink_page_list).
>>
>> The patch adds THP migration support to device memory, but you need to
>> handle migrate in (back to system memory) case correctly. The fault
>> handling should look like THP CoW fault handling behavior (before
>> 5.8):
>>      - if THP is enabled: allocate THP, fallback if allocation is failed
>>      - if THP is disabled: fallback to base page
>>
>> Swap fault handling doesn't look like the above. So, I said it seems
>> like more THP CoW (fault handling part only before 5.8). I hope I
>> articulate my mind.
>>
>> However, I didn't see such fallback is handled. It looks if THP
>> allocation is failed, it just returns SIGBUS; and no check about THP
>> status if I read the patches correctly. The THP might be disabled for
>> the specific vma or system wide before migrating from device memory
>> back to system memory.
>
> You are correct, the patch wasn't handling the fallback case.
> I'll add that in the next version.

For fallback, you need to split the THP in device firstly.  Because you
will migrate a base page instead a whole THP now.

Best Regards,
Huang, Ying

>>>
>>> thanks,
>>> --
>>> John Hubbard
>>> NVIDIA
