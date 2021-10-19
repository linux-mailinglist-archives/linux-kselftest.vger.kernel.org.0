Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD22D433D66
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhJSR1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhJSR1W (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:27:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D1866135F;
        Tue, 19 Oct 2021 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664309;
        bh=y7oT69szA/urDPs5Mt7jluLl2o6+yXQperP2iUwh3AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGeegZaE/DCG7LPVlInnAE6v/yrUhyMpyJ5tAZD5zfVEtSEgbOoB6t+XsrA94DC5k
         sVw2YItqFF7/ro6u1ndXpD+JmRMfn0rNF4FVb+SzVhHSVBLw6pLiPTDxIMMhgFmG5E
         nfcFYa4uMvUusfRpoRvkrGSLTi/3Mpw7FZC4QYOzpJWmdmZxCVMCuHNq3F7G2MkRhK
         3MK92fnkgLcRTSXyFYbhLwa/9lAZ/zI3pGntP92HblVqC8mOyWxPAe3T0CjV37pMMp
         BauC7bNd4tE/ZvnLdRUCTnxvNVfFxcdYcjz4DGXTyfNnguYqghFIddfZG5G1vCTydQ
         SC9gLyTjUk6ww==
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
Subject: [PATCH v3 34/42] arm64/sme: Provide Kconfig for SME
Date:   Tue, 19 Oct 2021 18:22:39 +0100
Message-Id: <20211019172247.3045838-35-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; h=from:subject; bh=y7oT69szA/urDPs5Mt7jluLl2o6+yXQperP2iUwh3AY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7eQs2ISDFmh4uUajl+uc5MZuWdkPo2w2uOk2bw Dn0TZi6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+3gAKCRAk1otyXVSH0EAsB/ 97aJMo9do6yEKKymRWdzqbM9q4Jqy3K5C88Q85LDG/V4E4In2uAMYFFgyFTk6w530OtlM7p5eiXJXk QXSrxC7NzU8C2iRxMi84JWNUatjV6ZErKmdGNJgFx4jRCwweLZmwqLQqB4LxhpvYemy8OCHswPhL6F U8BMRvuYvxuIvpOveWxTlQG6M21uMntAlCw9UXODSgdkmhw+8ubxyAB9bsvav4i1hPdh3+AqXBm9QB 8/htObnUq9zRtx7opKF4i6FbchVjiAIWOEjJJnMYiMbjxsGykRjrHh4ny6ykazo3anXS5+vzjEd+Lm DBQH6qb533Aly2IOQN58bUuYcQVXhZ
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
2.30.2

