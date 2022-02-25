Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3F4C4C77
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbiBYRgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbiBYRgg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50B91D52A6
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CB38B832D8
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81457C340FF;
        Fri, 25 Feb 2022 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810555;
        bh=bDRizLqcB/rg4bPthhre+I4xVGpZjdYARITX+zdN5ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHc1QsP66RPrqEZ5PTTRbaz0BMSN6JLOhmwTFEiy5onD0S9+zGHF7pNnk9POluZP0
         AoMw3Cy8uSX1sIYp/ea57oBhx2+T9WZLCwK3KpKq4lG5Y26HXpXgd/qi2ZxcR2jWJ4
         5Hxwj8ocK/y5A/lp/PEeVIb94yvGHn9/sS12mDFOna4UdGSqyBti3Zfoe4f4aE4l25
         Ksi3OOBdTto4To4UG1p6dxG5dix9GzQe1KSu2Te9437zic9Nbrp50NhCClgo2zg7dR
         JisLXJUmQuTqDn6aasybz+6FlDITGHrhV2JhixgMf6lafhD62HFQzNfXFCskd1XgeS
         hAh3H/NIHt7tA==
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
Subject: [PATCH v12 24/40] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Fri, 25 Feb 2022 16:59:07 +0000
Message-Id: <20220225165923.1474372-25-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; h=from:subject; bh=bDRizLqcB/rg4bPthhre+I4xVGpZjdYARITX+zdN5ac=; b=owGbwMvMwMWocq27KDak/QLjabUkhiRJrrsXE5s3y+/xqHLil0u5l6zytMnUKFhv9r/IRJtdEXwm fBWdjMYsDIxcDLJiiixrn2WsSg+X2Dr/0fxXMINYmUCmMHBxCsBEdH+z/2bzb/v9WXeFbmm0gMhrq+ 1c92o0WGqZ/td9rUthU18yX+STK6fdhCzNgtdOs54aRSbEqiuvmWpVfHqOisqqy6pvN627cIdn1kWW A+Lvvzq0phamtP58NmMeU+CXpbPnLRVTmaL3OvvH3Jvh94tyiqVtVeYo+0/c+9qkt8An3vYi7+Qln9 k6H6arT+1l8Njku2EN+8OXX3hOi0+z/FzwyMKJl8UiIUJkt/B0nYREJ4cA21spLuwaW5sfRZ/hC+My +eqV6pRr7eqjkbpFV6xvqZJPw6nZr1bGPrM4/0tz5vxgiyWPN8z/w2MTwp/geKPpYeCVmsOGATkcHn rmC+5d564O/3hAqYJ75uyfQiavAQ==
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
index 2e931373b361..d21d16bb03a8 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1742,6 +1742,15 @@ static void fpsimd_flush_cpu_state(void)
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

