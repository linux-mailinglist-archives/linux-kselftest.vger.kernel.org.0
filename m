Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB87D4C65
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjJXJbX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjJXJaz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:30:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB12171E;
        Tue, 24 Oct 2023 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139777; x=1729675777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3vy9fAeuuxL3PMPYGchCQGLED1dgGOCzucRm1jFBvV8=;
  b=DewtULf3PDupkB1w4Ti8UBZOcYO8gIWvF3Atv3MCzQpJYPceQN4Y3e+7
   jByE4taRbnB5JQ068flvqeO+cxWtQN1jQnDQF8jFC2pzcTXbyOs4IG5Ub
   BZtFEYBWrVNVvm6XY7AJilKqR+I4wxrV2D+dJ5qndJf+jM9Cc4Yo7WQq6
   KYacQmJqtEjh+ZxruGvJ971QLzIkw9FWNeGxM63kjKARHR365EouNeH41
   k/YAC9DkWEghKYMmt0DfrjnibltCxXhbnKxlnRN3eGbJ1uD+FQQMd6HIC
   6/xdfNv/AI1qfgl1XKoXlYEpfwLjlWJ5MJLC+dEXihBunBIc4nDBn/OXm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5644362"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5644362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758410117"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="758410117"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 20/24] selftests/resctrl: Add helper to convert L2/3 to integer
Date:   Tue, 24 Oct 2023 12:26:30 +0300
Message-Id: <20231024092634.7122-21-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"L2"/"L3" conversion to integer in embedded into get_cache_size()
which prevents reuse.

Create a helper for the cache string to integer conversion to make
it reusable.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 28 +++++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 7d72bea3ed58..b98d88f7cbc4 100644
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
+	perror("Invalid cache level");
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
-		perror("Invalid cache level");
-		return -1;
-	}
+	cache_num = get_cache_level(cache_type);
+	if (cache_num < 0)
+		return cache_num;
 
 	sprintf(cache_path, "/sys/bus/cpu/devices/cpu%d/cache/index%d/size",
 		cpu_no, cache_num);
-- 
2.30.2

