Return-Path: <linux-kselftest+bounces-11372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9DC90043B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AAC2B24EA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD81940A2;
	Fri,  7 Jun 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUp3OSrI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16871187350;
	Fri,  7 Jun 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764924; cv=none; b=HxdotEoX8eLS3vPXDyECM/367wPbe9NhG60Wnk4SyJKsADaxp6rRkQuBgseGF/rq9fFIlIAMGJfzexONA4uwNb0/0P6VvNcwfIwURkAfOnspJCRT7kqgxIOpIL/yVTz9DUZoyqSsiD0N6AIbypK+m+ZHyxUaDnOHfFUAa6hjqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764924; c=relaxed/simple;
	bh=rJDe/6uAcHgDPfmW4pV89zhCso/+PEfFAWseY49GJHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l39YmnlAt8gjWwc7hQtp/a/QjCjGGSM9BHNMT5LJisyKn10dqTCO4HsAm6Zl0lEKD22pM0IlkAfOV7G0x/QKWmluQ6J1eb27uBrBbkcEFeeuThNq1PA3kMikuSRkMgsRWwXlb5IHser5kBRL4yFPV1qtTAC4ZjSlKfNgO2x0LA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUp3OSrI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764923; x=1749300923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJDe/6uAcHgDPfmW4pV89zhCso/+PEfFAWseY49GJHA=;
  b=jUp3OSrILdMSppULqsLzSLZkpuSyk/hFvcB+xVcAjOnJLVHh6EXLEd+W
   Q/YWqGiN4+29eWG2Qjf8Nk3Glsb1WT9Vzj5AEA1Aw+zkJkQM7F0kyqAfT
   E1v62H6SFA2j5DlLVTgSvka+QfRDG0BN5a5AvDFhdd3c+dyGoWN/1dcQ3
   7mWx31jeku4GB2L6cICqPzgj0DrmjPL3kYKo7t6jdMSMd7E4UHhcDTp+Y
   7Wzq85wxkMAsnIExAPRDmEJu7npgge+qxaRurzN00H7AdvISf3NVsDYRl
   EQKPLMHv6HcPRptOj24GzP2We5NtdJLCsYukl2LXVSeg38RJVRibufc/o
   Q==;
X-CSE-ConnectionGUID: ChfQ76LERIm2nGYGU2uFpg==
X-CSE-MsgGUID: jWMU7p39T1awX0m/WuJ/uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25055964"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25055964"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:23 -0700
X-CSE-ConnectionGUID: pv8/EzgsTuS4cJNbQSZ6uw==
X-CSE-MsgGUID: yhN1SjlJTn62SC8o0z8+7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69484081"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:19 -0700
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
Subject: [PATCH v6 13/16] selftests/resctrl: Convert ctrlgrp & mongrp to pointers
Date: Fri,  7 Jun 2024 15:53:13 +0300
Message-Id: <20240607125316.7089-14-ilpo.jarvinen@linux.intel.com>
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

The struct resctrl_val_param has control and monitor groups as char
arrays but they are not supposed to be mutated within resctrl_val().

Convert the ctrlgrp and mongrp char array within resctrl_val_param to
plain const char pointers and adjust the strlen() based checks to
check NULL instead.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v6:
- Language tweak into kerneldoc
- Removed stale paragraph from commit message

v5:
- Return 0 if grp_name is null (restore earlier behavior)
- Move the root group note from comment into kerneldoc

v3:
- Removed wrong comment
- Changed grp_name check to return -1 on fail (internal sanity check)
---
 tools/testing/selftests/resctrl/resctrl.h   |  4 ++--
 tools/testing/selftests/resctrl/resctrlfs.c | 16 +++++++---------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 5967389038d4..a999fbc13fd3 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -91,8 +91,8 @@ struct resctrl_test {
  */
 struct resctrl_val_param {
 	char		*resctrl_val;
-	char		ctrlgrp[64];
-	char		mongrp[64];
+	const char	*ctrlgrp;
+	const char	*mongrp;
 	char		filename[64];
 	unsigned long	mask;
 	int		num_of_runs;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index f4dc8ef23a8c..e2d1ecb55d51 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -456,6 +456,9 @@ int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity)
  * @grp:	Full path and name of the group
  * @parent_grp:	Full path and name of the parent group
  *
+ * Creates a group @grp_name if it does not exist yet. If @grp_name is NULL,
+ * it is interpreted as the root group which always results in success.
+ *
  * Return: 0 on success, < 0 on error.
  */
 static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
@@ -464,12 +467,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 	struct dirent *ep;
 	DIR *dp;
 
-	/*
-	 * At this point, we are guaranteed to have resctrl FS mounted and if
-	 * length of grp_name == 0, it means, user wants to use root con_mon
-	 * grp, so do nothing
-	 */
-	if (strlen(grp_name) == 0)
+	if (!grp_name)
 		return 0;
 
 	/* Check if requested grp exists or not */
@@ -541,7 +539,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	char tasks[1024];
 	int ret = 0;
 
-	if (strlen(ctrlgrp))
+	if (ctrlgrp)
 		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
 	else
 		sprintf(controlgroup, "%s", RESCTRL_PATH);
@@ -558,7 +556,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
 	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)) ||
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
-		if (strlen(mongrp)) {
+		if (mongrp) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
 			ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
@@ -612,7 +610,7 @@ int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
 		goto out;
 	}
 
-	if (strlen(ctrlgrp) != 0)
+	if (ctrlgrp)
 		sprintf(controlgroup, "%s/%s/schemata", RESCTRL_PATH, ctrlgrp);
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
-- 
2.39.2


