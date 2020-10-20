Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D326E294590
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439409AbgJTXvl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:11172 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439398AbgJTXvj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:39 -0400
IronPort-SDR: DHPY2SsCSDkOo2Odk76EUjgLWTuUciXdmbR4jOwjO+Mft5a2yLEGM2TdEz7kYc/G768anKHHeQ
 W3kNoKEXqf6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486369"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:33 -0700
IronPort-SDR: 0R0rGImrLpj12vuleuFIvuDGm1P5HmSNroB8VJYrNKk+THM0pwi3+mN1BZjQX6M+//YMkkFPX7
 /zaIhqjMXXHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833894"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:33 -0700
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
Subject: [PATCH v3 18/21] selftests/resctrl: Fix incorrect parsing of iMC counters
Date:   Tue, 20 Oct 2020 23:51:23 +0000
Message-Id: <20201020235126.1871815-19-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

iMC (Integrated Memory Controller) counters are usually at
"/sys/bus/event_source/devices/" and are named as "uncore_imc_<n>".
num_of_imcs() function tries to count number of such iMC counters so that
it could appropriately initialize required number of perf_attr structures
that could be used to read these iMC counters.

num_of_imcs() function assumes that all the directories under this path
that start with "uncore_imc" are iMC counters. But, on some systems there
could be directories named as "uncore_imc_free_running" which aren't iMC
counters. Trying to read from such directories will result in "not found
file" errors and MBM/MBA tests will fail.

Hence, fix the logic in num_of_imcs() such that it looks at the first
character after "uncore_imc_" to check if it's a numerical digit or not. If
it's a digit then the directory represents an iMC counter, else, skip the
directory.

Fixes: 7f4d257e3a2a ("selftests/resctrl: Add callback to start a benchmark")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 270cd95e0026..88f9b641d753 100644
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
-- 
2.29.0

