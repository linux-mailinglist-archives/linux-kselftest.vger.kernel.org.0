Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B94A77E8DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbjHPSkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 14:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345597AbjHPSjk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 14:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AF1E6B;
        Wed, 16 Aug 2023 11:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EC5666E41;
        Wed, 16 Aug 2023 18:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A32AC433C7;
        Wed, 16 Aug 2023 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692211178;
        bh=up1w5Znn+PBziovx1/CPAIw5/1OjKjpRYvSpOdENwjQ=;
        h=From:Date:Subject:To:Cc:From;
        b=STqYZE6hdhl6Zd/e930gjmHcm2dBz74wzRK4iwPzHMS+Sh81vYMqhul4Q3auDQjvx
         kxWhXhmSuFvkm+FGdAah1zaJRPuM0Ct2tgi8N0QttnI/qo2gZSMpagKRwoqWXElyBE
         TtINwyY6SXP6I7wjMlWOZp+f9VSeKV74lybQBzhEVeoRpyaCQT+P90bGhNew1Lf6Xy
         jAwdgXm9qvm0aL8Z6SCQVbaumqygp2rcE556KWo4RyUFN3HkWUaBHyJHJf1e+C4wNe
         7CAvGMvz/AAynO2Zi9QILKgIdq0Is25NRc6jJc+qwFz4Uw0C95Tn2+JkrzJ6xBgOyS
         Fk2zgAUiPVVHg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 16 Aug 2023 19:39:32 +0100
Subject: [PATCH] kselftest/arm64: Fix hwcaps selftest build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230816-arm64-fix-crc32-build-v1-1-40165c1290f2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOMX3WQC/x2MWwqAIBAArxL73YKZSHaV6KN0q4VerBSBdPekz
 4GZSRBJmCK0RQKhmyMfe4aqLMAvwz4TcsgMWulaNZXFQTZrcOIHvfha43jxGtAF452ZNFlFkNt
 TKCv/t+vf9wMmu7/CZwAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=up1w5Znn+PBziovx1/CPAIw5/1OjKjpRYvSpOdENwjQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk3RfnsqD0+i8EJTpLQX5aFWIInGKIA3f1/3VYJFXh
 qysJECOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZN0X5wAKCRAk1otyXVSH0PqbCA
 CC2eficgH5AAOZqdop3ShELYYG3vu9k6eG7Wd5jd304qCPrp+b1udmfsMrpGvbIPsfxxb1F5MnWpL/
 n/se3OBmrvE9c5qjTPyoMqP8pQaN6nc4zFG+TvKEP5nfsTp+Cf5eU0ElyK+IbFoe/G4OekB4rYxUFU
 NeXru4tSwv7zvqlhMzzRiDm9Gu5RLbTSN8jLRsING72LJ1XFfXSGvX62loR+zUa6t26HZmkyPARagn
 Kg3BUrXZFzANPoJfsmWyf74/C8l2tGZgErSJNKsDtqkTAumTF7yGZE4/9JJL3yqixPHw/8WOBrPBIo
 9PEaEs12DKljMc89tYB8lO02XiRzDD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The hwcaps selftest currently relies on the assembler being able to
assemble the crc32w instruction but this is not in the base v8.0 so is not
accepted by the standard GCC configurations used by many distributions.
Switch to manually encoding to fix the build.

Fixes: 09d2e95a04ad ("kselftest/arm64: add crc32 feature to hwcap test")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 112b6a219382..3b26a3660292 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -42,7 +42,8 @@ static void atomics_sigill(void)
 
 static void crc32_sigill(void)
 {
-	asm volatile("crc32w w0, w0, w1");
+	/* CRC32W W0, W0, W1 */
+	asm volatile(".inst 0x1ac14800" : : : );
 }
 
 static void cssc_sigill(void)

---
base-commit: 358b763ee64b11f45287c286e1f6145729ed49ab
change-id: 20230816-arm64-fix-crc32-build-9d4c94f2e60e

Best regards,
-- 
Mark Brown <broonie@kernel.org>

