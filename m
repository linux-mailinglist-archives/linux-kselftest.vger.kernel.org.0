Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F06D0B73
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjC3Qh2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjC3QhY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 12:37:24 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869AD31C;
        Thu, 30 Mar 2023 09:37:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D4EF6320098E;
        Thu, 30 Mar 2023 12:37:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 Mar 2023 12:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680194234; x=1680280634; bh=BG
        wzN9alArpP+icGRPMJNrHFgvXg2GlJMjXi1YHIIuU=; b=HK0GjyYPrspfUfsigV
        M5c6WyqLPA1v/0CYq51mUt94arzTP+rMcNp3CVv4waWrQtIuJywSfQNxylh5D5Ta
        AdHSg1OqXc1/ZoUOc8iBSA4Qn8Dn2VyThB6ijF/zl9iJKwLj8gDXcq48IGny3J/8
        joZH3mKsu6Fpv8qls6a2KHSQNn0fNu9CvseycKHmp2DYRr9Xg47bVU66V3tfXDmM
        M6KQ2nCGYt4Lou0aICwY8LmQWuUPirN9IqwCYQZUPGaOse7aNW1u6p6OGY+MBe2/
        5FO3YiGiPvn+eYsr6YQCsw96+skI2/5V/08Pp0C+Uu6oEpnIGpmtjsHIwcCLLJdu
        gKgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680194234; x=1680280634; bh=BGwzN9alArpP+
        icGRPMJNrHFgvXg2GlJMjXi1YHIIuU=; b=KvQ8IMmEuABtTXS/YLUQYqfoEoj4D
        Atkzcj4w1TokeBF/Bv8hQZ7TLBV4kUxPmijbLkf4X+aU+gX8/BfMTruK0b9fsIBE
        IiVvq9eMA1zFHYiv0Vj2aHhtYISqBnx2/fwA8bgiTjUTilarFEWZhBwlsdDIi3/J
        KMOod7thqRNtk/fnQftrYQ/z6UUTFqlJ8Otk9hVNOtmnQYlsMHZ61qoL8qzPZXMk
        7PMsOsRcZL9n499ndAjfkhgHxA6TC5cXU6Iu1yfe0hBPdjNplZlWuLU4m2fP3Tic
        DG81Cy/Gjlu1Gc2PSf/sKsEvrUUhU/Y2RNRziOvPiKi+E5VdmbTXJF7pA==
X-ME-Sender: <xms:ubolZDQkYDHrNZOSauyAaHOX_qbj4s3lbtGggeqdi0KlX8vmFIDsTw>
    <xme:ubolZEw-XCaulLbIHgxsvNVJN3l3fV_JJ9VnJf9qDZjtznH9apU-SZEEsOmBNDqQX
    81FRPUBQ67xhN8Qq0M>
X-ME-Received: <xmr:ubolZI0mr4KJU7owTbzPpzbE0-UdYH8UJwDYRfR5w1-3OnsuCmzbcAvOLmCz8_8BFUFzYSp5lZ00p6Oz3os7kMUKO6JbBGSfKERg4ZPj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghf
    rghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrth
    htvghrnhepveelgffghfehudeitdehjeevhedthfetvdfhledutedvgeeikeeggefgudeg
    uedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:urolZDCEFRbYqUiGMQa6NQ2Rjjv10RLnPjFHRD1tT6_nYHq_cQ7xiA>
    <xmx:urolZMgscHQF-lpR2HlzG3CFn9-7goJLkULlQ_uEP3gH0CAtjECPHg>
    <xmx:urolZHpdRZXb3J7MV93e-2qQ42d08lBD6aTIaKyDQKlIIJOjhW8OYg>
    <xmx:urolZFXMWBz3-Faw4y2VLe5sms8-g-Wib_nUUwzSYuGSzoTVecDoPw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 12:37:12 -0400 (EDT)
References: <20230310182851.2579138-1-shr@devkernel.io>
 <273a2f82-928f-5ad1-0988-1a886d169e83@redhat.com>
 <20230315210545.GA116016@cmpxchg.org>
 <20230315211927.GB116016@cmpxchg.org>
 <c6a1c4fd-d8be-7942-bfe7-dc0e661a9c99@redhat.com>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Date:   Thu, 30 Mar 2023 09:19:19 -0700
In-reply-to: <c6a1c4fd-d8be-7942-bfe7-dc0e661a9c99@redhat.com>
Message-ID: <qvqwzg7u8abx.fsf@dev0134.prn3.facebook.com>
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


David Hildenbrand <david@redhat.com> writes:

