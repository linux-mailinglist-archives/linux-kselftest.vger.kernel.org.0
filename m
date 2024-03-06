Return-Path: <linux-kselftest+bounces-6022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763E8743A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 00:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0263D2827B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB21C6B1;
	Wed,  6 Mar 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqF5P00Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8F1CD29;
	Wed,  6 Mar 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766930; cv=none; b=LhMz55qQuqRbBJHRumaREd0vfy+L5X39CqiYPE0+gq7/LNV63qBpQdZi3vyHF3GooO9nJaAyei53I6NBcRg3hQV54Sv+fMTM6IHzHGtfEaQwIgB5urkvlj5yHEgxexYxULiDFTsJ9FBPzPVxuWFblYc39pOV59A5yp1ZVIFC43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766930; c=relaxed/simple;
	bh=c6+ev3J3g90szEyl4vo/CFRyq/0DlKhjt2evmW0ZfuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WpPt2I4ByRoG82K+SFduwwTHZVvbIuUcyGOx9LQ1liodxQN8jTyBX+8tTYKCP4bGWIKJ12W/p53qiM8/hUQUgrTgADDCrXhheLFB6ri8Y0EmiS3Bi+Ak8rAUANanFjNaBDwjAym3N6zfNcQgK3QUmBcN0sX1zO+XSs8O8a3IkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqF5P00Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E9FC433C7;
	Wed,  6 Mar 2024 23:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766930;
	bh=c6+ev3J3g90szEyl4vo/CFRyq/0DlKhjt2evmW0ZfuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fqF5P00Zl84wdxff5SRIdUrNIJAB/bURXtAmcfywqbI+ewY5jIsFDi1tM5NB25Bgp
	 w3KXUQTh0/ycS/9uqpH+9hBjz+oieKohnSWJsRSaefRpZdN3RSJkWNJkP+CsfV9N6T
	 gy4dOpvmsl6sI3kkkiCJwhb3q5VvXX7DPdI+9maxsjA/cQNdSJr8zCGvoQLX39a08/
	 omLDW2xfGtji6EFuBAiUCzD6iHUejx4mxA9Y79VwG9rcVs4Sa1+0konIQ0jKnsNnP0
	 UbgpGQ348D+uTFF5OeZPEiqnrhfS/+s6DWEBIS/AALtjf3pAtbqiSVHgTONHF9rqsO
	 F+ubq7mLpjsPw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Mar 2024 23:14:47 +0000
Subject: [PATCH v5 2/9] arm64/fpsimd: Enable host kernel access to FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-arm64-2023-dpisa-v5-2-c568edc8ed7f@kernel.org>
References: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
In-Reply-To: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=broonie@kernel.org;
 h=from:subject:message-id; bh=c6+ev3J3g90szEyl4vo/CFRyq/0DlKhjt2evmW0ZfuU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6PkCC5AHfKhJQGl+ou8J/JlNq2bo+cBISB6TRi9u
 P/PvPUyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZej5AgAKCRAk1otyXVSH0BssB/
 48nT736fR2fqoWBaqGdIW3sgSHS7RSXNbSO4nnab6HYjaq1FLWvUetmb3gJe9jUjuwPntNiEknXkYm
 CUUFDBlKQTlR9wh5gg7SMyxFNZOUtN/Q6XU//QssowDxvy95anPw0tToww3dg8LtQLofzdbubO8mxi
 OCJ+CoiyEWp8Tnq19+FpI593q8qyUzhfu7/W2O+Xn8F+vm+L4af7vDVNkanHUBWa9vNVxaONBLKV0L
 JMFHOB3m/apqDrGkN/GVa2F3P5sEF6KrDQxjYJjah3iSF8kxsgxEI5GfmOKUlH/dRwQAa86pzKSDAg
 MWk9PFyLLAXN5TL9etkFp5fSmoTKz4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_FPMR provides a new generally accessible architectural register FPMR.
This is only accessible to EL0 and EL1 when HCRX_EL2.EnFPM is set to 1,
do this when the host is running. The guest part will be done along with
context switching the new register and exposing it via guest management.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 3c6f8ba1e479..7f45ce9170bb 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -105,7 +105,7 @@
 #define HCRX_GUEST_FLAGS \
 	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
-#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
+#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_DS		(1UL << 32)

-- 
2.30.2


