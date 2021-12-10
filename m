Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1508470930
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhLJSsi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbhLJSsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:48:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D209C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:45:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 076D6B82959
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5475DC341CC;
        Fri, 10 Dec 2021 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161898;
        bh=TMip3u/Q/XCtOvE5SwU4TNF3b2fGyeSOVzwfivsGdlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTbsTfpb2KpNIXoeBE+j5Hg63qwDjeA7FmXtaMAkKZeOCzRB3LfVq1lUunQ/uWWys
         IWJIDm4YGm1GeEPdxLnr6eDQia/eJVy5thB4J9dRNUXeK3qQwp7JZtEHZebmQbhHIj
         kDYaXcW69wFwOVj7lXCmEzNU6UG+Aj6nbh3gX33rotocWf0cLp4l76Na/TWV0zsUYM
         3ZCn5oUWsr+/DhHyspedY+2gW9lzCORNjB+uqE4UO/7nhGzJPneM48ZcoM61KWXnZs
         EKB9TUYsd3M84YlI/PF/2Eeg84ueUtwJyIcNTfjzQKCDnr+TQpDuWKNEiv3bBVIdcb
         3pSUGwmbgBOuA==
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
Subject: [PATCH v7 28/37] arm64/sme: Provide Kconfig for SME
Date:   Fri, 10 Dec 2021 18:41:24 +0000
Message-Id: <20211210184133.320748-29-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; h=from:subject; bh=TMip3u/Q/XCtOvE5SwU4TNF3b2fGyeSOVzwfivsGdlo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59UKdl7VTDf8YoM1bMRWgMic3HucvsRQjUJYNTR hQVoYumJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfVAAKCRAk1otyXVSH0E4TB/ 9dxImWYi8b/JXXXXeCHSg6Kj3gegV6L91ey0BaYf4wY2R4iPov33PP3uPZjtobi/3Z9Bxr/9q8jVEx 8stcNbyLI5b2RSWBAutBYo52PS+PWTy98FxLIvZD1wd3bMy8n+hyXrH/Zv+5pj43AdsvCTCzDGuLcm ZsewKocUkQ069HaF4+zYm6GMzGHY69u5qi7dsIIH2NebPCy452yyI4NEs98XpfxtQDklG8Ij5EjPSm mt3a0ittKqTKlPj2Ntbzcwzvf3AgSF436l+ZiLNqmSfv4Vx6P9WZ3hCmBf+DVI9Vu0uiBeReyNlhnI vZ6oSiu3OVh73eAJWXSQzT7GEjvLjJ
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
index c4207cf9bb17..486f614638d5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1845,6 +1845,17 @@ config ARM64_SVE
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
2.30.2

