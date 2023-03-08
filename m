Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48DB6B0F26
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCHQr5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 11:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCHQrz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 11:47:55 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D773ECB062
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 08:47:48 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d7so18675546qtr.12
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 08:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678294068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxydbB3uyyn9bCiMvWGSHt2Z+kQttveOlsssE2ak6kI=;
        b=cgodqzhqamLdzp7EQPagtF1gYGWqDLN3V7I2zEYyuR3gRxt7mr8Akkw5zcmCOvBK69
         jj9g+fiGERJm/1MkvMYDfyG7+MrQnrN1DY3MCaUmitsvLqtLAvua6+EdYkZDsIOWJyPB
         Hy8kx66XXapoIqDmKQeTXgvQEl3WTmJ6IdrD7WGZIVBMsCoEpYMHzvL64dcU/AesBRNR
         SpVaNdkWzfz4TylRjWIImpxOVhEZytCAFIn2TPlLVzTRe1vbo60sf4qOhcufF17hpJIE
         LLpKCOc4w8iFIQbzzpb4tXlHnRkvNV2pbZ1b1lfoPU+f9fcOLj1JAopL5qTZJKILuEPC
         sfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678294068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxydbB3uyyn9bCiMvWGSHt2Z+kQttveOlsssE2ak6kI=;
        b=Lm+36XJXoIoiYUQfa4EH5NxDT/0k0Z4SeT6aRgR9AIr1TunhRTkBoyRxxJMEdx+wE2
         vkQOI4mRZMDPAZXRxWKc7chlZWsC7ovfgszcnEr+ek++1nHqmcsb++kmAL6oFR59igNL
         s6v+GVq6MvmGVE8dhYLUKGjGA8suN2+THm33toQwBxYqhYgMCMwWKOBBGeej9y5fDmha
         +mshI6n+tZ5UwYelcp9q9sxD3VEgKwiSxJiy75k7zSse6Aj1+QBYUK+9sbjTq8GmYUUE
         3DPFdL8+xtwIMWifj5EoxHGKBG/Swz9fFo/waZDer5sXnQT5GSKyg2jgW/JLyPJSNh68
         l45w==
X-Gm-Message-State: AO0yUKVp7rk9qndQHP2I1wPF55ic7Cwl2/Yh063HQ+c8feSMbveEooMt
        PD9ho+hxPMWe6Qcg2Tb3H+2VVA==
X-Google-Smtp-Source: AK7set97fg/D+XxANClcUJyVA0x8gZg5tcID6He26QN4715WeGw5XZyQfVlTn+sZ1wXRnsBx0LOWlQ==
X-Received: by 2002:a05:622a:1106:b0:3b9:bd05:bde1 with SMTP id e6-20020a05622a110600b003b9bd05bde1mr31825069qty.8.1678294067979;
        Wed, 08 Mar 2023 08:47:47 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id 29-20020a05620a041d00b0073b8745fd39sm3215975qkp.110.2023.03.08.08.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 08:47:47 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:47:46 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3 1/3] mm: add new api to enable ksm per process
Message-ID: <20230308164746.GA473363@cmpxchg.org>
References: <20230224044000.3084046-1-shr@devkernel.io>
 <20230224044000.3084046-2-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224044000.3084046-2-shr@devkernel.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 23, 2023 at 08:39:58PM -0800, Stefan Roesch wrote:
> This adds a new prctl to API to enable and disable KSM on a per process
> basis instead of only at the VMA basis (with madvise).
> 
> 1) Introduce new MMF_VM_MERGE_ANY flag
> 
> This introduces the new flag MMF_VM_MERGE_ANY flag. When this flag is
> set, kernel samepage merging (ksm) gets enabled for all vma's of a
> process.
> 
> 2) add flag to __ksm_enter
> 
> This change adds the flag parameter to __ksm_enter. This allows to
> distinguish if ksm was called by prctl or madvise.
> 
> 3) add flag to __ksm_exit call
> 
> This adds the flag parameter to the __ksm_exit() call. This allows to
> distinguish if this call is for an prctl or madvise invocation.
> 
> 4) invoke madvise for all vmas in scan_get_next_rmap_item
> 
> If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
> over all the vmas and enable ksm if possible. For the vmas that can be
> ksm enabled this is only done once.
> 
> 5) support disabling of ksm for a process
> 
> This adds the ability to disable ksm for a process if ksm has been
> enabled for the process.
> 
> 6) add new prctl option to get and set ksm for a process
> 
> This adds two new options to the prctl system call
> - enable ksm for all vmas of a process (if the vmas support it).
> - query if ksm has been enabled for a process.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>

Hey Stefan, thanks for merging the patches into one. I found it much
easier to review.

Overall this looks straight-forward to me. A few comments below:

