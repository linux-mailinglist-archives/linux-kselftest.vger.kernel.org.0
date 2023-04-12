Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE1C6DFBFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDLQ44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 12:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjDLQ4u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 12:56:50 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E99017;
        Wed, 12 Apr 2023 09:56:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 49621320098B;
        Wed, 12 Apr 2023 12:48:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 12:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681318104; x=1681404504; bh=sc
        mEOwqbnPS5gqPSEkaU6LjpECgptoW3US8TeIjHbcM=; b=Si/eL50z9Xi9fT7SJF
        W78kz7zd+4AbAd8Z3tPD8MTS/PnSHCnDn6Nw4Yi0buUDVcQ6yWkLffFYnbWcnIkZ
        Q4DtOpYn+uOUlBYVPkKhnUBRHtbcZll6Vp+eax4AuE8mJYPJSv7VJMiTF+DCqrSo
        6pIc0JfWmDcHyEzVqe3ggCGpGQRsYUR3eFwqbPeMkAexmFnkj8T2j/98HdMFbLaG
        nRc/HXOnFxaL3LU0m25AMst27uuWeDdLpsVaTh81vsimiBQa/y4Y8aJ1OYlBhYse
        gJIabX258lq7M0mft69pGYP4xWqp4G2qc7FFRxk6nuUnSYCawL2ao4r1+1k5NfVJ
        kSoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681318104; x=1681404504; bh=scmEOwqbnPS5g
        qPSEkaU6LjpECgptoW3US8TeIjHbcM=; b=UYN1CGR3PVERS+qYoWfER6Ed7lvm/
        eujtI+CUtT8pondrpLNLYbhkEX24P7jdzX9V+jFlZ59EwUQm6ma2AnNIRSQvkJPd
        QjFAQdZnf9Ds+L7/2vVDPxIW7Bc0YCdLvB2WA4H9Z9lCS/apC8nyqEFqjnwMY6U4
        EbUDFOc/LCrfETP20XBCqffIKn1G3AE/olGdqbRG52L9L0Jl0Nx68PPhRlsc69uE
        qECccQckk+iDXXUAg2QyvZVIgl8NX53/vzEHJCbyHjzGMJy1WpaVIEgoTFt0lPW6
        iyWZmU9F+t5d8hUw0ckZuR27HMWABXow/VBSpl2Wyi8wSil+LmRoone5w==
X-ME-Sender: <xms:2OA2ZNuYp8VZ3BKZXU-zOEJ0ZFZ3-mgpOPuCHOcrvEkOtckBILxlew>
    <xme:2OA2ZGfzitcj_LYQ89XZTUto2Z3Yk4OeydXOWfePv1TKrtR6lMMab1X0JXqmVOm5z
    YsEe6igPhwap9sRMHc>
X-ME-Received: <xmr:2OA2ZAyFLElZShUNZ6itZXNeuCSOzRls9_TPZ9TtmIBKayiObw-1MFYz-apl5ev_3Rhck7X3UoGtqVhZF0QQZt0tAnSoZXhitbkxoHbDBbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:2OA2ZEPacHsllWW0bE1ZEs1XMEBXSls_fu-wUQnwNPKbQNNbSVeCJQ>
    <xmx:2OA2ZN_kLH8Yjaw_uDS9O5vEk6yp2WzlZskUmLavU6ZjmHth3M3W7Q>
    <xmx:2OA2ZEVpOFydTRByef3DV9XNI1TVW4VJakpd5QR4C9hSJATNYmNcwA>
    <xmx:2OA2ZMYRzVy3j-cREclD0qjBZ8AuFmwRry_Lp8ofKDlDWzicO9Ph-A>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 12:48:23 -0400 (EDT)
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-2-shr@devkernel.io>
 <b3bac995-0d87-a4d7-b261-9cbe3aa901af@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 1/3] mm: add new api to enable ksm per process
Date:   Wed, 12 Apr 2023 09:44:28 -0700
In-reply-to: <b3bac995-0d87-a4d7-b261-9cbe3aa901af@redhat.com>
Message-ID: <qvqw1qkpavxn.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> [...]
>
> Thanks for giving mu sugegstions a churn. I think we can further
> improve/simplify some things. I added some comments, but might have more
> regarding MMF_VM_MERGE_ANY / MMF_VM_MERGEABLE.
>
> [I'll try reowkring your patch after I send this mail to play with some
> simplifications]
>
>>   arch/s390/mm/gmap.c            |   1 +
>>   include/linux/ksm.h            |  23 +++++--
>>   include/linux/sched/coredump.h |   1 +
>>   include/uapi/linux/prctl.h     |   2 +
>>   kernel/fork.c                  |   1 +
>>   kernel/sys.c                   |  23 +++++++
>>   mm/ksm.c                       | 111 ++++++++++++++++++++++++++-------
>>   mm/mmap.c                      |   7 +++
>>   8 files changed, 142 insertions(+), 27 deletions(-)
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 5a716bdcba05..9d85e5589474 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2591,6 +2591,7 @@ int gmap_mark_unmergeable(void)
>>   	int ret;
>>   	VMA_ITERATOR(vmi, mm, 0);
>>   +	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>
> Okay, that should keep the existing mechanism working. (but users can still mess
> it up)
>
> Might be worth a comment
>
> /*
>  * Make sure to disable KSM (if enabled for the whole process or
>  * individual VMAs). Note that nothing currently hinders user space
>  * from re-enabling it.
>  */
>

