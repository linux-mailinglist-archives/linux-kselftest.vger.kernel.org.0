Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B978D7858E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbjHWNSE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 09:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbjHWNR7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 09:17:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E200E70;
        Wed, 23 Aug 2023 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692796651; x=1724332651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aJatkA74p4ETjks991FVPs1infbN55y3Rel5pRq0AUw=;
  b=ln7heiACRHgFdYDFSZVSrX0f2LW3UfCPgLtt6A58MtUreULRyVth1v9C
   APktvOFRQEfMKqqvU+W2LkQ/35NIcXbt6EQ7yVt+98j1cF8SVsjXCDk//
   08DdPZHLsqapJiIbA8lO9McZDDyPTmjnF1eJgDmNp9SHBBs2S0AEhKZFl
   V+TsnkjvSC6VsPLmYW1z8QgLFKNvyaCwiaKLA54Iv4X49Sr8/Syz6MYRh
   2AB3js6QkoL/oYN2W7veUN4O3se0zbt/8NkJQwGflyjCptwJqIZAIlcSI
   eyl4yH0DucokIwpYdknM6CjYZ5O0meChoIcFpF95wd2EwsXLucvuJPh/Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373043988"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373043988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713572762"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713572762"
Received: from amangalo-mobl4.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.55.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:16:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/7] selftests/resctrl: Correct benchmark command help
Date:   Wed, 23 Aug 2023 16:15:51 +0300
Message-Id: <20230823131556.27617-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benchmark command must be the last argument because it consumes all the
remaining arguments but help misleadingly shows it as the first
argument. The benchmark command is also shown in quotes but it does not
match with the code.

Correct -b argument place in the help message and remove the quotes.
Tweak also how the options are presented by using ... notation.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 1e464ebeac47..de99923fa2e0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -52,8 +52,8 @@ int get_vendor(void)
 
 static void cmd_help(void)
 {
-	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
-	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
+	printf("usage: resctrl_tests [-h] [-t test list] [-n no_of_bits] [-b benchmark_cmd [option]...]\n");
+	printf("\t-b benchmark_cmd [option]...: run specified benchmark for MBM, MBA and CMT\n");
 	printf("\t   default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
 	printf("e.g. -t mbm,mba,cmt,cat\n");
-- 
2.30.2

