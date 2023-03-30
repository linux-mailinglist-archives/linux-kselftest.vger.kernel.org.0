Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B77A6D0B94
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjC3QqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjC3QqF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 12:46:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE24D50E;
        Thu, 30 Mar 2023 09:46:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9EF98320093D;
        Thu, 30 Mar 2023 12:46:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 30 Mar 2023 12:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680194760; x=1680281160; bh=C1
        ANtzD99ITAlQKFihJs3nRdO+Noal3WKWuXkIP7KiE=; b=qWfDLQArvQmB7aFjev
        i+7YCgnvM+n5QYFJf4i0ZT1ZNX6HtVJSTQxYz43+2Drn7L7LCxlaHIzkgLEN39qV
        YIsQPKvCBzhhrFnVeYyXBZPYuX/wpXfUZ9hjq23q9C9Ebb7gvLcJASrQkj+GLlw2
        qug7ru5btkiOT4DBF8jZs4YQ9QUYvBG5tIc8dxl2xXpjHHRUokiIJJPXHBZQo3MT
        On3EPZDQTha7icw1ZQAtZF3OcWb0FQAL/j/EA4kCuY/gpv9PEbMA1kxpQBv6pl2V
        vLiinfJh3jaYx3AYaiwcb6GBEauiO6W7oNoiAda8gIpVloTAiLQtrLvMHUSz/AUp
        QiEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680194760; x=1680281160; bh=C1ANtzD99ITAl
        QKFihJs3nRdO+Noal3WKWuXkIP7KiE=; b=NVaM3TniOM/E/HCLGOxRciWTO6yxV
        XM7LjAUJ3U/xNGvBJs35vqjQ4Hclu2Fe6EdVvW41l6AG7J4HzSjXXKiIomDJpErV
        +evqY5IF7fjzVYBZoTlwgagH52hwwiDQJU/y9UgJJYoAtl1uBR+LnbiPdt/UN5WC
        BT6FPgO2I7MNlahwGLf73ZS1vbImKIohAWpeCK0DkMOH1uJ7pHRWWJ2aqis9b9nt
        qJl4mA9zR214L+Ye1aaIR7c0zn4W+2Hi72DBqeXmJrs5oq3wUYfOQheVZFasrGua
        athtCv6WXGMtCsur2KVb9bYj9Acfysh4iWF20afel0+fT7Kp6/WVpa2dg==
X-ME-Sender: <xms:x7wlZJOvGjs49Zi2v49XhYxXK_VrTo9kq89Q6Q-Z5IqwjGd2MfVH1g>
    <xme:x7wlZL_vlMGEKooXogo8-fPFRv_F-dtRFqv78224xcyWv6S06XAW44rZlqvq3z99K
    cHEZEpsF9Juigo9Sfw>
X-ME-Received: <xmr:x7wlZIQGRNnUe5m-xLh0SKhjf9JPWk-85BTzXuwEO6qLxH2B3PQLOtg4LoH02rGSxh7EDocHz8oPsi-PnlWvAhK1e1b8lJ-uaQuoAfzKxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghf
    rghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrth
    htvghrnhepveelgffghfehudeitdehjeevhedthfetvdfhledutedvgeeikeeggefgudeg
    uedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:x7wlZFvKZF5WO5JrF29_eD-69_QDbHXJ0rkIFW7ouQzoLsOWg4H4OQ>
    <xmx:x7wlZBev33CsfwcBAT5KTIsPNy6bMl2ILUDwwg9ChdHar9-OKoB1Iw>
    <xmx:x7wlZB3TpuJqrp5vnI12X4iN_AdgemcIgx3uDPr-Q-Pd3cxDsORjIw>
    <xmx:yLwlZAyY0V1iUtUVdXS37VNqE_UEderiMUctO4ttthN94-GTje64FA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 12:45:58 -0400 (EDT)
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
 <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
 <ZCWcJelF5bEdF4N3@cmpxchg.org>
 <ff599dc1-729d-52dc-d605-8a8ac890ad15@redhat.com>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Date:   Thu, 30 Mar 2023 09:41:36 -0700
