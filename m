Return-Path: <linux-kselftest+bounces-31023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF342A910B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6D94605B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E35022E01E;
	Thu, 17 Apr 2025 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khJ9RHw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7D22E00A;
	Thu, 17 Apr 2025 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849651; cv=none; b=mpTHFDRvPyySss2lsO9i3JLtQyLmsX+PtJ7CQ/dzEW+Ms1U0uQ3YY7A4cRd1rZo/hoyhWhxJPc/T2rPxdsDrtu3EOOf7CLfPl86cRdFWDrakAJV4WNHsEJiMPX97ngc+hSetTLycepudTZGRByaR4WDH78a7jwIwhgZW13kFNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849651; c=relaxed/simple;
	bh=8wKbF7ujl1hlDs76hV4PzHiP9Uo97M2NjFijaiGNkbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXoHbWiQHebRLnbeAnqFEG0Cv8II/MZpwz5zSqsnzqhs0pv7qowy6bj2DdoTP/4NLjpQBGSU7u+G0CppOpPT6Th3z2SsMOG5X8U9QoD3vnqlA+RR2L7f15swW+fmIcq2kFxV7Vg1gnbrfT5RVqXD4R7ZnyYMSWMg8cFfN1tUcRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khJ9RHw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605D2C4CEEA;
	Thu, 17 Apr 2025 00:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849650;
	bh=8wKbF7ujl1hlDs76hV4PzHiP9Uo97M2NjFijaiGNkbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=khJ9RHw5mLTikw30MT0YwWM39KMMLBLBT6Krpr0l3eyfDmvICrx4DZuKChTJkS0VC
	 lb/WPUBX1dt85xLJyLEZF5n5qNGHauyTaJhB0jdMvfpyATUeFDQJqj6vRTgoNGuFlr
	 hLSnA/3A39QZBkq7Mz1qQm/5h7gk6H8NmUxCRqyIrniKuQyc2hlkCsrEShLXSxyoj2
	 7Oq6LaZXVwWTC0tNGKjkbGhjlEr7ztDsTTZ4HjsGTnyOmMj/KEOUjSYSS5aaWlnYK0
	 OjrIZ39GMQaoDOVLZs44Pv2jJwjNonqxK9WSLxnYsX5zmpMylbJ7rsT1gIniSz+1HH
	 vqrh8W0LDWTiQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:31 +0100
Subject: [PATCH v5 27/28] KVM: arm64: selftests: Add SME system registers
 to get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-27-f469a2d5f574@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8wKbF7ujl1hlDs76hV4PzHiP9Uo97M2NjFijaiGNkbY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEqEN0PBi+5sh+Ufd6YUKPCQBIGQCBFHgZHOLVxt
 MwC5Lq+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKhAAKCRAk1otyXVSH0IbxB/
 9kt29k0vrzqc7H+CKPAvHqHz2pM9oN8EKRlhOKwQxgaYKF86p42RWIW8AHBlgiRWuZBZP5CBQVs3av
 nd2ICQPqXMvFnHPCcfkAgtEVUJ+wMhvmX2+aAPYaCSc6L5WMZqTYZ9D6oy2mXOC2sqF6nCXTvICFM9
 T+QU8ahW5T1Exv31Drzd9sumQoIzb8KkWXGxRkay6FJsrgbbJjIw6plFpvlRsbiTYtkuP0+Zgmre2u
 Ne4dKicSIPFfHHvH4gz9SXuOvhAwmxLhSXVPodE/Lq/P0IW+FurG36AX2rbVIf06UvAWtzQL0BV9f6
 o2nzjXBnLBkjIPYFFikRXU14ERVMDC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a number of new system registers, update get-reg-list to check for
them based on the visibility of SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/get-reg-list.c | 32 +++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/get-reg-list.c b/tools/testing/selftests/kvm/arm64/get-reg-list.c
index d01798b6b3b4..920784aa2838 100644
--- a/tools/testing/selftests/kvm/arm64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/arm64/get-reg-list.c
@@ -23,6 +23,18 @@ struct feature_id_reg {
 };
 
 static struct feature_id_reg feat_id_regs[] = {
+	{
+		ARM64_SYS_REG(3, 0, 1, 2, 4),	/* SMPRI_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 0, 1, 2, 6),	/* SMCR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
 	{
 		ARM64_SYS_REG(3, 0, 2, 0, 3),	/* TCR2_EL1 */
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
@@ -52,7 +64,25 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		16,
 		1
-	}
+	},
+	{
+		ARM64_SYS_REG(3, 1, 0, 0, 6),	/* SMIDR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 4, 2, 2),	/* SVCR */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 13, 0, 5),	/* TPIDR2_EL0 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
 };
 
 bool filter_reg(__u64 reg)

-- 
2.39.5


