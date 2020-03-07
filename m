Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF817CB9F
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 04:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCGDq0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 22:46:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:57586 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgCGDqW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 22:46:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 19:46:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="235036048"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2020 19:46:21 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V1 12/13] selftests/resctrl: Dynamically select buffer size for CAT test
Date:   Fri,  6 Mar 2020 19:40:53 -0800
Message-Id: <18ab8b47d1d2b6373d7899bdf8df19fa94afcfaa.1583657204.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Presently, while running CAT test case, if user hasn't given any input for
'-n' option, the test defaults to 5 bits to determine the buffer size that
is used during test. Instead of statically running always with 5 bits,
change it such that the buffer size is always half of the cache size.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c      | 16 +++++++++++-----
 tools/testing/selftests/resctrl/resctrl.h       |  3 ++-
 tools/testing/selftests/resctrl/resctrl_tests.c |  7 ++++---
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index f7a67f005fe5..d1c50430ab20 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -109,7 +109,8 @@ void cat_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-static int prepare_masks_for_two_processes(int no_of_bits, char *cache_type)
+static int prepare_masks_for_two_processes(int *no_of_bits, bool user_bits,
+					   char *cache_type)
 {
 	int ret, i;
 	unsigned long long_mask, shareable_mask;
@@ -123,12 +124,15 @@ static int prepare_masks_for_two_processes(int no_of_bits, char *cache_type)
 	long_mask = strtoul(cbm_mask, NULL, 16);
 	count_of_bits = count_bits(long_mask);
 
+	if (!user_bits)
+		*no_of_bits = count_of_bits / 2;
+
 	/*
 	 * Max limit is count_of_bits - 1 because we need exclusive masks for
 	 * the two processes. So, the last saved bit will be used by the other
 	 * process.
 	 */
-	if (no_of_bits < 1 || no_of_bits > count_of_bits - 1) {
+	if (*no_of_bits < 1 || *no_of_bits > count_of_bits - 1) {
 		printf("Invalid input value for no_of_bits 'n'\n");
 		printf("Please Enter value in range 1 to %d\n",
 		       count_of_bits - 1);
@@ -140,7 +144,7 @@ static int prepare_masks_for_two_processes(int no_of_bits, char *cache_type)
 		return ret;
 
 	/* Prepare cbm mask without any shareable bits */
-	for (i = 0; i < no_of_bits; i++) {
+	for (i = 0; i < *no_of_bits; i++) {
 		p1_mask <<= 1;
 		p1_mask |= 1;
 	}
@@ -176,7 +180,8 @@ static int start_noisy_process(pid_t pid, int sibling_cpu_no)
 	return 0;
 }
 
-int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type)
+int cat_perf_miss_val(int cpu_no, int no_of_bits, bool user_bits,
+		      char *cache_type)
 {
 	int ret, sibling_cpu_no;
 	unsigned long buf_size;
@@ -194,7 +199,8 @@ int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type)
 	if (!validate_resctrl_feature_request("cat"))
 		return -1;
 
-	ret = prepare_masks_for_two_processes(no_of_bits, cache_type);
+	ret = prepare_masks_for_two_processes(&no_of_bits, user_bits,
+					      cache_type);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index cb67ad689475..393f2f34ccac 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -102,7 +102,8 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int setup_critical_process(pid_t pid, struct resctrl_val_param *param);
 int run_critical_process(pid_t pid, struct resctrl_val_param *param);
 void cat_test_cleanup(void);
-int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
+int cat_perf_miss_val(int cpu_no, int no_of_bits, bool user_bits,
+		      char *cache_type);
 int cqm_schemata_change(int cpu_no, int span, char *cache_type,
 			char **benchmark_cmd);
 unsigned int count_bits(unsigned long n);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3c408c636b6d..4461c3dc8cce 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -57,11 +57,11 @@ void tests_cleanup(void)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cqm_test = true;
-	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
+	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int ben_ind, ben_count;
-	bool cat_test = true;
+	bool cat_test = true, user_bits = false;
 
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
@@ -105,6 +105,7 @@ int main(int argc, char **argv)
 			cpu_no = atoi(optarg);
 			break;
 		case 'n':
+			user_bits = true;
 			no_of_bits = atoi(optarg);
 			break;
 		case 'h':
@@ -192,7 +193,7 @@ int main(int argc, char **argv)
 
 	if (cat_test) {
 		printf("# Starting CAT test ...\n");
-		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+		res = cat_perf_miss_val(cpu_no, no_of_bits, user_bits, "L3");
 		printf("%sok CAT: test\n", res ? "not " : "");
 		cat_test_cleanup();
 		tests_run++;
-- 
2.7.4

