Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6197D82E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbjJZMqp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344984AbjJZMqo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:46:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF4194;
        Thu, 26 Oct 2023 05:46:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2F9C433C7;
        Thu, 26 Oct 2023 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324402;
        bh=ZUqE+FoZ8I0edvZBSg8kbSquWpI5yMoNq50cI0RqCRA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tprJLkklYLd9LU4YRx3zEkYskq13dHHC2DhKzA6CzKjhJDGvRAm+LSGLuX62rkiUC
         mgh8v98gEYO6Q7HDvqodefGJdSJ/nntVf17lmXoZ033Kf3oIirNGfwYfonuA6eWiUr
         HNHPJ6O5NL9Q4+9lMul7E5tGQJ/IK4DD9TFJId6VERhWMUCiaQU0aB8ysjWNxxbvDa
         vNqQSTkVnrdUHLpk5OM0O+cnDANfcL68Y9mcCywePOP2WqeJGG7Hh6FHQqXBoHIRSr
         fl9bLROlEWhodHkPpWQ60wzkeldHScO4KY6tANyCuIOCs4UPawfMrcU/wwvwYi2Qxg
         GiDB2wx+dtocw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:17 +0100
Subject: [PATCH 03/21] arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-3-8470dd989bb2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZUqE+FoZ8I0edvZBSg8kbSquWpI5yMoNq50cI0RqCRA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+WUHz+pzcsY08wNR6Kjeb25JKyJyDhzGlPim9E
 eK8IbOeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpflgAKCRAk1otyXVSH0PU0B/
 9GMmBOtiaoARHjbPxYpbTU3Wt0euLtLqlrzKZURVhrsCeiyY1LoZvh0vXbrNdiQ+FEqycACOlXkXsY
 t0ki7j8v8aD0oQiiB3GBnJjEu9UXCb0sNlD88c7THyIbZ4Il9XLnKOBIt76Q000umfoX3M18aI7k+W
 Am8FRhvhNbAHQKk59MSLd7zZPCLv6YcrvZ6g7V6LJrDhsYL6AxiL8toCsDsB5fE9izdhNc1jB5KqIs
 CRXserJ3jo/Sl9vHtq0j2EsRpiXDiGSzEj3+TydR6tNj/Ntv/tSP3sLLHWLMkAjY2iJXTlUxq9EtP+
 OO+JMUz0p63D54Lespwq6HZEcBeen+
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

DDI0601 2023-09 adds a new system register ID_AA64ISAR3_EL1 enumerating
new floating point and TLB invalidation features. Add a defintion for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index fcca3a3714b0..0515006a7292 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1427,6 +1427,23 @@ UnsignedEnum	3:0	WFxT
 EndEnum
 EndSysreg
 
+Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
+Res0	63:12
+UnsignedEnum	11:8	TLBIW
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	FAMINMAX
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	3:0	CPA
+	0b0000	NI
+	0b0001	IMP
+	0b0010	CPA2
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64MMFR0_EL1	3	0	0	7	0
 UnsignedEnum	63:60	ECV
 	0b0000	NI

-- 
2.30.2

