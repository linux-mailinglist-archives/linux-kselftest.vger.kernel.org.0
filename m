Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E02817BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbgJBQV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBQV0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 12:21:26 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56FC0613D0
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 09:21:26 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id s9so1397702qks.21
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=BrOtsOgB7AJAwbyDYA2Ode1xJGzCqgNQ+JePR8F54qk=;
        b=AN1bIT6DtMnxiUeOqjodIOlnhBEo5C5dRCqw9poi9iO/VHAgPq+6JsjbNXPEa36J23
         gSCgms7FSnxPPq8SS8Xo1qWKe8kb9ys7PiIvZWrtZ+V5NUlt9yo9ay9Lq1gZmqtMdCRc
         XYQOv6Sclwa1E9iSLZEaMBS/vh52MFYvFW4Jk9B4UWa6sAOOc2RwGm3vCJS0+cqb6g2E
         4WfusZCP3cgtMOzGi5BsZa24y3/LCGYwHcb30m/3F6sHeUSqh4SMVFpgSOoRitwx5Ohg
         gTZVJeu52QwjPchJwVMa+8GVogM5Lvyc5vqnfSon+AaYmRbUnRZF4XMUE5ClZ0EYFJRA
         GDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=BrOtsOgB7AJAwbyDYA2Ode1xJGzCqgNQ+JePR8F54qk=;
        b=f7L/LtPMpmVV6U0ufEne4Xf1NRxCF8v7Llen8hgzTaNWfmnqKP4M+guwaNoyz4H+7d
         vI142kocFx2A+gEQpI1AwJCV6P1euPTrvKG+xgI5tAF2Qi4HZ1+n/148PIAtjl46pOU2
         ldAWTLwnt6r6TgO7VBM4+BU9LQ0Jr1NoDkwworAwhfzj9XV0neDkp7yT4S61XNcL3Xvq
         vfAOVU3jj0VzCgGKjzwDm/EVf8LW/kft2SNivkntrQIt7ONWBh/tqpS/aojCKenxAEET
         tINyAw7e8TgY17GbtwtTkYLNUg3rrHIior+ZR87PlRpHLp699BOvJattNLsvq5AWkaOi
         26cQ==
X-Gm-Message-State: AOAM532U5ASsRDEPQDuvMUz6qT4rsTjsWoXI+5PIrt3jtXm40/cWsMAR
        JQIVZwZo7PpNNcwC45ltmdNkbfh48yVTphYixw==
X-Google-Smtp-Source: ABdhPJwUUucdllaeVeyR+2aPmKeFHmUeJJlKTkCUaxWnA1O0Re9UJXEU1tbrUwRNca0i2TfGG+npIrF5VaK02dE5ng==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:1181:: with SMTP id
 t1mr2893118qvv.11.1601655685825; Fri, 02 Oct 2020 09:21:25 -0700 (PDT)
