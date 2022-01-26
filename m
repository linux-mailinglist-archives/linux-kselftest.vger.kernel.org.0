Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9867C49CD8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbiAZPNH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiAZPNG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:13:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA5C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:13:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 553F861857
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C08FC36AE5;
        Wed, 26 Jan 2022 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643209985;
        bh=+stvVyRnz2H4xbnaEtKWfcp0/IPDCeyODbC6Y5cXcCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nB72mlesq+Au/VqjtZb8aIX4mDOkielDaAjw9jlCVRX4Y0e8JCVzCtEgJ/IWESeL5
         R/4Fvt/k35LkgXsSiMk80sJoC0vJ8mjgqtdH1ceuU2Bu22LYsYLUqz2hLGExeJ+0Mq
         Md3W6MEQqb/yCGQBVBtCTDFEVQzT0uA15vB5I+zucm0NX2xIAJRmqlpX+WSNXVYOPo
         wFHOr3jgIqL3+Fzp/PIr0Q41r5mLdKeL3C6CbPGba+IuSCMa8Dk3U7yvREwWv8BNRp
         +lIcv7EKToZH+Zr4C/jqR87Wrg3NY6JR7EikQ12tJSU8tY65c/o8/k8j501PP/7iB+
         jNpTkbksm2PKg==
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
Subject: [PATCH v9 23/40] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Wed, 26 Jan 2022 15:11:03 +0000
Message-Id: <20220126151120.3811248-24-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; h=from:subject; bh=+stvVyRnz2H4xbnaEtKWfcp0/IPDCeyODbC6Y5cXcCY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WSIZjkrllyw3wrZv65gkzLMq7K6hvi8wR5NerZM dVGlefyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkiAAKCRAk1otyXVSH0Ny2B/ 4nCSiDDbNsZAJkVTSzqfPPSmIOHrE3u6RKhTUbQEZrRIgsnTYyUlPDxQUlOqqRMxUQMw+c2UW0bAGA pX+g4HA+xh5C84zTK7gR/yd9LKSq9g2eIpGPmUkJGMtzp03CVRNlsP0ZxgnYaKG7WhFiwKDaKSiKw2 fQlQ5r2k7SDzi4LV7FJ9vxFaV2H9ypVvBxsxhs8O45V24Ko0akf0RnjUlUFpzc833WWwgxK5LnBb0C P5NfIDUTo1JC6QdpLVZxp4Onahtaai1jx7UKYnJyHXjIjQO+wiMu5J2jIGJsJWyZcq/hYUjaABoFNQ UdFkkLsCbkmeoXmRIlpO2YmYWf8/TX
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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

