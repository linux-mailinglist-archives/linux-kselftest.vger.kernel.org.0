Return-Path: <linux-kselftest+bounces-16743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031596532B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 00:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0922818CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D871BE229;
	Thu, 29 Aug 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOR4ZBzv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F991BB6A0;
	Thu, 29 Aug 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971962; cv=none; b=aVDhZ95L3+HuqsJv2st5FEJYdVj93pD90ojApBx5pPhvGImqwfkAqLkdHv8le8zTHjHp3Gafy3klTfWg8jWIpQ0hkVZ0gR1+OAuxOArW6k7OFZXF6AJ42ajvgubLkeSJdZKxoXkKhao2j+CvhAq6yoX9Lq/9RSJybH0jkR5m5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971962; c=relaxed/simple;
	bh=iKp4xCXqNgDjqiNx2zTCptY03/NMsct47JdU65TyF24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNAJ1txMH9CjOkyEliVj/xp+Z3Fg0FURUNACLW2UsnUXM4vAda4g3E6XyRC29gCE5Dw3ezN29cubKjlUOsD606uTUhBvTv8OVIQLMfBsGER5tlSxAm0dP3mZ84HmKo5xcuVJPhZH6Lge9foH8yinKFsYbPBl+idahih3bhEpcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOR4ZBzv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724971960; x=1756507960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKp4xCXqNgDjqiNx2zTCptY03/NMsct47JdU65TyF24=;
  b=gOR4ZBzvuSehOIFgsY8dOY/QhCHaLwru209Juqiukk0pPzKyNYIbBx1b
   R4M5mwa6X4/gr1SF4aD+K2ew7UKVS7aZREWKuCHqSD/1iuwIIZIo2zwCE
   DKlo/ahqN0zrPzdGs9DddGxd+ZH8kiouz483nCP53drilxVnRikpXKojc
   C4APm1DrirGdl5uy4AiLcCmILsefT0u0GUvDOKzcEJQRiGeyLw7mGMd/f
   EjNJ6oZOjN999xKl9Dz0lvQ33cwqkXhjaDLYgHPPDaEiYktWTGRRJXJio
   a2X79aapX6rXpj+vHoukyAHbNWnFCnLd/pCgu5XPPOSpQBCcxABcq0gAe
   w==;
X-CSE-ConnectionGUID: PItHW7abSXClFDzCe7sOOQ==
X-CSE-MsgGUID: Aec3CK/PR2+D38xkOABU1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27479155"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27479155"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:39 -0700
X-CSE-ConnectionGUID: SKskw/HRQqmZyejLlvWAyw==
X-CSE-MsgGUID: r5HhghX/T0a1Sa9ay8iHUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63415122"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO rchatre-mobl4.intel.com) ([10.125.111.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:38 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] selftests/resctrl: Fix sparse warnings
Date: Thu, 29 Aug 2024 15:52:27 -0700
Message-ID: <ff4afcc2d4988edce7346b4bd32ee06bf724e6fd.1724970211.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724970211.git.reinette.chatre@intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix following sparse warnings:
 tools/testing/selftests/resctrl/resctrl_val.c:47:6: warning: symbol 'membw_initialize_perf_event_attr' was not declared. Should it be static?
 tools/testing/selftests/resctrl/resctrl_val.c:64:6: warning: symbol 'membw_ioctl_perf_event_ioc_reset_enable' was not declared. Should it be
static?
 tools/testing/selftests/resctrl/resctrl_val.c:70:6: warning: symbol 'membw_ioctl_perf_event_ioc_disable' was not declared. Should it be static?
 tools/testing/selftests/resctrl/resctrl_val.c:81:6: warning: symbol 'get_event_and_umask' was not declared. Should it be static?

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 8c275f6b4dd7..70e8e31f5d1a 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -44,7 +44,7 @@ static int imcs;
 static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
 static const struct resctrl_test *current_test;
 
-void membw_initialize_perf_event_attr(int i, int j)
+static void membw_initialize_perf_event_attr(int i, int j)
 {
 	memset(&imc_counters_config[i][j].pe, 0,
 	       sizeof(struct perf_event_attr));
@@ -61,13 +61,13 @@ void membw_initialize_perf_event_attr(int i, int j)
 		PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
 }
 
-void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
+static void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
 {
 	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
 	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-void membw_ioctl_perf_event_ioc_disable(int i, int j)
+static void membw_ioctl_perf_event_ioc_disable(int i, int j)
 {
 	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
 }
@@ -78,7 +78,7 @@ void membw_ioctl_perf_event_ioc_disable(int i, int j)
  * @count:		iMC number
  * @op:			Operation (read/write)
  */
-void get_event_and_umask(char *cas_count_cfg, int count, bool op)
+static void get_event_and_umask(char *cas_count_cfg, int count, bool op)
 {
 	char *token[MAX_TOKENS];
 	int i = 0;
-- 
2.46.0


