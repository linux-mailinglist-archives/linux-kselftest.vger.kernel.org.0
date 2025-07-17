Return-Path: <linux-kselftest+bounces-37464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DAB08221
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 03:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940835838D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 01:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604C1F130B;
	Thu, 17 Jul 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xClBLbWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C061CEAB2
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714644; cv=none; b=nOTHOAX+XGFuII1jnUYiaII2mv5apIZAKZDrJ1ZYdY/PzieDgvYe0TZT+l8xDbbsbI78pmMJZuKnFpfIr4wYLq12Edt76bqxahC3TfB+REJQQQUGo/sCVCLqm3s+7ceazF+lAbzFq6cJa+6t1KjsInGQoq6zUKrudJwGabYygLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714644; c=relaxed/simple;
	bh=gVjRcz8uf6Zvb6Qsl4X7UhIgb0DNmTUTLZ2nEa9VguQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FSayBfKJBoXjTMYdKBa4bi9EG/0GpXi2zcxQkpeIANtMQnrTRajUboHWoPPbkBhgEARbAWz7rQk6Wt/Dgchblbr5w/DYm5Rt1VefKFoGZA0uxVaABC30s92g0ofUtN1zojI/GtuWxS80TNHd3PULbuE1AynH1ximzedefr5Nf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xClBLbWD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b321087b1cdso401148a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 18:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752714641; x=1753319441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWnQRxNCBI5smoClGNV2WoMDHzg2Ry+I5lkI2YBnPkQ=;
        b=xClBLbWDHrVj3n6nq2dO41LPg6tjZJ0l6tgEHNMIGRXtTiLH7v7pqIC36JEhmOVfvK
         z4DV3yZf0adqCIDQ9qpA/WSmuFYymBLfhycr1bwObYB2SNv7LzSARS1XFSJVFnMYUCU2
         pJ5pyiiY09aVV9YVhHEWh0XAe2QyrKw1skcLncYCs6YXGKhUi6lcz+BrJPTHF1TulgL2
         w0sxBdppnbo52/LT4z2FAdWGqMgxhCMCKhRGK2bA/6JMyiRZL28x9Qseu3VF00eykBS+
         GJLFoEViVhajU9WPXBC7Vc6MMRDU63N+aMJdrDeAIYBc7kZ9TmNo15ulVlTPo5QmOYcG
         Tb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714641; x=1753319441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWnQRxNCBI5smoClGNV2WoMDHzg2Ry+I5lkI2YBnPkQ=;
        b=cowc7VmdQLHxwOoUlynPIN6pfZIdNxdZCcJrrJ/b3iuhU9OCS6r/NvtzxSmlX817Vy
         yWEVNMIEKE/fsQh/bVcKfmSc2gULRtHX6AvMlJ2CrgRpzdg6z73S6LovZXAKU8UTBi1J
         nA/7SXGT7GEnxbLE0BExQkPk7nAc6goVQLjO3bkAxifYmOlMOmVmVQYWKHbIo6pBAaJa
         +FPzguen2ulC/GUt3Kps+IAGA4Dx0wmVFvpdZ9RMV9lHMfD/Xc58eqN+sNu5q0uk9S7I
         s+N5yLCdo7c/mksjCYZIku3NU4nTqjXo9AMlI8WCxoFpNUJXhdBh6YDfDaEas5NtLQ0y
         ZAqA==
X-Forwarded-Encrypted: i=1; AJvYcCUIwaaptMe4sym+Vy/2RCVM25rRmrRjDduNHxiUh03W+LMWw9OTEdJe3Qz/y8Zc6guXWQnKvpMuayp2cwYATH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJEHu21C0W12qrW8Xi3pi7PAPoKFIAkHVwt/fymZ7yOJIfl+B
	+N4EQiGVuL3qB8YVsJ/jmdRbSuTk5L6hC0mQbJEdbmKYWM6Bz2TU+/k6CCljc/rKjKwY2roBd+n
	cxyeuInCyXA==
