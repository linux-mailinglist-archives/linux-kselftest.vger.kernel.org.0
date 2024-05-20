Return-Path: <linux-kselftest+bounces-10427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE328C9D4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB8C1C2255D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF4250A8F;
	Mon, 20 May 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmlMpimr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FE56766;
	Mon, 20 May 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208270; cv=none; b=udovgncUl5Jxj3J6OIBla0Iqinz+RQTv//Ocfv9ED6IlKpoNtDKH3dX9f6j/kE2xQ3TX6HDKH4OcpYuq37oP83BQgp3Grkc4luQVK9leYR3o1ahU6CmtPPErSoMKAgtkIJcC3HkKdx23dySXcPkMvGT+QPWxhre8NKRpms4N+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208270; c=relaxed/simple;
	bh=IK/hJK9+J08W1MsxIwwJRZTw4zqFwkiytsnG2YPMKBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPT6zOec4Pn9Wj5/9DG5qx/nW26IPM2qedeADUpc28moWRLcezNUy6eDLclknYZDXd42U4pmBXjmrByN8rQtJHR7/Dv5DASWASsgr9kv/wb/TT29aEhOhxFN1Fl98afF+UcfgQIyanEepx2TH2tzb/iSAkTK+xM0OpdKg9abT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmlMpimr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208269; x=1747744269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IK/hJK9+J08W1MsxIwwJRZTw4zqFwkiytsnG2YPMKBw=;
  b=XmlMpimrY32/0Q10z2G+E+7XkEjDLchqO2y6zzxKVWptQS+6UQVBYhZl
   WrZI+a7bF3GzeNYXWPZCUqzNjx4apqMIJ0jLozhR24d54jxAlybHsE5Wm
   Qe7qVjmSUISC+M8m6T0w1wQ2c0snU7VOjm5ues2fEKCkgFDHFs6NNlq6w
   8Kig39kZrUV7r2+8CpdLqv/3/lj2QugaJLNXk08EtPtibern0dfL0H+yc
   irtgx4KL9xKYEZ/lnCTLiZhI8XqO2jknSqFLnv6nV9lsVHIB9dkm6yOYv
   ABShegtbNCBTaa8Zi8c5bb6OXd0+k01zpNHHH1P5Li6r37bLkxq8mul+2
   Q==;
X-CSE-ConnectionGUID: i7ddnMAvRpaHT6Y3jt88yA==
X-CSE-MsgGUID: ApsuPWIRRuGarYQlwFtjxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12180336"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12180336"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:08 -0700
X-CSE-ConnectionGUID: 33vUk75zRgSv9Xb8f1AUfg==
X-CSE-MsgGUID: sTw8PonUQTOlY/r9VbJLMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="33091115"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:05 -0700
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
Subject: [PATCH v4 04/16] selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
Date: Mon, 20 May 2024 15:30:08 +0300
Message-Id: <20240520123020.18938-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
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
index 126a9cad588b..6ea8fd2c65cc 100644
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
@@ -775,10 +761,17 @@ int resctrl_val(const struct resctrl_test *test,
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
@@ -873,10 +866,10 @@ int resctrl_val(const struct resctrl_test *test,
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


