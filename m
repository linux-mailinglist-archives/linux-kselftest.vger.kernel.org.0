Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B125547DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jun 2022 14:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355973AbiFVJBJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jun 2022 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355762AbiFVJA7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jun 2022 05:00:59 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 02:00:58 PDT
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6037A1A
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jun 2022 02:00:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,212,1650960000"; 
   d="scan'208";a="80324726"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 22 Jun 2022 00:59:55 -0800
IronPort-SDR: KySdSDKmI6Iy4pefWcvfNvXA8f8Q59zSJ3Pjs/PMmzjYdvUk2jMal7vAwkSJ37fGNElRIt417c
 h3Zyjwb6l+B8cWn4m2TLOtshqJgadkOBIPVVu1D5uhd4WZbHz/KvrpUHmjPCceexdJFxs3iDSp
 sDZec5/V+EuewjLNBk06BEAv9QAItxo1PhaPGRERcz2/t/TSVVmuJF5EjVY9aF4x5Zmb1CtfaZ
 GVtNfxw5Bvc1ULikQ7Q+Calv9Wn3/CTfx7mXass6I4bdjp+LzdhPrTZ2dPY752jLGTksigS17p
 fFE=
From:   Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <atrajeev@linux.vnet.ibm.com>,
        Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [PATCH] kselftest: mqueue: increase timeout
Date:   Wed, 22 Jun 2022 14:29:11 +0530
Message-ID: <20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-12.mgc.mentorg.com (147.34.90.212)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default kselftest timeout is 45 seconds per test after which
run_kselftest marks the test case as failure.

Some mqueue perf tests take more than 100s to complete; especially in qemu
environment. Increase the timeout to 180 seconds for mqueue.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 tools/testing/selftests/mqueue/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mqueue/settings

diff --git a/tools/testing/selftests/mqueue/settings b/tools/testing/selftests/mqueue/settings
new file mode 100644
index 000000000000..a953c96aa16e
--- /dev/null
+++ b/tools/testing/selftests/mqueue/settings
@@ -0,0 +1 @@
+timeout=180
-- 
2.25.1