X-Google-Smtp-Source: AGHT+IEpbUWvUFEJYbDyCmd3R9Df4nrfFgF0AMHrQKS+Vp6pVqfn6MISuxEsOLiO//CrBDoxCfHNqPtyGmXE
X-Received: from pgbi37.prod.google.com ([2002:a63:5425:0:b0:b1f:fd39:8314])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d07:b0:234:8b24:108d
 with SMTP id adf61e73a8af0-23812947ebamr7492831637.22.1752714641247; Wed, 16
 Jul 2025 18:10:41 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:10:09 -0700
In-Reply-To: <20250717011011.3365074-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717011011.3365074-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717011011.3365074-7-ynaffit@google.com>
Subject: [PATCH v4 6/6] binder: encapsulate individual alloc test cases
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Each case tested by the binder allocator test is defined by 3 parameters:
the end alignment type of each requested buffer allocation, whether those
buffers share the front or back pages of the allotted address space, and
the order in which those buffers should be released. The alignment type
represents how a binder buffer may be laid out within or across page
boundaries and relative to other buffers, and it's used along with
whether the buffers cover part (sharing the front pages) of or all
(sharing the back pages) of the vma to calculate the sizes passed into
each test.

binder_alloc_test_alloc recursively generates each possible arrangement
of alignment types and then tests that the binder_alloc code tracks pages
correctly when those buffers are allocated and then freed in every
possible order at both ends of the address space. While they provide
comprehensive coverage, they are poor candidates to be represented as
KUnit test cases, which must be statically enumerated. For 5 buffers and
5 end alignment types, the test case array would have 750,000 entries.
This change structures the recursive calls into meaningful test cases so
that failures are easier to interpret.

Cc: Kees Cook <kees@kernel.org>
Acked-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
v2:
* Fix build warning Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202506281959.hfOTIUjS-lkp@intel.com/
v4:
* Replace snprintf with seq_buf functions
* Collected tag
---
 drivers/android/tests/binder_alloc_kunit.c | 226 ++++++++++++++++-----
 1 file changed, 175 insertions(+), 51 deletions(-)

diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
index 2f6077e96ae6..9b884d977f76 100644
--- a/drivers/android/tests/binder_alloc_kunit.c
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/seq_buf.h>
 #include <linux/sizes.h>
 
 #include "../binder_alloc.h"
@@ -27,7 +28,16 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 #define BUFFER_NUM 5
 #define BUFFER_MIN_SIZE (PAGE_SIZE / 8)
 
