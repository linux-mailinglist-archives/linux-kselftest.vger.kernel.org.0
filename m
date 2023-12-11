Return-Path: <linux-kselftest+bounces-1534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D980C974
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39ACE1F216B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EAB3AC27;
	Mon, 11 Dec 2023 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqTKSALa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141C419D;
	Mon, 11 Dec 2023 04:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297195; x=1733833195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZ0FrPzrovUZ12K5uT1Ot5nZ1oekQb+KbJEu5ZZLooI=;
  b=PqTKSALadYC5e+h+6YG8jmRiLE9XInlNTOxNa+wae3e5ygM/cduFKUwa
   8C/h55QDGqwmHBKzWz1IDAkzMlML8fq1b+/NUQvWp3ETu4srgaSOutUFX
   VGMwsi86D/jpIV6lTW3yNb+oCMlsFj6uq182e34CjeqfH6Nr6R8xEiNqD
   ssC2qmDVc2BznnMWHzPUHQ5g/vuubAIJYB3rtKhwipT6vUNqfORJaedND
   PUnBuSiUPst8X0I7ltcplb1+Bxdp/Ew1msesrAsXju1NDP3nqn9rLlHqZ
   7kT7aQ1CiC7h2VnjdjscaloF3UjSCvyF1rhYUJ88BSmFEoLjTWsglj0Lz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1708219"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1708219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="896440912"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="896440912"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 08/29] selftests/resctrl: Mark get_cache_size() cache_type const
Date: Mon, 11 Dec 2023 14:18:05 +0200
Message-Id: <20231211121826.14392-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
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
index 5f322a55dbb6..65e149038248 100644
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


