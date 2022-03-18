Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA184DD5C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 09:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiCRIBt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 04:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiCRIBs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 04:01:48 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Mar 2022 01:00:30 PDT
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834EE1ED048;
        Fri, 18 Mar 2022 01:00:30 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="54746912"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; 
   d="scan'208";a="54746912"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 18 Mar 2022 16:59:23 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C838CA243;
        Fri, 18 Mar 2022 16:59:22 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BCEA11075AD;
        Fri, 18 Mar 2022 16:59:21 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 6553C4006F185;
        Fri, 18 Mar 2022 16:59:21 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v6 2/6] selftests/resctrl: Change the default limited time to 120 seconds
Date:   Fri, 18 Mar 2022 16:58:03 +0900
Message-Id: <20220318075807.2921063-3-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
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

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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

