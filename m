Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8890E6DF6E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDLNWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjDLNWL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79579900B;
        Wed, 12 Apr 2023 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305715; x=1712841715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKz1qH2cDM86ZzghpGTcpGq4JirHuIesPeKIy9RAyIA=;
  b=czIycqWODWU9YKUJuZIJBa4iHYeI2eX+sVZtfBcY9gzt5FTJACqbFGg4
   pJjE2mbjJrGT0f9O5PXHIBmUAeUYf9EBo9ou9GytmV6d8g7fcfA2NlCkD
   VhPKMYygThvH/5rSanjITAyBATofX0avg6E/HK4xVqqSIKUyu7J62zVhZ
   0EkH5jb2tNLJQKpU8XeUNgT4TXOwbFoCZDC20KjQMhqodpIRe5www3Biv
   4EQRxKI7bfc8OWqlcqYC8p7FAfYXADwpwnpDz1zBmWUcplX2dPgeamaTN
   IS0BeptyYxmZi2xC2bw/n5TFIykOu0ZTa5MMwZgTHrmfEGPbl47/A6L+C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590018"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590018"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230013"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230013"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:37 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/22] selftests/resctrl: Add resctrl.h into build deps
Date:   Wed, 12 Apr 2023 16:21:01 +0300
Message-Id: <20230412132122.29452-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Makefile only lists *.c as build dependecies for the restctrl_tests
executable which excludes resctrl.h.

Add *.h to wildcard() cover also resctrl.h.

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 73d53257df42..2dc7da221795 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -7,4 +7,4 @@ TEST_GEN_PROGS := resctrl_tests
 
 include ../lib.mk
 
-$(OUTPUT)/resctrl_tests: $(wildcard *.c)
+$(OUTPUT)/resctrl_tests: $(wildcard *.c *.h)
-- 
2.30.2