> @@ -2659,6 +2660,34 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  	case PR_SET_VMA:
>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>  		break;
> +#ifdef CONFIG_KSM
> +	case PR_SET_MEMORY_MERGE:
> +		if (!capable(CAP_SYS_RESOURCE))
> +			return -EPERM;
> +
> +		if (arg2) {
> +			if (mmap_write_lock_killable(me->mm))
> +				return -EINTR;
> +
> +			if (test_bit(MMF_VM_MERGEABLE, &me->mm->flags))
> +				error = -EINVAL;

So if the workload has already madvised specific VMAs the
process-enablement will fail. Why is that? Shouldn't it be possible to
override a local decision from an outside context that has more
perspective on both sharing opportunities and security aspects?

If there is a good reason for it, the -EINVAL should be addressed in
the manpage. And maybe add a comment here as well.

> +			else if (!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags))
> +				error = __ksm_enter(me->mm, MMF_VM_MERGE_ANY);
> +			mmap_write_unlock(me->mm);
> +		} else {
> +			__ksm_exit(me->mm, MMF_VM_MERGE_ANY);
> +		}
> +		break;
> +	case PR_GET_MEMORY_MERGE:
> +		if (!capable(CAP_SYS_RESOURCE))
> +			return -EPERM;
> +
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +
> +		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
> +		break;
> +#endif
>  	default:
>  		error = -EINVAL;
>  		break;
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 56808e3bfd19..23d6944f78ad 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1063,6 +1063,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>  
>  			mm_slot_free(mm_slot_cache, mm_slot);
>  			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> +			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>  			mmdrop(mm);
>  		} else
>  			spin_unlock(&ksm_mmlist_lock);
> @@ -2329,6 +2330,17 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
>  	return rmap_item;
>  }
>  
> +static bool vma_ksm_mergeable(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_MERGEABLE)
> +		return true;
> +
> +	if (test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
> +		return true;
> +
> +	return false;
> +}
> +
>  static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  {
>  	struct mm_struct *mm;
> @@ -2405,8 +2417,20 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  		goto no_vmas;
>  
>  	for_each_vma(vmi, vma) {
> -		if (!(vma->vm_flags & VM_MERGEABLE))
> +		if (!vma_ksm_mergeable(vma))
>  			continue;
> +		if (!(vma->vm_flags & VM_MERGEABLE)) {

IMO, the helper obscures the interaction between the vma flag and the
per-process flag here. How about:

		if (!(vma->vm_flags & VM_MERGEABLE)) {
			if (!test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
				continue;

			/*
			 * With per-process merging enabled, have the MM scan
			 * enroll any existing and new VMAs on the fly.
			 * 
			ksm_madvise();
		}

> +			unsigned long flags = vma->vm_flags;
> +
> +			/* madvise failed, use next vma */
> +			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &flags))
> +				continue;
> +			/* vma, not supported as being mergeable */
> +			if (!(flags & VM_MERGEABLE))
> +				continue;
> +
> +			vm_flags_set(vma, VM_MERGEABLE);

I don't understand the local flags. Can't it pass &vma->vm_flags to
ksm_madvise()? It'll set VM_MERGEABLE on success. And you know it
wasn't set before because the whole thing is inside the !set
branch. The return value doesn't seem super useful, it's only the flag
setting that matters:

			ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &vma->vm_flags);
			/* madvise can fail, and will skip special vmas (pfnmaps and such) */
			if (!(vma->vm_flags & VM_MERGEABLE))
				continue;

> +		}
>  		if (ksm_scan.address < vma->vm_start)
>  			ksm_scan.address = vma->vm_start;
>  		if (!vma->anon_vma)
> @@ -2491,6 +2515,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  
>  		mm_slot_free(mm_slot_cache, mm_slot);
>  		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> +		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>  		mmap_read_unlock(mm);
>  		mmdrop(mm);
>  	} else {

> @@ -2664,12 +2690,39 @@ int __ksm_enter(struct mm_struct *mm)
>  	return 0;
>  }
>  
> -void __ksm_exit(struct mm_struct *mm)
> +static void unmerge_vmas(struct mm_struct *mm)
> +{
> +	struct vm_area_struct *vma;
> +	struct vma_iterator vmi;
> +
> +	vma_iter_init(&vmi, mm, 0);
> +
> +	mmap_read_lock(mm);
> +	for_each_vma(vmi, vma) {
> +		if (vma->vm_flags & VM_MERGEABLE) {
> +			unsigned long flags = vma->vm_flags;
> +
> +			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_UNMERGEABLE, &flags))
> +				continue;
> +
> +			vm_flags_clear(vma, VM_MERGEABLE);

ksm_madvise() tests and clears VM_MERGEABLE, so AFAICS

	for_each_vma(vmi, vma)
		ksm_madvise();

should do it...

> +		}
> +	}
> +	mmap_read_unlock(mm);
> +}
> +
> +void __ksm_exit(struct mm_struct *mm, int flag)
>  {
>  	struct ksm_mm_slot *mm_slot;
>  	struct mm_slot *slot;
>  	int easy_to_free = 0;
>  
> +	if (!(current->flags & PF_EXITING) && flag == MMF_VM_MERGE_ANY &&
> +		test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
> +		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> +		unmerge_vmas(mm);

...and then it's short enough to just open-code it here and drop the
unmerge_vmas() helper.
