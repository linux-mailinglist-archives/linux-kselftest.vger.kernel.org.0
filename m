Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B567D8305
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjJZMrb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJZMrS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F248D6C;
        Thu, 26 Oct 2023 05:47:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61B9C4339A;
        Thu, 26 Oct 2023 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324426;
        bh=Es1HQrf2Y34+Fy2pSDeaIOdQfdboYR0FuIcMBXlX4+E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rg50LsreK3vPIQnUFmO4QXkUaZiJ5uu+B1PwlgA+dWT2+hvnlSu8CfejYBS0jIOqN
         jm6KPhs9etVVGyPwD3sEzY3TZwQh4hptv7k4MGp1X3G2IAOJCp8HeuBqF06vbriFgk
         qkvDIr/xldrQYb3bFlPSKifIR7Ir8baQSuxKCxS5NzHbK8kdC1UL56z2OD12o++szv
         49aiBP6I8e31ZVskSWCtYq99rxIkhvDT+DXwDeGPZZHsSsOzONPW24DPqcCjsUSwCJ
         NIVKhB47bS7xGcEF7iJPEc5Gd6gWtvf6uboipUivt8bN0CryYGLbDCMPUqCXLu3DRZ
         jT1jdbWsALl0A==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:24 +0100
Subject: [PATCH 10/21] arm64/fpsimd: Enable host kernel access to FPMR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-10-8470dd989bb2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Es1HQrf2Y34+Fy2pSDeaIOdQfdboYR0FuIcMBXlX4+E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+cDio3fVDOG6FkTnDOEe/llr5xX9J3YDZxYQ5e
 4EBVfGqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpfnAAKCRAk1otyXVSH0KuWB/
 4v50sXhUz0JQ6Df8E+uf8uNMaUfxkYmtpSyW2zLhk5PHHVGCQsyVHKygDY+oINIJP1Am//8A0dhZ5o
 1RCYO7dDqCw+olrIQO8LKLKOFNn+tL1rkaIAJVSWu5+qhUkV3m0Tfaux/6l93zI3ginnkp8ohyaucZ
 wQt5hoE35RQPa/3xJvassbTstV9c02LKJ/mLw2J0zTBtHzJFf0WttobhzE7Ej+i2tqIT/SLAzVshlq
 jQrdtUDqraR9V4BddiTiGc77Wb4Dxav58X25YbyXOvf20gm0ZAIjOrz8E9cLDXp4MVUvLZTDt+7FeH
 lWSYXaEk3FeQwEanSBHA3FPQScEbHx
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

FEAT_FPMR provides a new generally accessible architectural register FPMR.
This is only accessible to EL0 and EL1 when HCRX_EL2.EnFPM is set to 1,
do this when the host is running. The guest part will be done along with
context switching the new register and exposing it via guest management.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 1095c6647e96..ef033c6c745c 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -103,7 +103,7 @@
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 #define HCRX_GUEST_FLAGS (HCRX_EL2_SMPME | HCRX_EL2_TCR2En)
-#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
+#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_RES1		((1U << 31) | (1 << 23))

-- 
2.30.2

