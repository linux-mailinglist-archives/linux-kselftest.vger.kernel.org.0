Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE66752359
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjGMNUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjGMNUa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:20:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4012D70;
        Thu, 13 Jul 2023 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254421; x=1720790421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GfdCAOh9DszUxeIi/d59C0n2Wm3we7mqJ8T1ceHWh+Q=;
  b=TbtAK4TxV9qHMcoCwzSS2oV1dnmrcCurIImIW15awdx+n2jGmnxo0ca7
   Owvce1Mhrpl4lvYpUGv0DTBkVYi9ZntyaLUfYYkle1WgOs4lovGuGf3cz
   iAFnA2XXVcNqGY9E0LmgAcowlikgGs5Z98LyBuqma1wmcrv/5OlUlRExH
   HQ01bITXXteiy1/U8H9N/reX2rgZIfUPiNXjxS5JwNIUnkhBVyMX/4YPr
   O1CG2GrnZsWNgJKrMyI/PHLep9jADKhrEDqo9NnEDI8tzUUwS39fg0yzL
   5KAuXRv4EzcVd3pJogaF02TXZnme6xz9Ya0xeKtKkuRKaYor588OL0rNq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496521"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496521"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615686"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615686"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 01/19] selftests/resctrl: Add resctrl.h into build deps
Date:   Thu, 13 Jul 2023 16:19:14 +0300
Message-Id: <20230713131932.133258-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Makefile only lists *.c as build dependencies for the resctrl_tests
executable which excludes resctrl.h.

Add *.h to wildcard() to include resctrl.h.

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 73d53257df42..5073dbc96125 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -7,4 +7,4 @@ TEST_GEN_PROGS := resctrl_tests
 
 include ../lib.mk
 
-$(OUTPUT)/resctrl_tests: $(wildcard *.c)
+$(OUTPUT)/resctrl_tests: $(wildcard *.[ch])
-- 
2.30.2