-static int binder_alloc_test_failures;
+#define FREESEQ_BUFLEN ((3 * BUFFER_NUM) + 1)
+
+#define ALIGN_TYPE_STRLEN (12)
+
+#define ALIGNMENTS_BUFLEN (((ALIGN_TYPE_STRLEN + 6) * BUFFER_NUM) + 1)
+
+#define PRINT_ALL_CASES (0)
+
+/* 5^5 alignment combinations * 2 places to share pages * 5! free sequences */
+#define TOTAL_EXHAUSTIVE_CASES (3125 * 2 * 120)
 
 /**
  * enum buf_end_align_type - Page alignment of a buffer
@@ -89,18 +99,42 @@ enum buf_end_align_type {
 	LOOP_END,
 };
 
-static void pr_err_size_seq(struct kunit *test, size_t *sizes, int *seq)
+static const char *const buf_end_align_type_strs[LOOP_END] = {
+	[SAME_PAGE_UNALIGNED] = "SP_UNALIGNED",
+	[SAME_PAGE_ALIGNED]   = " SP_ALIGNED ",
+	[NEXT_PAGE_UNALIGNED] = "NP_UNALIGNED",
+	[NEXT_PAGE_ALIGNED]   = " NP_ALIGNED ",
+	[NEXT_NEXT_UNALIGNED] = "NN_UNALIGNED",
+};
+
+struct binder_alloc_test_case_info {
+	char alignments[ALIGNMENTS_BUFLEN];
+	struct seq_buf alignments_sb;
+	size_t *buffer_sizes;
+	int *free_sequence;
+	bool front_pages;
+};
+
+static void stringify_free_seq(struct kunit *test, int *seq, struct seq_buf *sb)
 {
 	int i;
 
-	kunit_err(test, "alloc sizes: ");
 	for (i = 0; i < BUFFER_NUM; i++)
-		pr_cont("[%zu]", sizes[i]);
-	pr_cont("\n");
-	kunit_err(test, "free seq: ");
+		seq_buf_printf(sb, "[%d]", seq[i]);
+
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(sb));
+}
+
+static void stringify_alignments(struct kunit *test, int *alignments,
+				 struct seq_buf *sb)
+{
+	int i;
+
 	for (i = 0; i < BUFFER_NUM; i++)
-		pr_cont("[%d]", seq[i]);
-	pr_cont("\n");
+		seq_buf_printf(sb, "[ %d:%s ]", i,
+			       buf_end_align_type_strs[alignments[i]]);
+
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(sb));
 }
 
 static bool check_buffer_pages_allocated(struct kunit *test,
@@ -127,28 +161,30 @@ static bool check_buffer_pages_allocated(struct kunit *test,
 	return true;
 }
 
-static void binder_alloc_test_alloc_buf(struct kunit *test,
-					struct binder_alloc *alloc,
-					struct binder_buffer *buffers[],
-					size_t *sizes, int *seq)
+static unsigned long binder_alloc_test_alloc_buf(struct kunit *test,
+						 struct binder_alloc *alloc,
+						 struct binder_buffer *buffers[],
+						 size_t *sizes, int *seq)
 {
+	unsigned long failures = 0;
 	int i;
 
 	for (i = 0; i < BUFFER_NUM; i++) {
 		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
 		if (IS_ERR(buffers[i]) ||
-		    !check_buffer_pages_allocated(test, alloc, buffers[i], sizes[i])) {
-			pr_err_size_seq(test, sizes, seq);
-			binder_alloc_test_failures++;
-		}
+		    !check_buffer_pages_allocated(test, alloc, buffers[i], sizes[i]))
+			failures++;
 	}
+
+	return failures;
 }
 
-static void binder_alloc_test_free_buf(struct kunit *test,
-				       struct binder_alloc *alloc,
-				       struct binder_buffer *buffers[],
-				       size_t *sizes, int *seq, size_t end)
+static unsigned long binder_alloc_test_free_buf(struct kunit *test,
+						struct binder_alloc *alloc,
+						struct binder_buffer *buffers[],
+						size_t *sizes, int *seq, size_t end)
 {
+	unsigned long failures = 0;
 	int i;
 
 	for (i = 0; i < BUFFER_NUM; i++)
@@ -156,17 +192,19 @@ static void binder_alloc_test_free_buf(struct kunit *test,
 
 	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
 		if (list_empty(page_to_lru(alloc->pages[i]))) {
-			pr_err_size_seq(test, sizes, seq);
 			kunit_err(test, "expect lru but is %s at page index %d\n",
 				  alloc->pages[i] ? "alloc" : "free", i);
-			binder_alloc_test_failures++;
+			failures++;
 		}
 	}
+
+	return failures;
 }
 
-static void binder_alloc_test_free_page(struct kunit *test,
-					struct binder_alloc *alloc)
+static unsigned long binder_alloc_test_free_page(struct kunit *test,
+						 struct binder_alloc *alloc)
 {
+	unsigned long failures = 0;
 	unsigned long count;
 	int i;
 
@@ -180,27 +218,70 @@ static void binder_alloc_test_free_page(struct kunit *test,
 			kunit_err(test, "expect free but is %s at page index %d\n",
 				  list_empty(page_to_lru(alloc->pages[i])) ?
 				  "alloc" : "lru", i);
-			binder_alloc_test_failures++;
+			failures++;
 		}
 	}
+
+	return failures;
 }
 
-static void binder_alloc_test_alloc_free(struct kunit *test,
+/* Executes one full test run for the given test case. */
+static bool binder_alloc_test_alloc_free(struct kunit *test,
 					 struct binder_alloc *alloc,
-					 size_t *sizes, int *seq, size_t end)
+					 struct binder_alloc_test_case_info *tc,
+					 size_t end)
 {
+	unsigned long pages = PAGE_ALIGN(end) / PAGE_SIZE;
 	struct binder_buffer *buffers[BUFFER_NUM];
-
-	binder_alloc_test_alloc_buf(test, alloc, buffers, sizes, seq);
-	binder_alloc_test_free_buf(test, alloc, buffers, sizes, seq, end);
+	unsigned long failures;
+	bool failed = false;
+
+	failures = binder_alloc_test_alloc_buf(test, alloc, buffers,
+					       tc->buffer_sizes,
+					       tc->free_sequence);
+	failed = failed || failures;
+	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
+			    "Initial allocation failed: %lu/%u buffers with errors",
+			    failures, BUFFER_NUM);
+
+	failures = binder_alloc_test_free_buf(test, alloc, buffers,
+					      tc->buffer_sizes,
+					      tc->free_sequence, end);
+	failed = failed || failures;
+	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
+			    "Initial buffers not freed correctly: %lu/%lu pages not on lru list",
+			    failures, pages);
 
 	/* Allocate from lru. */
