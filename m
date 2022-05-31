Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DEE53998B
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jun 2022 00:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348436AbiEaWbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 18:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348424AbiEaWbG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 18:31:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CE19E9DD
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 15:31:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30026cf9af8so200117b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h9pooLAkTxOoQOC6qwQxwi4o0N+w6yf1K9YO1/jwitQ=;
        b=P2Kv1M4KvdGAJiBCHavF1zXIjFqInYmM2DI1iGWKnxmlqf4yDAdLi7aLh8XESxp+NV
         kMT/InhL1fVBPxrqeqw8rv1dk5rva4csKBxy1Xak1jp0XYN4sAR106MWhGUKDz5FZ30Y
         KUNHQ2SgPzxl43h9E5DiAs7Y8Kns67FIKC2XcKv69QyrGeZYnuJAjQXUA7M47MeQaeCT
         Nh5+cG/ZGXBGYEYYLIjA9Q3DNULgoDr5ZLBHN5SkUOd/Sw7f8/nxJ8BoLLorLPv4d8uU
         nR3yLwABX9I5Czy9JShk3uYFDrduecjAQoG9q3v6ZbQTn2iErZXgJB24T15SWYYSDqTp
         J9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h9pooLAkTxOoQOC6qwQxwi4o0N+w6yf1K9YO1/jwitQ=;
        b=cc9JNJ5VB61VBekr7eKDwgqMdFXScBdTYxMvPj0/wAJrammabpEFRj/f5VfnavbZeh
         AVe2iLF2C5irKfe5U8c912IOXyNE2HO0xK31MXdztwh/W7wJ4ZQpGP7GMBi4XiGLft6K
         x1hekV9UhF1ifuacb26HWtXOcSDk+KRllTH5hxRpDNpCoItPsGtHSbBsJvNuGD7DVbxv
         LQMlENHNWust+R34YkS1vJU7eZsWztmzdhY1eduEu0QCWcLlWnY/eJ0P24nO9IdLeN4e
         xa0UXvrpAnEDN8YMEFS1XIWzxu37aRuqiKgpBaQWLj8QVVluGdrSIu9l//LgMdoE562Y
         sihA==
X-Gm-Message-State: AOAM533WhkYeiJhID/8yTuvYrs1u1koRxkXCdbokbamMJ3pxYujOablo
        83i8F9hHtmetDRImzLbnYvEmAO+8z4c=
X-Google-Smtp-Source: ABdhPJxR5+9a+rq2QPHmzHo3mWkb9YqhKufREbDYM0yvQ7VUtvm+1tFjkzSNSzzxPLibDeUvrGcZjmJb28w=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5ba6:9c55:2664:4cc])
 (user=surenb job=sendgmr) by 2002:a25:e68b:0:b0:65c:7aa5:f901 with SMTP id
 d133-20020a25e68b000000b0065c7aa5f901mr19116227ybh.147.1654036263852; Tue, 31
 May 2022 15:31:03 -0700 (PDT)
Date:   Tue, 31 May 2022 15:30:59 -0700
Message-Id: <20220531223100.510392-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH RESEND v2 1/2] mm: drop oom code from exit_mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The primary reason to invoke the oom reaper from the exit_mmap path used
to be a prevention of an excessive oom killing if the oom victim exit
races with the oom reaper (see [1] for more details). The invocation has
moved around since then because of the interaction with the munlock
logic but the underlying reason has remained the same (see [2]).

Munlock code is no longer a problem since [3] and there shouldn't be
any blocking operation before the memory is unmapped by exit_mmap so
the oom reaper invocation can be dropped. The unmapping part can be done
with the non-exclusive mmap_sem and the exclusive one is only required
when page tables are freed.

Remove the oom_reaper from exit_mmap which will make the code easier to
read. This is really unlikely to make any observable difference although
some microbenchmarks could benefit from one less branch that needs to be
evaluated even though it almost never is true.

[1] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
[2] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
[3] a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Notes:
- Rebased over git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
mm-unstable branch per Andrew's request but applies cleany to Linus' ToT
- Conflicts with maple-tree patchset. Resolving these was discussed in
https://lore.kernel.org/all/20220519223438.qx35hbpfnnfnpouw@revolver/

 include/linux/oom.h |  2 --
 mm/mmap.c           | 31 ++++++++++++-------------------
 mm/oom_kill.c       |  2 +-
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 02d1e7bbd8cd..6cdde62b078b 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 	return 0;
 }
 
-bool __oom_reap_task_mm(struct mm_struct *mm);
-
 long oom_badness(struct task_struct *p,
 		unsigned long totalpages);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 2b9305ed0dda..b7918e6bb0db 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3110,30 +3110,13 @@ void exit_mmap(struct mm_struct *mm)
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
 
-	if (unlikely(mm_is_oom_victim(mm))) {
-		/*
-		 * Manually reap the mm to free as much memory as possible.
-		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
-		 * this mm from further consideration.  Taking mm->mmap_lock for
-		 * write after setting MMF_OOM_SKIP will guarantee that the oom
-		 * reaper will not run on this mm again after mmap_lock is
-		 * dropped.
-		 *
-		 * Nothing can be holding mm->mmap_lock here and the above call
-		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
-		 * __oom_reap_task_mm() will not block.
-		 */
-		(void)__oom_reap_task_mm(mm);
-		set_bit(MMF_OOM_SKIP, &mm->flags);
-	}
-
-	mmap_write_lock(mm);
+	mmap_read_lock(mm);
 	arch_exit_mmap(mm);
 
 	vma = mm->mmap;
 	if (!vma) {
 		/* Can happen if dup_mmap() received an OOM */
-		mmap_write_unlock(mm);
+		mmap_read_unlock(mm);
 		return;
 	}
 
@@ -3143,6 +3126,16 @@ void exit_mmap(struct mm_struct *mm)
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
+	mmap_read_unlock(mm);
+
+	/*
+	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
+	 * because the memory has been already freed. Do not bother checking
+	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
+	 */
+	set_bit(MMF_OOM_SKIP, &mm->flags);
+
+	mmap_write_lock(mm);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8a70bca67c94..98dca2b42357 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -538,7 +538,7 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
 static struct task_struct *oom_reaper_list;
 static DEFINE_SPINLOCK(oom_reaper_lock);
 
-bool __oom_reap_task_mm(struct mm_struct *mm)
+static bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret = true;
-- 
2.36.1.255.ge46751e96f-goog

