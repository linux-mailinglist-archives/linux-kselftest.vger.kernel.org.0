Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A30170A575
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 07:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjETFE4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 01:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjETFEy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 01:04:54 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8554EE58
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 22:04:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-623802d9bfdso29671976d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684559091; x=1687151091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lEZNQccpwa0JJflLeFMzBTg7opuNzA80L/3GrGRRMLY=;
        b=sUspdzVVWNb3XjsNMFsBKzPmFOP+kFv8BRsMIJY1Q9AHGcFEZAfu5vP/WUAmaQYDm8
         wXeWFgbQMvnIlxA+cUinkd5gIfhNJN3+27LaFT5wGRAn8q9/2ZLTXL8HoQDPpYrTKH/w
         aKUNodBp5R+mXwHYbHRWIciXD0B+gP+77/OdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684559091; x=1687151091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEZNQccpwa0JJflLeFMzBTg7opuNzA80L/3GrGRRMLY=;
        b=cDyzXCymnOrQKcggbjRNlGxePnC9dkj1wvb7tVSYCxhBNVUvNb9XQLO9x1P/CYl3oW
         ISlUS+tciMAt/VbQAsl3omU/5534hOy5IrgsstvOhxNbFP3PoGeqhu30ETHBLMStN8QO
         EpxiFjwAUQEHcXLVy6zdqaelFrQxnlh0KVbFwlO9aX21YCG9dTjd+xhw4MiUX/8InI7q
         jMSFAUg7u/DIz8TBP8eAtf7owMFciS6UQbnrkdmOKu0iHq+4FvhkaX8FRlEUwEn/dBy1
         6LzWmAYHn3ou6JWQC1Bd5FH6eWRbz7EQGPJdy6pQwOWuOvrFaV864+p6fHWRntOT5HIH
         YyUg==
X-Gm-Message-State: AC+VfDyaWmp7OUcRaMtLlf9HKsi1orhfrz/xHv4FT66VpTsv/yD+zkEi
        u7oQqeraMAThU2lkRopi244p2wsVz3zfsv+60n8=
X-Google-Smtp-Source: ACHHUZ5zqeNnbhBkxoN+lhzwMP1nElqBQHyKNNdlQW573FCVdKfT46iYAZsIyJCFbbklipt/bZOTbQ==
X-Received: by 2002:ad4:4eec:0:b0:621:599d:2fa0 with SMTP id dv12-20020ad44eec000000b00621599d2fa0mr9261488qvb.18.1684559091360;
        Fri, 19 May 2023 22:04:51 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id mm13-20020a0562145e8d00b0062162d2c0d5sm324900qvb.68.2023.05.19.22.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:04:50 -0700 (PDT)
Date:   Sat, 20 May 2023 05:04:50 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in
 move_page_tables()
Message-ID: <20230520050450.GA504695@google.com>
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org>
 <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
 <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
 <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com>
 <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com>
 <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 19, 2023 at 09:01:07PM -0700, Linus Torvalds wrote:
> On Fri, May 19, 2023 at 8:57 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > I also realize that I don't really need to check whether the masked
> > source address falls under a VMA neighboring to that of the source's.
> 
> I don't think that's true.
> 
> You can't start randomly moving other source vma's that may have other contents.

Here is the rewritten patch, this is untested and I am just sharing as a
preview (sorry if I have been noisy). I will test it soon and send a proper patch.

Basically, I detect any moves within the same VMA except when it happens for
stack moving down. And will add another patch later to test moves within a VMA.

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3] mm/mremap: Optimize the start addresses in move_page_tables()

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
nothing is expected to be mapped below the source/destination. However,
for non-overlapping mutually aligned moves as triggered by mremap(2),
I added support for checking such cases.

c. I currently only optimize for PMD moves, in the future I/we can build
on this work and do PUD moves as well if there is a need for this. But I
want to take it one step at a time.

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
[2] https://lore.kernel.org/all/CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/exec.c          |  2 +-
 include/linux/mm.h |  2 +-
 mm/mremap.c        | 71 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)

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
index 411a85682b58..5f2e0c7fc839 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -478,10 +478,56 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 	return moved;
 }
 
+/*
+ * A helper to check if we can align down. Required for
+ * move_page_tables() and realign_addr() to determine if there is any
+ * mapping to the newly aligned address.
+ */
+static bool can_align_down(struct vm_area_struct *vma, unsigned long addr,
+			       unsigned long mask)
+{
+	int addr_masked = addr & mask;
+	struct vm_area_struct *prev = NULL, *cur = NULL;
+
+	/* If the masked address is within vma, we cannot align the address down. */
+	if (vma->vm_start <= addr_masked)
+		return false;
+
+	/*
+	 * Attempt to find vma before prev that contains the address.
+	 * On any issue, assume the address is within a previous mapping.
+	 * @mmap write lock is held here, so the lookup is safe.
+	 */
+	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
+	if (!cur || cur != vma || !prev)
+		return false;
+
+	/* The masked address fell within a previous mapping. */
+	if (prev->vm_end > addr_masked)
+		return false;
+
+	return true;
+}
+
+/* Opportunistically realign to specified boundary for faster copy. */
+static void realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
+			 unsigned long *new_addr, struct vm_area_struct *new_vma,
+			 unsigned long mask)
+{
+	if ((*old_addr & ~mask) &&
+	    (*old_addr & ~mask) == (*new_addr & ~mask) &&
+	    can_align_down(old_vma, *old_addr, mask) &&
+	    can_align_down(new_vma, *new_addr, mask)) {
+		*old_addr = *old_addr & mask;
+		*new_addr = *new_addr & mask;
+	}
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks)
+		bool need_rmap_locks,
+		bool for_stack)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
@@ -493,6 +539,18 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	old_end = old_addr + len;
 
+	/*
+	 * If possible, realign addresses to PMD boundary for faster copy.
+	 * Don't align for intra-VMA moves as we may destroy existing mappings.
+	 * For the stack moving down, both the source and dest ranges are
+	 * within the same vma but we don't expect anything to exist between
+	 * start of the old stack and end of the new stack.
+	 */
+	if ((vma != new_vma || for_stack)
+		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK))) {
+		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
+	}
+
 	if (is_vm_hugetlb_page(vma))
 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
 						new_addr, len);
@@ -565,6 +623,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
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
 
@@ -633,7 +698,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
-				     need_rmap_locks);
+				     need_rmap_locks, false);
 	if (moved_len < old_len) {
 		err = -ENOMEM;
 	} else if (vma->vm_ops && vma->vm_ops->mremap) {
@@ -647,7 +712,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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

