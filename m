Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452C04F94D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiDHL6t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiDHL6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963A7E0AD
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B7296206A
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E5EC385A9;
        Fri,  8 Apr 2022 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419003;
        bh=hKEqxVq3qIYNyJ3Q5Mx9hTOo2XjAx/mVC4NFmLZ1diw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbZMRzpf8Te2GqAxWyjJ4p9AyUdTgvMBvxTqlCOch7C0mESZk9C8Tvll/cD/OwLJV
         a58obC4M0dWEBil8SprmomlsVt7GES2hrc6XSAT9x0T37rLsNDfrPXLjbg+vH243Ib
         NRE01/gbZbSh/IbPcb54QZXzs8fTEYCfsr3G+5F3nZaPWsHiJl/BgaAXiJG5T5jZ9y
         4L4goHxFWF9VY6hTi/Etb2Pmpm9z6OauKlQ88WQ3IwKuktGT7b2aG2L1eyDJXzfaRr
         sAucKpTbF/5LBS+EiWc8tJxfMhX2XWBo5dafsskHXwM6eIDwWXfcesGorMi8Qz+PNO
         jPl06ZR899S9g==
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
Subject: [PATCH v13 22/39] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Fri,  8 Apr 2022 12:43:11 +0100
Message-Id: <20220408114328.1401034-23-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; h=from:subject; bh=hKEqxVq3qIYNyJ3Q5Mx9hTOo2XjAx/mVC4NFmLZ1diw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/QbayPRAObOqjq+ZBzKh1FKgvLLGsBQ3TgiJDo PC1NiqOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAf0AAKCRAk1otyXVSH0PZUB/ 9sow+wd3rU879zNb/GBVbvo9TsEmWORj7qVQs8QWG+WXCgghi0kb4VQRsffML91gmX/X9CUH05T7rb 6qfXtjDJske9cv6IOh5vnb5P4stAJNeq937A5L0+edmNQteMyTsPAMqFyLGsY91YcUqvDEfNk/fOw1 DmS9GUCRz9Zia3EsEhzVq+b9OKDtyDL8PU0fOl9BEeGEvbCH13XdSWwGIo55o7E9Ur5EyCLN/p7Jj9 welMKPF7nFWiYHpepkDvWdI0Xq1ZI75cn2i1L/GKnSUVnca0G0Sn3M9417FEYT7uXSUPMm64pTDv88 FJCe8oAsJgqNDoKK3kg27OSFkcgVRC
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 94f06e9d37cf..9592cdd7d635 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1759,6 +1759,15 @@ static void fpsimd_flush_cpu_state(void)
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

