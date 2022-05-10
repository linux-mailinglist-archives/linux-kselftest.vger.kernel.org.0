Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B667520BA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 05:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiEJDEV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 23:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiEJDEU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 23:04:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856081C743A
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 20:00:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fb7bf98f1aso8486357b3.5
        for <linux-kselftest@vger.kernel.org>; Mon, 09 May 2022 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v8x+eJcpkdL63Ie+naoRJ5K0tY4VeOqZU3kdjwItKXU=;
        b=tQbZ/WVD3zHYzCMARi8lOIW6XMFgAqOYrHo1j1YMjmf1E6Db2YUEzn7zBhUfO02eJR
         uNsGGz9W6xVLA1AYHmS5NuZ7r/mRzpYH2Hnx/tmOtgNec150hi0ujhXc1tediKwiGf/h
         EPXp+GS+9N1Qw/QPsn0+c2TSoT9Gnu2f45AOpRYTz9Q7W6nM8VTqau2PAaYWtx/57eQc
         sCO4QD6WawO8xsNiG1kegbzuCNfwShl9YZ7etBeoKA2AtPazAPjk+4gc+G0GOH9R0oiT
         M2apOyLag5zgEmw+/WD/CZ9WQgMbVbFWjv93NsBsofE2y3+wrl4wEPRuAGpdMDyRRL5D
         oFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v8x+eJcpkdL63Ie+naoRJ5K0tY4VeOqZU3kdjwItKXU=;
        b=f4xBo3VTa0GMQjX2jEGIpAwDSL5pz9327u3h+ud/5G+UQi6Qvjfh5PoNC72wa1j4i+
         c/soEZo+t9FwZqrW0hGW3+77VmU1C40+0+sACaSvmGcgESaxHCXLI00KBgB3l2Oo2aUt
         0x+idYmL81o/phajVw5CCtUoKWegbH35EdllwXGTFFsOM/Mx7kMqnZdqBqQ/fWu0uQBx
         8eiiDglGcy/niYkl+1Tdp3KUwtn/sRRpfndjLhdRQAxN4pbL/sqsGzhZXHUdKYi5oLQJ
         yv/zr/Z5VEqwkk0ka37X/i/NOputaFzTDkNa4oO/MtrFhDp5V7uV6VQ52Jr2fiZixXe8
         TrUg==
X-Gm-Message-State: AOAM532clRIBQiQz15nQ6MSFwqMVbAqtK9ov/lR3lplwUVob7HnD8A1L
        GLCnLVJE0B79vFxZk6b5V5JKwvC+ALg=
X-Google-Smtp-Source: ABdhPJwPgNaVr9a+2gxmOd31MQgAEbhuyPy+GMIaxiFaw1vY5fiRw6vfJCoJcKJvO7YSwWHFwedVmy6Y5vo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:c861:f04:adab:761b])
 (user=surenb job=sendgmr) by 2002:a81:342:0:b0:2f8:a36c:1ddd with SMTP id
 63-20020a810342000000b002f8a36c1dddmr17464093ywd.505.1652151623732; Mon, 09
 May 2022 20:00:23 -0700 (PDT)
Date:   Mon,  9 May 2022 20:00:14 -0700
In-Reply-To: <20220510030014.3842475-1-surenb@google.com>
Message-Id: <20220510030014.3842475-3-surenb@google.com>
Mime-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 3/3] mm: delete unused MMF_OOM_VICTIM flag
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
---
 include/linux/oom.h            | 9 ---------
 include/linux/sched/coredump.h | 1 -
 mm/oom_kill.c                  | 4 +---
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 6cdf0772dbae..25990e9d9e15 100644
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
index 4d9e3a656875..746f6cb07a20 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -70,7 +70,6 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
 #define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
 #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
-#define MMF_OOM_VICTIM		25	/* mm is the oom victim */
 #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
 #define MMF_MULTIPROCESS	27	/* mm is shared between processes */
 /*
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 36355b162727..11291b99599f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -732,10 +732,8 @@ static void mark_oom_victim(struct task_struct *tsk)
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
2.36.0.512.ge40c2bad7a-goog

