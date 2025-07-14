Return-Path: <linux-kselftest+bounces-37277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF61B04799
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 20:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3D34E2110
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E96262D0B;
	Mon, 14 Jul 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTc+QsAj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35A277800
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519219; cv=none; b=AjMHv+3nie6cyUEJ4i4HYSoPeJDvdbpYaGpiL2KpV9IJxNenMbk5Kd+toi+gzrB4any52fCJpBRfc2G0w3gzATagPESMgahwVkex0IhZNCdr2v99GzcP95Hf4MIZBl381EcUe6kIW3vc+pThMSXaKWqp3NPPmeZoqDxXd63QjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519219; c=relaxed/simple;
	bh=yWmNmWgvKvda0eYoTS5d0V7bZ75rInx7GtYuQcH7ugI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ffA4jRSsSe1Lj041CC6946w4neDJoNtmokmZ1HS0N/slQK3DWfSY/xZQPeZQ2mK3Z6FqCDLTYKo84y66d+xPTMiHIXPw4Pi6ALEmFYaUlXmBvzyPqKlA4HuvJHlHESs5K3asDKlhuCaVvQ+W+oprZDO1gr996nFDIZOvD1aU9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTc+QsAj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2355651d204so45253595ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752519217; x=1753124017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIXYjl4Oy7cLC2gt6wngeVcZAy4rgnTDnLgmQ+C2I1Y=;
        b=HTc+QsAjg772pfqgUyduDtRNiRBCcyHQYf9MW2dp1RIyVBfSdXmHgYf7YHBipO+9Bm
         tz2a8nxBgLcruOpPSvXPxUxGBh4UwBgWXTsJXS8O+Hxs77nbwklcPkXsJ+fACf7BPCqY
         55Yr0a986zQD4guGYLzbu/yD+d3bXot94s7EKVHwaA+fUnA6FFy8bcS6p/kRbupeeUFd
         xkNP1TWH3KucoPHJySVfqNLexfajApHkT1/NwtQSmRWPB0h3qTSBViR1enL20EGvvSa5
         yPtBFKbxHBzCQd7wYgbtcFy0VL3KCWLZ7ElU/WdIaRb86EUOAX8ivtqMFElHF3fgctbB
         zOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519217; x=1753124017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIXYjl4Oy7cLC2gt6wngeVcZAy4rgnTDnLgmQ+C2I1Y=;
        b=jbC0Vh0PGqdEK3sJd4c4VtYIg7/TneCiUDWopE8T/n1hi+W1OW1s3EZHwNpDyC/fRQ
         S6NnhpxCwO4yGa2qLV6WdUUZ2AGmffW2nQxoBZ/dr0Vp9a5xIDwi3O15uLlm4filC3fv
         BC7vZZyiuDJABuzoqYi1T171B08gE5Ys4ROpO1PgNlYyePhaNNMRO+BFCy1W5NzfBl33
         c7e85cBpzFkEAm7LPlQTd9yzDvtgvqsAw1SxF09A3F/SA6rbZiA9xwIeUJHAGrkuuGiU
         GxcywebHisSSa2u9nN4HnxcP7L9byxRuX6Xtpy0hHsI4P3PV7iLRXu+pHs8GK3SKPqys
         jzZw==
X-Forwarded-Encrypted: i=1; AJvYcCWPV6IyitLdHtZm7O/GoaeVgiyynBd5kVb3fRq3LQdqxVJ0fLquEwFaReW81p3ZXjEQ4fP886eL4yC+n2Ll1/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOR3LjwVVbgZcQkOhMEPXDsRnT4o/qV9y1Yzol8jo5EOXam8E
	7xRzJ/2gLdvUYGoAvWdqBorfERqlgVpI2wB6emcTQKRIYsWdBybm3gIiGRmqEEcE3Zoz15S6x2x
	QZiOVWBtnlg==
X-Google-Smtp-Source: AGHT+IHkdxQBkNJ9u5fZvf31QYZmJmI78/imSoERcG85hl6ZxFXWcMCdQ6WF5agEQ/mYR3aMFUmQE1c5Wzd8
X-Received: from plbi11.prod.google.com ([2002:a17:903:20cb:b0:236:8084:af9f])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa7:b0:234:11f9:a72b
 with SMTP id d9443c01a7336-23dede96972mr178592455ad.50.1752519217585; Mon, 14
 Jul 2025 11:53:37 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:53:15 -0700
