Return-Path: <linux-kselftest+bounces-36240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 360CEAF07BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E1E4E12BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 01:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843AC14A62B;
	Wed,  2 Jul 2025 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKymX8KG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57391369B4
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418343; cv=none; b=uswivDQVpVi6Asvrj9VUa2GD4689LjcVvUSfXqktxUvYwb+I/YDwbwjHm1WpiUv3zmp65PzRSysEtwbVyGu9fp9hoouTOBRnNqKlSqSZi/On+0P7GsUsW+01AjhHTeXyG5CZ/M5SDPN0IkdP+zAYA7dRc7V8+SwSzLQuYZ+z/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418343; c=relaxed/simple;
	bh=f2UjTPl4HUGhaJZGvJzyLZ61geaJfkxh73V9CoWdrVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mD1ee0huutV7Kn+ixWwFE9yzC0cOzhsQW78RKXMVLyCOUVTCjniI5wzeR3V4IUCB63ZI/HztpnehC/odK4MLknixaKb2SxHSezYRk7KcRYe7MAGWkDlu92+sCBOZjn2FUqlM5+xzJxzRpKyui+kVRK3BKYm1IRLTMo8NUrV9Qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKymX8KG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7494999de28so8890085b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 18:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751418341; x=1752023141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/pcrYvaU6t8T3R2xq0AsGjXqPB0jvdSPEGz2fSJtgo=;
        b=mKymX8KG/TsADw9rQANNgx4O04IItLsIxbZr73MeowEK/ivhYqKqOD6CgzIfHiZerC
         WLi0oJ+/VQsUy2ecPG5840a2OfDhUX5MB9Zeo65NF+MsHGpNURA+hbkQQAye/JwWEODL
         RRXo38QSXacAxyPVBuyuIvbbP0954LdvDdQFtgwRdDtdvqN1F27axJCjbWnqiaij0JO6
         zoAFTun7BG5LZJjaGWePwmapEuHOC2n+70TvzgTrudr3u3sst9oMj772n/b3S2xbY+i+
         DJ+lHdUogvEkJ+rIflFWa2ke7pmZqFV5eGaTPEOpC2+xmwW11SFxKGQ23saRYnS0SUtl
         KREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418341; x=1752023141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/pcrYvaU6t8T3R2xq0AsGjXqPB0jvdSPEGz2fSJtgo=;
        b=M4nbTew8XNQT3U8kZG1tKHr8R/d1hp/b8xgJuOub2ZI/KTbn4WjEal1ZNQ3XK12ANN
         4uid1PzC7Eujf+PQtCjo+kr6jbJn7EfSsp0PsKiMLlNkJqhidHGtB76V9dX10pxJoPEZ
         /VLFHLkPc/bHGMB999XS2nzr+lZnat/FZ9igK+XRswn/N12bvsDAEpYkc+fKb9eOMzNt
         YHsNijysEIQXwSP6//wY+tLEgFXRQdjfPZivp86lyt8yTaDodZdrmLKKs1V3vyDMX87R
         9h3/3A1OGTXFNkDaf7UYo92CftjNxAchzAbvMdQ1LpsWF1CPU0hnZKOBSAHHk5CL54bc
         emfA==
X-Forwarded-Encrypted: i=1; AJvYcCWMcv3R9c28bHPo7JtXO3BMWJVJ6tXV5RimFmyBq3JNFviNM1/24ylhr02muaWkQmDPg/C0gFHhWJ/PAgCWkwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBZH9WbfAq/P7agas+TJ9iuZtXOCpUojcpmvacNXsoS2BFjVz
	3uhimITFZopM15wNOI5QjA/P0SNZwXNct+4NM0tblF6j9IkquExSUjZqpGIs06Y4v0bCq4ixuCe
	gE+t9Ctz/IQ==
X-Google-Smtp-Source: AGHT+IG5NLCTHeOaDLRDPmmOHIoEu82NGYVy1EMlQGWadW+vYXwIaO+BajMV3PWLuKbGBx45Tays0awo8y1u
X-Received: from pfqn28.prod.google.com ([2002:aa7:985c:0:b0:746:1fcb:a9cc])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0a:b0:1f5:717b:46dc
 with SMTP id adf61e73a8af0-222d7e8389amr1975822637.27.1751418340836; Tue, 01
 Jul 2025 18:05:40 -0700 (PDT)
