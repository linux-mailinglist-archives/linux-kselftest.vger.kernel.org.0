Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1B718E17
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 00:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjEaWIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 18:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjEaWIj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 18:08:39 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D2A1BD
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 15:08:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75b08639930so81569785a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685570899; x=1688162899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKyKgK7RUrVgt5O/vBjlSKA4QqkZUlv4FmPm/U0omy4=;
        b=obKUiscoppUsJUJ3/7hX1SsM+6rEew9ZQfKAMh3vWfYW1rmT9yIKGAZubZxIr4LEiG
         +Al4BVanJStN5/cLaoxvQfUA8HotrTrtltYR3OAN7CO/qw/V5C9yoijvOQuFNRqFFvUd
         FvFegsoDVgzfl78OoRhTbHXYk02PvrhI2s2+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685570899; x=1688162899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKyKgK7RUrVgt5O/vBjlSKA4QqkZUlv4FmPm/U0omy4=;
        b=IHliGCJ/QUAEt+Eq8gWRFAFVI4XYJFNWY30e27pbbxDwNpbVDSVwooKuTTbm6AoW43
         jmt9+SWtYVKhL5cvLjLeEaw9wRsdEYeWzdHz+6y2zwqvvQTKQ8bg2Jj4Qj6QDKiT14LE
         tdui41uRE341P4ikDfARv9DzPdqqquq+xrZUJ3bdxvWIxJ/Ob2HVmpsM7v4zIZ1c8xL6
         wDD5xAI55NE6p46VCmzpF/r+oNVeorx2S6Utcn0gtYcSZemgGmYH3q6Y7Jz1bsvrTfUy
         TrBD+u/o7CaRmYcpQxtstHXF/SHVKo0Y6JzjGiheQ+k0fXCZotNtKQYq6KIpFtdg43KT
         0RKg==
X-Gm-Message-State: AC+VfDyknaxle64pW86gqEu3Nqz+gPmjcLjxPYMCHLJf2PWs2gtJW2lt
        6k8tfdiTA/RA01sOXQ+CxRDULw==
X-Google-Smtp-Source: ACHHUZ7AkCLZ1IadOtiNpTKRumVwd03RrWCxqJfgVOKG6KWsEhn44uxV0VQrpA8Ip4FERNK4pI0qpA==
X-Received: by 2002:ac8:5a83:0:b0:3f5:1d97:1922 with SMTP id c3-20020ac85a83000000b003f51d971922mr15388023qtc.2.1685570899022;
        Wed, 31 May 2023 15:08:19 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b003f6b0f4126fsm6666172qtk.8.2023.05.31.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:08:18 -0700 (PDT)
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
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: [PATCH v4 2/7] mm/mremap: Allow moves within the same VMA for stack
Date:   Wed, 31 May 2023 22:08:02 +0000
Message-ID: <20230531220807.2048037-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230531220807.2048037-1-joel@joelfernandes.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 mm/mremap.c        | 40 ++++++++++++++++++----------------------
 3 files changed, 20 insertions(+), 24 deletions(-)

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
index bf355e4d6bd4..0283f9f43d92 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -479,22 +479,23 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 }
 
 /*
- * A helper to check if a previous mapping exists. Required for
- * move_page_tables() and realign_addr() to determine if a previous mapping
- * exists before we can do realignment optimizations.
+ * A helper to check if aligning down is OK. The newly aligned address should
+ * not fall on any existing mapping otherwise we don't align. For the stack
+ * moving down, that's a special move within the VMA that is created to span
+ * the source and destination of the move, so we make an exception for it.
  */
 static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
-			       unsigned long mask)
+			    unsigned long mask, bool for_stack)
 {
 	unsigned long addr_masked = addr_to_align & mask;
 	struct vm_area_struct *prev = NULL, *cur = NULL;
 
 	/*
-	 * If @addr_to_align of either source or destination is not the beginning
-	 * of the corresponding VMA, we can't align down or we will destroy part
-	 * of the current mapping.
+	 * Other than for stack moves, if @addr_to_align of either source or
+	 * destination is not the beginning of the corresponding VMA, we can't
+	 * align down or we will destroy part of the current mapping.
 	 */
-	if (vma->vm_start != addr_to_align)
+	if (!for_stack && vma->vm_start != addr_to_align)
 		return false;
 
 	/*
@@ -511,13 +512,13 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
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
@@ -526,7 +527,7 @@ static void realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks)
+		bool need_rmap_locks, bool for_stack)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
@@ -538,14 +539,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
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
@@ -694,7 +690,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
-				     need_rmap_locks);
+				     need_rmap_locks, false);
 	if (moved_len < old_len) {
 		err = -ENOMEM;
 	} else if (vma->vm_ops && vma->vm_ops->mremap) {
@@ -708,7 +704,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * and then proceed to unmap new area instead of old.
 		 */
 		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
-				 true);
+				 true, false);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

