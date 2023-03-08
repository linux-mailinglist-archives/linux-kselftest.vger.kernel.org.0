Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23DB6B1504
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 23:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCHWXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 17:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCHWXx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 17:23:53 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D28618B0;
        Wed,  8 Mar 2023 14:23:45 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D430F5C00E4;
        Wed,  8 Mar 2023 17:23:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 08 Mar 2023 17:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678314221; x=1678400621; bh=QO
        wR0D9gPl7Iokbw5axOEkvXsNmPpiw+HASooBf+03M=; b=lEYGgCBk+s6p2F2hDg
        KMCAS6GDNmPhmF8hzbgrDsWoKCfoCxTm4MCAXu3DzbuD887fuK5qf/vOtNdfenmy
        6147lBzeLBmBzolXLHDclVdOjbSxOrw3nU2z2jmjv8Jh313mxtnmijp+60vcLjwI
        f1p3ce55zBaKvAap2+SNySgwZ7DCjMoqaxBLesXfMlx+BGBlhAFrAb/4u2v4hPvl
        5jQy6FXNDrhW7jDnU30wwuH/nFdPZI3rtOemLUCo/+KjNCERlBPZXxUnBbnUsNqA
        gEJECf6tSyiAqwvAy/9IANtucsrYL3RgvMf+VSjxal/SA4g0EuwW8pVr74AJQWMH
        JqJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678314221; x=1678400621; bh=QOwR0D9gPl7Io
        kbw5axOEkvXsNmPpiw+HASooBf+03M=; b=pOp2qRfTXTkJ0KODm+Rfr1kfNl3ed
        D5XPH96mBf358Jzs9KYB69sfGM6i33xmK3PLcTrjbb64zUzZD0R4JmbR9HPtHQ9R
        7ozLcRgO5PgXYVCFSOmmHb7CsBYvBWTiDp94Isj4ZO1fvcWNFggAY/Vlgj/QuRBa
        Zum0fNSu7RNqC6pi0JCKz04DjwsOh41htTqdHp+N5JA1z1sGVKjGtL3XjLzu1PV8
        afQnZruYilXNQIZdgks65nMeqro3fRskkUkzqYvHrAxBFE02jKGmiEkF7IPicIcG
        +LdoOlxs3OnUp/TPhSjCn3Wvzh1hd1RxEtmvFKP++dg+hKXekzULJSPrg==
X-ME-Sender: <xms:7QoJZICotthS5iF31MchtXt9rbPKJZ06Sptp-SKqrE8TtNqfhUhFFg>
    <xme:7QoJZKjaHv-uOmoL22Vi86Ur5TqzVhSckJ_2jhOyKXQ5Vsf31sxvl7SWmSUUA3HOu
    8T1ehEEQqhrHkUNQD4>
X-ME-Received: <xmr:7QoJZLlh1pIuzaXk1LLgh6Ef6Mmg7dvm2lUOYCbuZkYlh3J7ArkFjWw5R3L4_LFf0_9IYRsedCBM_mJtrbnO9Qp9NDil6szmrP2C0Qv6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddufedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesth
    dtredttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghv
    khgvrhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhe
    dthfetvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:7QoJZOw9g-ox6g4HhJ4TDGVLB7S9QjlJomlQ3OGxLyQeD9l3hd-cSA>
    <xmx:7QoJZNQpV70N78TNvO8tasxk-Ay4IgwMgX0GsPelgPyVjcACxwi3Kg>
    <xmx:7QoJZJbjB9bZfn4ag6TCDjZLpWIWWWq3fz2U6X7RihcAcetco-pLKg>
    <xmx:7QoJZOReFAtqiDoskpqnglfshXpP18U6aK9EMQ_fxPEN6GeXBx-0Tw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Mar 2023 17:23:40 -0500 (EST)
References: <20230224044000.3084046-1-shr@devkernel.io>
 <20230224044000.3084046-2-shr@devkernel.io>
 <20230308164746.GA473363@cmpxchg.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3 1/3] mm: add new api to enable ksm per process
