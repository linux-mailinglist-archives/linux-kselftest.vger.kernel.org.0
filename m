Return-Path: <linux-kselftest+bounces-10435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C407D8C9D69
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0185C1C2257B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9596BFA3;
	Mon, 20 May 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ug1phEon"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A56BB5B;
	Mon, 20 May 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208340; cv=none; b=ZQZWgNctAnRE4LfY6wlmGa/Z85wyzuujs/7lXNnxtWn34Go+PGn5+gimh7acjB9WRhibxhnRygxPV+BAR8w18GOsPljAFfNttgyF/3rbZQSjWWJIHoHSgFcZzdtvQBV7yTPwizdYuX1y8BAGuX6wTyr9h8Cj+NrfrUllQe/DRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208340; c=relaxed/simple;
	bh=530we9tbb1br2D5djQ/lnp1n4VHVKq4UhHt+32wQESQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHNNHpryzB70DPnUZ06IDOnT0idUKQf9DH6+IUsD538Hz9He8Vhxd/APid+orcB4mF15LA5JliXSnaqp4jPAhU4+2d2x2bfjbTk8ii84GjqirSpDlw0SXaGclrr10Ng6uHxRFj8PB20xuHLbB2i5cyoeNWJp//OkElFl/2g7b30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ug1phEon; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208339; x=1747744339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=530we9tbb1br2D5djQ/lnp1n4VHVKq4UhHt+32wQESQ=;
  b=Ug1phEonWEYPXkGzRxjEYLnSG35Rn9dgI3zOMJ9tqwqd1QeaO/Jyc/pb
   dP89rSeZ+bpO39JG6Y9I4UoTqbfuNSvF6R2bzfdzwSRjnAzs9mma6S+q3
   ghscS/41LmgZNmuhat9rJqlTgqoca/NklbJBnrcCPoNdz21oDSjd4JG1E
   aZwyBEcBySALoQ8XQSfDh4uMeIGnK/n0bC1PxpsRJPbOo2ggol9fk3fb+
   pIsOiLDp0FmLZaBvyorbFsvY1PDtCrBdtD+FiuyyL0o8tmRelu2cLCfkQ
   uMxHjA1PUxh/Y36ohzTNBnfTHv68P6cD8UX2Bbgb3RgK6UAnse6vSoxxf
   A==;
X-CSE-ConnectionGUID: 5pqFe0JDTTKHbbhKZsyXFw==
X-CSE-MsgGUID: dN6iL4uMS6CIVDfWIvk4Fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12180544"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12180544"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:19 -0700
X-CSE-ConnectionGUID: HONmiqAjShaqzJMUIBk8eQ==
X-CSE-MsgGUID: DWdxaSGLSxKapeDDse7UiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="33091261"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:16 -0700
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
Subject: [PATCH v4 12/16] selftests/resctrl: Make some strings passed to resctrlfs functions const
Date: Mon, 20 May 2024 15:30:16 +0300
Message-Id: <20240520123020.18938-13-ilpo.jarvinen@linux.intel.com>
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

Control group, monitor group and resctrl_val are not mutated and
should not be mutated within resctrlfs.c functions.

Mark this by using const char * for the arguments.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
index aac382eaa032..a0e84157eb63 100644
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


