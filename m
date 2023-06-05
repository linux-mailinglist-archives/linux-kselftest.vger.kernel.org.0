Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712FA722E23
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjFESCT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjFESCQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:02:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A73C7;
        Mon,  5 Jun 2023 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988135; x=1717524135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GfdCAOh9DszUxeIi/d59C0n2Wm3we7mqJ8T1ceHWh+Q=;
  b=NKNgKZYDW4EIiYKeWX3g0OplolZJOk05m/fRqX8phFFixYDt6Q6arWQU
   87E5Mvf9ZnZdOz/es4ZEqsRAd9lu22I0hHAx2sEPlwwGen6kSLn6zn+OA
   hNhPLWjINl5+fuaFmmB6VGu7ZwdCvMil3mE9QCFt9oJcVIr/OVWQNh6io
   WEGPkTRg3YyDO/hBAX668haTvK4iuixO+oy8+eyP3LkWQfoXTu1zNhN+w
   WhUu6FzdMrm7bmMTPwxFiYUWmzBtvFDoro/1eCSLJam2xjY8zH2C1sD8N
   zu1nTkV0Xp++xd3lzlgfcuDwBjnPinxBYOzM7TPqn7DEgSXnVvQpUGaNS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442814842"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442814842"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821273977"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821273977"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:01:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 01/19] selftests/resctrl: Add resctrl.h into build deps
Date:   Mon,  5 Jun 2023 21:01:27 +0300
Message-Id: <20230605180145.112924-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
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

