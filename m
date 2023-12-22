Return-Path: <linux-kselftest+bounces-2397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1803A81CD00
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25521F23678
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F828E16;
	Fri, 22 Dec 2023 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaBeGfnU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BA381D0;
	Fri, 22 Dec 2023 16:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869F1C433CC;
	Fri, 22 Dec 2023 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262167;
	bh=erKmP1+KRvCsawhhhe4nJbEyfdI8hL+ADP+7cQBWi9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OaBeGfnUWKSCJzcli5tq5HPhmDN/vcCn1bTW3Zm0EqdLMYKQADQfxX+RNNDLcA/q4
	 yxhrHtn6i/SIi0t8odORoSI+ygZer0dVr0+1m3c7htYglv+ncBf3iUu76OS/N9ADJ8
	 8DMKc0VxVubBJlSyIFFbH/O91N9CRlvIftcePb8JFZG70JO3QNeCt5H6kq4btkVYAg
	 cZS3qq8LeOPT4zH4cfBXtFExxMbHNcLPgelyrl1Id6Cigs4dlPe/meITqA44QU9ckE
	 jxnI2G4qztYoe+KB7r+SIR+Nd7UZEEVp5noyuvrYROwYh9vB0hQwWR4G/Esmbb/aSw
	 dqzusTlqb7zGA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:28 +0000
Subject: [PATCH RFC v2 20/22] KVM: arm64: Support SME version configuration
 via ID registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-20-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=3167; i=broonie@kernel.org;
 h=from:subject:message-id; bh=erKmP1+KRvCsawhhhe4nJbEyfdI8hL+ADP+7cQBWi9g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeLhLDQdZCQDGvVU56BduCxr13OszFWMuB28bHc
 GpBU2GyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3iwAKCRAk1otyXVSH0OxPB/
 wL3g48tDcGWWMTxXzGD2MdoTLotiAlvcsXv1f8jv4/LRsyIRFo+OjZt4FsiEafWz2qZN0smpZPOohs
 I2NZKY5ueyBufz6YBirYPF4PLVr4+G4LLL281K0UQcTLpzYx1UOx99RLuqs++7nd3U9EOKv2yBDkkO
 qvrfLniCRHFeuZWb5SIclqzBStZh0TWsEAedCYiaEQJeyW++kWzUJrucxgzMZlScxEeE994irUDI6A
 24WLcBf0qN1tCNsjZU6jS+r4tKJOTuu9sUbL+RVoyeUD5STOrrn02yXlaDt4v4wSmuGt0dOO0hJFlN
 DYioFheVrYglObULV8hfb9v2Bjyx0e
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As well as a substantial set of features which provide additional
instructions there are also two current extensions which add new
architectural state, SME2 (which adds ZT) and FA64 (which makes
FFR valid in streaming mode SVE). Allow all of these to be
configured through writes to the ID registers.

At present the guest support for SME2 and FA64 does not use the values
configured here pending clarity on the approach to be taken generally
with regards to parsing supported features from ID registers.

We always allocate state for the new architectural state which might be
enabled if the host supports it, in the case of FFR this simplifies the
already fiddly allocation and is needed when SVE is also supported. In
the case of ZT the register is 64 bytes which is not completely trivial
(though not so much relative to the other SME state) but it is not
expected that there will be many practical users that want SME1 only so
it is expected that guests with SME1 only would not be common enough to
justify the complication of handling this. If this proves to be a
problem we can improve things incrementally.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f908aa3fb606..1ea658615467 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1412,13 +1412,6 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 	val = read_sanitised_ftr_reg(id);
 
 	switch (id) {
-	case SYS_ID_AA64PFR1_EL1:
-		if (!kvm_has_mte(vcpu->kvm))
-			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
-
-		if (!vcpu_has_sme(vcpu))
-			val &= ~ID_AA64PFR1_EL1_SME_MASK;
-		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
 			val &= ~(ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_APA) |
@@ -1582,6 +1575,20 @@ static u64 read_sanitised_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 	return val;
 }
 
+static u64 read_sanitised_id_aa64pfr1_el1(struct kvm_vcpu *vcpu,
+					  const struct sys_reg_desc *rd)
+{
+	u64 val = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
+
+	if (!vcpu_has_sme(vcpu))
+		val &= ~ID_AA64PFR1_EL1_SME_MASK;
+
+	if (!kvm_has_mte(vcpu->kvm))
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
+
+	return val;
+}
+
 #define ID_REG_LIMIT_FIELD_ENUM(val, reg, field, limit)			       \
 ({									       \
 	u64 __f_val = FIELD_GET(reg##_##field##_MASK, val);		       \
@@ -2164,7 +2171,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		   ID_AA64PFR0_EL1_GIC |
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
-	ID_SANITISED(ID_AA64PFR1_EL1),
+	{ SYS_DESC(SYS_ID_AA64PFR1_EL1),
+	  .access = access_id_reg,
+	  .get_user = get_id_reg,
+	  .set_user = set_id_reg,
+	  .reset = read_sanitised_id_aa64pfr1_el1,
+	  .val = ~(ID_AA64PFR1_EL1_MPAM_frac |
+		   ID_AA64PFR1_EL1_RAS_frac |
+		   ID_AA64PFR1_EL1_MTE), },
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),

-- 
2.30.2


