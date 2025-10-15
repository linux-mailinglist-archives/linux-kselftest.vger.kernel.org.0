Return-Path: <linux-kselftest+bounces-43256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCABE049F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 21:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06E6B357BB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0641F4CB7;
	Wed, 15 Oct 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCYGq6Pr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D211FDE14
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554845; cv=none; b=sKyClMj5vSIt8ARxBrILViNl28GClcr3Ff8eZsOiEInazgQLkZnzmIa1umHatio0y3o5Fh7M8a+3gLwDQhCFNcU5cnl346W1YvLBCmapkyQD0qO8ELQ5rk24RoYY2LiWJia6SIELM8uAc64JC4saVloXfps6VxZ8lDfc22uE+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554845; c=relaxed/simple;
	bh=HB6Vqw+7ydLWXhhSbVTw/E6GHFLSYol5gBxI60dhSzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6vbeiTqODCbXNpK2ho1QQ4DYovj4B0fquEo6n7Ape0i4GULKr6F+k0d8Ij/lmdaCytdRhe6PUm/P+D+pjcOkKGWXAWQ57605XGKkv5iT0MMIDYqqFca+6piuvMBPg5g1h7BhSuchEIx5VPgvirbZVrtIsJZigGcCDHdSZnO7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCYGq6Pr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78102ba5966so10331388b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760554843; x=1761159643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKpGbUmSzOj72WrP0EnxSLypc0IcqdMmnVFCtJZuxlU=;
        b=UCYGq6Pr19GUIroxMfFA6mLjTjFvs+dzJdU3EvzyRvumP6XKMickngUeInqsaIkEU1
         /Haj+BRIClXxQv924XQFZ2XMZXVspCeVr0MkOpn2o7f6trgpbQYrYKtIRg4+If3NJdCX
         6kVENpgCA44z1/ylJzlK/NAOa8nCzffJD3ukXZwsQXN/8frxy60gDPty8ItyMy2rYhyg
         DQHbS1O0jZnZrIvVtKjco2jiZYneU5VFPG5mQ2MManpmez/z1+o2t19l2CBJg1DlQIwo
         dtfEwqGLWlRwNq4NsisliJxpP8DSOz90AluRgB3Jrpn2TSCZNKrAdfElr3/E8ehItsE7
         svWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554843; x=1761159643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKpGbUmSzOj72WrP0EnxSLypc0IcqdMmnVFCtJZuxlU=;
        b=JHLigsVckYoKArF5YWeIt9IpGQbE8xq4tzrSoOidSHXIvtPKKftI5LazA9c6yCu1Qn
         mGqW/UdDBtAp3RaIL85JbfhsOAlfR30kbACeaTTgXaFo1WAiss+gfRsRKMSiGcYKFmY9
         WMLW0u/nMuwmz4YL9eFmW7f9WynoPlkPmGF/Eu98Er9gi4tWmWFppmpHAAj2iFJHkW4P
         1TT5B8Q3eFq5L5zLlpMUkY3GdTqUzOTAJn6XA9oGyxIujxrJN7N4KsoZH5g8IolFADlB
         a3ekSCIY+tj35rlLmqHppjGgsyqvIdDk+pUE37pBQFzln7pWFyWVUpobyTTlcMGw7qSE
         fD4g==
X-Forwarded-Encrypted: i=1; AJvYcCWUNWjkFGYXzbEvP/GShRS5+0kfFJ7BFVKdrZfRdNuE7X3Mg51YoIHMSAhQ+A+AYL7DiTaDQiqmLKhQEDx7ipc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHW5apg+DeNyA5TSvjud4lwp4m4g/g7/WhagzP+XNcsq42E//
	f1jvleLSENf52w7Y+DXn8Jkc1nBbUjYQuo9qpk8qHF4Hc/pc983ptIkF9ZGAbselAHwNgMYEMNg
	FIo9itw==
