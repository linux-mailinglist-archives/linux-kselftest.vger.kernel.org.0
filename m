Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3197B7B3137
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjI2LVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 07:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjI2LVi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 07:21:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E20CC9;
        Fri, 29 Sep 2023 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695986495; x=1727522495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h2w4jLDwnHjcUapV1jkntv5pgIa6zmfErB3TZ/IGgk8=;
  b=ETcwrfXg5Flq/37uv/6yJy9+liesMKOctTIKQt19CJsocEro6WYXAZ5F
   VdFGnRKrdlhSsh4oM/VzV6nn/7UmcSXVciPCTMfUoD78KLJ+0QyTQCdIG
   ugTLlHSk/+3UKbhpK7kefhCivWHbvF0oQX+yrTZTUSGBDqCcVgnacApRH
   XKZmxDGyZvlI0qQ186rcdgBpz+FIYaV69W8bajm5iLfNtA2f/h80gi4RK
   uWSch31dluaRIAG5uTxy8GBjg24l8UlSjH30h6h4c/Olkc4QYZLMAJ6+f
   Ks5zct/qAiGElo2boWVgWkUirDG8Ckz1ipWf6/NdkCW4rwQ+8Z5hWIv02
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361654988"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="361654988"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996901511"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="996901511"
Received: from valeks2x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.242])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:21:30 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 4/7] selftests/resctrl: Move _GNU_SOURCE define into Makefile
Date:   Fri, 29 Sep 2023 14:20:36 +0300
Message-Id: <20230929112039.7488-5-ilpo.jarvinen@linux.intel.com>
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

_GNU_SOURCE is defined in resctrl.h. Defining _GNU_SOURCE has a large
impact on what gets defined when including headers either before or
after it. This can result in compile failures if .c file decides to
include a standard header file before resctrl.h.

It is safer to define _GNU_SOURCE in Makefile so it is always defined
regardless of in which order includes are done.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc: <stable@vger.kernel.org>
---
 tools/testing/selftests/resctrl/Makefile  | 2 +-
 tools/testing/selftests/resctrl/resctrl.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 5073dbc96125..2deac2031de9 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index dd07463cdf48..d9b5df95849d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #ifndef RESCTRL_H
 #define RESCTRL_H
 #include <stdio.h>
-- 
2.30.2

