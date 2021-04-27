Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967C736CF45
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 01:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhD0XNt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 19:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhD0XNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 19:13:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E42C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 16:13:04 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id c15so3421516ilj.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=Hp96H5Ur9BuSq+J0U6rpyU9qbr/y6YsA/ZUJFjZV7y0=;
        b=BZ5O2ZfEbyP97Diq+MEIQzhvQ/6gQKV3S2sL9ZcQoGVLed1byLuoIgchR/fnO+HRXI
         YIKlJu48PfaC3T9LJlS+2Nz3pf8dZeDm4SqkSTGJttAIYpORqLc7mHgl+ezSffYpWDZk
         T4vKPiUIBDvn4HQUiTxaWP5TEwvZJixeO2tKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=Hp96H5Ur9BuSq+J0U6rpyU9qbr/y6YsA/ZUJFjZV7y0=;
        b=i3Uc095iOV34ZcmzsQflSwYUQ5s1JKdthzjg/R029i59/NOyewobgDCcXJ0Nh41Cao
         aMcVzmqnsDgN3ninYbc3SW7hlXm3Agvnwpyo2zls39ytRjtbFLhl8v7aRNUbiFiSVhkO
         3mnxt1EBI7xJfNNgAaEVAsv1O/VHZr+h8mKKqOzZI40j/mYKlo1oYb9TjLFgaTF+ao3r
         M4zQiq8BjTCxSjAQgIhCsYEh8pyokI5yHxm7pLxZF5mxlQBXfV6smx95gkbAP71ZnsUS
         Yc5UiJE22XaaAM/vAmSsrn0VCEdYPJ3SaKHKXZs/D1DiPAAmut6uL4CiRFaQltfsGL9y
         RQ+g==
X-Gm-Message-State: AOAM532j4XvNxYm++ZWURsCki6e8A9zai5/tdu+QlTyg0agPpkvyAkHj
        4S51OJwCA7iGnMYjYMuLgjGqJA==
X-Google-Smtp-Source: ABdhPJzJDHQJAjK/jMW1muOGp+cXHPyU8J11frDZnGZJpO78sAlkwaHnjbhPb1NLYl/nWTmaJoqcjw==
X-Received: by 2002:a05:6e02:d51:: with SMTP id h17mr20673677ilj.134.1619565183906;
        Tue, 27 Apr 2021 16:13:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l2sm1944338ilq.70.2021.04.27.16.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 16:13:03 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.13-rc1
Message-ID: <aea4049e-6de5-f27d-c23e-ca098d78f79f@linuxfoundation.org>
Date:   Tue, 27 Apr 2021 17:13:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------F142053B21395AE3B5C11899"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------F142053B21395AE3B5C11899
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.13-rc1.

This Kselftest update for Linux 5.13-rc1 consists of:

- fixes and updates to resctrl test from Fenghua Yu and Reinette Chatre
- fixes to Kselftest documentation, framework
- minor spelling correction in timers test

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-next-5.13-rc1

for you to fetch changes up to e75074781f1735c1976bc551e29ccf2ba9a4b17f:

   selftests/resctrl: Change a few printed messages (2021-04-07 16:37:49 
-0600)

----------------------------------------------------------------
linux-kselftest-next-5.13-rc1

This Kselftest update for Linux 5.13-rc1 consists of:

- fixes and updates to resctrl test from Fenghua Yu and Reinette Chatre
- fixes to Kselftest documentation, framework
- minor spelling correction in timers test

----------------------------------------------------------------
Antonio Terceiro (1):
       Documentation: kselftest: fix path to test module files

Colin Ian King (1):
       selftests/timers: Fix spelling mistake "clocksourc" -> "clocksource"

Fenghua Yu (20):
       selftests/resctrl: Enable gcc checks to detect buffer overflows
       selftests/resctrl: Fix compilation issues for global variables
       selftests/resctrl: Fix compilation issues for other global variables
       selftests/resctrl: Clean up resctrl features check
       selftests/resctrl: Fix missing options "-n" and "-p"
       selftests/resctrl: Rename CQM test as CMT test
       selftests/resctrl: Call kselftest APIs to log test results
       selftests/resctrl: Share show_cache_info() by CAT and CMT tests
       selftests/resctrl: Add config dependencies
       selftests/resctrl: Check for resctrl mount point only if resctrl 
FS is supported
       selftests/resctrl: Use resctrl/info for feature detection
       selftests/resctrl: Fix MBA/MBM results reporting format
       selftests/resctrl: Don't hard code value of "no_of_bits" variable
       selftests/resctrl: Modularize resctrl test suite main() function
       selftests/resctrl: Skip the test if requested resctrl feature is 
not supported
       selftests/resctrl: Fix unmount resctrl FS
       selftests/resctrl: Fix incorrect parsing of iMC counters
       selftests/resctrl: Fix checking for < 0 for unsigned values
       selftests/resctrl: Create .gitignore to include resctrl_tests
       selftests/resctrl: Change a few printed messages

Ilya Leoshkevich (1):
       selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)

Reinette Chatre (2):
       selftests/resctrl: Ensure sibling CPU is not same as original CPU
       selftests/resctrl: Fix a printed message

  Documentation/dev-tools/kselftest.rst              |   4 +-
  tools/testing/selftests/lib.mk                     |   3 +-
  tools/testing/selftests/resctrl/.gitignore         |   2 +
  tools/testing/selftests/resctrl/Makefile           |   2 +-
  tools/testing/selftests/resctrl/README             |   4 +-
  tools/testing/selftests/resctrl/cache.c            |  52 ++++++-
  tools/testing/selftests/resctrl/cat_test.c         |  57 +++----
  .../selftests/resctrl/{cqm_test.c => cmt_test.c}   |  75 +++-------
  tools/testing/selftests/resctrl/config             |   2 +
  tools/testing/selftests/resctrl/fill_buf.c         |   4 +-
  tools/testing/selftests/resctrl/mba_test.c         |  43 +++---
  tools/testing/selftests/resctrl/mbm_test.c         |  42 +++---
  tools/testing/selftests/resctrl/resctrl.h          |  29 +++-
  tools/testing/selftests/resctrl/resctrl_tests.c    | 163 
