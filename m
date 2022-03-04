Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB44CD28F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 11:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiCDKku (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 05:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiCDKks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 05:40:48 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD14B1AA07F;
        Fri,  4 Mar 2022 02:39:54 -0800 (PST)
IronPort-SDR: lzNUqQbOPP96TaNDtt7S+53Gz/3z2ZwEP0EPe6A0oESEbJuL4nWKTtrx/owsCawcdwebyT3OKx
 VGb0WJaLvGVXyUZBxwdB0FZzXB7rCCnocP2efLX4ERogNQRsGjCz+jVaF5vKgNxocRmJIvx4Wm
 WiBqahtgEqD/gCy9+Kd6mfV3+5nExoD6kPKGizex1vz7OE4wGZWC1oiHVmkMCy5hcbJ1c8wEej
 RkDPJnF0KshxEonqb2k0KU2XRlybO/aUUXp7qfu77KCFCfHhgnBsmFZfpmLM+9IUq4hL7eUHA9
 pwpAwx79pTh35dlPMOhngllc
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="64700885"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; 
   d="scan'208";a="64700885"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2022 19:39:52 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 14206E0548;
        Fri,  4 Mar 2022 19:39:51 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4DAC3D9950;
        Fri,  4 Mar 2022 19:39:50 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 2931140451C78;
        Fri,  4 Mar 2022 19:39:50 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v4 6/6] selftests/resctrl: Add missing SPDX license to Makefile
Date:   Fri,  4 Mar 2022 19:38:34 +0900
Message-Id: <20220304103834.486892-7-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
References: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
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
index 30af27b07d21..71e80bb19dd6 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 TEST_GEN_PROGS := resctrl_tests
 
 include ../lib.mk
-- 
2.27.0

