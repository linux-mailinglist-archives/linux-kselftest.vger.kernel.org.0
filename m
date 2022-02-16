Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDF4B7DDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 03:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245681AbiBPCa7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 21:30:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbiBPCar (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 21:30:47 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DCDF5426;
        Tue, 15 Feb 2022 18:30:36 -0800 (PST)
IronPort-SDR: 2sV41LWKzVrxPncdcDcC5bJgwVgyV2zX7L5aFld3A1yHFZtZ0xuJ7SzcUSJvc1L7GlvjMnlYVX
 Va4gu4sB1kMW8FjQkfnLDKbCjC9AI50ygcW+rJgembAfVzNTDJnp03ofEMzCZ9DVNuHK4KowPh
 AvAJAlmJgZbReXt/WbRF1iS5rOoJhNHeMiF13AZ7ovtj0jEE8SlYfa78X0jJMbb1BlddaqM3np
 iPavmq672jv+aTF4E1BXmF96bpOLadYQYUV4f0w7La/HoegNfD3SJcUA///rRiKpYWrV0VaWrl
 ZnrJ8yc7wO9CQSsSqwN3k9Y1
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="62964889"
X-IronPort-AV: E=Sophos;i="5.88,371,1635174000"; 
   d="scan'208";a="62964889"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Feb 2022 11:29:30 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 228D56452F;
        Wed, 16 Feb 2022 11:29:29 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D3BAD35AC;
        Wed, 16 Feb 2022 11:29:28 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id D693A4008A7D5;
        Wed, 16 Feb 2022 11:29:27 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH] selftests/resctrl: Add missing SPDX license to Makefile
Date:   Wed, 16 Feb 2022 11:28:26 +0900
Message-Id: <20220216022826.2999382-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the missing SPDX(SPDX-License-Identifier) license header to
tools/testing/selftests/resctrl/Makefile.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index de26638540ba..d661eb2df19b 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.27.0

