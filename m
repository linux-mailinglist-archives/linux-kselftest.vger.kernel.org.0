Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA2A7570EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 02:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGRAaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 20:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGRAaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 20:30:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7921A8
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 17:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83B3561375
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D6FC433CD;
        Tue, 18 Jul 2023 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689640208;
        bh=JAzoOFG/Nu8slUNucj7uOz4cfFujARjvN2vXgzUIK1A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YvQqEprQqVyhFnp8+OUXg8pRCxeC3vbWvTgFQQNCproWiJCdMA1DDRIsSKz2TkAaw
         cVBDdOw7VHIHK6zpdW38XrTD19lh8KooRc4CDnfATXrw37yoL7kwklK4PvrvYLObxa
         zNAvVTnLLKIMcQhWUjgAxF3ZUvf9m8wGcdO30+RnEv7YKT6s7Su2o1BCMJq8v0xPTC
         DsBdd/LS5VIPJfzHR6u+q6qXEcsfB++icmKKpryicPS3fCCeSGSW77LIvc8S2WREtC
         /TMcpVvDgJ1PpkbBr0XetNnoArXBrZc4RRkunkV2LbN5CIkmYP+uGt+FqQoAuq6taS
         x3CicQ841H9lA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Jul 2023 01:28:46 +0100
Subject: [PATCH v2 5/5] ASoC: topology: Add explicit build option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-asoc-topology-kunit-enable-v2-5-0ee11e662b92@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JAzoOFG/Nu8slUNucj7uOz4cfFujARjvN2vXgzUIK1A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktdz89eZeCatJqqik+rdtJuQ3aMTz8rpLjbLzp
 bAzrGqDcOCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLXc/AAKCRAk1otyXVSH
 0DheB/93ie1XMriGLa9EzlZkgGTvUtO7p43OdgwKKPP7V5pc/KvlqZhprG2rZyQzCPEaMfWPp/M
 q5J2PB/o2q0ZSEjWgy38TBC0uet1p/JYDykObACJxtmPEgVrestHy9wbcmdiNF89yybkxChwIsS
 d/CPt2BjwQ7WjAxMFNR+tk3kUs+V5d6n8jeE1MT++rToKx0p9U1kYtnuCHpOZESuDG4h52GQsG6
 xO9KwVRLwzzteUD4bJKYmsJ/zk94AHMS6FiCYgRx9RzxIBLCkApiMkiCXhAZapKf3j9bFs9+SjU
 cynKPWoetBvG7IgiVec6xpuS+bW+jipEV7h1yJIcW6F5gtGP
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

The default KUnit build options are not supposed to enable any
subsystems that were not already enabled but the topology code is a
library which is generally selected by drivers that want to use it.
Since KUnit is frequently run in virtual environments with minimal
driver support this makes it difficult to enable the toplogy tests so
provide an explicit Kconfig option which can be directly enabled when
using KUnit, and also include this in the KUnit all_tests.config.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig                            | 11 +++++++++++
 tools/testing/kunit/configs/all_tests.config |  1 +
 2 files changed, 12 insertions(+)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index bfa9622e1ab1..439fa631c342 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -38,6 +38,17 @@ config SND_SOC_TOPOLOGY
 	bool
 	select SND_DYNAMIC_MINORS
 
+config SND_SOC_TOPOLOGY_BUILD
+	bool "Build topology core"
+	select SND_SOC_TOPOLOGY
+	depends on KUNIT
+	help
+	  This option exists to facilitate running the KUnit tests for
+	  the topology core, KUnit is frequently tested in virtual
+	  environments with minimal drivers enabled but the topology
+	  core is usually selected by drivers.  There is little reason
+	  to enable it if not doing a KUnit build.
+
 config SND_SOC_TOPOLOGY_KUNIT_TEST
 	tristate "KUnit tests for SoC topology"
 	depends on KUNIT
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 13d15bc693fb..b8adb59455ef 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -39,3 +39,4 @@ CONFIG_SECURITY_APPARMOR=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
+CONFIG_SND_SOC_TOPOLOGY_BUILD=y

-- 
2.39.2

