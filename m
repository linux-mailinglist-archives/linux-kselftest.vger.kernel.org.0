Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D6453AEF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiFAVgn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jun 2022 17:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiFAVgm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jun 2022 17:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339B1C2D79;
        Wed,  1 Jun 2022 14:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C97AF61331;
        Wed,  1 Jun 2022 21:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBA7C385A5;
        Wed,  1 Jun 2022 21:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654119400;
        bh=N11gAQiSefrt49HoG+VdPLrSyzJ8gsx80XzIVHABxP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iptty91BhQzTEYnVSDH/IZ1dLjBE84XzIfhYEZ4yix6nJ70yTApfoXwFDuNibyU2c
         OzOgEScmNBKLWnNjw2lL5oH5TiIqUDcpVFGkdmBwA2cc/Z9n1ZE8PTfvzwTwpqFg8I
         xCQGqthWF9NNimTpr9X6/Oaf26/JBGAyITBOvO68=
Date:   Wed, 1 Jun 2022 14:36:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH RESEND v2 1/2] mm: drop oom code from exit_mmap
Message-Id: <20220601143638.9e78c470d2c980053cc8059a@linux-foundation.org>
In-Reply-To: <20220531223100.510392-1-surenb@google.com>
References: <20220531223100.510392-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 31 May 2022 15:30:59 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> The primary reason to invoke the oom reaper from the exit_mmap path used
> to be a prevention of an excessive oom killing if the oom victim exit
> races with the oom reaper (see [1] for more details). The invocation has
> moved around since then because of the interaction with the munlock
> logic but the underlying reason has remained the same (see [2]).
> 
> Munlock code is no longer a problem since [3] and there shouldn't be
> any blocking operation before the memory is unmapped by exit_mmap so
> the oom reaper invocation can be dropped. The unmapping part can be done
> with the non-exclusive mmap_sem and the exclusive one is only required
> when page tables are freed.
> 
> Remove the oom_reaper from exit_mmap which will make the code easier to
> read. This is really unlikely to make any observable difference although
> some microbenchmarks could benefit from one less branch that needs to be
> evaluated even though it almost never is true.
> 
> [1] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
> [2] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> [3] a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")
> 

I've just reinstated the mapletree patchset so there are some
conflicting changes.

> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>  	return 0;
>  }
>  
> -bool __oom_reap_task_mm(struct mm_struct *mm);
> -
>  long oom_badness(struct task_struct *p,
>  		unsigned long totalpages);
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2b9305ed0dda..b7918e6bb0db 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3110,30 +3110,13 @@ void exit_mmap(struct mm_struct *mm)
>  	/* mm's last user has gone, and its about to be pulled down */
>  	mmu_notifier_release(mm);
>  
> -	if (unlikely(mm_is_oom_victim(mm))) {
> -		/*
> -		 * Manually reap the mm to free as much memory as possible.
> -		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> -		 * this mm from further consideration.  Taking mm->mmap_lock for
> -		 * write after setting MMF_OOM_SKIP will guarantee that the oom
> -		 * reaper will not run on this mm again after mmap_lock is
> -		 * dropped.
> -		 *
> -		 * Nothing can be holding mm->mmap_lock here and the above call
> -		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> -		 * __oom_reap_task_mm() will not block.
> -		 */
> -		(void)__oom_reap_task_mm(mm);
> -		set_bit(MMF_OOM_SKIP, &mm->flags);
> -	}
> -
> -	mmap_write_lock(mm);
> +	mmap_read_lock(mm);

Unclear why this patch fiddles with the mm_struct locking in this
fashion - changelogging that would have been helpful.

But iirc mapletree wants to retain a write_lock here, so I ended up with

void exit_mmap(struct mm_struct *mm)
{
	struct mmu_gather tlb;
	struct vm_area_struct *vma;
	unsigned long nr_accounted = 0;
	MA_STATE(mas, &mm->mm_mt, 0, 0);
	int count = 0;

	/* mm's last user has gone, and its about to be pulled down */
	mmu_notifier_release(mm);

	mmap_write_lock(mm);
	arch_exit_mmap(mm);

	vma = mas_find(&mas, ULONG_MAX);
	if (!vma) {
		/* Can happen if dup_mmap() received an OOM */
		mmap_write_unlock(mm);
		return;
	}

	lru_add_drain();
	flush_cache_mm(mm);
	tlb_gather_mmu_fullmm(&tlb, mm);
	/* update_hiwater_rss(mm) here? but nobody should be looking */
	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);

	/*
	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
	 * because the memory has been already freed. Do not bother checking
	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
	 */
	set_bit(MMF_OOM_SKIP, &mm->flags);
	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
		      USER_PGTABLES_CEILING);
	tlb_finish_mmu(&tlb);

	/*
	 * Walk the list again, actually closing and freeing it, with preemption
	 * enabled, without holding any MM locks besides the unreachable
	 * mmap_write_lock.
	 */
	do {
		if (vma->vm_flags & VM_ACCOUNT)
			nr_accounted += vma_pages(vma);
		remove_vma(vma);
		count++;
		cond_resched();
	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);

	BUG_ON(count != mm->map_count);

	trace_exit_mmap(mm);
	__mt_destroy(&mm->mm_mt);
	mm->mmap = NULL;
	mmap_write_unlock(mm);
	vm_unacct_memory(nr_accounted);
}

