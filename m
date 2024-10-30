Return-Path: <linux-kselftest+bounces-21140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592D9B681E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BE51F22A3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B9215C59;
	Wed, 30 Oct 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiGplVAK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB48215C45;
	Wed, 30 Oct 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302853; cv=none; b=KUAHHCAJ3wsdMLHwAGGTPH7scSAe1obIB4SwhOP65l8xg49IiKYBmwI6IYTocZcFNOJ7woC1dCzFkMrhBL8DVPQKN70kD/E7HJWjOEnDJbvcFQtRvUZSm16lrH2EDJkSMO0G9QKP8vo0aWGhkWg8OZ5ubaGFqgoW7SKENw5Wzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302853; c=relaxed/simple;
	bh=+e1UOR5/B0UfboGAjExW6hKwnbL8AeMxgKnzh/ZXops=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giWu3zqqnhsmlEbBz59toLjihaguFLB/Si8dhFAXQmuJsEMWE4WqLEtbz4JSssZ1YCuZQBnc3pv22ADnk4iKohHNL7aWos76z0aZiE+NuRA+B3Mj7dJ2k/EJMCtMj1qpsU+KdlrQYSCvqUyDFMiynlkXjORGEIOd3M48veQ2LTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiGplVAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BC2C4CED3;
	Wed, 30 Oct 2024 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302853;
	bh=+e1UOR5/B0UfboGAjExW6hKwnbL8AeMxgKnzh/ZXops=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZiGplVAKP/U0sPI3zrjQwlgrORoD/Amz8RG2YL8LiSywrRHN2Cx53shmKrHXi4ZZJ
	 IMlUNexuRk0B8sjORDsqyFAqjW1SKjOVbu9fRGtRl9g/o5D9vcj7ZPEKyqffWetv/E
	 JwBkxiBpEonNAu2wwn2th5ekYTPmreqO3QpewtU43MtXa181QlF6jruQrUjazvErD3
	 bfNs6BFcfhM0IFx2hL+0iNtdjF1iFQBzLx4KTvk9vrLiHCTUXhB8+8pUEO51KjrbOT
	 JauqfSLvvl8JsupLyDuZ3w6lkWvBrfI/8IqPKuqccvrQH+LMYwapChXM63t1Gbw4nA
	 tLO+LsNaiTFFg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 15:34:53 +0000
Subject: [PATCH v2 8/9] KVM: arm64: Allow control of dpISA extensions in
 ID_AA64ISAR3_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-2024-dpisa-v2-8-b6601a15d2a5@kernel.org>
References: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
In-Reply-To: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
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
 h=from:subject:message-id; bh=+e1UOR5/B0UfboGAjExW6hKwnbL8AeMxgKnzh/ZXops=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIlNnMV/Bo3GWRxDAxp2dKrn2r5xbzZLI28XXcyJj
 S/vf/W+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyJTZwAKCRAk1otyXVSH0MmrB/
 9Ayd4qbzVp0FBgF+pAqcgt/GZZQJDrGD3JEkOkV3oLoZ6HX5hGK1EC20D2lyeIhou+1QN7T3fPf/g6
 hAym5gRgz1U+7RsMrWe0kL3dOVZJa3RWzBnEgLvZhAu3H8z5PPbnzjzsgeu4YCahJyWAiwJYoGJkmC
 DUiRdx46Ue7gTazRpesGHxh4bXETEnshESOaBNS0eyjd4bI/yXCEJXhZ4fJBcY0p9USu0L7omP+1qr
 e/y0TbChayabDX6HcYTAGjePCKLKa68Yb+mRjImKIc5G/9KDo3A4NHCIhSd4cqbsgJPYyH46/ViA7+
 HLJE52nGLzQliFbGhwJ6jJgsR7t8Yl
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
index dad88e31f9537fe02e28b117d6a740f15572e0ba..926b6a1b2d2389e95721ce577740a2fb740e4f6b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1546,6 +1546,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		if (!cpus_have_final_cap(ARM64_HAS_WFXT))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_WFxT);
 		break;
+	case SYS_ID_AA64ISAR3_EL1:
+		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX;
+		break;
 	case SYS_ID_AA64MMFR2_EL1:
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
 		break;
@@ -2409,7 +2412,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
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
2.39.2


