Return-Path: <linux-kselftest+bounces-47876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 710C6CD7BB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E9D3068DF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE3283FC5;
	Tue, 23 Dec 2025 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7yyC4qq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AE275870;
	Tue, 23 Dec 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452923; cv=none; b=WqXRBRk26nHRsSl/Bf4oJYojwQDpJr0lPpL+2WQSh3A5HRGYYFCyimfDKS5cNdkxGAW10ZriJlfsVgtn0gsRD26mwR5WK94isRK8zd2GGEpSK43hthpT+7xc7ML1f4qMeSofmdipTI94ZPKv00MO3LwY0odfx8u3U11fbOrg7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452923; c=relaxed/simple;
	bh=UcBGRJk70S1Rv85qJDISL95VGW1CnVltxuNnSLnZae0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCAjFEyhR6UIJyp0iAEvyDWb+ygIfBGLUyX3HYtKln5/rI1K1EZuOMqJFuQi5/p4+5cGi51LZCbAU/qm46lQQur2+81tU5zeQcJPi3mGo2I9r4m8n6xoi3AKlm6VvxVnsOrN0wTgZ3Cdf2AUrVkIueuU3iNclg+EB9aPQ/2uTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7yyC4qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F732C116C6;
	Tue, 23 Dec 2025 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452920;
	bh=UcBGRJk70S1Rv85qJDISL95VGW1CnVltxuNnSLnZae0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E7yyC4qqfA7Z/4QdPyqc7ZrKTGJdfcJg7FhYx0nX+gXWVxuFH++5TPGZzO/caQQfS
	 XpLaLH8tmJPz9Ddfp7pwSc1+xeNTqSTx4p28gRsfnty3yeuvx+Zt0cg/CBU4NkR3TC
	 7gMvAcvzUXVM+NIXZxAerxOFplv/QLMDfTEbqI+8gUq6Cf8orGZ39ZwMk5OMbO5N8Z
	 DQW5VGoVAHRtIOwCs+O1UvDf1bLodi0QHCTWbzl3zvNYLlF1Azmnd553GKsZs+m/IX
	 kZ+Ru92Qgyf5BSZHVqgSOxK1w2kg+3//gUL9SQyB5DTvnu7olYffbXVL3iuv0mpfIR
	 zFExHmJoqy3lQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:00 +0000
Subject: [PATCH v9 06/30] KVM: arm64: Pay attention to FFR parameter in SVE
 save and load
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-6-8be3867cb883@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UcBGRJk70S1Rv85qJDISL95VGW1CnVltxuNnSLnZae0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6HE2lIx24yhrPMc49cAVdCIj5v6Ca+PxFJM
 DBjjjoyPl+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnuhwAKCRAk1otyXVSH
 0Km/B/9mi3IncLDznTqdkw6oHxNbhh/TkoU+szJI5TxJTKBu3cBLsGpmJdyK9E/Hk6ANuJCKcWY
 plu/p0/6f7/RgAPiCSYPu/dlC0s4OQ3XXlOedkB8NxCDFm/xyXGwD8XEiIY6hWF0hgNM/a7szsy
 fSCoTxt13+AZ54LGpyUU3dx583VmGJ2xux79Ozu1oUXf9lpVFvjNFsoxE1XYOF0Sa4gL5aAowdt
 itKE2Fw1RQ7XhGu9ELQ1TXGqyj9DR6zdiASflllMsKVPL2BS6IQDaVUruEi8FPMjqeAyUDlfWfb
 xtBPrZvvOp7Q8rX+rReGQtOmMIEgyeczAaL/tzrHYjHUdEjf
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
2.47.3


