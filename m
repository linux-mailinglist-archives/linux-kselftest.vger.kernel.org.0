Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755C4C4C8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbiBYRhE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243904AbiBYRhA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:37:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1650B22D67A
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:36:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 486F6B832D1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2ADC340F3;
        Fri, 25 Feb 2022 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810581;
        bh=gpXYwwHjBWECYd9glOg05wFHftQryu8V/UpzngQGl4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ob/B9ioVWNOSh9KGM9m5Fa/OO6yvFc2wKPwdnODaWYpeLCd4ujNEdZ66RgXY1cN2c
         nAlCymqnwnY/b35/6s3GqdVo+k5NaO6auQh+JGZB9GVYCS4de2nqe1b5vmUmCnNRLW
         CJQEpUpHGmd8PYpM9hqKK/Kpyil3EJcBzpAkLwgRK7ctao+Nmg0kMFYBsfnLdWGiKw
         nKgXwZKVKrgaSGMmKLBLH5yozk/jMLIrCH4e7ZYVMFhIw/sZrM2dySb78rym0/wHdT
         dDls5UHUvbiXJ1dxH8B527n9vZk3exbQi1oWVFp2dKH4s9OtuyMYuRWrE156LsFise
         zQAuiMLdtzrxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v12 30/40] kselftest/arm64: Add manual encodings for SME instructions
Date:   Fri, 25 Feb 2022 16:59:13 +0000
Message-Id: <20220225165923.1474372-31-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; h=from:subject; bh=gpXYwwHjBWECYd9glOg05wFHftQryu8V/UpzngQGl4Q=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrhghFiAICiyGmVpz7+92Crrpgc79fXtr+9TOpN 2gK/qxKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkK4QAKCRAk1otyXVSH0EBiB/ 9lLesupdOB5DmjXDBiQNbNJp70StDxwWDA+PXXCfR7L1CXQJ58NcdVBKOJDorydwp6Dmry1v8pgGDo jefIQQSyT6UL1IvjgNOpeiOr87cH4yrIgGEy4eslL8Uu1AbGMLc45YksFG2BV2lC7W3ikMFlNIXHro g2QpTnZvB3moqAMr6GRsDJmQvy8mA1WoZsAdBkhZZRtN+20jcD+I+REsS9JRaizUeLKavmjhVKHnPK nvNZverrQkM961xQ+t/cxxlAKA/6jlpeXsPXxHQD1AiX3qU6XX8oLcdBK/vmQuIHGwyZMdtYh3g5s7 2Lae9B7An2OsU04TtUfWwLpuvRDoQ7
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As for the kernel so that we don't have ambitious toolchain requirements
to build the tests manually encode some of the SVE instructions.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/fp/sme-inst.h | 51 +++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/sme-inst.h

diff --git a/tools/testing/selftests/arm64/fp/sme-inst.h b/tools/testing/selftests/arm64/fp/sme-inst.h
new file mode 100644
index 000000000000..7191e53ca1c0
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/sme-inst.h
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021-2 ARM Limited.
+// Original author: Mark Brown <broonie@kernel.org>
+
+#ifndef SME_INST_H
+#define SME_INST_H
+
+/*
+ * RDSVL X\nx, #\imm
+ */
+.macro rdsvl nx, imm
+	.inst	0x4bf5800			\
+		| (\imm << 5)			\
+		| (\nx)
+.endm
+
+.macro smstop
+	msr	S0_3_C4_C6_3, xzr
+.endm
+
+.macro smstart_za
+	msr	S0_3_C4_C5_3, xzr
+.endm
+
+.macro smstart_sm
+	msr	S0_3_C4_C3_3, xzr
+.endm
+
+/*
+ * LDR (vector to ZA array):
+ *	LDR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ */
+.macro _ldr_za nw, nxbase, offset=0
+	.inst	0xe1000000			\
+		| (((\nw) & 3) << 13)		\
+		| ((\nxbase) << 5)		\
+		| ((\offset) & 7)
+.endm
+
+/*
+ * STR (vector from ZA array):
+ *	STR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ */
+.macro _str_za nw, nxbase, offset=0
+	.inst	0xe1200000			\
+		| (((\nw) & 3) << 13)		\
+		| ((\nxbase) << 5)		\
+		| ((\offset) & 7)
+.endm
+
+#endif
-- 
2.30.2