In-Reply-To: <20250714185321.2417234-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714185321.2417234-3-ynaffit@google.com>
Subject: [PATCH v3 2/6] binder: Store lru freelist in binder_alloc
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Store a pointer to the free pages list that the binder allocator should
use for a process inside of struct binder_alloc. This change allows
binder allocator code to be tested and debugged deterministically while
a system is using binder; i.e., without interfering with other binder
processes and independently of the shrinker. This is necessary to
convert the current binder_alloc_selftest into a kunit test that does
not rely on hijacking an existing binder_proc to run.

A binder process's binder_alloc->freelist should not be changed after
it is initialized. A sole exception is the process that runs the
existing binder_alloc selftest. Its freelist can be temporarily replaced
for the duration of the test because it runs as a single thread before
any pages can be added to the global binder freelist, and the test frees
every page it allocates before dropping the binder_selftest_lock. This
exception allows the existing selftest to be used to check for
regressions, but it will be dropped when the binder_alloc tests are
converted to kunit in a subsequent patch in this series.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
 drivers/android/binder_alloc.c          | 25 +++++++----
 drivers/android/binder_alloc.h          |  3 +-
 drivers/android/binder_alloc_selftest.c | 59 ++++++++++++++++++++-----
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index fcfaf1b899c8..2e89f9127883 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -26,7 +26,7 @@
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
-struct list_lru binder_freelist;
+static struct list_lru binder_freelist;
 
 static DEFINE_MUTEX(binder_alloc_mmap_lock);
 
@@ -210,7 +210,7 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 
 		trace_binder_free_lru_start(alloc, index);
 