-	binder_alloc_test_alloc_buf(test, alloc, buffers, sizes, seq);
-	if (list_lru_count(alloc->freelist))
-		kunit_err(test, "lru list should be empty but is not\n");
-
-	binder_alloc_test_free_buf(test, alloc, buffers, sizes, seq, end);
-	binder_alloc_test_free_page(test, alloc);
+	failures = binder_alloc_test_alloc_buf(test, alloc, buffers,
+					       tc->buffer_sizes,
+					       tc->free_sequence);
+	failed = failed || failures;
+	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
+			    "Reallocation failed: %lu/%u buffers with errors",
+			    failures, BUFFER_NUM);
+
+	failures = list_lru_count(alloc->freelist);
+	failed = failed || failures;
+	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
+			    "lru list should be empty after reallocation but still has %lu pages",
+			    failures);
+
+	failures = binder_alloc_test_free_buf(test, alloc, buffers,
+					      tc->buffer_sizes,
+					      tc->free_sequence, end);
+	failed = failed || failures;
+	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
+			    "Reallocated buffers not freed correctly: %lu/%lu pages not on lru list",
+			    failures, pages);
+
+	failures = binder_alloc_test_free_page(test, alloc);
+	failed = failed || failures;
+	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
+			    "Failed to clean up allocated pages: %lu/%lu pages still installed",
+			    failures, (alloc->buffer_size / PAGE_SIZE));
+
+	return failed;
 }
 
 static bool is_dup(int *seq, int index, int val)
@@ -216,24 +297,45 @@ static bool is_dup(int *seq, int index, int val)
 
 /* Generate BUFFER_NUM factorial free orders. */
 static void permute_frees(struct kunit *test, struct binder_alloc *alloc,
-			  size_t *sizes, int *seq, int index, size_t end)
+			  struct binder_alloc_test_case_info *tc,
+			  unsigned long *runs, unsigned long *failures,
+			  int index, size_t end)
 {
+	bool case_failed;
 	int i;
 
 	if (index == BUFFER_NUM) {
-		binder_alloc_test_alloc_free(test, alloc, sizes, seq, end);
+		DECLARE_SEQ_BUF(freeseq_sb, FREESEQ_BUFLEN);
+
+		case_failed = binder_alloc_test_alloc_free(test, alloc, tc, end);
+		*runs += 1;
+		*failures += case_failed;
+
+		if (case_failed || PRINT_ALL_CASES) {
+			stringify_free_seq(test, tc->free_sequence,
+					   &freeseq_sb);
+			kunit_err(test, "case %lu: [%s] | %s - %s - %s", *runs,
+				  case_failed ? "FAILED" : "PASSED",
+				  tc->front_pages ? "front" : "back ",
+				  seq_buf_str(&tc->alignments_sb),
+				  seq_buf_str(&freeseq_sb));
+		}
+
 		return;
 	}
 	for (i = 0; i < BUFFER_NUM; i++) {
-		if (is_dup(seq, index, i))
+		if (is_dup(tc->free_sequence, index, i))
 			continue;
-		seq[index] = i;
-		permute_frees(test, alloc, sizes, seq, index + 1, end);
+		tc->free_sequence[index] = i;
+		permute_frees(test, alloc, tc, runs, failures, index + 1, end);
 	}
 }
 
