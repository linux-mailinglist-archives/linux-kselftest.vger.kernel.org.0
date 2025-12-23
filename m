Return-Path: <linux-kselftest+bounces-47874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 649C1CD7C91
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5490330FDA87
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D52737EB;
	Tue, 23 Dec 2025 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCRgEV4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C52580FB;
	Tue, 23 Dec 2025 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452912; cv=none; b=Uoo2q3WWIQf1o3gpTMX57wQwfviHLKGCLPYyrIAHTe2BfSYatZsbx5cnv1PSDLi2KW7MzOAXjUUJGP+YmdpfhW5qjaGeIbvIxZ9jlW6mg/bzD2+1FFdTmoDPqclPFYX5oKM0oLzHhbwVj6RgAWZG623tN8BDg8oF01rxzC1RwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452912; c=relaxed/simple;
	bh=wS/Sr3h3O9OGRzttKyfjnEZ56/U90EAT24zyvgc9Crs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qeLly3uwPQoxwFmJL/lGebNxuPc4a2D054mNjiJh62zkC2UoD4k5k2SKlvQIzvUlJsc3TJRq6UBnYcHOLCF8XmEHzJZ9dYqusUZLFzxWKcAZd3fycPC9xl2A1Hr574b0dYZc41nJCa4JAYt4TgB8Obgqi34wdqqZTLYuktNppzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCRgEV4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275FDC19422;
	Tue, 23 Dec 2025 01:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452912;
	bh=wS/Sr3h3O9OGRzttKyfjnEZ56/U90EAT24zyvgc9Crs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NCRgEV4Kpsov+E9xvN2oqiENZrZmI3cK1QfAEGgL+6TEdEaBRQ+TkqvIlNkmt0tMY
	 M4pFTGj4mkpfXqyEEmGM3vZt87+ZXH4YJK78gh1Vfhh1mAu1Q10GeOEXQHoV8+2YZg
	 sxJfXBikOufoBdkliAIb4aueDqZ3Ca5A1HM4OT0opWQieykAM3gtVQ4sQOjLFhcVZx
	 uPW/Rqh/USCV/wi7OaDPbm0vmA8DzbLzp/QJ4mLnlysI86abk2NMsBcMG0dQ3xJI+W
	 PITJ6HsijJbh0QLe/hwLWKWLQyeZpy1l5gfg2zDoD3Fatc+K5AEPWfnuAowM4AVvYU
	 JULYuYvv9MeSw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:20:58 +0000
Subject: [PATCH v9 04/30] arm64/fpsimd: Check enable bit for FA64 when
 saving EFI state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-4-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wS/Sr3h3O9OGRzttKyfjnEZ56/U90EAT24zyvgc9Crs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6FOp/yeFdQmWsIDTjuHRv8lf47vDI2UyZQS
 cSy5dLq5y+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnuhQAKCRAk1otyXVSH
 0FcjB/9jxj9yHS7RtIqKmD88+ux1RuhFty0fPQPxGsOatiYtfDitIClUYiqlQe5PczTHfVw8vw0
 fEldJX5Zh5i77R8pJL4zR2DJ6LSqoWkxYToLw8aAw2nrhlSAWNsdGBOIRzb6YKgkzCsfr37KC1c
 ELgf+8Fitx4EJcFcUwPObrAWPiC7C0gMdHZob6hrtLeH1xZSDZhMoJUk0eo5jDIob/nzvG1G3Sa
 rOvHSqywKra3AIdZQJc0P6OsyrEGzptWIr03M5+tLzNBCkknJ8IDDf/ijO6tvgTWpim6574o0em
 cks9cs0ZBC42gOiUFnMZMa7WG3dn6eVmIOS4H4Lfk/zaUClB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently when deciding if we need to save FFR when in streaming mode prior
to EFI calls we check if FA64 is supported by the system. Since KVM guest
support will mean that FA64 might be enabled and disabled at runtime switch
to checking if traps for FA64 are enabled in SMCR_EL1 instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 887fce177c92..f4e8cee00198 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1948,6 +1948,11 @@ static bool efi_sm_state;
  * either doing something wrong or you need to propose some refactoring.
  */
 
+static bool fa64_enabled(void)
+{
+	return read_sysreg_s(SYS_SMCR_EL1) & SMCR_ELx_FA64;
+}
+
 /*
  * __efi_fpsimd_begin(): prepare FPSIMD for making an EFI runtime services call
  */
@@ -1980,7 +1985,7 @@ void __efi_fpsimd_begin(void)
 				 * Unless we have FA64 FFR does not
 				 * exist in streaming mode.
 				 */
-				if (!system_supports_fa64())
+				if (!fa64_enabled())
 					ffr = !(svcr & SVCR_SM_MASK);
 			}
 
@@ -2028,7 +2033,7 @@ void __efi_fpsimd_end(void)
 					 * Unless we have FA64 FFR does not
 					 * exist in streaming mode.
 					 */
-					if (!system_supports_fa64())
+					if (!fa64_enabled())
 						ffr = false;
 				}
 			}

-- 
2.47.3


