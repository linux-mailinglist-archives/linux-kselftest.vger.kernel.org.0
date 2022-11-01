Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC39614CCD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKAOj2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiKAOjZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC927120B8
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DD23B81CC4
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279DAC433D6;
        Tue,  1 Nov 2022 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313562;
        bh=lxN3b2FYRfYKa3rp4NRU1yWU1LTiLst+rtoiTHw401Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5A/A59y/17yYO9iJQ0qGNgeZxspAr2Edm+j9Ba9Vu+6i72PL+DY5EdjC4IVXtB3u
         RtVD03obZtGYTSfWVmKnMxmjS4aBjEL7S+mUFW9J18Ns0rgSc3PtdMJ2pFBDev/SIQ
         w2jjPZrDCIGqg0DzA7/t03yhWrl3UctxilHw1x8RpO/8i4m8NsO+fgkGlLh8eBnWc4
         LEgwHAOxu+gu62cW30oan4hwNfDmouF8lMQVnjPYxfVKzzT25geqcXttOwJ7kwxLNn
         MMfN+xUfKDQV7FJKLUWuSlsaH+0JUOL3Xg+GMTOA1KrYgraJ/5W/FW8b7VkMYBlVAf
         wnJKy5PmoRfQA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 03/21] arm64/sysreg: Update system registers for SME 2 and 2.1
Date:   Tue,  1 Nov 2022 14:33:18 +0000
Message-Id: <20221101143336.254445-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=broonie@kernel.org; h=from:subject; bh=lxN3b2FYRfYKa3rp4NRU1yWU1LTiLst+rtoiTHw401Y=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4szguQk5G1Wp1zJ9WFZbb4KEHHs3GtNYf6Duji o6VzzbyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuLAAKCRAk1otyXVSH0Ow9B/ 9Q6gP/xJ7rQdx3ySv3ZKHglpq/MX1do3VttlBdQ3B74fHJ8L8zGhRU7Wbsh2UkQDm7ulJdNLsL9Kqo qlrKKywZpvkZ9waDWTyjPp+6Hs85gDcP2Gqd2Ysp3ItPXCQtqwn7RtBA2zyZPfI1pBHL/Krh9lDMp8 w3W4L34t56cvyAnhPM1WxBwenMyH1Hj43nZ2ATkZASwhhW6aFGaSOlxRfqUw/eCuFaeVuGpHXlRePi YoJMaqobppCORumljsRuQHjARVuVtZk0SDKjX/akpwBWUve4e71Y0iI4M8eq2EhRhhgO+E6tpsYJM4 b3iD2INlxozWKo53a3mBrajekEs/VD
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/arm64/tools/sysreg | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b2782b8faa01..c8f259dbdfb8 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -221,7 +221,9 @@ Enum	63	FA64
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
@@ -232,7 +234,19 @@ Enum	48	F64F64
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
@@ -245,7 +259,10 @@ Enum	34	B16F32
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
@@ -845,7 +862,8 @@ EndSysreg
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
2.30.2

