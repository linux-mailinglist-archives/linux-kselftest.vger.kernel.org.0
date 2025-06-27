Return-Path: <linux-kselftest+bounces-35989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87DAEBE66
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE537AA041
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07892EB5BE;
	Fri, 27 Jun 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acs+QkaA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07222EAD13;
	Fri, 27 Jun 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751045113; cv=none; b=ByJvLzAe2Pi9yssSc86EGZniF1EIp0VRmT1edLBAdVmpOhbRsfXmAoFhN5NlPp34DiTuaaHxmEClEwVVxc09++UDL/5TYgZfu72kXfGrlW9LeWy8RsC//XtyIbIYLJsNrk7D9pj/qLF1mFU2HXuzXyc4bK2+Lp5DOOt1WYes9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751045113; c=relaxed/simple;
	bh=90CTXdhM4nXMyJJrevGmqFnP/+4mWVosryCVClyymX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNQTH+AQM/+B9VfMZvAbhYvvA5Sy/xG2GgPNuaBtg06jhqXS+siqiX34aSSHErn+8rjl+vjWQwQ/KLH+eYWf3GUgxMn/2rVepAPEzawDqtPB6AQqKWT28SemzePYL4MyLTjiSuvOf0c+g5s7mdrH/9g29mDUjOJQgJvQfsv7/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acs+QkaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F2FC4CEEF;
	Fri, 27 Jun 2025 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751045113;
	bh=90CTXdhM4nXMyJJrevGmqFnP/+4mWVosryCVClyymX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=acs+QkaApBJ4j866g1JzSz4mabzMzDW/EbRNQufSODvNdSW5J+TUwkNy2ltyNwfxf
	 S/uO7eEust3ue0lx77kAgy3XPEGut1hMwWrxsQ/BanH/TXTiMKHeUpPkgYxrbCEKBS
	 aLlX2M7oGQAjpOvbqCU/9sZPtVzFaCdbjlSr0wtGALl2syRbs6I702m2Mn1NK9vc0X
	 NKAtMyKCwuwlB1uU5zoo1+X19QzQySq+0G9vgiDYjOlpRNsQdzYpl5AiV1/a7ZLoPs
	 YXxMFeXZpsklmoYxLLhULmndQsVjWhmEkE3H3c3b6HDw8bSE+z0tl36IeNBslm4mlz
	 HB5N7mgvQoqSw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 27 Jun 2025 18:20:45 +0100
Subject: [PATCH 2/3] KVM: arm64: Expose FEAT_LSFE to guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-arm64-lsfe-v1-2-68351c4bf741@kernel.org>
References: <20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org>
In-Reply-To: <20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoXtPvo1Q9IWlfzKdT2SxDbt/hCcoPGNEpIsh/n
 gf0f1HU6JiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaF7T7wAKCRAk1otyXVSH
 0FQ9B/9/31gIL2CSNg29xUMAoNbUdzwpDLkOhtKr0sZD8J8Azdb7a9Y1I55DicWXIYc6+7dMUQy
 tGeufBHdm+WUCloBnS9xwszmL9FzhyLcfwFiMt11+RN7H0ZAMvYEr9dGwHgouNr5GZ50fMZQkQF
 /05yQK7m7tUBD/8JYAwvoRfRQ8iRRjCBMIHZwiUnEVJ+FlhF/xJuVsoYO/BaQPxfTJb2/77CM2B
 4+t555LIJiQ/wtwETAUZUpyM9iAAislTccKpyGVuPg+a4TzrwJIDDMufJP7oxrkCbp/0QtfE3lQ
 f1QrsxPfN/gt6ARLWACnW6K+/Vb89ZoZJOXmLLQVaqew2m+N
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


