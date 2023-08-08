Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274A177441E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjHHSPY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 14:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjHHSOz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 14:14:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B81E4C1
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 10:21:14 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKvWQ6l4Vz1L9Dx;
        Tue,  8 Aug 2023 21:42:26 +0800 (CST)
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
Subject: [PATCH v2 1/5] kselftest/arm64: add float-point feature to hwcap test
Date:   Tue, 8 Aug 2023 21:40:32 +0800
Message-ID: <20230808134036.668954-2-zengheng4@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the FP feature check in the set of hwcap tests.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 6a0adf916028..ec247587f2bf 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -39,6 +39,11 @@ static void cssc_sigill(void)
 	asm volatile(".inst 0xdac01c00" : : : "x0");
 }

+static void fp_sigill(void)
+{
+	asm volatile("fmov s0, #1");
+}
+
 static void ilrcpc_sigill(void)
 {
 	/* LDAPUR W0, [SP, #8] */
@@ -235,6 +240,13 @@ static const struct hwcap_data {
 		.cpuinfo = "cssc",
 		.sigill_fn = cssc_sigill,
 	},
+	{
+		.name = "FP",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_FP,
+		.cpuinfo = "fp",
+		.sigill_fn = fp_sigill,
+	},
 	{
 		.name = "LRCPC",
 		.at_hwcap = AT_HWCAP,
--
2.25.1

