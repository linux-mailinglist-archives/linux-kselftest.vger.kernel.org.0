Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337FF7D82EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjJZMqw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345005AbjJZMqu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:46:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8C194;
        Thu, 26 Oct 2023 05:46:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91771C433C9;
        Thu, 26 Oct 2023 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324405;
        bh=l+HCexWWxMeo4+X882PpIsnRc1YU/TuuwGZRa34ZAVo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HxSkc5zcim4fIsz1of6Y5as+8CAZs7GFuQ5+xfycnsE/b/2Is+MZ0XHH/+pA2B+/W
         mee0IXbfkhsfej9CSwpQ7eYjTGIdqZkGhP6KqcvEIBkU78CmpAsrNhflVoTcqiR2Wj
         VPJrybUSoaqp56l6aaITq9xi0eQVFvCKURnJVtZlQS8/Gek11tUj7Vj0xMN5CFJlsN
         1llfJiMql9H2UUo/ZsF+4bdzNI0LvtJ77O/O6yTvAxuS0TJhqdKmmy+MOvcYae1X2O
         KX+F+VLJNuPluO3KRh4m5nzAtWP+tk6lWk+QkHsZ73z7moI0bAYDJxwF2+VI9MOH1Y
         CoIxE9K75HHEw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:18 +0100
Subject: [PATCH 04/21] arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-4-8470dd989bb2@kernel.org>
References: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
In-Reply-To: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=broonie@kernel.org;
 h=from:subject:message-id; bh=l+HCexWWxMeo4+X882PpIsnRc1YU/TuuwGZRa34ZAVo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+XUuTBqlPY3g709lZjkwYwp+1ZdUE3hY0gt7IQ
 GpOYfLuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpflwAKCRAk1otyXVSH0K7jB/
 9ICx2WqKsW1ClXsnohdgTF3SOkdLDKnjHNlSqc9Ur0gJ5NCfS6kccYZzLwgEjzoAR5DThfGIZSDJt+
 OXOHBgGCBfzN5Ivlaf0WdFkUDQdu+vkrIY0RyNk+2DmE1tUalkkUjydPHS3C6C+ytF3AdgmQNTOGII
 DS2WsRlR+ll3gC98gzI3fJQXrmiGv3Fni6LVhsUAx+GLfnQIMRIwpFPHauUEAmgTOjR2e2VpiDLhsQ
 SsIbOH1zVwcZ3vTidZnJxL98YtD9Xqu4iIeF+xPer5Qp7ak4V1fcJMplcR5NKQMOxrYpBYZOBoy/5K
 Hlgm1bZgqd3CGwsYvIR/0qZHTUCWGz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DDI0601 2023-09 defines a new feature register ID_AA64FPFR0_EL1 which
enumerates a number of FP8 related features. Add a definition for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 0515006a7292..057cd85d8c2c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1127,6 +1127,35 @@ EndEnum
 Res0	31:0
 EndSysreg
 
+Sysreg	ID_AA64FPFR0_EL1	3	0	0	4	7
+Res0	63:32
+UnsignedEnum	31	F8CVT
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	30	F8FMA
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	29	F8DP4
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	28	F8DP2
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	27:2
+UnsignedEnum	1	F8E4M3
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	0	F8E5M2
+	0b0	NI
+	0b1	IMP
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
 Enum	63:60	HPMN0
 	0b0000	UNPREDICTABLE

-- 
2.30.2

