Return-Path: <linux-kselftest+bounces-14864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB6949345
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 16:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CE3287B8F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B9201264;
	Tue,  6 Aug 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMT7Mkzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F120124B;
	Tue,  6 Aug 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955082; cv=none; b=Ng8h3le4uk9HeuDVNH9uBCMIQgO21rBYb3Bp09INOY7CVWft+OUYgMXZBB2I7cDdk4Y9zmTh3wlwpnTAozE2GFbwMAkKtcrk9UiLv0OeMHOLMaz9xCWfj1NI0YEFenPgQqDod65moRh7z2qGrMQc5CA1+ebMI4Nf2XEEhNDXmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955082; c=relaxed/simple;
	bh=RWK5/XT/M0n3BCop1FuawRnOeOzURS5OXMnoWXmw4ZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1RWXyEbtfon7wEn5B+N/c1frm6PrUmr+FUNl5TCSUqIGa0v1jUJxIOJKMKL5I5fPgMiAihuYHy3rdBi1hsMn/vU5iJh4HnDGINMpKjxHhyYYfI/UcVGQOTBbV1rfw44aLok6ti+2hUhf3ArIIDxwphLqzHgjGtwNFoTFYrhkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMT7Mkzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ECDC4AF0D;
	Tue,  6 Aug 2024 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955082;
	bh=RWK5/XT/M0n3BCop1FuawRnOeOzURS5OXMnoWXmw4ZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NMT7MkzbMKqvMn/p3c68WpOhZPm9ayV0Esj7di6vsYtJzJ7iCgJSMSjpBoUSDUYoH
	 +5SBAZ4diucYFeZ7L0sCKDH5rayajFNXo3hsOGFETWJ8tQqmnJHOE+tDPqruU1QgSQ
	 gK5AqS8AL2RvIZKMbpzUztDHyVxJaY7zCxEMeg7CnQ34cT60Zxe8C1Vu5I1SvPY8Uv
	 mQICj9Zr1gw99GwZBG0JqmGabb1l31Kwn4r8TZGkMl9pe5IuL72ObtkztDY9AH4rt9
	 zacxG4fLx+pSPC8DVuXdcLisCBgVIYcrqQIACxxvEumv98YaFUN9Jket8119/cSBGL
	 d8yIuIbaaUWBA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Aug 2024 15:24:24 +0100
Subject: [PATCH v2 3/3] KVM: selftests: arm64: Use generated defines for
 named system registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-kvm-arm64-get-reg-list-v2-3-1d3fbc7b6844@kernel.org>
References: <20240806-kvm-arm64-get-reg-list-v2-0-1d3fbc7b6844@kernel.org>
In-Reply-To: <20240806-kvm-arm64-get-reg-list-v2-0-1d3fbc7b6844@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=12777; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RWK5/XT/M0n3BCop1FuawRnOeOzURS5OXMnoWXmw4ZY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmsjU9zL47L1oeMOgWzTI9mZVmMf/JB0/ELOcx03l0
 0CBPCFqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrI1PQAKCRAk1otyXVSH0NqGB/
 9gMpogDKHGWatGv7xjobk5JJNaleOjpOdrOXoqmUY5pBbcGlwD/aky9ahSF+zK38bl5+VKt+LUT+hx
 kMgzLr64kLL5S+dMgK7e0Y1848TJyhKrtJOPwJQ3JWTZFHJBQ+H1G82XtLMpdcMtU7pSWJos20Rosg
 ST/us7x7HIBvOXTJaNjf5HrdSzl+mgaTMh4sdV3GozbZO+hBlQoB+FMVnkmA4QiFldNPvKC3on4LPP
 U/4kEYoprL4wOd/kq/8s4yk8FmZ/aLWEIekejGVRQs8PLvUaGnw3KWCVv49JAK5hVROMSdsFWwRy2v
 p3LwDmUh+wHZcHDh986V6M7Z1diOa/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the get-reg-list test uses directly specified numeric values to