-		ret = list_lru_add(&binder_freelist,
+		ret = list_lru_add(alloc->freelist,
 				   page_to_lru(page),
 				   page_to_nid(page),
 				   NULL);
@@ -409,7 +409,7 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		if (page) {
 			trace_binder_alloc_lru_start(alloc, index);
 
-			on_lru = list_lru_del(&binder_freelist,
+			on_lru = list_lru_del(alloc->freelist,
 					      page_to_lru(page),
 					      page_to_nid(page),
 					      NULL);
@@ -1007,7 +1007,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			if (!page)
 				continue;
 
-			on_lru = list_lru_del(&binder_freelist,
+			on_lru = list_lru_del(alloc->freelist,
 					      page_to_lru(page),
 					      page_to_nid(page),
 					      NULL);
@@ -1229,6 +1229,17 @@ binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 static struct shrinker *binder_shrinker;
 
+static void __binder_alloc_init(struct binder_alloc *alloc,
+				struct list_lru *freelist)
+{
+	alloc->pid = current->group_leader->pid;
+	alloc->mm = current->mm;
+	mmgrab(alloc->mm);
+	mutex_init(&alloc->mutex);
+	INIT_LIST_HEAD(&alloc->buffers);
+	alloc->freelist = freelist;
+}
+
 /**
  * binder_alloc_init() - called by binder_open() for per-proc initialization
  * @alloc: binder_alloc for this proc
@@ -1238,11 +1249,7 @@ static struct shrinker *binder_shrinker;
  */
 void binder_alloc_init(struct binder_alloc *alloc)
 {
-	alloc->pid = current->group_leader->pid;
-	alloc->mm = current->mm;
-	mmgrab(alloc->mm);
-	mutex_init(&alloc->mutex);
-	INIT_LIST_HEAD(&alloc->buffers);
+	__binder_alloc_init(alloc, &binder_freelist);
 }
 
 int binder_alloc_shrinker_init(void)
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index feecd7414241..aa05a9df1360 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -15,7 +15,6 @@
 #include <linux/list_lru.h>
 #include <uapi/linux/android/binder.h>
 
-extern struct list_lru binder_freelist;
 struct binder_transaction;
 
 /**
@@ -91,6 +90,7 @@ static inline struct list_head *page_to_lru(struct page *p)
  * @free_async_space:   VA space available for async buffers. This is
  *                      initialized at mmap time to 1/2 the full VA space
  * @pages:              array of struct page *
+ * @freelist:           lru list to use for free pages (invariant after init)
  * @buffer_size:        size of address space specified via mmap
  * @pid:                pid for associated binder_proc (invariant after init)
  * @pages_high:         high watermark of offset in @pages
@@ -113,6 +113,7 @@ struct binder_alloc {
 	struct rb_root allocated_buffers;
 	size_t free_async_space;
 	struct page **pages;
+	struct list_lru *freelist;
 	size_t buffer_size;
 	int pid;
 	size_t pages_high;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 486af3ec3c02..8b18b22aa3de 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -8,8 +8,9 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/mm_types.h>
 #include <linux/err.h>
+#include <linux/list_lru.h>
+#include <linux/mm_types.h>
 #include "binder_alloc.h"
 
 #define BUFFER_NUM 5
@@ -18,6 +19,7 @@
 static bool binder_selftest_run = true;
 static int binder_selftest_failures;
 static DEFINE_MUTEX(binder_selftest_lock);
+static struct list_lru binder_selftest_freelist;
 
 /**
  * enum buf_end_align_type - Page alignment of a buffer
@@ -142,11 +144,6 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
 	for (i = 0; i < BUFFER_NUM; i++)
 		binder_alloc_free_buf(alloc, buffers[seq[i]]);
 
-		/**
-		 * Error message on a free page can be false positive
-		 * if binder shrinker ran during binder_alloc_free_buf
-		 * calls above.
-		 */
 	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
 		if (list_empty(page_to_lru(alloc->pages[i]))) {
 			pr_err_size_seq(sizes, seq);
@@ -162,8 +159,8 @@ static void binder_selftest_free_page(struct binder_alloc *alloc)
 	int i;
 	unsigned long count;
 
-	while ((count = list_lru_count(&binder_freelist))) {
-		list_lru_walk(&binder_freelist, binder_alloc_free_page,
+	while ((count = list_lru_count(&binder_selftest_freelist))) {
+		list_lru_walk(&binder_selftest_freelist, binder_alloc_free_page,
 			      NULL, count);
 	}
 
@@ -187,7 +184,7 @@ static void binder_selftest_alloc_free(struct binder_alloc *alloc,
 
 	/* Allocate from lru. */
 	binder_selftest_alloc_buf(alloc, buffers, sizes, seq);
-	if (list_lru_count(&binder_freelist))
+	if (list_lru_count(&binder_selftest_freelist))
 		pr_err("lru list should be empty but is not\n");
 
 	binder_selftest_free_buf(alloc, buffers, sizes, seq, end);
@@ -275,6 +272,20 @@ static void binder_selftest_alloc_offset(struct binder_alloc *alloc,
 	}
 }
 
+int binder_selftest_alloc_get_page_count(struct binder_alloc *alloc)
+{
+	struct page *page;
+	int allocated = 0;
+	int i;
+
+	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+		page = alloc->pages[i];
+		if (page)
+			allocated++;
+	}
+	return allocated;
+}
+
 /**
  * binder_selftest_alloc() - Test alloc and free of buffer pages.
  * @alloc: Pointer to alloc struct.
@@ -286,6 +297,7 @@ static void binder_selftest_alloc_offset(struct binder_alloc *alloc,
  */
 void binder_selftest_alloc(struct binder_alloc *alloc)
 {
+	struct list_lru *prev_freelist;
 	size_t end_offset[BUFFER_NUM];
 
 	if (!binder_selftest_run)
@@ -293,14 +305,41 @@ void binder_selftest_alloc(struct binder_alloc *alloc)
 	mutex_lock(&binder_selftest_lock);
 	if (!binder_selftest_run || !alloc->mapped)
 		goto done;
+
+	prev_freelist = alloc->freelist;
+
+	/*
+	 * It is not safe to modify this process's alloc->freelist if it has any
+	 * pages on a freelist. Since the test runs before any binder ioctls can
+	 * be dealt with, none of its pages should be allocated yet.
+	 */
+	if (binder_selftest_alloc_get_page_count(alloc)) {
+		pr_err("process has existing alloc state\n");
+		goto cleanup;
+	}
+
+	if (list_lru_init(&binder_selftest_freelist)) {
+		pr_err("failed to init test freelist\n");
+		goto cleanup;
+	}
+
+	alloc->freelist = &binder_selftest_freelist;
+
 	pr_info("STARTED\n");
 	binder_selftest_alloc_offset(alloc, end_offset, 0);
-	binder_selftest_run = false;
 	if (binder_selftest_failures > 0)
 		pr_info("%d tests FAILED\n", binder_selftest_failures);
 	else
 		pr_info("PASSED\n");
 
+	if (list_lru_count(&binder_selftest_freelist))
+		pr_err("expect test freelist to be empty\n");
+
+cleanup:
+	/* Even if we didn't run the test, it's no longer thread-safe. */
+	binder_selftest_run = false;
+	alloc->freelist = prev_freelist;
+	list_lru_destroy(&binder_selftest_freelist);
 done:
 	mutex_unlock(&binder_selftest_lock);
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


