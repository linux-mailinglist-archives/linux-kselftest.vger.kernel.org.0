Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B568EBD6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 10:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBHJky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 04:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBHJkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 04:40:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00F442C1;
        Wed,  8 Feb 2023 01:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675849247; x=1707385247;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=w+4SOYOHFtsPv6X601DdF2MZZiDyDeUy+9jXep2pHig=;
  b=WSWvz7/DXP2tg7EQ624fMeamhszyTdDVkFBXkWqXFhNfKjJzRasw7gB5
   AynA7Ldh6Qc9TUgPCTgYqRa4TCEbJG35f4oLoV+yGMowrX0aWeoOfaF/F
   gzgfI1/z6wAOY/CrhAKcVqBsknFUr2H4PLkYU9MAew5STnfNFlInysQil
   22AbPvGDWVrrD/0jv8qeiIATu8ZbI6AG1ime0Zci/yGPC2HI+6MP97pbs
   pkdHePUYsTt0AsG2ZGFsSq5WHhjG7QFZ4pD3XyGFqSrEmpJ0BhOBmvT3u
   hMLSKcs3h/gb8tAyqc5qLog8/SCCqmxlreUqKsriJgm+NiYrL74mmzIz+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328410798"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="328410798"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:40:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617150282"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="617150282"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:40:44 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 3/4] selftests/resctrl: Change name from CBM_MASK_PATH to INFO_PATH
Date:   Wed,  8 Feb 2023 11:40:25 +0200
Message-Id: <20230208094026.22529-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Signed-off-by: Fenghua Yu" <fenghua.yu@intel.com>

CBM_MASK_PATH is actually the path to resctrl/info, so change the macro
name to correctly indicate what it represents.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f0ded31fb3c7..4f0976f12634 100644
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

