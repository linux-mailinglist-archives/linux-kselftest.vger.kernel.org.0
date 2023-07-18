Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF37570EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 02:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGRA35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 20:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGRA35 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 20:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5520F1A8
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 17:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E13A761365
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E153C433CB;
        Tue, 18 Jul 2023 00:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689640195;
        bh=CrZhbPZ9FwBTokvrtGGOK79L/OJY8CV+5y15IrPndTc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ffFY7WQwV/lqerPI7KGjBkdWpPe8ulAGvEL+wXiFTO16y+pNJ9c8f7GOBNJlmpgVS
         q1L59AjKvKUptn+tpiXZOAIwGOd8k8jXHPVoaVhPKGy8kEFj4cia9cgNUBKWiGDO2z
         BAiMeQtjYsnYltDjmxcygnG0CfiAM56ihDVDIhqNP2f88MzLw/Ak70pMTzBFdxN0Y1
         IRlQ9aeEyNfcFQBSFJ51mNms8lHrHPNY9WdKkn+Fbricq6jamNIRxff5kfNBDIYeWH
         n2CAPOzyEz1351o5EQZ5vr1eU+wC3ZUSuu1ynu49xdpHbrnqq2xjqNf0+r1HrjaqOM
         rgVRgtdH79D7A==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Jul 2023 01:28:42 +0100
Subject: [PATCH v2 1/5] driver core: Provide stubs for !IOMEM builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-asoc-topology-kunit-enable-v2-1-0ee11e662b92@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CrZhbPZ9FwBTokvrtGGOK79L/OJY8CV+5y15IrPndTc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktdz5m2OQFGCRftcMVv/Funt3wXBqKcBsv56oL
 Laitxdvs3yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLXc+QAKCRAk1otyXVSH
 0MefB/99za3fuZtdz0rVH5AeHcPCF7GaJTRkzzIhb5WwHhbT8jCNeBK3G8u+r9F0ahtSfH+YHlN
 1DcaMJ3qZtpnxkYNNO2VzxP9Z0swluuMgWoN5XbfsjVEyJz4xUkPpcK7J9avwS5Qs/xhm8br2YI
 tcTu+Gkv56YKzfd/zcpFwU+ep5lRpZG9k9JV+l7VKUVcvkLjuM05U9HD6b79Jv6Fd/kEQTnhA+k
 FmnRWzn141+lRfXHfXSmHxP8uDsSYB7guASWtRkdW/YAb5IABf8N3kZRC8RmRUpEF7vex++xnEp
 VHZEv8dGY4WNMrykQUZZOSg862WtTXokJI/I8WxJPsWpv54O
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
without having to add explicit dependencies on HAS_IOMEM.

The most likely use case is builds with UML for KUnit testing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/device.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index bbaeabd04b0d..6731d7dc1a2a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -349,6 +349,7 @@ unsigned long devm_get_free_pages(struct device *dev,
 				  gfp_t gfp_mask, unsigned int order);
 void devm_free_pages(struct device *dev, unsigned long addr);
 
+#ifdef CONFIG_HAS_IOMEM
 void __iomem *devm_ioremap_resource(struct device *dev,
 				    const struct resource *res);
 void __iomem *devm_ioremap_resource_wc(struct device *dev,
@@ -357,6 +358,31 @@ void __iomem *devm_ioremap_resource_wc(struct device *dev,
 void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
 			    resource_size_t *size);
+#else
+
+static inline
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline
+void __iomem *devm_ioremap_resource_wc(struct device *dev,
+				       const struct resource *res)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline
+void __iomem *devm_of_iomap(struct device *dev,
+			    struct device_node *node, int index,
+			    resource_size_t *size)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+#endif
 
 /* allows to add/remove a custom action to devres stack */
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);

-- 
2.39.2

