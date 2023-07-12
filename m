Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742EE7511CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 22:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGLUX0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGLUX0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 16:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5B1FF5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 13:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A041A6190F
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 20:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F65EC433C9;
        Wed, 12 Jul 2023 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689193404;
        bh=dqQ9jv1nuJdvTPcfYD8jgFO3RiNCwkUN231aPtAxRSQ=;
        h=From:Date:Subject:To:Cc:From;
        b=hQ6EY3oCk1M981oy9aLaA55fkITLmLRzx+s4ZDKmObsbClJIYA9oBMRNEJD2wPMYn
         fSPtA7G4o69ZAoBT9kUgC1MI2SucRU//NsEQBkNmPuwwvqj3UCso+nWuwB0MKEUzX2
         2FjCQcq9NpaMDbTdjQCZgdZl0PNw9d5beyfVyTF9UI5tZ70+lA/xlpLxshaW7eufm4
         n0qBo8RE7vYYe/7LKNXhdmK8bTr52l8MjC8JkCTARGs7fDz0/KVuvpmR1MlGnpeK+c
         FSByPPBGfE2aBrUq+fNZwqlE2ZHB4Ekah03VOikg3Uq/YcM95bHnIfZfvCTD3c820w
         JhiDoHGZ9Jy+Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 21:23:17 +0100
Subject: [PATCH] kunit: qemu_configs: Enable all architectural features for
 arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-kunit-arm64-cpu-max-v1-1-4892fe50f40e@kernel.org>
X-B4-Tracking: v=1; b=H4sIALQLr2QC/x3M3QpAQBBA4VfRXJta46+8ilwMZplkaRcpeXeby
 +/inAeCeJUATfKAl0uDbi4iSxMYZnaToI7RQIZyUxvC5XR6IPu1KnDYT1z5xlpy5tIasj1BLHc
 vVu//2nbv+wHq8eefZQAAAA==
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dqQ9jv1nuJdvTPcfYD8jgFO3RiNCwkUN231aPtAxRSQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrwu4JRGViD0UhfjLcLQHgjVQpQLMpIGPf3+fi
 AEImTu4lp6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8LuAAKCRAk1otyXVSH
 0PxjB/9r3KpH/wV1RP6+ezmkRURAKmekPRy1A9hcFy5iMNg+WXyji4qnePIpymlyR0hSbGtW4D+
 cTPrFO3hEqeMILPuZDI4dtU2C8jIyWg+ypFhKMPyZJakO8qefLTwLahqEngUjmsDNWTHIEuKKxy
 r05hLHpABvRLWVIETNO2mdOl/w6qS0Vreca5+5+QPyYkhDz7bB+8FHiOvGZ2CY2z8EmyyEKYUcR
 9XhLVlsjoZ+/qsXDHrFLruA2bXScy9On3r9/q7MKzgAJQ1ekbjS82aA3ZXegVFNFsuWKNvy74j/
 IPL/gwNAAWW3NAJ8UIZqDayLcGW5IB4j9ypNw98Bnd2XoqZN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While it probably doesn't make a huge difference given the current KUnit
coverage we will get the best coverage of arm64 architecture features if
we specify -cpu=max rather than picking a specific CPU, this will include
all architecture features that qemu supports including many which have not
yet made it into physical implementations.

Due to performance issues emulating the architected pointer authentication
algorithm it is recommended to use the implementation defined algorithm
that qemu has instead, this should make no meaningful difference to the
coverage and will run the tests faster.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/kunit/qemu_configs/arm64.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index 67d04064f785..d3ff27024755 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
 			   qemu_arch='aarch64',
 			   kernel_path='arch/arm64/boot/Image.gz',
 			   kernel_command_line='console=ttyAMA0',
-			   extra_qemu_params=['-machine', 'virt', '-cpu', 'cortex-a57'])
+			   extra_qemu_params=['-machine', 'virt', '-cpu', 'max,pauth-impdef=on'])

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230702-kunit-arm64-cpu-max-7e3aa5f02fb2

Best regards,
-- 
Mark Brown <broonie@kernel.org>

