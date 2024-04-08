Return-Path: <linux-kselftest+bounces-7417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB789C9A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3001E1F26589
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2E14291F;
	Mon,  8 Apr 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwBkg93u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FED142645;
	Mon,  8 Apr 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594057; cv=none; b=ErtlobZCGGvZaY7QEyZZY/PKuunLau5/RfkJeq90EOdFuyHh8jWdka7m5NqzWRxe5+LXFLySAU/CmNjHoAQdLWDD3fESrAfoi/cPoC1AsASQvmLc6H4TXD6fS3cwW84rbINBzKDIAUoGGX3vsVmjRF0MMZ8IpTpWxHxdK1HJG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594057; c=relaxed/simple;
	bh=alWzWN2ftIOPpRJfvQ2aIf1EVnWbL1UAxa6aRGpE7OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+r549k2GMRfs73cBp75+lEWJ4pWMKVkX86ZqQ/CAKP1BfZ4XjV24l7F+RjFAGvLnlOqCHbVq9CtVwO1WegItKLVAGWFFCSPjIi1h6WfPTMtk58gRv/997FvM0/rnU0Lcz6G1uuGZYxnnT0btDqOOV79k1XRyWRoWFrqyK2OEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwBkg93u; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594055; x=1744130055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=alWzWN2ftIOPpRJfvQ2aIf1EVnWbL1UAxa6aRGpE7OE=;
  b=gwBkg93u3VIUcSoprB4cWH9NkTEB5c0Rznzq/mbZ6pqS3GfQdBA6NkjV
   fd+Eb+pWi8kglm4eBsR1I61Biogqey+GLC5bamLkB0uvapaW7Qg+g7rqz
   wWtm6pxqd/7mGDdgfvTkMZeqCLa2wXRn9aBW8j6epT/ilB0Q0o1yzfban
   JAlhDLcKU7O76Ad4c4zUrB78htEOJE3Gk3BHRWIkCF7H4FtRfcGk/otmN
   YFiUcdgelbDOBeFEF/n4HTnIXHyDy6bqsUkL4X6bOU3qCoM5MZ1dW8arw
   PrN+3zbIx5g/7Cgw9fTyvBbiG2m4pEEgZNeyPlqXF/9uT9xA1E1CSSoU6
   A==;
X-CSE-ConnectionGUID: tBvhCMsXTeaDllJSWpdzIA==
X-CSE-MsgGUID: oDljG+ZgTDmQvAsN/ksZ/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18454186"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18454186"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:14 -0700
X-CSE-ConnectionGUID: VJ0UqzJIRhqayuwRA4w9Gw==
X-CSE-MsgGUID: ACwO3W6mT+ilgpNC2Spe8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20062567"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 09/16] selftests/resctrl: Simplify mem bandwidth file code for MBA & MBM tests
Date: Mon,  8 Apr 2024 19:32:40 +0300
Message-Id: <20240408163247.3224-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

initialize_mem_bw_resctrl() and set_mbm_path() contain complicated set
of conditions, each yielding different file to be opened to measure
memory bandwidth through resctrl FS. In practice, only two of them are
used. For MBA test, ctrlgrp is always provided, and for MBM test both
ctrlgrp and mongrp are set.

The file used differ between MBA/MBM test, however, MBM test
unnecessarily create monitor group because resctrl FS already provides
monitoring interface underneath any ctrlgrp too, which is what the MBA
selftest uses.

Consolidate memory bandwidth file used to the one used by the MBA
selftest. Remove all unused branches opening other files to simplify
the code.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- New patch
---
 tools/testing/selftests/resctrl/resctrl_val.c | 45 ++-----------------
 1 file changed, 4 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index e4ad60963b0d..e8e5c0f7f20b 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -19,18 +19,10 @@
 #define MAX_TOKENS		5
 #define READ			0
 #define WRITE			1
-#define CON_MON_MBM_LOCAL_BYTES_PATH				\
-	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
 
 #define CON_MBM_LOCAL_BYTES_PATH		\
 	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
 
-#define MON_MBM_LOCAL_BYTES_PATH		\
-	"%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
-
-#define MBM_LOCAL_BYTES_PATH			\
-	"%s/mon_data/mon_L3_%02d/mbm_local_bytes"
-
 #define CON_MON_LCC_OCCUP_PATH		\
 	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
 
@@ -426,43 +418,15 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 	return 0;
 }
 
-void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
-{
-	if (ctrlgrp && mongrp)
-		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
-			RESCTRL_PATH, ctrlgrp, mongrp, domain_id);
-	else if (!ctrlgrp && mongrp)
-		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			mongrp, domain_id);
-	else if (ctrlgrp && !mongrp)
-		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			ctrlgrp, domain_id);
-	else if (!ctrlgrp && !mongrp)
-		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			domain_id);
-}
-
 /*
  * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
  * @ctrlgrp:			Name of the control monitor group (con_mon grp)
- * @mongrp:			Name of the monitor group (mon grp)
  * @domain_id:			Domain ID (cache ID; for MB, L3 cache ID)
- * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
  */
-static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
-				      int domain_id, char *resctrl_val)
+static void initialize_mem_bw_resctrl(const char *ctrlgrp, int domain_id)
 {
-	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		set_mbm_path(ctrlgrp, mongrp, domain_id);
-
-	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-		if (ctrlgrp)
-			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
-				RESCTRL_PATH, ctrlgrp, domain_id);
-		else
-			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
-				RESCTRL_PATH, domain_id);
-	}
+	sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+		ctrlgrp, domain_id);
 }
 
 /*
@@ -850,8 +814,7 @@ int resctrl_val(const struct resctrl_test *test,
 		if (ret)
 			goto out;
 
-		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
-					  domain_id, resctrl_val);
+		initialize_mem_bw_resctrl(param->ctrlgrp, domain_id);
 	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
 					    domain_id, resctrl_val);
-- 
2.39.2


