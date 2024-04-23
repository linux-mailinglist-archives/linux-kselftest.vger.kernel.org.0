Return-Path: <linux-kselftest+bounces-8726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B057B8AF74E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 21:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225601F274A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E47140378;
	Tue, 23 Apr 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n2zobNA5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE924140366
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900515; cv=none; b=McKjC2pNY2x9EckxU5v1QBtftHdLa0rIqOXruqGdAqcwqeGBGW5nJc0xEwRihNsUWOkIo/ucUiapSIuxvl6+fBF86o2ww+lHT2nhHuitrZUNdl6QTNVC103+fUzcrzqqjOfEOzVfO4EIXtWKYnnNANqrRgacHGo4TPsDkh1wxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900515; c=relaxed/simple;
	bh=GVnq19Jtygpx7/xSoRSJ/bI0Oymw8pT7KxuO9Uhn0Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4tpIL8CQkatw94Es0mznlDotPFDOJFoIrm1nmGftozD2inwlZ7j5SDvpShV0niqhzgXC8pF3UiidDVTtx7DTodudhciWyXaG/EwoxcEihbExyZJ1RcNR4G55fI6dtd5e1eckNVsZ1wOkHOyahIB5nXEcdBsaesRmws8oOVTmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n2zobNA5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ee12766586so163168b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713900513; x=1714505313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEOBuREQJ368TToeAeD7bKJjC+GLUrWOkGfeVbtkYk8=;
        b=n2zobNA5xeKuakgsavaLxQoJmw2AedieYz2Vi0pnJ9ToSZ/KAMKEe76xViQDVP/BV3
         ENVR6bfuDFMRiHXifPezFTZSc/iEpkmAwi6KdEeldtVgJ+96D7prI6ZjGpTJtjgv7oPr
         XwL5tTy9W+e2teIll4CYHiIiHBhWyyRvmeorw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713900513; x=1714505313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEOBuREQJ368TToeAeD7bKJjC+GLUrWOkGfeVbtkYk8=;
        b=VRQIWvuOPSNK+riHWg70hUvsDQlvQFRmYKJrnjfTmdcDCFlOhxawyxZQP02aNyI3qa
         6pNkOq0bb7xJQon6bsFSIByeSw6I4TdWH02OSg8HbJZwQ0RsVDMGLVhPOfc5c/krMNUJ
         QszyBLBPtsH728NuSZIWu3Bwt0Hdrovz8fAhm5KmLf9uRsz1JBze/csjSRO4boUNKxli
         9U/u0trA/LgyzFGlWD6B+iMqBcsneVFoJm1uZ2LEMhByKLthC9lDU2c7Gv1hlAK1IPXE
         gC+BelRkqGIgmWWNMmPLUKovo7azgX/upsyRZtYXBQ8u8KvfI9gH6gGnsSNk10uGr27U
         JO2g==
X-Forwarded-Encrypted: i=1; AJvYcCU235CL9PoUy2R6+qansH6mwkdahFzSLDH2qDI10yz+h62JPWPirHG+uZL1ZzzissB85cjrKN4O8TvkILiGwhqRsIhz50lRfq/odjQ4HevL
X-Gm-Message-State: AOJu0Yya2M2BvGwIskZwZO+tOcmwEf9wo4JBTeO4pE9yg++Zhg8uebEE
	25j22Ywdvr4yhgHL5JPgomnKREDB72wkd5FQJAo2+PxpKqsheYoCJ7hfaEMW0w==
X-Google-Smtp-Source: AGHT+IFUpaXaTakm4yI6/L52VsdiGQgNiJ1sgdGRCdzy04mXVCbJ8tWKoHrdU+IwCbwDWAUwOgOY8g==
X-Received: by 2002:a05:6a00:1825:b0:6ec:fa34:34ab with SMTP id y37-20020a056a00182500b006ecfa3434abmr633901pfa.9.1713900512865;
        Tue, 23 Apr 2024 12:28:32 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id t15-20020aa78f8f000000b006ed92b011desm10008324pfs.169.2024.04.23.12.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 12:28:32 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	pedro.falcato@gmail.com
