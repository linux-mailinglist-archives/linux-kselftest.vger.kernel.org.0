Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C762653B3E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiFBGxQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 02:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiFBGxO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 02:53:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DE6155;
        Wed,  1 Jun 2022 23:53:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C910F21A92;
        Thu,  2 Jun 2022 06:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654152790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLJ0N0T2O6uFXTnR65E4sHjnO46XiYNHKpqN0TLaU48=;
        b=TNy2EjYAr0pGL9UqpEqZkuWdw6bgFKDvgMMDDUY6I4kfCGU2a6ILzpQNvreSgqiu7wP5EX
        PpBDdlwWjwsiKrVCSDTuuh5LciWtVLYRr9gD7yWCeMzAEv1EErU8X9FEyUbxEd5I8o2LuR
        4X+8ei6SzdGv+Ixq4ZuiyzXufVoX7lg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B0A52C145;
        Thu,  2 Jun 2022 06:53:10 +0000 (UTC)
Date:   Thu, 2 Jun 2022 08:53:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH RESEND v2 1/2] mm: drop oom code from exit_mmap
Message-ID: <YpheVjLQj5ili7ZJ@dhcp22.suse.cz>
References: <20220531223100.510392-1-surenb@google.com>
 <20220601143638.9e78c470d2c980053cc8059a@linux-foundation.org>
 <CAJuCfpHcPhDYTpLj8Vo+W9Q6KkWdT_BOTaEfJW6_PDCPx5kD-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHcPhDYTpLj8Vo+W9Q6KkWdT_BOTaEfJW6_PDCPx5kD-A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 01-06-22 14:47:41, Suren Baghdasaryan wrote:
> On Wed, Jun 1, 2022 at 2:36 PM Andrew Morton <akpm@linux-foundation.org> wrote:
[...]
> > But iirc mapletree wants to retain a write_lock here, so I ended up with
> >
> > void exit_mmap(struct mm_struct *mm)
> > {
> >         struct mmu_gather tlb;
> >         struct vm_area_struct *vma;
> >         unsigned long nr_accounted = 0;
> >         MA_STATE(mas, &mm->mm_mt, 0, 0);
> >         int count = 0;
> >
> >         /* mm's last user has gone, and its about to be pulled down */
> >         mmu_notifier_release(mm);
> >
> >         mmap_write_lock(mm);
> >         arch_exit_mmap(mm);
> >
> >         vma = mas_find(&mas, ULONG_MAX);
> >         if (!vma) {
> >                 /* Can happen if dup_mmap() received an OOM */
> >                 mmap_write_unlock(mm);
> >                 return;
> >         }
> >
> >         lru_add_drain();
> >         flush_cache_mm(mm);
> >         tlb_gather_mmu_fullmm(&tlb, mm);
> >         /* update_hiwater_rss(mm) here? but nobody should be looking */
> >         /* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
> >         unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
> >
> >         /*
> >          * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> >          * because the memory has been already freed. Do not bother checking
> >          * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> >          */
> >         set_bit(MMF_OOM_SKIP, &mm->flags);
> >         free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
> >                       USER_PGTABLES_CEILING);
> >         tlb_finish_mmu(&tlb);
> >
> >         /*
> >          * Walk the list again, actually closing and freeing it, with preemption
> >          * enabled, without holding any MM locks besides the unreachable
> >          * mmap_write_lock.
> >          */
> >         do {
> >                 if (vma->vm_flags & VM_ACCOUNT)
> >                         nr_accounted += vma_pages(vma);
> >                 remove_vma(vma);
> >                 count++;
> >                 cond_resched();
> >         } while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
> >
> >         BUG_ON(count != mm->map_count);
> >
> >         trace_exit_mmap(mm);
> >         __mt_destroy(&mm->mm_mt);
> >         mm->mmap = NULL;
> 
> ^^^ this line above needs to be removed when the patch is applied over
> the maple tree patchset.

I am not fully up to date on the maple tree changes. Could you explain
why resetting mm->mmap is not needed anymore please?

-- 
Michal Hocko
SUSE Labs
