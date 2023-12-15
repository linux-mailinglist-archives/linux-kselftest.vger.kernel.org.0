Return-Path: <linux-kselftest+bounces-2043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE5814B32
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F78B22A4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85343589B;
	Fri, 15 Dec 2023 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyBEBAf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D53C467;
	Fri, 15 Dec 2023 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652803; x=1734188803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWp99CvfEs3juH76lfGgpykzybUU3pFntQVJ+7uu18A=;
  b=XyBEBAf4A7zcEgHtANZTQplqnzjYtG/b1h4nanBEvRE/NfCRLxaLIr/l
   WldaHjfAO8JDzjSeRmKlnfZdkkA8eAmCo4nqfA8fQMys0wvfQjSXXb0ye
   o/N3d5U69BpKfG3ip2J8IKPFCav7LGZNXEiEnRttDyNfg3Caewc5SCNiB
   htBSeojvvLtjGpd6gR16MBVUZWWhiO9dGKtrtNx8mT4j2KMBFKrFBe0ZG
   wNReWABxin/F8FAx9OrO+06YnMslP2aNF3G1iHBQKaxiU+FeIZvavJsxi
   cjaYuBLD2F4hTrh2BYT5vgYrT/315LMNX/82V5exzitDQWe1GQzMbwy0m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2453562"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2453562"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="809000777"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="809000777"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:06:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 08/29] selftests/resctrl: Mark get_cache_size() cache_type const
Date: Fri, 15 Dec 2023 17:04:54 +0200
Message-Id: <20231215150515.36983-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

get_cache_size() does not modify cache_type so it could be const.

Mark cache_type const so that const char * can be passed to it. This
prevents warnings once many of the test parameters are marked const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 89cd89507891..9e5777e1eee3 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -99,7 +99,7 @@ void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
 void mba_test_cleanup(void);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
-int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
+int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index a74be17eaa4e..1bbeb4dccf05 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -138,7 +138,7 @@ int get_resource_id(int cpu_no, int *resource_id)
  *
  * Return: = 0 on success, < 0 on failure.
  */
-int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
+int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size)
 {
 	char cache_path[1024], cache_str[64];
 	int length, i, cache_num;
-- 
2.30.2


