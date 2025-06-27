Return-Path: <linux-kselftest+bounces-36009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF378AEC121
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F316D3B0479
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EF2ED170;
	Fri, 27 Jun 2025 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXRI4V6s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621802EB5A0
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056703; cv=none; b=Sszd9i/eBbTfNoTlhQmDXZw+cUNUMqon70bGF88ljE0o45IgPZhrGZg1urTGIU9R4xEqh6bXtAD3Bzlw3vEC1y/d2HXZNsnNTommEfjrVSsxvMvYKYl9OQd+nvKa+a6JgcodN7CQDs94er0d8e7sgUgz5yfMFW4hN3VDR18x40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056703; c=relaxed/simple;
	bh=wb8oYRoTY0+9D1slnTkZLIYKZBXALupCR0E0+NW6+xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RZ9vhkyfwWeDg3HkjcceTW3uuWvvmy4PaeaL/yFCYECqqVCzFV6nLhZAWEEML+vXUC0WFM5frXKKI3SuOKfRTXS7UHmNwsWaJO5fHwFRcFokMxGnwfSBI7gWS0tCWs6ALH1NS+wykJjhpfJU8qnpKm6F27qT52qUO0bPnCIKKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXRI4V6s; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b115fb801bcso3008786a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751056701; x=1751661501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbblKIP5kwGJthzjmPtWkjGHdpslgAQakiXmXt1cBQ8=;
        b=KXRI4V6sE7ymT9YZlgu/4rfta/hStgSYfuNFzHrAnaHYMcHAt2DbKnjfL2syCkrYl5
         WIG3KY/ho9RpIETNwPQvqLZkRV+NVMOdNe3OkNlyKi/FRtL2ipck4Kt4iZIe4vyV9lKl
         2u0yTzjtAtxtGL8ygNnJmN9/vJLLaP92kp8PBda/8to/p5/uhXtCFnyRt/6GXisEg+WF
         h2VNeAh+nBloDgczDleT3khptaEHKOSm6zshbcl3EjlXZU9GFmN5/6wOTDHwRj5Q+Ehr
         aRc9d9y0jplHMbCCyrw5IVsU8EAW2Dt66jPZ/PUqIP/A7Udt8aSPuuCuKXZJEu55XeC2
         8Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751056701; x=1751661501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbblKIP5kwGJthzjmPtWkjGHdpslgAQakiXmXt1cBQ8=;
        b=Cm6IzBAVFlgTMfd1HpDBepCV8P31X8SyeyWxJ/P4OeqRhLRHD/eKJRWIfSqYxVICBM
         /bVPk31Fw930PkbMrNlQUzbG76sEEEUfkdBRvLi1mC0Ak0lEpVcAUQVjCqV4qDlg4Y67
         FPeUszQHccjyexyBd/S86BboHaZp3I5nokW5JKDzrTu6SHuGUHrBmgbDDiAKZh3wQnYN
         /UT+MleLc3Jl9gbOOPCDTbS8/ONY7lvMzLJh5oXxRY/FX3nIJBZVSm9UakFAJDPtbrIG
         e95KBgAnyKjV5Sa2ixOkaXXUCUl8oNACAvFFFIWF4DoDjQ3fhZAwZkAOUefbXCjnJiRU
         /fvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOS/6gJBYHFfIPQnWstrul8pLxzP2D7n+M/QzJPw9xbo3PiEMKMIk0snehek/5+de+01js7ucml6053VN7tY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZYKKELhxnr0SNlxsNPBz63/O1pYcd9M5YtUoeZ1cUvXGUEu2
	dLuTts6P8Da7xPXH3iqBOPW4W2ITBljabJWjsTIIH0soSIKe8zrq2+H++OnLMF7RuMY1nBohmYX
	ht8C2JPSXcQ==
X-Google-Smtp-Source: AGHT+IHm+lRxG+m2LUOVajGQ6CUeLAklQul6iCyqI6XKr2h0WT8VjUIErUKhF84g2gdyKVfR9Z1nU9Qv9dh0
X-Received: from pjbsr15.prod.google.com ([2002:a17:90b:4e8f:b0:311:ff32:a85d])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5604:b0:311:ad7f:329f
 with SMTP id 98e67ed59e1d1-318c93228d9mr6327952a91.31.1751056700714; Fri, 27
 Jun 2025 13:38:20 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:37:45 -0700
