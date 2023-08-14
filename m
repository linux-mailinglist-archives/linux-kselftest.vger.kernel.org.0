Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD977AF7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 04:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjHNCVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 22:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjHNCVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 22:21:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C791CA8
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Aug 2023 19:21:03 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPJ4w0RxLzrS9h;
        Mon, 14 Aug 2023 10:19:44 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 10:21:01 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <shuah@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <zengheng4@huawei.com>
Subject: [PATCH -next 4/4] kselftest/arm64: add jscvt feature to hwcap test
Date:   Mon, 14 Aug 2023 10:17:47 +0800
Message-ID: <20230814021747.1784812-5-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814021747.1784812-1-zengheng4@huawei.com>
References: <20230814021747.1784812-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the jscvt feature check in the set of hwcap tests.

Due to the requirement of jscvt feature, a compiler configuration
of v8.3 or above is needed to support assembly. Therefore, hand
encode is used here instead.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index c8444f25e52d..44da28043579 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -68,6 +68,12 @@ static void ilrcpc_sigill(void)
 	asm volatile(".inst 0x994083e0" : : : );
 }
 
+static void jscvt_sigill(void)
+{
+	/* FJCVTZS W0, D0 */
+	asm volatile(".inst 0x1e7e0000" : : : );
+}
+
 static void lrcpc_sigill(void)
 {
 	/* LDAPR W0, [SP, #0] */
@@ -320,6 +326,13 @@ static const struct hwcap_data {
 		.cpuinfo = "fp",
 		.sigill_fn = fp_sigill,
 	},
+	{
+		.name = "JSCVT",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_JSCVT,
+		.cpuinfo = "jscvt",
+		.sigill_fn = jscvt_sigill,
+	},
 	{
 		.name = "LRCPC",
 		.at_hwcap = AT_HWCAP,
-- 
2.25.1

