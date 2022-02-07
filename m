Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84ED4AC3F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbiBGPfN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 10:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356127AbiBGPYs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 10:24:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753DBC0401CE
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 07:24:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38136B815A6
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43228C340F2;
        Mon,  7 Feb 2022 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247486;
        bh=+stvVyRnz2H4xbnaEtKWfcp0/IPDCeyODbC6Y5cXcCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeGQY67CXRWkA02czlOg4e4dKQhn1vgI0TX0Kzvk92P2fXSxyJ5PZWf6JYjOh28HG
         p/fcLBFTTYtSxmJ0HdA+tLpc5Dt3SvtdUu0aCiagxYI6IPJ2FfmB6Q3516WmUXUlvr
         sK843zAnWjjzJQUIN0M3GElhb43EQjDIaRJSDys7IPjJ/sroNZ+Q09hJGxtT4+A3i/
         TMZLeRX92xt/Zwsfw0+rQCGsDpmCTfoa3kob31yRRRK/nCjSj3rCJpcSsa4I3pUOyg
         3pgwkQtQ4m1aZ8I99dU4lZt6qIvRyb7UXGx/s9GxtOAaCYuZ/siUWdvC4Lq+H3sC9r
         9f5S4Sk87qJ/A==
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
Subject: [PATCH v11 24/40] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Mon,  7 Feb 2022 15:20:53 +0000
Message-Id: <20220207152109.197566-25-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; h=from:subject; bh=+stvVyRnz2H4xbnaEtKWfcp0/IPDCeyODbC6Y5cXcCY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjXZjkrllyw3wrZv65gkzLMq7K6hvi8wR5NerZM dVGlefyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE41wAKCRAk1otyXVSH0NQpB/ 9paVTph2pBZxYnT/c1ExiDXuHtp0fK3bfvDPEFT3bvWk96GqS7QwDkwaX2TuIM/QS8Ip7+6FM11I1z /Od20Ab96ZmMgKUnlxByL9hKw4g+pQcJB8Wqz4V6cV185sLmu8Dij7x/1+35pVPTOwft4FvC+uBe2a SSAcH1i11FngQ+xBNThdmdvo+2KWxm8L1AZ98cMW5EcyROtHRU/Bt4sM5M1+GhqyNJFqCD1vP06tLb bs5P0ELeLusAiGHNUThbDtTZbuNMANSC5axgd6WIFW7mUbGV4ZtsVHJsSID+dxJlsU5Bys1zUzt8hF TFjiL/AwQ/WxnrY43MddYL5xVG+cdM
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

Both streaming mode and ZA may increase power consumption when they are
enabled and streaming mode makes many FPSIMD and SVE instructions undefined
which will cause problems for any kernel mode floating point so disable
both when we flush the CPU state. This covers both kernel_neon_begin() and
idle and after flushing the state a reload is always required anyway.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 8b111b7f2006..e00d3a9e919c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1762,6 +1762,15 @@ static void fpsimd_flush_cpu_state(void)
 {
 	WARN_ON(!system_supports_fpsimd());
 	__this_cpu_write(fpsimd_last_state.st, NULL);
+
+	/*
+	 * Leaving streaming mode enabled will cause issues for any kernel
+	 * NEON and leaving streaming mode or ZA enabled may increase power
+	 * consumption.
+	 */
+	if (system_supports_sme())
+		sme_smstop();
+
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
-- 
2.30.2

