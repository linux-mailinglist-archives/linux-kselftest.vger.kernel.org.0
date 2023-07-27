Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8A766036
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 01:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjG0X1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 19:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjG0X1D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 19:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196130CD
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B40E161F7C
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 23:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4194C433CB;
        Thu, 27 Jul 2023 23:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500420;
        bh=jXMPykm8Sa7SRlmo5xtzHOIlSIk5Hq+qJ6dIW9lIji4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gM52nhQMToDrNZbOQX4DUuuR/CzhvuP3nCm0/uSOtAuHCbgUImUxjsue5HeACy+NA
         6G4nByfh3BVo/4HM7b8CEgr72bc9l8B7oFWMmX3H7fcHpf12i7HJwPCTeRlwLt9Oi0
         HXlUSMJr/Lh+KYjwnO82u2aPL5VH/kplEMlS7nTe+7je0oyee8oGDDEh8djNIoqp1p
         rhp8n0vnPkr7IcY06BWpY1R2yFiVVk+TyaSpARzLoKBbqNxgUO+yAttnnePy5RWyiN
         JKNBjlwz0wzwrpslxSm33c8gjaNgVT8Aqq5LbHO9yqHPFVNv9SkF9rjY5uuyr9t6kF
         r7NVgg9ZAUjdg==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 28 Jul 2023 00:26:13 +0100
Subject: [PATCH v4 2/6] tools compiler.h: Add OPTIMIZER_HIDE_VAR()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-arm64-signal-memcpy-fix-v4-2-0c1290db5d46@kernel.org>
References: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
In-Reply-To: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jXMPykm8Sa7SRlmo5xtzHOIlSIk5Hq+qJ6dIW9lIji4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwv063LfMOVtDu/PC70CFOI6dnptcjxsMx0BeCTqD
 G+2FKZKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZML9OgAKCRAk1otyXVSH0BeqB/
 9St4zvcVA9AM5uZQ6iXsgGbrRYpAQ2GF9jDM2QSQZjfgaqcwhNuH8s7zUG1EfjTnUS+fkklj0iISTF
 4s/SVoqGco4pKmKSsQaTx2t72WX1P2klXpJosUBr7AJsmezlqabHHc7vXcwIsHkabcALJqHgQUJ/e9
 6Sw2X36LvFHp4Qua+RzWH96L5GV6nUNcftVPp5Gx1UnIBKJ+2+w1GCoX8scYJXYTjgxQ1T78sVH27n
 P4VSH757Cj82weBwXP5Vsv8Dy5m9zGcFjPbiHANEetNZWoSVZx3uaPP4poqby4sdLk6fsqLBuW/ek9
 YA+RfSx0/GXLhU5yeezLdoBmc81JK2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Port over the definition of OPTIMIZER_HIDE_VAR() so we can use it in
kselftests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/linux/compiler.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 9d36c8ce1fe7..f75cced41d59 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -190,4 +190,10 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #define ___PASTE(a, b) a##b
 #define __PASTE(a, b) ___PASTE(a, b)
 
+#ifndef OPTIMIZER_HIDE_VAR
+/* Make the optimizer believe the variable can be manipulated arbitrarily. */
+#define OPTIMIZER_HIDE_VAR(var)						\
+	__asm__ ("" : "=r" (var) : "0" (var))
+#endif
+
 #endif /* _TOOLS_LINUX_COMPILER_H */

-- 
2.30.2

