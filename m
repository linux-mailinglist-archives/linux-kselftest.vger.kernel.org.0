Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02F76E0D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjHCHG2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjHCHF4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:05:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318C3A87
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 00:05:21 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGfsX1RcZzNmQq;
        Thu,  3 Aug 2023 15:01:52 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 15:05:17 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <will@kernel.org>, <broonie@kernel.org>, <shuah@kernel.org>,
        <catalin.marinas@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>, <xiexiuqi@huawei.com>
Subject: [PATCH] kselftest/arm64: add RCpc load-acquire to the tested hwcaps
Date:   Thu, 3 Aug 2023 15:02:31 +0800
Message-ID: <20230803070231.3962475-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add RCpc load-acquire and various features check in the set of hwcaps.

Test log as shown below:
~~~
  # RCpc load-acquire present
  ok 47 cpuinfo_match_RCpc load-acquire
  ok 48 sigill_RCpc load-acquire
  # RCpc load-acquire2 present
  ok 49 cpuinfo_match_RCpc load-acquire2
  ok 50 sigill_RCpc load-acquire2
~~~

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 93333a90bf3a..ccb3f6adb68f 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -194,6 +194,18 @@ static void svebf16_sigill(void)
 	asm volatile(".inst 0x658aa000" : : : "z0");
 }
 
+static void lrcpc_sigill(void)
+{
+	/* LDAPR W0, [SP, #0] */
+	asm volatile(".inst 0xb8bfc3e0" : : : );
+}
+
+static void ilrcpc_sigill(void)
+{
+	/* LDAPUR W0, [SP, #8] */
+	asm volatile(".inst 0x994083e0" : : : );
+}
+
 static const struct hwcap_data {
 	const char *name;
 	unsigned long at_hwcap;
@@ -364,6 +376,20 @@ static const struct hwcap_data {
 		.hwcap_bit = HWCAP2_SVE_EBF16,
 		.cpuinfo = "sveebf16",
 	},
+	{
+		.name = "RCpc load-acquire",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_LRCPC,
+		.cpuinfo = "lrcpc",
+		.sigill_fn = lrcpc_sigill,
+	},
+	{
+		.name = "RCpc load-acquire2",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_ILRCPC,
+		.cpuinfo = "ilrcpc",
+		.sigill_fn = ilrcpc_sigill,
+	},
 };
 
 static bool seen_sigill;
-- 
2.25.1

