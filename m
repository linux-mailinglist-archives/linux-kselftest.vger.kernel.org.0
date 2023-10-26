Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25B47D82FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjJZMrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjJZMrE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D26A10E9;
        Thu, 26 Oct 2023 05:46:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633C8C433C8;
        Thu, 26 Oct 2023 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324418;
        bh=DS16tWYR3F7VpcQzgtoFB6E5W9YGpDiaNegIk+jm1dk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LFswMmZqU3SzIsT4cDG0KmUSUwDlbWwrxhX5PJgZ76t/gzl/H9OuDg+KCVRqbz8S8
         3dBxf3Sw8PH2n/lwpTtukIXGmtJ6Vq7SCY6qg0+90az5UpTO66C48FmMZ7VfgDOF9c
         Y/43EyWbAbTRctzt67JWPUOlwwG+fBb6rnkNIt2EhfiAqor4bXuEcddu7Zy3PSriXK
         HKAg4RLURZ34VaKoz2hcmB+yZrkbfbuUkv/CtxsxxCVD/UYNd5PSAVhAgA1kL4noB4
         DcUWivDZHqfeyHKMYAcRQowXt25Icjak+WE2pisnvfRqsga2lXWgpiZKulnMpv/10U
         0h04t+SWD1KrQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:22 +0100
Subject: [PATCH 08/21] arm64/sysreg: Add definition for FPMR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-8-8470dd989bb2@kernel.org>
References: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
In-Reply-To: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DS16tWYR3F7VpcQzgtoFB6E5W9YGpDiaNegIk+jm1dk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+aQjFzMSMDRU1ddpFtQzfW3+/loKKykxvkfyGR
 SfYVEO2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpfmgAKCRAk1otyXVSH0CL+B/
 9EHMME7iyfi+AdW55w4cbU/CSm5218COZm2ZFudBp8G1VQTEoMapJ4r2xkOgLU31sDfxfTf9zw5N3i
 bydjU5couA1UxqAF9L+JihcjIuIrqjVshBTVvz5vo+fe1ax8L0E8PasQ5RXcxlS8DUV3XcHf1mxJNq
 PbHDR4EZxkmkLQlgk2EntSgAPBnPSO6Aof9/VEDxU580hwGYrIFuIHcJDsIF96EUILFb85uyqZkwAb
 Egf87T3GGZ0LXpNyKGlufyVaL+nc6KP1ur80vptObIn3ctJh7bW6luxf6BPhhETNCCL/Egaur41yCg
 LRaPlzmBREdX+kwW/nUB6RrYvREUO/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DDI0601 2023-09 defines a new sysrem register FPMR (Floating Point Mode
Register) which configures the new FP8 features. Add a definition of this
register.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index e603a6153527..3e4cb8a141a3 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2132,6 +2132,29 @@ Field	1	ZA
 Field	0	SM
 EndSysreg
 
+Sysreg	FPMR	3	3	4	4	2
+Res0	63:38
+Field	37:32	LSCALE2
+Field	31:24	NSCALE
+Res0	23
+Field	22:16	LSCALE
+Field	15	OSC
+Field	14	OSM
+Res0	13:9
+UnsignedEnum	8:6	F8D
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+UnsignedEnum	5:3	F8S2
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+UnsignedEnum	2:0	F8S1
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+EndSysreg
+
 SysregFields	HFGxTR_EL2
 Field	63	nAMAIR2_EL1
 Field	62	nMAIR2_EL1

-- 
2.30.2