In-Reply-To: <20250627203748.881022-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627203748.881022-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627203748.881022-5-ynaffit@google.com>
Subject: [PATCH 4/5] binder: Convert binder_alloc selftests to KUnit
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

Convert the existing binder_alloc_selftest tests into KUnit tests. These
tests allocate and free an exhaustive combination of buffers with
various sizes and alignments. This change allows them to be run without
blocking or otherwise interfering with other processes in binder.

This test is refactored into more meaningful cases in the subsequent
patch.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
 drivers/android/Kconfig                    |  10 -
 drivers/android/Makefile                   |   1 -
 drivers/android/binder.c                   |   5 -
 drivers/android/binder_alloc.c             |   3 +
 drivers/android/binder_alloc.h             |   5 -
 drivers/android/binder_alloc_selftest.c    | 345 ---------------------
 drivers/android/tests/binder_alloc_kunit.c | 278 +++++++++++++++++
 7 files changed, 281 insertions(+), 366 deletions(-)
 delete mode 100644 drivers/android/binder_alloc_selftest.c

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index b1bc7183366c..5b3b8041f827 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -37,16 +37,6 @@ config ANDROID_BINDER_DEVICES
 	  created. Each binder device has its own context manager, and is
 	  therefore logically separated from the other devices.
 
-config ANDROID_BINDER_IPC_SELFTEST
-	bool "Android Binder IPC Driver Selftest"
-	depends on ANDROID_BINDER_IPC
-	help
-	  This feature allows binder selftest to run.
-
-	  Binder selftest checks the allocation and free of binder buffers
-	  exhaustively with combinations of various buffer sizes and
-	  alignments.
-
 config ANDROID_BINDER_ALLOC_KUNIT_TEST
 	tristate "KUnit Tests for Android Binder Alloc" if !KUNIT_ALL_TESTS
 	depends on ANDROID_BINDER_IPC && KUNIT
diff --git a/drivers/android/Makefile b/drivers/android/Makefile
index 74d02a335d4e..c5d47be0276c 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -3,5 +3,4 @@ ccflags-y += -I$(src)			# needed for trace events
 
 obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
 obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
-obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
 obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= tests/
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9dfe90c284fc..7b2653a5d59c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5718,11 +5718,6 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct binder_thread *thread;
 	void __user *ubuf = (void __user *)arg;
 
-	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
-			proc->pid, current->pid, cmd, arg);*/
-
-	binder_selftest_alloc(&proc->alloc);
-
 	trace_binder_ioctl(cmd, arg);
 
 	ret = wait_event_interruptible(binder_user_error_wait, binder_stop_on_user_error < 2);
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index c79e5c6721f0..74a184014fa7 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -701,6 +701,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 out:
 	return buffer;
 }
+EXPORT_SYMBOL_IF_KUNIT(binder_alloc_new_buf);
 
 static unsigned long buffer_start_page(struct binder_buffer *buffer)
 {
@@ -879,6 +880,7 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	binder_free_buf_locked(alloc, buffer);
 	mutex_unlock(&alloc->mutex);
 }
