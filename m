Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81131D8A7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgERWOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:46558 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgERWOB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:14:01 -0400
IronPort-SDR: MPy1Pfu+HzVbltSSssgU5vfmyJQbPkOKaTemSSR7o+IMC2dzFx+Vpyd1V15Catxua+y2/zvXjn
 Bbl2TXG8qcmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:14:00 -0700
IronPort-SDR: DjRAtaYLlKkurEdP+4JdGMtsfB4sCtVkB7qsz85lkYvVRqEfCKPPl+09o4rECL27bvCXYdeX5Z
 sglvHKhKBG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420393"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:14:00 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 13/19] selftests/resctrl: Dynamically select buffer size for CAT test
Date:   Mon, 18 May 2020 15:08:33 -0700
Message-Id: <f687ffb8b1d04a2c3cd6e374eaa8c02f8b473377.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Presently, while running CAT test case, if user hasn't given any input for
'-n' option, the test defaults to 5 bits to determine the buffer size that
is used during test. This might become a problem on system with max_cbm
mask <= 5 bits. Hence, instead of statically running always with 5 bits,
change it such that the buffer size is always half of the cache size.

Please note that CMT test is still hard coded with 5 bits. It will change
in subsequent patches that change CMT test.

Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
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
index f005ba2b41ec..fb7703413be7 100644
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
2.19.1

