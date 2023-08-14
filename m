Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B515D77AF7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 04:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjHNCVg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 22:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjHNCVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 22:21:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB7C11D
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Aug 2023 19:21:02 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPJ314PPWz2Bd2d;
        Mon, 14 Aug 2023 10:18:05 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 10:20:59 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <shuah@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <zengheng4@huawei.com>
Subject: [PATCH -next 2/4] kselftest/arm64: add AES feature check to hwcap test
Date:   Mon, 14 Aug 2023 10:17:45 +0800
Message-ID: <20230814021747.1784812-3-zengheng4@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the AES feature check in the set of hwcap tests.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index c87a2e167ee8..d9a49b1467ac 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -34,6 +34,12 @@
  */
 typedef void (*sig_fn)(void);
 
+static void aes_sigill(void)
+{
+	/* AESE V0.16B, V0.16B */
+	asm volatile(".inst 0x4e284800" : : : );
+}
+
 static void atomics_sigill(void)
 {
 	/* STADD W0, [SP] */
@@ -280,6 +286,13 @@ static const struct hwcap_data {
 	sig_fn sigbus_fn;
 	bool sigbus_reliable;
 } hwcaps[] = {
+	{
+		.name = "AES",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_AES,
+		.cpuinfo = "aes",
+		.sigill_fn = aes_sigill,
+	},
 	{
 		.name = "CRC32",
 		.at_hwcap = AT_HWCAP,
-- 
2.25.1

