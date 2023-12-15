Return-Path: <linux-kselftest+bounces-2064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5292814B61
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144C61C2357E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3DF3C467;
	Fri, 15 Dec 2023 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6EHBiWt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF454596B;
	Fri, 15 Dec 2023 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652980; x=1734188980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VB0+uopmzLBdFoQyH1tNp0ZoBbzjE/BpX5BNhSMP/b4=;
  b=n6EHBiWttpnLTeGKHOK8p4vEwWfNgEmErycUnkQwPRhCVFdINQLeBHcf
   adEM9ZyKZEkHPtCrjPAsUlbXViOv2VYN00QFKNWaugTCVl7osd1jOamua
   VKMSL8vIZJMrRVR3sQipM20+aRXnTaYOR1zXh6ON1dNGV2MgeVKPcfGs3
   4JDoM9YlTMfq7RQYAVxsQmNL+IXrcm/vLDFy1UH9xByjyk1z6GYoof1XK
   AZOnmYXDHc65tnz2QqvB6bYm0mgxtdWAqMRixpikJfvaD+dvooeLLlBrX
   cE3GzzcEP7odaBOXlFDwqMCArv23SFzjZ0Gvr+OTpce9DK3m1PBAAsoOl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392461795"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="392461795"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1106151106"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1106151106"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:36 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 27/29] selftests/resctrl: Add helper to convert L2/3 to integer
Date: Fri, 15 Dec 2023 17:05:13 +0200
Message-Id: <20231215150515.36983-28-ilpo.jarvinen@linux.intel.com>
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

"L2"/"L3" conversion to integer is embedded into get_cache_size()
which prevents reuse.

Create a helper for the cache string to integer conversion to make
it reusable.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 28 +++++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index fed6741edc5f..eab928c46f98 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -94,6 +94,23 @@ int umount_resctrlfs(void)
 	return 0;
 }
 
+/*
+ * get_cache_level - Convert cache level from string to integer
+ * @cache_type:		Cache level as string
+ *
+ * Return: cache level as integer or -1 if @cache_type is invalid.
+ */
+static int get_cache_level(const char *cache_type)
+{
+	if (!strcmp(cache_type, "L3"))
+		return 3;
+	if (!strcmp(cache_type, "L2"))
+		return 2;
+
+	ksft_print_msg("Invalid cache level\n");
+	return -1;
+}
+
 /*
  * get_resource_id - Get socket number/l3 id for a specified CPU
  * @cpu_no:	CPU number
@@ -144,14 +161,9 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 	int length, i, cache_num;
 	FILE *fp;
 
-	if (!strcmp(cache_type, "L3")) {
-		cache_num = 3;
-	} else if (!strcmp(cache_type, "L2")) {
-		cache_num = 2;
-	} else {
-		ksft_print_msg("Invalid cache level\n");
-		return -1;
-	}
+	cache_num = get_cache_level(cache_type);
+	if (cache_num < 0)
+		return cache_num;
 
 	sprintf(cache_path, "/sys/bus/cpu/devices/cpu%d/cache/index%d/size",
 		cpu_no, cache_num);
-- 
2.30.2


