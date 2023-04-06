Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33576D9E1D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjDFRDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 13:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDFRDV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 13:03:21 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C80273F;
        Thu,  6 Apr 2023 10:03:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 38225320097A;
        Thu,  6 Apr 2023 13:03:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Apr 2023 13:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680800595; x=1680886995; bh=yg
        Gy2hfGMUZ/sVKx6qf9fqJmSIWmeg4Snqz38AyDgXs=; b=Rf0A9xNpCsujqRcO+S
        DI8YVguRlCs1X375klibe/SRPN+UF0IB2rU6CliVHfBfwMhPYzYTFWIzKMEDgpWe
        sfUYgWpEi2rY/Xn7GNyUFAQCk0UgYUo5QNcvGm/p9lxYic60WDZioVHMegSY5IxC
        LyOXQ1TgpSoWzvsKKBjE1NkZyjxlPZD24GXB3s0ebvAE5KxmlzLFR9bMUiW/kF1j
        71CqxPigYZUbhzhD2KkuKQ4hFOViLJyjIZInFjc90UTFAYWy0DjqcAcGLW7xwhNX
        vQM5NUZ7J0+1VTEz13yq6CwUzrTKzikeNxIPVZlz1v5oW7HG63/xcnl5MhJae0g2
        O7dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680800595; x=1680886995; bh=ygGy2hfGMUZ/s
        VKx6qf9fqJmSIWmeg4Snqz38AyDgXs=; b=ct2aPFIoakvaMYWpsWOaFgXYL7j7s
        hMLGpcgARKDcHTSbjIjzMAI4NauzikJCe3TW3mdmRMmtCmKeDj7iTcbbBMLcjQ9u
        udtN7CtVkeYovh64ePnFxf2lwvRDDF+L7yVaXcU4jzMpGLdtkyObTKUNAxJ/NcVW
        u91yfNgnECrIIyngVuGR80U9ck25GFpmrqLvIBis4WiR7wEHO7zXP9WvhCijodW2
        afdu3Zr2hjYl8pdb7UG5GgJ+wRY6YqipMFuy/E3lsTFH9IZ30LkvBQ3suu0Aeski
        J9xzHR+6pBD3/DVvrun1RzudY9tkCiG1PV8nhDymJpmzSv2MuheFFHo9w==
X-ME-Sender: <xms:UvsuZG090qMfzkx7t74Kmri2tM1HPtmF7sVGtf3I3eJy8nR7cSX4Vg>
    <xme:UvsuZJExJhJ1Bx8TnGghu9M6zKS_4AjIEl_VidOUWKNTIXcu2QtTAvy52l_g8qHzh
    w9-oTc44ccH0QqVX9M>
X-ME-Received: <xmr:UvsuZO6413G8PiH425ruAq9TCHq6eC_uAEzzhOWaPbChkuf4YUn0GBEBw2DCaWR5hcW6Dow022E5kQtMackd4FDY8WkdWBFEQnUJKyqn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:UvsuZH39Sm3gJRdLubRImCQ3Megz58hLEGzMf4ea6S6vkyVZ22EeRw>
    <xmx:UvsuZJEALDrzJTk-6Z_gShjRGMr6AZ22lhANlkkRVr6AQ2I2C6RrFg>
    <xmx:UvsuZA8g0RGNCHU6_8aIneTJK7_grLieYdHRPnLz0kRSOYp_zDb62Q>
    <xmx:U_suZPa4vtrNvwVWrzxQGJiC69Tsm2646Xx1IVf9aBPPnaYxF1DX5A>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 13:03:13 -0400 (EDT)
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
 <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
 <ZCWcJelF5bEdF4N3@cmpxchg.org>
 <ff599dc1-729d-52dc-d605-8a8ac890ad15@redhat.com>
 <qvqwv8ii89x6.fsf@dev0134.prn3.facebook.com>
 <f969cb1f-651f-592f-7540-89f73e175c7d@redhat.com>
 <qvqwlej8vrst.fsf@dev0134.prn3.facebook.com>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Date:   Thu, 06 Apr 2023 09:59:32 -0700
In-reply-to: <qvqwlej8vrst.fsf@dev0134.prn3.facebook.com>
Message-ID: <qvqw4jptc59w.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Stefan Roesch <shr@devkernel.io> writes:

> David Hildenbrand <david@redhat.com> writes:
>
>>>>> Obviously we could spend months analysing which exact allocations are
>>>>> identical, and then more months or years reworking the architecture to
>>>>> deduplicate them by hand and in userspace. But this isn't practical,
>>>>> and KSM is specifically for cases where this isn't practical.
>>>>> Based on your request in the previous thread, we investigated whether
>>>>> the boost was coming from the unintended side effects of KSM splitting
>>>>> THPs. This wasn't the case.
>>>>> If you have other theories on how the results could be bogus, we'd be
>>>>> happy to investigate those as well. But you have to let us know what
>>>>> you're looking for.
>>>>>
>>>>
>>>> Maybe I'm bad at making such requests but
>>>>
>>>> "Stefan, can you do me a favor and investigate which pages we end up
>>>> deduplicating -- especially if it's mostly only the zeropage and if it's
>>>> still that significant when disabling THP?"
>>>>
>>>> "In any case, it would be nice to get a feeling for how much variety in
>>>> these 20% of deduplicated pages are. "
>>>>
>>>> is pretty clear to me. And shouldn't take months.
>>>>
>>
>> Just to clarify: the details I requested are not meant to decide whether to
>> reject the patch set (I understand that it can be beneficial to have); I
>> primarily want to understand if we're really dealing with a workload where KSM
>> is able to deduplicate pages that are non-trivial, to maybe figure out if there
>> are other workloads that could similarly benefit -- or if we could optimize KSM
>> for these specific cases or avoid the memory deduplication altogether.
>>
>> In contrast to e.g.:
>>
>> 1) THP resulted in many zeropages we end up deduplicating again. The THP
>>    placement was unfortunate.
>>
>> 2) Unoptimized memory allocators that leave many identical pages mapped
>>    after freeing up memory (e.g., zeroed pages, pages all filled with
>>    poison values) instead of e.g., using MADV_DONTNEED to free up that
>>    memory.
>>
>>
>
> I repeated an experiment with and without KSM. In terms of THP there is
> no huge difference between the two. On a 64GB main memory machine I see
> between 100 - 400MB in AnonHugePages.
>
>>> /sys/kernel/mm/ksm/pages_shared is over 10000 when we run this on an
>>> Instagram workload. The workload consists of 36 processes plus a few
>>> sidecar processes.
>>
>> Thanks! To which value is /sys/kernel/mm/ksm/max_page_sharing set in that
>> environment?
>>
>
> It's set to the standard value of 256.
>
> In the meantime I have run experiments with different settings for
> pages_to_scan. With the default value of 100, we only get a relatively
> small benefit of KSM. If I increase the value to for instance to 2000 or
> 3000 the savings are substantial. (The workload is memory bound, not
> CPU bound).
>
> Here are some stats for setting pages_to_scan to 3000:
>
> full_scans: 560
> general_profit: 20620539008
> max_page_sharing: 256
> merge_across_nodes: 1
> pages_shared: 125446
> pages_sharing: 5259506
> pages_to_scan: 3000
> pages_unshared: 1897537
> pages_volatile: 12389223
> run: 1
> sleep_millisecs: 20
> stable_node_chains: 176
> stable_node_chains_prune_millisecs: 2000
> stable_node_dups: 2604
> use_zero_pages: 0
> zero_pages_sharing: 0
>
>
>> What would be interesting is pages_shared after max_page_sharing was set to a
>> very high number such that pages_shared does not include duplicates. Then
>> pages_shared actually expresses how many different pages we deduplicate. No need
>> to run without THP in that case.
>>
>
> Thats on my list for the next set of experiments.
>

In the new experiment I increased the max_page_sharing value to 16384.
This reduced the number of stable_node_dups considerably (its around 3%
of the previous value). However pages_sharing is still very high for
this workload.

full_scans: 138
general_profit: 24442268608
max_page_sharing: 16384
merge_across_nodes: 1
pages_shared: 144590
pages_sharing: 6230983
pages_to_scan: 3000
pages_unshared: 2120307
pages_volatile: 14590780
run: 1
sleep_millisecs: 20
stable_node_chains: 23
stable_node_chains_prune_millisecs: 2000
stable_node_dups: 78
use_zero_pages: 0
zero_pages_sharing: 0

>> Similarly, enabling "use_zero_pages" could highlight if your workload ends up
>> deduplciating a lot of zeropages. But maxing out max_page_sharing would be
>> sufficient to understand what's happening.
>>
>>
>
> I already run experiments with use_zero_pages, but they didn't make a
> difference. I'll repeat the experiment with a higher pages_to_scan
> value.
>
>>> Each of these individual processes has around 500MB in KSM pages.
>>>
>>
>> That's really a lot, thanks.
>>
>>> Also to give some idea for individual VMA's
>>> 7ef5d5600000-7ef5e5600000 rw-p 00000000 00:00 0 (Size: 262144 KB, KSM:
>>> 73160 KB)
>>>
>>
>> I'll have a look at the patches today.