++++++++++++++-------
  tools/testing/selftests/resctrl/resctrl_val.c      |  95 +++++++-----
  tools/testing/selftests/resctrl/resctrlfs.c        | 134 ++++++++++-------
  .../testing/selftests/timers/clocksource-switch.c  |   2 +-
  17 files changed, 413 insertions(+), 300 deletions(-)
  create mode 100644 tools/testing/selftests/resctrl/.gitignore
  rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (56%)
  create mode 100644 tools/testing/selftests/resctrl/config

----------------------------------------------------------------

--------------F142053B21395AE3B5C11899
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.13-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.13-rc1.diff"

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index a901def730d9..dcefee707ccd 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -239,8 +239,8 @@ using a shell script test runner.  ``kselftest/module.sh`` is designed
 to facilitate this process.  There is also a header file provided to
 assist writing kernel modules that are for use with kselftest:
 
-- ``tools/testing/kselftest/kselftest_module.h``
-- ``tools/testing/kselftest/kselftest/module.sh``
+- ``tools/testing/selftests/kselftest_module.h``
+- ``tools/testing/selftests/kselftest/module.sh``
 
 How to use
 ----------
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index a5ce26d548e4..be17462fe146 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -74,7 +74,8 @@ ifdef building_out_of_srctree
 		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
+				  $(addprefix $(OUTPUT)/,$(TEST_PROGS))) ; \
 	else \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
 	fi
diff --git a/tools/testing/selftests/resctrl/.gitignore b/tools/testing/selftests/resctrl/.gitignore
new file mode 100644
index 000000000000..ab68442b6bc8
--- /dev/null
+++ b/tools/testing/selftests/resctrl/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+resctrl_tests
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index d585cc1948cc..6bcee2ec91a9 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,5 +1,5 @@
 CC = $(CROSS_COMPILE)gcc
-CFLAGS = -g -Wall
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 SRCS=$(wildcard *.c)
 OBJS=$(SRCS:.c=.o)
 
diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 6e5a0ffa18e8..4b36b25b6ac0 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -46,8 +46,8 @@ ARGUMENTS
 Parameter '-h' shows usage information.
 
 usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n no_of_bits]
-        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM default benchmark is builtin fill_buf
-        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cqm, cat
+        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT default benchmark is builtin fill_buf
+        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cmt, cat
         -n no_of_bits: run cache tests using specified no of bits in cache bit mask
         -p cpu_no: specify CPU number to run the test. 1 is default
         -h: help
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 38dbf4962e33..68ff856d36f0 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -111,7 +111,7 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
 
 /*
  * Get LLC Occupancy as reported by RESCTRL FS
- * For CQM,
+ * For CMT,
  * 1. If con_mon grp and mon grp given, then read from mon grp in
  * con_mon grp
  * 2. If only con_mon grp given, then read from con_mon grp
@@ -182,7 +182,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 	/*
 	 * Measure cache miss from perf.
 	 */
