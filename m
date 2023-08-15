Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3177C69D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 06:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjHOEGp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 00:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjHOEEV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 00:04:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317CE35B6
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 21:02:19 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RPyHH4BjSz1GDYk;
        Tue, 15 Aug 2023 12:00:59 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 12:02:17 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>, <shuah@kernel.org>,
        <broonie@kernel.org>
CC:     <zengheng4@huawei.com>, <xiexiuqi@huawei.com>,
        <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next 1/4] kselftest/arm64: add SHA1 and related features to hwcap test
Date:   Tue, 15 Aug 2023 11:58:47 +0800
Message-ID: <20230815035850.3947870-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815035850.3947870-1-zengheng4@huawei.com>
References: <20230815035850.3947870-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the SHA1 and related features check in the set of hwcap tests.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index af5490cae09b..c87a2e167ee8 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -87,6 +87,24 @@ static void rng_sigill(void)
 	asm volatile("mrs x0, S3_3_C2_C4_0" : : : "x0");
 }
 
+static void sha1_sigill(void)
+{
+	/* SHA1H S0, S0 */
+	asm volatile(".inst 0x5e280800" : : : );
+}
+
+static void sha2_sigill(void)
+{
+	/* SHA256H Q0, Q0, V0.4S */
+	asm volatile(".inst 0x5e004000" : : : );
+}
+
+static void sha512_sigill(void)
+{
+	/* SHA512H Q0, Q0, V0.2D */
+	asm volatile(".inst 0xce608000" : : : );
+}
+
 static void sme_sigill(void)
 {
 	/* RDSVL x0, #0 */
@@ -334,6 +352,27 @@ static const struct hwcap_data {
 		.hwcap_bit = HWCAP2_RPRFM,
 		.cpuinfo = "rprfm",
 	},
+	{
+		.name = "SHA1",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SHA1,
+		.cpuinfo = "sha1",
+		.sigill_fn = sha1_sigill,
+	},
+	{
+		.name = "SHA2",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SHA2,
+		.cpuinfo = "sha2",
+		.sigill_fn = sha2_sigill,
+	},
+	{
+		.name = "SHA512",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SHA512,
+		.cpuinfo = "sha512",
+		.sigill_fn = sha512_sigill,
+	},
 	{
 		.name = "SME",
 		.at_hwcap = AT_HWCAP2,
-- 
2.25.1

