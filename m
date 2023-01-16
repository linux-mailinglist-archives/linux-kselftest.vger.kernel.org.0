Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6F66C609
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjAPQOH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjAPQNR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:13:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD12B61A;
        Mon, 16 Jan 2023 08:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A34F61047;
        Mon, 16 Jan 2023 16:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170E7C43396;
        Mon, 16 Jan 2023 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885277;
        bh=TaXKfe7r42NnJSzTx0Oj6fkdFodcwZfrTJqWBd69eSg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DR6pijpAwjwluzusTWHAX6e4Q2tir2DM22nScNmot9S7LaQvQJj/m6niUVnaSpcyf
         wy4yr7vA8OQEm3Vfgzw2x9xHyZs0H10vD0ewIOfu+TbZ4fcfVa3NMYDh6qGnONb0xC
         F1xlgexSw9g2ihfhgVZ35Q5Iqouw904UadDyLdxMJue1DBjK88joabySX0s46cpUNQ
         buK5+Yg12vF8vnRKmoQv8E04Veuyv7Hyl27vGeqtvbX4M0hwaXM3Lb4sL4fQtib61D
         KN5Bszql2LXSyz3IdYJ7VfGDULOpBNl+Oidg+kJbo330iuqFeVfaHlSUwGgBUOtGec
         ioWhaXvpo2dHw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:56 +0000
Subject: [PATCH v4 21/21] kselftest/arm64: Add coverage of SME 2 and 2.1
 hwcaps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-21-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=3401; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TaXKfe7r42NnJSzTx0Oj6fkdFodcwZfrTJqWBd69eSg=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhuSjpZsmtQpa808uKEqQ4wp5YBv383vgx53sp2ZnZIk+2jgj
 Y3ZWJ6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwEfup7P9LLHs4lqXpaU+YO2nVbn
 kx48rgrVkVnbs+3RGYm5HfJFfG9vX/gR8X9O4WbhLI1Kyc87px6TwR3fWR8gzVUavS/oRsc8upS/7O
 edFmV8gEFt1J3AqLOcPPfhbpCtH47SOd/m3l14aflTzMru+uOMzlnWoS9+xu+vIoa05O/nq7dXs79E
 Jdq47Frs3cuD5cWdXlP9duoUmiMhxxGjPr/fU1Ze6Kzy2pOFz+cuWn1UfPaRU9E5tmaykrdEnh5pZc
 4227theYdVhPZ5GTvPnJulij2/pBl0x/RkjgZK9vnuEWQQwrKkMTP3MvDJ9wyidVUnwqc3hGrvKFQq
 fIYnnGNcsbCw9u8X5+6dKEis/6AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the hwcaps defined by SME 2 and 2.1 to the hwcaps test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 115 ++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 9f255bc5f31c..93333a90bf3a 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -50,6 +50,78 @@ static void sme_sigill(void)
 	asm volatile(".inst 0x04bf5800" : : : "x0");
 }
 
+static void sme2_sigill(void)
+{
+	/* SMSTART ZA */
+	asm volatile("msr S0_3_C4_C5_3, xzr" : : : );
+
+	/* ZERO ZT0 */
+	asm volatile(".inst 0xc0480001" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void sme2p1_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* BFCLAMP { Z0.H - Z1.H }, Z0.H, Z0.H */
+	asm volatile(".inst 0xc120C000" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smei16i32_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* SMOPA ZA0.S, P0/M, P0/M, Z0.B, Z0.B */
+	asm volatile(".inst 0xa0800000" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smebi32i32_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* BMOPA ZA0.S, P0/M, P0/M, Z0.B, Z0.B */
+	asm volatile(".inst 0x80800008" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smeb16b16_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* BFADD ZA.H[W0, 0], {Z0.H-Z1.H} */
+	asm volatile(".inst 0xC1E41C00" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smef16f16_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FADD ZA.H[W0, 0], { Z0.H-Z1.H } */
+	asm volatile(".inst 0xc1a41C00" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
 static void sve_sigill(void)
 {
 	/* RDVL x0, #0 */
@@ -158,6 +230,49 @@ static const struct hwcap_data {
 		.sigill_fn = sme_sigill,
 		.sigill_reliable = true,
 	},
+	{
+		.name = "SME2",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME2,
+		.cpuinfo = "sme2",
+		.sigill_fn = sme2_sigill,
+		.sigill_reliable = true,
+	},
+	{
+		.name = "SME 2.1",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME2P1,
+		.cpuinfo = "sme2p1",
+		.sigill_fn = sme2p1_sigill,
+	},
+	{
+		.name = "SME I16I32",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_I16I32,
+		.cpuinfo = "smei16i32",
+		.sigill_fn = smei16i32_sigill,
+	},
+	{
+		.name = "SME BI32I32",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_BI32I32,
+		.cpuinfo = "smebi32i32",
+		.sigill_fn = smebi32i32_sigill,
+	},
+	{
+		.name = "SME B16B16",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_B16B16,
+		.cpuinfo = "smeb16b16",
+		.sigill_fn = smeb16b16_sigill,
+	},
+	{
+		.name = "SME F16F16",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_F16F16,
+		.cpuinfo = "smef16f16",
+		.sigill_fn = smef16f16_sigill,
+	},
 	{
 		.name = "SVE",
 		.at_hwcap = AT_HWCAP,

-- 
2.34.1

