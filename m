Return-Path: <linux-kselftest+bounces-11561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52CC90253D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546DEB24FAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8C714373D;
	Mon, 10 Jun 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Agqpb/TX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3F140E4D;
	Mon, 10 Jun 2024 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032545; cv=none; b=CR2Ugj2y5qRJJ2YrhYtSnjfPQJCL3syklVpTYG2dcyqWvN87zlADD/jRydJbCRtfgcM9oW7SRBTIkySVrZdH0fZ7+uv1TGPo7Hxk0HtRARLCy6f04OLMua5XsZxPagUlSdQEEjoWdh8ylrJc2XvgyjeFi48EQIEuMl2ISXPCNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032545; c=relaxed/simple;
	bh=f0+2Hn9SdO3OSRQSm+QVherXzyhhrJ+JeHDaV/jdYXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WucR4NgfFbTd5+ANzjb1mN2T+k4CUOs3jk0bHJ9mDkOsPQFiw2itIT2l9vXPE7/4XE3bxbeWymDXljxXbrwFiXCvqgKQU0wJbVfzUMRoGx+PXY7fLXN5uB7bJfXOPCwY9OJgE/YrFu2/CDxgAcHWY0S/LChTurSXntLUNCnDcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Agqpb/TX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032544; x=1749568544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f0+2Hn9SdO3OSRQSm+QVherXzyhhrJ+JeHDaV/jdYXI=;
  b=Agqpb/TXAy8sOU/iPbqTYhofWOJ6QLusRbdpPpiBcpYV5w/dHxADIUkl
   EifjpoCh1GJx8EZieAi/GzQGZLjtFSDV1wRWrzpeEnGJOdCvjKKdlWHPP
   ubKwf/VkGMQRz8e1KejtiblQmHvfbRq1N20GBkNKWnXYTS9qdgRaZpKMw
   xgtb/tZuzlnbdH5oCH0a7ffnpsB/Baq8U9T/52oa8hzaFV39BKlzoGq5S
   SMtavf/4aLm+w05LYJ10F1jKVSxplK2hQuzJEI2+QIncNXpjRfTUcoodM
   f5tUpJCE6noNgWTCA13gW34i4g4cKuluHIYONO+ZV1RRjOOgreApZkfc3
   g==;
X-CSE-ConnectionGUID: nIhYp4GaTIuGlPa0DukBnw==
X-CSE-MsgGUID: /HNU6eTwRL2qPS2gXhqKFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18530804"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18530804"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:15:44 -0700
X-CSE-ConnectionGUID: NyU76BH+Tbm9E9FZgNorSQ==
X-CSE-MsgGUID: +OYHm8IWRninTprus44W/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39650674"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:15:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 04/16] selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
Date: Mon, 10 Jun 2024 18:14:45 +0300
Message-Id: <20240610151457.7305-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Both initialize_mem_bw_resctrl() and initialize_llc_occu_resctrl() that
are called from resctrl_val() need to determine domain ID to construct
resctrl fs related paths. Both functions do it by taking CPU ID which
neither needs for any other purpose than determining the domain ID.

Consolidate determining the domain ID into resctrl_val() and pass the
domain ID instead of CPU ID to initialize_mem_bw_resctrl() and
initialize_llc_occu_resctrl().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5fad7e757af3..cccf6b80f3f3 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -450,19 +450,12 @@ void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
  * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
  * @ctrlgrp:			Name of the control monitor group (con_mon grp)
  * @mongrp:			Name of the monitor group (mon grp)
- * @cpu_no:			CPU number that the benchmark PID is binded to
+ * @domain_id:			Domain ID (cache ID; for MB, L3 cache ID)
  * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
  */
 static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
-				      int cpu_no, char *resctrl_val)
+				      int domain_id, char *resctrl_val)
 {
-	int domain_id;
-
-	if (get_domain_id("MB", cpu_no, &domain_id) < 0) {
-		ksft_print_msg("Could not get domain ID\n");
-		return;
-	}
-
 	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
 		set_mbm_path(ctrlgrp, mongrp, domain_id);
 
@@ -621,19 +614,12 @@ static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
  * initialize_llc_occu_resctrl:	Appropriately populate "llc_occup_path"
  * @ctrlgrp:			Name of the control monitor group (con_mon grp)
  * @mongrp:			Name of the monitor group (mon grp)
- * @cpu_no:			CPU number that the benchmark PID is binded to
+ * @domain_id:			Domain ID (cache ID; for MB, L3 cache ID)
  * @resctrl_val:		Resctrl feature (Eg: cat, cmt.. etc)
  */
 static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
-					int cpu_no, char *resctrl_val)
+					int domain_id, char *resctrl_val)
 {
-	int domain_id;
-
-	if (get_domain_id("L3", cpu_no, &domain_id) < 0) {
-		ksft_print_msg("Could not get domain ID\n");
-		return;
-	}
-
 	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		set_cmt_path(ctrlgrp, mongrp, domain_id);
 }
@@ -765,10 +751,17 @@ int resctrl_val(const struct resctrl_test *test,
 	int ret = 0, pipefd[2];
 	char pipe_message = 0;
 	union sigval value;
+	int domain_id;
 
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
 
+	ret = get_domain_id(test->resource, uparams->cpu, &domain_id);
+	if (ret < 0) {
+		ksft_print_msg("Could not get domain ID\n");
+		return ret;
+	}
+
 	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
 		ret = validate_bw_report_request(param->bw_report);
@@ -863,10 +856,10 @@ int resctrl_val(const struct resctrl_test *test,
 			goto out;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
-					  uparams->cpu, resctrl_val);
+					  domain_id, resctrl_val);
 	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
-					    uparams->cpu, resctrl_val);
+					    domain_id, resctrl_val);
 
 	/* Parent waits for child to be ready. */
 	close(pipefd[1]);
-- 
2.39.2


