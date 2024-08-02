Return-Path: <linux-kselftest+bounces-14748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7259465AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB70A1C20E71
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5D13B797;
	Fri,  2 Aug 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1ckbatW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB7013B5AE;
	Fri,  2 Aug 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635895; cv=none; b=twGe26nzZAw02hDGoLluBBR1a7NTRntHjZOKSTkhKC5Aku2s4w1utfsifK9dxo0064a52CvzTaPngjm8Qr871a+b56l9Fbo4lm10oI0eEzjCFUFO5TGL1xBRcf9KBjjC4NnGLpqJDpL6WUaVo3hArfOOgvspI5T3rQpvXKLIOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635895; c=relaxed/simple;
	bh=AVgebCWfsB1J9sg1AYiFbvjfukzP5s4owE8FOzxGRiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pG6OjYZbXoHSDKNwKYEQfqLocBOP074H0oKuBziHtqx8qDz3iaR9vCiOyAvIFVmX4n8KrLwlgSPKn2VgUIYoAnFefGpfDcs8MEFOerhclCWK2Oall3NKhKntVoblAZbMuUGrpfeWKzhyr6S4KUs9ToIP7eQTG9Zc32TQdLs+bWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1ckbatW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A20C32782;
	Fri,  2 Aug 2024 21:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635895;
	bh=AVgebCWfsB1J9sg1AYiFbvjfukzP5s4owE8FOzxGRiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U1ckbatWSCsnlWdTBT6duFL2GwbVkNTMMMlW3jN8qYXZJMYxcdDhkwgwAauCE9UZv
	 IIcpub+Hc5gJ6uAX5uRIJRYNLLgHziNIBI3zhs3V+EzBUZ14+pC3o/5YNkOnpBMxn8
	 z79XJ+QRZ1q1Le8pq/8lIdFg+DqlCyaZelYArK2VLMS0nK/P1k4CSd+u459C6NONgI
	 ZrRXY+SbuhvS3zrKllh4+uJi3vN0fijrElpH07LJ5rKdHZ4VBl1RwZYE2E4sDyHqaY
	 2pQNCZS+bXAA2fZn5npRA6Ffjz8SVB2NfqHhBon2LCyTbhOnHatH8GPTXp3VMxx/SM
	 NppLyPlewRI2w==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 02 Aug 2024 22:57:53 +0100
Subject: [PATCH 1/2] KVM: selftests: arm64: Simplify specification of
 filtered registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-kvm-arm64-get-reg-list-v1-1-3a5bf8f80765@kernel.org>
References: <20240802-kvm-arm64-get-reg-list-v1-0-3a5bf8f80765@kernel.org>
In-Reply-To: <20240802-kvm-arm64-get-reg-list-v1-0-3a5bf8f80765@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AVgebCWfsB1J9sg1AYiFbvjfukzP5s4owE8FOzxGRiQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmrVZv5ePVRlzFtHE1IV89P3y2WNY0J8BDdG0donou
 w+Y8nt2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZq1WbwAKCRAk1otyXVSH0IUjB/
 90hc+2imIEoJUMsqqL3gypXToxHXVOW77FsqHEba9EAptauCBWjlEjtuIxQFtcqdAAABjvYGYoEcq/
 HyhReFSZXiXcD3UfyNiAT/YUrRLaI1SuJmeEQn6xCkqXa4n8sX03759m93FtDi9iMASaftMTUCTOcn
 I7ZOGGi8MJlEd1bdKPssYwks7dcqhpaeo2NRG1WkUPjzKefJWvE9Lu53Cl4kGa5Ub5kUEqpgBLNpHw
 MY485H8r1JDpoGhxo2zR8rW3I7NUgFLCnTzcS7irBLYqae9ji/W4BEyxrnn7nIHSX7klz8Ywg3zCvt
 wC1xFC8Om6moU0SWUGBarzczECmkYp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since we already import the generated sysreg definitions from the main
kernel and reference them in processor.h for use in other KVM tests we
can also make use of them for get-reg-list as well instead of having hard
coded magic numbers in the program. Do this for the table defining which
registers should be gated on ID register values, using a macro which allows
us to specify the register and ID register field in a much more compact
and direct fashion.

In the process we fix the ID register checked for S1PIE specific registers
which was using an incorrect shift of 4, checking SCTLRX support instead.
No other change is seen in the generated data.

Fixes: 5f0419a0083b ("KVM: selftests: get-reg-list: add Permission Indirection registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 29 ++++++++--------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 709d7d721760..a00322970578 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -22,25 +22,18 @@ struct feature_id_reg {
 	__u64 feat_min;
 };
 
-static struct feature_id_reg feat_id_regs[] = {
-	{
-		ARM64_SYS_REG(3, 0, 2, 0, 3),	/* TCR2_EL1 */
-		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
-		0,
-		1
-	},
-	{
-		ARM64_SYS_REG(3, 0, 10, 2, 2),	/* PIRE0_EL1 */
-		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
-		4,
-		1
-	},
-	{
-		ARM64_SYS_REG(3, 0, 10, 2, 3),	/* PIR_EL1 */
-		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
-		4,
-		1
+#define FEAT_ID_CHECK(reg, id_reg, id_field, id_val)	\
+	{						\
+		KVM_ARM64_SYS_REG(SYS_##reg),		\
+		KVM_ARM64_SYS_REG(SYS_##id_reg),	\
+		id_reg##_##id_field##_SHIFT,		\
+		id_reg##_##id_field##_##id_val,		\
 	}
+
+static struct feature_id_reg feat_id_regs[] = {
+	FEAT_ID_CHECK(TCR2_EL1, ID_AA64MMFR3_EL1, TCRX, IMP),
+	FEAT_ID_CHECK(PIRE0_EL1, ID_AA64MMFR3_EL1, S1PIE, IMP),
+	FEAT_ID_CHECK(PIR_EL1, ID_AA64MMFR3_EL1, S1PIE, IMP),
 };
 
 bool filter_reg(__u64 reg)

-- 
2.39.2


