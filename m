Return-Path: <linux-kselftest+bounces-20575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB3F9AF44A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA31B217C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2E2178ED;
	Thu, 24 Oct 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJRvg89A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D119E975;
	Thu, 24 Oct 2024 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804084; cv=none; b=Sr/4vqVs5hb6DBnhmsu6hgflNPaa7NTeSxtvSl3uF5dx5BrlcNAWQFVc5atQdZ4QqhKheCuX710f98SWI4MZXykLI7lkAb5at92zcnDpVIeXn+yfzVWXRV7ozKRIV+NXHkiokRs01KTXD9TkLH7HMkeTbf60OTr0sxORi2rDndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804084; c=relaxed/simple;
	bh=Crd/6uBvwkLS624C2I2nGq3B18WmfaTdjyycMbejCYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgoNQXOos42pp3MYiOkyx/8N3rgR4l9DPzWuCqqWb8WmhOm+59X0dBWQ9iTWLlzj98T4dYbFxuFz/hh4EQQkwo4sLVk62EcbMEnD3M3aG4ebWwVApZ7mOg4vvEOnkm/6MN8O+1oVv07+A+MMwXV+ois40UVNw/n/9ke/UQDesbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJRvg89A; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804082; x=1761340082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Crd/6uBvwkLS624C2I2nGq3B18WmfaTdjyycMbejCYI=;
  b=IJRvg89AiU20ryKgr422kVfzd3WSM5hh1EtIskPCPn/o4qiCt1O7mDaA
   syhHRI1GGyMCy0B7aMmieZXBJhRQf0nxHp/SbaUsyPmR1j2nbK78dTsln
   raZmAEU+l5TLSuO6Al6e/ToIQe/cB4IvVtKCi3GeMvQ5VS6cemFNRegjc
   fvGU72Lu6ZWK32hoZLk8fZ9xio9mUA3V9v6iIHNSTGBiA6kUqqQjZIR5F
   RES+vnIInXCQr4GBHFplar+wN2mCIfUaIpSki/9Q1rsmh7EmiVuTuFzft
   CoEjsqZu7FdHsV/Rdmc9IJneAEeQkw2OQQTCWbphmhZYepQq8IfcV3pt+
   w==;
X-CSE-ConnectionGUID: OhqWdO6bTsCYilRwn+yeaA==
X-CSE-MsgGUID: C9CALt35TduOU85G4XCPOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090868"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090868"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:00 -0700
X-CSE-ConnectionGUID: 65ADica2QgS4w4YjfNWwDg==
X-CSE-MsgGUID: DWxS0w3JS/OsP84CRCETiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488020"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:00 -0700
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
Subject: [PATCH V4 01/15] selftests/resctrl: Make functions only used in same file static
Date: Thu, 24 Oct 2024 14:18:38 -0700
Message-ID: <c1e8c2d732fbf9ee1531aeea9a490a68b82db4f9.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix following sparse warnings:
 tools/testing/selftests/resctrl/resctrl_val.c:47:6: warning: symbol 'membw_initialize_perf_event_attr' was not declared. Should it be static?
 tools/testing/selftests/resctrl/resctrl_val.c:64:6: warning: symbol 'membw_ioctl_perf_event_ioc_reset_enable' was not declared. Should it be
static?
 tools/testing/selftests/resctrl/resctrl_val.c:70:6: warning: symbol 'membw_ioctl_perf_event_ioc_disable' was not declared. Should it be static?
 tools/testing/selftests/resctrl/resctrl_val.c:81:6: warning: symbol 'get_event_and_umask' was not declared. Should it be static?

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since v1:
- Add Ilpo's Reviewed-by tag.
- Let subject describe the change, not the tool that found it. (checkpatch.pl)
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
2.47.0


