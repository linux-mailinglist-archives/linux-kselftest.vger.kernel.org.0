Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA8A774424
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjHHSPf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 14:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbjHHSPG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 14:15:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD3D1775B0
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 10:21:16 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKvWT2hLmzrSG1;
        Tue,  8 Aug 2023 21:42:29 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 21:43:39 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <kristina.martsenko@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <broonie@kernel.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <xiexiuqi@huawei.com>,
        <zengheng4@huawei.com>
Subject: [PATCH v2 5/5] kselftest/arm64: add lse and lse2 features to hwcap test
Date:   Tue, 8 Aug 2023 21:40:36 +0800
Message-ID: <20230808134036.668954-6-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808134036.668954-1-zengheng4@huawei.com>
References: <20230808134036.668954-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the LSE and various features check in the set of hwcap tests.

As stated in the ARM manual, the LSE2 feature allows for atomic access
to unaligned memory. Therefore, for processors that only have the LSE
feature, we register .sigbus_fn to test their ability to perform
unaligned access.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 69234a8e8c59..112b6a219382 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -34,6 +34,12 @@
  */
 typedef void (*sig_fn)(void);

+static void atomics_sigill(void)
+{
+	/* STADD W0, [SP] */
+	asm volatile(".inst 0xb82003ff" : : : );
+}
+
 static void crc32_sigill(void)
 {
 	asm volatile("crc32w w0, w0, w1");
@@ -231,6 +237,14 @@ static void svebf16_sigill(void)
 	asm volatile(".inst 0x658aa000" : : : "z0");
 }

+static void uscat_sigbus(void)
+{
+	/* unaligned atomic access */
+	asm volatile("ADD x1, sp, #2" : : : );
+	/* STADD W0, [X1] */
+	asm volatile(".inst 0xb820003f" : : : );
+}
+
 static const struct hwcap_data {
 	const char *name;
 	unsigned long at_hwcap;
@@ -276,6 +290,22 @@ static const struct hwcap_data {
 		.cpuinfo = "ilrcpc",
 		.sigill_fn = ilrcpc_sigill,
 	},
+	{
+		.name = "LSE",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_ATOMICS,
+		.cpuinfo = "atomics",
+		.sigill_fn = atomics_sigill,
+	},
+	{
+		.name = "LSE2",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_USCAT,
+		.cpuinfo = "uscat",
+		.sigill_fn = atomics_sigill,
+		.sigbus_fn = uscat_sigbus,
+		.sigbus_reliable = true,
+	},
 	{
 		.name = "MOPS",
 		.at_hwcap = AT_HWCAP2,
--
2.25.1

