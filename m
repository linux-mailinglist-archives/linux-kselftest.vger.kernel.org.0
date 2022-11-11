Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30776263D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiKKVv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKKVvJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1476B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69236B82802
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7253BC433D7;
        Fri, 11 Nov 2022 21:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203466;
        bh=YKInprl0Z/WdYYYPuq/XXVfRQrNbgVz3ey4J2M/3SlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jH8mmHaeACLWnXvq9ZvYeerhcLsoPdgoKJBJ+rzdRrL2uApmKhrWjLszXPX/DbAcx
         R61rvXQZStvi1IfjwyjQ9mUI0YMLObwif9dgBOjlOcG10QvTUm7mKmQkrDlQe2CiWE
         emtn7SRKnkRCVVEu2IFf7cwjOaysTESlK/Mi887RxhDATvkg8iFqNYD6T8QQlcCm1u
         5xQGVQwal+n3sS6QEVDl5hWhIN5hphqUE123fY4v4mP8+3FCkUbNc3ClIIuUAOkqVM
         kQrJw2ys5zjkknDC0NL54ai7h/fY/sy9gs3M+FcKngCZmGR4rhHydvMjzLCWuf805V
         +GEK+Hsf7pKyg==
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
Subject: [PATCH v3 05/21] arm64/esr: Document ISS for ZT0 being disabled
Date:   Fri, 11 Nov 2022 21:50:10 +0000
Message-Id: <20221111215026.813348-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=645; i=broonie@kernel.org; h=from:subject; bh=YKInprl0Z/WdYYYPuq/XXVfRQrNbgVz3ey4J2M/3SlI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsORtC8ef3jGaowJXIFnq+Ms+yKnG+/t2cBH8Ug2 gL1ykRGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DkQAKCRAk1otyXVSH0PPGB/ 9vsqmGGGZ/Y44CxWkuwJYH2gkyWUwn+JQKhacbKQeRIr8ygNpbX6tAJPNP9C3O6U+NltHgul/sqJty SOUHPshpxWWloITYw6Hi7ElYRLWJ4kK5F/ziRhhqSz4jL52LpU+8Ol8df0BLoUZj1VgXJnRa1ZNYmr lNDkJ+OFQHPfBiai4Xx5LPIVGEtC9ccKqYVuHaPIC5iUeVEsufkjP8cOzb2k7gvmFY4r8d1KV4yJyX Ij5VI5fbj/GsqGEYpoMlQAKM8R4n+FN2M4LLdrJxXmuJXXJt7fVlhn0Bwp/0+BEZJ8BPGuFwuzzw1b zPbug30BWq+/AQHLHY0D5xXotGoXZW
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

