Return-Path: <linux-kselftest+bounces-3500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC783B5EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 01:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F53286A74
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE77388;
	Thu, 25 Jan 2024 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1X57XxK8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B0385
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141614; cv=none; b=suWdfcvpXBpGDQgX6Xgp2F/Vd5TNnZz9ITHFEgjm/cocyml/zCQ/qFeuhT1b8+FlNHFhmBL8RPWxnxPIWxGNMKtuPLaSFc2X2mMqYoN/nNDZ0jJJtv0bAnqY5bFupsj7woRhs1v2T+laJXwApZIzGPXbSZ96xRlpnT8yo1WTdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141614; c=relaxed/simple;
	bh=KeDhP+xDEL1TMTboAgFtXRykmAfuqzqg9CJvAJXtD5M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VmUjQ2j3Wg/wMzGzsWCUXSr46Qi3SC+AAmU4PMygRRdLlGo2skTLpanJZFpypa8j6tbiOAWj9MYZbEgt+DkJI/Dtb9FmN10+C/mSMjKmX63dkLyr9F4LveYwoorLe5Tqq9op7BCJ9TuHl7fThO0ITPmYaT6MFHMlhhBMIa3sWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1X57XxK8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efb07ddb0fso74864957b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 16:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706141611; x=1706746411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cPu242y3p9rQer5EHrWEZnnEQJcAmzowYqkBYJsGGGI=;
        b=1X57XxK8kLFWMnqQXT6ef9m2hHNn7cN6e+KeVbLZWzIISpl3Ek3GGLhwdfFRDw/ERt
         3DAioZgxt+5BHyTHfiDwjWw3HSEDOKEJI5U3T6a4OXxd8F9815A0HjoDu8D8O3IenjGX
         Oq95SWP6H9U3ty3UZlQV+IQuhktvwcs1biEqy3Mzu/UCBoBa13LIC6YI3ZtvL+J3akYT
         Cv/vTycBYBWZUX55TReHkVE6sesA5gl9sTHuIOxLZUK4micWLleazlVbdEPx/qoxQo6z
         9nNj0eh4epS0Bpj7c7l73GwlNeD4S1vNsRYGOXr6rGrh5RVx0xRh96+00opq0QetCEjg
         cBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141611; x=1706746411;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPu242y3p9rQer5EHrWEZnnEQJcAmzowYqkBYJsGGGI=;
        b=TAn+0S2MVm/YQ2BkhFEqKwjaj6cfN1uhGZlFY7vveYgHlZiiOPZOjdQWAUAKqgfOt3
         j4sU2+Jb5pKUuT+38dQNPLNY9L99EXR2xYQuUngVXv7V9lLI/tvDc3TweLAKW4Dq0PQ6
         +8pdYv6ezI1ulDAHWIn36cZeOcBHbv5q+COf/jEz98dRIdQ+DcNMLLKrhnFXUMbadSic
         G1U3vvfnSs+6Uh7cwf8Z+s6f7KDnkvmz5VKa7uoU/HVQHlJjhOqTGScpIasbL4nYz+Aa
         RRZil7VGibyHaJu6Lw5KXnrGffI76ACQkbNA93LxrG9j8bB7v+sLFCwMPUIOAYC41kCT
         YIFA==
X-Gm-Message-State: AOJu0Yw1X9n53xn9Th6u8zA3Bh7jU2t85wvQ7FylWiVuyk8ie826xOeP
	lpVvkuPmm89gmzwmRJc8BXmE8DodZ+zrTUaNw1rn6QsH+M1WIp/9jjRUc0hf93Z3C74002oJyAb
	wiw==
X-Google-Smtp-Source: AGHT+IEZLtB9otomnw6MNDdoYLF/2uX4yU3la82s4yNMlhvEgVEVg/VGQzuPnFpome6BU13TgA+OWJtInTs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:ff85:6a8d:d789:76fa])
 (user=surenb job=sendgmr) by 2002:a0d:eb89:0:b0:5ff:ea65:3a71 with SMTP id
 u131-20020a0deb89000000b005ffea653a71mr549405ywe.3.1706141611543; Wed, 24 Jan
 2024 16:13:31 -0800 (PST)
