Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E808143D12D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbhJ0Syl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243646AbhJ0Syk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:54:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75C5D610A6;
        Wed, 27 Oct 2021 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360734;
        bh=y7oT69szA/urDPs5Mt7jluLl2o6+yXQperP2iUwh3AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZ+WcDxjhBw/FVEq51+ZXJ9nEN9qKz1oiljxTkCy9MEhOIGw3kZlCQbp3OVHzBvW3
         eia7/kPIBner14pYdVwXhAo9fMtITaQinXFig5Ww55jWpj5mNxoDizQG6nl6iyR5p3
         Wpw/wGSIEbCqp1u2iD1d8hxlr4VEauKmbMuxJyB6o7GnR9vbLmBsdG9kc+6z77N2Z3
         VVvTK6kjtX2/sxgbiGMvC+KK61gA7gk5DL7zMqZ8pf7tSJbAdNecbUIQfK47Wlt4ez
         3kJzujf8vq9rlTD4XiPYxgnO52nM9g8d8gN5lbxrwrx+0+XxjysueqNC+QLzHjMukm
         GXsjQQQoKmGFg==
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
Subject: [PATCH v5 29/38] arm64/sme: Provide Kconfig for SME
Date:   Wed, 27 Oct 2021 19:44:15 +0100
Message-Id: <20211027184424.166237-30-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; h=from:subject; bh=y7oT69szA/urDPs5Mt7jluLl2o6+yXQperP2iUwh3AY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ39Qs2ISDFmh4uUajl+uc5MZuWdkPo2w2uOk2bw Dn0TZi6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd/QAKCRAk1otyXVSH0EPLB/ 9HLYN6W8xNI/Qf9jt4emQxtXDxddKm9CknmCtcxKg0hFJlm/UOqf+sAIYkqLp2m/iKN1tNrfjXw16U 8Pr7xMWBWSH0SsAED4V4mTI21l7e8AgS300J9cmJGnVUzo7w93ZhVQypoVyj2w4OF0uuz6G5nFSEu8 grzi92zSymNQqCr2vDR/N9rygdjhEevntTHJsAs5W2vxd6NaF0ErUApXeXtvo5NITQ9DzboTQSDq14 iNyHHs5GgL/29YyMzZxEOnn8dX9+Yp65dAifi70JPa4HCYB2JweSMPVlfMpEpiSWWftLT8Y9or6CPf gljZ5upPjDRtgCW6t8G0BlzKRepAXu
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

