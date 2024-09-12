Return-Path: <linux-kselftest+bounces-17854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1C976FFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A771C23ECB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6AC1BF80F;
	Thu, 12 Sep 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5ASdFiP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D37156F3C;
	Thu, 12 Sep 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164295; cv=none; b=CnwQxg0uAIgrV985uXhgrKS+hzu3GVJmD9K0FCMo/os+y0TiKBTNIMWcsSP7aXCSAYDNcrnYR/0jFxVRP3AET4vk6667scoPCmg6wCEoCb8fhEs9RmczGWCW1uINCzEkrMYab87Nc2HFqauBOtb5cNb/IMpucs+hYigDADXYvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164295; c=relaxed/simple;
	bh=m2qKIKBMD3l9202rvhFx78CKdiRjtOAEI4d8wLS4i18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPjPhlf+MUUbFVxfsBxLBgrF0GtvhUsF8swox5V7uEiME+KqBlMwwmIODvvNnzfzMW9NetrzcTh8T6kGBn+J37RWjcBz7ieqTIlr66i0zeFiG0Wsa5Mjj7AKAGjPoAWBEGm5q9Vl81BLd0X7WuvnIctWnEBIcEODh6PSpMVLFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5ASdFiP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164294; x=1757700294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m2qKIKBMD3l9202rvhFx78CKdiRjtOAEI4d8wLS4i18=;
  b=W5ASdFiPewX52681fs6y71DwuJPF0h8l2zERSrAURxxGH13hjQfW6zzc
   9HnRZ+9HDxX28rT80ujHFw6XyEvjQt+deYvwGqdy+7RurHjfjCofZTmbo
   ctuSl34rHGpXRDCZDEXPkgefewo+bHEINj9ywGSfOepRFHTzMhWr61P9w
   RK0OdvYLBib7vLQXxlhkOIaeRCo8ODqSseU2hI8dQSPBBKMlUABQ9TpJX
   ht7z30gF/d9HGBRwHWDiuA5FIFOI4v6tiRJjVJzjuNzajdivqLf/ADVr5
   ivPrcEfuSwLg4zG6UPWSUsHv00LsOZCKlfFuTmggNAE8c8jG+0EV6XVxG
   g==;
X-CSE-ConnectionGUID: EadLacyKSWKthoEbQ93sfA==
X-CSE-MsgGUID: /W/pyhUHQJWjkX40/SfizA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976573"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976573"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
X-CSE-ConnectionGUID: 4q2vUEAyQS+AvNPmQMA6wQ==
X-CSE-MsgGUID: 5GZXJH80RGKjy/ekPAHHBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724600"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
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
Subject: [PATCH V2 01/13] selftests/resctrl: Make functions only used in same file static
Date: Thu, 12 Sep 2024 11:13:50 -0700
Message-ID: <551f786b1df77ef2f4e25d1448dea4c6e62a2f72.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726164080.git.reinette.chatre@intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com>
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
2.46.0


