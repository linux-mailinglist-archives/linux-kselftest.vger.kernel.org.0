Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4A520BA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 05:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiEJDET (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 23:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiEJDES (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 23:04:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F72878C5
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 20:00:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f8398e99dcso136747137b3.9
        for <linux-kselftest@vger.kernel.org>; Mon, 09 May 2022 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0AgUzbjAvIGQIJ3TKegneiDhTRDvs3xkC1XjZGJhuTM=;
        b=g2QUSKlRjvRS+HoSod1AhsivUbuFmEFJg57nBgO2wWxFMQNX8TsbB41XI1BTaumzbB
         6dpabPhWR5+CjlSCvGkHLatd/WH7DTMT9+YpzFnMX5YnTqC63pNh0jGXTOwMvm/EekcO
         1G82nTItky0wND+qfqPnQnhEFucQi98nX1BAmm560CLqvAd6UjZFzwDZnQLkdvRGqJKC
         lDQHbrXjl6MaKJWo0QyHQhnb1KINt/R/Nif3SsK6F3E/csIPox5QHrzItKaFGqIdHj9i
         jnao6Vz1C95NxOnvQrDnVNQx/S1fX7vCdGcb5oC/oJNzcg5EuqIaKKkZUIrYg2wglL1y
         BE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0AgUzbjAvIGQIJ3TKegneiDhTRDvs3xkC1XjZGJhuTM=;
        b=56+I4lqA1fTtVH0hHpy7e/yliXBwHFGvx7l74g15DlS6wYnpnoHYkiQ97TYQ/PVKj1
         4LZCeA/RIoj1Xapjx4cJdOJfjgJvPkxDk1XXQIbZoI4SMtrTG7fRPuKI+U6KSQmof2Ed
         jAWUJx+IYW3jME8NXJqUGX/99MkeMR6vW3Uy6a2W63OfSeIcdfxiWgXvModNgR8FmOr6
         zbH57fa1ELJi75oUb33/CKkEwCsHW9uwajMqrqFN/z7YmaIzuxb8zy6vsuhiZ9/EwePp
         yphYIhAB95gUSuaUX+NMGIqEGZERqgZjqs5AmjgjW3VNb0Hi2a3Qttq2cMyDT6Tn6C33
         O61Q==
X-Gm-Message-State: AOAM5317d3pIOhdRcH8WhcaOeEZdRyRSDDHaK2Q1n/MkS/P/3qCUs14q
        CIYd70SkSf6rtT9rq3JM0WiOuOAdLM8=
X-Google-Smtp-Source: ABdhPJzDKMEzb2CAKUZ4Pj/zM4asaQ571FFbXOKj7mf4MBe/jnpHMEbX7l3RdYkWo2AAdpU/z6TgOHILws8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:c861:f04:adab:761b])
 (user=surenb job=sendgmr) by 2002:a25:e606:0:b0:648:402e:598a with SMTP id
 d6-20020a25e606000000b00648402e598amr16042195ybh.170.1652151621410; Mon, 09
 May 2022 20:00:21 -0700 (PDT)
Date:   Mon,  9 May 2022 20:00:13 -0700
In-Reply-To: <20220510030014.3842475-1-surenb@google.com>
Message-Id: <20220510030014.3842475-2-surenb@google.com>
Mime-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 2/3] mm: drop oom code from exit_mmap
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

With the oom-killer being able to operate on locked pages, exit_mmap
does not need to ensure that oom_reap_task_mm is done before it can
proceed. Instead it can rely on mmap_lock write lock to prevent
oom-killer from operating on the vma tree while it's freeing page
tables. exit_mmap can hold mmap_lock read lock when unmapping vmas
and then take mmap_lock write lock before freeing page tables.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/oom.h |  2 --
 mm/mmap.c           | 25 ++++++-------------------
 mm/oom_kill.c       |  2 +-
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..6cdf0772dbae 100644
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
index 313b57d55a63..feaa840fb95d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
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
 
@@ -3138,6 +3121,10 @@ void exit_mmap(struct mm_struct *mm)
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
+	mmap_read_unlock(mm);
+	/* Set MMF_OOM_SKIP to disregard this mm from further consideration.*/
+	set_bit(MMF_OOM_SKIP, &mm->flags);
+	mmap_write_lock(mm);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 49d7df39b02d..36355b162727 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -509,7 +509,7 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
 static struct task_struct *oom_reaper_list;
 static DEFINE_SPINLOCK(oom_reaper_lock);
 
-bool __oom_reap_task_mm(struct mm_struct *mm)
+static bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret = true;
-- 
2.36.0.512.ge40c2bad7a-goog

