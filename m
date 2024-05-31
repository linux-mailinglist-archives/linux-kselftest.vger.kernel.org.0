Return-Path: <linux-kselftest+bounces-11013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796308D62A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F8F1F27B05
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD122158D6D;
	Fri, 31 May 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNsLuN/4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA9158D69;
	Fri, 31 May 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161242; cv=none; b=PyE01FJgzVm5cw998K6xCWHQWahT+3yCKnDogbGJZw/s1bCZ9ZRMBEqvFxoMqqpTTUL6gR1bufZpEJvh0z9csO9asklGeve/H8AMrPK/NlaMrBhS53jxuOHNxMCcHryNLiZpjY9eQrKlc4gGsT1jTejI011Se4+3W4W7UDI+vdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161242; c=relaxed/simple;
	bh=1cenIq2y5GVuEnpBRWOSyJVgdBVaGOrTeE8GFWltggM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfwCEKBXH1LxH/J5TzGWkjPrbsv4xDLX5J0qB8zaRe8Ahfsn/KY+WPIBUogonaLophSJHupM+zJvX0Hjo8Z4p1w+kZy4Ytk7wfd4KZSmXVLGRJWk2W87BS0mjAunTberrfI/h0f8BF/N6KXFX7fbQSmP9V6rluxKoNl6gMhP0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNsLuN/4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161242; x=1748697242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1cenIq2y5GVuEnpBRWOSyJVgdBVaGOrTeE8GFWltggM=;
  b=eNsLuN/4k/n/GiHpKNI4v/51dHkG6L5xJnJbvwZM14PnmtlEV8VeAa89
   tE1FJJLNwKEJhTLPu4HNOLm28wQoOn9hNdTyAonLtOlIqNQi/VtySdF7l
   nqV5gJKlMPdhziFehkQUI6Awt63BGcdd+8ZckoJEKgcdOb/F3jxFnfl/x
   wtOzLPjPHp6lPexs0C1jTGRguWOV674PCIRns/F9hMaTQ1udtNt6BVT16
   rN/QOgT5aegCHTuAZZ61J/MvBbH3vGSskR54dsXadsTdkCiO7spqsb51z
   NQG4NDktqDKIqsqk2RaKztzQbqVnpSFjojnMmM6ZYbog8xcpt/X2PO7cs
   A==;
X-CSE-ConnectionGUID: X7i/U7ZnTL2zmE2MssMr5w==
X-CSE-MsgGUID: /3GrWxltRzuxczIDodUltg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25103320"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25103320"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:14:01 -0700
X-CSE-ConnectionGUID: JDAsfvxESW+M1CmUrfoezw==
X-CSE-MsgGUID: 981qNrWAQiOq7/xIjV3n7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41077919"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:58 -0700
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
Subject: [PATCH v5 13/16] selftests/resctrl: Convert ctrlgrp & mongrp to pointers
Date: Fri, 31 May 2024 16:11:39 +0300
Message-Id: <20240531131142.1716-14-ilpo.jarvinen@linux.intel.com>
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
index f4dc8ef23a8c..893041faaf18 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -456,6 +456,9 @@ int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity)
  * @grp:	Full path and name of the group
  * @parent_grp:	Full path and name of the parent group
  *
+ * Creates a group @grp_name if it does not exist yet. If @grp_name is NULL,
+ * it is interpreted as the root group which always results success.
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


