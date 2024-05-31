Return-Path: <linux-kselftest+bounces-11004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6500C8D628E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46EC1F279E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2751158D97;
	Fri, 31 May 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzpXIpo/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42999158D85;
	Fri, 31 May 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161153; cv=none; b=cJeyyFcET4QWdsuSCnODj9oJxd3Fc7dYPAZKIlK6t0yZCM+wEcfk4Ca83cTP3ssP6+ivylQ40ZSjzWjPW2dpIrfQN/RAaJoHE722iOGTP4FGLlKp2D1th/2CFThQ1OE4hEl1FXIOpYvxr38lFMP7NqBOV3s47wSVZBz4t/JE0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161153; c=relaxed/simple;
	bh=tD2aSwCrDIPm3yB94Vjyq3zpc7djs34CDQwpb3HVo9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMKxitI0N0P5BDESXmzuvfco24jYRqkKkYX+EP7xx0A03YLObFwL8sJKUTvv3DVXizKOqKVPw2QLncMDtq5UJuVDsunEoQMBB+xkfp9bibOYSDZQJ6gaPFfn90DHLLG6meI3cDv+1CoYQz2BtwMydmWjJjB7LfJdwR9lJz8ANoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzpXIpo/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161152; x=1748697152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tD2aSwCrDIPm3yB94Vjyq3zpc7djs34CDQwpb3HVo9Q=;
  b=XzpXIpo/bq8hgUJGabe01breH2RGqFAESsfLGT6PjW8jrgN8hRf277Er
   Zn59UXEI1SfESVUV6jnKrKo0UQWpz1M/Yyfr7ukFpaOS4xbyNjDBHnEUE
   56osIYzbpT9PC9b6nU5N9Yz7FGK9k7EcSchla2gG2+kuBK2fP2rA1wDYb
   XyStzu0IWtJEy5L4X5y8WbA0FN+GyHxWbj/YluouEFy/vSrQ0AgI2HqkP
   /13uWgSx4TkR2O7L5yLDfqABq27CbShybYX1BIpceHJcl6NyGSWbszChq
   XN5FFLv0K9VAqu9h+H9CMz2iYaaTJWlodRBl/SenkkD+XjNfaIwx4RgCK
   Q==;
X-CSE-ConnectionGUID: XCiQs+gkRt641o+pfShQ+A==
X-CSE-MsgGUID: Pu1iXpxPQ8yrCMn1jGunuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17532532"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17532532"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:32 -0700
X-CSE-ConnectionGUID: N3p3KKX5SQKi7rbUtP1CFw==
X-CSE-MsgGUID: EFV9siojQSKjC/pVSIv6IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36106881"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 04/16] selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
Date: Fri, 31 May 2024 16:11:30 +0300
Message-Id: <20240531131142.1716-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index cb646168179e..e1ae59063c51 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -456,19 +456,12 @@ void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
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
 
@@ -627,19 +620,12 @@ static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
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
@@ -769,10 +755,17 @@ int resctrl_val(const struct resctrl_test *test,
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
@@ -867,10 +860,10 @@ int resctrl_val(const struct resctrl_test *test,
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


