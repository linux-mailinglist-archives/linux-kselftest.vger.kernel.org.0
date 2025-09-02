Return-Path: <linux-kselftest+bounces-40564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB270B3FE1C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A833AD0CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B662FC009;
	Tue,  2 Sep 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1ovcLNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1E2F8BF1;
	Tue,  2 Sep 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813478; cv=none; b=t9ryoSyGLdwhQqUxiPEmPcTmIMLuAyVp+OUH8cMvsLavRIrrTTAjJ8wJx2AL+3gfQ9Hyfq3ReKc9vXjZDYyHsCX1q12IjXkSR61M1Ux8krxIfIU4FTYYxNbHBmQLlBvIXaibz5jYGiVO447KjbdSIEbwN9skfIupOxvp5G6wZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813478; c=relaxed/simple;
	bh=Rg1wsJ3gpmGTtJKL2YMiJAj+B1RPC9bu8N2e6PnFCu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+JXp97fhFw2wY0u281dmihpvSP2TBbQ0ofa0NlkY2ObOHDv8NwFdxqYXspcT6Gp2ZXdvKSXxv8QKN04yCpNzBeyj2QnbbIelW3hyCS5loNuyPFTdrDl/ctY6ke6hmuUm1t/1BDaWxJIQ46O6zcht6Nj6fOaaIRWOP4k9rOW8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1ovcLNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1E8C4CEF7;
	Tue,  2 Sep 2025 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813478;
	bh=Rg1wsJ3gpmGTtJKL2YMiJAj+B1RPC9bu8N2e6PnFCu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r1ovcLNfwVDXL+bXxzf5PSa1rUsPdW+5HC0nyoDrUBhf8Q7fZkimaoas8YJ0nLoEF
	 msIIKeGVrnqVEEx4qvi9IaN5J3huOh9ZMNGzM2EkSGmSEIUa0+aKXesdbNnfhZHkfY
	 5fs723DlvsUqcy4gYffMWWSegvDrEgFpe3XuzbHkCmki4tn2HvOEWBvEiwCk0GEQKz
	 xLv/FCTxT9yI4FEXwaGwF6a27wPBvyx3a6pIWPqZUay5aAPsuehyWZgdqlyoZp9uHz
	 lPkUAQpntbVdlaPWRh1GF0yxr4ywWpbccDEOrm4lpbxExtJARuwicq2tOFrEyYnwfr
	 kyV2hO8I4mUcg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:07 +0100
Subject: [PATCH v8 04/29] arm64/fpsimd: Check enable bit for FA64 when
 saving EFI state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-4-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Rg1wsJ3gpmGTtJKL2YMiJAj+B1RPC9bu8N2e6PnFCu0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotth9vlQp3HEcNB3+1aXZEyLLW8Xg5amiroyT3
 Uc8RlPjvACJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYfQAKCRAk1otyXVSH
 0NlcB/9vVs/g0odZcyA1QsPFpOgkZ8RK1EFUEQuzEG+2XZdcsZ+x/l64QDrBpjtGxfUI9iRdMsf
 6kV6wWYZ8CbZ5en6OkpoKOVbaS0uVoveAvevSmis/ZH2z+63X1rj49SfTIhaXRD/MY/I80AM/y1
 Rx7ZxRWKFZ0cbZyVwLsRjzEq6F3/UzcJkRxQJ0Cpk+QdOKs/JbkcnFN7n2VQXpPgi5p1IQGJwCq
 T8sUEs+3f08NUp94pEr/szprnByKwuh/R7/sXJKl1o4lXX3bD16XA7MYnUWo0vpVD0MYMqyA34T
 LF0fDuJvEgDEsGIhZ1N1z1ttj73BN/Jhf4LnSW5Z1/Wo6x3k
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
index 77f9dfaffe8b..de2897d6208c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1908,6 +1908,11 @@ static bool efi_sm_state;
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
@@ -1940,7 +1945,7 @@ void __efi_fpsimd_begin(void)
 				 * Unless we have FA64 FFR does not
 				 * exist in streaming mode.
 				 */
-				if (!system_supports_fa64())
+				if (!fa64_enabled())
 					ffr = !(svcr & SVCR_SM_MASK);
 			}
 
@@ -1988,7 +1993,7 @@ void __efi_fpsimd_end(void)
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


