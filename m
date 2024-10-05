Return-Path: <linux-kselftest+bounces-19101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B425A991625
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750A9283C9C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A92C14A62E;
	Sat,  5 Oct 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxNjaWC6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCE14A629;
	Sat,  5 Oct 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124671; cv=none; b=XpbcQgGy/kr+OaAQoSo9enjq9YNklIyA8uYOQZKf+lK5NVuIVhGEuwqe2nWr7szVo6onUBRgWycmFtYeoc4rdFD2ctNVMB2OcRj+IBkTkaQeU8h3FNivoBLiK5YJPxqfjDRgi1NgKSBAv8ONKaljWMuFJm0fNFwQWCLraVyUJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124671; c=relaxed/simple;
	bh=QbqPPtlt/36NRRykoSC6fOII09vEJC3Jof1+QZGywM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWo9Hxa0Poh4+CQKA5QJzAm/o3/GXcgv7BFJSrFEE8/jo9izAeMLNPthWMoK9v0/Np8gDZ3FUNlAM3NLCgtIw8jU0EfOhHSG7K6v27ta+XpZCOpr/+yTyHH1R8AM1cBxeeF/1HHSkVyklHOHIed3lo09Abk3GF5TaG0Qufv4CZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxNjaWC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48605C4CECC;
	Sat,  5 Oct 2024 10:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124670;
	bh=QbqPPtlt/36NRRykoSC6fOII09vEJC3Jof1+QZGywM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gxNjaWC6yOVVvp3TMQ8pK+Y47LltPtgyzBJ+hbuujEketXsOB7YBITOgP5KLKv7Fh
	 0OVgIm2Zy2Qv+TgKuM53JDZ7DhODgJyDbczWCtFp0lwX8evsnMSY2uiws08EDFZbIA
	 S7uJlLqOYDt+ORQZUO7qHLvlTUHqgcDCPZ4OqG0jUkSswAMhbul7bBaA47eREfnC0v
	 MyWuTKby6JtyPUuCG1V7ZtILpTNK1kBaFxU8SUU9wf/et7sw2bnlGmyBDz4u2S+IDV
	 er72uLHiXeC3rJ8kOK5V5nw1I90ecO3yGKerwsYlIPFT+S85q4n1J7V4SZTSE/0spI
	 cdeVdGYawuP7g==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:37:28 +0100
Subject: [PATCH v14 1/5] KVM: arm64: Expose S1PIE to guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-arm64-gcs-v14-1-59060cd6092b@kernel.org>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
In-Reply-To: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QbqPPtlt/36NRRykoSC6fOII09vEJC3Jof1+QZGywM8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARb1QtItMZjozqWtKsSdLOTTu4J0BaffKuWKVeZ3
 xoSzl+CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEW9QAKCRAk1otyXVSH0F0/B/
 46fuNQRlGNAqZbCOsnnF7mhJNrGYEvzbev4l+BTYXh44XesiYS4VZpe1sVwTTFzydKT2vwtcXeqj1r
 gFq4DV+cXQuGcasG5FqfvZjvHpZVvxC+bpYtEnSSrgUhrzBxzm0B6K38G6BtcjX9pMcCHVgAVHFqz0
 6uIIvXv+I9xLimBYJ9MwHXX89cP2076yXOdNqEPdOw7BXS0g/oFjCKNCj4twz3gbcpl9kHHO+UHsEp
 gA0FuiK1rK7f4ijpvSEJ8Bogm/mlGIL0T7ECRnUDMuSfMQkJvq6B0rc6j4CqjDfzkmQl8KbX3cFiPa
 O+vQmbbMc5a348nl0WSYEpAjxeyeRW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Prior to commit 70ed7238297f ("KVM: arm64: Sanitise ID_AA64MMFR3_EL1")
we just exposed the santised view of ID_AA64MMFR3_EL1 to guests, meaning
that they saw both TCRX and S1PIE if present on the host machine. That
commit added VMM control over the contents of the register and exposed
S1POE but removed S1PIE, meaning that the extension is no longer visible
to guests. Reenable support for S1PIE with VMM control.

Fixes: 70ed7238297f ("KVM: arm64: Sanitise ID_AA64MMFR3_EL1")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index dad88e31f9537fe02e28b117d6a740f15572e0ba..d48f89ad6aa7139078e7991ce6c8ebc4a0543551 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1550,7 +1550,8 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
 		break;
 	case SYS_ID_AA64MMFR3_EL1:
-		val &= ID_AA64MMFR3_EL1_TCRX | ID_AA64MMFR3_EL1_S1POE;
+		val &= ID_AA64MMFR3_EL1_TCRX | ID_AA64MMFR3_EL1_S1POE |
+			ID_AA64MMFR3_EL1_S1PIE;
 		break;
 	case SYS_ID_MMFR4_EL1:
 		val &= ~ARM64_FEATURE_MASK(ID_MMFR4_EL1_CCIDX);
@@ -2433,6 +2434,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 					ID_AA64MMFR2_EL1_NV |
 					ID_AA64MMFR2_EL1_CCIDX)),
 	ID_WRITABLE(ID_AA64MMFR3_EL1, (ID_AA64MMFR3_EL1_TCRX	|
+				       ID_AA64MMFR3_EL1_S1PIE   |
 				       ID_AA64MMFR3_EL1_S1POE)),
 	ID_SANITISED(ID_AA64MMFR4_EL1),
 	ID_UNALLOCATED(7,5),

-- 
2.39.2


