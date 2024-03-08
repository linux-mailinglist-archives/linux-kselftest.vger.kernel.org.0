Return-Path: <linux-kselftest+bounces-6103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9587653C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A6CB23DEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7344381D4;
	Fri,  8 Mar 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQIGKiJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63C58123;
	Fri,  8 Mar 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904293; cv=none; b=WsNumqtBPqih+gmHs0RujTT2r3PaxXq4KrEfVjrUizB4jDnYWZmMuSIPhAfDoqjpfXFuQ8AIUbXj0peKtadXPEiiAE0UOeLL0U2WeT9mLt2G4aO3xHNb2wNlrzckJtW2/U3G9F9QsWXCs151fXmmU0M/6JcgMrFFXNEpkJvHap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904293; c=relaxed/simple;
	bh=kRaWpTPVGxvl7VpYPhXiNMknGjdLtg0cy6JGu5e0yZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGA8nitM/8j+3GVi+npjdywMbkQobzR2qdSiAyz+fp2IUk20O0DHRddET3oWVJXhcy2GL6+M8dn8Xf6sgABSUfQYoxlpEw+C3bl6MAm/FRZsw8qD25zmeY8qkIBsSft5MeQVG6ajfSl5SOLkb55Lt+HmkLN2vnS0VLqXmiv3RFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQIGKiJF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904292; x=1741440292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRaWpTPVGxvl7VpYPhXiNMknGjdLtg0cy6JGu5e0yZw=;
  b=LQIGKiJFo0DZ/6uO2VWhargPBYIRekx8FXPzFyIUsDscS0vQa4l3SIc+
   6w9rOJs5klSskxvWLfXSquQ/8h8i1xGLvTnsLSjPkVtHLIrlwmqTXIs+z
   WtSNLznI0MtdeWVFvpyioZbQzxWdtcsqWfNacYPa8QAts3tgb1+3f4InL
   IdMC0u6IJqeYFOSLKUEAQuQjE5napJxysjxV+C8+FIIL6M+e9p8H5K6fM
   J6WyJNXBD9R4nEzett/SlGnDqd9QoQmlg5O+UUo3wfyowai1ZtEwvKVjT
   NLQPH5KsEZQdWF47N+/TRVDHNNfx8uQbqH2mQrenpTG3a88W7/BmbIQbl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15269520"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15269520"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10863404"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:24:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/13] selftests/resctrl: Make some strings passed to resctrlfs functions const
Date: Fri,  8 Mar 2024 15:22:52 +0200
Message-Id: <20240308132255.14442-11-ilpo.jarvinen@linux.intel.com>
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

Control group, monitor group and resctrl_val are not mutated and
should not be mutated within resctrlfs.c functions.

Mark this by using const char * for the arguments.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   | 7 ++++---
 tools/testing/selftests/resctrl/resctrlfs.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 9a1a3d0399ce..3ccca8556aa7 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -134,9 +134,10 @@ bool test_resource_feature_check(const struct resctrl_test *test);
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
index 95a6be52d866..e01044194ddd 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -498,8 +498,8 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
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
@@ -557,7 +557,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
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


