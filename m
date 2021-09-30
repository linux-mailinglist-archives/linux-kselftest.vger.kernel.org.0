Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F141E0DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353373AbhI3SSu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3SSu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72162615A2;
        Thu, 30 Sep 2021 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025827;
        bh=o+RQNAy1dBknJVuUu4SgWKBTSPbnYCQZgTQcMqKt5zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBCOd/jt/ctmLo3z34qfMkigc6vjaPhnt55RDdg2EQ8m0EpW0jOdM515MFJmFKsRK
         mh+TMwgMxGYyecPQJ0mPcxRvWdmLRWiPxhGRKo50kJO6aT5FxvNxGyNDhNn8N8bL2A
         9/adn5nnoxImy1O/UQjUhQIQfYEuNsW5hbLbEllr4b2Ab01JJRNU2zNG2UV9DKnDU6
         vmwTPheOZ6a07btWfb7e9DNmhvc4KJA1t9YoRq7qYEkPQAqDuHzO/5D7nR1B5pkQ1f
         6dilCzNgbceaHh/0Lf4ZRc0ChXC/2pWXxM84m6VcBl1cLn+5fgUHXzatqJBCLmtpAO
         73bIIu581onhA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 31/38] arm64/sme: Provide Kconfig for SME
Date:   Thu, 30 Sep 2021 19:11:37 +0100
Message-Id: <20210930181144.10029-32-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; h=from:subject; bh=o+RQNAy1dBknJVuUu4SgWKBTSPbnYCQZgTQcMqKt5zs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3aeXBpgy3/rVCJD8oZqdJuVm2zVglW7RpamTCH d3Gf7daJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX92gAKCRAk1otyXVSH0DUNB/ 9cd8qL7zAONu2QAyrGTfsbsyUcAOXIR1Vn4EXlNIH4txixBatiFs8yS7zqepkmOnofbakN4am46z53 yL/5kuwcKXi0AGln3z4URXru6NguFly4hcKsPuus/3/gN0NXX3iZafDyEnaZO/WkKOxXmF/3ApjhS/ Ht4c18EcrxRlgRmdbJLG0yGEZeXFTetQtSQjhK4C+6FHHAtXk4f9ilTBe6xG08FvQtUjVAtzFUfGPG b3E6GUi1WtWLGk+//lTv0gZo9Gpr1adaryRTulknUcJm5EtGqA/B9SG7Hhf27sDmVadt8tDl7Rl6xe uAsZTQ94PvpqFmZ9FsJTXWZjiNz+D1
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that basline support for the Scalable Matrix Extension (SME) is present
introduce the Kconfig option allowing it to be built. While there is no
requirement for a system with SME to support SVE at runtime the support for
streaming mode SVE is mostly shared with normal SVE so depend on SVE.

Since there is currently no support for KVM and no handling of either
streaming mode or ZA with KVM the option the feature is marked as being
incompatible with KVM and not enabled by default.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..f7004dd0a1b4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1719,6 +1719,17 @@ config ARM64_SVE
 	  booting the kernel.  If unsure and you are not observing these
 	  symptoms, you should assume that it is safe to say Y.
 
+config ARM64_SME
+	bool "ARM Scalable Matrix Extension support"
+	depends on ARM64_SVE
+	depends on !KVM
+	help
+	  The Scalable Matrix Extension (SME) is an extension to the AArch64
+	  execution state which utilises a substantial subset of the SVE
+	  instruction set, together with the addition of new architectural
+	  register state capable of holding two dimensional matrix tiles to
+	  enable various matrix operations.
+
 config ARM64_MODULE_PLTS
 	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	depends on MODULES
-- 
2.20.1