+EXPORT_SYMBOL_IF_KUNIT(binder_alloc_free_buf);
 
 /**
  * binder_alloc_mmap_handler() - map virtual address space for proc
@@ -1217,6 +1219,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 err_mmget:
 	return LRU_SKIP;
 }
+EXPORT_SYMBOL_IF_KUNIT(binder_alloc_free_page);
 
 static unsigned long
 binder_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index dc8dce2469a7..bed97c2cad92 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -121,11 +121,6 @@ struct binder_alloc {
 	bool oneway_spam_detected;
 };
 
-#ifdef CONFIG_ANDROID_BINDER_IPC_SELFTEST
-void binder_selftest_alloc(struct binder_alloc *alloc);
-#else
-static inline void binder_selftest_alloc(struct binder_alloc *alloc) {}
-#endif
 enum lru_status binder_alloc_free_page(struct list_head *item,
 				       struct list_lru_one *lru,
 				       void *cb_arg);
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
deleted file mode 100644
index 8b18b22aa3de..000000000000
--- a/drivers/android/binder_alloc_selftest.c
+++ /dev/null
@@ -1,345 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* binder_alloc_selftest.c
- *
- * Android IPC Subsystem
- *
- * Copyright (C) 2017 Google, Inc.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/err.h>
-#include <linux/list_lru.h>
-#include <linux/mm_types.h>
-#include "binder_alloc.h"
-
-#define BUFFER_NUM 5
-#define BUFFER_MIN_SIZE (PAGE_SIZE / 8)
-
-static bool binder_selftest_run = true;
-static int binder_selftest_failures;
-static DEFINE_MUTEX(binder_selftest_lock);
-static struct list_lru binder_selftest_freelist;
-
-/**
- * enum buf_end_align_type - Page alignment of a buffer
- * end with regard to the end of the previous buffer.
- *
- * In the pictures below, buf2 refers to the buffer we
- * are aligning. buf1 refers to previous buffer by addr.
- * Symbol [ means the start of a buffer, ] means the end
- * of a buffer, and | means page boundaries.
- */
-enum buf_end_align_type {
-	/**
-	 * @SAME_PAGE_UNALIGNED: The end of this buffer is on
-	 * the same page as the end of the previous buffer and
-	 * is not page aligned. Examples:
-	 * buf1 ][ buf2 ][ ...
-	 * buf1 ]|[ buf2 ][ ...
-	 */
-	SAME_PAGE_UNALIGNED = 0,
-	/**
-	 * @SAME_PAGE_ALIGNED: When the end of the previous buffer
-	 * is not page aligned, the end of this buffer is on the
-	 * same page as the end of the previous buffer and is page
-	 * aligned. When the previous buffer is page aligned, the
-	 * end of this buffer is aligned to the next page boundary.
-	 * Examples:
-	 * buf1 ][ buf2 ]| ...
-	 * buf1 ]|[ buf2 ]| ...
-	 */
-	SAME_PAGE_ALIGNED,
-	/**
-	 * @NEXT_PAGE_UNALIGNED: The end of this buffer is on
-	 * the page next to the end of the previous buffer and
-	 * is not page aligned. Examples:
-	 * buf1 ][ buf2 | buf2 ][ ...
-	 * buf1 ]|[ buf2 | buf2 ][ ...
-	 */
-	NEXT_PAGE_UNALIGNED,
-	/**
-	 * @NEXT_PAGE_ALIGNED: The end of this buffer is on
-	 * the page next to the end of the previous buffer and
-	 * is page aligned. Examples:
-	 * buf1 ][ buf2 | buf2 ]| ...
-	 * buf1 ]|[ buf2 | buf2 ]| ...
-	 */
-	NEXT_PAGE_ALIGNED,
-	/**
-	 * @NEXT_NEXT_UNALIGNED: The end of this buffer is on
-	 * the page that follows the page after the end of the
-	 * previous buffer and is not page aligned. Examples:
-	 * buf1 ][ buf2 | buf2 | buf2 ][ ...
-	 * buf1 ]|[ buf2 | buf2 | buf2 ][ ...
-	 */
-	NEXT_NEXT_UNALIGNED,
-	/**
-	 * @LOOP_END: The number of enum values in &buf_end_align_type.
-	 * It is used for controlling loop termination.
-	 */
-	LOOP_END,
-};
-
-static void pr_err_size_seq(size_t *sizes, int *seq)
-{
-	int i;
-
-	pr_err("alloc sizes: ");
-	for (i = 0; i < BUFFER_NUM; i++)
-		pr_cont("[%zu]", sizes[i]);
-	pr_cont("\n");
-	pr_err("free seq: ");
-	for (i = 0; i < BUFFER_NUM; i++)
-		pr_cont("[%d]", seq[i]);
-	pr_cont("\n");
-}
-
-static bool check_buffer_pages_allocated(struct binder_alloc *alloc,
-					 struct binder_buffer *buffer,
-					 size_t size)
-{
-	unsigned long page_addr;
-	unsigned long end;
-	int page_index;
-
-	end = PAGE_ALIGN(buffer->user_data + size);
-	page_addr = buffer->user_data;
-	for (; page_addr < end; page_addr += PAGE_SIZE) {
-		page_index = (page_addr - alloc->vm_start) / PAGE_SIZE;
-		if (!alloc->pages[page_index] ||
-		    !list_empty(page_to_lru(alloc->pages[page_index]))) {
-			pr_err("expect alloc but is %s at page index %d\n",
-			       alloc->pages[page_index] ?
-			       "lru" : "free", page_index);
-			return false;
-		}
-	}
-	return true;
-}
-
-static void binder_selftest_alloc_buf(struct binder_alloc *alloc,
-				      struct binder_buffer *buffers[],
-				      size_t *sizes, int *seq)
-{
-	int i;
-
-	for (i = 0; i < BUFFER_NUM; i++) {
-		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
-		if (IS_ERR(buffers[i]) ||
-		    !check_buffer_pages_allocated(alloc, buffers[i],
-						  sizes[i])) {
-			pr_err_size_seq(sizes, seq);
-			binder_selftest_failures++;
-		}
-	}
-}
-
-static void binder_selftest_free_buf(struct binder_alloc *alloc,
-				     struct binder_buffer *buffers[],
-				     size_t *sizes, int *seq, size_t end)
-{
-	int i;
-
-	for (i = 0; i < BUFFER_NUM; i++)
-		binder_alloc_free_buf(alloc, buffers[seq[i]]);
-
-	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
-		if (list_empty(page_to_lru(alloc->pages[i]))) {
-			pr_err_size_seq(sizes, seq);
-			pr_err("expect lru but is %s at page index %d\n",
-			       alloc->pages[i] ? "alloc" : "free", i);
-			binder_selftest_failures++;
-		}
-	}
-}
-
-static void binder_selftest_free_page(struct binder_alloc *alloc)
-{
-	int i;
-	unsigned long count;
-
-	while ((count = list_lru_count(&binder_selftest_freelist))) {
-		list_lru_walk(&binder_selftest_freelist, binder_alloc_free_page,
-			      NULL, count);
-	}
-
-	for (i = 0; i < (alloc->buffer_size / PAGE_SIZE); i++) {
-		if (alloc->pages[i]) {
-			pr_err("expect free but is %s at page index %d\n",
-			       list_empty(page_to_lru(alloc->pages[i])) ?
-			       "alloc" : "lru", i);
-			binder_selftest_failures++;
-		}
-	}
-}
-
-static void binder_selftest_alloc_free(struct binder_alloc *alloc,
-				       size_t *sizes, int *seq, size_t end)
-{
-	struct binder_buffer *buffers[BUFFER_NUM];
-
-	binder_selftest_alloc_buf(alloc, buffers, sizes, seq);
-	binder_selftest_free_buf(alloc, buffers, sizes, seq, end);
-
-	/* Allocate from lru. */
-	binder_selftest_alloc_buf(alloc, buffers, sizes, seq);
-	if (list_lru_count(&binder_selftest_freelist))
-		pr_err("lru list should be empty but is not\n");
-
-	binder_selftest_free_buf(alloc, buffers, sizes, seq, end);
-	binder_selftest_free_page(alloc);
-}
-
-static bool is_dup(int *seq, int index, int val)
-{
-	int i;
-
-	for (i = 0; i < index; i++) {
-		if (seq[i] == val)
-			return true;
-	}
-	return false;
-}
-
-/* Generate BUFFER_NUM factorial free orders. */
-static void binder_selftest_free_seq(struct binder_alloc *alloc,
-				     size_t *sizes, int *seq,
-				     int index, size_t end)
-{
-	int i;
-
-	if (index == BUFFER_NUM) {
-		binder_selftest_alloc_free(alloc, sizes, seq, end);
-		return;
-	}
-	for (i = 0; i < BUFFER_NUM; i++) {
-		if (is_dup(seq, index, i))
-			continue;
-		seq[index] = i;
-		binder_selftest_free_seq(alloc, sizes, seq, index + 1, end);
-	}
-}
-
-static void binder_selftest_alloc_size(struct binder_alloc *alloc,
-				       size_t *end_offset)
-{
-	int i;
-	int seq[BUFFER_NUM] = {0};
-	size_t front_sizes[BUFFER_NUM];
-	size_t back_sizes[BUFFER_NUM];
-	size_t last_offset, offset = 0;
-
-	for (i = 0; i < BUFFER_NUM; i++) {
-		last_offset = offset;
-		offset = end_offset[i];
-		front_sizes[i] = offset - last_offset;
-		back_sizes[BUFFER_NUM - i - 1] = front_sizes[i];
-	}
-	/*
-	 * Buffers share the first or last few pages.
-	 * Only BUFFER_NUM - 1 buffer sizes are adjustable since
-	 * we need one giant buffer before getting to the last page.
-	 */
-	back_sizes[0] += alloc->buffer_size - end_offset[BUFFER_NUM - 1];
-	binder_selftest_free_seq(alloc, front_sizes, seq, 0,
-				 end_offset[BUFFER_NUM - 1]);
-	binder_selftest_free_seq(alloc, back_sizes, seq, 0, alloc->buffer_size);
-}
-
-static void binder_selftest_alloc_offset(struct binder_alloc *alloc,
-					 size_t *end_offset, int index)
-{
-	int align;
-	size_t end, prev;
-
-	if (index == BUFFER_NUM) {
-		binder_selftest_alloc_size(alloc, end_offset);
-		return;
-	}
-	prev = index == 0 ? 0 : end_offset[index - 1];
-	end = prev;
-
-	BUILD_BUG_ON(BUFFER_MIN_SIZE * BUFFER_NUM >= PAGE_SIZE);
-
-	for (align = SAME_PAGE_UNALIGNED; align < LOOP_END; align++) {
-		if (align % 2)
-			end = ALIGN(end, PAGE_SIZE);
-		else
-			end += BUFFER_MIN_SIZE;
-		end_offset[index] = end;
-		binder_selftest_alloc_offset(alloc, end_offset, index + 1);
-	}
-}
-
-int binder_selftest_alloc_get_page_count(struct binder_alloc *alloc)
-{
-	struct page *page;
-	int allocated = 0;
-	int i;
-
-	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-		page = alloc->pages[i];
-		if (page)
-			allocated++;
-	}
-	return allocated;
-}
-
-/**
- * binder_selftest_alloc() - Test alloc and free of buffer pages.
- * @alloc: Pointer to alloc struct.
- *
- * Allocate BUFFER_NUM buffers to cover all page alignment cases,
- * then free them in all orders possible. Check that pages are
- * correctly allocated, put onto lru when buffers are freed, and
- * are freed when binder_alloc_free_page is called.
- */
-void binder_selftest_alloc(struct binder_alloc *alloc)
-{
-	struct list_lru *prev_freelist;
-	size_t end_offset[BUFFER_NUM];
-
-	if (!binder_selftest_run)
-		return;
-	mutex_lock(&binder_selftest_lock);
-	if (!binder_selftest_run || !alloc->mapped)
-		goto done;
-
-	prev_freelist = alloc->freelist;
-
-	/*
-	 * It is not safe to modify this process's alloc->freelist if it has any
-	 * pages on a freelist. Since the test runs before any binder ioctls can
-	 * be dealt with, none of its pages should be allocated yet.
-	 */
-	if (binder_selftest_alloc_get_page_count(alloc)) {
-		pr_err("process has existing alloc state\n");
-		goto cleanup;
-	}
-
-	if (list_lru_init(&binder_selftest_freelist)) {
-		pr_err("failed to init test freelist\n");
-		goto cleanup;
-	}
-
-	alloc->freelist = &binder_selftest_freelist;
-
-	pr_info("STARTED\n");
-	binder_selftest_alloc_offset(alloc, end_offset, 0);
-	if (binder_selftest_failures > 0)
-		pr_info("%d tests FAILED\n", binder_selftest_failures);
-	else
-		pr_info("PASSED\n");
-
-	if (list_lru_count(&binder_selftest_freelist))
-		pr_err("expect test freelist to be empty\n");
-
-cleanup:
-	/* Even if we didn't run the test, it's no longer thread-safe. */
-	binder_selftest_run = false;
-	alloc->freelist = prev_freelist;
-	list_lru_destroy(&binder_selftest_freelist);
-done:
-	mutex_unlock(&binder_selftest_lock);
-}
diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
index 4b68b5687d33..500b21246c99 100644
--- a/drivers/android/tests/binder_alloc_kunit.c
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -21,6 +21,265 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
 #define BINDER_MMAP_SIZE SZ_128K
 
