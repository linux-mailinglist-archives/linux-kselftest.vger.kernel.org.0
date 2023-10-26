Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA917D82E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbjJZMqk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJZMqh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:46:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED710E;
        Thu, 26 Oct 2023 05:46:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DB8C433CB;
        Thu, 26 Oct 2023 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324395;
        bh=/SsV17JjmcJWXgvKkTqZRVD5akWZYypymBxevZPCiMY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=umjzpE0Q326WUy10ZFOmuReuhYw1cyUt4vgtO8lcUDs5aYU2q/rSCwg9DZAs10iB8
         oHTeWWJnjgfaRhIsG9e2hOXgwtAMti8BNyCGQEj+oJ52+jwDdZBjFz+jqALq2ysH5Y
         gz7R8uFemtjyyBP/67rI21xNAgmYJrkN9tb7F78wrwFYKliZRX+t1TZR3z6u8M5zkM
         jCP3EQXelzKKzg2W/J3lHdOCjsdN+7UPY5/axMx2nl8duuHF+l2a7BMjSiihKtdpaF
         LyM5j6P6fyHKDZ1QFe+c3MoiBvXsRCrQlWny5r8L1qBeiDI7JNtFvm6N5XW8IUCuLD
         RVZNgm9f61xAQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:15 +0100
Subject: [PATCH 01/21] arm64/sysreg: Add definition for ID_AA64PFR2_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-1-8470dd989bb2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/SsV17JjmcJWXgvKkTqZRVD5akWZYypymBxevZPCiMY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+Uv5s65NqMFKzwXuON3ueWSkSrMRqWmMnlFvHq
 9F/xllWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpflAAKCRAk1otyXVSH0NGDB/
 0fcICQjJwsx5FdjSkdG3BPMzhGWFeXQUR7esZohLu9g6mefV8buYsAc1nCdzY59PRYQ7AgT47jCZjw
 55uFH0adbIlwDlFnDr01UXxFtslG16AMMLkfNaVCvpq+1MeE9ck2RroMKWVxWjT2Jkla6+aB6nHfpa
 gooqN0BEwpJ7QN7xBqhHOg4ibBWuGKImIhSLtDlCekkXRBAMkPq59BZAZ5h6yeQJMUwS2OWY9Eh/DL
 5RsIOfiIg138jFiyLuNAmBVQ39/KX4ZV3GeMhxX0TZ099ejdrzFQ+LsDwVz+kEcQGYxVvuMlZjNwNH
 3chUCCqwTK85ztKn/byYBMQYuU+Y4n
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

DDI0601 2023-09 defines a new system register ID_AA64PFR2_EL1 which
enumerates FPMR and some new MTE features. Add a definition of this
register.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 76ce150e7347..0ea93d166f48 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1002,6 +1002,27 @@ UnsignedEnum	3:0	BT
 EndEnum
 EndSysreg
 
+Sysreg	ID_AA64PFR2_EL1	3	0	0	4	2
+Res0	63:36
+UnsignedEnum	35:32	FPMR
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	31:12
+UnsignedEnum	11:8	MTEFAR
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	MTESTOREONLY
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	3:0	MTEPERM
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64ZFR0_EL1	3	0	0	4	4
 Res0	63:60
 UnsignedEnum	59:56	F64MM

-- 
2.30.2

