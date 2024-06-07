Return-Path: <linux-kselftest+bounces-11363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F0B900411
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493F21C22413
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B93190696;
	Fri,  7 Jun 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AF9bbjA2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73368190682;
	Fri,  7 Jun 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764844; cv=none; b=VADkHjF9spZ/+CoNRYUrd5UVBsnTCm6EMWrgsoj2M1KpTNB6dbc2bDKCdGW9SX0GjvCgLotpahFq3l2UaOtZkHzE6pI4Qv0QcfeoYyLm0oMnIpb4fcpLspcgfdXUZYieg39xkDt7Iz+z2QtmFFUO3sIVb52EQCrz9L8KEZ2ZRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764844; c=relaxed/simple;
	bh=Kp3Tb8HJyb49S7gZJAPeYxxSAm8mewkGAdK9ttwIC/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp5GElVINY/vee1IXHOkZ8ONYuqCUN3nobOBJg1nrERVVA/WcyqjgW5BpG+1PRcCsLmiHgspJ3eCg4LgF/KAvHJfv3r5OTzIakp979zzYs8FXeZliDXbQbZY9JHS1vn92fA5PeUG3jIFAz2wTi2K5rAr2k3KBTGC8mb21GlZUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AF9bbjA2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764843; x=1749300843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kp3Tb8HJyb49S7gZJAPeYxxSAm8mewkGAdK9ttwIC/M=;
  b=AF9bbjA2Ov/KFYjE4iTjbRI6yn+I80lITy403l36Gsb1NeJfTCvk1h4z
   Mr9rQ4whIVb9AzLpIq4ttF5OMVphOLCw6F0TnRQPzHvYZAPvCk4YJXRhU
   yH4rjAWpBlA33PPeceDYLsqbwEhi2uo+hnMqY6gWoUJyHBglZN+fir0Lm
   MI22eHCRWrquR2FDUY2xgFmeHyIHe3i3YRqZLF3MaM/zVoXO71b4ewovE
   qWt1T3w4y5/U3jPcqhBt61712DAY1VCC872gv0/7XpOAStPU6Yau/zqvD
   Ucr1B8bcbLhwV8fjJH1CCGYcTHWoEJgiFxMODfE8BEvv2+9xdBgc66wxT
   g==;
X-CSE-ConnectionGUID: NSmDfUTeTbijD2qGGkG0NQ==
X-CSE-MsgGUID: nuRg5sumSV+ibv67JlNToQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25110889"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25110889"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:54:02 -0700
X-CSE-ConnectionGUID: 3Cn85gmCTJa0ZXyzLmEMlA==
X-CSE-MsgGUID: MgNP9vXTS9eZewMv6X7SDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38237589"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:53:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 04/16] selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
Date: Fri,  7 Jun 2024 15:53:04 +0300
Message-Id: <20240607125316.7089-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
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
index 9979879eda74..e333e4efb550 100644
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


