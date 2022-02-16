Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896564B7DAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 03:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiBPCaK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 21:30:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241563AbiBPCaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 21:30:10 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A9EF5426;
        Tue, 15 Feb 2022 18:29:58 -0800 (PST)
IronPort-SDR: 6gBjHwVCpkApe48hHj/iFMfucg9Pth6iyV9NCeLdL0MdgnuZbmfm9jgXS2ds+V6YZCbaZ4N8mu
 SlljFNCModLk/J2smHjqWmIlgIJSpDnPNBWg2wOKhS/LgsZH7YHKbplFg/XX1cotLXCNOqiLxJ
 52KpWTzMh7bIB9fgNak+IeutUj06ofoamdxdLAQyql2T3fgld5aJOAnFoDwavSxqB2Ot5LMbeB
 wqcgY+lC37fDP+xFoA5fBDjeapRNw45M8BbXp6fR7zFrJm6kglKm+o1xSc7NXxRDVtScqEqyCW
 8UuNmQRwN80u4/NmVjEgNfjG
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="62933532"
X-IronPort-AV: E=Sophos;i="5.88,371,1635174000"; 
   d="scan'208";a="62933532"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Feb 2022 11:28:53 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EEADF030C;
        Wed, 16 Feb 2022 11:28:51 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C03FCBDB33;
        Wed, 16 Feb 2022 11:28:50 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 82B0A4007E8D1;
        Wed, 16 Feb 2022 11:28:50 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 4/5] selftests/resctrl: Change the default limited time to 120 seconds
Date:   Wed, 16 Feb 2022 11:26:40 +0900
Message-Id: <20220216022641.2998318-5-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
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

When testing on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz the resctrl
selftests fail due to timeout after exceeding the default time limit of
45 seconds. On this system the test takes about 68 seconds. 
Since the failing test by default accesses a fixed size of memory, the
execution time should not vary significantly between different environment.
A new default of 120 seconds should be sufficient yet easy to customize
with the introduction of the "settings" file for reference.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
From the perspective of the kselftest framework,
a rule of "Don't take too long" is a concern.
To get some better informed opinions from kselftest audience,
I highlighted this change in the cover letter.

I adopted most of Reinette's phrase from the discussion in patch v2
to explain why 120s is appropriate for this test.

 tools/testing/selftests/resctrl/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/resctrl/settings

diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
new file mode 100644
index 000000000000..6091b45d226b
--- /dev/null
+++ b/tools/testing/selftests/resctrl/settings
@@ -0,0 +1 @@
+timeout=120
-- 
2.27.0

