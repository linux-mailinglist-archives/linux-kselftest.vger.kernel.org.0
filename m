Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE207837A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 03:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjHVBzZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 21:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjHVBzY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 21:55:24 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8341113
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34bb72ffb1fso11141665ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692669322; x=1693274122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmTCssMd/OkLNKuh8A+l/1O9kIjaudHJc+AQCzKHLlk=;
        b=A1fiRL9/gyGYLlkYcaWvN0fBKnQebciTf0B21CCdmsU1xEeOwPHiF1/xra5llF4iqQ
         QGiqLGX70eBqHNJ5suqvz4NbbitFDLqcy3w6HKepVcS2DlgpUM+PMtv50jv4oJX6cS0Z
         Y3Gnd49h1/o+WqJ4Dlgt0SeNoAFckPqhzGZ+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692669322; x=1693274122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmTCssMd/OkLNKuh8A+l/1O9kIjaudHJc+AQCzKHLlk=;
        b=bdRfLzJByXLbZg2qGUct0WHQ2wZH176TAgNTMK6EvCvGWAqi7+cxGvB/0KJ3tTz0bG
         hge6Oh/yBHWgX2aQmK6JBGfd73dN3Q5n00MMtNdTuDX4FT5geAMfy/hqxzrT9njvT91p
         5E7DQ7PqgU1yW3NaF4MHZ7lkOdzg2s/n7yxyQ0X9LJCR6Be+vy2n17D8k8IuUpZBLj5S
         lBfAWBeAPk5CQA5hnvCXfqZ4b69iT3vr8eWZOeCl/EJkBg7KOob8j2vwOcWL/plxZufW
         cD2W9yYEY0QMPj8aGem3ZPCh9B4Q41343YRiPwBgB6xyCVMDJKYrCx1NdnOpOHWBt/l6
         RhaQ==
X-Gm-Message-State: AOJu0YwMHwiTnriLroV0xIh0kWtuKXUWDU3sn54lHMHtuLkysu4MUVyz
        4ZFfj4jcoAJspSXjWbESwlqy4A==
X-Google-Smtp-Source: AGHT+IF3qvn51n/32NdS40F5GBEiAi2QwNfdcj7jaTRmqbaEocW2e2V/vyWF81PIpFzzD8zMdl/02g==
X-Received: by 2002:a05:6e02:1a4b:b0:349:8dfa:ad64 with SMTP id u11-20020a056e021a4b00b003498dfaad64mr13813434ilv.15.1692669322088;
        Mon, 21 Aug 2023 18:55:22 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q11-20020a92d40b000000b0034886587bdcsm2907390ilm.18.2023.08.21.18.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:55:21 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v5 2/7] mm/mremap: Allow moves within the same VMA
Date:   Tue, 22 Aug 2023 01:54:55 +0000
Message-ID: <20230822015501.791637-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822015501.791637-1-joel@joelfernandes.org>
References: <20230822015501.791637-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For the stack move happening in shift_arg_pages(), the move is happening
within the same VMA which spans the old and new ranges.

In case the aligned address happens to fall within that VMA, allow such
moves and don't abort the optimization.

In the mremap case, we cannot allow any such moves as will end up
destroying some part of the mapping (either the source of the move, or
part of the existing mapping). So just avoid it for mremap.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/exec.c          |  2 +-
 include/linux/mm.h |  2 +-
 mm/mremap.c        | 29 +++++++++++++++--------------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1a827d55ba94..244925307958 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -712,7 +712,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	 * process cleanup to remove whatever mess we made.
 	 */
 	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false))
+				       vma, new_start, length, false, true))
 		return -ENOMEM;
 
 	lru_add_drain();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..e635d1fc73b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2458,7 +2458,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks);
+		bool need_rmap_locks, bool for_stack);
 
 /*
  * Flags used by change_protection().  For now we make it a bitmap so
diff --git a/mm/mremap.c b/mm/mremap.c
index 035fbf542a8f..06baa13bd2c8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -490,12 +490,13 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 }
 
 /*
- * A helper to check if a previous mapping exists. Required for
- * move_page_tables() and realign_addr() to determine if a previous mapping
- * exists before we can do realignment optimizations.
+ * A helper to check if aligning down is OK. The aligned address should fall
+ * on *no mapping*. For the stack moving down, that's a special move within
+ * the VMA that is created to span the source and destination of the move,
+ * so we make an exception for it.
  */
 static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
-			       unsigned long mask)
+			    unsigned long mask, bool for_stack)
 {
 	unsigned long addr_masked = addr_to_align & mask;
 
@@ -504,7 +505,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 	 * of the corresponding VMA, we can't align down or we will destroy part
 	 * of the current mapping.
 	 */
-	if (vma->vm_start != addr_to_align)
+	if (!for_stack && vma->vm_start != addr_to_align)
 		return false;
 
 	/*
@@ -517,7 +518,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 /* Opportunistically realign to specified boundary for faster copy. */
 static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
 			     unsigned long *new_addr, struct vm_area_struct *new_vma,
-			     unsigned long mask)
+			     unsigned long mask, bool for_stack)
 {
 	/* Skip if the addresses are already aligned. */
 	if ((*old_addr & ~mask) == 0)
@@ -528,8 +529,8 @@ static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old
 		return;
 
 	/* Ensure realignment doesn't cause overlap with existing mappings. */
-	if (!can_align_down(old_vma, *old_addr, mask) ||
-	    !can_align_down(new_vma, *new_addr, mask))
+	if (!can_align_down(old_vma, *old_addr, mask, for_stack) ||
+	    !can_align_down(new_vma, *new_addr, mask, for_stack))
 		return;
 
 	*old_addr = *old_addr & mask;
@@ -539,7 +540,7 @@ static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks)
+		bool need_rmap_locks, bool for_stack)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
@@ -559,9 +560,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	 * If possible, realign addresses to PMD boundary for faster copy.
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
-	if ((vma != new_vma)
-		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK)))
-		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
+	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
+		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK,
+				 for_stack);
 
 	flush_cache_range(vma, old_addr, old_end);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
@@ -708,7 +709,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
-				     need_rmap_locks);
+				     need_rmap_locks, false);
 	if (moved_len < old_len) {
 		err = -ENOMEM;
 	} else if (vma->vm_ops && vma->vm_ops->mremap) {
@@ -722,7 +723,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * and then proceed to unmap new area instead of old.
 		 */
 		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
-				 true);
+				 true, false);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
-- 
2.42.0.rc1.204.g551eb34607-goog

