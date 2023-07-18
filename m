Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA337570EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 02:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGRAaC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 20:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGRAaB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 20:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A89E43
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 17:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC556127D
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4734C433D9;
        Tue, 18 Jul 2023 00:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689640199;
        bh=wRRnJwjd9xFCNGY/0Tqpmscr+RMrnGnIgCFrmukZL1s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fNirPgcqr0ah+kdMBVwWRxPBnVTY51yFpbxXmVMGo4Ow/gkTvPRIkts7f69Hk5ngG
         F/xpp6iysIAAvNhg41/4Bovj8jfZ27eypmzzMW5GlUv/NLDO7AG1JDhQGbfGsMlZ5M
         SoKw8ht1r4Sb++IP2N2zeXIRnsRtHM9t+s5EoPiiZMC0B/bCM5aZ0ykWYGUx/Hljjs
         S1mLj6w6mjHPTA8mYqv7jy3uhN3k/VSmHwdGS/e3jFo2Pd9fywLeHdkosL+8ZFxqJN
         MylH9VpNnV36a+AtPN+AmyK7UTQSJnw3bwGIHR5eIyKz+pDpici5nUB+nuYkwNpAhP
         E5F9MWIaxCoWw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Jul 2023 01:28:43 +0100
Subject: [PATCH v2 2/5] platform: Provide stubs for !HAS_IOMEM builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-asoc-topology-kunit-enable-v2-2-0ee11e662b92@kernel.org>
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
In-Reply-To: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wRRnJwjd9xFCNGY/0Tqpmscr+RMrnGnIgCFrmukZL1s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktdz5HH5KULEXbuQ1q25QSGhhphNIcj9NRdlYN
 NgFp+BhFLGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLXc+QAKCRAk1otyXVSH
 0CeGB/0V05WlCqnoWtp17MzhLgPRsjEddQIW26JPMXN0EMFxBus8RjbLsuwVOs88wy5oq/vHLZT
 tgjoOEB8ZFnCOL1zxrbnuuUfFJWqAHFwQcVJHzdwCBSZOD/kElqRLfZJZMu9/Wr47eOiYg6vfra
 4iCi6f6S6a0EHF8LyRgF4NT7Xaom9J8xYoeyLvp5aBiCPMWiGr/M3Q1M9m3Y0gCMjgfvC8j3/k6
 /i8x7HlCwlbIcEAL/kYUnEIeRKSTlGlTcKZJLkfkw4+MYx5v7kVqEIb+5sxNqRv8hNboSSxY+N+
 dwQJ6NaU17fD77ORtRHlV8T9DkDeLxMIfsW5+wrzB5twpsKn
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

The various _ioremap_resource functions are not built when
CONFIG_HAS_IOMEM is disabled but no stubs are provided. Given how
widespread IOMEM usage is in drivers and how rare !IOMEM configurations
are in practical use let's just provide some stubs so users will build
without having to add explicit dependencies on IOMEM.

The most likely use case is builds with UML for KUnit testing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/platform_device.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index b845fd83f429..7a41c72c1959 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -63,6 +63,8 @@ extern struct resource *platform_get_mem_or_io(struct platform_device *,
 extern struct device *
 platform_find_device_by_driver(struct device *start,
 			       const struct device_driver *drv);
+
+#ifdef CONFIG_HAS_IOMEM
 extern void __iomem *
 devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
 				unsigned int index, struct resource **res);
@@ -72,6 +74,32 @@ devm_platform_ioremap_resource(struct platform_device *pdev,
 extern void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name);
+#else
+
+static inline void __iomem *
+devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
+				unsigned int index, struct resource **res)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+
+static inline void __iomem *
+devm_platform_ioremap_resource(struct platform_device *pdev,
+			       unsigned int index)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void __iomem *
+devm_platform_ioremap_resource_byname(struct platform_device *pdev,
+				      const char *name)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+#endif
+
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);

-- 
2.39.2

