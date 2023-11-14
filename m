Return-Path: <linux-kselftest+bounces-91-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653067EB237
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E341C20AC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFAA3FB13;
	Tue, 14 Nov 2023 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEGdzbC7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558941231;
	Tue, 14 Nov 2023 14:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9683C43395;
	Tue, 14 Nov 2023 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972555;
	bh=+jSB6ryQw/tAoaW0f6Dn8f5r/j3Y5hYXa/dEZzeKHsY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SEGdzbC7b3wvMV/Ivzh+9pjvZ4JIMa9KlE7jQa6b4P2pa6rq17+x3do5ktJq1XLux
	 7T4GgVQV7XbbzuW7I2oE2Q1GisQDn5s60Zm9L3lSQruv90HXyNcPZRO98vranKE7l2
	 /GrQfWQYcZjvSQUQGvLmKA+UQt+ba+dAoAnpU2Up9slFFsWZJiYEBrBEIsxsQZGNrJ
	 DxNdqxvl+v1I8aIMm2OKN44VvNMGy752EsPi39uSdacKE8uDorHkb/u9pEjBsDRrAD
	 8gqTuFsq5dcoH2Xpq+C6lSGdEw9sW8wZvPS4wRmKOXjCUjZGbBj64nFj7lUQKALnli
	 AeCR4q53PRrdA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:55 +0000
Subject: [PATCH v2 10/21] arm64/fpsimd: Enable host kernel access to FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-10-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+jSB6ryQw/tAoaW0f6Dn8f5r/j3Y5hYXa/dEZzeKHsY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WcKwT165mW8oQVRPIaZv68B/WwcA+JzKzLOCir
 kQlxz5+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFnAAKCRAk1otyXVSH0GMdB/
 4+cijMYPYrqufsdKVq1iYT/G7uPwkXJ9/l3VF+dAG1JOHxhY2b2Ce8RiIKiql/X7QgixZvMO/M/zOM
 ZPIUX4CV0DhhyCv0dry+chuyfHmZKstJzsDz4jyryyx+szv4am5GwIGJHOHVKQ/JoSK4k/SRMyKR4q
 U7TJe73E+13UCeTitrIqV6D2gDqr7SqeRungofG3SkzDPWAQb4givyRUVEyAWPEukXji4V58e40LzE
 mgNS18Eb0F4D4Ih3su5c+Ejb3IF390ueKDQJLFs6HKKcR82E589lXZnquLKvpuP4hHV/KUWZ28+PY2
 8jL/aO44ctaIzBymlrA1ZBmmRoqanD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_FPMR provides a new generally accessible architectural register FPMR.
This is only accessible to EL0 and EL1 when HCRX_EL2.EnFPM is set to 1,
do this when the host is running. The guest part will be done along with
context switching the new register and exposing it via guest management.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index b85f46a73e21..9f9239d86900 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -105,7 +105,7 @@
 #define HCRX_GUEST_FLAGS \
 	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
-#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
+#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_RES1		((1U << 31) | (1 << 23))

-- 
2.30.2