> On 15.03.23 22:19, Johannes Weiner wrote:
>> On Wed, Mar 15, 2023 at 05:05:47PM -0400, Johannes Weiner wrote:
>>> On Wed, Mar 15, 2023 at 09:03:57PM +0100, David Hildenbrand wrote:
>>>> On 10.03.23 19:28, Stefan Roesch wrote:
>>>>> So far KSM can only be enabled by calling madvise for memory regions. To
>>>>> be able to use KSM for more workloads, KSM needs to have the ability to be
>>>>> enabled / disabled at the process / cgroup level.
>>>>>
>>>>> Use case 1:
>>>>> The madvise call is not available in the programming language. An example for
>>>>> this are programs with forked workloads using a garbage collected language without
>>>>> pointers. In such a language madvise cannot be made available.
>>>>>
>>>>> In addition the addresses of objects get moved around as they are garbage
>>>>> collected. KSM sharing needs to be enabled "from the outside" for these type of
>>>>> workloads.
>>>>>
>>>>> Use case 2:
>>>>> The same interpreter can also be used for workloads where KSM brings no
>>>>> benefit or even has overhead. We'd like to be able to enable KSM on a workload
>>>>> by workload basis.
>>>>>
>>>>> Use case 3:
>>>>> With the madvise call sharing opportunities are only enabled for the current
>>>>> process: it is a workload-local decision. A considerable number of sharing
>>>>> opportuniites may exist across multiple workloads or jobs. Only a higler level
>>>>> entity like a job scheduler or container can know for certain if its running
>>>>> one or more instances of a job. That job scheduler however doesn't have
>>>>> the necessary internal worklaod knowledge to make targeted madvise calls.
>>>>>
>>>>> Security concerns:
>>>>> In previous discussions security concerns have been brought up. The problem is
>>>>> that an individual workload does not have the knowledge about what else is
>>>>> running on a machine. Therefore it has to be very conservative in what memory
>>>>> areas can be shared or not. However, if the system is dedicated to running
>>>>> multiple jobs within the same security domain, its the job scheduler that has
>>>>> the knowledge that sharing can be safely enabled and is even desirable.
>>>>>
>>>>> Performance:
>>>>> Experiments with using UKSM have shown a capacity increase of around 20%.
>>>>
>>>> Stefan, can you do me a favor and investigate which pages we end up
>>>> deduplicating -- especially if it's mostly only the zeropage and if it's
>>>> still that significant when disabling THP?
>>>>
>>>>
>>>> I'm currently investigating with some engineers on playing with enabling KSM
>>>> on some selected processes (enabling it blindly on all VMAs of that process
>>>> via madvise() ).
>>>>
>>>> One thing we noticed is that such (~50 times) 20MiB processes end up saving
>>>> ~2MiB of memory per process. That made me suspicious, because it's the THP
>>>> size.
>>>>
>>>> What I think happens is that we have a 2 MiB area (stack?) and only touch a
>>>> single page. We get a whole 2 MiB THP populated. Most of that THP is zeroes.
>>>>
>>>> KSM somehow ends up splitting that THP and deduplicates all resulting
>>>> zeropages. Thus, we "save" 2 MiB. Actually, it's more like we no longer
>>>> "waste" 2 MiB. I think the processes with KSM have less (none) THP than the
>>>> processes with THP enabled, but I only took a look at a sample of the
>>>> process' smaps so far.
>>>
>>> THP and KSM is indeed an interesting problem. Better TLB hits with
>>> THPs, but reduced chance of deduplicating memory - which may or may
>>> not result in more IO that outweighs any THP benefits.
>>>
>>> That said, the service in the experiment referenced above has swap
>>> turned on and is under significant memory pressure. Unused splitpages
>>> would get swapped out. The difference from KSM was from deduplicating
>>> pages that were in active use, not internal THP fragmentation.
>> Brainfart, my apologies. It could have been the ksm-induced splits
>> themselves that allowed the unused subpages to get swapped out in the
>> first place.
>
> Yes, it's not easy to spot that this is implemented. I just wrote a simple
> reproducer to confirm: modifying a single subpage in a bunch of THP ranges will
> populate a THP whereby most of the THP is zeroes.
>
> As long as you keep accessing the single subpage via the PMD I assume chances of
> getting it swapped out are lower, because the folio will be references/dirty.
>
> KSM will come around and split the THP filled mostly with zeroes and deduplciate
> the resulting zero pages.
>
> [that's where a zeropage-only KSM could be very valuable eventually I think]
>

We can certainly run an experiment where THP is turned off to verify if we
observe similar savings,

>> But no, I double checked that workload just now. On a weekly average,
>> it has about 50 anon THPs and 12 million regular anon. THP is not a
>> factor in the reduction results.
>
> You mean with KSM enabled or with KSM disabled for the process? Not sure if your
> observation reliably implies that the scenario described couldn't have happened,
> but it's late in Germany already :)
>
> In any case, it would be nice to get a feeling for how much variety in these 20%
> of deduplicated pages are. For example, if it's 99% the same page or just a wild
> collection.
>
> Maybe "cat /sys/kernel/mm/ksm/pages_shared" would be expressive already. But I
> seem to be getting "126" in my simple example where only zeropages should get
> deduplicated, so I have to take another look at the stats tomorrow ...

/sys/kernel/mm/ksm/pages_shared is over 10000 when we run this on an
Instagram workload. The workload consists of 36 processes plus a few
sidecar processes.

Also to give some idea for individual VMA's

7ef5d5600000-7ef5e5600000 rw-p 00000000 00:00 0 (Size: 262144 KB, KSM: 73160 KB)
