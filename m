Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB6774BE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 23:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjHHVAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjHHU7y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 16:59:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F54D504C2
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 09:54:32 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKjb836jfztS5w;
        Tue,  8 Aug 2023 14:15:00 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 14:18:27 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <kristina.martsenko@arm.com>, <shuah@kernel.org>,
        <catalin.marinas@arm.com>, <broonie@kernel.org>, <will@kernel.org>
CC:     <zengheng4@huawei.com>, <linux-kselftest@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/5] kselftest/arm64: add crc32 feature to hwcap test
Date:   Tue, 8 Aug 2023 14:13:52 +0800
Message-ID: <20230808061356.2215158-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808061356.2215158-1-zengheng4@huawei.com>
References: <20230808061356.2215158-1-zengheng4@huawei.com>
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

Add the CRC32 feature check in the set of hwcap tests.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index eaf9881c2e43..7ea526e7934e 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -33,6 +33,12 @@
  */
 typedef void (*sigill_fn)(void);
 
+static void crc32_sigill(void)
+{
+	/* CRC32W W0, W0, W1 */
+	asm volatile(".inst 0x1ac14800" : : : );
+}
+
 static void cssc_sigill(void)
 {
 	/* CNT x0, x0 */
@@ -234,6 +240,13 @@ static const struct hwcap_data {
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

