Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CEE450877
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhKOPe3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:34:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236682AbhKOPdk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:33:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65EFB63236;
        Mon, 15 Nov 2021 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990214;
        bh=TMip3u/Q/XCtOvE5SwU4TNF3b2fGyeSOVzwfivsGdlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAO4rO0zFHHJN7QfHkFHFpNE6hU4b6QyYgl60VNsrdGCwasN9K3LnPn9XaADF48Xb
         Va9YgMAUdpwkYI+TZc6t1NFhkznoBVTPVgzv1cBTNzMVN6hoMdWZPlajyAR6Q9KkSv
         w9DkWBKWXG3Ho5Ok+CM/VyhnZdOjyXWr8u/bfM+fd9jb9WPwj0fvcyRBTdhWkvh7r5
         3sw/EX/MOmpREx+w64ji+8dIZcOoY9YoL+nhc9J8rpWY75reXZE9qnA7enoQbvwYMg
         6Aw/kCPinS91AT1MV0JYh6OLdjdpVbKM8Px+3L433xecPd1hpfMqC8JmR5ucid+PJi
         OdPHscErZvuqA==
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
Subject: [PATCH v6 28/37] arm64/sme: Provide Kconfig for SME
Date:   Mon, 15 Nov 2021 15:28:26 +0000
Message-Id: <20211115152835.3212149-29-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; h=from:subject; bh=TMip3u/Q/XCtOvE5SwU4TNF3b2fGyeSOVzwfivsGdlo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyaKdl7VTDf8YoM1bMRWgMic3HucvsRQjUJYNTR hQVoYumJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8mgAKCRAk1otyXVSH0N/rB/ sHBPnsc5phw9N+gq1257db5NAs/V0VeLgpvEg59C9QlgWcJMZPXBkA2F9mnowd56+vQfkZwjltvsPM PVPsFa//p9OKX8tsAJushGL19e10K8qrdAfxvQ5FoEPbJajYgAL+Ksu/ZcQOsoqigyE8V8w6Bzuuib zP9AjA6BR9rdTEz+RlmRWJCgPe+ZpvCqaAweAIwuONtrDbp1kRlgBjEzyVBVgYiOrHGeCqKqc9w3Z+ BB7q+lxvXtDnWBCe3dGnT8B1BLysAtjcTz54dUvQ2PW8ASWeFIDmm16hHJtOh8wUBAqfUtrSPHcNYm IrF18amjEQX03Ao7EdcElu8CY8n9u9
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