+#define BUFFER_NUM 5
+#define BUFFER_MIN_SIZE (PAGE_SIZE / 8)
+
+static int binder_alloc_test_failures;
+
+/**
+ * enum buf_end_align_type - Page alignment of a buffer
+ * end with regard to the end of the previous buffer.
+ *
+ * In the pictures below, buf2 refers to the buffer we
+ * are aligning. buf1 refers to previous buffer by addr.
+ * Symbol [ means the start of a buffer, ] means the end
+ * of a buffer, and | means page boundaries.
+ */
+enum buf_end_align_type {
+	/**
+	 * @SAME_PAGE_UNALIGNED: The end of this buffer is on
+	 * the same page as the end of the previous buffer and
+	 * is not page aligned. Examples:
+	 * buf1 ][ buf2 ][ ...
+	 * buf1 ]|[ buf2 ][ ...
+	 */
+	SAME_PAGE_UNALIGNED = 0,
+	/**
+	 * @SAME_PAGE_ALIGNED: When the end of the previous buffer
+	 * is not page aligned, the end of this buffer is on the
+	 * same page as the end of the previous buffer and is page
+	 * aligned. When the previous buffer is page aligned, the
+	 * end of this buffer is aligned to the next page boundary.
+	 * Examples:
+	 * buf1 ][ buf2 ]| ...
+	 * buf1 ]|[ buf2 ]| ...
+	 */
+	SAME_PAGE_ALIGNED,
+	/**
+	 * @NEXT_PAGE_UNALIGNED: The end of this buffer is on
+	 * the page next to the end of the previous buffer and
+	 * is not page aligned. Examples:
+	 * buf1 ][ buf2 | buf2 ][ ...
+	 * buf1 ]|[ buf2 | buf2 ][ ...
+	 */
+	NEXT_PAGE_UNALIGNED,
+	/**
+	 * @NEXT_PAGE_ALIGNED: The end of this buffer is on
+	 * the page next to the end of the previous buffer and
+	 * is page aligned. Examples:
+	 * buf1 ][ buf2 | buf2 ]| ...
+	 * buf1 ]|[ buf2 | buf2 ]| ...
+	 */
+	NEXT_PAGE_ALIGNED,
+	/**
+	 * @NEXT_NEXT_UNALIGNED: The end of this buffer is on
+	 * the page that follows the page after the end of the
+	 * previous buffer and is not page aligned. Examples:
+	 * buf1 ][ buf2 | buf2 | buf2 ][ ...
+	 * buf1 ]|[ buf2 | buf2 | buf2 ][ ...
+	 */
+	NEXT_NEXT_UNALIGNED,
+	/**
+	 * @LOOP_END: The number of enum values in &buf_end_align_type.
+	 * It is used for controlling loop termination.
+	 */
+	LOOP_END,
+};
+
+static void pr_err_size_seq(struct kunit *test, size_t *sizes, int *seq)
+{
+	int i;
+
+	kunit_err(test, "alloc sizes: ");
+	for (i = 0; i < BUFFER_NUM; i++)
+		pr_cont("[%zu]", sizes[i]);
+	pr_cont("\n");
+	kunit_err(test, "free seq: ");
+	for (i = 0; i < BUFFER_NUM; i++)
+		pr_cont("[%d]", seq[i]);
+	pr_cont("\n");
+}
+
+static bool check_buffer_pages_allocated(struct kunit *test,
+					 struct binder_alloc *alloc,
+					 struct binder_buffer *buffer,
+					 size_t size)
+{
+	unsigned long page_addr;
+	unsigned long end;
+	int page_index;
+
+	end = PAGE_ALIGN(buffer->user_data + size);
+	page_addr = buffer->user_data;
+	for (; page_addr < end; page_addr += PAGE_SIZE) {
+		page_index = (page_addr - alloc->vm_start) / PAGE_SIZE;
+		if (!alloc->pages[page_index] ||
+		    !list_empty(page_to_lru(alloc->pages[page_index]))) {
+			kunit_err(test, "expect alloc but is %s at page index %d\n",
+				  alloc->pages[page_index] ?
+				  "lru" : "free", page_index);
+			return false;
+		}
+	}
+	return true;
+}
+
+static void binder_alloc_test_alloc_buf(struct kunit *test,
+					struct binder_alloc *alloc,
+					struct binder_buffer *buffers[],
+					size_t *sizes, int *seq)
+{
+	int i;
+
+	for (i = 0; i < BUFFER_NUM; i++) {
+		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
+		if (IS_ERR(buffers[i]) ||
+		    !check_buffer_pages_allocated(test, alloc, buffers[i], sizes[i])) {
+			pr_err_size_seq(test, sizes, seq);
+			binder_alloc_test_failures++;
+		}
+	}
+}
+
+static void binder_alloc_test_free_buf(struct kunit *test,
+				       struct binder_alloc *alloc,
+				       struct binder_buffer *buffers[],
+				       size_t *sizes, int *seq, size_t end)
+{
+	int i;
+
+	for (i = 0; i < BUFFER_NUM; i++)
+		binder_alloc_free_buf(alloc, buffers[seq[i]]);
+
+	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
+		if (list_empty(page_to_lru(alloc->pages[i]))) {
+			pr_err_size_seq(test, sizes, seq);
+			kunit_err(test, "expect lru but is %s at page index %d\n",
+				  alloc->pages[i] ? "alloc" : "free", i);
+			binder_alloc_test_failures++;
+		}
+	}
+}
+
+static void binder_alloc_test_free_page(struct kunit *test,
+					struct binder_alloc *alloc)
+{
+	unsigned long count;
+	int i;
+
+	while ((count = list_lru_count(alloc->freelist))) {
+		list_lru_walk(alloc->freelist, binder_alloc_free_page,
+			      NULL, count);
+	}
+
+	for (i = 0; i < (alloc->buffer_size / PAGE_SIZE); i++) {
+		if (alloc->pages[i]) {
+			kunit_err(test, "expect free but is %s at page index %d\n",
+				  list_empty(page_to_lru(alloc->pages[i])) ?
+				  "alloc" : "lru", i);
+			binder_alloc_test_failures++;
+		}
+	}
+}
+
+static void binder_alloc_test_alloc_free(struct kunit *test,
+					 struct binder_alloc *alloc,
+					 size_t *sizes, int *seq, size_t end)
+{
+	struct binder_buffer *buffers[BUFFER_NUM];
+
+	binder_alloc_test_alloc_buf(test, alloc, buffers, sizes, seq);
+	binder_alloc_test_free_buf(test, alloc, buffers, sizes, seq, end);
+
+	/* Allocate from lru. */
+	binder_alloc_test_alloc_buf(test, alloc, buffers, sizes, seq);
+	if (list_lru_count(alloc->freelist))
+		kunit_err(test, "lru list should be empty but is not\n");
+
+	binder_alloc_test_free_buf(test, alloc, buffers, sizes, seq, end);
+	binder_alloc_test_free_page(test, alloc);
+}
+
+static bool is_dup(int *seq, int index, int val)
+{
+	int i;
+
+	for (i = 0; i < index; i++) {
+		if (seq[i] == val)
+			return true;
+	}
+	return false;
+}
+
+/* Generate BUFFER_NUM factorial free orders. */
+static void permute_frees(struct kunit *test, struct binder_alloc *alloc,
+			  size_t *sizes, int *seq, int index, size_t end)
+{
+	int i;
+
+	if (index == BUFFER_NUM) {
+		binder_alloc_test_alloc_free(test, alloc, sizes, seq, end);
+		return;
+	}
+	for (i = 0; i < BUFFER_NUM; i++) {
+		if (is_dup(seq, index, i))
+			continue;
+		seq[index] = i;
+		permute_frees(test, alloc, sizes, seq, index + 1, end);
+	}
+}
+
+static void gen_buf_sizes(struct kunit *test, struct binder_alloc *alloc,
+			  size_t *end_offset)
+{
+	size_t last_offset, offset = 0;
+	size_t front_sizes[BUFFER_NUM];
+	size_t back_sizes[BUFFER_NUM];
+	int seq[BUFFER_NUM] = {0};
+	int i;
+
+	for (i = 0; i < BUFFER_NUM; i++) {
+		last_offset = offset;
+		offset = end_offset[i];
+		front_sizes[i] = offset - last_offset;
+		back_sizes[BUFFER_NUM - i - 1] = front_sizes[i];
+	}
+	/*
+	 * Buffers share the first or last few pages.
+	 * Only BUFFER_NUM - 1 buffer sizes are adjustable since
+	 * we need one giant buffer before getting to the last page.
+	 */
+	back_sizes[0] += alloc->buffer_size - end_offset[BUFFER_NUM - 1];
+	permute_frees(test, alloc, front_sizes, seq, 0,
+		      end_offset[BUFFER_NUM - 1]);
+	permute_frees(test, alloc, back_sizes, seq, 0, alloc->buffer_size);
+}
+
+static void gen_buf_offsets(struct kunit *test, struct binder_alloc *alloc,
+			    size_t *end_offset, int index)
+{
+	size_t end, prev;
+	int align;
+
+	if (index == BUFFER_NUM) {
+		gen_buf_sizes(test, alloc, end_offset);
+		return;
+	}
+	prev = index == 0 ? 0 : end_offset[index - 1];
+	end = prev;
+
+	BUILD_BUG_ON(BUFFER_MIN_SIZE * BUFFER_NUM >= PAGE_SIZE);
+
+	for (align = SAME_PAGE_UNALIGNED; align < LOOP_END; align++) {
+		if (align % 2)
+			end = ALIGN(end, PAGE_SIZE);
+		else
+			end += BUFFER_MIN_SIZE;
+		end_offset[index] = end;
+		gen_buf_offsets(test, alloc, end_offset, index + 1);
+	}
+}
+
 struct binder_alloc_test {
 	struct binder_alloc alloc;
 	struct list_lru binder_test_freelist;
@@ -56,6 +315,24 @@ static void binder_alloc_test_mmap(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_is_last(&buf->entry, &alloc->buffers));
 }
 
