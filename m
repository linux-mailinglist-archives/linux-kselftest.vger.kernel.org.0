Return-Path: <linux-kselftest+bounces-6104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7E87653E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2571C2128D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566B381AB;
	Fri,  8 Mar 2024 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEdPs6pW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAC5916F;
	Fri,  8 Mar 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904302; cv=none; b=CmAQC2oALc7Wy4vgGWTYi941efxCGRM/P/CQpkVnMUf78udl3Xr5kGxqbB2j3baNCJiKar8nTPxzVCL0tmU7aNA7+NHs3mlHezh0ATOEOsMp405tV8k8WjZY8PfqJRSPO+I3ukaG6MZUMh/Lif4+H2X4L1PXhMrqAydIz5yXD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904302; c=relaxed/simple;
	bh=x3DnjlQUVlSAxB3VKBoysXSz9oqAtOIM0lwfgLDTlME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHN/tLhL5zIxLptN0lTcK4a538hEC8WB0sT/XOorNzda6+354QIz7orKyShE0YXk4012EX6qb8RMNeHMwnWyQC1rA+3woGbp1fQafFVVp53/UOuFx6M4TFVhlMwu9uvh+gB8IgbuPNUBUfzCc9/QtHKLkmmqtLm804BrfaPM3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEdPs6pW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904300; x=1741440300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3DnjlQUVlSAxB3VKBoysXSz9oqAtOIM0lwfgLDTlME=;
  b=PEdPs6pWXoEPmiwdcDU1dXXL3wjms+GmUeH5+Clev3+7zLxlhPOK+yRI
   DIzwMTjYIou+/ga3E0AlkOXWpGxBFXlOfiwpGLTdQN2XUYsXr7bzV8IYI
   US+mvlA+COvKdA8i1watWhLe43jVbDDJ8lWXzrdWVMulhqMVsqqxl3igT
   o/lxmkKe36GqZ/hh+aVpuo3OGwhJ4oqzILHjxdrFzGRor294/hYd+Ibhn
   JIPoKNx4AXnLb5ZzeFjZ76s5/g5BTo0PXNR20h9nv0MHrNBSIe23uhmwg
   WHzeCpmepiBLWPzplB5RBGhS6W29yY+CdnheFxPX1ypgUwLvEWeDa87Or
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8375238"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="8375238"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:25:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10472795"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:24:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/13] selftests/resctrl: Convert ctrlgrp & mongrp to pointers
Date: Fri,  8 Mar 2024 15:22:53 +0200
Message-Id: <20240308132255.14442-12-ilpo.jarvinen@linux.intel.com>
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

The struct resctrl_val_param has control and monitor groups as char
arrays but they are not supposed to be mutated within resctrl_val().

Convert the ctrlgrp and mongrp char array within resctrl_val_param to
plain const char pointers and adjust the strlen() based checks to
check NULL instead.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   | 4 ++--
 tools/testing/selftests/resctrl/resctrlfs.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 3ccca8556aa7..f6a77139d1c0 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -86,8 +86,8 @@ struct resctrl_test {
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
index e01044194ddd..597150e4056e 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -433,7 +433,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 	 * length of grp_name == 0, it means, user wants to use root con_mon
 	 * grp, so do nothing
 	 */
-	if (strlen(grp_name) == 0)
+	if (!grp_name)
 		return 0;
 
 	/* Check if requested grp exists or not */
@@ -505,7 +505,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	char tasks[1024];
 	int ret = 0;
 
-	if (strlen(ctrlgrp))
+	if (ctrlgrp)
 		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
 	else
 		sprintf(controlgroup, "%s", RESCTRL_PATH);
@@ -522,7 +522,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
 	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)) ||
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
-		if (strlen(mongrp)) {
+		if (mongrp) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
 			ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
@@ -576,7 +576,7 @@ int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
 		goto out;
 	}
 
-	if (strlen(ctrlgrp) != 0)
+	if (ctrlgrp)
 		sprintf(controlgroup, "%s/%s/schemata", RESCTRL_PATH, ctrlgrp);
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
-- 
2.39.2


