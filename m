Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65BF49AA67
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 05:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1325561AbiAYDhl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 22:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3422138AbiAYCaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 21:30:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E79C038AE8
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 16:15:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA3361496
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59995C340E7;
        Tue, 25 Jan 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069730;
        bh=3sonF+yHE0fhlKD09DOEsXzDPxYrP95z6ruAnvpEJGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeUL/uRg+N8qGiQYYtiPz7kCxVupfk7Z6X0zH+TBJd4qidU6s1HGk0lDqGTNQzxRI
         Riw7e0nHlM9zKocG7QHaMZAyKWLWnS4mSHIfZiu6eCYP1byNJSlxDmxP0YaVLB1JLf
         XG1zmq2DBQVWuSaQsYE9w7EKIHDoF+9sFxq+O3vwSL5+1ge80AnzodOTBgaWRdZYQs
         99SCiivx2Adel+QgiipPszfOxSE7Zwbpq+KkXEu70AYWZl1aGAtwHni7SrY44yOGgS
         HSXIQjsrTOeFZ28TEA3lcn7H93P9DmXgLRH6LkDrxL5vdt0rbkdqesYqwmQ6CmC5Zd
         ZYp4HDqS3OH+Q==
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
Subject: [PATCH v8 02/38] arm64: Add feature detection for fine grained traps
Date:   Tue, 25 Jan 2022 00:10:38 +0000
Message-Id: <20220125001114.193425-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; h=from:subject; bh=3sonF+yHE0fhlKD09DOEsXzDPxYrP95z6ruAnvpEJGM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AC//2QjAgtLKpaHN3VkL1TidYgxM2zCB5+nShw WJsna3aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9AAgAKCRAk1otyXVSH0NSMB/ 91vAjavGUrRIbSfB7NNYbejpWkY43ECBQHx+Kx1eooW4hgntBfKG6S182Oc689gzr7dhXdILY5I0C1 yYWTnJapu/KZnD18q178dDoijFOdHG33jOlPcEnU0CfCqE9wluRB+nYui6wjjngrg+g/99yXxYajuC I3B+Acl1NfSoEHYwcrr6PPWp5zqIUN3ZEufYMH9KIm3mBMpRL62QkWxZkD2dQ3+mYSBbkYR+vpcAmo N/6l1DM9/PgLIQsyLAtSx+lW6FrgwrXhjavAFeam0K4ocvtNnHbM1q7AR6aJQ1r7l2mWprhv/9VDpI /njnDCAr0h4TkbOE7RB/RPcX3ZX6Il
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some of the traps for nVHE SME support are provided as fine grained traps
so add detection of fine grained traps in order to allow us to guard usage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 11 +++++++++++
 arch/arm64/tools/cpucaps       |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d9f09e40aaf6..ec060db1dcf0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2400,6 +2400,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
 	},
+	{
+		.desc = "Fine Grained Traps",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HAS_FGT,
+		.sys_reg = SYS_ID_AA64MMFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR0_FGT_SHIFT,
+		.field_width = 4,
+		.min_field_value = 1,
+		.matches = has_cpuid_feature,
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 870c39537dd0..b3ada80aa48d 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -20,6 +20,7 @@ HAS_DCPOP
 HAS_E0PD
 HAS_ECV
 HAS_EPAN
+HAS_FGT
 HAS_GENERIC_AUTH
 HAS_GENERIC_AUTH_ARCH
 HAS_GENERIC_AUTH_IMP_DEF
-- 
2.30.2

