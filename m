Return-Path: <linux-kselftest+bounces-11012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C58D62A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60117B2719A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C4158A35;
	Fri, 31 May 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLP+UOu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE9158A37;
	Fri, 31 May 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161232; cv=none; b=oEZUXDwtv3/VmRDVgpsNp2bZJaTjcdHmi6xaiWHA8kKbYnTvfDGdXhdm171lfyRu1G9g5pV3ppcX0JB+IWEIMelcxlcFpysiBGTCzwsfpy3K6/wvFFbP4GhH1mqpSPwpOS1kH32bwKaQRFZX+QvoQfSbQ4mThyWa3w6Ml3Tp98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161232; c=relaxed/simple;
	bh=oyiBqZIntQPj4G6U3zZCp1m6/YoI8zCEvCRwFyxhcXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0R5YsOpNJ5tOuKSFUkga0hmOUt3ry+E5c6heMXpLFiL2uxLd8jfAFVpSeL/06c1HPebnUNwG0FoKm9NjJzvY7MndDEwPANRiYKW6Olt82re7NTM6/ySd/gQAetO2+vX7JebrDlgyLjQ4guzF5lzC5LH1YSSO1fsKtYCR7A1j+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLP+UOu9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161231; x=1748697231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyiBqZIntQPj4G6U3zZCp1m6/YoI8zCEvCRwFyxhcXA=;
  b=VLP+UOu9WfSS54KYptPPRWEsk5EMmytMhLlQQkfljE7wGUeF2KiDC4Vb
   OpjnA+py8SAJ8KIfq+N6YgZl4MXVFi+Y0pzerAqjuBa1vP3DbovH2WS6w
   /cMaZkBVFYVFUpwp3nPNhH06UsqiN2YF+RsJvX4yEhjApegA1uPxwqXna
   OdtlN7p6ksoifXdJFtaEpT1PyEvYBJK5TtMQ72K43nRbGa//VCwP51kZT
   SvgVb3/kibG2onYH2CW0GGyc7hIb8l6jj/9uqop1Hog5/sfKqrAD7rWz4
   hQNdjoYG+WOveI8rWj3+kgp3iggLUI6VsIuv2Ojgd6w/vYAwdIrLc05Jr
   g==;
X-CSE-ConnectionGUID: 5zMq6Mb2QGewtUUfX1WWcw==
X-CSE-MsgGUID: 2+BNHhM6Rx67zm6RKHuFzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24263325"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24263325"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:51 -0700
X-CSE-ConnectionGUID: bGhuBRP3Rlia0poHogO87Q==
X-CSE-MsgGUID: G39GX+foQAqBZMCHvl5OtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36098382"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:47 -0700
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
Subject: [PATCH v5 12/16] selftests/resctrl: Make some strings passed to resctrlfs functions const
Date: Fri, 31 May 2024 16:11:38 +0300
Message-Id: <20240531131142.1716-13-ilpo.jarvinen@linux.intel.com>
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

Control group, monitor group and resctrl_val are not mutated and
should not be mutated within resctrlfs.c functions.

Mark this by using const char * for the arguments.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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