Cc: jeffxu@google.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 1/1] mseal: Add branch prediction hint.
Date: Tue, 23 Apr 2024 19:28:25 +0000
Message-ID: <20240423192825.1273679-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240423192825.1273679-1-jeffxu@chromium.org>
References: <20240423192825.1273679-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

It is unlikely that application calls mm syscall, such as mprotect,
on already sealed mappings, adding branch prediction hint.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/madvise.c  | 2 +-
 mm/mmap.c     | 4 ++--
 mm/mprotect.c | 2 +-
 mm/mremap.c   | 4 ++--
 mm/mseal.c    | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index f7d589534e82..ea2e4f6981e2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1442,7 +1442,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	 * Check if the address range is sealed for do_madvise().
 	 * can_modify_mm_madv assumes we have acquired the lock on MM.
 	 */
-	if (!can_modify_mm_madv(mm, start, end, behavior)) {
+	if (unlikely(!can_modify_mm_madv(mm, start, end, behavior))) {
 		error = -EPERM;
 		goto out;
 	}
diff --git a/mm/mmap.c b/mm/mmap.c
index 4b80076c319e..6bc0b35ee1f9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2697,7 +2697,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	 * Prevent unmapping a sealed VMA.
 	 * can_modify_mm assumes we have acquired the lock on MM.
 	 */
-	if (!can_modify_mm(mm, start, end))
+	if (unlikely(!can_modify_mm(mm, start, end)))
 		return -EPERM;
 
 	 /* arch_unmap() might do unmaps itself.  */
@@ -3120,7 +3120,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Prevent unmapping a sealed VMA.
 	 * can_modify_mm assumes we have acquired the lock on MM.
 	 */
-	if (!can_modify_mm(mm, start, end))
+	if (unlikely(!can_modify_mm(mm, start, end)))
 		return -EPERM;
 
 	arch_unmap(mm, start, end);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b30b2494bfcd..465c6cd9578c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -748,7 +748,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	 * checking if memory is sealed.
 	 * can_modify_mm assumes we have acquired the lock on MM.
 	 */
-	if (!can_modify_mm(current->mm, start, end)) {
+	if (unlikely(!can_modify_mm(current->mm, start, end))) {
 		error = -EPERM;
 		goto out;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index d69b438dcf83..223552901f14 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -912,7 +912,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	 *
 	 * can_modify_mm assumes we have acquired the lock on MM.
 	 */
-	if (!can_modify_mm(mm, addr, addr + old_len))
+	if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
 		return -EPERM;
 
 	if (flags & MREMAP_FIXED) {
@@ -1087,7 +1087,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	 * Place can_modify_mm here so we can keep the logic related to
 	 * shrink/expand together.
 	 */
-	if (!can_modify_mm(mm, addr, addr + old_len)) {
+	if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
 		ret = -EPERM;
 		goto out;
 	}
diff --git a/mm/mseal.c b/mm/mseal.c
index daadac4b8125..bf783bba8ed0 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -32,7 +32,7 @@ static inline void set_vma_sealed(struct vm_area_struct *vma)
  */
 static bool can_modify_vma(struct vm_area_struct *vma)
 {
-	if (vma_is_sealed(vma))
+	if (unlikely(vma_is_sealed(vma)))
 		return false;
 
 	return true;
@@ -75,7 +75,7 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
 
 	/* going through each vma to check. */
 	for_each_vma_range(vmi, vma, end) {
-		if (!can_modify_vma(vma))
+		if (unlikely(!can_modify_vma(vma)))
 			return false;
 	}
 
@@ -100,7 +100,7 @@ bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long
 
 	/* going through each vma to check. */
 	for_each_vma_range(vmi, vma, end)
-		if (is_ro_anon(vma) && !can_modify_vma(vma))
+		if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma)))
 			return false;
 
 	/* Allow by default. */
-- 
2.44.0.769.g3c40516874-goog