Date:   Wed, 08 Mar 2023 14:16:36 -0800
In-reply-to: <20230308164746.GA473363@cmpxchg.org>
Message-ID: <qvqwbkl2zxui.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Johannes Weiner <hannes@cmpxchg.org> writes:

> On Thu, Feb 23, 2023 at 08:39:58PM -0800, Stefan Roesch wrote:
>> This adds a new prctl to API to enable and disable KSM on a per process
>> basis instead of only at the VMA basis (with madvise).
>>
>> 1) Introduce new MMF_VM_MERGE_ANY flag
>>
>> This introduces the new flag MMF_VM_MERGE_ANY flag. When this flag is
>> set, kernel samepage merging (ksm) gets enabled for all vma's of a
>> process.
>>
>> 2) add flag to __ksm_enter
>>
>> This change adds the flag parameter to __ksm_enter. This allows to
>> distinguish if ksm was called by prctl or madvise.
>>
>> 3) add flag to __ksm_exit call
>>
>> This adds the flag parameter to the __ksm_exit() call. This allows to
>> distinguish if this call is for an prctl or madvise invocation.
>>
>> 4) invoke madvise for all vmas in scan_get_next_rmap_item
>>
>> If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
>> over all the vmas and enable ksm if possible. For the vmas that can be
>> ksm enabled this is only done once.
>>
>> 5) support disabling of ksm for a process
>>
>> This adds the ability to disable ksm for a process if ksm has been
>> enabled for the process.
>>
>> 6) add new prctl option to get and set ksm for a process
>>
>> This adds two new options to the prctl system call
>> - enable ksm for all vmas of a process (if the vmas support it).
>> - query if ksm has been enabled for a process.
>>
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>
> Hey Stefan, thanks for merging the patches into one. I found it much
> easier to review.
>
> Overall this looks straight-forward to me. A few comments below:
>
>> @@ -2659,6 +2660,34 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>  	case PR_SET_VMA:
>>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>>  		break;
>> +#ifdef CONFIG_KSM
>> +	case PR_SET_MEMORY_MERGE:
>> +		if (!capable(CAP_SYS_RESOURCE))
>> +			return -EPERM;
>> +
>> +		if (arg2) {
>> +			if (mmap_write_lock_killable(me->mm))
>> +				return -EINTR;
>> +
>> +			if (test_bit(MMF_VM_MERGEABLE, &me->mm->flags))
>> +				error = -EINVAL;
>
> So if the workload has already madvised specific VMAs the
> process-enablement will fail. Why is that? Shouldn't it be possible to
> override a local decision from an outside context that has more
> perspective on both sharing opportunities and security aspects?
>
> If there is a good reason for it, the -EINVAL should be addressed in
> the manpage. And maybe add a comment here as well.
>

This makes sense, I'll remove the check above.

>> +			else if (!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags))
>> +				error = __ksm_enter(me->mm, MMF_VM_MERGE_ANY);
>> +			mmap_write_unlock(me->mm);
>> +		} else {
>> +			__ksm_exit(me->mm, MMF_VM_MERGE_ANY);
>> +		}
>> +		break;
>> +	case PR_GET_MEMORY_MERGE:
>> +		if (!capable(CAP_SYS_RESOURCE))
>> +			return -EPERM;
>> +
>> +		if (arg2 || arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +
>> +		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>> +		break;
>> +#endif
>>  	default:
>>  		error = -EINVAL;
>>  		break;
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 56808e3bfd19..23d6944f78ad 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1063,6 +1063,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>>
>>  			mm_slot_free(mm_slot_cache, mm_slot);
>>  			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>> +			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>>  			mmdrop(mm);
>>  		} else
>>  			spin_unlock(&ksm_mmlist_lock);
>> @@ -2329,6 +2330,17 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
>>  	return rmap_item;
>>  }
>>
>> +static bool vma_ksm_mergeable(struct vm_area_struct *vma)
>> +{
>> +	if (vma->vm_flags & VM_MERGEABLE)
>> +		return true;
>> +
>> +	if (test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>  static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>  {
>>  	struct mm_struct *mm;
>> @@ -2405,8 +2417,20 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>  		goto no_vmas;
>>
>>  	for_each_vma(vmi, vma) {
>> -		if (!(vma->vm_flags & VM_MERGEABLE))
>> +		if (!vma_ksm_mergeable(vma))
>>  			continue;
>> +		if (!(vma->vm_flags & VM_MERGEABLE)) {
>
> IMO, the helper obscures the interaction between the vma flag and the
> per-process flag here. How about:
>
> 		if (!(vma->vm_flags & VM_MERGEABLE)) {
> 			if (!test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
> 				continue;
>
> 			/*
> 			 * With per-process merging enabled, have the MM scan
> 			 * enroll any existing and new VMAs on the fly.
> 			 *
> 			ksm_madvise();
> 		}
>
>> +			unsigned long flags = vma->vm_flags;
>> +
>> +			/* madvise failed, use next vma */
>> +			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &flags))
>> +				continue;
>> +			/* vma, not supported as being mergeable */
>> +			if (!(flags & VM_MERGEABLE))
>> +				continue;
>> +
>> +			vm_flags_set(vma, VM_MERGEABLE);
>
> I don't understand the local flags. Can't it pass &vma->vm_flags to
> ksm_madvise()? It'll set VM_MERGEABLE on success. And you know it
> wasn't set before because the whole thing is inside the !set
> branch. The return value doesn't seem super useful, it's only the flag
> setting that matters:
>
> 			ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &vma->vm_flags);
> 			/* madvise can fail, and will skip special vmas (pfnmaps and such) */
> 			if (!(vma->vm_flags & VM_MERGEABLE))
> 				continue;
>

vm_flags is defined as const. I cannot pass it directly inside the
function, this is the reason, I'm using a local variable for it.

>> +		}
>>  		if (ksm_scan.address < vma->vm_start)
>>  			ksm_scan.address = vma->vm_start;
>>  		if (!vma->anon_vma)
>> @@ -2491,6 +2515,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>
>>  		mm_slot_free(mm_slot_cache, mm_slot);
>>  		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>> +		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>>  		mmap_read_unlock(mm);
>>  		mmdrop(mm);
>>  	} else {
>
>> @@ -2664,12 +2690,39 @@ int __ksm_enter(struct mm_struct *mm)
>>  	return 0;
>>  }
>>
>> -void __ksm_exit(struct mm_struct *mm)
>> +static void unmerge_vmas(struct mm_struct *mm)
>> +{
>> +	struct vm_area_struct *vma;
>> +	struct vma_iterator vmi;
>> +
>> +	vma_iter_init(&vmi, mm, 0);
>> +
>> +	mmap_read_lock(mm);
>> +	for_each_vma(vmi, vma) {
>> +		if (vma->vm_flags & VM_MERGEABLE) {
>> +			unsigned long flags = vma->vm_flags;
>> +
>> +			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_UNMERGEABLE, &flags))
>> +				continue;
>> +
>> +			vm_flags_clear(vma, VM_MERGEABLE);
>
> ksm_madvise() tests and clears VM_MERGEABLE, so AFAICS
>
> 	for_each_vma(vmi, vma)
> 		ksm_madvise();
>
> should do it...
>

This is the same problem. vma->vm_flags is defined as const.

+		if (vma->vm_flags & VM_MERGEABLE) {
This will be removed.

>> +		}
>> +	}
>> +	mmap_read_unlock(mm);
>> +}
>> +
>> +void __ksm_exit(struct mm_struct *mm, int flag)
>>  {
>>  	struct ksm_mm_slot *mm_slot;
>>  	struct mm_slot *slot;
>>  	int easy_to_free = 0;
>>
>> +	if (!(current->flags & PF_EXITING) && flag == MMF_VM_MERGE_ANY &&
>> +		test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
>> +		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>> +		unmerge_vmas(mm);
>
> ...and then it's short enough to just open-code it here and drop the
> unmerge_vmas() helper.
