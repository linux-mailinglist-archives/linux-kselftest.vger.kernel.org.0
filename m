Return-Path: <linux-kselftest+bounces-6096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A087651B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EBF1C221AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0522EFB;
	Fri,  8 Mar 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMIMwRe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF663CF4F;
	Fri,  8 Mar 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904227; cv=none; b=joKi2iR9h3jcAZu1EB6cmu76K71pfL6q+w3F2RSHxsZqAP+oUGLNQ+K4UAJqv9d9vLaN4DnxalRE3UqM2V1Y5O1sowEfYbEIPd19qX1DlyiEiKM6nbo6n+tWv/yA4oJe84KiOJnuJQmxSDqpobDAs61eTxyjQftrvRVHmFwWQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904227; c=relaxed/simple;
	bh=rwUGKWtRQHCPDzae5+w4LWpcgWjkphzsu2B1RTrQA40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vk9m67aiUyKtVIF7V/BiGSozDnaeiv+TBmti/i1Kq3pUmQpLe4UAb4PB5l7Lxxf/1+NGfzis3AtMCWdSY/s4V4Qs038zO17thG37fcwi4bKUZWmOz1u8wit00OPtoD59s6JxQxDpyL+lBc2D49j1YJWj8dNWBniRAVaj+08Mig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMIMwRe6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904226; x=1741440226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rwUGKWtRQHCPDzae5+w4LWpcgWjkphzsu2B1RTrQA40=;
  b=TMIMwRe6SI3sejfbudsj9/sNY0g1S2AeFqSY4GSbwRppMxm8Gdi5RRSk
   WptKsJDSUaNXOyRP+QOtEk9kYNYC3O1zf0CrfutrJIBB3P3jw6xBl1Au2
   UCRrNJbGf/9p9J9QHWTHG5FRqVJh9cQt/gR9YeJxLaU+r6whSiFI/ZKDD
   bAGtD5EIr/XOeSkUgIZqwRV4pp8tCfN27AUJqzuOeomvIWx5Tol5oyqQZ
   nFEwWseunMdplTZaqCfJQPVWqQOhI/Ueuw9TOX0bfg/eyLbQ8REoo/DnG
   OFw+vRyNqrwNIhehS3UN8wf214EPC1DElB248vcJ4x6xvz6VrzuhnUzTE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4801405"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4801405"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="11007151"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/13] selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
Date: Fri,  8 Mar 2024 15:22:45 +0200
Message-Id: <20240308132255.14442-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
References: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
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
---
 tools/testing/selftests/resctrl/resctrl_val.c | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 4df2cd738f88..7981589f4db0 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -431,19 +431,12 @@ void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
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
 
@@ -600,19 +593,12 @@ static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
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
@@ -729,10 +715,17 @@ int resctrl_val(const struct resctrl_test *test,
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
@@ -827,10 +820,10 @@ int resctrl_val(const struct resctrl_test *test,
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


