Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899E233024A
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhCGOzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:5870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhCGOzL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:11 -0500
IronPort-SDR: yHA3RAof9jhyaNCJ1wcbywRXRgyMAscn3OiRdujassW2RfoPdauNqgKd5peHTCFQWT1s7PonSM
 qcVHZoQb7bnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813506"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813506"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: /jt6fYrmSu3+qmN9DxWd4Ra9OOGZ9qeY6mP1hJ0LimT2T9W4g3ZZj2HFMuY/7IR3ne0Jz0JkPJ
 wWDcDo0DAULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189144"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 19/21] selftests/resctrl: Fix incorrect parsing of iMC counters
Date:   Sun,  7 Mar 2021 14:55:00 +0000
Message-Id: <20210307145502.2916364-20-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
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

Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 48bcd5fd7d79..de99d398ebfb 100644
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
2.30.1