Date: Wed, 24 Jan 2024 16:13:28 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125001328.335127-1-surenb@google.com>
Subject: [PATCH 1/2] userfaultfd: handle zeropage moves by UFFDIO_MOVE
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Current implementation of UFFDIO_MOVE fails to move zeropages and returns
EBUSY when it encounters one. We can handle them by mapping a zeropage
at the destination and clearing the mapping at the source. This is done
both for ordinary and for huge zeropages.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Applies cleanly over mm-unstable branch.

 mm/huge_memory.c | 105 +++++++++++++++++++++++++++--------------------
 mm/userfaultfd.c |  42 +++++++++++++++----
 2 files changed, 96 insertions(+), 51 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f40feb31b507..5dcc02c25e97 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2190,13 +2190,18 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	}
 
 	src_page = pmd_page(src_pmdval);
-	if (unlikely(!PageAnonExclusive(src_page))) {
-		spin_unlock(src_ptl);
-		return -EBUSY;
-	}
 
-	src_folio = page_folio(src_page);
-	folio_get(src_folio);
+	if (!is_huge_zero_pmd(src_pmdval)) {
+		if (unlikely(!PageAnonExclusive(src_page))) {
+			spin_unlock(src_ptl);
+			return -EBUSY;
+		}
+
+		src_folio = page_folio(src_page);
+		folio_get(src_folio);
+	} else
+		src_folio = NULL;
+
 	spin_unlock(src_ptl);
 
 	flush_cache_range(src_vma, src_addr, src_addr + HPAGE_PMD_SIZE);
@@ -2204,19 +2209,22 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 				src_addr + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
-	folio_lock(src_folio);
+	if (src_folio) {
+		folio_lock(src_folio);
 
-	/*
-	 * split_huge_page walks the anon_vma chain without the page
-	 * lock. Serialize against it with the anon_vma lock, the page
-	 * lock is not enough.
-	 */
-	src_anon_vma = folio_get_anon_vma(src_folio);
-	if (!src_anon_vma) {
-		err = -EAGAIN;
-		goto unlock_folio;
-	}
-	anon_vma_lock_write(src_anon_vma);
+		/*
+		 * split_huge_page walks the anon_vma chain without the page
+		 * lock. Serialize against it with the anon_vma lock, the page
+		 * lock is not enough.
+		 */
+		src_anon_vma = folio_get_anon_vma(src_folio);
+		if (!src_anon_vma) {
+			err = -EAGAIN;
+			goto unlock_folio;
+		}
+		anon_vma_lock_write(src_anon_vma);
+	} else
+		src_anon_vma = NULL;
 
 	dst_ptl = pmd_lockptr(mm, dst_pmd);
 	double_pt_lock(src_ptl, dst_ptl);
@@ -2225,45 +2233,54 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		err = -EAGAIN;
 		goto unlock_ptls;
 	}