Date: Tue,  1 Jul 2025 18:04:45 -0700
In-Reply-To: <20250702010447.2994412-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702010447.2994412-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702010447.2994412-6-ynaffit@google.com>
Subject: [PATCH v2 5/5] binder: encapsulate individual alloc test cases
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

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
v2:
* Fix build warning Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202506281959.hfOTIUjS-lkp@intel.com/
---
 drivers/android/tests/binder_alloc_kunit.c | 234 ++++++++++++++++-----
 1 file changed, 181 insertions(+), 53 deletions(-)

diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
index 9e185e2036e5..02aa4a135eb5 100644
--- a/drivers/android/tests/binder_alloc_kunit.c
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -24,7 +24,16 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
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
@@ -86,18 +95,49 @@ enum buf_end_align_type {
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
+	size_t *buffer_sizes;
+	int *free_sequence;
+	char alignments[ALIGNMENTS_BUFLEN];
+	bool front_pages;
+};
+
+static void stringify_free_seq(struct kunit *test, int *seq, char *buf,
+			       size_t buf_len)
 {
+	size_t bytes = 0;
 	int i;
 
-	kunit_err(test, "alloc sizes: ");
-	for (i = 0; i < BUFFER_NUM; i++)
-		pr_cont("[%zu]", sizes[i]);
-	pr_cont("\n");
-	kunit_err(test, "free seq: ");
-	for (i = 0; i < BUFFER_NUM; i++)
-		pr_cont("[%d]", seq[i]);
-	pr_cont("\n");
+	for (i = 0; i < BUFFER_NUM; i++) {
+		bytes += snprintf(buf + bytes, buf_len - bytes, "[%d]", seq[i]);
+		if (bytes >= buf_len)
+			break;
+	}
+	KUNIT_EXPECT_LT(test, bytes, buf_len);
+}
+
+static void stringify_alignments(struct kunit *test, int *alignments,
+				 char *buf, size_t buf_len)
+{
+	size_t bytes = 0;
+	int i;
+
+	for (i = 0; i < BUFFER_NUM; i++) {
+		bytes += snprintf(buf + bytes, buf_len - bytes, "[ %d:%s ]", i,
+				  buf_end_align_type_strs[alignments[i]]);
+		if (bytes >= buf_len)
+			break;
+	}
+
+	KUNIT_EXPECT_LT(test, bytes, buf_len);
 }
 
 static bool check_buffer_pages_allocated(struct kunit *test,
@@ -124,28 +164,30 @@ static bool check_buffer_pages_allocated(struct kunit *test,
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
@@ -153,17 +195,19 @@ static void binder_alloc_test_free_buf(struct kunit *test,
 
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
 
@@ -177,27 +221,70 @@ static void binder_alloc_test_free_page(struct kunit *test,
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
@@ -213,24 +300,44 @@ static bool is_dup(int *seq, int index, int val)
 
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
+		char freeseq_buf[FREESEQ_BUFLEN];
+
+		case_failed = binder_alloc_test_alloc_free(test, alloc, tc, end);
+		*runs += 1;
+		*failures += case_failed;
+
+		if (case_failed || PRINT_ALL_CASES) {
+			stringify_free_seq(test, tc->free_sequence, freeseq_buf,
+					   FREESEQ_BUFLEN);
+			kunit_err(test, "case %lu: [%s] | %s - %s - %s", *runs,
+				  case_failed ? "FAILED" : "PASSED",
+				  tc->front_pages ? "front" : "back ",
+				  tc->alignments, freeseq_buf);
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
@@ -238,31 +345,45 @@ static void gen_buf_sizes(struct kunit *test, struct binder_alloc *alloc,
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
+		stringify_alignments(test, alignments, tc.alignments,
+				     ALIGNMENTS_BUFLEN);
+
+		gen_buf_sizes(test, alloc, &tc, end_offset, runs, failures);
 		return;
 	}
 	prev = index == 0 ? 0 : end_offset[index - 1];
@@ -276,7 +397,9 @@ static void gen_buf_offsets(struct kunit *test, struct binder_alloc *alloc,
 		else
 			end += BUFFER_MIN_SIZE;
 		end_offset[index] = end;
-		gen_buf_offsets(test, alloc, end_offset, index + 1);
+		alignments[index] = align;
+		gen_buf_offsets(test, alloc, end_offset, alignments, runs,
+				failures, index + 1);
 	}
 }
 
@@ -328,10 +451,15 @@ static void binder_alloc_exhaustive_test(struct kunit *test)
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


