Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E294C4C83
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiBYRgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbiBYRgw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186D22D65A
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:36:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA47A61DC0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D39C340E7;
        Fri, 25 Feb 2022 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810577;
        bh=SiXh1GlTPzJ80ou8d0q75uEEfBAwCwDfZii7Ka/3bc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udpT4g9lCKkmUAphqul2boEFltV/bjRgD9/o1VV/ihjQHWjyaRbPX9LDTmJU/NPKz
         +Yk+QlG4X+tMdFnn5GjV49142nRO/JXD/zdjuy933aIzrMiEnQhvB7qFkXiby9/Zg4
         KZlgZVbBHhd94dTVDhiOKEtLN6VsONLISVbVzvAWcfbl2oewyqef3DVBWC3WK8bgsw
         u6jH4Z9kHiUwWTrl6m+zAvhgPRXF2tKse2jtZkxFBegp9x3TSOfdzXpRifb9bwhJMg
         /dDRIl+KxmxTp4KGTSGolHoZjoiuhsT0ZrnGsCnbpW0FtZhRZjd3MqIxFPVSX6dRxM
         63b/kOwCu35wA==
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
Subject: [PATCH v12 29/40] arm64/sme: Provide Kconfig for SME
Date:   Fri, 25 Feb 2022 16:59:12 +0000
Message-Id: <20220225165923.1474372-30-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; h=from:subject; bh=SiXh1GlTPzJ80ou8d0q75uEEfBAwCwDfZii7Ka/3bc4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrhwdYzL9L7Qrfdei4bFgf3dSM8vVVLSAm/CYiz vV7SIlmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkK4QAKCRAk1otyXVSH0DYeB/ 0T+wlUUZhxCKS58D35CrirM55QLjgJEaAbj3go2HNzocTreEjqgrzqdis4qGqEwm8F46vWM/+WvZ2u PQejUbA2DRKGJSo/tTHggJ0ZywRn7PnbSlV/S5mNE6g2oGW549oN3QFLFCBo1RoSOvv+PGOGXfdZR4 egAZvKuNhz0UBtb0bt9/Gyp6DflybEJc21Gc5+CObkj0743i2ipNxXKtaNSPU26KABLYdbtYUwYHDQ GvfqgZLDXt3HlZITSdIi478IDuNPi39EkalRJGoGfVxjIVFUfIu19zHgPRc39RJLS8TO/tvhD4tb68 wargCI+8LblSAux/RqDrnf5dWBMmnE
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

Now that basline support for the Scalable Matrix Extension (SME) is present
introduce the Kconfig option allowing it to be built. While the feature
registers don't impose a strong requirement for a system with SME to
support SVE at runtime the support for streaming mode SVE is mostly
shared with normal SVE so depend on SVE.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cbcd42decb2a..4fd7574866cc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1924,6 +1924,17 @@ config ARM64_SVE
 	  booting the kernel.  If unsure and you are not observing these
 	  symptoms, you should assume that it is safe to say Y.
 
+config ARM64_SME
+	bool "ARM Scalable Matrix Extension support"
+	default y
+	depends on ARM64_SVE
+	help
+	  The Scalable Matrix Extension (SME) is an extension to the AArch64
+	  execution state which utilises a substantial subset of the SVE
+	  instruction set, together with the addition of new architectural
+	  register state capable of holding two dimensional matrix tiles to
+	  enable various matrix operations.
+
 config ARM64_MODULE_PLTS
 	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	depends on MODULES
-- 
2.30.2

