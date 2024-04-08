Return-Path: <linux-kselftest+bounces-7424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E2E89C9BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C9DB280C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C77914601D;
	Mon,  8 Apr 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUyyhXYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F82145FF1;
	Mon,  8 Apr 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594093; cv=none; b=Y4LsDvs64+k0mZg+hhxymgwsFQMGLyWNYrPoqwnaDsBaQaR9AuWbl1A97qxns46XH88TL2ycakNQKn/Egy7TwHqI2wbv2+1DPbQwJNhhmuLtyNkRcdGtNLWAnl7HMEvGg9+FI/boa5H7ZkZESpMdCEjWUwePTmrjwI9Sc0UiAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594093; c=relaxed/simple;
	bh=530we9tbb1br2D5djQ/lnp1n4VHVKq4UhHt+32wQESQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqGHDZhErXS+8EyCOwMgWs6mEIGPqlCTkIQeJfpaoMoc+zwZqf8cN7+Psdh6XhMIDZr0gOrse6yRVWB5gqeWKr36lfy6Zt5V7em1VIGwKExnOgSa4znfpGyQBRBg/hk7PNurWVP7UMYh5U/E9CXt0VXhpJiMvx46NcN5PJbSx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUyyhXYW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594092; x=1744130092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=530we9tbb1br2D5djQ/lnp1n4VHVKq4UhHt+32wQESQ=;
  b=XUyyhXYWem4JwYea+eWmDo8xGG/CsIcrJI+3ZTfb5KLrrMSKfZRuCxcp
   Ed8mIFGwnDhbXJkTinRw2TiNbcksC/7eZSRQKaPBJIVczjKW8oDtzGFm9
   IIJW0n8BrfjOwpd7ohH6DbpEg4u+2EASPjENNMqUkm8aaPQ0tcnnO3+3H
   kAIvdwr3/Fipnq2txrJtb0mRcG9nPH3u2dIFmymtNDvy3oxbpNbwQeyHD
   G/8v9wGEGVIjRftdW1ITu5b4ZA8MyDoHo/drlTHkZNKJUTTv23R4RlA/B
   DtY65JrRueHwuuDZC+bJgQAbxMcBXJSySrREDAVjw+yXbvRWFoJzz4zyF
   w==;
X-CSE-ConnectionGUID: LEtF753+Sgu8mK1pJUnbpA==
X-CSE-MsgGUID: KOVaHBkSTpOWxS2VxSH/HQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7750091"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7750091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:51 -0700
X-CSE-ConnectionGUID: u9ZmcFUxR+CQrfR1YRRegw==
X-CSE-MsgGUID: q6bWzXGLS8acwixytYsBWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="57396663"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:34:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 13/16] selftests/resctrl: Make some strings passed to resctrlfs functions const
Date: Mon,  8 Apr 2024 19:32:44 +0300
Message-Id: <20240408163247.3224-14-ilpo.jarvinen@linux.intel.com>
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


