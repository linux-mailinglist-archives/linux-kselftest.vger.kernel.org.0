Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4B49CE66
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbiAZPb4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbiAZPby (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:31:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57134C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:31:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 210BAB81EA8
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89914C340ED;
        Wed, 26 Jan 2022 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211112;
        bh=+stvVyRnz2H4xbnaEtKWfcp0/IPDCeyODbC6Y5cXcCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRPuKNGHCwnZ1VSUSqealiseudJoqlb+/8nsHVWbGZbQrwPtNcAFQGW71I3UwX2Az
         rzfCmxqS0rEuRtShv+CSZoDJFfAypiBqdMeMnBihZQxF5d9yVBv+2vVt4kCzW6Lrks
         uJCUF4AcTEZFincKuPi7tfNQYiWF6IxLFljy7H1T6BCSfUSRal2IruPaNVFyncCj/d
         66ASS390FFxe72z1rlXYWF6QULikvrmRKNFuM+DEJa6yagO0WKxjulS+YAV5HG0sQA
         V2FRpxJ23WgIfLTHgdJjAEdp2ZgPdWYhJHlnUzSYduZnqQIIiF9aliQH+8vLcJzbJ6
         3PbxG2ZySUkfg==
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
Subject: [PATCH v10 23/39] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Wed, 26 Jan 2022 15:27:33 +0000
Message-Id: <20220126152749.233712-24-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; h=from:subject; bh=+stvVyRnz2H4xbnaEtKWfcp0/IPDCeyODbC6Y5cXcCY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhnZjkrllyw3wrZv65gkzLMq7K6hvi8wR5NerZM dVGlefyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoZwAKCRAk1otyXVSH0LFTCA CFRAzSN/vje9nUUCsi+wm2PdjWcOfGt3sY+Ukajpn0zlb9gPmFHavfmNRwhTc/7H8WyXcePT3n39/+ 1yWEo92lRkfsCFtfBj3ge6s8kIMR4ualZ9Zm14cj4oyx7DVrV+dQJVbdM+FFlJqWTMTvqfFmHKBWXe o65DjGa4dSHKR3HP7OytWo0AS4UPdapfbm1miFw6BM7VI0aey+lxela6rEx+ldTtkVl4IyU5PUPrDF nJjOCCiwl0gng9F2k8yXKE+DYOGsoxb/aWSC5uJYqh4he1fw5lqm3NqIkutYy5piivH61cO2INTXWZ v23Iq3O7CgRbHLrjxF5BUSwqInqxYP
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

