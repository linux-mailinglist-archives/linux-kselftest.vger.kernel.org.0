Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF69506A4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349965AbiDSL2Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351353AbiDSL1m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:27:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9240712ABE
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44592B81846
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E9FC385A5;
        Tue, 19 Apr 2022 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367497;
        bh=hKEqxVq3qIYNyJ3Q5Mx9hTOo2XjAx/mVC4NFmLZ1diw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtdXNzNGNqIEpXHSfEQAcoqLQA0OwnOcKDqUUOsEK30/CwM/vmZM55bFDdRdVgate
         FIqnXzaLYHO6Uh/guVYztKPCO4PoqTKx2JhLdMpBbS6Z1tLMM0hbc3QuItEsnaseMe
         idZi3Dogm7SVDh0YiZO3vJoAm/SXLVXOmusumws0EHuPEYhE4R4sMl4b/iGu8eAo5P
         MJs8hrCwE4uSP4+NNdguB3ju4hmOmvFdK+gTlOqPq//zvOFbIFS0wxW/GmN+CXD7Vz
         shVizrxaqmq6xGDR0qxFzz78MiqeGSTYCUEE+jaE6SaR0mBG7h5gF5iCU4zwMAeIfA
         ultWbR4Ehl4tg==
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
Subject: [PATCH v14 22/39] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Tue, 19 Apr 2022 12:22:30 +0100
Message-Id: <20220419112247.711548-23-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; h=from:subject; bh=hKEqxVq3qIYNyJ3Q5Mx9hTOo2XjAx/mVC4NFmLZ1diw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpt5bayPRAObOqjq+ZBzKh1FKgvLLGsBQ3TgiJDo PC1NiqOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6beQAKCRAk1otyXVSH0HsjB/ 99t6AWS0KoiDaWwA1DqLBTFqSSLoaO0NK6a/uwv+HSzr8GMop4VZ4Jx+wxMhIFhR3ZQTNnGhdadvR+ 33Ozd+ypw9AO57hbRuNZX1/Vt9Au6jm3irZzve/q5nrjy86I4wnyl114GsOwjTUaB+g2Zn2tSPoDLo 2YuS73oV0vFDm3aTswWCgxcF+SA10fDBiIotXrR8ADPZA2DotX58GxC19jFaNdhHC7qLzbNw+biCAu RiUjOMub4MO3jeWg+ooKKn6TWhVv8tg5k7G5GlwDpO1sVhoErSG6LXOq7ZR/90i/ZVPSZCewptyPfy Xl3RcId+7mqhbe5HN2xu31t7cvmNnF
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

