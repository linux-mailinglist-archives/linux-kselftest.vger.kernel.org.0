Return-Path: <linux-kselftest+bounces-41320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A114BB54AE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195A95A0B2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7015C301011;
	Fri, 12 Sep 2025 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cuzy0Pok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112E301003;
	Fri, 12 Sep 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676127; cv=none; b=pU7YOo45u7+VehxBEZT21mcUdd3wwGZY4OK0V7J85z05OY9s5RJWEm6J8TRMoksuYTIPuh8GrUqZBq5U+8fP+CjHDu6ut4gijJzpBhwp/qdiskiF4010HjtDYmhGQjmDzuWZDq8UnzDwLMylz8J8cvwTcQnKP4oM1cGe/jm043U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676127; c=relaxed/simple;
	bh=a7v6V+1etb8iiKXRjxUma/LMQuFjf/rSgVqbyq2ZhUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/Wcorl+Ko7tgf9cBOe8DsIUUeJS7wOUBhfATXVfnqwOcl6N8+SXeFeRJmDyUFh5D0krR5+7NOrIjSol2GCH8KmUhRsJL8lmUauGpax4WOqc8EhnARkKnuyrlUNncH4LDs2cpRJ2zX1bxANZB/EVQAX5i25PK6LmiR/DWITAze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cuzy0Pok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A234BC4CEF4;
	Fri, 12 Sep 2025 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757676126;
	bh=a7v6V+1etb8iiKXRjxUma/LMQuFjf/rSgVqbyq2ZhUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cuzy0Pok0pnKc3GOM8TfILUvN3zFNGTU81T85egu9IGbnz9wAD5TY+L8HQX0VDM7j
	 ESRr0Fs1JEsxFppMDmtchO/4boSTPNNYTGzNmkWRZO5qd88yBlFX6pJcbeL6m3XpNW
	 jfNmyncqV8AtfB4pg3LZ4Y8KQoiLXuyfXZEva3SiccJlSn4t+4umlSggt0aRiPsNBU
	 pIaepVEGZ4caj0HdyFB+c4qfibVe3KBZecmA2SrG4O23NsAoanfmMpNpvLTsxI05mF
	 euoVVXdLwF913xFQit2vdVvu1tjOMlV2Gpf4AQTaNzPFqljsMW3ZrlCgTMjtZRJw7C
	 h1WXntA8WOu8A==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 12 Sep 2025 10:25:27 +0100
Subject: [PATCH v16 1/6] arm64/gcs: Ensure FGTs for EL1 GCS instructions
 are disabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm64-gcs-v16-1-6435e5ec37db@kernel.org>
References: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
In-Reply-To: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a7v6V+1etb8iiKXRjxUma/LMQuFjf/rSgVqbyq2ZhUg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoxAJUhkh3JG/R0IYWg4xGHGXuPOIYtANMJtlNz
 GPNwWcl1t6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMQCVAAKCRAk1otyXVSH
 0PtDB/99Zwm9Uj+D9vpqCwCG8A/mNEwCm8ll+dZs/C1WO8VuKkHRz3lQ7BCu/JNDC21jxnMGNX2
 jNsYKkbVoIc1xhbggK84VQ+7733IRrQszs29I/vQML/rFjJCWgULRVDDegp3PxvfsTokwmsszj1
 CWhVkaz8KxJtiFzd00LjQNe1uC7EEjfb7vwQZsjjAfJAZ3i9k0mpCdMsaRfSNVDbcc0NhlKZSW/
 L3o0f7xJmMr05I0Q1Jk9tf5gviEfAepl1WOQIh9wMXPodqfj4I7pn0V96ZBV00G1KI66v4ydpw5
 QMtgL4KrMF9wPxpcZ8vuwC/GHsRdP6FFom4YtRxAPcom4SaN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The initial EL2 setup for GCS did not include disabling of EL1 usage of
GCS instructions, also disable these traps.  This is the first disabling
of instruction traps, use x2 to store the value to be written.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 46033027510c..d174f405c44a 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -353,6 +353,11 @@
 	orr	x0, x0, #HFGRTR_EL2_nGCS_EL1_MASK
 	orr	x0, x0, #HFGRTR_EL2_nGCS_EL0_MASK
 
+	/* Disable traps of GCS instructions at EL1 */
+	orr	x2, x2, #HFGITR_EL2_nGCSEPP_MASK
+	orr	x2, x2, #HFGITR_EL2_nGCSSTR_EL1_MASK
+	orr	x2, x2, #HFGITR_EL2_nGCSPUSHM_EL1_MASK
+
 .Lskip_gce_fgt_\@:
 
 .Lset_fgt_\@:

-- 
2.47.2


