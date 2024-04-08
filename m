Return-Path: <linux-kselftest+bounces-7425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A972889C9BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC34289DCC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692D142E6C;
	Mon,  8 Apr 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Afmh9qgx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B61142640;
	Mon,  8 Apr 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594110; cv=none; b=kFcJBRPoQCnhPBhHT99wQtw13tRxHaIWs6T4msPUVGkSgeaCuC3SMmPTfyfAVTu8kIsH34p/KKwyhC3a8PSN2Hvj0ZPAXHQprM4B/WTZg0liLgHEvRZ3UpssPPDg+GtdNWxkzcAA1JB0yQZEo5+GRO4Z4mtx2eaUFnv9eQqujo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594110; c=relaxed/simple;
	bh=zcaBoK/ACFrIjjdFXj8eyQESy8iAslUg8GB4EQy4ers=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9+mWew3/kqKUcLOZqgJtdbc0U+CK3Wrxe/0N4jL2SLdV+Nkieh4hdEohgwphieoHvgId+6dvemc7bmrf8bBGVKA927tH9dGM61yYIhTcP/G+wsUAsUeYO2An+r7Y/dDSD+NlwZJ+1+EATXo2AHHnebqHdeCPF6Y5O7AGBXnII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Afmh9qgx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594109; x=1744130109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zcaBoK/ACFrIjjdFXj8eyQESy8iAslUg8GB4EQy4ers=;
  b=Afmh9qgxHu+jm4FaAErrhGXAFylybNzDnlKIfsEcwXA1yEoeb8rLNl/L
   OV3cx/mGQdcLi3s7mL2uw8InHFniOUpqiBjnKVrvmxezgYT+L8jFTdLGk
   ojAOOpg2QkJmLkLjKxwUtD3QTWLWQ5qnACVeCbzMaVyyZYKyocH39n6Wq
   Y467TPiLOMhlqpR05oiOEGKRNibzzLw7g5xExU81BUXWiB0uG2fnlQbPN
   sCd6R0RV4tx1yGsVU+1/K2FVVReM/qsmrx1Yt9hn8YmGjv8SUjyw6eISW
   WuH1zPYnYD1UNkzHw7ie3vDks3XGc3RJk/e2u1iygoeAJA2NYxh63ch2N
   g==;
X-CSE-ConnectionGUID: UH8M2wKYT5iU5+ieTuEFog==
X-CSE-MsgGUID: E+dUqzQTQY2wPgPRae5Hrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18492258"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18492258"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:35:08 -0700
X-CSE-ConnectionGUID: nVeyn8h8TA6CR78BjNZ55w==
X-CSE-MsgGUID: XeFqQqoRT66DOLOjlFQ8SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20376584"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:35:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 14/16] selftests/resctrl: Convert ctrlgrp & mongrp to pointers
Date: Mon,  8 Apr 2024 19:32:45 +0300
Message-Id: <20240408163247.3224-15-ilpo.jarvinen@linux.intel.com>
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

The struct resctrl_val_param has control and monitor groups as char
arrays but they are not supposed to be mutated within resctrl_val().

Convert the ctrlgrp and mongrp char array within resctrl_val_param to
plain const char pointers and adjust the strlen() based checks to
check NULL instead.

Convert !grp_name check in create_grp() into internal sanity check by
returning error if the caller asked to create a group but doesn't
provide a name for the group. The existing code already abides this by
only calling create_grp() if mongrp is non-NULL so the error should
never be returned with the current selftests (ctrlgrp is never NULL).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- Removed wrong comment
- Changed grp_name check to return -1 on fail (internal sanity check)
---
 tools/testing/selftests/resctrl/resctrl.h   |  4 ++--
 tools/testing/selftests/resctrl/resctrlfs.c | 15 +++++----------
 2 files changed, 7 insertions(+), 12 deletions(-)

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
index a0e84157eb63..6b4448588666 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -464,13 +464,8 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 	struct dirent *ep;
 	DIR *dp;
 
-	/*
-	 * At this point, we are guaranteed to have resctrl FS mounted and if
-	 * length of grp_name == 0, it means, user wants to use root con_mon
-	 * grp, so do nothing
-	 */
-	if (strlen(grp_name) == 0)
-		return 0;
+	if (!grp_name)
+		return -1;
 
 	/* Check if requested grp exists or not */
 	dp = opendir(parent_grp);
@@ -541,7 +536,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	char tasks[1024];
 	int ret = 0;
 
-	if (strlen(ctrlgrp))
+	if (ctrlgrp)
 		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
 	else
 		sprintf(controlgroup, "%s", RESCTRL_PATH);
@@ -558,7 +553,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
 	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)) ||
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
-		if (strlen(mongrp)) {
+		if (mongrp) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
 			ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
@@ -612,7 +607,7 @@ int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
 		goto out;
 	}
 
-	if (strlen(ctrlgrp) != 0)
+	if (ctrlgrp)
 		sprintf(controlgroup, "%s/%s/schemata", RESCTRL_PATH, ctrlgrp);
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
-- 
2.39.2


