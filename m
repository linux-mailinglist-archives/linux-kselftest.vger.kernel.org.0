Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44572718E15
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 00:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjEaWIh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 18:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjEaWIg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 18:08:36 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A631B8
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 15:08:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-626157a186bso8552996d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685570898; x=1688162898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcpMDk08TnAKM11DZYaTQHoJHdMHYlx0PmCfJSmuqxQ=;
        b=wEwknpWuACfVk2BLZAAwhK1P+A8Agyg2LkaiMrZv/vk+Jqv3PjEA3zHf+KOHmK4Pxx
         sYYbfV/UmdJ7qbsavZh91UeTFvV/aLbtLtNOxKYXZP0bQ+FrDbx/ezrzjN+6DuOM96+6
         CyyRczA9px0WqR6nr3eZ09ZYqir15Ii3x7h8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685570898; x=1688162898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcpMDk08TnAKM11DZYaTQHoJHdMHYlx0PmCfJSmuqxQ=;
        b=boA3mVFl/R3wnKPeUchKbH35hGCFCZUSuGlI3+0Va60V+tmRlDhBOnFPpQSiiQdCQX
         bseJgsEKpsExDohe3kV23QHJpW0r3ht5NZ1VvuIhV2TenQEKsgZ4OkTwBJH32iPCai0g
         zurzAOeR/eAbQluYIBvgi8dPcSBGXqJvNa8Tov03VgFb5nHCf8lFmoakuhb0o7F+yh1o
         Dkdxq9Mbx5iieHDNCtkXy8rZP9fmNFIed1hAATFWBkRWWLtt4OlgM4+XWwEwdiUaCunD
         ArVMDn4RL6TyAeMdMNnA+ABuM+39k6JFj77sNBSMNvmCuac75HrjrQnxG1L6FOHPVrrR
         qADQ==
X-Gm-Message-State: AC+VfDyvciti8hp4XnAqM3cGwDzANJMrZvDAN17nOoVIazernME2nqe8
        FhF0Uzop/zEK34v1MpLEQqh8Kg==
X-Google-Smtp-Source: ACHHUZ6VD/g4jSj2d9B84SOdyc6mJVRalNKUWWpk2+9CxmTsHgUmiKwb5GcyFfj7v6tYE/kvvmPfuQ==
X-Received: by 2002:a05:6214:509d:b0:570:5389:2216 with SMTP id kk29-20020a056214509d00b0057053892216mr16116075qvb.22.1685570898020;
        Wed, 31 May 2023 15:08:18 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b003f6b0f4126fsm6666172qtk.8.2023.05.31.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:08:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in move_page_tables()
Date:   Wed, 31 May 2023 22:08:01 +0000
Message-ID: <20230531220807.2048037-2-joel@joelfernandes.org>
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

Recently, we see reports [1] of a warning that triggers due to
move_page_tables() doing a downward and overlapping move on a
mutually-aligned offset within a PMD. By mutual alignment, I
mean the source and destination addresses of the mremap are at
the same offset within a PMD.

This mutual alignment along with the fact that the move is downward is
sufficient to cause a warning related to having an allocated PMD that
does not have PTEs in it.

This warning will only trigger when there is mutual alignment in the
move operation. A solution, as suggested by Linus Torvalds [2], is to
initiate the copy process at the PMD level whenever such alignment is
present. Implementing this approach will not only prevent the warning
from being triggered, but it will also optimize the operation as this
method should enhance the speed of the copy process whenever there's a
possibility to start copying at the PMD level.

Some more points:
a. The optimization can be done only when both the source and
destination of the mremap do not have anything mapped below it up to a
PMD boundary. I add support to detect that.

b. #a is not a problem for the call to move_page_tables() from exec.c as
nothing is expected to be mapped below the source. However, for
non-overlapping mutually aligned moves as triggered by mremap(2), I
added support for checking such cases.

c. I currently only optimize for PMD moves, in the future I/we can build
on this work and do PUD moves as well if there is a need for this. But I
want to take it one step at a time.

d. We need to be careful about mremap of ranges within the VMA itself.
For this purpose, I added checks to determine if the address to align
is not the beginning of the VMA which that address corresponds to.

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
[2] https://lore.kernel.org/all/CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/mremap.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 411a85682b58..bf355e4d6bd4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -478,6 +478,51 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 	return moved;
 }
 
+/*
+ * A helper to check if a previous mapping exists. Required for
+ * move_page_tables() and realign_addr() to determine if a previous mapping
+ * exists before we can do realignment optimizations.
+ */
+static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
+			       unsigned long mask)
+{
+	unsigned long addr_masked = addr_to_align & mask;
+	struct vm_area_struct *prev = NULL, *cur = NULL;
+
+	/*
+	 * If @addr_to_align of either source or destination is not the beginning
+	 * of the corresponding VMA, we can't align down or we will destroy part
+	 * of the current mapping.
+	 */
+	if (vma->vm_start != addr_to_align)
+		return false;
+
+	/*
+	 * Find the VMA before @vma to see if it subsumes the masked address.
+	 * The mmap write lock is held here so the lookup is safe.
+	 */
+	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
+	if (WARN_ON_ONCE(cur != vma))
+		return false;
+
+	return !prev || prev->vm_end <= addr_masked;
+}
+
+/* Opportunistically realign to specified boundary for faster copy. */
+static void realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
+			 unsigned long *new_addr, struct vm_area_struct *new_vma,
+			 unsigned long mask)
+{
+	bool mutually_aligned = (*old_addr & ~mask) == (*new_addr & ~mask);
+
+	if ((*old_addr & ~mask) && mutually_aligned
+	    && can_align_down(old_vma, *old_addr, mask)
+	    && can_align_down(new_vma, *new_addr, mask)) {
+		*old_addr = *old_addr & mask;
+		*new_addr = *new_addr & mask;
+	}
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -493,6 +538,15 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	old_end = old_addr + len;
 
+	/*
+	 * If possible, realign addresses to PMD boundary for faster copy.
+	 * Don't align for intra-VMA moves as we may destroy existing mappings.
+	 */
+	if ((vma != new_vma)
+		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK))) {
+		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
+	}
+
 	if (is_vm_hugetlb_page(vma))
 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
 						new_addr, len);
@@ -565,6 +619,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_end(&range);
 
+	/*
+	 * Prevent negative return values when {old,new}_addr was realigned
+	 * but we broke out of the above loop for the first PMD itself.
+	 */
+	if (len + old_addr < old_end)
+		return 0;
+
 	return len + old_addr - old_end;	/* how much done */
 }
 
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

