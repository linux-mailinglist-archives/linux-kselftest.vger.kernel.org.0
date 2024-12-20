Return-Path: <linux-kselftest+bounces-23670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF69F96EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EC116DE93
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8021CA11;
	Fri, 20 Dec 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+DXmh56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85821A44F;
	Fri, 20 Dec 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713466; cv=none; b=TZveCU0s4zt8sXRBiKsXf03XB/1vcKO+Y35XFAmicPmlnvHHF6n7rlz6OZ1x0BHON17CIluDDRCrbfxo2ycgKYD2F1HQyffVZysBPJhWqnzDhV5/u+UPRTmMBLm5oRGpHHg0CM7jNfd1/zhiXNX85ubtKVl5aW/cVN96AM8v1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713466; c=relaxed/simple;
	bh=a79dWEQuz4lN5+ZR85xtsyqrLMzIRNiH+ZgTGzqkyTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwZaG3TZ7QUj5XueFSjJ+ZqqWvixnsad7DB2l6lSrcJNfjrZz4BjgMliHzp6zo+/4PT2TwTIGmWnAzcEeRXDYwPf/rwXZdV2a3Fs/eDVQhOIXg4724seFJ1YjRTh7QBEiSppQJO4cz3cUDnj83Nb+PEzJt+0kj6/fCcqVq0C7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+DXmh56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158D5C4CED3;
	Fri, 20 Dec 2024 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713465;
	bh=a79dWEQuz4lN5+ZR85xtsyqrLMzIRNiH+ZgTGzqkyTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j+DXmh56L3Btf6+Rvx9v/lj7WF1rd1Mf1XID8Z9kAZ3M+t5+t8gJOxAkz3uNTEm4/
	 elq75KEhDQt8euIshEsiS6gE1x+vWWacdzIGscAXsAGkxRGCO5D8HGFEjlDPQblLrk
	 avtWc3gQBWXU/gf39yUAjPsExinlsxFtLMZ8C4A9brZOdR+hhw6IuT9UtrkzVkmnAU
	 VBx4t8NVEilPraTk/+T6zvMOzRwe/MyqP1v/BLztsNE0itaP3FzTXTcVnC26TVeF9q
	 l3Falxc5SslcFF1e/tx4KinHyAV3FBzGQ66QqAQqfmwWWjDrspDE54tZmuqc7ooynM
	 q1b58utBo7FnQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:28 +0000
Subject: [PATCH RFC v3 03/27] arm64/fpsimd: Check enable bit for FA64 when
 saving EFI state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-3-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a79dWEQuz4lN5+ZR85xtsyqrLMzIRNiH+ZgTGzqkyTk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBW2Hy1qulZq7d1XQX6Oaip9UEsJD/p5OTWqqfR
 SoTdq3yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgVgAKCRAk1otyXVSH0J1/B/
 sEiIHvTFQypVacv8wFQ6IUikCeXXpGO8HJ3ETxw9BOn2LpiB1GMEA3dSd5oYMRAzbciGfQc6HXaKjb
 KUU3+CDXVTd0j1bVkY2+HVgLUrNYO4iKaS9nV0yV0+0+cU1i+A7F8m42z5GpiMMI+/+2LlWKNRo9wB
 uSxHSAbWxSkIJfKei5WM9jDeDU8yXHm2p2FwO+v+z2+R3KODeUZp1JsFjhvTpkCnMOYZwTmhN7ZZ2k
 v2hprIvZlNsDYT6zFrC31afAfa8iUKZqY8Lo/hX+zbxHRUIq7cDWuYXg2HFe5JFcrClWkb0rrwYV8d
 HgU+PccmqKURz+Egk40B3ty57FkAAx
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
index 7c66ed6e43c34d1b5e1cc00595c12244d13d3d0d..a6f9a102fadb0547b4988cb5b0c239ca90a262a0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1980,6 +1980,11 @@ static DEFINE_PER_CPU(bool, efi_sm_state);
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
@@ -2014,7 +2019,7 @@ void __efi_fpsimd_begin(void)
 				 * Unless we have FA64 FFR does not
 				 * exist in streaming mode.
 				 */
-				if (!system_supports_fa64())
+				if (!fa64_enabled())
 					ffr = !(svcr & SVCR_SM_MASK);
 			}
 
@@ -2065,7 +2070,7 @@ void __efi_fpsimd_end(void)
 					 * Unless we have FA64 FFR does not
 					 * exist in streaming mode.
 					 */
-					if (!system_supports_fa64())
+					if (!fa64_enabled())
 						ffr = false;
 				}
 			}

-- 
2.39.5


