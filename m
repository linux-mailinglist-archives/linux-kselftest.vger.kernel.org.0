Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09C16263D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiKKVva (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiKKVvK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78373769
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA1D62100
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824DDC433D6;
        Fri, 11 Nov 2022 21:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203468;
        bh=nNqQUwIlLlhNTh00NGbkWKb/ZzHhU7JuzVml+Agak8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9mk9NrEPipfUkg5bA67FBxWoKAJGHkll6JxTElFqB9u9oEvGhUqi3KAeY8qJXaIK
         6YBN4gDR1jMb2rvQ35KIIEF8IDfK2vwdGaVyndzhcHqGyv/L6DLKmKjwdiEZRnlmjk
         5UIvkXOn1IzJMPc28kxGVMgNDBDtGEnfjPD/4tilNZiJSYKRZlRvIOkgK1P2xrmG3z
         nEFAk8mRmK8WBWUAFLWRxjmhjnAa3EgHFmypWvlYk8wYcVwFUZPN69yTHzNuo82vfD
         rVlMI0LyRblZr8csUglpVXEfkLsa6GA4J22fEyF6JKvxNetD+pbjA6M3ezWU7CBvyq
         FApQde1jg3big==
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
Subject: [PATCH v3 06/21] arm64/sme: Manually encode ZT0 load and store instructions
Date:   Fri, 11 Nov 2022 21:50:11 +0000
Message-Id: <20221111215026.813348-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=broonie@kernel.org; h=from:subject; bh=nNqQUwIlLlhNTh00NGbkWKb/ZzHhU7JuzVml+Agak8Y=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOSnGSUPdo5XijQQVesN8LP48yDwYn+xoJHDLQF kPqnmJ6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DkgAKCRAk1otyXVSH0ESQB/ 0aROXJzzC+UGWfwuVKJJjnKpVajnZOh5CDeK4OYoUZMMEPuJO3gvFeqT6NJCrAdZ4mEPvxTcC4ovTl kyLsUn1SVAKzSkueZb7wig9cGnn/vrILMVssmMORegveokvQTWqWYr/YsrAeGk9l9aPfkPhN3bM9mG eP2C4ibT279CXA2iNx1nT4GXkx0LVkubgJSwo8fSHJyM9mAnz6tYspxgEnYqFfNc+L85wcOBI2wRVa xeE4jgK9tnWbRxAqf1P3RiwZF8gG/1M6ue2qJybbjwnWd7YxlWD777Y3sNG7TqAQQ6onzcHNUv42Mm yd0RGjOpiTU+TdBlITXO4nh95hOCoI
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

In order to avoid unrealistic toolchain requirements we manually encode the
instructions for loading and storing ZT0.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimdmacros.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 5e0910cf4832..cd03819a3b68 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -220,6 +220,28 @@
 		| ((\offset) & 7)
 .endm
 
+/*
+ * LDR (ZT0)
+ *
+ *	LDR ZT0, nx
+ */
+.macro _ldr_zt nx
+	_check_general_reg \nx
+	.inst	0xe11f8000	\
+		 | (\nx << 5)
+.endm
+
+/*
+ * STR (ZT0)
+ *
+ *	STR ZT0, nx
+ */
+.macro _str_zt nx
+	_check_general_reg \nx
+	.inst	0xe13f8000		\
+		| (\nx << 5)
+.endm
+
 /*
  * Zero the entire ZA array
  *	ZERO ZA
-- 
2.30.2

