Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF074FBCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 01:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGKXWC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 19:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGKXWB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 19:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D84EE7A;
        Tue, 11 Jul 2023 16:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19E126163E;
        Tue, 11 Jul 2023 23:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CDFC433C7;
        Tue, 11 Jul 2023 23:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689117719;
        bh=vQ/4FdUHpBmumWCKBTUpKBXwITOJ+uIM73ZXp1cmBn8=;
        h=From:Date:Subject:To:Cc:From;
        b=dOM1gzieroZhHlRsVkSok1ytXauiUv+UAJU/RiccbGv5XoFilqAYUK2tM3FkMJCuD
         5qdzm7t6SsDkjpn4hhWerb5+QP5FguYTfOtUk38EgIJ7R0FPqg7kS66oMRDSBOI/5C
         9N8CjAoey0YDYGCLLrqHGJpteXZmW92VmAfxE3D3Xw/HuZd/2v06ICwzF/bzfG9yzH
         93RrDrzvb42dIVIVntgGakx6/EMEqsfEA242uKdTVw0L887nlVQrui/BQW6aCegexF
         FtHUOR3Fm/bRZSNY1R/5xLeuonM3btKEeCESO2/spNWnP26mdpLO8CLWWse5vbC0LV
         BAV8O+AOM6aeA==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 00:21:52 +0100
Subject: [PATCH] regmap: Provide user selectable option to enable regmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-regmap-kunit-enable-v1-1-13e296bd0204@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA/krWQC/x3MQQqEMBAF0atIr6chUSEyV5FZRPPVRidKoiJI7
 m5w+RZVN0UEQaRvcVPAKVFWn6E/BfWT9SNYXDaVqqyUUZoDxr/deD687AxvuwVsVWN0A2Ocqym
 XW8Ag13ttfyk9W3Xd32UAAAA=
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vQ/4FdUHpBmumWCKBTUpKBXwITOJ+uIM73ZXp1cmBn8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkreQTBvI4v3u5njYjQ9DpJsBF9tFfTI4IadbuR
 bCPGkQE7WyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK3kEwAKCRAk1otyXVSH
 0EMNB/wMOcU4nHjg1HsZAwVtRWvb6xLgfL8JnIvFaet+hHaaCWX+qBMqW0HdDdO5EsFlVNQFXWQ
 myqH25zoWQAej64c59fa+kxajJsbtioWW2svwaN+mRhhQxX5c0s+lNsIhLUX41zzSZobl9sxAE+
 hgsr5JNwQCegWAAENiPq7Jev+r9DYWlMd9bTGxGzmG7fYLMjyR+6VDvqGm3pUR7T7PJir3uuQsd
 HUW/BvSpWrq1JSUPsG1QtWG1G6duAWbxy/Nq5VTOBkJecZ4OSJw6eCSYROD0368qZEjpEDkd7HW
 XtblmFSCaz2CymyVPkzguPov5+XjOnVhXH/k1pxSquT49aIz
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

Since apparently enabling all the KUnit tests shouldn't enable any new
subsystems it is hard to enable the regmap KUnit tests in normal KUnit
testing scenarios that don't enable any drivers.  Add a Kconfig option
to help with this and include it in the KUnit all tests config.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/Kconfig                  | 12 +++++++++++-
 tools/testing/kunit/configs/all_tests.config |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 0db2021f7477..b1affac70d5d 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -4,7 +4,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	bool "Register Map support" if KUNIT_ALL_TESTS
+	bool
 	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO || REGMAP_FSI)
 	select IRQ_DOMAIN if REGMAP_IRQ
 	select MDIO_BUS if REGMAP_MDIO
@@ -23,6 +23,16 @@ config REGMAP_KUNIT
 	default KUNIT_ALL_TESTS
 	select REGMAP_RAM
 
+config REGMAP_BUILD
+	bool "Enable regmap build"
+	depends on KUNIT
+	select REGMAP
+	help
+	  This option exists purely to allow the regmap KUnit tests to
+	  be enabled without having to enable some driver that uses
+	  regmap due to unfortunate issues with how KUnit tests are
+	  normally enabled.
+
 config REGMAP_AC97
 	tristate
 
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 0393940c706a..873f3e06ccad 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -33,5 +33,7 @@ CONFIG_DAMON_PADDR=y
 CONFIG_DEBUG_FS=y
 CONFIG_DAMON_DBGFS=y
 
+CONFIG_REGMAP_BUILD=y
+
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230701-regmap-kunit-enable-a08718e77dd4

Best regards,
-- 
Mark Brown <broonie@kernel.org>