I'll add the comment.

>>   	for_each_vma(vmi, vma) {
>>   		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
>>   		vm_flags = vma->vm_flags;
>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>> index 7e232ba59b86..f24f9faf1561 100644
>> --- a/include/linux/ksm.h
>> +++ b/include/linux/ksm.h
>> @@ -18,20 +18,29 @@
>>   #ifdef CONFIG_KSM
>>   int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>>   		unsigned long end, int advice, unsigned long *vm_flags);
>> -int __ksm_enter(struct mm_struct *mm);
>> -void __ksm_exit(struct mm_struct *mm);
>> +
>> +int ksm_add_mm(struct mm_struct *mm);
>> +void ksm_add_vma(struct vm_area_struct *vma);
>> +void ksm_add_vmas(struct mm_struct *mm);
>> +
>> +int __ksm_enter(struct mm_struct *mm, int flag);
>> +void __ksm_exit(struct mm_struct *mm, int flag);
>>     static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>>   {
>> +	if (test_bit(MMF_VM_MERGE_ANY, &oldmm->flags))
>> +		return ksm_add_mm(mm);
>
> ksm_fork() runs before copying any VMAs. Copying the bit should be sufficient.
>
> Would it be possible to rework to something like:
>
> if (test_bit(MMF_VM_MERGE_ANY, &oldmm->flags))
> 	set_bit(MMF_VM_MERGE_ANY, &mm->flags)
> if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
> 	return __ksm_enter(mm);
>

That will work.
> work? IOW, not exporting ksm_add_mm() and not passing a flag to __ksm_enter() --
> it would simply set MMF_VM_MERGEABLE ?
>

ksm_add_mm() is also used in prctl (kernel/sys.c). Do you want to make a
similar change there?
>
> I rememebr proposing that enabling MMF_VM_MERGE_ANY would simply enable
> MMF_VM_MERGEABLE.
>
>>   	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
>> -		return __ksm_enter(mm);
>> +		return __ksm_enter(mm, MMF_VM_MERGEABLE);
>>   	return 0;
>>   }
>>     static inline void ksm_exit(struct mm_struct *mm)
>>   {
>> -	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
>> -		__ksm_exit(mm);
>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>> +		__ksm_exit(mm, MMF_VM_MERGE_ANY);
>> +	else if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
>> +		__ksm_exit(mm, MMF_VM_MERGEABLE);
>
> Can we do
>
> if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
> 	__ksm_exit(mm);
>
> And simply let __ksm_exit() clear both bits?
>
Yes, I'll make the change.
>>   }
>>     /*
>> @@ -53,6 +62,10 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
>>     #else  /* !CONFIG_KSM */
>>
>
> [...]
>
>>   #endif /* _LINUX_SCHED_COREDUMP_H */
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 1312a137f7fb..759b3f53e53f 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -290,4 +290,6 @@ struct prctl_mm_map {
>>   #define PR_SET_VMA		0x53564d41
>>   # define PR_SET_VMA_ANON_NAME		0
>>   +#define PR_SET_MEMORY_MERGE		67
>> +#define PR_GET_MEMORY_MERGE		68
>>   #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index f68954d05e89..1520697cf6c7 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   		if (vma_iter_bulk_store(&vmi, tmp))
>>   			goto fail_nomem_vmi_store;
>>   +		ksm_add_vma(tmp);
>
> Is this really required? The relevant VMAs should have VM_MERGEABLE set.
>
I'll fix it.

>>   		mm->map_count++;
>>   		if (!(tmp->vm_flags & VM_WIPEONFORK))
>>   			retval = copy_page_range(tmp, mpnt);
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 495cd87d9bf4..9bba163d2d04 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/highuid.h>
>>   #include <linux/fs.h>
>>   #include <linux/kmod.h>
>> +#include <linux/ksm.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/resource.h>
>>   #include <linux/kernel.h>
>> @@ -2661,6 +2662,28 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>   	case PR_SET_VMA:
>>   		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>>   		break;
>> +#ifdef CONFIG_KSM
>> +	case PR_SET_MEMORY_MERGE:
>> +		if (mmap_write_lock_killable(me->mm))
>> +			return -EINTR;
>> +
>> +		if (arg2) {
>> +			int err = ksm_add_mm(me->mm);
>> +
>> +			if (!err)
>> +				ksm_add_vmas(me->mm);
>> +		} else {
>> +			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>
> Okay, so disabling doesn't actually unshare anything.
>
>> +		}
>> +		mmap_write_unlock(me->mm);
>> +		break;
>> +	case PR_GET_MEMORY_MERGE:
>> +		if (arg2 || arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +
>> +		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>> +		break;
>> +#endif
>>   	default:
>>   		error = -EINVAL;
>>   		break;
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index d7bd28199f6c..ab95ae0f9def 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -534,10 +534,33 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
>>   	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
>>   }
>>   +static bool vma_ksm_compatible(struct vm_area_struct *vma)
>> +{
>> +	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
>> +			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
>> +			     VM_MIXEDMAP))
>> +		return false;		/* just ignore the advice */
>> +
>> +	if (vma_is_dax(vma))
>> +		return false;
>> +
>> +#ifdef VM_SAO
>> +	if (vma->vm_flags & VM_SAO)
>> +		return false;
>> +#endif
>> +#ifdef VM_SPARC_ADI
>> +	if (vma->vm_flags & VM_SPARC_ADI)
>> +		return false;
>> +#endif
>> +
>> +	return true;
>> +}
>> +
>>   static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>>   		unsigned long addr)
>>   {
>>   	struct vm_area_struct *vma;
>> +
>
> unrelated change
>
Removed.

>>   	if (ksm_test_exit(mm))
>>   		return NULL;
>>   	vma = vma_lookup(mm, addr);
>> @@ -1065,6 +1088,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>>     			mm_slot_free(mm_slot_cache, mm_slot);
>>   			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>> +			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>>   			mmdrop(mm);
>>   		} else
>>   			spin_unlock(&ksm_mmlist_lock);
>> @@ -2495,6 +2519,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>     		mm_slot_free(mm_slot_cache, mm_slot);
>>   		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>> +		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>>   		mmap_read_unlock(mm);
>>   		mmdrop(mm);
>>   	} else {
>> @@ -2571,6 +2596,63 @@ static int ksm_scan_thread(void *nothing)
>>   	return 0;
>>   }
>>   +static void __ksm_add_vma(struct vm_area_struct *vma)
>> +{
>> +	unsigned long vm_flags = vma->vm_flags;
>> +
>> +	if (vm_flags & VM_MERGEABLE)
>> +		return;
>> +
>> +	if (vma_ksm_compatible(vma)) {
>> +		vm_flags |= VM_MERGEABLE;
>> +		vm_flags_reset(vma, vm_flags);
>> +	}
>> +}
>> +
>> +/**
>> + * ksm_add_vma - Mark vma as mergeable
>
> "if compatible"
>
I'll added the above.

>> + *
>> + * @vma:  Pointer to vma
>> + */
>> +void ksm_add_vma(struct vm_area_struct *vma)
>> +{
>> +	struct mm_struct *mm = vma->vm_mm;
>> +
>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>> +		__ksm_add_vma(vma);
>> +}
>> +
>> +/**
>> + * ksm_add_vmas - Mark all vma's of a process as mergeable
>> + *
>> + * @mm:  Pointer to mm
>> + */
>> +void ksm_add_vmas(struct mm_struct *mm)
>
> I'd suggest calling this
>
I guess you forgot your name suggestion?

