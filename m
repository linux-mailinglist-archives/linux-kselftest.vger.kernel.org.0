Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C35953998E
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jun 2022 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348453AbiEaWbI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 18:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348438AbiEaWbH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 18:31:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8359D4F9
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 15:31:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30cb80ee75cso21658627b3.15
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UfACMRIARsl50+9wESZ79WxVKrf1+DeKmOpN6HZLSFs=;
        b=Qp+2cBCS7ITPDOl5rHNmdb1lWOYKjukksEth7d58stLaRDNC0idqCpnhdxF3mkFcTa
         1FGFBrEBZ2LgvCruuE+4qYGthyMFsYizvEH8o6++tF22Lfeva7pKpmSjnKFdQGzZHGfy
         iPtlGCx26lneyD09J0vFnpmuieGI82MhDAVi/hid9dRAUZE8mfJTCFoUgzJ9CQ0cqjCJ
         aw+sr/GwcHIdrVOzXjn9Nj9SwlMpcHQxRah7CJxuT0RKzNrTinTBz5FvdmTjyNwxMoUE
         Cz4Fr3RnUu3ztwTz4Gkp1nYNmeMnSIox8YdaxKNhGK8UhevC30YG9+F1b7o8Ahnxca4o
         /LCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UfACMRIARsl50+9wESZ79WxVKrf1+DeKmOpN6HZLSFs=;
        b=vAJPfSWod6c7IpJyqF0FywbObxM/y0BsmgUoTuF7buSfXIu79Lt/yTx4CpKgNLyr9R
         2Ne3z32lkZZ8kpV6RRLKSrHic0GfR4afr16iry5ggaPrFOrTyptNwWUH/wanklYb51I/
         y/t0JArFFtfvnhE7EBtj74uy4hsmQDB12Gj4LujGQeL2kembHsphoG4bRXnzVmXH9zlK
         7rB++FOlqGpMNgYuwkDi4+HgkX7fUcbWowSqbjvKeK7d3uawmBsRDwWWFEZ/hOxR5tUk
         8SSqR0qr8fEKdNY7Zzwu5l6/7x9kgD8U//tULbCri9mg8T0UdGsMEiRlVSRe9y/2c0id
         aLiQ==
X-Gm-Message-State: AOAM530YxEgrdYoOvH6iWg44/NY7I6Db9A2JNtU5h0q++XfYHOt8crzj
        tn/8nKkABqTwPbLEoE9MXEtITOjlEAc=
X-Google-Smtp-Source: ABdhPJxX6iFY+WymNZyAKQoSiD+LL6u2FyieTp6U+XBjEKo1mTwLbBFK4SjCjkolRPSHBi/WsllO9vmq/xQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5ba6:9c55:2664:4cc])
 (user=surenb job=sendgmr) by 2002:a81:b0b:0:b0:2e5:dcc1:3d49 with SMTP id
 11-20020a810b0b000000b002e5dcc13d49mr66111326ywl.210.1654036266179; Tue, 31
 May 2022 15:31:06 -0700 (PDT)
Date:   Tue, 31 May 2022 15:31:00 -0700
In-Reply-To: <20220531223100.510392-1-surenb@google.com>
Message-Id: <20220531223100.510392-2-surenb@google.com>
Mime-Version: 1.0
References: <20220531223100.510392-1-surenb@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
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

With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
now unused and can be removed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/oom.h            | 9 ---------
 include/linux/sched/coredump.h | 7 +++----
 mm/oom_kill.c                  | 4 +---
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 6cdde62b078b..7d0c9c48a0c5 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -77,15 +77,6 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
 	return tsk->signal->oom_mm;
 }
 
-/*
- * Use this helper if tsk->mm != mm and the victim mm needs a special
- * handling. This is guaranteed to stay true after once set.
- */
-static inline bool mm_is_oom_victim(struct mm_struct *mm)
-{
-	return test_bit(MMF_OOM_VICTIM, &mm->flags);
-}
-
 /*
  * Checks whether a page fault on the given mm is still reliable.
  * This is no longer true if the oom reaper started to reap the
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 4d0a5be28b70..8270ad7ae14c 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -71,9 +71,8 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
 #define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
 #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
-#define MMF_OOM_VICTIM		25	/* mm is the oom victim */
-#define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
-#define MMF_MULTIPROCESS	27	/* mm is shared between processes */
+#define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
+#define MMF_MULTIPROCESS	26	/* mm is shared between processes */
 /*
  * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
  * replaced in the future by mm.pinned_vm when it becomes stable, or grow into
@@ -81,7 +80,7 @@ static inline int get_dumpable(struct mm_struct *mm)
  * pinned pages were unpinned later on, we'll still keep this bit set for the
  * lifecycle of this mm, just for simplicity.
  */
-#define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
+#define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 98dca2b42357..c6c76c313b39 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -764,10 +764,8 @@ static void mark_oom_victim(struct task_struct *tsk)
 		return;
 
 	/* oom_mm is bound to the signal struct life time. */
-	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
+	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm))
 		mmgrab(tsk->signal->oom_mm);
-		set_bit(MMF_OOM_VICTIM, &mm->flags);
-	}
 
 	/*
 	 * Make sure that the task is woken up from uninterruptible sleep
-- 
2.36.1.255.ge46751e96f-goog