X-Google-Smtp-Source: AGHT+IHyRappA+6tH9Os76YkQbRqGqpECognzksl9aFKwm+WiLtRqKUJv0T7aogOLuMAz2ED3mj7afM55V4=
X-Received: from pgip24.prod.google.com ([2002:a63:c158:0:b0:b54:fd1f:ef57])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10a:b0:334:8dcb:567b
 with SMTP id adf61e73a8af0-3348dcb5856mr3480615637.52.1760554842922; Wed, 15
 Oct 2025 12:00:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:58:55 +0000
In-Reply-To: <cover.1760551864.git.wyihan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760551864.git.wyihan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <57ed0bcbcfcec6fda89d60727467d7bd621c95ab.1760551864.git.wyihan@google.com>
Subject: [RFC PATCH RESEND 1/3] mm: memory_failure: Fix MF_DELAYED handling on
 truncation during failure
From: Lisa Wang <wyihan@google.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: david@redhat.com, rientjes@google.com, seanjc@google.com, 
	ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com, 
	jiaqiyan@google.com, tabba@google.com, dave.hansen@linux.intel.com, 
	Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="UTF-8"

The .error_remove_folio a_ops is used by different filesystems to handle
folio truncation upon discovery of a memory failure in the memory
associated with the given folio.

Currently, MF_DELAYED is treated as an error, causing "Failed to punch
page" to be written to the console. MF_DELAYED is then relayed to the
caller of truncat_error_folio() as MF_FAILED. This further causes
memory_failure() to return -EBUSY, which then always causes a SIGBUS.

This is also implies that regardless of whether the thread's memory
corruption kill policy is PR_MCE_KILL_EARLY or PR_MCE_KILL_LATE, a
memory failure within guest_memfd memory will always cause a SIGBUS.

Update truncate_error_folio() to return MF_DELAYED to the caller if the
.error_remove_folio() callback reports MF_DELAYED.

Generalize the comment: MF_DELAYED means memory failure was handled and
some other part of memory failure will be handled later (e.g. a next
access will result in the process being killed). Specifically for
guest_memfd, a next access by the guest will result in an error returned
to the userspace VMM.

With delayed handling, the filemap continues to hold refcounts on the
folio. Hence, take that into account when checking for extra refcounts
in me_pagecache_clean(). This is aligned with the implementation in
me_swapcache_dirty(), where, if a folio is still in the swap cache,
extra_pins is set to true.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/memory-failure.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index df6ee59527dd..77f665c16a73 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -922,9 +922,11 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
  * by the m-f() handler immediately.
  *
  * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.
- * The page is unmapped, and is removed from the LRU or file mapping.
- * An attempt to access the page again will trigger page fault and the
- * PF handler will kill the process.
+ * It means memory_failure was handled (e.g. removed from file mapping or the
+ * LRU) and some other part of memory failure will be handled later (e.g. a
+ * next access will result in the process being killed). Specifically for
+ * guest_memfd, a next access by the guest will result in an error returned to
+ * the userspace VMM.
  *
  * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
  * The page has been completely isolated, that is, unmapped, taken out of
@@ -999,6 +1001,9 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
 	if (mapping->a_ops->error_remove_folio) {
 		int err = mapping->a_ops->error_remove_folio(mapping, folio);
 
+		if (err == MF_DELAYED)
+			return err;
+
 		if (err != 0)
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
 		else if (!filemap_release_folio(folio, GFP_NOIO))
@@ -1108,18 +1113,19 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		goto out;
 	}
 
-	/*
-	 * The shmem page is kept in page cache instead of truncating
-	 * so is expected to have an extra refcount after error-handling.
-	 */
-	extra_pins = shmem_mapping(mapping);
-
 	/*
 	 * Truncation is a bit tricky. Enable it per file system for now.
 	 *
 	 * Open: to take i_rwsem or not for this? Right now we don't.
 	 */
 	ret = truncate_error_folio(folio, page_to_pfn(p), mapping);
+
+	/*
+	 * The shmem page, or any page with MF_DELAYED error handling, is kept in
+	 * page cache instead of truncating, so is expected to have an extra
+	 * refcount after error-handling.
+	 */
+	extra_pins = shmem_mapping(mapping) || ret == MF_DELAYED;
 	if (has_extra_refcount(ps, p, extra_pins))
 		ret = MF_FAILED;
 
-- 
2.51.0.788.g6d19910ace-goog


