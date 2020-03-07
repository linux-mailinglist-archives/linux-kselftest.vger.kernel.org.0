Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E308317CBA7
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 04:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCGDqS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 22:46:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:57584 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgCGDqS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 22:46:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 19:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="235036021"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2020 19:46:17 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V1 07/13] selftests/resctrl: Don't use variable argument list for setup function
Date:   Fri,  6 Mar 2020 19:40:48 -0800
Message-Id: <4d2f519c9a67d86e71f8fe6fd281f1e39cfe4e49.1583657204.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

struct resctrl_val_param has setup() function that accepts variable
argument list. But, presently, all the test cases use only 1 argument as
input and it's struct resctrl_val_param *. So, instead of variable argument
list, directly pass struct resctrl_val_param * as parameter.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 2 +-
 tools/testing/selftests/resctrl/cat_test.c    | 8 +-------
 tools/testing/selftests/resctrl/cqm_test.c    | 9 +--------
 tools/testing/selftests/resctrl/mba_test.c    | 8 +-------
 tools/testing/selftests/resctrl/mbm_test.c    | 8 +-------
 tools/testing/selftests/resctrl/resctrl.h     | 2 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 4 ++--
 7 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 38dbf4962e33..1cbcd7fbe216 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -243,7 +243,7 @@ int cat_val(struct resctrl_val_param *param)
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
 		if (strcmp(resctrl_val, "cat") == 0) {
-			ret = param->setup(1, param);
+			ret = param->setup(param);
 			if (ret) {
 				ret = 0;
 				break;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 5da43767b973..046c7f285e72 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -27,17 +27,11 @@ unsigned long cache_size;
  * con_mon grp, mon_grp in resctrl FS.
  * Run 5 times in order to get average values.
  */
-static int cat_setup(int num, ...)
+static int cat_setup(struct resctrl_val_param *p)
 {
-	struct resctrl_val_param *p;
 	char schemata[64];
-	va_list param;
 	int ret = 0;
 
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
-
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
 		return -1;
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
index fb4797cfda09..f27b0363e518 100644
--- a/tools/testing/selftests/resctrl/cqm_test.c
+++ b/tools/testing/selftests/resctrl/cqm_test.c
@@ -21,15 +21,8 @@ char cbm_mask[256];
 unsigned long long_mask;
 unsigned long cache_size;
 
-static int cqm_setup(int num, ...)
+static int cqm_setup(struct resctrl_val_param *p)
 {
-	struct resctrl_val_param *p;
-	va_list param;
-
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
-
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
 		return -1;
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 165e5123e040..0f85e5be390d 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -22,16 +22,10 @@
  * con_mon grp, mon_grp in resctrl FS.
  * For each allocation, run 5 times in order to get average values.
  */
-static int mba_setup(int num, ...)
+static int mba_setup(struct resctrl_val_param *p)
 {
 	static int runs_per_allocation, allocation = 100;
-	struct resctrl_val_param *p;
 	char allocation_str[64];
-	va_list param;
-
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
 
 	if (runs_per_allocation >= NUM_OF_RUNS)
 		runs_per_allocation = 0;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 530ec5bec0b9..9e847641516a 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -84,21 +84,15 @@ static int check_results(int span)
 	return 0;
 }
 
-static int mbm_setup(int num, ...)
+static int mbm_setup(struct resctrl_val_param *p)
 {
-	struct resctrl_val_param *p;
 	static int num_of_runs;
-	va_list param;
 	int ret = 0;
 
 	/* Run NUM_OF_RUNS times */
 	if (num_of_runs++ >= NUM_OF_RUNS)
 		return -1;
 
-	va_start(param, num);
-	p = va_arg(param, struct resctrl_val_param *);
-	va_end(param);
-
 	/* Set up shemata with 100% allocation on the first run. */
 	if (num_of_runs == 0)
 		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 39bf59c6b9c5..e320e79bc4d4 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -59,7 +59,7 @@ struct resctrl_val_param {
 	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
-	int		(*setup)(int num, ...);
+	int		(*setup)(struct resctrl_val_param *param);
 };
 
 pid_t bm_pid, ppid;
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 520fea3606d1..271cb5c976f5 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -712,7 +712,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	while (1) {
 		if ((strcmp(resctrl_val, "mbm") == 0) ||
 		    (strcmp(resctrl_val, "mba") == 0)) {
-			ret = param->setup(1, param);
+			ret = param->setup(param);
 			if (ret) {
 				ret = 0;
 				break;
@@ -722,7 +722,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 			if (ret)
 				break;
 		} else if (strcmp(resctrl_val, "cqm") == 0) {
-			ret = param->setup(1, param);
+			ret = param->setup(param);
 			if (ret) {
 				ret = 0;
 				break;
-- 
2.7.4

