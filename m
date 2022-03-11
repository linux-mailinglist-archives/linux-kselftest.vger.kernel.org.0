Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABE34D5C3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 08:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347091AbiCKHZw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 02:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiCKHZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 02:25:50 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 23:24:47 PST
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181531B65ED;
        Thu, 10 Mar 2022 23:24:46 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="45601605"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="45601605"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 16:23:40 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 60DB1C68A5;
        Fri, 11 Mar 2022 16:23:39 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id ACFFD14254;
        Fri, 11 Mar 2022 16:23:38 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 7D1E4401110B2;
        Fri, 11 Mar 2022 16:23:38 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v5 2/6] selftests/resctrl: Change the default limited time to 120 seconds
Date:   Fri, 11 Mar 2022 16:21:43 +0900
Message-Id: <20220311072147.3301525-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
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
 tools/testing/selftests/resctrl/settings | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/settings

diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
new file mode 100644
index 000000000000..a383f3d4565b
--- /dev/null
+++ b/tools/testing/selftests/resctrl/settings
@@ -0,0 +1,3 @@
+# If running time is longer than 120 seconds when new tests are added in
+# the future, increase timeout here.
+timeout=120
-- 
2.27.0

