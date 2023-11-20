Return-Path: <linux-kselftest+bounces-308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D14977F118E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71662B21225
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFA6FA6;
	Mon, 20 Nov 2023 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwLjWhsS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD62FE8;
	Mon, 20 Nov 2023 03:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478947; x=1732014947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2nuB8c4RaFldr1vBKKlrQfzunfFSpEE8iiNB8l6YAk=;
  b=ZwLjWhsSCCm7vo+5LJpeGRztvLCi6lUEfrRGVvG8+DCGpTiwUgPE51fx
   f8hcnVv815vyviokK1hbi5SkJyW7rk5O8Jyko8EC5a5M7peNw9YOnOI01
   Vwi1p4aCXNQoTybWWNIEFVv6OFczCf/Gf502G2gh1IfZhtXZ+ZL6P8aOA
   hetJlqa/8VW+McxFzNbHJuydotEIaXmsMdcwaRGjXtf3oclDd4s69uvK7
   +U9ytRamH0J/uDlUy5/vbS76T6AhnRuTSTdo94EPkj30vTwFBmelAGF1k
   xg/L8gKtGcT0KaNVH8W74xicpzEaNkuHSDgmt5SLq1L4BeOgrFkbgWva2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="388737113"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="388737113"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="759761255"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="759761255"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:15:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 13/26] selftests/resctrl: Improve perf init
Date: Mon, 20 Nov 2023 13:13:27 +0200
Message-Id: <20231120111340.7805-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

struct perf_event_attr initialization is spread into
perf_event_initialize() and perf_event_attr_initialize() and setting
->config is hardcoded by the deepest level.

perf_event_attr init belongs to perf_event_attr_initialize() so move it
entirely there. Rename the other function
perf_event_initialized_read_format().

Call each init function directly from the test as they will take
different parameters (especially true after the perf related global
variables are moved to local variables).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 52d37d1c380f..315f30f23371 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -15,8 +15,9 @@ static struct perf_event_read pe_read;
 static int pe_fd;
 char llc_occup_path[1024];
 
-static void perf_event_attr_initialize(void)
+static void perf_event_attr_initialize(__u64 config)
 {
+	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
 	pea_llc_miss.type = PERF_TYPE_HARDWARE;
 	pea_llc_miss.size = sizeof(struct perf_event_attr);
 	pea_llc_miss.read_format = PERF_FORMAT_GROUP;
@@ -27,6 +28,7 @@ static void perf_event_attr_initialize(void)
 	pea_llc_miss.inherit = 1;
 	pea_llc_miss.exclude_guest = 1;
 	pea_llc_miss.disabled = 1;
+	pea_llc_miss.config = config;
 }
 
 /* Start counters to log values */
@@ -36,16 +38,9 @@ static void perf_event_reset_enable(void)
 	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static void perf_event_initialize(void)
+static void perf_event_initialize_read_format(void)
 {
-	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
 	memset(&pe_read, 0, sizeof(struct perf_event_read));
-
-	/* Initialize perf_event_attr structures for HW_CACHE_MISSES */
-	perf_event_attr_initialize();
-
-	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
-
 	pe_read.nr = 1;
 }
 
@@ -205,7 +200,8 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
-	perf_event_initialize();
+	perf_event_attr_initialize(PERF_COUNT_HW_CACHE_MISSES);
+	perf_event_initialize_read_format();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-- 
2.30.2


