Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639777C6B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 06:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjHOEQL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 00:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjHOENH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 00:13:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9919B4
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 21:12:28 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RPyW01zBDz1GDYy;
        Tue, 15 Aug 2023 12:11:08 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 12:12:26 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>, <shuah@kernel.org>,
        <broonie@kernel.org>
CC:     <zengheng4@huawei.com>, <xiexiuqi@huawei.com>,
        <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next v2 4/4] kselftest/arm64: add jscvt feature to hwcap test
Date:   Tue, 15 Aug 2023 12:09:15 +0800
Message-ID: <20230815040915.3966955-5-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815040915.3966955-1-zengheng4@huawei.com>
References: <20230815040915.3966955-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index df7a62659aa2..2683d0deb4c3 100644
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

