Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D525F33024B
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhCGOzd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:5870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhCGOzL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:11 -0500
IronPort-SDR: wR6fCXgXXy2p9Up8a0/+r6n6Oo+9UEAeYbBsX2mjhhdQweySOMTIfw73UCeD+ThQev3++/3+P3
 vZCSbRDINPhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813502"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813502"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: fP5Vrb2HEt5HigrUbyciwM0tckYkNBW1WGsB5gReczgFwo3ktqiwD3NwgNS0Uh1IZ8NVLZ4my0
 iCa0WgHQ52yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189131"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 15/21] selftests/resctrl: Don't hard code value of "no_of_bits" variable
Date:   Sun,  7 Mar 2021 14:54:56 +0000
Message-Id: <20210307145502.2916364-16-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cache related tests (like CAT and CMT) depend on a variable called
no_of_bits to run. no_of_bits defines the number of contiguous bits
that should be set in the CBM mask and a user can pass a value for
no_of_bits using -n command line argument. If a user hasn't passed any
value, it defaults to 5 (randomly chosen value).

Hard coding no_of_bits to 5 will make the cache tests fail to run on
systems that support maximum cbm mask that is less than or equal to 5 bits.
Hence, don't hard code no_of_bits value.

If a user passes a value for "no_of_bits" using -n option, use it.
Otherwise, no_of_bits is equal to half of the maximum number of bits in
the cbm mask.

Please note that CMT test is still hard coded to 5 bits. It will change in
subsequent patches that change CMT test.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c      | 5 ++++-
 tools/testing/selftests/resctrl/resctrl_tests.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 109363e9a7d7..58f075aa0423 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -130,7 +130,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Get max number of bits from default-cabm mask */
 	count_of_bits = count_bits(long_mask);
 
-	if (n < 1 || n > count_of_bits - 1) {
+	if (!n)
+		n = count_of_bits / 2;
+
+	if (n > count_of_bits - 1) {
 		ksft_print_msg("Invalid input value for no_of_bits n!\n");
 		ksft_print_msg("Please Enter value in range 1 to %d\n",
 			       count_of_bits - 1);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index f1b08afbc3d0..56900738edd6 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -57,7 +57,7 @@ void tests_cleanup(void)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
+	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int ben_ind, ben_count, tests = 0;
@@ -110,6 +110,10 @@ int main(int argc, char **argv)
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
@@ -188,7 +192,7 @@ int main(int argc, char **argv)
 		ksft_print_msg("Starting CMT test ...\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "cmt");
-		res = cmt_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
+		res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 		ksft_test_result(!res, "CMT: test\n");
 		cmt_test_cleanup();
 	}
-- 
2.30.1

