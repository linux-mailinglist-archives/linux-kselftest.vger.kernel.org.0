Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D706D5B6FCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiIMOR7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiIMORW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 10:17:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB5120F43
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 07:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEB95B80F2B
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 14:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F72C433D6;
        Tue, 13 Sep 2022 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663078313;
        bh=7g35m2Y1NFhV51gn2Q8xiBWqGn+MvC9Px03amMMepCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XaZMUHoWc5RqVIXhx6f/Tq968UWMUQkwwLwskQESTT2O1TvKMz9ldfFFbSxgRQMh3
         KLKXYJs0hLWITdzAXjP9Bien4jQVyt4P0FpnBIdSA3yD0jKXt1Jqpz9xlc6FJbSYU1
         wUIjWudOst/OW/ldUHPeC50gjVuNdGvvDcNb/KcuccASnkjHOkgu89zTgxp5qZP5ZS
         iPvXdjIB5HAkShE7GJkfWjaIfUMj08nkLFjQJ+Hb0LAHgSFY1azHBSW8ifar5HdHVs
         GQRqU/kPejXBkg+1wjPQJ4I70mzlYZU/ASWnz6UVd1VZQ98x9GSkGmzP0L2Qt1zhL+
         6PqBwBbnuov3g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] kselftest/arm64: Add SVE 2 to the tested hwcaps
Date:   Tue, 13 Sep 2022 15:11:00 +0100
Message-Id: <20220913141101.151400-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220913141101.151400-1-broonie@kernel.org>
References: <20220913141101.151400-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3789; i=broonie@kernel.org; h=from:subject; bh=7g35m2Y1NFhV51gn2Q8xiBWqGn+MvC9Px03amMMepCw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjII90cyuFhWS0iXI7AYg7Aw7BQ2RLjo6ZoU+t4App 14bNJDmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYyCPdAAKCRAk1otyXVSH0MHJB/ 96L1uZi+Doy7dfximEYA9qH/BWBkihGrIrUM8lMfn6NDe+x/5QnODZtOtOtiRjTS5AfgJ7SKPFZVsP SOSoX3kdRmDhPuueaFHR0L/Ea19k1DY5500klvPsDDv/A4hhwonepX6Na5sx6pKvBR50p5EBBq55bm 8dtjvvlragEv6OXLuE8fHmr6ra55u3Nz/rZ3gKQDM++K4dyn5rZjZsYztfk5QslQhqRvSIsRIYjyQy 8afhHAWwmieZ0GZTYLNiO6wrMWBK685eTyoQTTOBn1cVLoT1eAq6dF8u8FBBtDS0YYASJ9e7l276EM XmfZA8HaKHB1uWJu1V9xypqitUWhwI
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

Include SVE 2 and the various subfeatures it adds in the set of
hwcaps we check for.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 136 ++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 04e4a81dd159..6c91b4a0987e 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -45,6 +45,66 @@ static void sve_sigill(void)
 	asm volatile(".inst 0x04bf5000" : : : "x0");
 }
 
+static void sve2_sigill(void)
+{
+	/* SQABS Z0.b, P0/M, Z0.B */
+	asm volatile(".inst 0x4408A000" : : : "z0");
+}
+
+static void sveaes_sigill(void)
+{
+	/* AESD z0.b, z0.b, z0.b */
+	asm volatile(".inst 0x4522e400" : : : "z0");
+}
+
+static void svepmull_sigill(void)
+{
+	/* PMULLB Z0.Q, Z0.D, Z0.D */
+	asm volatile(".inst 0x45006800" : : : "z0");
+}
+
+static void svebitperm_sigill(void)
+{
+	/* BDEP Z0.B, Z0.B, Z0.B */
+	asm volatile(".inst 0x4500b400" : : : "z0");
+}
+
+static void svesha3_sigill(void)
+{
+	/* EOR3 Z0.D, Z0.D, Z0.D, Z0.D */
+	asm volatile(".inst 0x4203800" : : : "z0");
+}
+
+static void svesm4_sigill(void)
+{
+	/* SM4E Z0.S, Z0.S, Z0.S */
+	asm volatile(".inst 0x4523e000" : : : "z0");
+}
+
+static void svei8mm_sigill(void)
+{
+	/* USDOT Z0.S, Z0.B, Z0.B[0] */
+	asm volatile(".inst 0x44a01800" : : : "z0");
+}
+
+static void svef32mm_sigill(void)
+{
+	/* FMMLA Z0.S, Z0.S, Z0.S */
+	asm volatile(".inst 0x64a0e400" : : : "z0");
+}
+
+static void svef64mm_sigill(void)
+{
+	/* FMMLA Z0.D, Z0.D, Z0.D */
+	asm volatile(".inst 0x64e0e400" : : : "z0");
+}
+
+static void svebf16_sigill(void)
+{
+	/* BFCVT Z0.H, P0/M, Z0.S */
+	asm volatile(".inst 0x658aa000" : : : "z0");
+}
+
 static const struct hwcap_data {
 	const char *name;
 	unsigned long at_hwcap;
@@ -69,6 +129,82 @@ static const struct hwcap_data {
 		.sigill_fn = sve_sigill,
 		.sigill_reliable = true,
 	},
+	{
+		.name = "SVE 2",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVE2,
+		.cpuinfo = "sve2",
+		.sigill_fn = sve2_sigill,
+	},
+	{
+		.name = "SVE AES",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVEAES,
+		.cpuinfo = "sveaes",
+		.sigill_fn = sveaes_sigill,
+	},
+	{
+		.name = "SVE2 PMULL",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVEPMULL,
+		.cpuinfo = "svepmull",
+		.sigill_fn = svepmull_sigill,
+	},
+	{
+		.name = "SVE2 BITPERM",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVEBITPERM,
+		.cpuinfo = "svebitperm",
+		.sigill_fn = svebitperm_sigill,
+	},
+	{
+		.name = "SVE2 SHA3",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVESHA3,
+		.cpuinfo = "svesha3",
+		.sigill_fn = svesha3_sigill,
+	},
+	{
+		.name = "SVE2 SM4",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVESM4,
+		.cpuinfo = "svesm4",
+		.sigill_fn = svesm4_sigill,
+	},
+	{
+		.name = "SVE2 I8MM",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVEI8MM,
+		.cpuinfo = "svei8mm",
+		.sigill_fn = svei8mm_sigill,
+	},
+	{
+		.name = "SVE2 F32MM",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVEF32MM,
+		.cpuinfo = "svef32mm",
+		.sigill_fn = svef32mm_sigill,
+	},
+	{
+		.name = "SVE2 F64MM",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVEF64MM,
+		.cpuinfo = "svef64mm",
+		.sigill_fn = svef64mm_sigill,
+	},
+	{
+		.name = "SVE2 BF16",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVEBF16,
+		.cpuinfo = "svebf16",
+		.sigill_fn = svebf16_sigill,
+	},
+	{
+		.name = "SVE2 EBF16",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVE_EBF16,
+		.cpuinfo = "sveebf16",
+	},
 };
 
 static bool seen_sigill;
-- 
2.30.2

