Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB424F94DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiDHL7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiDHL7L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:59:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656A48BF3C
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00CE761FDF
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0364C385AC;
        Fri,  8 Apr 2022 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419023;
        bh=bmQq9+Hs9ppK5+d67ccvsBsIxc0wnK8U9AX00pV28UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdT7VrKgERpz6H4g0Eu0VPv3wDk4LaznrjXEOOcUAwPK2+RPH9B9JZjKqYi1Gaq1I
         /jHUkjwP/weuEYXpOKQMV+87cbmUc/DPOB8k576V+nvFBycvLHUR67bOO5nWnXbltw
         0xjYjQTQvJclU5dTKAsQ27UVQBHDXMlZ+eZ4/FoM49/KFjHPZlFqpZ/GJa4bq1OqLS
         YUTghrIvhgPuaWDj1+VgtFCSLsi3VnhvVz4JlR6yZRpDi7fOf2PFZeVg98GZPZUWbD
         yb316O29amWhCpPI1yl8SkfLRUwRQlfXw7/ycz+F/RzYCR8TLNuoOarsVsraVfexqw
         qUYhWYCPCyLwA==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 27/39] arm64/sme: Provide Kconfig for SME
Date:   Fri,  8 Apr 2022 12:43:16 +0100
Message-Id: <20220408114328.1401034-28-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; h=from:subject; bh=bmQq9+Hs9ppK5+d67ccvsBsIxc0wnK8U9AX00pV28UM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/UAxUEsFosscV36+F0kLBR+bmSz16+f2YTgKsR gljSoxOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAf1AAKCRAk1otyXVSH0K8cB/ 9M/j4kluR0Nrf2PPhLPCfVpZ34in89IgJVEACGFfEItsnA/C33CFqs2QvlC8zaEqpG88e38zGMLXgU 5kbntrCLMRKEqHBVMyJktNYx85/CGpiI1PLwCHm7cvffPwYOCEEX6rl7igQuDNonrCDiqNBhkkxERm RCsIrSi4i4jk2wLOgCCJoo79snBtSHYoLVdYLAltEY4j/zDWFrfQ1Xyd8+Q618woOEhkkoZHPT7MKZ BVAnDJlPLoLL6O25AnJ1cwjGSKTWc4dBqJUTRvIMOLnfnG897E7dnAOCYLSZBbbTRpHiI8Lq3SjO1y UqE2tnkb0ENKzmXla0EieLy5XQxo1x
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
index 57c4c995965f..0897984918e8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1939,6 +1939,17 @@ config ARM64_SVE
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

