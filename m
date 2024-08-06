Return-Path: <linux-kselftest+bounces-14862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E3694933D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D481F24FE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E011D47D1;
	Tue,  6 Aug 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2J5Z4Is"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CE1D47BB;
	Tue,  6 Aug 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955076; cv=none; b=GU06SUagJMFV/wCtJTJbjwzxh/zjD9pYRA+URDy7MsvOe/kkdu9Wsg2mEs5bZK+Od9sN4GZazuZzz9OMXISaOSAxEssFR8+D3Ql9Wdl7WuOKjRdc3Q7LC1KyFt4771EfavYupCSWyf8LgjN4hzJoLviLFDvPt18rs2JobjqD/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955076; c=relaxed/simple;
	bh=VBT2tJgs9EGy4nBDf18vFyM35Elgr8DLyvQ1Ren2XqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JcwSlztWavSzdn19pY5zstRrwXr3oDeTos7qtSVwNVsXnnXYLpuoJHYPhTDNNOW8HR7ngzalqsYYHQ/+BZOL1TZwMzE2kbcqqc5TIVF2sbTenZI8bpudVaXlOUYVTz3JZt/BUA03uGPx/mdaL3u2ZDFZ+tkhak+lRNeAwMcVJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2J5Z4Is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A667C4AF09;
	Tue,  6 Aug 2024 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955075;
	bh=VBT2tJgs9EGy4nBDf18vFyM35Elgr8DLyvQ1Ren2XqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u2J5Z4Is0l5sHVEwiEW5OeMM2Iw+cC0dyrYal8cvdp95/VSc8nV8ECASHOJ9XUFMv
	 DCvn50vwfvqGWo+w4g8NtfD5FJNRn3OusnDxdp8xtwLgA70bix7ggDFJyJ4E8stOd5
	 3vM+XpUSFguWlDzzJf6GGnU9rA4kwwlp9hpJ+w775j6m/wnN4Eb2E0UdihFZST8USQ
	 Q+UCg5fXeXanVkesjhhlwiQCZXVplMQYl68gvsKQWD0PFWPVxwLTE2IOGL8Ht+snMj
	 K2asrv0mzzrOqdWDffmbeuMT3/h3alOfWAXxUGnG2e0fAIkkFEwZw7JaDz0ezGXXo/
	 pWeiG5qrgPigA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Aug 2024 15:24:22 +0100
Subject: [PATCH v2 1/3] KVM: selftests: arm64: Simplify specification of
 filtered registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-kvm-arm64-get-reg-list-v2-1-1d3fbc7b6844@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VBT2tJgs9EGy4nBDf18vFyM35Elgr8DLyvQ1Ren2XqM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmsjU7HVkGtsRcdnpm2eaoLlLyr8p/cpwApE+8RIuP
 ksnVbtSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrI1OwAKCRAk1otyXVSH0FjAB/
 4ypKijxW0921PZ+CJqAHoDvjme/UE/UucABDU5bsgtOD0nmaS5z/sZ/c4l8XdNDA1Q7piTWPFVeAe7
 TgAHqhWuNy5z12X20lozdtkbFyTePhDz95xm1M6r26PdhPwXPO14BS5nAIgT/CvhjgLv7uG6BQ/ckC
 gQg1Bg6w/vrbeIIwZgh5SgNFYB38HgEG3MkkrvBExDOk261XxhzHF936dYIlDIhIMS9l1yMY1qhee9
 lqyt9eZLYGJ18A1Ql0EJcSnJNYi5Gd7EOu8o3fZLMiLDBdACFYcMXVbGmPXKi3zPyZoQB+dnXQp8MW
 HfElEvEprIr4NgDO2b5R81OKm4SGmS
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
index 709d7d721760..97ac3f6b5c4b 100644
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
+#define FEAT_ID_CHECK(xreg, xid_reg, id_field, id_val)			\
+	{								\
+		.reg		= KVM_ARM64_SYS_REG(SYS_##xreg),	\
+		.id_reg		= KVM_ARM64_SYS_REG(SYS_##xid_reg),	\
+		.feat_shift	= xid_reg##_##id_field##_SHIFT,		\
+		.feat_min	= xid_reg##_##id_field##_##id_val,	\
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


