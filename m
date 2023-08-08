Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2E774425
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjHHSPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjHHSPK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 14:15:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829472AA
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 10:21:26 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKvSn2M5KzNn1q;
        Tue,  8 Aug 2023 21:40:09 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 21:43:36 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <kristina.martsenko@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <broonie@kernel.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <xiexiuqi@huawei.com>,
        <zengheng4@huawei.com>
Subject: [PATCH v2 2/5] kselftest/arm64: add crc32 feature to hwcap test
Date:   Tue, 8 Aug 2023 21:40:33 +0800
Message-ID: <20230808134036.668954-3-zengheng4@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the CRC32 feature check in the set of hwcap tests.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index ec247587f2bf..70850bdb0e35 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -33,6 +33,11 @@
  */
 typedef void (*sigill_fn)(void);

+static void crc32_sigill(void)
+{
+	asm volatile("crc32w w0, w0, w1");
+}
+
 static void cssc_sigill(void)
 {
 	/* CNT x0, x0 */
@@ -233,6 +238,13 @@ static const struct hwcap_data {
 	sigill_fn sigill_fn;
 	bool sigill_reliable;
 } hwcaps[] = {
+	{
+		.name = "CRC32",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_CRC32,
+		.cpuinfo = "crc32",
+		.sigill_fn = crc32_sigill,
+	},
 	{
 		.name = "CSSC",
 		.at_hwcap = AT_HWCAP2,
--
2.25.1

