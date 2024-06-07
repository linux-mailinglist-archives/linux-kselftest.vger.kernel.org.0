Return-Path: <linux-kselftest+bounces-11371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A836900437
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAF128C9A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BB1974FD;
	Fri,  7 Jun 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjnW7Lfg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD3199236;
	Fri,  7 Jun 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764915; cv=none; b=r25iTPgwD37845o2v8nnYSqAHTtPGDivaXKjAKVFL4ZkBrRahRPcCL2YIvhlP7jkzEZ7VeOtgm0BVhwGbt60riygvD9MQAwesLNqWzL5xr9LHiqjz1LNRwJnCtkh4XT2dHR4rb0bqyJ8K6rKJ/vE2Rn8m5poPVSDEfD9vLdrs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764915; c=relaxed/simple;
	bh=4SCpVL/IeTKG53E42JHkzC4LYfnBdt41K4fBb9PzOZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+iplYwN4ChGkz5SZjZ3WyHRvtM716LTGoFu/fan8d7ZfkJbf7SinhyB2ROql8UV47XaluQFBj9SlqULYgQNUlWWZWNPkdD4hdzDp5rAvE3EubNrTf1LXzuMJmxdTcXnfMiYrSvJvDV8G8onrJ4bqvpGq3sMCyOZIF6JsTrnTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjnW7Lfg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764914; x=1749300914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4SCpVL/IeTKG53E42JHkzC4LYfnBdt41K4fBb9PzOZ0=;
  b=LjnW7LfgVySWF8gDlwI3Ix50bwUwMHG5kumW8pE8lXyndXRwSbNW5P7X
   BF41qnaw/f4xxuJYctN+fLtgN3InGHhHaerZDnHepR2X0bDh7785AAjVP
   2Nz1Ve4J282XRp3vtjOSYhvU/nIcsNI4fqOBz3FMs26x9azd+cdmS0W4s
   rZqm+uShZmZd40DHnvD17HIH47XYZB+w/t3pEMXzklIjt+uY+50RSDTte
   6sX2N/34pampU7zaOHvsjOMjRThpqAMKh1JdkhvJoO2Adzs60WEr3a0NS
   AdrRvBYKsGLoWHoZC4wLA7WhEavHdXWybl4tzN4wX8WpFkxCqlNO+ipXV
   A==;
X-CSE-ConnectionGUID: NV8nfm2rQF6xU8NyjbBhgA==
X-CSE-MsgGUID: lRTcqGgnT8yaj2pAEjx7GQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25055948"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25055948"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:14 -0700
X-CSE-ConnectionGUID: bCMBMlU/S9alneuBSIFFuw==
X-CSE-MsgGUID: 7c8plW4JSdWbvr0azYZ0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69484057"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:10 -0700
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
Subject: [PATCH v6 12/16] selftests/resctrl: Make some strings passed to resctrlfs functions const
Date: Fri,  7 Jun 2024 15:53:12 +0300
Message-Id: <20240607125316.7089-13-ilpo.jarvinen@linux.intel.com>
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

Control group, monitor group and resctrl_val are not mutated and
should not be mutated within resctrlfs.c functions.

Mark this by using const char * for the arguments.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   | 7 ++++---
 tools/testing/selftests/resctrl/resctrlfs.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4446a0e493ef..5967389038d4 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -141,9 +141,10 @@ bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
 int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity);
-int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resource);
-int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
-			    char *resctrl_val);
+int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
+		   const char *resource);
+int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
+			    const char *mongrp, const char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 unsigned char *alloc_buffer(size_t buf_size, int memflush);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 9e4cda154d66..f4dc8ef23a8c 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -534,8 +534,8 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  *
  * Return: 0 on success, < 0 on error.
  */
-int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
-			    char *resctrl_val)
+int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
+			    const char *mongrp, const char *resctrl_val)
 {
 	char controlgroup[128], monitorgroup[512], monitorgroup_p[256];
 	char tasks[1024];
@@ -593,7 +593,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
  *
  * Return: 0 on success, < 0 on error.
  */
-int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resource)
+int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
+		   const char *resource)
 {
 	char controlgroup[1024], reason[128], schema[1024] = {};
 	int domain_id, fd, schema_len, ret = 0;
-- 
2.39.2


