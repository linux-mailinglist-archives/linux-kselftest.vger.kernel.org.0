Return-Path: <linux-kselftest+bounces-22744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3D9E1CA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 13:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70A52839C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A9B1EE000;
	Tue,  3 Dec 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doa94yYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101B1F76CD;
	Tue,  3 Dec 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229847; cv=none; b=e4zDfxBCaYlIZT1KJ4TzLxsj06ZDdO71SFPvb8A305cBCIun4fwwQVHOmWVEZ2BvLKegDPakflu6FSp8TifGFQRI9lW3gtZvI7e8Yy17wH+/FtSUd2eiSJOQFCsFj1fQZoHaALQ9BDSZ3nyo0mDrvEX75JjQiIsHuF3BUwameiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229847; c=relaxed/simple;
	bh=cKym5jL1wVVG9G/7MeEDQVRM4fdPvM6wIXw2UfuLn2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVeyG01WNN/QLmq2Vx3rNAtmObwGd/0Tkzj2KW8nts4eIqwHbuML4FpNMEeT826ZTtB6l/JIFC36jl25/jm57ku4DEiDJzy0F+Jgmh5RfXIUp2ZavTWAXAHxfW4O74ayyUFnpPK76csn+Su3z2V2HZ45dWEk+2XX2AMSKKfIMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doa94yYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B10C4CEDD;
	Tue,  3 Dec 2024 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229847;
	bh=cKym5jL1wVVG9G/7MeEDQVRM4fdPvM6wIXw2UfuLn2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=doa94yYBy9haMntmlbm8c224q3RdvwGeJTtBfIuunDMuxA/jckdpBeET9N/vCXe3M
	 P/uZFfWnsV1iRI3k/HVF1BcJ3/I/cMP+Dsw6HpYPcCyDX/qPwO6mKJ+8Liw122qs3b
	 1wUv1tD9bLYY4Nl7EBPUHMkyAWLElHjBhyEjmZM2+cuPejgcem5Anoy5Erw3jH04S3
	 BXXL2CbhjwsJ9rGrw9R1FxFgMFBK/J+oCFcfM3r9QqbmOTrc8TJRstbJzqQtQvJdbO
	 f+KNGpv1/24jPu25x+aLSbVSHFg/JixPYpPPpB04UkcA72SvDlfAD4XPL+PgTk5Auy
	 2qVax49I3Hmrw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:39:27 +0000
Subject: [PATCH v3 8/9] KVM: arm64: Allow control of dpISA extensions in
 ID_AA64ISAR3_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-2024-dpisa-v3-8-a6c78b1aa297@kernel.org>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
In-Reply-To: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cKym5jL1wVVG9G/7MeEDQVRM4fdPvM6wIXw2UfuLn2s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvz6aOsLhl+VMGWa2eZFsaOppvS4Wo9lfr2bBE7B
 cuzMesKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ078+gAKCRAk1otyXVSH0DLMB/
 wM1MdmguAMfWES2WtJrEu9ppWGk1VrwOELT9b4yycTmmf8cCrot4U5+T0rMCUJjKDXNi63T+rWFwYz
 6KNVeuiw4ea+juUNnOwWXQ7eqa3DKo0H3tmVFdVCDxNJ7FHEkPTwjBz6j3mIYYrTHaaaPxVHmeAQHv
 GdNrKyGFVcHTOG6MRUxkjfQ0hl0vnrbmdedoMHP/93jYVp9Yau9VzUgWbxEwn0pEgUnqkv4IMUzyIK
 O5q/Jxz5jN0aMb94BV1AzLeCk3nXFEWu6JZfCqX8wYjnVL3qntlOsc5KMulVRXPj40KqEitAbJN7+D
 lbu4yAt6hmPywZJ7M19w7bz2ddCz2x
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

ID_AA64ISAR3_EL1 is currently marked as unallocated in KVM but does have a
number of bitfields defined in it. Expose FPRCVT and FAMINMAX, two simple
instruction only extensions to guests.

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


