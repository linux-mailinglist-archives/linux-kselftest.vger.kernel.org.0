Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB443274C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhJRTNu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232892AbhJRTNt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:13:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1D436128E;
        Mon, 18 Oct 2021 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584298;
        bh=y7oT69szA/urDPs5Mt7jluLl2o6+yXQperP2iUwh3AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3+c1zSscZEkBNRafUUHaOhu5vkyv9DFbHkmj9s2+JEFnDgOoan54R4HRtw0QiIbd
         vc8S93FRNDk50CJe9qXBK3gDNqX3kh3njP7g3eCUh5qhooH6cIyheAObavaPHCAk6y
         0VxkxpGHUfj8ifjVc+L20a8jDWet3Nh+0SItVLwhLqOMyEMvW51N/1qCKQjbu7vaPP
         8jyfBzAVvJfLa95knTg4qLsUARKuEH7xIaCOdaLKDUenSMAa6eG0lMzXg9zg1OE3UI
         iebf6IG309YYhAq2tbihAy5ZmXWAeDZmmscPFH+lrSQVDdTM8+QiVLm4IN7BwOItXr
         3FTGfrIQC/E8w==
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
Subject: [PATCH v2 34/42] arm64/sme: Provide Kconfig for SME
Date:   Mon, 18 Oct 2021 20:08:50 +0100
Message-Id: <20211018190858.2119209-35-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; h=from:subject; bh=y7oT69szA/urDPs5Mt7jluLl2o6+yXQperP2iUwh3AY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcZBQs2ISDFmh4uUajl+uc5MZuWdkPo2w2uOk2bw Dn0TZi6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GQQAKCRAk1otyXVSH0IZ2B/ wLc5fet5rvuk29Ek9t8qdRG9V+iRMyVf2JzGem3gUf5pV1IBFvvf+youR6H8Urvk2RTewGx8j6Xpv3 w7a9l/2P4I1OgGv++jPXvPVllYYq8Mh93JwQe+qS+7mwc+oDIPrf4GoWP249N+JZBGdKfKOr1OZapz qAHtDD6CormjIZ9kqsSDV9OoY4kFHGUbX3Q6xHwirJ+0O94jn4zYNfalXsKjesJY3bUixi1yNyCMEk nGGgH86EXvk04fOquWJe1bae1HFfhvOz5V4RdB6HwYfjKtdW2ZE9Tp7i49lUPCL6/7AyoXHDZGCED/ tnKzS8XkDK2oYqzDb36cKahiH6cqri
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

