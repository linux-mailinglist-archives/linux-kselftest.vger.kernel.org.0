Return-Path: <linux-kselftest+bounces-19104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A7199162E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80BD2842F3
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027611537A8;
	Sat,  5 Oct 2024 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF1gD6G0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911C15350B;
	Sat,  5 Oct 2024 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124679; cv=none; b=VBQYjczP43ae+2Nh2+pdHERytF1i9bBOd21qii+GsVNqJa1b+OVzexzImeaDPWGxbCzhYMPx8LkchTRMMMse8JTSNDmm/1ALhukPmRce2hBf06sIyAa29DlHtPf/Mg1SwJbQsOSmqWrA190oxHgF+bKpKjSiWTmddoII0wRWHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124679; c=relaxed/simple;
	bh=1w+V9LlE1J6cc3An9dYnLJVfYeaBJHjSV6dDDI8zsLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KS+RXzCbTykc98zCJ2rBEM7dkOPyUAD59DAR/kg8hxMfeW+gJPr0GxQ+dz3Dqd0ZFZPEsitzkgbEm+12T0JIS0tIlbeB0fB6rRqBefUdJdlU/ODj2YE/Xxfftz369ioKsMFyIMQCHyKMN2YaQRPFOofq1wQ1NwNVkXqDwPxx+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF1gD6G0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BDCC4CECE;
	Sat,  5 Oct 2024 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124679;
	bh=1w+V9LlE1J6cc3An9dYnLJVfYeaBJHjSV6dDDI8zsLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dF1gD6G0dluyvIOR3G73dKhwQFvzLmkQmr6FRjX8YxT9aFTj8OT9zeZiuK276sscu
	 o1a1ZREALGTqYLByST2a4agP1z6gY2OYfn1CRSRu3eKul/ksTSsoLcTBju6KMDXGye
	 3E0e5w678JHwPK2btii1HnyWLpynAup2VYE6vLr3nHIbCaTNUWTj0E/UgWtE3DmgrY
	 bMlpV5RwTMMGmeFnj+eKP0zGslqpgpPbkU1PT1lPeJWl9vN/qISi34HYTBwmlKxHgP
	 9z/AyHye/vChBcV5E7EGZwA8FZEIh+lNtOJ0YCXSD4nEIeJnWLijHlwfJZr3K/ur5e
	 MQQC1Sq9+H54A==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:37:31 +0100
Subject: [PATCH v14 4/5] KVM: arm64: Set PSTATE.EXLOCK when entering an
 exception
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-arm64-gcs-v14-4-59060cd6092b@kernel.org>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
In-Reply-To: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1w+V9LlE1J6cc3An9dYnLJVfYeaBJHjSV6dDDI8zsLg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARb3XNsQxPIIVJgqL1ofZ9n+yPUBRv+TsEKWQi+9
 EUnXChSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEW9wAKCRAk1otyXVSH0OMeB/
 48PIFxhsSEeGYLvbkQwXs0CsofuASzZyRNlYQd6TAmR33CckB3r9f4MbRDTPD5/BKjU8M42crd5dGE
 N7zCYVdZJK2rwkjnPX66tP2rxRMGYFoffktadf1k4YV3lpeLslgP0ffiXr8GyhrfokscwNGuQ9YsWC
 xAw1Q2aNwYoTyDwAPI+tJn/R0W1kIrS1oufeh1EJI3eVrF6HQug330/7ZncwYvQIxpIpGrcacAlvi9
 PBQdwoofpHTWI4Mq+dCe0WJf8LKGctAJ9624a3XkMY3qO3dNs7gsZnJku6G/q7uQT2+hUWeWhx/0ob
 wfMwN83sha2Pc6WbQr90onjrvSer0V
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As per DDI 0487 RWTXBY we need to manage PSTATE.EXLOCK when entering an
exception, when the exception is entered from a lower EL the bit is cleared
while if entering from the same EL it is set to GCSCR_ELx.EXLOCKEN.
Implement this behaviour in enter_exception64().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  2 ++
 arch/arm64/kvm/hyp/exception.c       | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 0f39ba4f3efd4a8760f0fca0fbf1a2563b191c7d..9987957f4f7137bf107653b817885bb976853a83 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -37,6 +37,7 @@
 #define PSR_MODE_EL3t	0x0000000c
 #define PSR_MODE_EL3h	0x0000000d
 #define PSR_MODE_MASK	0x0000000f
+#define PSR_EL_MASK	0x0000000c
 
 /* AArch32 CPSR bits */
 #define PSR_MODE32_BIT		0x00000010
@@ -56,6 +57,7 @@
 #define PSR_C_BIT	0x20000000
 #define PSR_Z_BIT	0x40000000
 #define PSR_N_BIT	0x80000000
+#define PSR_EXLOCK_BIT 0x400000000
 
 #define PSR_BTYPE_SHIFT		10
 
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 424a5107cddb5e1cdd75ef3581adef03aaadabb7..0d41b9b75cf83250b2c0d20cd82c153869efb0e4 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -160,6 +160,16 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 	// PSTATE.BTYPE is set to zero upon any exception to AArch64
 	// See ARM DDI 0487E.a, pages D1-2293 to D1-2294.
 
+	// PSTATE.EXLOCK is set to 0 upon any exception to a higher
+	// EL, or to GCSCR_ELx.EXLOCKEN for an exception to the same
+	// exception level.  See ARM DDI 0487 RWTXBY, D.1.3.2 in K.a.
+	if (kvm_has_gcs(vcpu->kvm) &&
+	    (target_mode & PSR_EL_MASK) == (mode & PSR_EL_MASK)) {
+		u64 gcscr = __vcpu_read_sys_reg(vcpu, GCSCR_EL1);
+		if (gcscr & GCSCR_ELx_EXLOCKEN)
+			new |= PSR_EXLOCK_BIT;
+	}
+
 	new |= PSR_D_BIT;
 	new |= PSR_A_BIT;
 	new |= PSR_I_BIT;

-- 
2.39.2


