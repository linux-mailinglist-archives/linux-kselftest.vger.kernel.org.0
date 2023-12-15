Return-Path: <linux-kselftest+bounces-2053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E007814B46
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936E6B237C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AED364C3;
	Fri, 15 Dec 2023 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgQhW3iU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EED3EA67;
	Fri, 15 Dec 2023 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652877; x=1734188877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBcdrvEK0XQ9ISAlNYAMavewDocUP/dWs8LzX3EURKw=;
  b=hgQhW3iUSiz00Yl7qA4o3aJu0C/b4w3jEB5EgbtxDISxtP5PNEu8Js7e
   rdzZnqwhKnZX9lNrumrDvAGz9R3EHEY6diMyjXVkEDWUwVhcADXDQpjyP
   cb4vwpp/yJxbBp/0Z8jkJ32UHouXlBHiSlj3hpxdafrjDJP63GndC6YiX
   Unt0T6Hjfacfoq80dh+pGx25D/KVjOYq1Pj0m6G1z+j6oOgzwFlpRgvoQ
   EuFSPQv+Pmd5U7dC1r2XuOmPJ3eo/O1pBkrSGSY3g+HIapmyigfsYHbNf
   kEkCBunmuB1u3Tf9swrxfWW/k/1B8BQ4PZ61+O6dyOUofseRQQVjtOxNI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="399120743"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="399120743"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:07:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="17750930"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:07:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 16/29] selftests/resctrl: Improve perf init
Date: Fri, 15 Dec 2023 17:05:02 +0200
Message-Id: <20231215150515.36983-17-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 7f45c4957f81..58ee6f6b0edf 100644
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
 
@@ -204,7 +199,8 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
-	perf_event_initialize();
+	perf_event_attr_initialize(PERF_COUNT_HW_CACHE_MISSES);
+	perf_event_initialize_read_format();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-- 
2.30.2


