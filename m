Return-Path: <linux-kselftest+bounces-31002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3061A9105D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403B93B3AAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37C61CD1E0;
	Thu, 17 Apr 2025 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdkO4f4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031B1BD03F;
	Thu, 17 Apr 2025 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849567; cv=none; b=mxrBtZqGdb/A8hNYaMcwXc/c9EhdqBtjzZ6QfP8f6vzKQfaPCaqhiV3akP9r0FVewIw9MGSZ8Bn9ajQzzAjf3s/oRavAhuypfI/dYCsFvMH/ieqzrXBBMXabfTny2lqlpiYdz2U8AQsOm8PgSVI6c+8Z8mzOzmkhIWKjP6jvfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849567; c=relaxed/simple;
	bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJOEEz/H/I5apcWTkPCTQpKRMcqEIkWsS2iRDNvuHitqDVbsLTWXWQaQwiOW7nt5nvjtyPLy/d32anfEGZQmALg3DY8YmgRGcgMutgBrspZaBUIwl4MWZmlcrW4c66AD+t67LDgKSOFAfq8/otyc99KRdlZ+Y7LLczDCUUEVuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdkO4f4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1515FC4CEEC;
	Thu, 17 Apr 2025 00:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849567;
	bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MdkO4f4JPRZABY1VGe30ZeGWmuZSaFtFjbPoiZ2JKwQKtrVsYYf+i/22bM/C+txQ3
	 VSO+h2w4M6PFbTJ4jJuGtA7NKmb8GQRy7fxoJvXqI8F5gsZeaih/Epir+BBRnVNxBo
	 Hp6hUzdsIkOFIYJJjEeNVg0Ql1sx2Oy53Ymcnb6a6tGeil1b4Pi1WKRP/FZ4z5qFjp
	 7pPdS6TOxmVCSVTUHyU5tp+Ms+5+l1+metEEhiXl3x0QMVo21vdWGqnJXgEGOtZg0d
	 h1BI2SPu6XavqVmm4LMiapysyCFBTz7B07OxOsVm+98XmHHC0kdhlDlBI4XpxPHEa9
	 dllqrRyHfmcCg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:10 +0100
Subject: [PATCH v5 06/28] KVM: arm64: Pay attention to FFR parameter in SVE
 save and load
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-6-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEpzpbQUMEswprMpZyLy/JHBOf6XVtUUczmdbGV3
 75K2OBWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKcwAKCRAk1otyXVSH0HsWB/
 4sQSXEfCj864idBPTgxT0QVL16QLKlb2tYjFR+g2STcCPnwZtZV1LFwSJbC+OJ0RtkpxlsRUsy5QJJ
 WFPpm0J4Sg7vjD8aAwkFrjupW6IXioTIpwT6iNqrgVv0t5lhHq3QaUTweKPMNmhngcGpVQH7Tv0xKz
 CM3CmFatHvmNWXBNDUCzW3RfToFWgv6sydXRsYGZ4pXT2SPKc37OCJH0gKrmd/5pnCPhIQfFwzhDka
 7wGg10+QjYKhwRxgJFm0McV6OSvvX2EegeLpZ3m8rJqinM817Vh56PEVx8wjGXJot2vVqsPOckFYjU
 MGfk8dfjxwzkIRO5X1aN0LPGTEUO5v
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The hypervisor copies of the SVE save and load functions are prototyped
with third arguments specifying FFR should be accessed but the assembly
functions overwrite whatever is supplied to unconditionally access FFR.
Remove this and use the supplied parameter.

This has no effect currently since FFR is always present for SVE but will
be important for SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/fpsimd.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index e950875e31ce..6e16cbfc5df2 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -21,13 +21,11 @@ SYM_FUNC_START(__fpsimd_restore_state)
 SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
-	mov	x2, #1
 	sve_load 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_restore_state)
 
 SYM_FUNC_START(__sve_save_state)
-	mov	x2, #1
 	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)

-- 
2.39.5


