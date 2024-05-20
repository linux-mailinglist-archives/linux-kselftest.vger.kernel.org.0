Return-Path: <linux-kselftest+bounces-10436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8C88C9D6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14471285355
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3146BFAB;
	Mon, 20 May 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1ZPR5KU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C359147;
	Mon, 20 May 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208349; cv=none; b=OkZMHRvZGGqxQHJLFYd1ThpOpqqQzklvSes3RnXPa+F0la5oDoQKRUkwLCU2+HAW6GU5nxiKfqpTyUFJmvXi4WYuUV2KWRORD5mj2I8vVgW3KUL9k4ZFQP2aalolcTmbDswb5MOaX7iMNwZjSu3qRrjnaHwuV9/Tukot04VG+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208349; c=relaxed/simple;
	bh=zcaBoK/ACFrIjjdFXj8eyQESy8iAslUg8GB4EQy4ers=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCZv/LYsiP7MmyJ8kK+QnP4g/h035WLhRrIy48wv2JVdhLmiwGLJzzHe4O7KguZmPUySgf8phruIi68x6axy3iDLIJhOd7cL+hVUH7DganEmLtsNyso0O948+2fcDgp0VaKKvMlpiwMb9XLvhV/ZLthu3dise9za6qz0wOEZ9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1ZPR5KU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208348; x=1747744348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zcaBoK/ACFrIjjdFXj8eyQESy8iAslUg8GB4EQy4ers=;
  b=I1ZPR5KUO96o2odX7FAmXeg8BeC7mwXs9fNC+VebRDJaytbRUr+HM0rD
   VjyuOwFjFhourm2yXqJg19Tz2ilAqmJWlILsN5sx+4335rcRfUS0C4e3G
   qNM2UJG9gTy7U0ER+JqmRTV+lAV6IOuyIzHvIUSQOG8AatKOkGzsE0a3L
   pnoeMbwzxHGiw2GExdn8909Lvfhgg4ahJD9gvxU/hIwlLY3H3oSqRnJYH
   8dKhmZGwxvXaSkFPWQ5FGmkrm7d+I/NOEQSky0+uycCL9UAtc9SoSI4fI
   /OimQ7/S7ikRaYffH0kx3knCaZzi0nWLBo03kdOmQkKQtrUOL6aywXRYJ
   Q==;
X-CSE-ConnectionGUID: NIR5mArpQ0qcSV55N5UsXA==
X-CSE-MsgGUID: 6h1h4VlXTb22H+8dIAlyRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12180558"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12180558"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:28 -0700
X-CSE-ConnectionGUID: sz8r3dBKS0iodzgPVEo8qQ==
X-CSE-MsgGUID: LN7xEZuhRSq2z5LHB1gVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="33091294"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:24 -0700
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
Subject: [PATCH v4 13/16] selftests/resctrl: Convert ctrlgrp & mongrp to pointers
Date: Mon, 20 May 2024 15:30:17 +0300
Message-Id: <20240520123020.18938-14-ilpo.jarvinen@linux.intel.com>
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


