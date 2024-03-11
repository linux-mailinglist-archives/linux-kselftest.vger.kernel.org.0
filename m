Return-Path: <linux-kselftest+bounces-6199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D787810B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E2E287D38
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42463FBBD;
	Mon, 11 Mar 2024 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAIrf2q+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D74437C;
	Mon, 11 Mar 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165269; cv=none; b=H5HAhPMtoDjESihO4HfU6OoqB36EGfN7G+NHQ087Y8NefkhaWsLm+/DdQ7TFB+rcqJjZzoIttKXIbXdllkyzjrfBepw8Lb7A3sjFkWouzZ4l+WKjr6Rv77wIhicW2DYrJwFGXQBYObbNWFgmjQZNqC1jsxTOhKONGwFHOwfxZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165269; c=relaxed/simple;
	bh=wiEt/mNCP6TC3G2ncRVWx2EtVH6HXJqveGGLYP/G6RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZs5JcPLjt/no4mwNU2ka1fz36a+mYbn4H/7yOys0QCdB8yeB01D8duwfHNv/zwB7tNCpTg9bMR4DiUf62yIPpRYQj0WjZno9qO+bqvbktlXGHwaSAS38GLz3JR01KGapQY5qCvIkGQmUp+qXRESvX6Q7xx8GZkSER/EhqYNjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAIrf2q+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165267; x=1741701267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wiEt/mNCP6TC3G2ncRVWx2EtVH6HXJqveGGLYP/G6RU=;
  b=lAIrf2q+TAGg2w6ymjKqbDDFE2SUotwVTeZZrU5IkO/YCOnNgGT2SSx3
   Ax8gLsxkQJyZlVg1t6Ukgylwm8dhusxS1Eaf4jYDUeuj93B8bTfwbt+7z
   AI1OU5XkDLzgYrSjQzaP7BGViYbbV6s12wUAXsCaa3fEqS12CswMROxEd
   NvzvhkHVjtMKuQ0cQqHuEvmPjFTn0Igzqvo785d+Lg4PO4nrSXQ8C6iLo
   4RQSCsmNmOAn+v3XXiX5AuSpDZRkdmeRqlJtRJEMCRzOkOaZE6zAgb4dx
   SJAc5Q8Req2VMwbfAq/dQS7Cu1q1BzKPMsE8sAu+GdHxgzs9YiN7/J1mh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4705347"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4705347"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11243364"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 11/13] selftests/resctrl: Convert ctrlgrp & mongrp to pointers
Date: Mon, 11 Mar 2024 15:52:28 +0200
Message-Id: <20240311135230.7007-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
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
index 52769b075233..54e5bce4c698 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -89,8 +89,8 @@ struct resctrl_test {
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
index 79cf1c593106..dbe0cc6d74fa 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -469,7 +469,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 	 * length of grp_name == 0, it means, user wants to use root con_mon
 	 * grp, so do nothing
 	 */
-	if (strlen(grp_name) == 0)
+	if (!grp_name)
 		return 0;
 
 	/* Check if requested grp exists or not */
@@ -541,7 +541,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	char tasks[1024];
 	int ret = 0;
 
-	if (strlen(ctrlgrp))
+	if (ctrlgrp)
 		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
 	else
 		sprintf(controlgroup, "%s", RESCTRL_PATH);
@@ -558,7 +558,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
 	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)) ||
 	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
-		if (strlen(mongrp)) {
+		if (mongrp) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
 			ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
@@ -612,7 +612,7 @@ int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
 		goto out;
 	}
 
-	if (strlen(ctrlgrp) != 0)
+	if (ctrlgrp)
 		sprintf(controlgroup, "%s/%s/schemata", RESCTRL_PATH, ctrlgrp);
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
-- 
2.39.2


