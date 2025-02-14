Return-Path: <linux-kselftest+bounces-26607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B8EA35407
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C875416C689
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8D130A54;
	Fri, 14 Feb 2025 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIwiYkpb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9312B17C;
	Fri, 14 Feb 2025 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498471; cv=none; b=kW1+gLI6dlkvx/2AIb3VbizVjufQvi20rIOkam0iTggqvUvAhtDEPjI9uI7I0bFoprvRcgbtd6/2FN6naWlYy4PelcOWq0ZEwvgwJ3qLpwLciiJZxf1Ya1jhLrxo9Ai7h4vuWeEzbL/cXHzZFDTDP73SLTeWC/datmfnNWuMwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498471; c=relaxed/simple;
	bh=XKkgc2ILOcIk5OZtippiLeHcza1bJLfSqPNREumRZo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dus1GjujjYDrdhH5Dv5OzuuA6TmUFkQnsjPx5WspaoZMuo1Y3Xjz5jHwWFzxAVhoUp4NktNjx+tL9Cas+De25a53ThjmoCv+xsO7OSiM6dutqvyfl71OTBAX7FiuNTgpkO1e+31SNcS1mOSSHFTs/y0qMcG5Zq1cYD4xzG/2Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIwiYkpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D08C4CEEB;
	Fri, 14 Feb 2025 02:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498471;
	bh=XKkgc2ILOcIk5OZtippiLeHcza1bJLfSqPNREumRZo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TIwiYkpbfwwAR8616SkmJGruf5XyQrNCGdKxu/NIsJDAEVgvK+gPhTrL2dsmJig0+
	 uhJb7W4STeUohsGvPAGGbSfP8U7Mn38w+hDl9N6xDa27kGl2Qtgt19hhNQNuDj/bAR
	 T9NmyYhqPX06nmRJiWSrmbU+JgB9HzbaB4K/dIE8XI7GlFbWT8pbi8fZ+6cn4UyZAI
	 IOsiqMvdPmVYTXHdM/dbtKyb1ZPYcT5X8Brlf8mNtNisCHrztHBh4bk3I8emn73ACf
	 hgRjQJe0eZpgrg7krEs4ww1YKO1Absj+KZo8xs94kDx9Nk0dQY0wUGVdj4WZzqE1Vh
	 LwMd+f1PSkgXg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:46 +0000
Subject: [PATCH v4 03/27] arm64/fpsimd: Check enable bit for FA64 when
 saving EFI state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-3-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XKkgc2ILOcIk5OZtippiLeHcza1bJLfSqPNREumRZo0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPCoUhVMtJEjvpA+QPVPDAXTGF2POU//l0shFXR
 9FqDoS2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jwgAKCRAk1otyXVSH0CQ1B/
 9AR+Gl+YtCX69mA6Ju8BvQmrPUol5Kqjmozm7grMCtnUYXnpKGXCfXTtFTOD+0KPTWtOuz7rbTMgPM
 PDbxzQn0WY8n2twP/Vqr8ZGlP35ntN8jLUQILxqHpXpvEeqVHPTlYYYnJgI7Fogyt6ACXZ0qlShy36
 RDrsSyPT9joYNzzuPyoEl+LpLUqZZE+VleDeRcclR5c6gQl/UbG7aTAZv2Wr8UYoBVrg9mrHF2WDDv
 XYDcLzJlwMyJybV2A7rAD9gNxjJpmBWBT+Hes9LVAVx6wpH2KBZdMbf85qP0ZPdnuC2t4OL7ZwrL9U
 1WHaTwS4MLi/SKd9EOMvaYhLR7r+LR
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
index 446a379d87539bb37a9d4eb7466a73d8819afc56..a97af9daea472cc57bafc0564fdfe4e327924db1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1955,6 +1955,11 @@ static DEFINE_PER_CPU(bool, efi_sm_state);
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
@@ -1989,7 +1994,7 @@ void __efi_fpsimd_begin(void)
 				 * Unless we have FA64 FFR does not
 				 * exist in streaming mode.
 				 */
-				if (!system_supports_fa64())
+				if (!fa64_enabled())
 					ffr = !(svcr & SVCR_SM_MASK);
 			}
 
@@ -2040,7 +2045,7 @@ void __efi_fpsimd_end(void)
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


