Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781DD614CCF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKAOja (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKAOj3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766591903C
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 138D3615ED
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1DAC433D7;
        Tue,  1 Nov 2022 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313567;
        bh=YKInprl0Z/WdYYYPuq/XXVfRQrNbgVz3ey4J2M/3SlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EeLJAfh53DSosVOk3rSRQUaUW8ErlZS8bWSDoSKNCe5pbOO40CasCAC4p30+LkEb+
         tL2VtKyvGerDKnxAT82YvY5Nz3Jqaz6zVD5WlxS8TZlZqCr76V/bMT6r/snMpKE7vZ
         iGbUr+tdvZqYWrOe45EU42tUirQaDF0EkmNbrOCcqSUOGRfJZ5pxNa0VPc9QeR8hi6
         fUaPVKygpYQsxI15DGRyNfuzog+kpWYLkn5fimULXa9VlYHkvf/Cb3wtG5MNV0OZD2
         yImuw4jvK7oj1kPA2BOBrj52iK3OmUcUP1zKShHe5iyTdcI3rjuJz3+7Y5mX78JUSt
         8qyydxtrqOyXg==
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
Subject: [PATCH v2 05/21] arm64/esr: Document ISS for ZT0 being disabled
Date:   Tue,  1 Nov 2022 14:33:20 +0000
Message-Id: <20221101143336.254445-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=645; i=broonie@kernel.org; h=from:subject; bh=YKInprl0Z/WdYYYPuq/XXVfRQrNbgVz3ey4J2M/3SlI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4utC8ef3jGaowJXIFnq+Ms+yKnG+/t2cBH8Ug2 gL1ykRGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuLgAKCRAk1otyXVSH0MPsB/ 9d2sFAonITHoPTNFnLA3oKF1bPJvnBWguMQf+1QtZo63o+D0dvqGoHTlzKBs2eqaWlLbFnKNpswith lCo6ac3g5SC0unHTuVmvKOhVsrEkm36rOb+kw7KjLG1RJiR3PduhGmMMQeaFDIoIak7aprq/rSGQ+5 eu49Lct9B96qvtOuF54J54VIlDdxh6VTFwR5DeE8ObZuh3AuaiH7mw9U+rj4lNd+qzw4MaFFKbaMJ8 bGt/yJleV6lED8vSPcZg53w7lGDZuhO4CQnos/JYLUB6CEdcHdRjxLSfLaC+c1VyUGV5Y48aQdec6c 0vVf3K6Vnzg9+redqHqSHEmE8j8JBR
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

SME2 defines a new ISS code for use when trapping acesses to ZT0, add a
definition for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/esr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 15b34fbfca66..5f3271e9d5df 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -341,6 +341,7 @@
 #define ESR_ELx_SME_ISS_ILL		1
 #define ESR_ELx_SME_ISS_SM_DISABLED	2
 #define ESR_ELx_SME_ISS_ZA_DISABLED	3
+#define ESR_ELx_SME_ISS_ZT_DISABLED	4
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
-- 
2.30.2