-	if (folio_maybe_dma_pinned(src_folio) ||
-	    !PageAnonExclusive(&src_folio->page)) {
-		err = -EBUSY;
-		goto unlock_ptls;
-	}
+	if (src_folio) {
+		if (folio_maybe_dma_pinned(src_folio) ||
+		    !PageAnonExclusive(&src_folio->page)) {
+			err = -EBUSY;
+			goto unlock_ptls;
+		}
 
-	if (WARN_ON_ONCE(!folio_test_head(src_folio)) ||
-	    WARN_ON_ONCE(!folio_test_anon(src_folio))) {
-		err = -EBUSY;
-		goto unlock_ptls;
-	}
+		if (WARN_ON_ONCE(!folio_test_head(src_folio)) ||
+		    WARN_ON_ONCE(!folio_test_anon(src_folio))) {
+			err = -EBUSY;
+			goto unlock_ptls;
+		}
 
-	folio_move_anon_rmap(src_folio, dst_vma);
-	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+		folio_move_anon_rmap(src_folio, dst_vma);
+		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
 
-	src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-	/* Folio got pinned from under us. Put it back and fail the move. */
-	if (folio_maybe_dma_pinned(src_folio)) {
-		set_pmd_at(mm, src_addr, src_pmd, src_pmdval);
-		err = -EBUSY;
-		goto unlock_ptls;
-	}
+		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
+		/* Folio got pinned from under us. Put it back and fail the move. */
+		if (folio_maybe_dma_pinned(src_folio)) {
+			set_pmd_at(mm, src_addr, src_pmd, src_pmdval);
+			err = -EBUSY;
+			goto unlock_ptls;
+		}
 
-	_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
-	/* Follow mremap() behavior and treat the entry dirty after the move */
-	_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
+		_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
+		/* Follow mremap() behavior and treat the entry dirty after the move */
+		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
+	} else {
+		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
+		_dst_pmd = mk_huge_pmd(src_page, dst_vma->vm_page_prot);
+	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
 	src_pgtable = pgtable_trans_huge_withdraw(mm, src_pmd);
 	pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
 unlock_ptls:
 	double_pt_unlock(src_ptl, dst_ptl);
-	anon_vma_unlock_write(src_anon_vma);
-	put_anon_vma(src_anon_vma);
+	if (src_anon_vma) {
+		anon_vma_unlock_write(src_anon_vma);
+		put_anon_vma(src_anon_vma);
+	}
 unlock_folio:
 	/* unblock rmap walks */
-	folio_unlock(src_folio);
+	if (src_folio)
+		folio_unlock(src_folio);
 	mmu_notifier_invalidate_range_end(&range);
-	folio_put(src_folio);
+	if (src_folio)
+		folio_put(src_folio);
 	return err;
 }
 #endif /* CONFIG_USERFAULTFD */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3548b3e31a97..5fbf4da15c5c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -959,6 +959,31 @@ static int move_swap_pte(struct mm_struct *mm,
 	return 0;
 }
 
+static int move_zeropage_pte(struct mm_struct *mm,
+			     struct vm_area_struct *dst_vma,
+			     struct vm_area_struct *src_vma,
+			     unsigned long dst_addr, unsigned long src_addr,
+			     pte_t *dst_pte, pte_t *src_pte,
+			     pte_t orig_dst_pte, pte_t orig_src_pte,
+			     spinlock_t *dst_ptl, spinlock_t *src_ptl)
+{
+	pte_t zero_pte;
+
+	double_pt_lock(dst_ptl, src_ptl);
+	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
+	    !pte_same(ptep_get(dst_pte), orig_dst_pte))
+		return -EAGAIN;
+
+	zero_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
+					 dst_vma->vm_page_prot));
+	ptep_clear_flush(src_vma, src_addr, src_pte);
+	set_pte_at(mm, dst_addr, dst_pte, zero_pte);
+	double_pt_unlock(dst_ptl, src_ptl);
+
+	return 0;
+}
+
+
 /*
  * The mmap_lock for reading is held by the caller. Just move the page
  * from src_pmd to dst_pmd if possible, and return true if succeeded
@@ -1041,6 +1066,14 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	}
 
 	if (pte_present(orig_src_pte)) {
+		if (is_zero_pfn(pte_pfn(orig_src_pte))) {
+			err = move_zeropage_pte(mm, dst_vma, src_vma,
+					       dst_addr, src_addr, dst_pte, src_pte,
+					       orig_dst_pte, orig_src_pte,
+					       dst_ptl, src_ptl);
+			goto out;
+		}
+
 		/*
 		 * Pin and lock both source folio and anon_vma. Since we are in
 		 * RCU read section, we can't block, so on contention have to
@@ -1404,19 +1437,14 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 				err = -ENOENT;
 				break;
 			}
-			/* Avoid moving zeropages for now */
-			if (is_huge_zero_pmd(*src_pmd)) {
-				spin_unlock(ptl);
-				err = -EBUSY;
-				break;
-			}
 
 			/* Check if we can move the pmd without splitting it. */
 			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
 			    !pmd_none(dst_pmdval)) {
 				struct folio *folio = pfn_folio(pmd_pfn(*src_pmd));
 
-				if (!folio || !PageAnonExclusive(&folio->page)) {
+				if (!folio || (!is_huge_zero_page(&folio->page) &&
+					       !PageAnonExclusive(&folio->page))) {
 					spin_unlock(ptl);
 					err = -EBUSY;
 					break;
-- 
2.43.0.429.g432eaa2c6b-goog


