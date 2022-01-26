Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE649CD9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiAZPNa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbiAZPN3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:13:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D95C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:13:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB444617B4
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0567C340E6;
        Wed, 26 Jan 2022 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643210008;
        bh=QxDCYADgLO7Ate8OqAbdluQUXHUE34NK/8kXtjiy66A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHtV8VJLvuGbs3WmZsViKNdU5o3APfzD3v1wH73TlEn8/WGXUf3BhVo7Xpcy+X07e
         alTFNfoYZZ7hV61YByc4IazNRcpeinW585zTp9KcJvZ9otLmWM7h8bYJtel7bOUdvK
         K0x392mH+wjsQVI/UR0gLNLZB7hodOTb4H5sXuPw/wPpm1k6fKoXksbXEwsSACpvot
         W4IFCPJE1R4ptCwm5sscfEXrTdbiP980ndvDefu2iSO7aQuf0W7+/hLHFnOyglVCc7
         IJet6YCxtNp0KhwfJwF9ZQu5YObj+PMHU+3Z4ff5kF6dcfdljEh2Du/FRshHnbANN1
         QZ0YMFcr9DNYg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v9 28/40] arm64/sme: Provide Kconfig for SME
Date:   Wed, 26 Jan 2022 15:11:08 +0000
Message-Id: <20220126151120.3811248-29-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; h=from:subject; bh=QxDCYADgLO7Ate8OqAbdluQUXHUE34NK/8kXtjiy66A=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WSMO5EXNCblah8mNd3crJRe3Ue7ZJ3oWFjj+/Wo dCuJNvuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkjAAKCRAk1otyXVSH0JqyB/ 0QTisbTvOcPNbemLX9/+A5acoUoqosDxXpmP+/QRizvr7vIQO/vILQS2jbt/6YdX4WQHnesEwRKpfR Ow+7cQgQPnEht6HgTXwQKEpUZ+hxEZLyMsUho51y+i9giTQYNWkbe4qpZLd4oRnNaxkY0CP+a/YCgg 81ETu0W84H7FDqxaeAFKQrY+BmCB2eiA2jR0qe4Z5/iVzR9My9xEsO4mPuTAdkP28mMqMRvlBpQt7F YvW+TXcIh/b5z/niRxjBIyBHPvpKsGV2ER4XsZ5EPk7gUazv+vVEvThGRjkgeaIL8ECtOI3KWx2Dtx DDpCIWHu4J3aaWTlstWKrVKXC8gUYZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that basline support for the Scalable Matrix Extension (SME) is present
introduce the Kconfig option allowing it to be built. While the feature
registers don't impose a strong requirement for a system with SME to
support SVE at runtime the support for streaming mode SVE is mostly
shared with normal SVE so depend on SVE.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6978140edfa4..f60f3b04ddf5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1839,6 +1839,17 @@ config ARM64_SVE
 	  booting the kernel.  If unsure and you are not observing these
 	  symptoms, you should assume that it is safe to say Y.
 
+config ARM64_SME
+	bool "ARM Scalable Matrix Extension support"
+	default y
+	depends on ARM64_SVE
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

