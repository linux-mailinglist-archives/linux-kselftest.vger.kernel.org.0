Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7508D6B3111
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 23:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjCIWia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 17:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjCIWiP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 17:38:15 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A2A2332D;
        Thu,  9 Mar 2023 14:38:06 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 166145C0166;
        Thu,  9 Mar 2023 17:38:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 09 Mar 2023 17:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678401486; x=1678487886; bh=Ze
        3+pxMevBT00ZvMFDroeTtBvnMDSJcEIMQQMq34NOo=; b=TapyiyUjWS8nJHLJYu
        K4MTpsfTjdpBVaVfg5m8PuG+bJIKFuCHys4P79nNp7gXznmRyzk9AiTLkqzdscPA
        fxF230oU/MLcftTC0gddvvDRIJmuHWo5inXinR9Z1NZ0NbEcJf5OZOG9dcqbWXT3
        up4CvBTawMj4f5XGY/6z3y/9GaOYH++zCNfRQXTCHp/2ImTqxuANBTsV0UJ4xc4z
        vxwjiAILFey1ZBZ5J/02MfJ25MSwNvDaKBzc2BRxMdHNkAx+X+U8PmIj7sLh1gzN
        WXkAWcEa3HB9dH+MPBFh8N02TaKWjZipOhwf2v6owgRyDeCFj0mIi+Jx75D+f+oi
        kliA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678401486; x=1678487886; bh=Ze3+pxMevBT00
        ZvMFDroeTtBvnMDSJcEIMQQMq34NOo=; b=VAbCLuqQDWyXb8usdEton5pImuh9i
        p66rVmg5ehzX8siKz7T3v41LDXIEOqvIfhJueXXpPa2KX+T6dpHGgNK8n8zbcU87
        NoxYnTzqdiOPaEv2X/YiKJgnTJFS3v+GkhxYQp1RlvqoXzavsjvlKMnRVL96kw2M
        MEl1Iz51kvYyK2VTtMG0iMtQ7LaeFf+2lVlj1xOVlmjMq+QytPCZeRSniktwBcYK
        UicLAutRmf/7nyvdXb+I60L3fpQ8RK88gAd/R8YNsyCkMeAOmHfhWP3zDQimTd/3
        1fNT/AzBiXRZjqBQ+Dn0NfUF+EHKZsdVmfJ6jpOrCzGkP/OeFJl0M/A+w==
X-ME-Sender: <xms:zV8KZAe-Zme8q5S4ny4RbCCed1YXr8U7CkIj3f1utlD9PqyWpM2lCQ>
    <xme:zV8KZCNP493OBGOyiFjGqsihAY368iyHHMofrSvCmN0IWxGEyZIUOfZv_3HRBi5J-
    E2KMBjRu5UaLZ3G5Os>
X-ME-Received: <xmr:zV8KZBh8hvgtNng4nhLNn2w3vpLAfhQ5WM2MIWEns-Pa7DgmuYs95I-LxhucvN3EBth9aGJOQuE-VvslxoZ3sbisXS8U8upxhtaKdEL91w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduiedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesth
    dtredttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghv
    khgvrhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhe
    dthfetvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:zV8KZF_Swx-XM29kVkFQT1q-1w6agdm6W97i3cBajf7GwkJuM5RelQ>
    <xmx:zV8KZMuwOQM-xma202l1hBRrUDxXAA2Xw6LwlRvqHlqS48EZJ0pW9Q>
    <xmx:zV8KZMFEcbpragtMT_uRyPllREZ54U1sUeCfY6sP9tBp70Ddi8BwDA>
    <xmx:zl8KZB_omguko8VdelLIuBAHIwgBGj9FhUk7-_ThsfWX7JZVNvtN4w>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Mar 2023 17:38:04 -0500 (EST)
References: <20230224044000.3084046-1-shr@devkernel.io>
 <20230224044000.3084046-2-shr@devkernel.io>
 <20230308164746.GA473363@cmpxchg.org>
 <qvqwbkl2zxui.fsf@dev0134.prn3.facebook.com>
 <20230309045910.GD476158@cmpxchg.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3 1/3] mm: add new api to enable ksm per process
Date:   Thu, 09 Mar 2023 14:33:10 -0800
In-reply-to: <20230309045910.GD476158@cmpxchg.org>
Message-ID: <qvqwa60lo8j8.fsf@dev0134.prn3.facebook.com>
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

> On Wed, Mar 08, 2023 at 02:16:36PM -0800, Stefan Roesch wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>> > On Thu, Feb 23, 2023 at 08:39:58PM -0800, Stefan Roesch wrote:
>> >> @@ -2405,8 +2417,20 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>> >>  		goto no_vmas;
>> >>
>> >>  	for_each_vma(vmi, vma) {
>> >> -		if (!(vma->vm_flags & VM_MERGEABLE))
>> >> +		if (!vma_ksm_mergeable(vma))
>> >>  			continue;
>> >> +		if (!(vma->vm_flags & VM_MERGEABLE)) {
>> >
>> > IMO, the helper obscures the interaction between the vma flag and the
>> > per-process flag here. How about:
>> >
>> > 		if (!(vma->vm_flags & VM_MERGEABLE)) {
>> > 			if (!test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
>> > 				continue;
>> >
>> > 			/*
>> > 			 * With per-process merging enabled, have the MM scan
>> > 			 * enroll any existing and new VMAs on the fly.
>> > 			 *
>> > 			ksm_madvise();
>> > 		}
>> >
>> >> +			unsigned long flags = vma->vm_flags;
>> >> +
>> >> +			/* madvise failed, use next vma */
>> >> +			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &flags))
>> >> +				continue;
>> >> +			/* vma, not supported as being mergeable */
>> >> +			if (!(flags & VM_MERGEABLE))
>> >> +				continue;
>> >> +
>> >> +			vm_flags_set(vma, VM_MERGEABLE);
>> >
>> > I don't understand the local flags. Can't it pass &vma->vm_flags to
>> > ksm_madvise()? It'll set VM_MERGEABLE on success. And you know it
>> > wasn't set before because the whole thing is inside the !set
>> > branch. The return value doesn't seem super useful, it's only the flag
>> > setting that matters:
>> >
>> > 			ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &vma->vm_flags);
>> > 			/* madvise can fail, and will skip special vmas (pfnmaps and such) */
>> > 			if (!(vma->vm_flags & VM_MERGEABLE))
>> > 				continue;
>> >
>>
>> vm_flags is defined as const. I cannot pass it directly inside the
>> function, this is the reason, I'm using a local variable for it.
>
> Oops, good catch.
>
> However, while looking at the flag helpers, I'm also realizing that
> modifications requires the mmap_sem in write mode, which this code
> doesn't. This function might potentially scan the entire process
> address space, so you can't just change the lock mode, either.
>
> Staring more at this, do you actually need to set VM_MERGEABLE on the
> individual vmas? There are only a few places that check VM_MERGEABLE,
> and AFAICS they can all just check for MMF_VM_MERGE_ANY also.
>
> You'd need to factor out the vma compatibility checks from
> ksm_madvise(), and skip over special vmas during the mm scan. But
> those tests are all stable under the read lock, so that's fine.
>
> The other thing ksm_madvise() does is ksm_enter() - but that's
> obviously not needed from inside the loop over ksm_enter'd mms. :)

The check alone for MMF_VM_MERGE_ANY is not sufficient. We also
need to check if the respective VMA is mergeable. I'll split off the
checks in ksm_madvise to its own function, so it can be called from
where VM_MERGEABLE is currently checked.

With the above change, the function unmerge_vmas is no longer needed.
