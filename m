Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A882B436A2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhJUSLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232381AbhJUSLd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:11:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2341061B1B;
        Thu, 21 Oct 2021 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839757;
        bh=y7oT69szA/urDPs5Mt7jluLl2o6+yXQperP2iUwh3AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtBOMHdHD3PYQGPRLPyykfVKI8sXjXhlbBvLzOE+eO+PybGR6DCorKfsSKBdwRWgs
         5fQxGjaqHm+7jOT8o2+/vJaOk9+0b06D3oafKkqHWeOjLzhwDhwQkuPVTPIklJCp88
         UNMazM5TWsMQFjCr0B5uxtjYucTU3DiiTS7J4vp1hnRovqdNsWc/N636dW+QfA/GI1
         fL8jp5nz99DE2BhvJ6byIoSrGkSHjSL9ePUef8Nfeu+q0SYtcM6dAUMOzHFDEzPLwq
         BOiOjEi7JpTT17of1rQLMMBlo0/HDp/aE7k9Aw9SSHMlWC9jvWceDpQk1ONmrY+hUJ
         vr986yAQtVyxw==
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
Subject: [PATCH v4 25/33] arm64/sme: Provide Kconfig for SME
Date:   Thu, 21 Oct 2021 19:07:14 +0100
Message-Id: <20211021180722.3699248-26-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; h=from:subject; bh=y7oT69szA/urDPs5Mt7jluLl2o6+yXQperP2iUwh3AY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxSQs2ISDFmh4uUajl+uc5MZuWdkPo2w2uOk2bw Dn0TZi6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsUgAKCRAk1otyXVSH0OHFB/ 4ttfYp2tMsUaDYkzJaOFdz8xoSkucPqquuhlb4wYDE/4wNtsJfgISEzX4VcmdYh3+0Xokho5n/UyzL bW0QwfuXWpPs8r0YDjR0ROZT9sizqKJsMq1bYXMoDrZ0gfyep+1aYxNdBkgVOY+EurnQuhOCXO/Ef2 1BxznEUvJTzJrnLf4NOvtX64eSieAUKAKARgWBv/jX5RrkCUrgC2kSdn2gg3YEJUhP5ZUAy3jDpY1H SArzwMlWQLkjDycEn7kUk5P6J4sj9xYQh4AErMl2/9KCpr7zcL8x57BERWuGwftYmc0nwaIHtvdJhV oFaPubqEc2Ib1ljqiKO/O6JdI5SL9x
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

