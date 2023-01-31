Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86366839BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 23:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAaW4z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 17:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaW4y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 17:56:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF626AF
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:56:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B18A61743
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 22:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078A0C4339E;
        Tue, 31 Jan 2023 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675205812;
        bh=NOhvDhCN7uOA9tKbnAmGofUYUWi9IqtE+mHDLpY5sxE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RuphEXQHw9LgnFPPRytT/f65Yayrm8j3/j+lTTvUUCVl67YXytbAv+QtmluTill0u
         hsvggWfIu2fGOCaaAUqt198yV95o5wLAQV5yiyFA1MjmGD80zp+PztY0P9Ta0NuDvF
         RyJWEc06C+CPae1MpT99lKugaIWFfVpdDn4ekK2lWO8FLjdHzpnngZCKm/8rlpm/k/
         /ms9ZXSYA3na9y/6KLHvWPttIjA4lRH1MACa5AeyOTGKO+9OUz77z9ZWHGNCyLHCH8
         ryjCkadV0H9kgSHB6BemictRk5zaKfQH06zVVDwdhQuFLgUt+NxT7OWw0J1bzqIiGJ
         TEU3A+NZmPqZQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:56:34 +0000
Subject: [PATCH 1/2] kselftest/arm64: Fix enumeration of systems without
 128 bit SME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230131-arm64-kselftest-sig-sme-no-128-v1-1-d47c13dc8e1e@kernel.org>
References: <20230131-arm64-kselftest-sig-sme-no-128-v1-0-d47c13dc8e1e@kernel.org>
In-Reply-To: <20230131-arm64-kselftest-sig-sme-no-128-v1-0-d47c13dc8e1e@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NOhvDhCN7uOA9tKbnAmGofUYUWi9IqtE+mHDLpY5sxE=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhuSbc9b359l+t02fVfE20FF89t5Vt0JXRx5iCjef/HX3Ve77
 smtOdzIaszAwcjHIiimyrH2WsSo9XGLr/EfzX8EMYmUCmcLAxSkAE/lfwf6b/YHflNzpfaEPuo2/Cf
 Npee5qfvKiWfbysrtqBybdsp0cc6GIzWexm2tRlyz/q31Covt9eI4olJW7GGtEB5e+YfuZ8fO6WcUL
 rqqLEn4V828tiIu98mZu6NrvmfJ/O98pSK8unrHcx1tx3s7ZBULC3uz9ZnIOPZoR7MFfT4eLqa8tt+
 uTeaNeusY85OP1LRm3+Gu3XGTtu+Msdoq3MaVMdIHfXo525oKn/u7JRqJWi50tIrNjZnFHbgzQn51Z
 bLnXz+/5RTU1iU/1H31XvxZhSZop0jd9xUmt2K0P0tZM+hgW37Tr6sNtoocuOcc/k3SZVv8zX3Kumm
 VGSKyUGEdH5+RFJUWGXB/tu+OCAA==
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

The current signal handling tests for SME do not account for the fact that
unlike SVE all SME vector lengths are optional so we can't guarantee that
we will encounter the minimum possible VL, they will hang enumerating VLs
on such systems. Abort enumeration when we find the lowest VL.

Fixes: 4963aeb35a9e ("kselftest/arm64: signal: Add SME signal handling tests")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c | 4 ++++
 tools/testing/selftests/arm64/signal/testcases/za_regs.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
index cd738265cdcd..00bbdc9a6269 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -34,6 +34,10 @@ static bool sme_get_vls(struct tdescr *td)
 
 		vl &= PR_SME_VL_LEN_MASK;
 
+		/* Did we find the lowest supported VL? */
+		if (vq < sve_vq_from_vl(vl))
+			break;
+
 		/* Skip missing VLs */
 		vq = sve_vq_from_vl(vl);
 
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index ea45acb115d5..174ad6656696 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -34,6 +34,10 @@ static bool sme_get_vls(struct tdescr *td)
 
 		vl &= PR_SME_VL_LEN_MASK;
 
+		/* Did we find the lowest supported VL? */
+		if (vq < sve_vq_from_vl(vl))
+			break;
+
 		/* Skip missing VLs */
 		vq = sve_vq_from_vl(vl);
 

-- 
2.30.2

