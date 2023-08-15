Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1377C69C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 06:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjHOEGi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjHOEEV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 00:04:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19135B7
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 21:02:20 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RPyHJ2LVyz1GDZp;
        Tue, 15 Aug 2023 12:01:00 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 12:02:18 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>, <shuah@kernel.org>,
        <broonie@kernel.org>
CC:     <zengheng4@huawei.com>, <xiexiuqi@huawei.com>,
        <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next 2/4] kselftest/arm64: add AES feature check to hwcap test
Date:   Tue, 15 Aug 2023 11:58:48 +0800
Message-ID: <20230815035850.3947870-3-zengheng4@huawei.com>
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

