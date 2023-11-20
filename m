Return-Path: <linux-kselftest+bounces-300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73B7F1178
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157B828183E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B791134DF;
	Mon, 20 Nov 2023 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0w51w/e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9321AE3;
	Mon, 20 Nov 2023 03:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478875; x=1732014875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJ/eQhSvr2090GXHqueS1VlGnJy7feZQHUaQho+s3vE=;
  b=i0w51w/eABbM+Ye5kreDuO42MbfyLxphtQwpOxmLlyZso3mDNJLHRU19
   CauPh2EiMHysHpTu1RHDt4BkHeHAxNRqB2jC2xscQoqlJDz8RmyQ3eSuT
   UTWvOlJSpYsKj71nXqKtgibcl3aNx3OE8lEsb67ltYCUvWvuMsnfOxhtH
   OiljMST4J4hNVQtPTERRZWnlWEmU/KpXNx5YFQnF57mtCnzqioouT4nJ7
   60LgFLq2p1xUUreGYiw3MAMEx9yaRN7Pq+gSntwagjUZtMyVq4RNtHBkq
   zwh27eElpMFF1/kNYXaIoQTwtBsLAplvXWBQloIG1n7YX/lQn/AgCU1Ta
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381987317"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="381987317"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="742696030"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="742696030"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 05/26] selftests/resctrl: Mark get_cache_size() cache_type const
Date: Mon, 20 Nov 2023 13:13:19 +0200
Message-Id: <20231120111340.7805-6-ilpo.jarvinen@linux.intel.com>
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

get_cache_size() does not modify cache_type so it could be const.

Mark cache_type const so that const char * can be passed to it. This
prevents warnings once many of the test parameters are marked const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 7a2b4da684ed..62bad95ea7d0 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -100,7 +100,7 @@ void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
 void mba_test_cleanup(void);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
-int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
+int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 211fc7647659..1ea610fa65b1 100644
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


