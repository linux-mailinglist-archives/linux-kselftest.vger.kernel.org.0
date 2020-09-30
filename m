Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4287827F501
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 00:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgI3WVr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 18:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgI3WVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 18:21:47 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB7C061755
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:21:47 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w3so2224999qtn.16
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=XbvI12WaHJN29uXJhtZ+EOB9wipW/gZZ4hVhoy3A3pk=;
        b=P+s7piSRTOYlMasrhJ2oHEQPHoelb8iyusd1TAd6av+DBZjV3mCsezsGb0aM8Cbq8F
         wcWniTz7nt0cgEMZzRfuoQ9pfRQazas3/PsqYjDs/NBqewHVQbn3A9FR3YF5x8RLQ+yX
         jcg16G459PC61aytMKkZj8myAxNaZIkOeqF5C6gBGdEB4NIfzn9r9+I4XIjXfWBQTRL9
         nS21h4UueeuQ2VbqCnuA3kMG+4TjoDJl/gd2FxnZTiVHWLNyDBQ+8gxZZrGH2WQCMMeD
         XR49bF8yCpSjBarMyiS0KGX73IcaryYShv5dSNVrdWlHauwdqr5/O7le3VC/vIKhaCKe
         Hxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=XbvI12WaHJN29uXJhtZ+EOB9wipW/gZZ4hVhoy3A3pk=;
        b=Kg9uIx5OC4RrirbmmmSC5rNqTqbpVBXO5KRVbUYjowg8mZ4w2JJHaiazkKN/1WRFuU
         LlDzDkLCKtOQzSkGwI74/tJbwVxtbpvD5247xRNbNgC8elgxsa6BROmkQHuem9RIBlfo
         TgzJsSMzH0ibZD+rmpdmhax58EujCV4h2yY47dmDSSP2lvi4f0Yfr+Jko7/+qV6/t/bR
         SBlnidmVFleNMwgYbA4GN4y3+D/nDj0B4s7fOmKJ50gtUEi45aPoZEr44ZzDAKab7PA+
         zm1vUoYXVqZ4Oq6x1f0ohmULmzEv/Ebx8txVSxbp12KYGH5IyTMompvi9vPpfxGUNG91
         BBOQ==
X-Gm-Message-State: AOAM530FqcZgZitWrWrDbw+sZRgdHjBaOI+9uIMVn2AzFzstI0bT8CGo
        hUWs4u4QXgcWUEUB+haPRu4cgALjXQmmvJfEmQ==
X-Google-Smtp-Source: ABdhPJwwSEexZldCHo9VW8lyUDwdXeRxfa1mYE1k7wqr1xRB7FpnAJwFMYg556it3BiSNrrerzkgakSQGznEqtJ0mQ==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:9d03:: with SMTP id
 m3mr4759136qvf.54.1601504506102; Wed, 30 Sep 2020 15:21:46 -0700 (PDT)
Date:   Wed, 30 Sep 2020 22:21:18 +0000
In-Reply-To: <20200930222130.4175584-1-kaleshsingh@google.com>
Message-Id: <20200930222130.4175584-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 1/5] kselftests: vm: Add mremap tests
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>, Jia He <justin.he@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Zi Yan <ziy@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test mremap on regions of various sizes and alignments and validate
data after remapping. Also provide total time for remapping
the region which is useful for performance comparison of the mremap
optimizations that move pages at the PMD/PUD levels if HAVE_MOVE_PMD
and/or HAVE_MOVE_PUD are enabled.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 tools/testing/selftests/vm/.gitignore    |   1 +
 tools/testing/selftests/vm/Makefile      |   1 +
 tools/testing/selftests/vm/mremap_test.c | 243 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests   |  11 +
 4 files changed, 256 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mremap_test.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 849e8226395a..b3a183c36cb5 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -8,6 +8,7 @@ thuge-gen
 compaction_test
 mlock2-tests
 mremap_dontunmap
+mremap_test
 on-fault-limit
 transhuge-stress
 protection_keys
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index a9026706d597..f044808b45fa 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -16,6 +16,7 @@ TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
 TEST_GEN_FILES += mremap_dontunmap
