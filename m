Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7537929458D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439396AbgJTXvj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:11170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439383AbgJTXvi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:38 -0400
IronPort-SDR: 0NXVAYk8t44ewDEJwQMkTtgkCQUqml1Pp09jRwOhb8DHeY61NnLJmudt9wBIXW6iV1XLDDw0S/
 8HxA+ezCA8gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486364"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486364"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:32 -0700
IronPort-SDR: LenO+0omYoy+QePb68FFyACvDU7YBUzp8qM7f49cphTvIxeWyq6UF98u3swWUmoyyIAsP3g/BW
 qIXGaXpnPkCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833853"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:31 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 13/21] selftests/resctrl: Don't hard code value of "no_of_bits" variable
Date:   Tue, 20 Oct 2020 23:51:18 +0000
Message-Id: <20201020235126.1871815-14-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
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

Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c      | 5 ++++-
 tools/testing/selftests/resctrl/resctrl_tests.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 5da43767b973..1bce84e23783 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -151,7 +151,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Get max number of bits from default-cabm mask */
 	count_of_bits = count_bits(long_mask);
 
-	if (n < 1 || n > count_of_bits - 1) {
+	if (!n)
+		n = count_of_bits / 2;
+
+	if (n > count_of_bits - 1) {
 		printf("Invalid input value for no_of_bits n!\n");
 		printf("Please Enter value in range 1 to %d\n",
 		       count_of_bits - 1);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index f4867a81eee6..5c217d0228f4 100644
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
 	int ben_ind, ben_count;
@@ -106,6 +106,10 @@ int main(int argc, char **argv)
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
 		printf("# Starting CMT test ...\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "cmt");
-		res = cmt_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
+		res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 		printf("%sok CMT: test\n", res ? "not " : "");
 		cmt_test_cleanup();
 		tests_run++;
-- 
2.29.0

