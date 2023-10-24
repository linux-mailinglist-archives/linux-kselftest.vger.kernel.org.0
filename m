Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83B7D4C46
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjJXJ3g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjJXJ3R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:29:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F01712;
        Tue, 24 Oct 2023 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139718; x=1729675718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mFZKHeamlLZ+ycNh2qTCIXTUBPT6HqNoVKwHnY1lXRs=;
  b=gkd7rTTjEWHFcjw3PQX9QHOR96ApYFhZfM/48N+xOXLiHn73RFRl5RkH
   rk8xxg46uPqZBp+YDWqTPGmOyChal6ptypxcLIbbCb0voIENOiGCsQOm6
   uA6FPdTtolC428z8R9XsANL+aR8BiKWzSp5cLVK5dHGTON50nA7kxVyyh
   pLnNxOEj9r5aQ5YNOcOvLn2af236un9f1DgvLldlhsWD4XHqdReAhI9c5
   /Ez8AoBknJXY8hexvcqlBEF32HBALQ7bfYh6zWuk2J5LOtYAscJ4Q9UAI
   6x6cGBIh+nkdGPmEBY8ltxVUm4bkfogauEuhpweZ2ATOBFQ36STRgRsYu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386829582"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="386829582"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828754688"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="828754688"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:34 -0700
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
Subject: [PATCH 13/24] selftests/resctrl: Convert perf related globals to locals
Date:   Tue, 24 Oct 2023 12:26:23 +0300
Message-Id: <20231024092634.7122-14-ilpo.jarvinen@linux.intel.com>
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

Perf related variables pea_llc_miss, pe_read, and pe_fd are globals in
cache.c.

Convert them to locals for better scoping and make pea_llc_miss simpler
by renaming it to pea. Make close(pe_fd) handling easier to understand
by doing it inside cat_val().

Make also sizeof()s use safer way determine the right struct.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 69 ++++++++++++++-----------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index a84679a4ac0c..a65e2e35c33c 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -10,36 +10,35 @@ struct perf_event_read {
 	} values[2];
 };
 
-static struct perf_event_attr pea_llc_miss;
-static struct perf_event_read pe_read;
-static int pe_fd;
 char llc_occup_path[1024];
 
-static void perf_event_attr_initialize(__u64 config)
+static void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config)
 {
-	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
-	pea_llc_miss.type = PERF_TYPE_HARDWARE;
-	pea_llc_miss.size = sizeof(struct perf_event_attr);
-	pea_llc_miss.read_format = PERF_FORMAT_GROUP;
-	pea_llc_miss.exclude_kernel = 1;
-	pea_llc_miss.exclude_hv = 1;
-	pea_llc_miss.exclude_idle = 1;
-	pea_llc_miss.exclude_callchain_kernel = 1;
-	pea_llc_miss.inherit = 1;
-	pea_llc_miss.exclude_guest = 1;
-	pea_llc_miss.disabled = 1;
-	pea_llc_miss.config = config;
+	memset(pea, 0, sizeof(*pea));
+	pea->type = PERF_TYPE_HARDWARE;
+	pea->size = sizeof(struct perf_event_attr);
+	pea->read_format = PERF_FORMAT_GROUP;
+	pea->exclude_kernel = 1;
+	pea->exclude_hv = 1;
+	pea->exclude_idle = 1;
+	pea->exclude_callchain_kernel = 1;
+	pea->inherit = 1;
+	pea->exclude_guest = 1;
+	pea->disabled = 1;
+	pea->config = config;
 }
 
-static void perf_event_initialize_read_format(void)
+static void perf_event_initialize_read_format(struct perf_event_read *pe_read)
 {
-	memset(&pe_read, 0, sizeof(struct perf_event_read));
-	pe_read.nr = 1;
+	memset(pe_read, 0, sizeof(*pe_read));
+	pe_read->nr = 1;
 }
 
-static int perf_event_reset_enable(pid_t pid, int cpu_no)
+static int perf_event_reset_enable(struct perf_event_attr *pea, pid_t pid, int cpu_no)
 {
-	pe_fd = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
+	int pe_fd;
+
+	pe_fd = perf_event_open(pea, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
 	if (pe_fd == -1) {
 		perror("Error opening leader");
 		ctrlc_handler(0, NULL, NULL);
@@ -50,7 +49,7 @@ static int perf_event_reset_enable(pid_t pid, int cpu_no)
 	ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
 	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
 
-	return 0;
+	return pe_fd;
 }
 
 /*
@@ -124,21 +123,21 @@ static int print_results_cache(char *filename, int bm_pid, __u64 llc_value)
  *
  * Return: =0 on success.  <0 on failure.
  */
-static int perf_event_measure(struct resctrl_val_param *param, int bm_pid)
+static int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
+			      struct resctrl_val_param *param, int bm_pid)
 {
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
 	ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
 
-	ret = read(pe_fd, &pe_read, sizeof(struct perf_event_read));
-	close(pe_fd);
+	ret = read(pe_fd, pe_read, sizeof(*pe_read));
 	if (ret == -1) {
 		perror("Could not get perf value");
 		return -1;
 	}
 
-	return print_results_cache(param->filename, bm_pid, pe_read.values[0].value);
+	return print_results_cache(param->filename, bm_pid, pe_read->values[0].value);
 }
 
 int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
@@ -169,7 +168,10 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 {
 	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
+	static struct perf_event_read pe_read;
+	struct perf_event_attr pea;
 	pid_t bm_pid;
+	int pe_fd;
 
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
@@ -187,8 +189,8 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
-	perf_event_attr_initialize(PERF_COUNT_HW_CACHE_MISSES);
-	perf_event_initialize_read_format();
+	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
+	perf_event_initialize_read_format(&pe_read);
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
@@ -199,9 +201,12 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 		if (ret < 0)
 			break;
-		ret = perf_event_reset_enable(bm_pid, param->cpu_no);
-		if (ret)
+
+		pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
+		if (pe_fd < 0) {
+			ret = -1;
 			break;
+		}
 
 		if (run_fill_buf(span, memflush, operation, true)) {
 			fprintf(stderr, "Error-running fill buffer\n");
@@ -210,9 +215,11 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 
 		sleep(1);
-		ret = perf_event_measure(param, bm_pid);
+		ret = perf_event_measure(pe_fd, &pe_read, param, bm_pid);
 		if (ret)
 			goto pe_close;
+
+		close(pe_fd);
 	}
 
 	return ret;
-- 
2.30.2

