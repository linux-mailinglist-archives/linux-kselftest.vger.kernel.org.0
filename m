Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168BD7D4C41
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjJXJ3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjJXJ3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:29:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F81BF6;
        Tue, 24 Oct 2023 02:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139701; x=1729675701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5TJ7qV+EW+iJ9ZdFNVeU3a2hKS++KMxkkRhcp+n3/fI=;
  b=C8In/bdkTbVNTYjrBrv2zquYbqHWiYNDvMaWpJxfHqNM//1LDQp24Xm4
   ninDaDRoMrCQsy4WQxW0TGEzbZv42m1wX5gEhDMKy9Lhbvag2zFvSyvga
   gelF8RjL0JzmmH8r2qvAQY90Mg0GuGxQjXG9Kcee4ScYCBLQ1AGXpY2kN
   Sc7zxXfqawgPj5xO9MFEkhn9WwVbzW1B0cfxN1/JAes1BzCef7HJ9vIwW
   /QHhTnqDiUsL6hvvEQSOjcE5GWiUm2gHK3hlgkg75YqzIjnimQRJ/KYNY
   7vpaB7N0DEzcuRTEzWVaJ5tGNyIg9KQ+Tgimw/rqk/k4JjJmNoU6blQUi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386829543"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="386829543"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828754667"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="828754667"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/24] selftests/resctrl: Consolidate naming of perf event related things
Date:   Tue, 24 Oct 2023 12:26:21 +0300
Message-Id: <20231024092634.7122-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Naming for perf event related functions, types, and variables is
currently inconsistent.

Make struct read_format and all functions related to perf events start
with perf_event. Adjust variable names towards the same direction
but use shorter names for variables where appropriate (pe prefix).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 46 ++++++++++++-------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 208af1ecae28..a70ace82e76e 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -3,7 +3,7 @@
 #include <stdint.h>
 #include "resctrl.h"
 
-struct read_format {
+struct perf_event_read {
 	__u64 nr;			/* The number of events */
 	struct {
 		__u64 value;		/* The value of the event */
@@ -11,11 +11,11 @@ struct read_format {
 };
 
 static struct perf_event_attr pea_llc_miss;
-static struct read_format rf_cqm;
-static int fd_lm;
+static struct perf_event_read pe_read;
+static int pe_fd;
 char llc_occup_path[1024];
 
-static void initialize_perf_event_attr(void)
+static void perf_event_attr_initialize(void)
 {
 	pea_llc_miss.type = PERF_TYPE_HARDWARE;
 	pea_llc_miss.size = sizeof(struct perf_event_attr);
@@ -29,31 +29,31 @@ static void initialize_perf_event_attr(void)
 	pea_llc_miss.disabled = 1;
 }
 
-static void initialize_llc_perf(void)
+static void perf_event_initialize(void)
 {
 	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
-	memset(&rf_cqm, 0, sizeof(struct read_format));
+	memset(&pe_read, 0, sizeof(struct perf_event_read));
 
 	/* Initialize perf_event_attr structures for HW_CACHE_MISSES */
-	initialize_perf_event_attr();
+	perf_event_attr_initialize();
 
 	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
 
-	rf_cqm.nr = 1;
+	pe_read.nr = 1;
 }
 
-static int reset_enable_llc_perf(pid_t pid, int cpu_no)
+static int perf_event_reset_enable(pid_t pid, int cpu_no)
 {
-	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
-	if (fd_lm == -1) {
+	pe_fd = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
+	if (pe_fd == -1) {
 		perror("Error opening leader");
 		ctrlc_handler(0, NULL, NULL);
 		return -1;
 	}
 
 	/* Start counters to log values */
-	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
-	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
 
 	return 0;
 }
@@ -122,28 +122,28 @@ static int print_results_cache(char *filename, int bm_pid, __u64 llc_value)
 }
 
 /*
- * measure_llc_perf:	measure perf events
+ * perf_event_measure:	measure perf events
  * @bm_pid:	child pid that runs benchmark
  *
  * Measure things like cache misses from perf events.
  *
  * Return: =0 on success.  <0 on failure.
  */
-static int measure_llc_perf(struct resctrl_val_param *param, int bm_pid)
+static int perf_event_measure(struct resctrl_val_param *param, int bm_pid)
 {
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
-	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
 
-	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
-	close(fd_lm);
+	ret = read(pe_fd, &pe_read, sizeof(struct perf_event_read));
+	close(pe_fd);
 	if (ret == -1) {
 		perror("Could not get perf value");
 		return -1;
 	}
 
-	return print_results_cache(param->filename, bm_pid, rf_cqm.values[0].value);
+	return print_results_cache(param->filename, bm_pid, pe_read.values[0].value);
 }
 
 int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
@@ -192,7 +192,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
-	initialize_llc_perf();
+	perf_event_initialize();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
@@ -203,7 +203,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 		if (ret < 0)
 			break;
-		ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
+		ret = perf_event_reset_enable(bm_pid, param->cpu_no);
 		if (ret)
 			break;
 
@@ -214,7 +214,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 
 		sleep(1);
-		ret = measure_llc_perf(param, bm_pid);
+		ret = perf_event_measure(param, bm_pid);
 		if (ret)
 			goto pe_close;
 	}
@@ -222,7 +222,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	return ret;
 
 pe_close:
-	close(fd_lm);
+	close(pe_fd);
 	return ret;
 }
 
-- 
2.30.2

