Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B06614CD0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKAOjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKAOjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9892D12AFF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59C06B81DDF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4173C4347C;
        Tue,  1 Nov 2022 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313570;
        bh=nNqQUwIlLlhNTh00NGbkWKb/ZzHhU7JuzVml+Agak8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ooRgAoGkoMAzNXQfsm8pn/4sZFyfCKgPO4DTQ55jzjgnU1aBbi0BelIZOvXp6nV4l
         3st9gG3x/zeH3y1NZc+ASerxZqc0aAgqE89qROvAdpReVxRdqjqHp7htt+Sk3vbrDt
         S72BL1Bz71hZp4AUHUMQo9tHwF4CDlbU3wLjhycLpnMRg/k0StzDYnR+cPDNDffCE7
         +ckQF03mrgzQRM3ur4DbwZKjsl5V2LttqP0bKyRBcW6q95FCfrcOFMd7bRz5amGFOm
         DhzxlO3lDwc6DpH6KijxwmEO1+kUZ/kXTvpKvagAj5eq34sLcLpX7CudR/oFXUsIvD
         0xa8omovETkVw==
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
Subject: [PATCH v2 06/21] arm64/sme: Manually encode ZT0 load and store instructions
Date:   Tue,  1 Nov 2022 14:33:21 +0000
Message-Id: <20221101143336.254445-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=broonie@kernel.org; h=from:subject; bh=nNqQUwIlLlhNTh00NGbkWKb/ZzHhU7JuzVml+Agak8Y=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4vnGSUPdo5XijQQVesN8LP48yDwYn+xoJHDLQF kPqnmJ6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuLwAKCRAk1otyXVSH0Fl/B/ 0faWBNOtatH8YELdjihsu7sT35RTc8WK8xytQPNTGIP2yRyOEoe/0hYGJlAj/K2HT1JjEpKw6yIXTU JtYPf0uTKrUYWNiWM7h8pAzfAryj2Z5caT5iqowMMBiQaC4Cad9FIvQ+au4WmFuAb3LtEawUPGA3mV h9u5UhIObQaVrpDv4Z1q6DU3eart15pSIe/LudZ+zkL/M/DR3Z0BSzi5kW9B0If9Xnu6ERGYalvsHo wyhyXAzIzOtWkihtAGUtMMK+LRgcPHMV0wW1sAFyTTro+G3piKVkjlYAAx1+tkGA/eOLk6AwpLsDdM 3El/1hOcUvgGmxXA/cYlvZE4FAOMd9
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

