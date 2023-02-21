Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E389269E6BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBUSDg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 13:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjBUSDf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 13:03:35 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F68EFBF;
        Tue, 21 Feb 2023 10:03:32 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 14BBF5C00EE;
        Tue, 21 Feb 2023 13:03:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 Feb 2023 13:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1677002609; x=1677089009; bh=ZH9OeA2FvC
        aJR9ZdNyNOKK8xdZTHpoN/UMcS3ejigug=; b=uFm3OuqiNjZk1Pp1VcYl+B4GLI
        LHh0AzdprYYpC0NdWU4lBklhoeaUyj8Ky/y48Su+7draK6ujiDqll6TAHxuTTvVE
        e58ql/Hott1vljDoBYKN/P+cgMOQsAvatGq9i0/dLBmBCdZIo5IGOrDPNISTITrG
        Kz01+aqAf4LzyCQKvaqvQFmRYKFhEsfqEfYIM+tBqafPCpGuGNM8lLYKX/fwbd53
        8ak3vPCjL4xHJzBgOi4zdvDpJLMTF0z7sK4VhVf2Pu1dA0QpKzgj2Vx948kMk8Mv
        XRgznh0CTgY3I8BUuNBoCT5T9Ao2ACFibsD7UsDtVyvIUIqv9EsVPMTxv85g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677002609; x=1677089009; bh=ZH9OeA2FvCaJR9ZdNyNOKK8xdZTH
        poN/UMcS3ejigug=; b=AaTB+z0pCAZE5fWJg+tXQ9XobiP2hdb4zrZw2akHB+Oq
        /qN7mH5X2STy4YUeJKdrmAVcWwKMBS3Sa8GuvfgjwhNSOAenm+aLhc7bmzGwK6Tp
        BA1ZycvGfZc5z/r9Q2D1JXAitRXeKOWlVYi7RNVLBki4+c3c8fy28zWF1K6ev4L8
        fsfVrceQ3CHhYx+6fta5ib+QtTtwyNct0wCVGoIyNHJJLR/wky9b410Oy6SRH2Ou
        67cUxgssYFu/RWi7E/7yieo3p0/iaD3kKriy1VD1GvbhDEBuB1e9njUg2amd8XaC
        woBK0CSqBTzVKLeGaUTTvgalkjFDHf21CTqq9a6fEA==
X-ME-Sender: <xms:cAf1YykvX83DCS4cVcdGyEkdQgZp3fI-veIRAsihNug-EF_k4IkjeQ>
    <xme:cAf1Y50GqEVO49TkBN3lihfG-6z5AY0goeofFZdYOmEIW2SrGyb7-ubHzz2Jmz8W1
    Brn1C1gBLayXK4xp9A>
X-ME-Received: <xmr:cAf1Ywo3mNSv7UEEqZXh5QXdyHlHyhM3sjeqiHIdATJHMR2w2KjLtbVsdDtGDZUeaKl31uXs-jLVGacAt5VqelNxwSEWhOkBk3t_4Qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesth
    dtofdttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghv
    khgvrhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepfeeludefhfegvdffieeuhfdvud
    etvdetfefgieegffduhfegffeuudevkeeiuedunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:cAf1Y2nXXfRrqcLzVDk7NnExbFZQ8trl5HsmurfFrc52XTZWYfWNWQ>
    <xmx:cAf1Yw3SjDo4olDVlF0KNzjU493iZpZpa1WkdTgLUEu13i-JcArJmw>
    <xmx:cAf1Y9u5j932q5El25kyBFiDlpkY9o4N6PWILAtPc3GbT8ZiFMO_5g>
    <xmx:cQf1YxlyRNGOiANfBZCF4ez6YfBJ3r6tIYOuQI2kvS95FZIqnHxzCQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 13:03:27 -0500 (EST)
References: <20230210215023.2740545-1-shr@devkernel.io>
 <Y/TtBc9DAkUKRHnV@cmpxchg.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH v2 00/19] mm: process/cgroup ksm support
Date:   Tue, 21 Feb 2023 09:59:59 -0800
In-reply-to: <Y/TtBc9DAkUKRHnV@cmpxchg.org>
Message-ID: <qvqwttzevqtx.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Johannes Weiner <hannes@cmpxchg.org> writes:

> Hi Stefan,
>
> On Fri, Feb 10, 2023 at 01:50:04PM -0800, Stefan Roesch wrote:
>> So far KSM can only be enabled by calling madvise for memory regions. What is
>> required to enable KSM for more workloads is to enable / disable it at the
>> process / cgroup level.
>>
>> Use case:
>> The madvise call is not available in the programming language. An example for
>> this are programs with forked workloads using a garbage collected language without
>> pointers. In such a language madvise cannot be made available.
>>
>> In addition the addresses of objects get moved around as they are garbage
>> collected. KSM sharing needs to be enabled "from the outside" for these type of
>> workloads.
>
> It would be good to expand on the argument that Rik made about the
> interpreter being used for things were there are no merging
> opportunities, and the KSM scanning overhead isn't amortized.
>
> There is a fundamental mismatch in scopes. madvise() is a
> workload-local decision, whereas sizable sharing opportunities may or
> may not exist across multiple workloads. Only a higher-level entity
> like a job scheduler can know for certain whether it's running one or
> more instances of a job. That job scheduler in turn doesn't have the
> necessary knowledge of the workload's internals to make targeted and
> well-timed advise calls with, say, process_madvise().
>
> This also applies to the security concerns brought up in previous
> threads. An individual workload doesn't know what else is running on
> the machine, so it needs to be highly conservative about what it can
> give up for system-wide merging. However, if the system is dedicated
> to running multiple jobs within the same security domain, it's the job
> scheduler that knows that sharing isn't a problem, and even desirable.
>
> So I think this series makes sense, but it would be good to expand a
> bit on the reasoning and address the security aspect in the cover/doc.
>

These are good points Johannes, I'll elaborate on them with the next
version of the patch.

>> Stefan Roesch (19):
>>   mm: add new flag to enable ksm per process
>>   mm: add flag to __ksm_enter
>>   mm: add flag to __ksm_exit call
>>   mm: invoke madvise for all vmas in scan_get_next_rmap_item
>>   mm: support disabling of ksm for a process
>>   mm: add new prctl option to get and set ksm for a process
>
> The implementation looks sound to me as well.
>
> I think it would be a bit easier to review if you folded these ^^^
> patches, the tools patch below, and the prctl selftests, all into one
> single commit. It's one logical change. This way the new flags and
> helper functions can be reviewed against the new users and callsites
> without having to jump back and forth between emails.
>

I'll fold them in the next version.

>>   mm: split off pages_volatile function
>>   mm: expose general_profit metric
>>   docs: document general_profit sysfs knob
>>   mm: calculate ksm process profit metric
>>   mm: add ksm_merge_type() function
>>   mm: expose ksm process profit metric in ksm_stat
>>   mm: expose ksm merge type in ksm_stat
>>   docs: document new procfs ksm knobs
>
> Same with the new knobs/stats and their documentation.
>

I'll fold them in the next version.

> Logical splitting is easier to follow than geographical splitting.
>
> Thanks!
