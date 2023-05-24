Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050FC70FA25
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjEXPc7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbjEXPc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 11:32:56 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBF12B
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:53 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75b132ad421so152850385a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684942372; x=1687534372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYAWyrxgPtqWXYxm6cJhdFwBx5wHciPZ/aYd0labdNY=;
        b=On7I5ayOaYhi5YG/GPdB9nxaPm77pHmMCGllRGYcQUbOR9RaWe8+E1kwIyz/Gm1IO2
         lzlpVKQhkPTjP/JCXbURVFFWQ3jgbHYHGgepr9uzBOnTK1CeaL3pkQv0Y3ntC9d96Fw5
         Q/V2PreQmRTT8rUh3sL+unZfL9jgCw+Ofoan0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942372; x=1687534372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYAWyrxgPtqWXYxm6cJhdFwBx5wHciPZ/aYd0labdNY=;
        b=EDlNgJ9zeH938N1yriBbmSlJx6zT7NegaoJCVjaRmEY9Lw54PpB90cGDmE8+mLws8G
         862aMZg0YsUwIxf7QUGS6098kREesFk2yZ7/rCijoHfvAfSK4n5JBzWs2w2IDZbbB8p7
         fiQ51L+e7OKPYcyAwCdTXIpQWYIfk25+RBuzGSMD1bFASreR+bIrFRqfaUvYkUq9A59J
         rhjXLpUO67M9V1YDeWOjXSbalr5ky+bJlexqG3pwWmKjtlVehJ285l0Gi7XGqtc/0l5W
         VBfLhOOzzc1lB/LNwDBDnBIoiQ2hQAs2atLFFC1CeH3HrLLK5HMBGet06THcUhbQF/6J
         YJQA==
X-Gm-Message-State: AC+VfDwTmeqV0XwzRq5VHlS2VjmeGMnTDHdXYyiwk8rhQLTMhks8f04h
        Hpkbjy5S7Al9Pes9fxlTXXVXJE2tlswd/jkvTMU=
X-Google-Smtp-Source: ACHHUZ5whL3pswyeHoY7J7ITOmoL7n/+ckLUp2U8dIz21/Y207+W8uQinoe+VqHo2CMLKpf+5MBPGQ==
X-Received: by 2002:a05:620a:172a:b0:75b:23a1:3634 with SMTP id az42-20020a05620a172a00b0075b23a13634mr9248078qkb.69.1684942372538;
        Wed, 24 May 2023 08:32:52 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b007590aa4b115sm3296906qkj.87.2023.05.24.08.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:32:51 -0700 (PDT)
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
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v3 1/6] mm/mremap: Optimize the start addresses in move_page_tables()
Date:   Wed, 24 May 2023 15:32:34 +0000
Message-ID: <20230524153239.3036507-2-joel@joelfernandes.org>
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

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/mremap.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 411a85682b58..184d52f83b19 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -478,6 +478,53 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
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
+	/* If the masked address is within vma, we cannot align the address down. */
+	if (vma->vm_start <= addr_masked)
+		return false;
+
+	/*
+	 * Attempt to find VMA before prev that contains the address.
+	 * On any issue finding prev, assume there is a mapping and return false
+	 * which will turn off any optimizations. Yes, we're conservative!
+	 * The mmap write lock is held here, so the lookup is safe.
+	 */
+	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
+	if (!cur || cur != vma || !prev)
+		return false;
+
+	/* The masked address fell within some previous mapping. */
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
@@ -493,6 +540,15 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
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
@@ -565,6 +621,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
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
2.40.1.698.g37aff9b760-goog

