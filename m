Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AF07D4C3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjJXJ3I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjJXJ2z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:28:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5019A7;
        Tue, 24 Oct 2023 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139693; x=1729675693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8FKUtvRYnvzaa3K/57t7W2HJhIgi4sQgl8n8AtOFcZo=;
  b=oKSi2gAJZtd5PyXGojM8jAB8MMhuwDDeVhYcVlt5Iq1NGDJO4UhREKI0
   Ss6HQmdeDKCynhn3TDn9HVoVwVtECixm1C0sWZj8TjQL7Ea/3FjuJG8F0
   opAkW2ugpEHkB5gDoo1SH08QFHbga705LiWESMihSOSDGhpqTXhacEsy+
   N8xNZVqJPGYPks64Mh5Yf2ddt6kIBiIJMOXo1kTDRRS5W0LabTFHfNL5Y
   fvkl/s8ee5/1PRX1ChM1V05AL96eLUMwaDkxAQY7TwOxrsRs+AdyoKRwX
   Bw8Gzx4TTdH+qnJV2ZiblY9sEFVmSwXSHa8qU+fTrigVHnXR3+Djqx3xX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386829532"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="386829532"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828754659"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="828754659"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:09 -0700
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
Subject: [PATCH 10/24] selftests/resctrl: Remove nested calls in perf event handling
Date:   Tue, 24 Oct 2023 12:26:20 +0300
Message-Id: <20231024092634.7122-11-ilpo.jarvinen@linux.intel.com>
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

Perf event handling has functions that are the sole caller of another
perf event handling related function:
  - reset_enable_llc_perf() calls perf_event_open_llc_miss()
  - reset_enable_llc_perf() calls ioctl_perf_event_ioc_reset_enable()
  - measure_llc_perf() calls get_llc_perf()

Remove the extra layer of calls to make the code easier to follow by
moving the code into the calling function.

In addition, converts print_results_cache() unsigned long parameter to
__u64 that matches the type coming from perf.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 86 +++++++------------------
 1 file changed, 25 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index d39ef4eebc37..208af1ecae28 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -29,25 +29,6 @@ static void initialize_perf_event_attr(void)
 	pea_llc_miss.disabled = 1;
 }
 
-static void ioctl_perf_event_ioc_reset_enable(void)
-{
-	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
-	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
-}
-
-static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
-{
-	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
-				PERF_FLAG_FD_CLOEXEC);
-	if (fd_lm == -1) {
-		perror("Error opening leader");
-		ctrlc_handler(0, NULL, NULL);
-		return -1;
-	}
-
-	return 0;
-}
-
 static void initialize_llc_perf(void)
 {
 	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
@@ -63,42 +44,16 @@ static void initialize_llc_perf(void)
 
 static int reset_enable_llc_perf(pid_t pid, int cpu_no)
 {
-	int ret = 0;
-
-	ret = perf_event_open_llc_miss(pid, cpu_no);
-	if (ret < 0)
-		return ret;
-
-	/* Start counters to log values */
-	ioctl_perf_event_ioc_reset_enable();
-
-	return 0;
-}
-
-/*
- * get_llc_perf:	llc cache miss through perf events
- * @llc_perf_miss:	LLC miss counter that is filled on success
- *
- * Perf events like HW_CACHE_MISSES could be used to validate number of
- * cache lines allocated.
- *
- * Return: =0 on success.  <0 on failure.
- */
-static int get_llc_perf(__u64 *llc_perf_miss)
-{
-	int ret;
-
-	/* Stop counters after one span to get miss rate */
-
-	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
-
-	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
-	if (ret == -1) {
-		perror("Could not get llc misses through perf");
+	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
+	if (fd_lm == -1) {
+		perror("Error opening leader");
+		ctrlc_handler(0, NULL, NULL);
 		return -1;
 	}
 
-	*llc_perf_miss = rf_cqm.values[0].value;
+	/* Start counters to log values */
+	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
+	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
 
 	return 0;
 }
@@ -166,20 +121,29 @@ static int print_results_cache(char *filename, int bm_pid, __u64 llc_value)
 	return 0;
 }
 
+/*
+ * measure_llc_perf:	measure perf events
+ * @bm_pid:	child pid that runs benchmark
+ *
+ * Measure things like cache misses from perf events.
+ *
+ * Return: =0 on success.  <0 on failure.
+ */
 static int measure_llc_perf(struct resctrl_val_param *param, int bm_pid)
 {
-	__u64 llc_perf_miss = 0;
 	int ret;
 
-	/*
-	 * Measure cache miss from perf.
-	 */
-	ret = get_llc_perf(&llc_perf_miss);
-	if (ret < 0)
-		return ret;
+	/* Stop counters after one span to get miss rate */
+	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
 
-	ret = print_results_cache(param->filename, bm_pid, llc_perf_miss);
-	return ret;
+	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
+	close(fd_lm);
+	if (ret == -1) {
+		perror("Could not get perf value");
+		return -1;
+	}
+
+	return print_results_cache(param->filename, bm_pid, rf_cqm.values[0].value);
 }
 
 int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
-- 
2.30.2

