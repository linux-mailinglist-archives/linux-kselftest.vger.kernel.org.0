Return-Path: <linux-kselftest+bounces-36471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C3AF7DCB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFDA5823D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBEE2571AA;
	Thu,  3 Jul 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEixGJF1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA74256C8D;
	Thu,  3 Jul 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560013; cv=none; b=gb+jJcLvxS7SBLsAGUblbqcayarf0BEhlYwkIDEUO74899GJwyZ1KLC+3HiWw+hHeTvhN/nKQ+7hWzDR5XXMFDfeTaI9N7IUUuXC2p8pUCjPmrqqFRhktoH9VNTKcjKBSgoGazMoTM6VMKWI34lyUUPEoV0b9Zr+LFaeWaNxgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560013; c=relaxed/simple;
	bh=90CTXdhM4nXMyJJrevGmqFnP/+4mWVosryCVClyymX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjJlpFhuuiyNT1zCAoxU8RhFeuyJQj0tFbHTkLxnas1tiY+NBDcrYhf6euHVEZk6/c2WxxwSuTtveaM3hzFy8aE7dV5EytLgGg6VvDclsfzCWso8K4sHfJaQhqZbvo1xyzNEbNT+RUd1+cZgNlI4F2uvD5KokpfuGJBFPXcPB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEixGJF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6259FC4CEEE;
	Thu,  3 Jul 2025 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751560012;
	bh=90CTXdhM4nXMyJJrevGmqFnP/+4mWVosryCVClyymX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CEixGJF1mZ2cvbi1whnnoBju4b6BNMXqM+52MvLEa731G3dWLfx7wm9QqaaE0ff6w
	 92x6T0QqUD7m+vWr6+Wi8RexCsndRtgvTUsnnRSCmCpYhyt1P5aOqUp/lPCIDL9PWv
	 E2NhPFlXGMbz6LhfjRDr4NwbpvmJ7eq26aWN/HMfSkAkB2OB5sVVwxkx3CGpwWC2Zf
	 RTnvzGswGgYT0OLz1QS5MqpTnWBLof6z6CS/kiZpRSnKNAEq3i+r1QYDwmDpVaYlO/
	 XNHFznVxWDeqC6q9Rl6J8wbcHBjkyyMKYKGlSBJR1QJoeLdkyrByX9yEqaYN7VBgRF
	 5AIaCR3s2l3Rg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Jul 2025 17:23:23 +0100
Subject: [PATCH v2 2/3] KVM: arm64: Expose FEAT_LSFE to guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-arm64-lsfe-v2-2-eced80999cb4@kernel.org>
References: <20250703-arm64-lsfe-v2-0-eced80999cb4@kernel.org>
In-Reply-To: <20250703-arm64-lsfe-v2-0-eced80999cb4@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=broonie@kernel.org;
 h=from:subject:message-id; bh=90CTXdhM4nXMyJJrevGmqFnP/+4mWVosryCVClyymX0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZq9C+PfNQji4jba2ZysHPz8RoGObA6Pa/ZuWX
 F9jDQV8oHmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGavQgAKCRAk1otyXVSH
 0NURB/9mggTPUYzWc+KsavFv2cEdY88MaY/uPfK+lU0MZ/eV24pYzWxdyncYKMlpvGOTW/22arP
 LU2zJ7Cl/P9ppUb3g/ZXttd2/xPMyK0YtGfiOiNhXCmqHEh0Z3lQ5e2Q8m/p7MMsPsoncg0Fm/X
 yGVSILA+DZNaV0LVr8Xn2IM2F/8VAKutGl+eZrB9egoZpVRamvADN9B7neZ6T/QCFYOWnzONmRR
 RHELmLfa6K2FKCb66+BrJVabOZGUeG4xEbYMPjlnBj1iBZZZNxc6IYH/Nlp9em53JThcIcqADab
 l31LOKbssiK1EmDk52tldTp9jYGCP+85/8XlOzI77kCwqk1p
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_LSFE (Large System Float Extension), providing atomic floating point
memory operations, is optional from v9.5. This feature adds no new
architectural state, expose the relevant ID register field to guests so
they can discover it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 76c2f0da821f..be685422bf9b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1636,7 +1636,8 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 			val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_WFxT);
 		break;
 	case SYS_ID_AA64ISAR3_EL1:
-		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX;
+		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_LSFE |
+			ID_AA64ISAR3_EL1_FAMINMAX;
 		break;
 	case SYS_ID_AA64MMFR2_EL1:
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
@@ -2921,6 +2922,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
 	ID_WRITABLE(ID_AA64ISAR3_EL1, (ID_AA64ISAR3_EL1_FPRCVT |
+				       ID_AA64ISAR3_EL1_LSFE |
 				       ID_AA64ISAR3_EL1_FAMINMAX)),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),

-- 
2.39.5