+TEST_GEN_FILES += mremap_test
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
new file mode 100644
index 000000000000..09dc9a1ef81f
--- /dev/null
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 Google LLC
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <time.h>
+
+#include "../kselftest.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+struct config {
+	unsigned long long src_alignment;
+	unsigned long long dest_alignment;
+	unsigned long long region_size;
+	int overlapping;
+};
+
+struct test {
+	const char *name;
+	struct config config;
+	int expect_failure;
+};
+
+enum {
+	_1KB = 1ULL << 10,	/* 1KB -> not page aligned */
+	_4KB = 4ULL << 10,
+	_8KB = 8ULL << 10,
+	_1MB = 1ULL << 20,
+	_2MB = 2ULL << 20,
+	_4MB = 4ULL << 20,
+	_1GB = 1ULL << 30,
+	_2GB = 2ULL << 30,
+	PTE = _4KB,
+	PMD = _2MB,
+	PUD = _1GB,
+};
+
+#define MAKE_TEST(source_align, destination_align, size,	\
+		  overlaps, should_fail, test_name)		\
+{								\
+	.name = test_name,					\
+	.config = {						\
+		.src_alignment = source_align,			\
+		.dest_alignment = destination_align,		\
+		.region_size = size,				\
+		.overlapping = overlaps,			\
+	},							\
+	.expect_failure = should_fail				\
+}
+
+#define MAKE_SIMPLE_TEST(source_align, destination_align, size)	\
+	MAKE_TEST(source_align, destination_align, size, 0, 0,	\
+		  #size " mremap - Source " #source_align	\
+		  " aligned, Destination " #destination_align	\
+		  " aligned")
+
+/*
+ * Returns the start address of the mapping on success, else returns
+ * NULL on failure.
+ */
+static void *get_source_mapping(struct config c)
+{
+	unsigned long long addr = 0ULL;
+	void *src_addr = NULL;
+retry:
+	addr += c.src_alignment;
+	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
+			MAP_FIXED | MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	if (src_addr == MAP_FAILED) {
+		if (errno == EPERM)
+			goto retry;
+		goto error;
+	}
+	/*
+	 * Check that the address is aligned to the specified alignment. Addresses
+	 * which have alignments that are multiples of that specified are not considered
+	 * valid. For instance, 1GB address is 2MB-aligned, however it will not be
+	 * considered valid for a requested alignment of 2MB. This is done to
+	 * reduce coincidental alignment in the tests.
+	 */
+	if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
+			!((unsigned long long) src_addr & c.src_alignment))
+		goto retry;
+
+	if (!src_addr)
+		goto error;
+
+	return src_addr;
+error:
+	ksft_print_msg("Failed to map source region: %s\n",
+			strerror(errno));
+	return NULL;
+}
+
+/* Returns the time taken for the remap on success else returns -1. */
+static long long remap_region(struct config c)
+{
+	void *addr, *src_addr, *dest_addr;
+	int i, j;
+	struct timespec t_start = {0, 0}, t_end = {0, 0};
+	long long  start_ns, end_ns, align_mask, ret, offset;
+	char pattern[] = {0xa8, 0xcd, 0xfe};
+	int pattern_size = ARRAY_SIZE(pattern);
+
+	src_addr = get_source_mapping(c);
+	if (!src_addr) {
+		ret = -1;
+		goto out;
+	}
+
+	/* Set byte pattern */
+	for (i = 0; i < c.region_size; i++) {
+		for (j = 0; i+j < c.region_size && j < pattern_size; j++)
+			memset((char *) src_addr + i+j, pattern[j], 1);
+		i += pattern_size-1;
+	}
+
+	align_mask = ~(c.dest_alignment - 1);
+	offset = (c.overlapping) ? -c.dest_alignment : c.dest_alignment;
+	addr = (void *) (((unsigned long long) src_addr + c.region_size + offset)
+			& align_mask);
+
+	/* See comment in get_source_mapping() */
+	if (!((unsigned long long) addr & c.dest_alignment))
+		addr = (void *) ((unsigned long long) addr | c.dest_alignment);
+
+	clock_gettime(CLOCK_MONOTONIC, &t_start);
+	dest_addr = mremap(src_addr, c.region_size, c.region_size,
+			MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
+	clock_gettime(CLOCK_MONOTONIC, &t_end);
+
+	if (dest_addr == MAP_FAILED) {
+		ksft_print_msg("mremap failed: %s\n", strerror(errno));
+		ret = -1;
+		goto clean_up_src;
+	}
+
+	/* Verify byte pattern after remapping */
+	for (i = 0; i < c.region_size; i++) {
+		for (j = 0; i+j < c.region_size && j < pattern_size; j++) {
+			if (((char *) dest_addr)[i+j] != (char) pattern[j]) {
+				ksft_print_msg("Data after remap doesn't match at offset %d\n",
+						i+j);
+				ksft_print_msg("Expected: %#x\t Got: %#x\n", pattern[j] & 0xff,
+						((char *) dest_addr)[i+j] & 0xff);
+				ret = -1;
+				goto clean_up_dest;
+			}
+		}
+		i += pattern_size-1;
+	}
+
+	start_ns = t_start.tv_sec * 1000000000ULL + t_start.tv_nsec;
+	end_ns = t_end.tv_sec * 1000000000ULL + t_end.tv_nsec;
+	ret = end_ns - start_ns;
+
+/*
+ * Since the destination address is specified using MREMAP_FIXED, subsequent mremap will unmap any
+ * previous mapping at the address range specified by dest_addr and region_size. This significantly
+ * affects the remap time of subsequent tests. So we clean up mappings after each test.
+ */
+clean_up_dest:
+	munmap(dest_addr, c.region_size);
+clean_up_src:
+	munmap(src_addr, c.region_size);
+out:
+	return ret;
+}
+
+static void run_mremap_test_case(struct test test_case, int *failures)
+{
+	long long remap_time = remap_region(test_case.config);
+
+	if (remap_time < 0) {
+		if (test_case.expect_failure)
+			ksft_test_result_pass("%s\n\tExpected mremap failure\n", test_case.name);
+		else {
+			ksft_test_result_fail("%s\n", test_case.name);
+			*failures += 1;
+		}
+	} else
+		ksft_test_result_pass("%s\n\tmremap time: %12lldns\n", test_case.name, remap_time);
+}
+
+int main(int argc, char *argv[])
+{
+	int failures = 0;
+	int i;
+
+	struct test test_cases[] = {
+		/* Expected mremap failures */
+		MAKE_TEST(_4KB, _4KB, _4KB, 1 /* overlaps */, 1 /* fails */,
+			  "mremap - Source and Destination Regions Overlapping"),
+		MAKE_TEST(_4KB, _1KB, _4KB, 0 /* overlaps */, 1 /* fails */,
+			  "mremap - Destination Address Misaligned (1KB-aligned)"),
+		MAKE_TEST(_1KB, _4KB, _4KB, 0 /* overlaps */, 1 /* fails */,
+			  "mremap - Source Address Misaligned (1KB-aligned)"),
+
+		/* Src addr PTE aligned */
+		MAKE_SIMPLE_TEST(PTE, PTE, _8KB),
+
+		/* Src addr 1MB aligned */
+		MAKE_SIMPLE_TEST(_1MB, PTE, _2MB),
+		MAKE_SIMPLE_TEST(_1MB, _1MB, _2MB),
+
+		/* Src addr PMD aligned */
+		MAKE_SIMPLE_TEST(PMD, PTE, _4MB),
+		MAKE_SIMPLE_TEST(PMD, _1MB, _4MB),
+		MAKE_SIMPLE_TEST(PMD, PMD, _4MB),
+
+		/* Src addr PUD aligned */
+		MAKE_SIMPLE_TEST(PUD, PTE, _2GB),
+		MAKE_SIMPLE_TEST(PUD, _1MB, _2GB),
+		MAKE_SIMPLE_TEST(PUD, PMD, _2GB),
+		MAKE_SIMPLE_TEST(PUD, PUD, _2GB),
+	};
+
+	struct test perf_test_cases[] = {
+		/* mremap 1GB region - Page table level aligned time comparison */
+		MAKE_SIMPLE_TEST(PTE, PTE, _1GB),
+		MAKE_SIMPLE_TEST(PMD, PMD, _1GB),
+		MAKE_SIMPLE_TEST(PUD, PUD, _1GB),
+	};
+
+	ksft_set_plan(ARRAY_SIZE(test_cases) + ARRAY_SIZE(perf_test_cases));
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
+		run_mremap_test_case(test_cases[i], &failures);
+
+	ksft_print_msg("\nmremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:\n");
+	for (i = 0; i < ARRAY_SIZE(perf_test_cases); i++)
+		run_mremap_test_case(perf_test_cases[i], &failures);
+
+	if (failures > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index a3f4f30f0a2e..d578ad831813 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -241,6 +241,17 @@ else
 	echo "[PASS]"
 fi
 
+echo "-------------------"
+echo "running mremap_test"
+echo "-------------------"
+./mremap_test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
 echo "-----------------"
 echo "running thuge-gen"
 echo "-----------------"
-- 
2.28.0.709.gb0816b6eb0-goog

