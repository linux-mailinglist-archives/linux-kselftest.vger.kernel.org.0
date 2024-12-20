Return-Path: <linux-kselftest+bounces-23671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA39F96F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D573616A4C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB021D01D;
	Fri, 20 Dec 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r40FRzzA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A021A931;
	Fri, 20 Dec 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713470; cv=none; b=cf/72tAfg15eal5yyEQyB4zEz9DpzN0GRgjaCRNL0r0OvyiduUPHqfBBYSAHOzXQQu34sPcpl2dqHmrM1mLezITxgBwTy2OUkpm6mY8wlID4D/lbAENk61q7qs9Z+ZJeusqcZoNgLwS89wExN629k5H8agj8ewPUnzYLfEO2H2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713470; c=relaxed/simple;
	bh=fk7img7pT6wgpuZQLS9waoWrhY76ao9cwX81iGcxSKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zh1oLFdICW7Ciwwl5f6f/4yBdLrxJ4zAN1AzwGGTYH3NmJwawcEasu8fF168NS4LE6xOoDu6nB91HM2nKGgl59QNv9yFNfI4FZL9+jVCtAfXDoZWHLV6mUbX7kNBueXkuJn8SsTOnhkMwT+3/XRUFZHyDSc6DjEc3nnjLggULBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r40FRzzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE162C4CEDD;
	Fri, 20 Dec 2024 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713470;
	bh=fk7img7pT6wgpuZQLS9waoWrhY76ao9cwX81iGcxSKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r40FRzzAD3sThPfoOUv5MyiG47YJJ0vUQJfugJx/VJ2FdIH4Jq1EQjAqh5xLDpERG
	 pRPOMBM0moFgk2Gk8JtejusZ97o1LMZON6Jz5p+Rs1HExLVpMmPpllE+R7lKLmspFp
	 YL+9ifTPscFe0nulX2K2q9kBmzbsdsydoAyevBAGYd8T4MHQC+I5y4ndI3DxxKO8tP
	 IhJCXqOmgFehQaX0nZQ7itPUxCjACzMYXxIPg4s+42L6byPdHRM4RXXGa8Jr3C0czi
	 AVunGWujtHucm8uUfArMp9QaAyonFMc2Uc31N+IQbyI3biz4o+k1ntq7W8YKMHHe1Y
	 ptJz6lfM1rerQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:29 +0000
Subject: [PATCH RFC v3 04/27] arm64/fpsimd: Determine maximum virtualisable
 SME vector length
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-4-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fk7img7pT6wgpuZQLS9waoWrhY76ao9cwX81iGcxSKQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBXHrVm0TzLRgpwCo4EdZG2bTDNm8vyq1D2fzBF
 7WlvjpuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgVwAKCRAk1otyXVSH0BO3B/
 0Qyd/4GV4pTYzevIebRa4EB3r1j8mUDGAUC466RIT9GNevbNxUj/nblW6f2YTc27rq9axg3XaNJxh7
 oVessmtZ70Q7Dt7AmJeBZ6jU24Sfa2pqjH05G8Xi+d9VU8Jy/vRa9fmom8LcX2vmJLtJixGNPcIg0g
 TaS5sQ2wmPvYfON+whNW9XgsG3MK4cdpIc+pPu90FNe9bMScnZ4LDXQx+PUvmMaZ8LhZY7PnXXOmzL
 8JNOilCBVafF3TGjr2asrEQvoLkUpeCRmlobv5NBg7g6dHGOAebedFOx+2B2r5cCRxZkgyT7g/Ncjc
 6imY3E7ReG1krovkI0/39Mtgs69+gf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As with SVE we can only virtualise SME vector lengths that are supported by
all CPUs in the system, implement similar checks to those for SVE. Since
unlike SVE there are no specific vector lengths that are architecturally
required the handling is subtly different, we report a system where this
happens with a maximum vector length of -1.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a6f9a102fadb0547b4988cb5b0c239ca90a262a0..d976708d84854846fe38a35a19c60ff36f44030a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1276,7 +1276,8 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
 void __init sme_setup(void)
 {
 	struct vl_info *info = &vl_info[ARM64_VEC_SME];
-	int min_bit, max_bit;
+	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
+	int min_bit, max_bit, b;
 
 	if (!system_supports_sme())
 		return;
@@ -1306,12 +1307,32 @@ void __init sme_setup(void)
 	 */
 	set_sme_default_vl(find_supported_vector_length(ARM64_VEC_SME, 32));
 
+	bitmap_andnot(tmp_map, info->vq_partial_map, info->vq_map,
+		      SVE_VQ_MAX);
+
+	b = find_last_bit(tmp_map, SVE_VQ_MAX);
+	if (b >= SVE_VQ_MAX)
+		/* All VLs virtualisable */
+		info->max_virtualisable_vl = SVE_VQ_MAX;
+	else if (b == SVE_VQ_MAX - 1)
+		/* No virtualisable VLs */
+		info->max_virtualisable_vl = -1;
+	else
+		info->max_virtualisable_vl = sve_vl_from_vq(__bit_to_vq(b +  1));
+
+	if (info->max_virtualisable_vl > info->max_vl)
+		info->max_virtualisable_vl = info->max_vl;
+
 	pr_info("SME: minimum available vector length %u bytes per vector\n",
 		info->min_vl);
 	pr_info("SME: maximum available vector length %u bytes per vector\n",
 		info->max_vl);
 	pr_info("SME: default vector length %u bytes per vector\n",
 		get_sme_default_vl());
+
+	/* KVM decides whether to support mismatched systems. Just warn here: */
+	if (info->max_virtualisable_vl < info->max_vl)
+		pr_warn("SME: unvirtualisable vector lengths present\n");
 }
 
 void sme_suspend_exit(void)

-- 
2.39.5


