Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0F41E0DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353371AbhI3SSn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3SSm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6064A6140F;
        Thu, 30 Sep 2021 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025819;
        bh=cD4FALZ+o8Jhic3hBdZ/lttEi5Wq9537MuDDsXImrIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9+HrGEgWFk8p/vHi4NFh3a5vyx3ijTigdb8xH+8Y6D16j/le7jPoINKiPYzB8XXe
         KGsnEKvc0WoSG45UBMfgakrGhiumpxS6aasvRnPv6ywSsFibDqHY5J9l1c8qXsLMpr
         8QHkPYewagnDC1Zdvc1R+RqcwLz3v5SXw7b0BZQ+n/qDFl3dbkqeA+gV3hf02mi8ED
         nACDkQKe0GoHEG9nsqhe+/DhJ0qSz55x/WBy9khlPTI9GdO4RF73bFKTHVUq+CA8kv
         ZiLX29waDVZ0I+kLl0lvfHPhVcgTlwiJI+adjmlzFhCUY1krsD8f3cTrSj3LGXN7AY
         w4D4jy/OtcRqQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 29/38] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Thu, 30 Sep 2021 19:11:35 +0100
Message-Id: <20210930181144.10029-30-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; h=from:subject; bh=cD4FALZ+o8Jhic3hBdZ/lttEi5Wq9537MuDDsXImrIw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3YQ3heUpTuxKbkroveMPM8Rrr6Gr5WMFlBub6Y 8nwnyfSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX92AAKCRAk1otyXVSH0BMdB/ 0T3Ex/M1cL3DRNVE9uCMa90RL1iKIaDNEAwG+N42KbYSnvb6fK3WD/mODxomAf7Z0t6UtnaO1xMfCy Pp1jS1ULZAYDqGbcYDZSsMejedSOi0PVUMu8x+6RIWDe7iE7tkYGZ34PFOXByV4izvJS7+ejydpmfp fk2eAG0K53UF2BMH+ED3lATdxA0yT8ATGdMyXIjQAmDPUBcay6AMshqXng+7Ux5jUWXs3ydwt+NKoq znxOtK/U4yqp43cj/isaP3/ZRGjkupqwcoEFdvzLkquwhxUZn1OwFFrGpDpgaeu0RKoldwYqjbvKMx irl1H7eW16thxN6hWA8q44jqjcsc58
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
 arch/arm64/kernel/fpsimd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 118435dc1da4..c34d32360502 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1736,6 +1736,17 @@ static void fpsimd_flush_cpu_state(void)
 {
 	WARN_ON(!system_supports_fpsimd());
 	__this_cpu_write(fpsimd_last_state.st, NULL);
+
+	/*
+	 * Leaving streaming mode enabled will cause issues for any kernel
+	 * NEON and leaving streaming mode or ZA enabled may incrase power
+	 * consumption.
+	 */
+	if (system_supports_sme())
+		sysreg_clear_set_s(SYS_SVCR_EL0,
+				   SYS_SVCR_EL0_ZA_MASK | SYS_SVCR_EL0_ZA_MASK,
+				   0);
+
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
-- 
2.20.1

