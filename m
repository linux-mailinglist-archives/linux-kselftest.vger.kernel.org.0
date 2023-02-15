Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2262E697CC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjBONHL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjBONG6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:06:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014C339286;
        Wed, 15 Feb 2023 05:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466404; x=1708002404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJytfcP4W/Nd+1A+HEFfRfK2SHfSGE7vjyPsbBrbJmY=;
  b=TRZAIE167DY/ZC9oRyUKjguxo6j6BTcOueb8naUcUYop9qcV98ssqpar
   opte8qj9wCCOSKfBsNOBbLYzxz4o+bbxP1nRq+zmGwnqYe4C5pkJUwpag
   uvoYfnSDfhA+ztayGE1HQJN74VPpHdfeAfp7l4wEMIWHNYS44xUyq815U
   35pgbUMQHwJhnGWN2RmTNXuOe4z7gOZ3PwV+0Fsk+KcBHVqaQd93Z4BvL
   GFxcRkknCwBLbTzF2vKTR0KBMhT+OHccPqxeT40Pu0+3p69DXuiDMKEOc
   ftBjKNepqCFz+4NFDSbzA9uVq2/j8U98hCs+BAGZNWWQZEezmkvw6uiPm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456307"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456307"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436095"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436095"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:40 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 7/9] selftests/resctrl: Change name from CBM_MASK_PATH to INFO_PATH
Date:   Wed, 15 Feb 2023 15:06:03 +0200
Message-Id: <20230215130605.31583-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

CBM_MASK_PATH is actually the path to resctrl/info.

Change the macro name to correctly indicate what it represents.

[ ij: Tweaked the changelog. ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f44fa2de4d98..20aaa7c0e784 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -28,7 +28,7 @@
 #define MB			(1024 * 1024)
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
-#define CBM_MASK_PATH		"/sys/fs/resctrl/info"
+#define INFO_PATH		"/sys/fs/resctrl/info"
 #define L3_PATH			"/sys/fs/resctrl/info/L3"
 #define MB_PATH			"/sys/fs/resctrl/info/MB"
 #define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 6f543e470ad4..cc6cf49e3129 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -210,7 +210,7 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
 	if (!cbm_mask)
 		return -1;
 
-	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH, cache_type);
+	sprintf(cbm_mask_path, "%s/%s/cbm_mask", INFO_PATH, cache_type);
 
 	fp = fopen(cbm_mask_path, "r");
 	if (!fp) {
-- 
2.30.2