-	if (!strcmp(param->resctrl_val, "cat")) {
+	if (!strncmp(param->resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 		ret = get_llc_perf(&llc_perf_miss);
 		if (ret < 0)
 			return ret;
@@ -192,7 +192,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 	/*
 	 * Measure llc occupancy from resctrl.
 	 */
-	if (!strcmp(param->resctrl_val, "cqm")) {
+	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
 		ret = get_llc_occu_resctrl(&llc_occu_resc);
 		if (ret < 0)
 			return ret;
@@ -234,7 +234,7 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
-	if ((strcmp(resctrl_val, "cat") == 0)) {
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 		ret = initialize_llc_perf();
 		if (ret)
 			return ret;
@@ -242,7 +242,7 @@ int cat_val(struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if (strcmp(resctrl_val, "cat") == 0) {
+		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
@@ -270,3 +270,45 @@ int cat_val(struct resctrl_val_param *param)
 
 	return ret;
 }
+
+/*
+ * show_cache_info:	show cache test result information
+ * @sum_llc_val:	sum of LLC cache result data
+ * @no_of_bits:		number of bits
+ * @cache_span:		cache span in bytes for CMT or in lines for CAT
+ * @max_diff:		max difference
+ * @max_diff_percent:	max difference percentage
+ * @num_of_runs:	number of runs
+ * @platform:		show test information on this platform
+ * @cmt:		CMT test or CAT test
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
+		    unsigned long cache_span, unsigned long max_diff,
+		    unsigned long max_diff_percent, unsigned long num_of_runs,
+		    bool platform, bool cmt)
+{
+	unsigned long avg_llc_val = 0;
+	float diff_percent;
+	long avg_diff = 0;
+	int ret;
+
+	avg_llc_val = sum_llc_val / (num_of_runs - 1);
+	avg_diff = (long)abs(cache_span - avg_llc_val);
+	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
+
+	ret = platform && abs((int)diff_percent) > max_diff_percent &&
+	      (cmt ? (abs(avg_diff) > max_diff) : true);
+
+	ksft_print_msg("%s Check cache miss rate within %d%%\n",
+		       ret ? "Fail:" : "Pass:", max_diff_percent);
+
+	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+	ksft_print_msg("Number of bits: %d\n", no_of_bits);
+	ksft_print_msg("Average LLC val: %lu\n", avg_llc_val);
+	ksft_print_msg("Cache span (%s): %lu\n", cmt ? "bytes" : "lines",
+		       cache_span);
+
+	return ret;
+}
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 5da43767b973..cd4f68388e0f 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -17,10 +17,10 @@
 #define MAX_DIFF_PERCENT	4
 #define MAX_DIFF		1000000
 
-int count_of_bits;
-char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
+static int count_of_bits;
+static char cbm_mask[256];
+static unsigned long long_mask;
+static unsigned long cache_size;
 
 /*
  * Change schemata. Write schemata to specified
@@ -52,27 +52,6 @@ static int cat_setup(int num, ...)
 	return ret;
 }
 
-static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
-			    unsigned long span)
-{
-	unsigned long allocated_cache_lines = span / 64;
-	unsigned long avg_llc_perf_miss = 0;
-	float diff_percent;
-
-	avg_llc_perf_miss = sum_llc_perf_miss / (NUM_OF_RUNS - 1);
-	diff_percent = ((float)allocated_cache_lines - avg_llc_perf_miss) /
-				allocated_cache_lines * 100;
-
-	printf("%sok CAT: cache miss rate within %d%%\n",
-	       !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT ?
-	       "not " : "", MAX_DIFF_PERCENT);
-	tests_run++;
-	printf("# Percent diff=%d\n", abs((int)diff_percent));
-	printf("# Number of bits: %d\n", no_of_bits);
-	printf("# Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
-	printf("# Allocated cache lines: %lu\n", allocated_cache_lines);
-}
-
 static int check_results(struct resctrl_val_param *param)
 {
 	char *token_array[8], temp[512];
@@ -80,7 +59,7 @@ static int check_results(struct resctrl_val_param *param)
 	int runs = 0, no_of_bits = 0;
 	FILE *fp;
 
-	printf("# Checking for pass/fail\n");
+	ksft_print_msg("Checking for pass/fail\n");
 	fp = fopen(param->filename, "r");
 	if (!fp) {
 		perror("# Cannot open file");
@@ -108,9 +87,9 @@ static int check_results(struct resctrl_val_param *param)
 	fclose(fp);
 	no_of_bits = count_bits(param->mask);
 
-	show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
-
-	return 0;
+	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
+			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       !is_amd, false);
 }
 
 void cat_test_cleanup(void)
@@ -132,11 +111,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (ret)
 		return ret;
 
-	if (!validate_resctrl_feature_request("cat"))
-		return -1;
-
 	/* Get default cbm mask for L3/L2 cache */
-	ret = get_cbm_mask(cache_type);
+	ret = get_cbm_mask(cache_type, cbm_mask);
 	if (ret)
 		return ret;
 
@@ -146,15 +122,18 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	ret = get_cache_size(cpu_no, cache_type, &cache_size);
 	if (ret)
 		return ret;
-	printf("cache size :%lu\n", cache_size);
+	ksft_print_msg("Cache size :%lu\n", cache_size);
 
 	/* Get max number of bits from default-cabm mask */
 	count_of_bits = count_bits(long_mask);
 
-	if (n < 1 || n > count_of_bits - 1) {
-		printf("Invalid input value for no_of_bits n!\n");
-		printf("Please Enter value in range 1 to %d\n",
-		       count_of_bits - 1);
+	if (!n)
+		n = count_of_bits / 2;
+
+	if (n > count_of_bits - 1) {
+		ksft_print_msg("Invalid input value for no_of_bits n!\n");
+		ksft_print_msg("Please enter value in range 1 to %d\n",
+			       count_of_bits - 1);
 		return -1;
 	}
 
@@ -164,7 +143,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return -1;
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= "cat",
+		.resctrl_val	= CAT_STR,
 		.cpu_no		= cpu_no,
 		.mum_resctrlfs	= 0,
 		.setup		= cat_setup,
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cmt_test.c
similarity index 56%
rename from tools/testing/selftests/resctrl/cqm_test.c
rename to tools/testing/selftests/resctrl/cmt_test.c
index c8756152bd61..8968e36db99d 100644
--- a/tools/testing/selftests/resctrl/cqm_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Cache Monitoring Technology (CQM) test
+ * Cache Monitoring Technology (CMT) test
  *
  * Copyright (C) 2018 Intel Corporation
  *
@@ -11,17 +11,17 @@
 #include "resctrl.h"
 #include <unistd.h>
 
-#define RESULT_FILE_NAME	"result_cqm"
+#define RESULT_FILE_NAME	"result_cmt"
 #define NUM_OF_RUNS		5
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-int count_of_bits;
-char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
+static int count_of_bits;
+static char cbm_mask[256];
+static unsigned long long_mask;
+static unsigned long cache_size;
 
-static int cqm_setup(int num, ...)
+static int cmt_setup(int num, ...)
 {
 	struct resctrl_val_param *p;
 	va_list param;
@@ -39,38 +39,6 @@ static int cqm_setup(int num, ...)
 	return 0;
 }
 
-static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
-			    unsigned long span)
-{
-	unsigned long avg_llc_occu_resc = 0;
-	float diff_percent;
-	long avg_diff = 0;
-	bool res;
-
-	avg_llc_occu_resc = sum_llc_occu_resc / (NUM_OF_RUNS - 1);
-	avg_diff = (long)abs(span - avg_llc_occu_resc);
-
-	diff_percent = (((float)span - avg_llc_occu_resc) / span) * 100;
-
-	if ((abs((int)diff_percent) <= MAX_DIFF_PERCENT) ||
-	    (abs(avg_diff) <= MAX_DIFF))
-		res = true;
-	else
-		res = false;
-
-	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not",
-	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
-
-	printf("# diff: %ld\n", avg_diff);
-	printf("# percent diff=%d\n", abs((int)diff_percent));
-	printf("# Results are displayed in (Bytes)\n");
-	printf("# Number of bits: %d\n", no_of_bits);
-	printf("# Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
-	printf("# llc_occu_exp (span): %lu\n", span);
-
-	tests_run++;
-}
-
 static int check_results(struct resctrl_val_param *param, int no_of_bits)
 {
 	char *token_array[8], temp[512];
@@ -78,7 +46,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	int runs = 0;
 	FILE *fp;
 
-	printf("# checking for pass/fail\n");
+	ksft_print_msg("Checking for pass/fail\n");
 	fp = fopen(param->filename, "r");
 	if (!fp) {
 		perror("# Error in opening file\n");
@@ -86,7 +54,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 		return errno;
 	}
 
-	while (fgets(temp, 1024, fp)) {
+	while (fgets(temp, sizeof(temp), fp)) {
 		char *token = strtok(temp, ":\t");
 		int fields = 0;
 
@@ -101,17 +69,18 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 		runs++;
 	}
 	fclose(fp);
-	show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
 
-	return 0;
+	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
+			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       true, true);
 }
 
-void cqm_test_cleanup(void)
+void cmt_test_cleanup(void)
 {
 	remove(RESULT_FILE_NAME);
 }
 
-int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
+int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 {
 	int ret, mum_resctrlfs;
 
@@ -122,10 +91,10 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	if (!validate_resctrl_feature_request("cqm"))
+	if (!validate_resctrl_feature_request(CMT_STR))
 		return -1;
 
-	ret = get_cbm_mask("L3");
+	ret = get_cbm_mask("L3", cbm_mask);
 	if (ret)
 		return ret;
 
@@ -134,18 +103,18 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	ret = get_cache_size(cpu_no, "L3", &cache_size);
 	if (ret)
 		return ret;
-	printf("cache size :%lu\n", cache_size);
+	ksft_print_msg("Cache size :%lu\n", cache_size);
 
 	count_of_bits = count_bits(long_mask);
 
 	if (n < 1 || n > count_of_bits) {
-		printf("Invalid input value for numbr_of_bits n!\n");
-		printf("Please Enter value in range 1 to %d\n", count_of_bits);
+		ksft_print_msg("Invalid input value for numbr_of_bits n!\n");
+		ksft_print_msg("Please enter value in range 1 to %d\n", count_of_bits);
 		return -1;
 	}
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= "cqm",
+		.resctrl_val	= CMT_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
@@ -154,7 +123,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.mask		= ~(long_mask << n) & long_mask,
 		.span		= cache_size * n / count_of_bits,
 		.num_of_runs	= 0,
-		.setup		= cqm_setup,
+		.setup		= cmt_setup,
 	};
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
@@ -170,7 +139,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	cqm_test_cleanup();
+	cmt_test_cleanup();
 
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/config b/tools/testing/selftests/resctrl/config
new file mode 100644
index 000000000000..8d9f2deb56ed
--- /dev/null
+++ b/tools/testing/selftests/resctrl/config
@@ -0,0 +1,2 @@
+CONFIG_X86_CPU_RESCTRL=y
+CONFIG_PROC_CPU_RESCTRL=y
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 79c611c99a3d..51e5cf22632f 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -115,7 +115,7 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 
 	while (1) {
 		ret = fill_one_span_read(start_ptr, end_ptr);
-		if (!strcmp(resctrl_val, "cat"))
+		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
 			break;
 	}
 
@@ -134,7 +134,7 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 {
 	while (1) {
 		fill_one_span_write(start_ptr, end_ptr);
-		if (!strcmp(resctrl_val, "cat"))
+		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
 			break;
 	}
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7bf8eaa6204b..1a1bdb6180cf 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -12,7 +12,7 @@
 
 #define RESULT_FILE_NAME	"result_mba"
 #define NUM_OF_RUNS		5
-#define MAX_DIFF		300
+#define MAX_DIFF_PERCENT	5
 #define ALLOCATION_MAX		100
 #define ALLOCATION_MIN		10
 #define ALLOCATION_STEP		10
@@ -56,13 +56,14 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	int allocation, runs;
 	bool failed = false;
 
-	printf("# Results are displayed in (MB)\n");
+	ksft_print_msg("Results are displayed in (MB)\n");
 	/* Memory bandwidth from 100% down to 10% */
 	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
 	     allocation++) {
 		unsigned long avg_bw_imc, avg_bw_resc;
 		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-		unsigned long avg_diff;
+		int avg_diff_per;
+		float avg_diff;
 
 		/*
 		 * The first run is discarded due to inaccurate value from
@@ -76,23 +77,26 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 
 		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
-		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
-
-		printf("%sok MBA schemata percentage %u smaller than %d %%\n",
-		       avg_diff > MAX_DIFF ? "not " : "",
-		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
-		       MAX_DIFF);
-		tests_run++;
-		printf("# avg_diff: %lu\n", avg_diff);
-		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
-		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
-		if (avg_diff > MAX_DIFF)
+		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+		avg_diff_per = (int)(avg_diff * 100);
+
+		ksft_print_msg("%s Check MBA diff within %d%% for schemata %u\n",
+			       avg_diff_per > MAX_DIFF_PERCENT ?
+			       "Fail:" : "Pass:",
+			       MAX_DIFF_PERCENT,
+			       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
+
+		ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
+		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
+		ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
+		if (avg_diff_per > MAX_DIFF_PERCENT)
 			failed = true;
 	}
 
-	printf("%sok schemata change using MBA%s\n", failed ? "not " : "",
-	       failed ? " # at least one test failed" : "");
-	tests_run++;
+	ksft_print_msg("%s Check schemata change using MBA\n",
+		       failed ? "Fail:" : "Pass:");
+	if (failed)
+		ksft_print_msg("At least one test failed\n");
 }
 
 static int check_results(void)
@@ -141,7 +145,7 @@ void mba_test_cleanup(void)
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= "mba",
+		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
@@ -154,9 +158,6 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	if (!validate_resctrl_feature_request("mba"))
-		return -1;
-
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 4700f7453f81..8392e5c55ed0 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -11,16 +11,16 @@
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mbm"
-#define MAX_DIFF		300
+#define MAX_DIFF_PERCENT	5
 #define NUM_OF_RUNS		5
 
-static void
+static int
 show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 {
 	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-	long avg_diff = 0;
-	int runs;
+	int runs, ret, avg_diff_per;
+	float avg_diff = 0;
 
 	/*
 	 * Discard the first value which is inaccurate due to monitoring setup
@@ -33,15 +33,18 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 
 	avg_bw_imc = sum_bw_imc / 4;
 	avg_bw_resc = sum_bw_resc / 4;
-	avg_diff = avg_bw_resc - avg_bw_imc;
-
-	printf("%sok MBM: diff within %d%%\n",
-	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
-	tests_run++;
-	printf("# avg_diff: %lu\n", labs(avg_diff));
-	printf("# Span (MB): %d\n", span);
-	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
-	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
+	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+	avg_diff_per = (int)(avg_diff * 100);
+
+	ret = avg_diff_per > MAX_DIFF_PERCENT;
+	ksft_print_msg("%s Check MBM diff within %d%%\n",
+		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
+	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
+	ksft_print_msg("Span (MB): %d\n", span);
+	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
+	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
+
+	return ret;
 }
 
 static int check_results(int span)
@@ -49,10 +52,10 @@ static int check_results(int span)
 	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
 	char temp[1024], *token_array[8];
 	char output[] = RESULT_FILE_NAME;
-	int runs;
+	int runs, ret;
 	FILE *fp;
 
-	printf("# Checking for pass/fail\n");
+	ksft_print_msg("Checking for pass/fail\n");
 
 	fp = fopen(output, "r");
 	if (!fp) {
@@ -76,11 +79,11 @@ static int check_results(int span)
 		runs++;
 	}
 
-	show_bw_info(bw_imc, bw_resc, span);
+	ret = show_bw_info(bw_imc, bw_resc, span);
 
 	fclose(fp);
 
-	return 0;
+	return ret;
 }
 
 static int mbm_setup(int num, ...)
@@ -114,7 +117,7 @@ void mbm_test_cleanup(void)
 int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= "mbm",
+		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.span		= span,
@@ -128,9 +131,6 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	if (!validate_resctrl_feature_request("mbm"))
-		return -1;
-
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 39bf59c6b9c5..1ad10c47e31d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -23,11 +23,16 @@
 #include <sys/eventfd.h>
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
+#include "../kselftest.h"
 
 #define MB			(1024 * 1024)
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define CBM_MASK_PATH		"/sys/fs/resctrl/info"
+#define L3_PATH			"/sys/fs/resctrl/info/L3"
+#define MB_PATH			"/sys/fs/resctrl/info/MB"
+#define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
+#define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
 #define PARENT_EXIT(err_msg)			\
 	do {					\
@@ -62,11 +67,15 @@ struct resctrl_val_param {
 	int		(*setup)(int num, ...);
 };
 
-pid_t bm_pid, ppid;
-int tests_run;
+#define MBM_STR			"mbm"
+#define MBA_STR			"mba"
+#define CMT_STR			"cmt"
+#define CAT_STR			"cat"
 
-char llc_occup_path[1024];
-bool is_amd;
+extern pid_t bm_pid, ppid;
+
+extern char llc_occup_path[1024];
+extern bool is_amd;
 
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
@@ -74,7 +83,7 @@ int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(char *resctrl_val);
+bool validate_resctrl_feature_request(const char *resctrl_val);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
@@ -92,16 +101,20 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
-int get_cbm_mask(char *cache_type);
+int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int cat_val(struct resctrl_val_param *param);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
-int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
+int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
 unsigned int count_bits(unsigned long n);
-void cqm_test_cleanup(void);
+void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
+int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
+		    unsigned long cache_span, unsigned long max_diff,
+		    unsigned long max_diff_percent, unsigned long num_of_runs,
+		    bool platform, bool cmt);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 425cc85ac883..f51b5fc066a3 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -37,10 +37,10 @@ void detect_amd(void)
 static void cmd_help(void)
 {
 	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
-	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM");
-	printf("\t default benchmark is builtin fill_buf\n");
+	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
+	printf("\t   default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
-	printf("e.g. -t mbm, mba, cqm, cat\n");
+	printf("e.g. -t mbm, mba, cmt, cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -50,17 +50,88 @@ void tests_cleanup(void)
 {
 	mbm_test_cleanup();
 	mba_test_cleanup();
-	cqm_test_cleanup();
+	cmt_test_cleanup();
+	cat_test_cleanup();
+}
+
+static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
+			 int cpu_no, char *bw_report)
+{
+	int res;
+
+	ksft_print_msg("Starting MBM BW change ...\n");
+
+	if (!validate_resctrl_feature_request(MBM_STR)) {
+		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
+		return;
+	}
+
+	if (!has_ben)
+		sprintf(benchmark_cmd[5], "%s", MBA_STR);
+	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
+	ksft_test_result(!res, "MBM: bw change\n");
+	mbm_test_cleanup();
+}
+
+static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
+			 int cpu_no, char *bw_report)
+{
+	int res;
+
+	ksft_print_msg("Starting MBA Schemata change ...\n");
+
+	if (!validate_resctrl_feature_request(MBA_STR)) {
+		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
+		return;
+	}
+
+	if (!has_ben)
+		sprintf(benchmark_cmd[1], "%d", span);
+	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+	ksft_test_result(!res, "MBA: schemata change\n");
+	mba_test_cleanup();
+}
+
+static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
+{
+	int res;
+
+	ksft_print_msg("Starting CMT test ...\n");
+	if (!validate_resctrl_feature_request(CMT_STR)) {
+		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
+		return;
+	}
+
+	if (!has_ben)
+		sprintf(benchmark_cmd[5], "%s", CMT_STR);
+	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
+	ksft_test_result(!res, "CMT: test\n");
+	cmt_test_cleanup();
+}
+
+static void run_cat_test(int cpu_no, int no_of_bits)
+{
+	int res;
+
+	ksft_print_msg("Starting CAT test ...\n");
+
+	if (!validate_resctrl_feature_request(CAT_STR)) {
+		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
+		return;
+	}
+
+	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+	ksft_test_result(!res, "CAT: test\n");
 	cat_test_cleanup();
 }
 
 int main(int argc, char **argv)
 {
-	bool has_ben = false, mbm_test = true, mba_test = true, cqm_test = true;
-	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
+	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
+	int c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
-	int ben_ind, ben_count;
+	int ben_ind, ben_count, tests = 0;
 	bool cat_test = true;
 
 	for (i = 0; i < argc; i++) {
@@ -73,7 +144,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	while ((c = getopt(argc_new, argv, "ht:b:")) != -1) {
+	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
 		char *token;
 
 		switch (c) {
@@ -82,17 +153,21 @@ int main(int argc, char **argv)
 
 			mbm_test = false;
 			mba_test = false;
-			cqm_test = false;
+			cmt_test = false;
 			cat_test = false;
 			while (token) {
-				if (!strcmp(token, "mbm")) {
+				if (!strncmp(token, MBM_STR, sizeof(MBM_STR))) {
 					mbm_test = true;
-				} else if (!strcmp(token, "mba")) {
+					tests++;
+				} else if (!strncmp(token, MBA_STR, sizeof(MBA_STR))) {
 					mba_test = true;
-				} else if (!strcmp(token, "cqm")) {
-					cqm_test = true;
-				} else if (!strcmp(token, "cat")) {
+					tests++;
+				} else if (!strncmp(token, CMT_STR, sizeof(CMT_STR))) {
+					cmt_test = true;
+					tests++;
+				} else if (!strncmp(token, CAT_STR, sizeof(CAT_STR))) {
 					cat_test = true;
+					tests++;
 				} else {
 					printf("invalid argument\n");
 
@@ -106,6 +181,10 @@ int main(int argc, char **argv)
 			break;
 		case 'n':
 			no_of_bits = atoi(optarg);
+			if (no_of_bits <= 0) {
+				printf("Bail out! invalid argument for no_of_bits\n");
+				return -1;
+			}
 			break;
 		case 'h':
 			cmd_help();
@@ -118,7 +197,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	printf("TAP version 13\n");
+	ksft_print_header();
 
 	/*
 	 * Typically we need root privileges, because:
@@ -126,7 +205,7 @@ int main(int argc, char **argv)
 	 * 2. We execute perf commands
 	 */
 	if (geteuid() != 0)
-		printf("# WARNING: not running as root, tests may fail.\n");
+		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
 
 	/* Detect AMD vendor */
 	detect_amd();
@@ -155,48 +234,26 @@ int main(int argc, char **argv)
 	sprintf(bw_report, "reads");
 	sprintf(bm_type, "fill_buf");
 
-	check_resctrlfs_support();
+	if (!check_resctrlfs_support())
+		return ksft_exit_fail_msg("resctrl FS does not exist\n");
+
 	filter_dmesg();
 
-	if (!is_amd && mbm_test) {
-		printf("# Starting MBM BW change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "mba");
-		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
-		printf("%sok MBM: bw change\n", res ? "not " : "");
-		mbm_test_cleanup();
-		tests_run++;
-	}
+	ksft_set_plan(tests ? : 4);
 
-	if (!is_amd && mba_test) {
-		printf("# Starting MBA Schemata change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[1], "%d", span);
-		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
-		printf("%sok MBA: schemata change\n", res ? "not " : "");
-		mba_test_cleanup();
-		tests_run++;
-	}
+	if (!is_amd && mbm_test)
+		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (cqm_test) {
-		printf("# Starting CQM test ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "cqm");
-		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
-		printf("%sok CQM: test\n", res ? "not " : "");
-		cqm_test_cleanup();
-		tests_run++;
-	}
+	if (!is_amd && mba_test)
+		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (cat_test) {
-		printf("# Starting CAT test ...\n");
-		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
-		printf("%sok CAT: test\n", res ? "not " : "");
-		tests_run++;
-		cat_test_cleanup();
-	}
+	if (cmt_test)
+		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
+
+	if (cat_test)
+		run_cat_test(cpu_no, no_of_bits);
 
-	printf("1..%d\n", tests_run);
+	umount_resctrlfs();
 
-	return 0;
+	return ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 520fea3606d1..95224345c78e 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -221,8 +221,8 @@ static int read_from_imc_dir(char *imc_dir, int count)
  */
 static int num_of_imcs(void)
 {
+	char imc_dir[512], *temp;
 	unsigned int count = 0;
-	char imc_dir[512];
 	struct dirent *ep;
 	int ret;
 	DIR *dp;
@@ -230,7 +230,25 @@ static int num_of_imcs(void)
 	dp = opendir(DYN_PMU_PATH);
 	if (dp) {
 		while ((ep = readdir(dp))) {
-			if (strstr(ep->d_name, UNCORE_IMC)) {
+			temp = strstr(ep->d_name, UNCORE_IMC);
+			if (!temp)
+				continue;
+
+			/*
+			 * imc counters are named as "uncore_imc_<n>", hence
+			 * increment the pointer to point to <n>. Note that
+			 * sizeof(UNCORE_IMC) would count for null character as
+			 * well and hence the last underscore character in
+			 * uncore_imc'_' need not be counted.
+			 */
+			temp = temp + sizeof(UNCORE_IMC);
+
+			/*
+			 * Some directories under "DYN_PMU_PATH" could have
+			 * names like "uncore_imc_free_running", hence, check if
+			 * first character is a numerical digit or not.
+			 */
+			if (temp[0] >= '0' && temp[0] <= '9') {
 				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
 					ep->d_name);
 				ret = read_from_imc_dir(imc_dir, count);
@@ -282,9 +300,9 @@ static int initialize_mem_bw_imc(void)
  * Memory B/W utilized by a process on a socket can be calculated using
  * iMC counters. Perf events are used to read these counters.
  *
- * Return: >= 0 on success. < 0 on failure.
+ * Return: = 0 on success. < 0 on failure.
  */
-static float get_mem_bw_imc(int cpu_no, char *bw_report)
+static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
 	int imc, j, ret;
@@ -355,13 +373,18 @@ static float get_mem_bw_imc(int cpu_no, char *bw_report)
 		close(imc_counters_config[imc][WRITE].fd);
 	}
 
-	if (strcmp(bw_report, "reads") == 0)
-		return reads;
+	if (strcmp(bw_report, "reads") == 0) {
+		*bw_imc = reads;
+		return 0;
+	}
 
-	if (strcmp(bw_report, "writes") == 0)
-		return writes;
+	if (strcmp(bw_report, "writes") == 0) {
+		*bw_imc = writes;
+		return 0;
+	}
 
-	return (reads + writes);
+	*bw_imc = reads + writes;
+	return 0;
 }
 
 void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
@@ -397,10 +420,10 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 		return;
 	}
 
-	if (strcmp(resctrl_val, "mbm") == 0)
+	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
 		set_mbm_path(ctrlgrp, mongrp, resource_id);
 
-	if ((strcmp(resctrl_val, "mba") == 0)) {
+	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		if (ctrlgrp)
 			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
 				RESCTRL_PATH, ctrlgrp, resource_id);
@@ -420,9 +443,8 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
  * 1. If con_mon grp is given, then read from it
  * 2. If con_mon grp is not given, then read from root con_mon grp
  */
-static unsigned long get_mem_bw_resctrl(void)
+static int get_mem_bw_resctrl(unsigned long *mbm_total)
 {
-	unsigned long mbm_total = 0;
 	FILE *fp;
 
 	fp = fopen(mbm_total_path, "r");
@@ -431,7 +453,7 @@ static unsigned long get_mem_bw_resctrl(void)
 
 		return -1;
 	}
-	if (fscanf(fp, "%lu", &mbm_total) <= 0) {
+	if (fscanf(fp, "%lu", mbm_total) <= 0) {
 		perror("Could not get mbm local bytes");
 		fclose(fp);
 
@@ -439,7 +461,7 @@ static unsigned long get_mem_bw_resctrl(void)
 	}
 	fclose(fp);
 
-	return mbm_total;
+	return 0;
 }
 
 pid_t bm_pid, ppid;
@@ -449,7 +471,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 	kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
 	tests_cleanup();
-	printf("Ending\n\n");
+	ksft_print_msg("Ending\n\n");
 
 	exit(EXIT_SUCCESS);
 }
@@ -492,7 +514,7 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 	return 0;
 }
 
-static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
+static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
 {
 	if (strlen(ctrlgrp) && strlen(mongrp))
 		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
@@ -512,7 +534,7 @@ static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
  * @ctrlgrp:			Name of the control monitor group (con_mon grp)
  * @mongrp:			Name of the monitor group (mon grp)
  * @cpu_no:			CPU number that the benchmark PID is binded to
- * @resctrl_val:		Resctrl feature (Eg: cat, cqm.. etc)
+ * @resctrl_val:		Resctrl feature (Eg: cat, cmt.. etc)
  */
 static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 					int cpu_no, char *resctrl_val)
@@ -524,14 +546,15 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 		return;
 	}
 
-	if (strcmp(resctrl_val, "cqm") == 0)
-		set_cqm_path(ctrlgrp, mongrp, resource_id);
+	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
+		set_cmt_path(ctrlgrp, mongrp, resource_id);
 }
 
 static int
 measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 {
-	unsigned long bw_imc, bw_resc, bw_resc_end;
+	unsigned long bw_resc, bw_resc_end;
+	float bw_imc;
 	int ret;
 
 	/*
@@ -541,13 +564,13 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 	 * Compare the two values to validate resctrl value.
 	 * It takes 1sec to measure the data.
 	 */
-	bw_imc = get_mem_bw_imc(param->cpu_no, param->bw_report);
-	if (bw_imc <= 0)
-		return bw_imc;
+	ret = get_mem_bw_imc(param->cpu_no, param->bw_report, &bw_imc);
+	if (ret < 0)
+		return ret;
 
-	bw_resc_end = get_mem_bw_resctrl();
-	if (bw_resc_end <= 0)
-		return bw_resc_end;
+	ret = get_mem_bw_resctrl(&bw_resc_end);
+	if (ret < 0)
+		return ret;
 
 	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
 	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
@@ -579,8 +602,8 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
 
-	if ((strcmp(resctrl_val, "mba")) == 0 ||
-	    (strcmp(resctrl_val, "mbm")) == 0) {
+	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
+	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
 		ret = validate_bw_report_request(param->bw_report);
 		if (ret)
 			return ret;
@@ -645,7 +668,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 		PARENT_EXIT("Child is done");
 	}
 
-	printf("# benchmark PID: %d\n", bm_pid);
+	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
 
 	/*
 	 * Register CTRL-C handler for parent, as it has to kill benchmark
@@ -674,15 +697,15 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (ret)
 		goto out;
 
-	if ((strcmp(resctrl_val, "mbm") == 0) ||
-	    (strcmp(resctrl_val, "mba") == 0)) {
+	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
+	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		ret = initialize_mem_bw_imc();
 		if (ret)
 			goto out;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
-	} else if (strcmp(resctrl_val, "cqm") == 0)
+	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
 					    param->cpu_no, resctrl_val);
 
@@ -710,8 +733,8 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if ((strcmp(resctrl_val, "mbm") == 0) ||
-		    (strcmp(resctrl_val, "mba") == 0)) {
+		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
+		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
@@ -721,7 +744,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 			ret = measure_vals(param, &bw_resc_start);
 			if (ret)
 				break;
-		} else if (strcmp(resctrl_val, "cqm") == 0) {
+		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 19c0ec4045a4..5f5a166ade60 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -10,8 +10,6 @@
  */
 #include "resctrl.h"
 
-int tests_run;
-
 static int find_resctrl_mount(char *buffer)
 {
 	FILE *mounts;
@@ -49,8 +47,6 @@ static int find_resctrl_mount(char *buffer)
 	return -ENOENT;
 }
 
-char cbm_mask[256];
-
 /*
  * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
  * @mum_resctrlfs:	Should the resctrl FS be remounted?
@@ -70,28 +66,25 @@ int remount_resctrlfs(bool mum_resctrlfs)
 	if (ret)
 		strcpy(mountpoint, RESCTRL_PATH);
 
-	if (!ret && mum_resctrlfs && umount(mountpoint)) {
-		printf("not ok unmounting \"%s\"\n", mountpoint);
-		perror("# umount");
-		tests_run++;
-	}
+	if (!ret && mum_resctrlfs && umount(mountpoint))
+		ksft_print_msg("Fail: unmounting \"%s\"\n", mountpoint);
 
 	if (!ret && !mum_resctrlfs)
 		return 0;
 
+	ksft_print_msg("Mounting resctrl to \"%s\"\n", RESCTRL_PATH);
 	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
-	printf("%sok mounting resctrl to \"%s\"\n", ret ? "not " : "",
-	       RESCTRL_PATH);
 	if (ret)
 		perror("# mount");
 
-	tests_run++;
-
 	return ret;
 }
 
 int umount_resctrlfs(void)
 {
+	if (find_resctrl_mount(NULL))
+		return 0;
+
 	if (umount(RESCTRL_PATH)) {
 		perror("# Unable to umount resctrl");
 
@@ -205,16 +198,18 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 /*
  * get_cbm_mask - Get cbm mask for given cache
  * @cache_type:	Cache level L2/L3
- *
- * Mask is stored in cbm_mask which is global variable.
+ * @cbm_mask:	cbm_mask returned as a string
  *
  * Return: = 0 on success, < 0 on failure.
  */
-int get_cbm_mask(char *cache_type)
+int get_cbm_mask(char *cache_type, char *cbm_mask)
 {
 	char cbm_mask_path[1024];
 	FILE *fp;
 
+	if (!cbm_mask)
+		return -1;
+
 	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH, cache_type);
 
 	fp = fopen(cbm_mask_path, "r");
@@ -268,7 +263,7 @@ int get_core_sibling(int cpu_no)
 	while (token) {
 		sibling_cpu_no = atoi(token);
 		/* Skipping core 0 as we don't want to run test on core 0 */
-		if (sibling_cpu_no != 0)
+		if (sibling_cpu_no != 0 && sibling_cpu_no != cpu_no)
 			break;
 		token = strtok(NULL, "-,");
 	}
@@ -334,7 +329,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		operation = atoi(benchmark_cmd[4]);
 		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
 
-		if (strcmp(resctrl_val, "cqm") != 0)
+		if (strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 			buffer_span = span * MB;
 		else
 			buffer_span = span;
@@ -458,9 +453,9 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 	if (ret)
 		goto out;
 
-	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
-	if ((strcmp(resctrl_val, "cqm") == 0) ||
-	    (strcmp(resctrl_val, "mbm") == 0)) {
+	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
+	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)) ||
+	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
 		if (strlen(mongrp)) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
@@ -477,13 +472,10 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 	}
 
 out:
-	printf("%sok writing benchmark parameters to resctrl FS\n",
-	       ret ? "not " : "");
+	ksft_print_msg("Writing benchmark parameters to resctrl FS\n");
 	if (ret)
 		perror("# writing to resctrlfs");
 
-	tests_run++;
-
 	return ret;
 }
 
@@ -505,13 +497,13 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	int resource_id, ret = 0;
 	FILE *fp;
 
-	if ((strcmp(resctrl_val, "mba") != 0) &&
-	    (strcmp(resctrl_val, "cat") != 0) &&
-	    (strcmp(resctrl_val, "cqm") != 0))
+	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
+	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
+	    strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		return -ENOENT;
 
 	if (!schemata) {
-		printf("# Skipping empty schemata update\n");
+		ksft_print_msg("Skipping empty schemata update\n");
 
 		return -1;
 	}
@@ -528,9 +520,10 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
+	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
-	if (strcmp(resctrl_val, "mba") == 0)
+	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
 		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
 
 	fp = fopen(controlgroup, "w");
@@ -551,10 +544,9 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	fclose(fp);
 
 out:
-	printf("%sok Write schema \"%s\" to resctrl FS%s%s\n",
-	       ret ? "not " : "", schema, ret ? " # " : "",
-	       ret ? reason : "");
-	tests_run++;
+	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
+		       schema, ret ? " # " : "",
+		       ret ? reason : "");
 
 	return ret;
 }
@@ -578,18 +570,20 @@ bool check_resctrlfs_support(void)
 
 	fclose(inf);
 
-	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");
-	tests_run++;
+	ksft_print_msg("%s Check kernel supports resctrl filesystem\n",
+		       ret ? "Pass:" : "Fail:");
+
+	if (!ret)
+		return ret;
 
 	dp = opendir(RESCTRL_PATH);
-	printf("%sok resctrl mountpoint \"%s\" exists\n",
-	       dp ? "" : "not ", RESCTRL_PATH);
+	ksft_print_msg("%s Check resctrl mountpoint \"%s\" exists\n",
+		       dp ? "Pass:" : "Fail:", RESCTRL_PATH);
 	if (dp)
 		closedir(dp);
-	tests_run++;
 
-	printf("# resctrl filesystem %s mounted\n",
-	       find_resctrl_mount(NULL) ? "not" : "is");
+	ksft_print_msg("resctrl filesystem %s mounted\n",
+		       find_resctrl_mount(NULL) ? "not" : "is");
 
 	return ret;
 }
@@ -615,26 +609,56 @@ char *fgrep(FILE *inf, const char *str)
  * validate_resctrl_feature_request - Check if requested feature is valid.
  * @resctrl_val:	Requested feature
  *
- * Return: 0 on success, non-zero on failure
+ * Return: True if the feature is supported, else false
  */
-bool validate_resctrl_feature_request(char *resctrl_val)
+bool validate_resctrl_feature_request(const char *resctrl_val)
 {
-	FILE *inf = fopen("/proc/cpuinfo", "r");
+	struct stat statbuf;
 	bool found = false;
 	char *res;
+	FILE *inf;
 
-	if (!inf)
+	if (!resctrl_val)
 		return false;
 
-	res = fgrep(inf, "flags");
-
-	if (res) {
-		char *s = strchr(res, ':');
+	if (remount_resctrlfs(false))
+		return false;
 
-		found = s && !strstr(s, resctrl_val);
-		free(res);
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
+		if (!stat(L3_PATH, &statbuf))
+			return true;
+	} else if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
+		if (!stat(MB_PATH, &statbuf))
+			return true;
+	} else if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
+		   !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
+		if (!stat(L3_MON_PATH, &statbuf)) {
+			inf = fopen(L3_MON_FEATURES_PATH, "r");
+			if (!inf)
+				return false;
+
+			if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
+				res = fgrep(inf, "llc_occupancy");
+				if (res) {
+					found = true;
+					free(res);
+				}
+			}
+
+			if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
+				res = fgrep(inf, "mbm_total_bytes");
+				if (res) {
+					free(res);
+					res = fgrep(inf, "mbm_local_bytes");
+					if (res) {
+						found = true;
+						free(res);
+					}
+				}
+			}
+			fclose(inf);
+		}
 	}
-	fclose(inf);
 
 	return found;
 }
@@ -671,9 +695,9 @@ int filter_dmesg(void)
 
 	while (fgets(line, 1024, fp)) {
 		if (strstr(line, "intel_rdt:"))
-			printf("# dmesg: %s", line);
+			ksft_print_msg("dmesg: %s", line);
 		if (strstr(line, "resctrl:"))
-			printf("# dmesg: %s", line);
+			ksft_print_msg("dmesg: %s", line);
 	}
 	fclose(fp);
 	waitpid(pid, NULL, 0);
diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index bfc974b4572d..2d66abd877e6 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -3,7 +3,7 @@
  *		(C) Copyright IBM 2012
  *		Licensed under the GPLv2
  *
- *  NOTE: This is a meta-test which quickly changes the clocksourc and
+ *  NOTE: This is a meta-test which quickly changes the clocksource and
  *  then uses other tests to detect problems. Thus this test requires
  *  that the inconsistency-check and nanosleep tests be present in the
  *  same directory it is run from.

--------------F142053B21395AE3B5C11899--