-static void gen_buf_sizes(struct kunit *test, struct binder_alloc *alloc,
-			  size_t *end_offset)
+static void gen_buf_sizes(struct kunit *test,
+			  struct binder_alloc *alloc,
+			  struct binder_alloc_test_case_info *tc,
+			  size_t *end_offset, unsigned long *runs,
+			  unsigned long *failures)
 {
 	size_t last_offset, offset = 0;
 	size_t front_sizes[BUFFER_NUM];
@@ -241,31 +343,46 @@ static void gen_buf_sizes(struct kunit *test, struct binder_alloc *alloc,
 	int seq[BUFFER_NUM] = {0};
 	int i;
 
+	tc->free_sequence = seq;
 	for (i = 0; i < BUFFER_NUM; i++) {
 		last_offset = offset;
 		offset = end_offset[i];
 		front_sizes[i] = offset - last_offset;
 		back_sizes[BUFFER_NUM - i - 1] = front_sizes[i];
 	}
+	back_sizes[0] += alloc->buffer_size - end_offset[BUFFER_NUM - 1];
+
 	/*
 	 * Buffers share the first or last few pages.
 	 * Only BUFFER_NUM - 1 buffer sizes are adjustable since
 	 * we need one giant buffer before getting to the last page.
 	 */
-	back_sizes[0] += alloc->buffer_size - end_offset[BUFFER_NUM - 1];
-	permute_frees(test, alloc, front_sizes, seq, 0,
+	tc->front_pages = true;
+	tc->buffer_sizes = front_sizes;
+	permute_frees(test, alloc, tc, runs, failures, 0,
 		      end_offset[BUFFER_NUM - 1]);
-	permute_frees(test, alloc, back_sizes, seq, 0, alloc->buffer_size);
+
+	tc->front_pages = false;
+	tc->buffer_sizes = back_sizes;
+	permute_frees(test, alloc, tc, runs, failures, 0, alloc->buffer_size);
 }
 
 static void gen_buf_offsets(struct kunit *test, struct binder_alloc *alloc,
-			    size_t *end_offset, int index)
+			    size_t *end_offset, int *alignments,
+			    unsigned long *runs, unsigned long *failures,
+			    int index)
 {
 	size_t end, prev;
 	int align;
 
 	if (index == BUFFER_NUM) {
-		gen_buf_sizes(test, alloc, end_offset);
+		struct binder_alloc_test_case_info tc = {0};
+
+		seq_buf_init(&tc.alignments_sb, tc.alignments,
+			     ALIGNMENTS_BUFLEN);
+		stringify_alignments(test, alignments, &tc.alignments_sb);
+
+		gen_buf_sizes(test, alloc, &tc, end_offset, runs, failures);
 		return;
 	}
 	prev = index == 0 ? 0 : end_offset[index - 1];
@@ -279,7 +396,9 @@ static void gen_buf_offsets(struct kunit *test, struct binder_alloc *alloc,
 		else
 			end += BUFFER_MIN_SIZE;
 		end_offset[index] = end;
-		gen_buf_offsets(test, alloc, end_offset, index + 1);
+		alignments[index] = align;
+		gen_buf_offsets(test, alloc, end_offset, alignments, runs,
+				failures, index + 1);
 	}
 }
 
@@ -331,10 +450,15 @@ static void binder_alloc_exhaustive_test(struct kunit *test)
 {
 	struct binder_alloc_test *priv = test->priv;
 	size_t end_offset[BUFFER_NUM];
+	int alignments[BUFFER_NUM];
+	unsigned long failures = 0;
+	unsigned long runs = 0;
 
-	gen_buf_offsets(test, &priv->alloc, end_offset, 0);
+	gen_buf_offsets(test, &priv->alloc, end_offset, alignments, &runs,
+			&failures, 0);
 
-	KUNIT_EXPECT_EQ(test, binder_alloc_test_failures, 0);
+	KUNIT_EXPECT_EQ(test, runs, TOTAL_EXHAUSTIVE_CASES);
+	KUNIT_EXPECT_EQ(test, failures, 0);
 }
 
 /* ===== End test cases ===== */
-- 
2.50.0.727.gbf7dc18ff4-goog


