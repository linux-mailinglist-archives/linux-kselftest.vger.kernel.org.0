Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE326263D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKKVv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKKVu7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:50:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8F76B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:50:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E5F6620FE
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD202C43144;
        Fri, 11 Nov 2022 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203457;
        bh=lOUZCifMHboFbLxwhjZn6C57SVt4x4t69pdgW608bz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rA1x+5+5NafjXgY5aPumtoYoD7XD2LjAW32Szj9NawVgMeWxpPhzm0PHIvP99eZPA
         ynzVgIikLnE4foL2JjtfTts5tLRB6FnzBfvpqfKzlMd+hRtUMOEeDOA/eAMI5UL8kx
         rU4hmBbpOqBTcIc5pal8P9t1lV2MsAP+dO6L0XeCKVT/E2gABnK0ula8iDyuPStbfb
         0g1beYnHeuHNCVUAapvtHCyQXW9enNTI8unZ2oPKKeDYaUaktop3YOTHqhsBmqdz1a
         rBj6TaIEZOv1akywQwhkxNIxv4l0DIQr5spRZYsvHadg+OBPtMwLOzQoW/P5cXdz3p
         DtP3WfUJWyXAw==
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
Subject: [PATCH v3 02/21] arm64: Document boot requirements for SME 2
Date:   Fri, 11 Nov 2022 21:50:07 +0000
Message-Id: <20221111215026.813348-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=broonie@kernel.org; h=from:subject; bh=lOUZCifMHboFbLxwhjZn6C57SVt4x4t69pdgW608bz0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOOhRbWyFSJabgeEElsZNUpVGjE7rscOYX8SYR2 CgFittyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DjgAKCRAk1otyXVSH0DfNB/ 4kGxuFhHHGtWGp6T6+sd2nf5le37q+BWoBn0T/tx/PdNbuFeFzDKGDNDh3fG2OUqjVh29vdkYTzMpR hsq90eZF+zh8r52sOpTCJrzzwv6P+q9fcYdtQaY00jPrLZZ5LB36OqhwSW6Bw4vPaKC5VdfOmUQhw5 JvDBFX4Wsuo+vtisnguGyf5crmrh6D/NwJJeid1f1/5uq9RjPEnEETS6r8SkNg4++tP41I4YWiVA1Y xemQD1Owsfv1orth1eiT3Sz0b1Y0LBZ4MsJbjg4dBwyKrrvPKVeXxiNO6KzhGGaRPKIu3IbHZI6C6b vEWdq48GmHpqCD1pljSuPiL3v8Khf8
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

SME 2 introduces the new ZT0 register, we require that access to this
reigster is not trapped when we identify that the feature is supported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/booting.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 8c324ad638de..81709132de7b 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -368,6 +368,16 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HCR_EL2.ATA (bit 56) must be initialised to 0b1.
 
+  For CPUs with the Scalable Matrix Extension version 2 (FEAT_SME2):
+
+  - If EL3 is present:
+
+    - SMCR_EL3.EZT0 (bit 30) must be initialised to 0b1.
+
+ - If the kernel is entered at EL1 and EL2 is present:
+
+    - SMCR_EL2.EZT0 (bit 30) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
-- 
2.30.2

