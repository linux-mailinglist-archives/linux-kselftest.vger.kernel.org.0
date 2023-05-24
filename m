Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223DC70FA26
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjEXPc7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjEXPc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 11:32:57 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB1B18E
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:54 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75b0f2ce4b7so84868885a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684942373; x=1687534373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHeROvIq4CSC2FMFzmeiM0i6iG6dvZWzuyFWS5s0CDs=;
        b=wlQ8v0bsuOA9hOIgsHnV0xzgFyBlbO7E6j9Va6zOMO1Lq54V7yVfco94su2p9uA3zT
         GAryTJuE/eyHkMObMXy25pmdmQHP7wJqp+4j8yOi3nIDdmPVuWoRz9/X7tM7FdDjEOMh
         Zp+su0joqmuWavruN1PE8gqEZA6j486QyZYcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942373; x=1687534373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHeROvIq4CSC2FMFzmeiM0i6iG6dvZWzuyFWS5s0CDs=;
        b=G8Zes0U/p/uylOtv1nmsutHz+/16C29k7KvqhuMICI3Ex9K5y781X5Ji3LpOjrTJDn
         dtRpIsjw5k4nLaumSc143OFp2NEDFHqKGO+mj4c9N9krJEUNgPTu81Ds6ijynj2WEgz3
         SihI+CJRAcG/rr3/61m2HsEhqektGQLeZgO3wsrXkU/ZLGw5lSwBNUcfZYxT80k4YLty
         3dxUOAhSAjuXwF2ji6EHg54lUhj+w1g4SU1Nn/0SPt+Kl7IbpTPAFhVSiVJmb6gmCYCe
         LbWfO/ImEo0ogf+mutY2A8+ehsuCBYKPhocE00l7oqXOKo5b7hOIMhDTIYLKI59uYle/
         OdLA==
X-Gm-Message-State: AC+VfDyPUuzdc/emZXXgBbiNtV/JFPBnn2LFNnzv7J83PqiRsAak5kgG
        hUL9W+VbF4jekwZ1OSJMLYcFZQ==
X-Google-Smtp-Source: ACHHUZ6ycnNF8Yd16rVGJYGcJx7BXDIL8yb88KqwcCKd5ph6scnPX3adlemcGYKPU680bLYJm4BkEA==
X-Received: by 2002:a37:856:0:b0:75b:23a0:d9d5 with SMTP id 83-20020a370856000000b0075b23a0d9d5mr7619005qki.43.1684942373514;
        Wed, 24 May 2023 08:32:53 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b007590aa4b115sm3296906qkj.87.2023.05.24.08.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:32:52 -0700 (PDT)
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
Subject: [PATCH v3 2/6] mm/mremap: Allow moves within the same VMA
Date:   Wed, 24 May 2023 15:32:35 +0000
Message-ID: <20230524153239.3036507-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230524153239.3036507-1-joel@joelfernandes.org>
References: <20230524153239.3036507-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 mm/mremap.c        | 40 ++++++++++++++++++++--------------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7c44d0c65b1b..7a7217353115 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -707,7 +707,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	 * process cleanup to remove whatever mess we made.
 	 */
 	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false))
+				       vma, new_start, length, false, true))
 		return -ENOMEM;
 
 	lru_add_drain();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..dd415cd2493d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2265,7 +2265,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks);
+		bool need_rmap_locks, bool for_stack);
 
 /*
  * Flags used by change_protection().  For now we make it a bitmap so
diff --git a/mm/mremap.c b/mm/mremap.c
index 184d52f83b19..323c3b94216f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -479,18 +479,23 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
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
 	struct vm_area_struct *prev = NULL, *cur = NULL;
 
-	/* If the masked address is within vma, we cannot align the address down. */
-	if (vma->vm_start <= addr_masked)
+	/*
+	 * Other than for stack moves, if the alignment causes the address to be within
+	 * its own @vma, we can't align down or we will destroy the current mapping.
+	 * In other words for non-stack moves, the masked addr has to fall on no mapping.
+	 */
+	if (!for_stack && vma->vm_start <= addr_masked)
 		return false;
 
 	/*
@@ -513,13 +518,13 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 /* Opportunistically realign to specified boundary for faster copy. */
 static void realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
 			 unsigned long *new_addr, struct vm_area_struct *new_vma,
-			 unsigned long mask)
+			 unsigned long mask, bool for_stack)
 {
 	bool mutually_aligned = (*old_addr & ~mask) == (*new_addr & ~mask);
 
 	if ((*old_addr & ~mask) && mutually_aligned
-	    && can_align_down(old_vma, *old_addr, mask)
-	    && can_align_down(new_vma, *new_addr, mask)) {
+	    && can_align_down(old_vma, *old_addr, mask, for_stack)
+	    && can_align_down(new_vma, *new_addr, mask, for_stack)) {
 		*old_addr = *old_addr & mask;
 		*new_addr = *new_addr & mask;
 	}
@@ -528,7 +533,7 @@ static void realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks)
+		bool need_rmap_locks, bool for_stack)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
@@ -540,14 +545,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	old_end = old_addr + len;
 
-	/*
-	 * If possible, realign addresses to PMD boundary for faster copy.
-	 * Don't align for intra-VMA moves as we may destroy existing mappings.
-	 */
-	if ((vma != new_vma)
-		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK))) {
-		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
-	}
+	/* If possible, realign addresses to PMD boundary for faster copy. */
+	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
+		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK, for_stack);
 
 	if (is_vm_hugetlb_page(vma))
 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
@@ -696,7 +696,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
-				     need_rmap_locks);
+				     need_rmap_locks, false);
 	if (moved_len < old_len) {
 		err = -ENOMEM;
 	} else if (vma->vm_ops && vma->vm_ops->mremap) {
@@ -710,7 +710,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * and then proceed to unmap new area instead of old.
 		 */
 		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
-				 true);
+				 true, false);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
-- 
2.40.1.698.g37aff9b760-goog

