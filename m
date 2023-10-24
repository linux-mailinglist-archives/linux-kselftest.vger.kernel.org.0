Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630707D4C44
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjJXJ3b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjJXJ3H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:29:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2B81FC1;
        Tue, 24 Oct 2023 02:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139709; x=1729675709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwVbuYCXjjmS1wYgCO7ZGGdahtlDKGYkkf8/AfncZ54=;
  b=HB2EnfV3CRcRQ3WcLzJJ/TUGJKZK4Ccxx3yMN4HcovuhVIUDTyd9vzh4
   VlF7gma3NuLTB6+JNbLdsjaS4a7WA4RndDHw0EcJWCAezWgKKVVUUZdH3
   fpoW7ZU/mjrLIP8kPEMcCA6N9iPLyvuwwZBryKfsOPmf6VqBXptfMfPFB
   h/D5oY5SxzedlzuaKLjOETpYpDs6BltDmfrXEzciKimgtmSlOyxIj/6JT
   C30HMOPL6NMJihXyK8s/62liOcCoI2KI1hEPvXhqQf3qP4zzBWfzTtVph
   cbXUJFstPHQd9t1P1sGmKA0jGNWA5aF3KGW2SsG6CMfZBhYfT2hE5E1sW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386829566"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="386829566"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828754682"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="828754682"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:25 -0700
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
Subject: [PATCH 12/24] selftests/resctrl: Improve perf init
Date:   Tue, 24 Oct 2023 12:26:22 +0300
Message-Id: <20231024092634.7122-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

struct perf_event_attr initialization is spread into
perf_event_initialize() and perf_event_attr_initialize() and setting
->config is hardcoded by the deepest level.

perf_event_attr init belongs to perf_event_attr_initialize() so move it
entirely there. Rename the other function
perf_event_initialized_read_format().

Call each init function directly from the test as they will take
different parameters (especially tue after the perf related global
variables are moved to local variables).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index a70ace82e76e..a84679a4ac0c 100644
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
@@ -27,18 +28,12 @@ static void perf_event_attr_initialize(void)
 	pea_llc_miss.inherit = 1;
 	pea_llc_miss.exclude_guest = 1;
 	pea_llc_miss.disabled = 1;
+	pea_llc_miss.config = config;
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
 
@@ -192,7 +187,8 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
-	perf_event_initialize();
+	perf_event_attr_initialize(PERF_COUNT_HW_CACHE_MISSES);
+	perf_event_initialize_read_format();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-- 
2.30.2