define system registers to validate. Since we already have a macro which
allows us to use the generated system register definitions from the main
kernel easily let's update all the registers where we have specified the
name in a comment to just use that macro. This reduces the number of
places where we need to validate the name to number mapping.

This conversion was done with the sed command:

  sed -i -E 's-ARM64_SYS_REG.*/\* (.*) \*/-KVM_ARM64_SYS_REG(SYS_\1),-' tools/testing/selftests/kvm/aarch64/get-reg-list.c

We still have a number of numerically specified registers, some of these
are reserved registers without defined names (eg, unallocated ID registers)
and others either doing have kernel macro definitions yet.  There are
also uncommented registers with definitions we could find by parsing
tools/sysreg and registers like DBGBVRn_EL1 listed which have
parameterised macros we could use prior to conversion to generation.

No change in the generated output.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 204 ++++++++++-----------
 1 file changed, 102 insertions(+), 102 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index a270287a4c88..8011ea27c107 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -323,11 +323,11 @@ static __u64 base_regs[] = {
 	KVM_REG_ARM_TIMER_CVAL,
 
 	ARM64_SYS_REG(3, 3, 14, 0, 2),
-	ARM64_SYS_REG(3, 0, 0, 0, 0),	/* MIDR_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 0, 6),	/* REVIDR_EL1 */
-	ARM64_SYS_REG(3, 1, 0, 0, 1),	/* CLIDR_EL1 */
-	ARM64_SYS_REG(3, 1, 0, 0, 7),	/* AIDR_EL1 */
-	ARM64_SYS_REG(3, 3, 0, 0, 1),	/* CTR_EL0 */
+	KVM_ARM64_SYS_REG(SYS_MIDR_EL1),
+	KVM_ARM64_SYS_REG(SYS_REVIDR_EL1),
+	KVM_ARM64_SYS_REG(SYS_CLIDR_EL1),
+	KVM_ARM64_SYS_REG(SYS_AIDR_EL1),
+	KVM_ARM64_SYS_REG(SYS_CTR_EL0),
 	ARM64_SYS_REG(2, 0, 0, 0, 4),
 	ARM64_SYS_REG(2, 0, 0, 0, 5),
 	ARM64_SYS_REG(2, 0, 0, 0, 6),
@@ -336,8 +336,8 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(2, 0, 0, 1, 5),
 	ARM64_SYS_REG(2, 0, 0, 1, 6),
 	ARM64_SYS_REG(2, 0, 0, 1, 7),
-	ARM64_SYS_REG(2, 0, 0, 2, 0),	/* MDCCINT_EL1 */
-	ARM64_SYS_REG(2, 0, 0, 2, 2),	/* MDSCR_EL1 */
+	KVM_ARM64_SYS_REG(SYS_MDCCINT_EL1),
+	KVM_ARM64_SYS_REG(SYS_MDSCR_EL1),
 	ARM64_SYS_REG(2, 0, 0, 2, 4),
 	ARM64_SYS_REG(2, 0, 0, 2, 5),
 	ARM64_SYS_REG(2, 0, 0, 2, 6),
@@ -394,109 +394,109 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(2, 0, 0, 15, 5),
 	ARM64_SYS_REG(2, 0, 0, 15, 6),
 	ARM64_SYS_REG(2, 0, 0, 15, 7),
-	ARM64_SYS_REG(2, 0, 1, 1, 4),	/* OSLSR_EL1 */
-	ARM64_SYS_REG(2, 4, 0, 7, 0),	/* DBGVCR32_EL2 */
-	ARM64_SYS_REG(3, 0, 0, 0, 5),	/* MPIDR_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 1, 0),	/* ID_PFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 1, 1),	/* ID_PFR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 1, 2),	/* ID_DFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 1, 3),	/* ID_AFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 1, 4),	/* ID_MMFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 1, 5),	/* ID_MMFR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 1, 6),	/* ID_MMFR2_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 1, 7),	/* ID_MMFR3_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 2, 0),	/* ID_ISAR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 2, 1),	/* ID_ISAR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 2, 2),	/* ID_ISAR2_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 2, 3),	/* ID_ISAR3_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 2, 4),	/* ID_ISAR4_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 2, 5),	/* ID_ISAR5_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 2, 6),	/* ID_MMFR4_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 2, 7),	/* ID_ISAR6_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 3, 0),	/* MVFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 3, 1),	/* MVFR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 3, 2),	/* MVFR2_EL1 */
+	KVM_ARM64_SYS_REG(SYS_OSLSR_EL1),
+	KVM_ARM64_SYS_REG(SYS_DBGVCR32_EL2),
+	KVM_ARM64_SYS_REG(SYS_MPIDR_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_PFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_PFR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_DFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_MMFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_MMFR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_MMFR2_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_MMFR3_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_ISAR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_ISAR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_ISAR2_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_ISAR3_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_ISAR4_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_ISAR5_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_MMFR4_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_ISAR6_EL1),
+	KVM_ARM64_SYS_REG(SYS_MVFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_MVFR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_MVFR2_EL1),
 	ARM64_SYS_REG(3, 0, 0, 3, 3),
-	ARM64_SYS_REG(3, 0, 0, 3, 4),	/* ID_PFR2_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 3, 5),	/* ID_DFR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 3, 6),	/* ID_MMFR5_EL1 */
+	KVM_ARM64_SYS_REG(SYS_ID_PFR2_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_DFR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_MMFR5_EL1),
 	ARM64_SYS_REG(3, 0, 0, 3, 7),
-	ARM64_SYS_REG(3, 0, 0, 4, 0),	/* ID_AA64PFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 4, 2),	/* ID_AA64PFR2_EL1 */
+	KVM_ARM64_SYS_REG(SYS_ID_AA64PFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64PFR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64PFR2_EL1),
 	ARM64_SYS_REG(3, 0, 0, 4, 3),
-	ARM64_SYS_REG(3, 0, 0, 4, 4),	/* ID_AA64ZFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 4, 5),	/* ID_AA64SMFR0_EL1 */
+	KVM_ARM64_SYS_REG(SYS_ID_AA64ZFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64SMFR0_EL1),
 	ARM64_SYS_REG(3, 0, 0, 4, 6),
 	ARM64_SYS_REG(3, 0, 0, 4, 7),
-	ARM64_SYS_REG(3, 0, 0, 5, 0),	/* ID_AA64DFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 5, 1),	/* ID_AA64DFR1_EL1 */
+	KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64DFR1_EL1),
 	ARM64_SYS_REG(3, 0, 0, 5, 2),
 	ARM64_SYS_REG(3, 0, 0, 5, 3),