In-reply-to: <ff599dc1-729d-52dc-d605-8a8ac890ad15@redhat.com>
Message-ID: <qvqwv8ii89x6.fsf@dev0134.prn3.facebook.com>
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


My mistake I first answered to an older email.

David Hildenbrand <david@redhat.com> writes:

> On 30.03.23 16:26, Johannes Weiner wrote:
>> On Thu, Mar 30, 2023 at 06:55:31AM +0200, David Hildenbrand wrote:
>>> On 29.03.23 01:09, Andrew Morton wrote:
>>>> On Fri, 10 Mar 2023 10:28:48 -0800 Stefan Roesch <shr@devkernel.io> wrote:
>>>>
>>>>> So far KSM can only be enabled by calling madvise for memory regions. To
>>>>> be able to use KSM for more workloads, KSM needs to have the ability to be
>>>>> enabled / disabled at the process / cgroup level.
>>>>
>>>> Review on this series has been a bit thin.  Are we OK with moving this
>>>> into mm-stable for the next merge window?
>>>
>>> I still want to review (traveling this week), but I also don't want to block
>>> this forever.
>>>
>>> I think I didn't get a reply from Stefan to my question [1] yet (only some
>>> comments from Johannes). I would still be interested in the variance of
>>> pages we end up de-duplicating for processes.
>>>
>>> The 20% statement in the cover letter is rather useless and possibly
>>> misleading if no details about the actual workload are shared.
>> The workload is instagram. It forks off Django runtimes on-demand
>> until it saturates whatever hardware it's running on. This benefits
>> from merging common heap/stack state between instances. Since that
>> runtime is quite large, the 20% number is not surprising, and matches
>> our expectations of duplicative memory between instances.
>
> Thanks for this explanation. It's valuable to get at least a feeling for the
> workload because it doesn't seem to apply to other workloads at all.
>
>> Obviously we could spend months analysing which exact allocations are
>> identical, and then more months or years reworking the architecture to
>> deduplicate them by hand and in userspace. But this isn't practical,
>> and KSM is specifically for cases where this isn't practical.
>> Based on your request in the previous thread, we investigated whether
>> the boost was coming from the unintended side effects of KSM splitting
>> THPs. This wasn't the case.
>> If you have other theories on how the results could be bogus, we'd be
>> happy to investigate those as well. But you have to let us know what
>> you're looking for.
>>
>
> Maybe I'm bad at making such requests but
>
> "Stefan, can you do me a favor and investigate which pages we end up
> deduplicating -- especially if it's mostly only the zeropage and if it's
> still that significant when disabling THP?"
>
> "In any case, it would be nice to get a feeling for how much variety in
> these 20% of deduplicated pages are. "
>
> is pretty clear to me. And shouldn't take months.
>

/sys/kernel/mm/ksm/pages_shared is over 10000 when we run this on an
Instagram workload. The workload consists of 36 processes plus a few
sidecar processes.

Each of these individual processes has around 500MB in KSM pages.

Also to give some idea for individual VMA's

7ef5d5600000-7ef5e5600000 rw-p 00000000 00:00 0 (Size: 262144 KB, KSM:
73160 KB)

>> Beyond that, I don't think we need to prove from scratch that KSM can
>
> I never expected a proof. I was merely trying to understand if it's really KSM
> that helps here. Also with the intention to figure out if KSM is really the
> right tool to use here or if it simply "helps by luck" as with the shared
> zeropage. That end result could have been valuable to your use case as well,
> because KSM overhead is real.
>
>> be a worthwhile optimization. It's been established that it can
>> be. This series is about enabling it in scenarios where madvise()
>> isn't practical, that's it, and it's yielding the expected results.
>
> I'm sorry to say, but you sound a bit aggressive and annoyed. I also have no
> idea why Stefan isn't replying to me but always you.
>
> Am I asking the wrong questions? Do you want me to stop looking at KSM code?
>

Your review is valuable, Johannes was quicker than me.