>> +{
>> +	struct vm_area_struct *vma;
>> +
>> +	VMA_ITERATOR(vmi, mm, 0);
>> +	for_each_vma(vmi, vma)
>> +		__ksm_add_vma(vma);
>> +}
>> +
>> +/**
>> + * ksm_add_mm - Add mm to mm ksm list
>> + *
>> + * @mm:  Pointer to mm
>> + *
>> + * Returns 0 on success, otherwise error code
>> + */
>> +int ksm_add_mm(struct mm_struct *mm)
>> +{
>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>> +		return -EINVAL;
>> +	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
>> +		return -EINVAL;
>> +
>> +	return __ksm_enter(mm, MMF_VM_MERGE_ANY);
>> +}
>> +
>>   int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>>   		unsigned long end, int advice, unsigned long *vm_flags)
>>   {
>> @@ -2579,28 +2661,13 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>>     	switch (advice) {
>>   	case MADV_MERGEABLE:
>> -		/*
>> -		 * Be somewhat over-protective for now!
>> -		 */
>> -		if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
>> -				 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
>> -				 VM_HUGETLB | VM_MIXEDMAP))
>> -			return 0;		/* just ignore the advice */
>> -
>> -		if (vma_is_dax(vma))
>> +		if (vma->vm_flags & VM_MERGEABLE)
>>   			return 0;
>> -
>> -#ifdef VM_SAO
>> -		if (*vm_flags & VM_SAO)
>> +		if (!vma_ksm_compatible(vma))
>>   			return 0;
>> -#endif
>> -#ifdef VM_SPARC_ADI
>> -		if (*vm_flags & VM_SPARC_ADI)
>> -			return 0;
>> -#endif
>>     		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
>> -			err = __ksm_enter(mm);
>> +			err = __ksm_enter(mm, MMF_VM_MERGEABLE);
>>   			if (err)
>>   				return err;
>>   		}
>> @@ -2626,7 +2693,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>>   }
>>   EXPORT_SYMBOL_GPL(ksm_madvise);
>>   -int __ksm_enter(struct mm_struct *mm)
>> +int __ksm_enter(struct mm_struct *mm, int flag)
>>   {
>>   	struct ksm_mm_slot *mm_slot;
>>   	struct mm_slot *slot;
>> @@ -2659,7 +2726,7 @@ int __ksm_enter(struct mm_struct *mm)
>>   		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
>>   	spin_unlock(&ksm_mmlist_lock);
>>   -	set_bit(MMF_VM_MERGEABLE, &mm->flags);
>> +	set_bit(flag, &mm->flags);
>>   	mmgrab(mm);
>>     	if (needs_wakeup)
>> @@ -2668,7 +2735,7 @@ int __ksm_enter(struct mm_struct *mm)
>>   	return 0;
>>   }
>>   -void __ksm_exit(struct mm_struct *mm)
>> +void __ksm_exit(struct mm_struct *mm, int flag)
>>   {
>>   	struct ksm_mm_slot *mm_slot;
>>   	struct mm_slot *slot;
>> @@ -2700,7 +2767,7 @@ void __ksm_exit(struct mm_struct *mm)
>>     	if (easy_to_free) {
>>   		mm_slot_free(mm_slot_cache, mm_slot);
>> -		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>> +		clear_bit(flag, &mm->flags);
>>   		mmdrop(mm);
>>   	} else if (mm_slot) {
>>   		mmap_write_lock(mm);
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 740b54be3ed4..483e182e0b9d 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -46,6 +46,7 @@
>>   #include <linux/pkeys.h>
>>   #include <linux/oom.h>
>>   #include <linux/sched/mm.h>
>> +#include <linux/ksm.h>
>>     #include <linux/uaccess.h>
>>   #include <asm/cacheflush.h>
>> @@ -2213,6 +2214,8 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>   	/* vma_complete stores the new vma */
>>   	vma_complete(&vp, vmi, vma->vm_mm);
>>   +	ksm_add_vma(new);
>> +
>
> Splitting a VMA shouldn't modify VM_MERGEABLE, so I assume this is not required?
>
I'll fix it.

>>   	/* Success. */
>>   	if (new_below)
>>   		vma_next(vmi);
>> @@ -2664,6 +2667,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>   	if (file && vm_flags & VM_SHARED)
>>   		mapping_unmap_writable(file->f_mapping);
>>   	file = vma->vm_file;
>> +	ksm_add_vma(vma);
>>   expanded:
>>   	perf_event_mmap(vma);
>>   @@ -2936,6 +2940,7 @@ static int do_brk_flags(struct vma_iterator *vmi,
>> struct vm_area_struct *vma,
>>   		goto mas_store_fail;
>>     	mm->map_count++;
>> +	ksm_add_vma(vma);
>>   out:
>>   	perf_event_mmap(vma);
>>   	mm->total_vm += len >> PAGE_SHIFT;
>> @@ -3180,6 +3185,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>>   		if (vma_link(mm, new_vma))
>>   			goto out_vma_link;
>>   		*need_rmap_locks = false;
>> +		ksm_add_vma(new_vma);
>
> Copying shouldn't modify VM_MERGEABLE, so I think this is not required?
>
I'll fix it.

>>   	}
>>   	validate_mm_mt(mm);
>>   	return new_vma;
>> @@ -3356,6 +3362,7 @@ static struct vm_area_struct *__install_special_mapping(
>>   	vm_stat_account(mm, vma->vm_flags, len >> PAGE_SHIFT);
>>     	perf_event_mmap(vma);
>> +	ksm_add_vma(vma);
>
> IIUC, special mappings will never be considered a reasonable target for KSM
> (especially, because at least VM_DONTEXPAND is always set).
>
> I think you can just drop this call.
I dropped it.