-	ARM64_SYS_REG(3, 0, 0, 5, 4),	/* ID_AA64AFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 5, 5),	/* ID_AA64AFR1_EL1 */
+	KVM_ARM64_SYS_REG(SYS_ID_AA64AFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64AFR1_EL1),
 	ARM64_SYS_REG(3, 0, 0, 5, 6),
 	ARM64_SYS_REG(3, 0, 0, 5, 7),
-	ARM64_SYS_REG(3, 0, 0, 6, 0),	/* ID_AA64ISAR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 6, 1),	/* ID_AA64ISAR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 6, 2),	/* ID_AA64ISAR2_EL1 */
+	KVM_ARM64_SYS_REG(SYS_ID_AA64ISAR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64ISAR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64ISAR2_EL1),
 	ARM64_SYS_REG(3, 0, 0, 6, 3),
 	ARM64_SYS_REG(3, 0, 0, 6, 4),
 	ARM64_SYS_REG(3, 0, 0, 6, 5),
 	ARM64_SYS_REG(3, 0, 0, 6, 6),
 	ARM64_SYS_REG(3, 0, 0, 6, 7),
-	ARM64_SYS_REG(3, 0, 0, 7, 0),	/* ID_AA64MMFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 7, 1),	/* ID_AA64MMFR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 7, 2),	/* ID_AA64MMFR2_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 7, 4),	/* ID_AA64MMFR4_EL1 */
+	KVM_ARM64_SYS_REG(SYS_ID_AA64MMFR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64MMFR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64MMFR2_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64MMFR3_EL1),
+	KVM_ARM64_SYS_REG(SYS_ID_AA64MMFR4_EL1),
 	ARM64_SYS_REG(3, 0, 0, 7, 5),
 	ARM64_SYS_REG(3, 0, 0, 7, 6),
 	ARM64_SYS_REG(3, 0, 0, 7, 7),