+/**
+ * binder_alloc_exhaustive_test() - Exhaustively test alloc and free of buffer pages.
+ *
+ * Allocate BUFFER_NUM buffers to cover all page alignment cases,
+ * then free them in all orders possible. Check that pages are
+ * correctly allocated, put onto lru when buffers are freed, and
+ * are freed when binder_alloc_free_page() is called.
+ */
+static void binder_alloc_exhaustive_test(struct kunit *test)
+{
+	struct binder_alloc_test *priv = test->priv;
+	size_t end_offset[BUFFER_NUM];
+
+	gen_buf_offsets(test, &priv->alloc, end_offset, 0);
+
+	KUNIT_EXPECT_EQ(test, binder_alloc_test_failures, 0);
+}
+
 /* ===== End test cases ===== */
 
 static void binder_alloc_test_vma_close(struct vm_area_struct *vma)
@@ -149,6 +426,7 @@ static void binder_alloc_test_exit(struct kunit *test)
 static struct kunit_case binder_alloc_test_cases[] = {
 	KUNIT_CASE(binder_alloc_test_init_freelist),
 	KUNIT_CASE(binder_alloc_test_mmap),
+	KUNIT_CASE(binder_alloc_exhaustive_test),
 	{}
 };
 
-- 
2.50.0.727.gbf7dc18ff4-goog


