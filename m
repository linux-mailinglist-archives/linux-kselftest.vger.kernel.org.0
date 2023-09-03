Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00527790CA9
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbjICPNm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjICPNl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:41 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDB2118
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 08:13:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-795547f055fso33808039f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Sep 2023 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754017; x=1694358817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4plAmoxt0TIZz59K3TwGGgNGB354bzgqE5y3am6jPM=;
        b=tbXIpgfSOxUppfhpAF7YQgdPvus3o7YClNsvbLqZx/mQ8FFCPpJy04oAAYHKT1RV4v
         28vSItNSLvFZRcXsXoXE4T5+du1AgR/xS6fVSUa8ssmDzUgDmY2NHWbXnjgmqlYnTCLK
         S1smp78E/XNZEB90mQ/TTiAWlphEjTRNSnCi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754017; x=1694358817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4plAmoxt0TIZz59K3TwGGgNGB354bzgqE5y3am6jPM=;
        b=Jc0x55vAKJR2BMwnOJv6geILW1PtTH1sfxBYDJE4omfHvyZlmRJ6QLyOktCz5Et0+S
         R4TOdfLy5YO4gJj+UMtjaJSz0XvqEL+XoWwuNE4G44baBYioPTCt9hgXyqeG6v5xeUGv
         TQSI23oXskR9c+rEzApT/9dmcKKUiuR+LYyKZcIKWEIYpI8x9uzfObPWKcEjGst6yBko
         tlk+FWqtXBGaSq0E7v/JcTGxzGvFQZ0IiL5L+rCsHhVjHFt19++6mKBb+RdMFoQv7orD
         /MEgZDrc/j9niq+raQXPOTbxiqglajjW5D7lwrjR2N8oWTbFwZPOADRHEx+3+RN1ZGuA
         T17w==
X-Gm-Message-State: AOJu0Yx88kc1xNufiXiA3CxMfQsfk12npA8r4fsIov/CKWoA3CrZl9q3
        r4T0Gr2u7KjDzUcp9W994o+Q6g==
X-Google-Smtp-Source: AGHT+IHJGQrTQCQWJADO7oGCiqQCRPPFaXSY0O8+5g3/GiBjHqRcTCt3H4l78vIVACIFoG7YASx0Jw==
X-Received: by 2002:a6b:7f46:0:b0:791:2db5:c779 with SMTP id m6-20020a6b7f46000000b007912db5c779mr11231804ioq.10.1693754017569;
        Sun, 03 Sep 2023 08:13:37 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v6 1/7] mm/mremap: Optimize the start addresses in move_page_tables()
Date:   Sun,  3 Sep 2023 15:13:22 +0000
Message-ID: <20230903151328.2981432-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230903151328.2981432-1-joel@joelfernandes.org>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

b. #1 is not a problem for the call to move_page_tables() from exec.c as
nothing is expected to be mapped below the source. However, for
non-overlapping mutually aligned moves as triggered by mremap(2), I
added support for checking such cases.

c. I currently only optimize for PMD moves, in the future I/we can build
on this work and do PUD moves as well if there is a need for this. But I
want to take it one step at a time.

d. We need to be careful about mremap of ranges within the VMA itself.
For this purpose, I added checks to determine if the address after
alignment falls within its VMA itself.

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
[2] https://lore.kernel.org/all/CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com/

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 11e06e4ab33b..1011326b7b80 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -489,6 +489,53 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
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
+	 * Make sure the realignment doesn't cause the address to fall on an
+	 * existing mapping.
+	 */
+	return find_vma_intersection(vma->vm_mm, addr_masked, vma->vm_start) == NULL;
+}
+
+/* Opportunistically realign to specified boundary for faster copy. */
+static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
+			     unsigned long *new_addr, struct vm_area_struct *new_vma,
+			     unsigned long mask)
+{
+	/* Skip if the addresses are already aligned. */
+	if ((*old_addr & ~mask) == 0)
+		return;
+
+	/* Only realign if the new and old addresses are mutually aligned. */
+	if ((*old_addr & ~mask) != (*new_addr & ~mask))
+		return;
+
+	/* Ensure realignment doesn't cause overlap with existing mappings. */
+	if (!can_align_down(old_vma, *old_addr, mask) ||
+	    !can_align_down(new_vma, *new_addr, mask))
+		return;
+
+	*old_addr = *old_addr & mask;
+	*new_addr = *new_addr & mask;
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -508,6 +555,14 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
 						new_addr, len);
 
+	/*
+	 * If possible, realign addresses to PMD boundary for faster copy.
+	 * Only realign if the mremap copying hits a PMD boundary.
+	 */
+	if ((vma != new_vma)
+		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK)))
+		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
+
 	flush_cache_range(vma, old_addr, old_end);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
 				old_addr, old_end);
@@ -577,6 +632,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
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
2.42.0.283.g2d96d420d3-goog