Date:   Fri,  2 Oct 2020 16:20:46 +0000
In-Reply-To: <20201002162101.665549-1-kaleshsingh@google.com>
Message-Id: <20201002162101.665549-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201002162101.665549-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 1/6] kselftests: vm: Add mremap tests
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
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Ira Weiny <ira.weiny@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
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
Changes in v2:
  - Reduce test time by only validating a certain threshold of the
    remapped region (4MB by default). The -t flag can be used to
    set a custom threshold in MB or no threshold by passing 0. (-t0).
    mremap time is not provided in stdout for only partially validated
    regions. This time is only applicable for comparison if the entire
    mapped region was faulted in.
  - Use a random pattern for validating the remapped region. The -p
    flag can be used to run the tests with a specified seed for the
    random pattern.
  - Print test configs (threshold_mb and pattern_seed) to stdout.
  - Remove MAKE_SIMPLE_TEST macro.
  - Define named flags instead of 0 / 1.
  - Add comments for destination address' align_mask and offset.

 tools/testing/selftests/vm/.gitignore    |   1 +
 tools/testing/selftests/vm/Makefile      |   1 +
 tools/testing/selftests/vm/mremap_test.c | 333 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests   |  11 +
 4 files changed, 346 insertions(+)
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
index 000000000000..abe1f0a5a26a
--- /dev/null
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 Google LLC
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <time.h>
+
+#include "../kselftest.h"
+
+#define EXPECT_SUCCESS 0
+#define EXPECT_FAILURE 1
+#define NON_OVERLAPPING 0
+#define OVERLAPPING 1
+#define NS_PER_SEC 1000000000ULL
+#define VALIDATION_DEFAULT_THRESHOLD 4	/* 4MB */
+#define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
+#define PATTERN_SIZE 3
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
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
+static long long remap_region(struct config c, unsigned int threshold_mb,
+			      char pattern_seed)
+{
+	void *addr, *src_addr, *dest_addr;
+	unsigned long long i;
+	struct timespec t_start = {0, 0}, t_end = {0, 0};
+	long long  start_ns, end_ns, align_mask, ret, offset;
+	unsigned long long threshold;
+
+	if (threshold_mb == VALIDATION_NO_THRESHOLD)
+		threshold = c.region_size;
+	else
+		threshold = MIN(threshold_mb * _1MB, c.region_size);
+
+	src_addr = get_source_mapping(c);
+	if (!src_addr) {
+		ret = -1;
+		goto out;
+	}
+
+	/* Set byte pattern */
+	srand(pattern_seed);
+	for (i = 0; i < threshold; i++)
+		memset((char *) src_addr + i, (char) rand(), 1);
+
+	/* Mask to zero out lower bits of address for alignment */
+	align_mask = ~(c.dest_alignment - 1);
+	/* Offset of destination address from the end of the source region */
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
+	srand(pattern_seed);
+	for (i = 0; i < threshold; i++) {
+		char c = (char) rand();
+
+		if (((char *) dest_addr)[i] != c) {
+			ksft_print_msg("Data after remap doesn't match at offset %d\n",
+					i);
+			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
+					((char *) dest_addr)[i] & 0xff);
+			ret = -1;
+			goto clean_up_dest;
+		}
+	}
+
+	start_ns = t_start.tv_sec * NS_PER_SEC + t_start.tv_nsec;
+	end_ns = t_end.tv_sec * NS_PER_SEC + t_end.tv_nsec;
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
+static void run_mremap_test_case(struct test test_case, int *failures, unsigned int threshold_mb,
+				 unsigned int pattern_seed)
+{
+	long long remap_time = remap_region(test_case.config, threshold_mb, pattern_seed);
+
+	if (remap_time < 0) {
+		if (test_case.expect_failure)
+			ksft_test_result_pass("%s\n\tExpected mremap failure\n", test_case.name);
+		else {
+			ksft_test_result_fail("%s\n", test_case.name);
+			*failures += 1;
+		}
+	} else {
+		/* Comparing mremap time is only applicable if entire region was faulted in */
+		if (threshold_mb == VALIDATION_NO_THRESHOLD ||
+		    test_case.config.region_size <= threshold_mb * _1MB)
+			ksft_test_result_pass("%s\n\tmremap time: %12lldns\n",
+					      test_case.name, remap_time);
+		else
+			ksft_test_result_pass("%s\n", test_case.name);
+	}
+}
+
+static void usage(const char *cmd)
+{
+	fprintf(stderr,
+		"Usage: %s [[-t <threshold_mb>] [-p <pattern_seed>]]\n"
+		"-t\t only validate threshold_mb of the remapped region\n"
+		"  \t if 0 is supplied no threshold is used; all tests\n"
+		"  \t are run and remapped regions validated fully.\n"
+		"  \t The default threshold used is 4MB.\n"
+		"-p\t provide a seed to generate the random pattern for\n"
+		"  \t validating the remapped region.\n", cmd);
+}
+
+static int parse_args(int argc, char **argv, unsigned int *threshold_mb,
+		      unsigned int *pattern_seed)
+{
+	const char *optstr = "t:p:";
+	int opt;
+
+	while ((opt = getopt(argc, argv, optstr)) != -1) {
+		switch (opt) {
+		case 't':
+			*threshold_mb = atoi(optarg);
+			break;
+		case 'p':
+			*pattern_seed = atoi(optarg);
+			break;
+		default:
+			usage(argv[0]);
+			return -1;
+		}
+	}
+
+	if (optind < argc) {
+		usage(argv[0]);
+		return -1;
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int failures = 0;
+	int i, run_perf_tests;
+	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
+	unsigned int pattern_seed;
+	time_t t;
+
+	pattern_seed = (unsigned int) time(&t);
+
+	if (parse_args(argc, argv, &threshold_mb, &pattern_seed) < 0)
+		exit(EXIT_FAILURE);
+
+	ksft_print_msg("Test configs:\n\tthreshold_mb=%u\n\tpattern_seed=%u\n\n",
+		       threshold_mb, pattern_seed);
+
+	struct test test_cases[] = {
+		/* Expected mremap failures */
+		MAKE_TEST(_4KB, _4KB, _4KB, OVERLAPPING, EXPECT_FAILURE,
+			  "mremap - Source and Destination Regions Overlapping"),
+		MAKE_TEST(_4KB, _1KB, _4KB, NON_OVERLAPPING, EXPECT_FAILURE,
+			  "mremap - Destination Address Misaligned (1KB-aligned)"),
+		MAKE_TEST(_1KB, _4KB, _4KB, NON_OVERLAPPING, EXPECT_FAILURE,
+			  "mremap - Source Address Misaligned (1KB-aligned)"),
+
+		/* Src addr PTE aligned */
+		MAKE_TEST(PTE, PTE, _8KB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "8KB mremap - Source PTE-aligned, Destination PTE-aligned"),
+
+		/* Src addr 1MB aligned */
+		MAKE_TEST(_1MB, PTE, _2MB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "2MB mremap - Source 1MB-aligned, Destination PTE-aligned"),
+		MAKE_TEST(_1MB, _1MB, _2MB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "2MB mremap - Source 1MB-aligned, Destination 1MB-aligned"),
+
+		/* Src addr PMD aligned */
+		MAKE_TEST(PMD, PTE, _4MB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "4MB mremap - Source PMD-aligned, Destination PTE-aligned"),
+		MAKE_TEST(PMD, _1MB, _4MB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "4MB mremap - Source PMD-aligned, Destination 1MB-aligned"),
+		MAKE_TEST(PMD, PMD, _4MB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "4MB mremap - Source PMD-aligned, Destination PMD-aligned"),
+
+		/* Src addr PUD aligned */
+		MAKE_TEST(PUD, PTE, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "2GB mremap - Source PUD-aligned, Destination PTE-aligned"),
+		MAKE_TEST(PUD, _1MB, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "2GB mremap - Source PUD-aligned, Destination 1MB-aligned"),
+		MAKE_TEST(PUD, PMD, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "2GB mremap - Source PUD-aligned, Destination PMD-aligned"),
+		MAKE_TEST(PUD, PUD, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "2GB mremap - Source PUD-aligned, Destination PUD-aligned"),
+	};
+
+	struct test perf_test_cases[] = {
+		/* mremap 1GB region - Page table level aligned time comparison */
+		MAKE_TEST(PTE, PTE, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "1GB mremap - Source PTE-aligned, Destination PTE-aligned"),
+		MAKE_TEST(PMD, PMD, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "1GB mremap - Source PMD-aligned, Destination PMD-aligned"),
+		MAKE_TEST(PUD, PUD, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
+			  "1GB mremap - Source PUD-aligned, Destination PUD-aligned"),
+	};
+
+	run_perf_tests =  (threshold_mb == VALIDATION_NO_THRESHOLD) ||
+				(threshold_mb * _1MB >= _1GB);
+
+	ksft_set_plan(ARRAY_SIZE(test_cases) + (run_perf_tests ?
+		      ARRAY_SIZE(perf_test_cases) : 0));
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
+		run_mremap_test_case(test_cases[i], &failures, threshold_mb, pattern_seed);
+
+	if (run_perf_tests) {
+		ksft_print_msg("\n%s\n",
+		 "mremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:");
+		for (i = 0; i < ARRAY_SIZE(perf_test_cases); i++)
+			run_mremap_test_case(perf_test_cases[i], &failures, threshold_mb,
+					     pattern_seed);
+	}
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
2.28.0.806.g8561365e88-goog