-	ARM64_SYS_REG(3, 0, 1, 0, 0),	/* SCTLR_EL1 */
-	ARM64_SYS_REG(3, 0, 1, 0, 1),	/* ACTLR_EL1 */
-	ARM64_SYS_REG(3, 0, 1, 0, 2),	/* CPACR_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 0, 0),	/* TTBR0_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 0, 1),	/* TTBR1_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 0, 2),	/* TCR_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 0, 3),	/* TCR2_EL1 */
-	ARM64_SYS_REG(3, 0, 5, 1, 0),	/* AFSR0_EL1 */
-	ARM64_SYS_REG(3, 0, 5, 1, 1),	/* AFSR1_EL1 */
-	ARM64_SYS_REG(3, 0, 5, 2, 0),	/* ESR_EL1 */
-	ARM64_SYS_REG(3, 0, 6, 0, 0),	/* FAR_EL1 */
-	ARM64_SYS_REG(3, 0, 7, 4, 0),	/* PAR_EL1 */
-	ARM64_SYS_REG(3, 0, 10, 2, 0),	/* MAIR_EL1 */
-	ARM64_SYS_REG(3, 0, 10, 2, 2),	/* PIRE0_EL1 */
-	ARM64_SYS_REG(3, 0, 10, 2, 3),	/* PIR_EL1 */
-	ARM64_SYS_REG(3, 0, 10, 3, 0),	/* AMAIR_EL1 */
-	ARM64_SYS_REG(3, 0, 12, 0, 0),	/* VBAR_EL1 */
-	ARM64_SYS_REG(3, 0, 12, 1, 1),	/* DISR_EL1 */
-	ARM64_SYS_REG(3, 0, 13, 0, 1),	/* CONTEXTIDR_EL1 */
-	ARM64_SYS_REG(3, 0, 13, 0, 4),	/* TPIDR_EL1 */
-	ARM64_SYS_REG(3, 0, 14, 1, 0),	/* CNTKCTL_EL1 */
-	ARM64_SYS_REG(3, 2, 0, 0, 0),	/* CSSELR_EL1 */
-	ARM64_SYS_REG(3, 3, 13, 0, 2),	/* TPIDR_EL0 */
-	ARM64_SYS_REG(3, 3, 13, 0, 3),	/* TPIDRRO_EL0 */
-	ARM64_SYS_REG(3, 3, 14, 0, 1),	/* CNTPCT_EL0 */
-	ARM64_SYS_REG(3, 3, 14, 2, 1),	/* CNTP_CTL_EL0 */
-	ARM64_SYS_REG(3, 3, 14, 2, 2),	/* CNTP_CVAL_EL0 */
-	ARM64_SYS_REG(3, 4, 3, 0, 0),	/* DACR32_EL2 */
-	ARM64_SYS_REG(3, 4, 5, 0, 1),	/* IFSR32_EL2 */
-	ARM64_SYS_REG(3, 4, 5, 3, 0),	/* FPEXC32_EL2 */
+	KVM_ARM64_SYS_REG(SYS_SCTLR_EL1),
+	KVM_ARM64_SYS_REG(SYS_ACTLR_EL1),
+	KVM_ARM64_SYS_REG(SYS_CPACR_EL1),
+	KVM_ARM64_SYS_REG(SYS_TTBR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_TTBR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_TCR_EL1),
+	KVM_ARM64_SYS_REG(SYS_TCR2_EL1),
+	KVM_ARM64_SYS_REG(SYS_AFSR0_EL1),
+	KVM_ARM64_SYS_REG(SYS_AFSR1_EL1),
+	KVM_ARM64_SYS_REG(SYS_ESR_EL1),
+	KVM_ARM64_SYS_REG(SYS_FAR_EL1),
+	KVM_ARM64_SYS_REG(SYS_PAR_EL1),
+	KVM_ARM64_SYS_REG(SYS_MAIR_EL1),
+	KVM_ARM64_SYS_REG(SYS_PIRE0_EL1),
+	KVM_ARM64_SYS_REG(SYS_PIR_EL1),
+	KVM_ARM64_SYS_REG(SYS_AMAIR_EL1),
+	KVM_ARM64_SYS_REG(SYS_VBAR_EL1),
+	KVM_ARM64_SYS_REG(SYS_DISR_EL1),
+	KVM_ARM64_SYS_REG(SYS_CONTEXTIDR_EL1),
+	KVM_ARM64_SYS_REG(SYS_TPIDR_EL1),
+	KVM_ARM64_SYS_REG(SYS_CNTKCTL_EL1),
+	KVM_ARM64_SYS_REG(SYS_CSSELR_EL1),
+	KVM_ARM64_SYS_REG(SYS_TPIDR_EL0),
+	KVM_ARM64_SYS_REG(SYS_TPIDRRO_EL0),
+	KVM_ARM64_SYS_REG(SYS_CNTPCT_EL0),
+	KVM_ARM64_SYS_REG(SYS_CNTP_CTL_EL0),
+	KVM_ARM64_SYS_REG(SYS_CNTP_CVAL_EL0),
+	KVM_ARM64_SYS_REG(SYS_DACR32_EL2),
+	KVM_ARM64_SYS_REG(SYS_IFSR32_EL2),
+	KVM_ARM64_SYS_REG(SYS_FPEXC32_EL2),
 };
 
 static __u64 pmu_regs[] = {
-	ARM64_SYS_REG(3, 0, 9, 14, 1),	/* PMINTENSET_EL1 */
-	ARM64_SYS_REG(3, 0, 9, 14, 2),	/* PMINTENCLR_EL1 */
-	ARM64_SYS_REG(3, 3, 9, 12, 0),	/* PMCR_EL0 */
-	ARM64_SYS_REG(3, 3, 9, 12, 1),	/* PMCNTENSET_EL0 */
-	ARM64_SYS_REG(3, 3, 9, 12, 2),	/* PMCNTENCLR_EL0 */
-	ARM64_SYS_REG(3, 3, 9, 12, 3),	/* PMOVSCLR_EL0 */
-	ARM64_SYS_REG(3, 3, 9, 12, 4),	/* PMSWINC_EL0 */
-	ARM64_SYS_REG(3, 3, 9, 12, 5),	/* PMSELR_EL0 */
-	ARM64_SYS_REG(3, 3, 9, 13, 0),	/* PMCCNTR_EL0 */
-	ARM64_SYS_REG(3, 3, 9, 14, 0),	/* PMUSERENR_EL0 */
-	ARM64_SYS_REG(3, 3, 9, 14, 3),	/* PMOVSSET_EL0 */
+	KVM_ARM64_SYS_REG(SYS_PMINTENSET_EL1),
+	KVM_ARM64_SYS_REG(SYS_PMINTENCLR_EL1),
+	KVM_ARM64_SYS_REG(SYS_PMCR_EL0),
+	KVM_ARM64_SYS_REG(SYS_PMCNTENSET_EL0),
+	KVM_ARM64_SYS_REG(SYS_PMCNTENCLR_EL0),
+	KVM_ARM64_SYS_REG(SYS_PMOVSCLR_EL0),
+	KVM_ARM64_SYS_REG(SYS_PMSWINC_EL0),
+	KVM_ARM64_SYS_REG(SYS_PMSELR_EL0),
+	KVM_ARM64_SYS_REG(SYS_PMCCNTR_EL0),
+	KVM_ARM64_SYS_REG(SYS_PMUSERENR_EL0),
+	KVM_ARM64_SYS_REG(SYS_PMOVSSET_EL0),
 	ARM64_SYS_REG(3, 3, 14, 8, 0),
 	ARM64_SYS_REG(3, 3, 14, 8, 1),
 	ARM64_SYS_REG(3, 3, 14, 8, 2),
@@ -559,7 +559,7 @@ static __u64 pmu_regs[] = {
 	ARM64_SYS_REG(3, 3, 14, 15, 4),
 	ARM64_SYS_REG(3, 3, 14, 15, 5),
 	ARM64_SYS_REG(3, 3, 14, 15, 6),
-	ARM64_SYS_REG(3, 3, 14, 15, 7),	/* PMCCFILTR_EL0 */
+	KVM_ARM64_SYS_REG(SYS_PMCCFILTR_EL0),
 };
 
 static __u64 vregs[] = {
@@ -648,7 +648,7 @@ static __u64 sve_regs[] = {
 	KVM_REG_ARM64_SVE_PREG(14, 0),
 	KVM_REG_ARM64_SVE_PREG(15, 0),
 	KVM_REG_ARM64_SVE_FFR(0),
-	ARM64_SYS_REG(3, 0, 1, 2, 0),   /* ZCR_EL1 */
+	KVM_ARM64_SYS_REG(SYS_ZCR_EL1),
 };
 
 static __u64 sve_rejects_set[] = {
@@ -656,19 +656,19 @@ static __u64 sve_rejects_set[] = {
 };
 
 static __u64 pauth_addr_regs[] = {
-	ARM64_SYS_REG(3, 0, 2, 1, 0),	/* APIAKEYLO_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 1, 1),	/* APIAKEYHI_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 1, 2),	/* APIBKEYLO_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 1, 3),	/* APIBKEYHI_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 2, 0),	/* APDAKEYLO_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 2, 1),	/* APDAKEYHI_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 2, 2),	/* APDBKEYLO_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 2, 3)	/* APDBKEYHI_EL1 */
+	KVM_ARM64_SYS_REG(SYS_APIAKEYLO_EL1),
+	KVM_ARM64_SYS_REG(SYS_APIAKEYHI_EL1),
+	KVM_ARM64_SYS_REG(SYS_APIBKEYLO_EL1),
+	KVM_ARM64_SYS_REG(SYS_APIBKEYHI_EL1),
+	KVM_ARM64_SYS_REG(SYS_APDAKEYLO_EL1),
+	KVM_ARM64_SYS_REG(SYS_APDAKEYHI_EL1),
+	KVM_ARM64_SYS_REG(SYS_APDBKEYLO_EL1),
+	KVM_ARM64_SYS_REG(SYS_APDBKEYHI_EL1),
 };
 
 static __u64 pauth_generic_regs[] = {
-	ARM64_SYS_REG(3, 0, 2, 3, 0),	/* APGAKEYLO_EL1 */
-	ARM64_SYS_REG(3, 0, 2, 3, 1),	/* APGAKEYHI_EL1 */
+	KVM_ARM64_SYS_REG(SYS_APGAKEYLO_EL1),
+	KVM_ARM64_SYS_REG(SYS_APGAKEYHI_EL1),
 };
 
 #define BASE_SUBLIST \

-- 
2.39.2


