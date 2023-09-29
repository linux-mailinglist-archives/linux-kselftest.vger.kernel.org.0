Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5F7B312C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjI2LVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjI2LVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 07:21:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1341AE;
        Fri, 29 Sep 2023 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695986465; x=1727522465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PVn56X56Wrx64QPNUKF/C+r8extw29MLooKw3ZIFeg0=;
  b=Od+yffdlyqFRakdps9yErecSDjHt6AufjgACn1gJUUEwphKgKygZkO0N
   RMcEhMhd8+a9siMbAwFqdIkJO4f5zRWYfLsyoR2Q2Q8EXbI7df5kLJCDp
   U3Jfyutf70QxN8MaCBCpUKyiZws+kCZ1ZwhQygZ3q0I6acFUiTXZUTzSp
   s9HepuSBR/bqvhIXrV8cgj1Sb4ifR40VehebM1+VjQHifffJSZTFa3VLR
   FWMwYzM99WIsUYkfMN1L+FBt1hjoEh46jcEcXL6Flt1xv7X5ndWXYIboq
   Qvz+/82DzUeduYauZJtDruLbekVkqBMQ0ofy30u1RO77x9I6PvzF8HyWP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="446435510"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="446435510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="779243762"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="779243762"
Received: from valeks2x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.242])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:20:59 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/7] selftests/resctrl: Fix uninitialized .sa_flags
Date:   Fri, 29 Sep 2023 14:20:33 +0300
Message-Id: <20230929112039.7488-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230929112039.7488-1-ilpo.jarvinen@linux.intel.com>
References: <20230929112039.7488-1-ilpo.jarvinen@linux.intel.com>
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

signal_handler_unregister() calls sigaction() with uninitializing
sa_flags in the struct sigaction.

Make sure sa_flags is always initialized in signal_handler_unregister()
by initializing the struct sigaction when declaring it.

Fixes: 73c55fa5ab55 (selftests/resctrl: Commonize the signal handler register/unregister for all tests)
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 51963a6f2186..1e8b90077218 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -504,7 +504,7 @@ int signal_handler_register(void)
  */
 void signal_handler_unregister(void)
 {
-	struct sigaction sigact;
+	struct sigaction sigact = {};
 
 	sigact.sa_handler = SIG_DFL;
 	sigemptyset(&sigact.sa_mask);
-- 
2.30.2

