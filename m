Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3217521668
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 15:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiEJNKE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 09:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiEJNKD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 09:10:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D51FCEC;
        Tue, 10 May 2022 06:06:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 80D4A1F8C5;
        Tue, 10 May 2022 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652187963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/N9r55RmDL/P9k3rTsZHZPvN6mp52YHLJIGiCPRLKk=;
        b=HFVf+OtUg9TYMgd3f48zTa9GREuZx+/CvV/j811tjcwFhT7hKlvedqhIzE4vCon9BCMCLb
        vGCdo0xzZU9i6gOEGqX05QMZv6nmFYoJ7qE4LQL54vqsPW73edif4xO7s7P+/YQJJvq6l3
        3+B2mCNHrrvRCUpgP+rhMkzTiotdB38=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DDF572C141;
        Tue, 10 May 2022 13:06:02 +0000 (UTC)
Date:   Tue, 10 May 2022 15:05:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        minchan@kernel.org, kirill@shutemov.name, aarcange@redhat.com,
        brauner@kernel.org, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        peterx@redhat.com, jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/3] mm: drop oom code from exit_mmap
Message-ID: <YnpjNyrdqT/QxBPI@dhcp22.suse.cz>
References: <20220510030014.3842475-1-surenb@google.com>
 <20220510030014.3842475-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510030014.3842475-2-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 09-05-22 20:00:13, Suren Baghdasaryan wrote:
> With the oom-killer being able to operate on locked pages, exit_mmap
> does not need to ensure that oom_reap_task_mm is done before it can
> proceed. Instead it can rely on mmap_lock write lock to prevent
> oom-killer from operating on the vma tree while it's freeing page
> tables. exit_mmap can hold mmap_lock read lock when unmapping vmas
> and then take mmap_lock write lock before freeing page tables.

The changelog is rather light on nasty details which might be good but
for the sake of our future us let's be more verbose so that we do not
have to reinvent the prior history each time we are looking into this
code. I would go with something like this instead:
"
The primary reason to invoke the oom reaper from the exit_mmap path used
to be a prevention of an excessive oom killing if the oom victim exit
races with the oom reaper (see 212925802454 ("mm: oom: let oom_reap_task
and exit_mmap run concurrently") for more details. The invocation has
moved around since then because of the interaction with the munlock
logic but the underlying reason has remained the same (see 27ae357fa82b
("mm, oom: fix concurrent munlock and oom reaper unmap, v3").

Munlock code is no longer a problem since a213e5cf71cb ("mm/munlock:
delete munlock_vma_pages_all(), allow oomreap") and there shouldn't be
any blocking operation before the memory is unmapped by exit_mmap so
the oom reaper invocation can be dropped. The unmapping part can be done
with the non-exclusive mmap_sem and the exclusive one is only required
when page tables are freed.

Remove the oom_reaper from exit_mmap which will make the code easier to
read. This is really unlikely to make any observable difference although
some microbenchmarks could benefit from one less branch that needs to be
evaluated even though it almost never is true.
"

One minor comment below. Other than that \o/ this is finally going away.
I strongly suspect that the history of this code is a nice example about how
over optimizing code can cause more harm than good.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/oom.h |  2 --
>  mm/mmap.c           | 25 ++++++-------------------
>  mm/oom_kill.c       |  2 +-
>  3 files changed, 7 insertions(+), 22 deletions(-)
> 
[...]
> @@ -3138,6 +3121,10 @@ void exit_mmap(struct mm_struct *mm)
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use -1 here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, vma, 0, -1);
> +	mmap_read_unlock(mm);
> +	/* Set MMF_OOM_SKIP to disregard this mm from further consideration.*/
> +	set_bit(MMF_OOM_SKIP, &mm->flags);

I think that it would be slightly more readable to add an empty line
above and below of this. Also the comment would be more helpful if it
explaind what the further consideration actually means. I would go with

	/*
	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
	 * because the memory has been already freed. Do not bother
	 * checking mm_is_oom_victim because setting a bit
	 * unconditionally is just cheaper.
	 */

> +	mmap_write_lock(mm);
>  	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
>  	tlb_finish_mmu(&tlb);

-- 
Michal Hocko
SUSE Labs
