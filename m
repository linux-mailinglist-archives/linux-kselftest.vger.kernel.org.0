Return-Path: <linux-kselftest+bounces-20087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C246F9A32B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D632B21E37
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09746152E02;
	Fri, 18 Oct 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dj8Rcggx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44051C4A;
	Fri, 18 Oct 2024 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218159; cv=none; b=OsUoA5dZijHj0+2xJZKqGi2jv0zMlNG5+IMm5VKlt4C3SQsnd8njEcxm6aIqp9RDVGQgGTkXVHXNB/SXmgHCQagHt2kZRFd0TmmeZeU4YV5mGp+xdLeTwk44FgspZ5I4gZ9KmAGFVJ2G7UAgas1vUC50evypYhi7RvAlDtZFmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218159; c=relaxed/simple;
	bh=KrVngyFGE5oudkQB75kRR5MAeQoNnD4X59aZn9uB91E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVfbULcHz8eR528BJ/Ostb2k+2v9tdATXcxCbLQprVY4mo43rK+/Q4jGkO8LM0vyQZDe4Njx8vzF0x2WD0AkkjlMJx4NRcv7D6LlHpBoISopK2Sz/gUgDHuKAlQpwShiXXTg6TvCNxNQZYgP+UQSftvFlfzuA0lLlty9tB+bmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dj8Rcggx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218159; x=1760754159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KrVngyFGE5oudkQB75kRR5MAeQoNnD4X59aZn9uB91E=;
  b=Dj8RcggxR09Likhd3NipBCU49hM3nvBKrUIRVxmaSZkR0ApoGkaEqtAn
   W94NIy9qe6VaAl7DecHo1AkLo+wvoUB7nWOwGvjP6Hm5VwczyFvVWCDuP
   yVwouJxC9PoaCZjI+W8yz5LsJwApwJadouABnzAnR/ZO1m+wYajnpzvbn
   rQiGFiXI5jHAgWkZ8jidO0ZTRkENg1hp8vLikkj9ofp+Ds6UEYeY4VGjq
   j+hZk5PQb5cRK+UlPs6w8jmgLHRInhaWkmQZlPcFgVjJhXW5wOQdDaN9T
   TzZAbTrCCrFmyfbE/zbUBds+V3KWDTRSch28unl3LrJOlH/9or1s69m9p
   Q==;
X-CSE-ConnectionGUID: mrUJVxQWRqO4kGLZXnmKug==
X-CSE-MsgGUID: KTlwA4j+QiiDRThCQZ3zag==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149667"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149667"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
X-CSE-ConnectionGUID: +bZBXRaqRC6JHsNpKtRJoA==
X-CSE-MsgGUID: /P3/vDGOTY6b669hWsuGEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697698"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:36 -0700
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
Subject: [PATCH V3 01/15] selftests/resctrl: Make functions only used in same file static
Date: Thu, 17 Oct 2024 19:33:16 -0700
Message-ID: <551f786b1df77ef2f4e25d1448dea4c6e62a2f72.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
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
2.46.2


