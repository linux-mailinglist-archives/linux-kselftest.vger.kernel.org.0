Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5655166C59F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjAPQIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjAPQHZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:07:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E9241C5;
        Mon, 16 Jan 2023 08:05:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DBAAB81065;
        Mon, 16 Jan 2023 16:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88228C433EF;
        Mon, 16 Jan 2023 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885130;
        bh=BRfk0WOJMVJQ0g6gzb8bzQbO/L/4/GqYQAhZHV+SWIg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ch1sF2XHZse7Ty/yGLrjCrku7Q9y/IpOI1twzw7JGrPwJpozxfcRMfLpDGP5yVKED
         EzTczLO+c5qcLtpCcpMPeBGb9srvY9LGiB5hkoprKd03koTcpahLPx/p1nMuh1mqq6
         L+WKCh0kp5TaI98f8gXjdOJUfkSgsDCqCCMBJsi+qsch4PkgyMx4fIjgoTd0yax0Rv
         VjCExTE9f/aJiMpRfu5IRin8ctApJXe4A26QuLIpEHmzLvL2i/MaC0kO2gLR4GELVY
         TqllPXC/iTQYQWoQgqSGVnlC8yYcToCwiGb0GCvYzK0aV/FUUc+j8im3bPXmrPy1bx
         XX7ckP2jPHW1g==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:38 +0000
Subject: [PATCH v4 03/21] arm64/sysreg: Update system registers for SME 2
 and 2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-3-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BRfk0WOJMVJQ0g6gzb8bzQbO/L/4/GqYQAhZHV+SWIg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWkESxtnGjNFkNhM7rHCgefRvsjIDZTnxQOibp6
 ekyJS2+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1pAAKCRAk1otyXVSH0JFfB/
 96NjdQ6gCljpAd/nlKb214gbriT1C0eTzfcAbiaRXjE858AqHLE5xyTY4B3KNCRKVM0FzmOiAKWk3O
 zbGUOVXNW1DADOqg/xFV6jWDuOE3kMkTgnhOlrgc0JUT9D8p/Nl+wHZdrKHJbzsake9aCvekoqGh7L
 FWrlR4HLsJMZoY3DY2r72X5UM7a7A09swSKOXXzXg3YA1dFvTjs98GSlKX0cW8EMdzpPVotm2H4nSy
 dAUOroxsRzJh13OGg/A+aKlLjItnqyW/FrLesE6f3WPsci0IjksXlcHkkWXVFYxp5CQlIJniOMm/py
 OXaTcHcVENoEIm6rUBkXUkjSyXPZFk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

FEAT_SME2 and FEAT_SME2P1 introduce several new SME features which can
be enumerated via ID_AA64SMFR0_EL1 and a new register ZT0 access to
which is controlled via SMCR_ELn, add the relevant register description.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 184e58fd5631..13c87d8a42f1 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -894,6 +894,7 @@ EndEnum
 Enum	27:24	SME
 	0b0000	NI
 	0b0001	IMP
+	0b0010	SME2
 EndEnum
 Res0	23:20
 Enum	19:16	MPAM_frac
@@ -975,7 +976,9 @@ Enum	63	FA64
 EndEnum
 Res0	62:60
 Enum	59:56	SMEver
-	0b0000	IMP
+	0b0000	SME
+	0b0001	SME2
+	0b0010	SME2p1
 EndEnum
 Enum	55:52	I16I64
 	0b0000	NI
@@ -986,7 +989,19 @@ Enum	48	F64F64
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	47:40
+Enum	47:44	I16I32
+	0b0000	NI
+	0b0101	IMP
+EndEnum
+Enum	43	B16B16
+	0b0	NI
+	0b1	IMP
+EndEnum
+Enum	42	F16F16
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	41:40
 Enum	39:36	I8I32
 	0b0000	NI
 	0b1111	IMP
@@ -999,7 +1014,10 @@ Enum	34	B16F32
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	33
+Enum	33	BI32I32
+	0b0	NI
+	0b1	IMP
+EndEnum
 Enum	32	F32F32
 	0b0	NI
 	0b1	IMP
@@ -1599,7 +1617,8 @@ EndSysreg
 SysregFields	SMCR_ELx
 Res0	63:32
 Field	31	FA64
-Res0	30:9
+Field	30	EZT0
+Res0	29:9
 Raz	8:4
 Field	3:0	LEN
 EndSysregFields

-- 
2.34.1

