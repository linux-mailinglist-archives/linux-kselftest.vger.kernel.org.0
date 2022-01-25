Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900CE49A52F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3409228AbiAYAZM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:25:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52114 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374324AbiAYAQt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 19:16:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A68B061543
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B056BC340E9;
        Tue, 25 Jan 2022 00:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069808;
        bh=+stvVyRnz2H4xbnaEtKWfcp0/IPDCeyODbC6Y5cXcCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8wbOYozrg4+ovKqrWnHq18dFa0bz71bu8Rr/6/ewc58V43gHblWYO25/Zn7FB57v
         xubMD6JJHVgn3VvtrRhwWg7zvLqw5dTL59NWQFEPCmonHw7qSJ8H2nwPcq2a2KGu5w
         CXTMeCc17fNBNw/eYs3h4OUF6Q3Q72n5DthiAl5E6wO9X07Ix4gq3THDXmbp8gsLzM
         3Wb6/eEdOUCOWqrN6eIVsP3hZdmqN/8xgofETXtVellDBvX+nWqhlGVplYyFH3WvBf
         zmSMQUnpSUvUUK8rMwLkWi+UG0ZrDhn6Z3u6RYH3JlbhPYZ4DCjxKG3qW2bF9ptIw4
         aeVPuNh3Xy0Xw==
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
Subject: [PATCH v8 22/38] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Tue, 25 Jan 2022 00:10:58 +0000
Message-Id: <20220125001114.193425-23-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; h=from:subject; bh=+stvVyRnz2H4xbnaEtKWfcp0/IPDCeyODbC6Y5cXcCY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70ASZjkrllyw3wrZv65gkzLMq7K6hvi8wR5NerZM dVGlefyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9AEgAKCRAk1otyXVSH0NbyB/ 0aSvLUKYmoq6mFoAyvpGc/oT3Cs8OYVjbNPgjDw2ExcuHRbslUM2Mr0KL3jFfhvee4XeVMl6fVdWZI qr658iRh7kGFTUU5UE1J2hqhfohsDh8EC7a2+S+ZtcAe/r/ZiuJcqDkykG2UFXWHj1npykI9B0/ybx q1KkfrLoGwkFQq8Qtgl3b93K1iOrmi8x76b7aRvmIWQIwDoEXTF5GOuSpRACciWM4n1Y4cn6X9s71n RmgmsUeY+jswAhlV+8Yk5JRxyHjS+ibi0+kDGF0PbS1KpMhTa0+3R6w0ZrX3XP1IuU63+JgCi2qfNe 7JzsueypROn3Znfz+GdLab96n/x3mG
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

