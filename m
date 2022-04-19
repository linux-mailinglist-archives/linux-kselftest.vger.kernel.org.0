Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C2F506A53
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351376AbiDSL2U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351444AbiDSL2D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:28:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E524F33
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91958B8184D
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB25C385A7;
        Tue, 19 Apr 2022 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367518;
        bh=bmQq9+Hs9ppK5+d67ccvsBsIxc0wnK8U9AX00pV28UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+zQqKdbQI+mS4HhiGd37IVHn7AQwgY1PLAb6tLN0oMUXC3y/po7Cxzj+1qqWVm9t
         lmlVYA8FQTMIQYA+ik/HqxoqcqBqHTKfTRfP5AdLKiA3+2Z6fNstTTVn1736RxHc02
         V3Gtj+mN3rSTx0Hyg4XwGJhTUCb1SlBpHkgJleE9zeSIuQpm5jVgNH0HltxnOFHJAQ
         a0NjDM4IOc++3SZhB1DtJNCfTGTLyz6NdmYxBU9+C/SaMNoY1wTX5fpiiS4h2Tjx8B
         7HPrgS/8zlc9sbNpePIdsXnEAiAQxMZ8u9RMqobECS0SRqLXLIrvyyg/dyTxPGrPVq
         puObr+opK4xQg==
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
Subject: [PATCH v14 27/39] arm64/sme: Provide Kconfig for SME
Date:   Tue, 19 Apr 2022 12:22:35 +0100
Message-Id: <20220419112247.711548-28-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; h=from:subject; bh=bmQq9+Hs9ppK5+d67ccvsBsIxc0wnK8U9AX00pV28UM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpt9AxUEsFosscV36+F0kLBR+bmSz16+f2YTgKsR gljSoxOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bfQAKCRAk1otyXVSH0K38B/ 9cna5AxLSwfYTwmYxJ0HTPZ58U0vwlssA4S4QMMfIh8sPBUEvF0t1lMm1CTZwpGn2+ZXcXyLjI8r6y ENwF82goVK2d2popKK9p0F4/UiczBMdKIYaWkfcHdyhGWxP+tZUbWB+eS1jcEA2i1hJfkYjBJaGvp4 XpF9pvEKeNHE1mEsDmWZvgqJGehpVGwU28RvuaFe1/EsWmPdikwsvyYQ4hGTXeB3zew/P9WFXPJS92 LSSmSBb9bYuxxcPW8Mxvs4p1PZlqyj/Y7nov6YLyX9Yy0+FNo4VWiQTw9rgNAMTRiA95oqNuZS5Vyt 5CIuVliAk5jrc6Vc3mAp/Fwwy+6Yrw
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

