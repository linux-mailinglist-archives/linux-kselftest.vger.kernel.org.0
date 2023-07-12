Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41856750CC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjGLPkw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjGLPkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 11:40:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42741989
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 08:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D87D6187A
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 15:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEF1C433B6;
        Wed, 12 Jul 2023 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176449;
        bh=zjgQNRJt1XUpdg7Bhx4u4P1bq8NwhLvKyp3fTanEiyY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CZ5D9Sdwfu9ZqoJ/LYu8HriOln5IMNmUHz/6YmC20LP+oPnaMwty8/emtBbS6hwvE
         j2t3CeVTI7hU71R3l1K3BO0yDh5HX7thtIPRX1z5ICD1zFwRev3LwAaXr0i+sRreP1
         5j3QGeHX5BB0YC6rOfGYiFMXiVqHPuEzdOvnhUsphsEcmwSsZNoL0fq4llV6bKBjsK
         dcPCnJkWtkz0aDmO2mIyr1UQDaRugAf+PX0SgRGcEpLn+GQ55kNJD9aYIdXyGiPWYF
         L7NZDCJ1/+ae4ZyZVVJMUs4h24908pmC4YKmh4fMunIC4Ps09BaCdRDHDR14XAvr2c
         zwiSbOxXNLt6g==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 16:40:35 +0100
Subject: [PATCH 2/2] ASoC: topology: Add explicit build option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-asoc-topology-kunit-enable-v1-2-b9f2da9dca23@kernel.org>
References: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
In-Reply-To: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zjgQNRJt1XUpdg7Bhx4u4P1bq8NwhLvKyp3fTanEiyY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrsl3xmJL5BTeryZ75BFB5e0i9AgK2lJCAkivk
 qP/R7QRI2yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK7JdwAKCRAk1otyXVSH
 0JYsB/4ou0Z9CImBZWr0Ez9ziPcsF/+y/vnFExcwXXU1IsZnAw+0K9e0qQZQr+Dd3OXCYRlgioA
 NR8ahixDmhaApTUWVuEsn2gE+50dpTCWnydz+MVYnh5UBf6M390EOE1opDa0aUxlFic/PHZ/mvt
 TsGumyLM/UsODs36QvXw6Tj/pecV86uvTY7jg6SSC+tqiRRuEnvrIVgKEK02NlC/RRmv+fVuwHV
 sLvdWU+9XWjZ2zg+zSorYazJYteZkpqUay3/tZOR019Z7KLvCXt/EAJ07tOfI3aYdHrAr8URxLD
 umYvw3uptTrTp5aYQSg0FtSNM4PoEbLReDKFHR5Z+HVBQxvj
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

