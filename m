Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6168EBD2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 10:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBHJkm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 04:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHJkl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 04:40:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B6977A;
        Wed,  8 Feb 2023 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675849241; x=1707385241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5te91Tbq5bcJrl+9WOQqOi1osSLqIV0/0A3oSWetII=;
  b=eArhFvezlXrIsHO7y4PCNZ3nY9GvP2UKsGsqRmtORWukG6edm31gjosI
   ZXTlpjN/jWaYf20das9FYIE47qDdNl4V6LtzGtlKlCTelS9AljdlbeHTx
   jGz5hd6wG19j2VmkFi6M9bMGFfzY6bp/DPfDni758uyDy23Npu24p4LPZ
   U+8MQi0cYvj20A+BUmHzlg4Nwjuf2eBUEo/KKXvHq77+F93XpDCrrGrR3
   mdjTEmkV7hZuLd4WwfESiCfb2q98YiROcODkTOfARowM3X0K5fcNRsZvz
   aUFYInyGmfSR4Uk8PoKVwfxoZ5yu0oRZvIp1z0V0VcYGZ4lZAfUGAHaw9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328410784"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="328410784"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:40:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617150253"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="617150253"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:40:38 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/4] selftests/resctrl: Change initialize_llc_perf() return type to void
Date:   Wed,  8 Feb 2023 11:40:23 +0200
Message-Id: <20230208094026.22529-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

initialize_llc_perf() unconditionally does return 0 so no point in
having it's return type as int. Hence, change it's return type from int
to void.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 68ff856d36f0..4b8ee81aedae 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -48,7 +48,7 @@ static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
 	return 0;
 }
 
-static int initialize_llc_perf(void)
+static void initialize_llc_perf(void)
 {
 	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
 	memset(&rf_cqm, 0, sizeof(struct read_format));
@@ -59,8 +59,6 @@ static int initialize_llc_perf(void)
 	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
 
 	rf_cqm.nr = 1;
-
-	return 0;
 }
 
 static int reset_enable_llc_perf(pid_t pid, int cpu_no)
@@ -234,11 +232,8 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-		ret = initialize_llc_perf();
-		if (ret)
-			return ret;
-	}
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
+		initialize_llc_perf();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-- 
2.30.2

