Return-Path: <linux-kselftest+bounces-24037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67767A04CF2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 00:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20FD162C6D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 23:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745511F76C9;
	Tue,  7 Jan 2025 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIw6FR02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675D1F76C2;
	Tue,  7 Jan 2025 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290885; cv=none; b=NNqzWhgZ50DEB4CAZOfYUW05jcn7Mav5bPItq7mDHOPeuW5zyWnjnuXr2AubrgRo0ZBwjr0+S0rUW5u1NZbP6NQ0vgtsGvwbWJ4Ho8/Zv6UZSxYCABk9GaplNjfjNUSuBQ9WiuJEcwHOPNBei/028tKFq2RlX9Cn8YFxzenSpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290885; c=relaxed/simple;
	bh=W8fINH3OVANmdQFVX+js38cqXZpA2truKvR5K6znyyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcBcXCpgY4ojjg0NyqOh6RI8iOF6faKWoKaCIyJoDCTxSdSXfDVcUFFO3Jqng8GiIKqjDi6kENk0v+fRWZw3EGdbjMFcshjOoLuCr7jCgKxYJ/DkRzDmTa4l3N2xzQVjQnEYyzHwyUgVxRYEE3EOX9of2IIetbdhj40XovCL7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIw6FR02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E54CC4CEDF;
	Tue,  7 Jan 2025 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290884;
	bh=W8fINH3OVANmdQFVX+js38cqXZpA2truKvR5K6znyyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EIw6FR02ctl7z3kfIqI2bf77wi8c0QSzXjcmC89JQY4MtldCUJEBlMAGfS+Hg62a+
	 kvBj9dnEDE97fx3gB74HCAYWmwPkDRVxvLogNn+p9pUhzUi0wn3P3/ak4l9ylgZpdd
	 SpZNgI5yPh2qQlblqT0PWDcMtlcY581OqY1A0pYTDCqPbhos63iw/q1g0s10Finvy/
	 Ec5CCOOPchxJv97KyXjiI+vN1Oml9ZCiiAkQvG30o8oVxOWSZAPdgkr64l+YeEtatt
	 oXmxU8oCcQlAAN5NB1Qe0LHekVsvuA//WbbtKcxDXYjbIXZLHJ3Wmz3m0Vnp5H3SMA
	 eVThIa+FZdLiA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Jan 2025 22:59:44 +0000
Subject: [PATCH v5 4/5] KVM: arm64: Allow control of dpISA extensions in
 ID_AA64ISAR3_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-arm64-2024-dpisa-v5-4-7578da51fc3d@kernel.org>
References: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
In-Reply-To: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W8fINH3OVANmdQFVX+js38cqXZpA2truKvR5K6znyyg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnfbIzV51I9sDzW6LbaKlT3yiu8P8lpBGtSObfUDPC
 dCxZk+eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ32yMwAKCRAk1otyXVSH0Gt9B/
 0b/5GPo8kXWfskPOztZz636lKq/ggWtkvBpiGDk3Br01bpbV68JWvM7908DnByeyzUJc+qFlAbR9ye
 IpRDbQ86HrpsNJwnmC5egOBqY/snrduWGMd7BIvUdv1Y88q46SpLRYj9k9y6KwefDDbL9OsTZzwonl
 pem+BRHEvKdUI+06b6fGWV922/2SsbMcQG/Af+81uIUJzAjDxMHWAbK5vDoDFtzoCDotezmI5wv7I+
 vWST20DT1eAUliXKVw93xPYa7LIuuZQXQ78sr9EoWtzMPq8GvDC4F7nvADhXTpBzNr+VVmoa/q4Zhr
 xaFZLOiYk5Ri/uc4EHGNnE9IdvAhbz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

ID_AA64ISAR3_EL1 is currently marked as unallocated in KVM but does have a
number of bitfields defined in it. Expose FPRCVT and FAMINMAX, two simple
instruction only extensions to guests.

Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 83c6b4a07ef56cf0ed9c8751ec80686f45dca6b2..6efbe3f4a579afd1874c4cf844c1c1249ae8b942 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1604,6 +1604,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		if (!cpus_have_final_cap(ARM64_HAS_WFXT))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_WFxT);
 		break;
+	case SYS_ID_AA64ISAR3_EL1:
+		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX;
+		break;
 	case SYS_ID_AA64MMFR2_EL1:
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
 		break;
@@ -2608,7 +2611,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-	ID_UNALLOCATED(6,3),
+	ID_WRITABLE(ID_AA64ISAR3_EL1, (ID_AA64ISAR3_EL1_FPRCVT |
+				       ID_AA64ISAR3_EL1_FAMINMAX)),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),

-- 
2.39.5


