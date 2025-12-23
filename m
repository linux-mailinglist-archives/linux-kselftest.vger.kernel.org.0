Return-Path: <linux-kselftest+bounces-47882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C76CD7C61
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02FB6309C300
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA72D6E6B;
	Tue, 23 Dec 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O16FGqKT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19252D5C83;
	Tue, 23 Dec 2025 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452948; cv=none; b=tb4d+QZbBi9vJSTmE2PBMQ1gyAfnnLah5BpBr+xOFMWoEokI3INgbBsjcQtfc8mtJnwqL+kmYdA3JKfBALaUuL2x1W9tcRBuLWSwkwLM4TdBd1DTK2cYg1az23AVx1GBcSPagejj2Dxvi0V9GM902iZ53nA5NqWyQi622SsM4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452948; c=relaxed/simple;
	bh=gfp0s8vq4GgXX2OhDBoI78/711AOqvXjX/EjV4hM7Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0dsCLg3nS0p3FEA9HgHwL3h9aEVdU06UNwubGIktqZ+MtxNiD8pWrxDXBvykp0XInjgBWHjYwHFEW+4sjFh9cvk4952hhcqfmvLXklR6NdlJUPRKzfNKhGQouIVF6V7V/VCUOoyKNdF/HRqXXvw/VjohyIHJM2OKaHRS1iSBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O16FGqKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7D9C116C6;
	Tue, 23 Dec 2025 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452947;
	bh=gfp0s8vq4GgXX2OhDBoI78/711AOqvXjX/EjV4hM7Ew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O16FGqKTNdczc4/lSuwlD8138gQJMp4jx7y/Ez2gACQQQQOeVbrimke1N8wcOMoWW
	 HJa+cUenUXOtb977SVm42D9WFm96+Sc0R334clTxAw/YhFxqtOaRJ3S8Z8kNKYCi8W
	 OmqdKB56h413grtXnz5KyTp3nwAhp1i5J/DYilqmE+LfPjR/VhQsnOp6rFO7R2Jbxp
	 e4CEOaiE0NIR05xpxYTSFn1euO6OCZl2p99U8vTpA5+59WKBpXlieg+c6p7czbqaSL
	 UYOF6Oetl4xHRptAo1TRRwilN6T5dgCMcCynUTzohRWk0E9OHzfSNtKIqPKbybMjmN
	 /29wPbOYOaVlQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:06 +0000
Subject: [PATCH v9 12/30] KVM: arm64: Rename sve_state_reg_region
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-12-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gfp0s8vq4GgXX2OhDBoI78/711AOqvXjX/EjV4hM7Ew=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6LyU2hP4tGR98SafeORWHn3VqVtWLVYEDpd
 9CqFj8boKKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnuiwAKCRAk1otyXVSH
 0NW2CACHCG80SVmspz99x7BNFLI22yJy0+S+koe679BIRDvbUunQDWWrfFfutWGJd1iIEAvK3lz
 1/JEhESq4l3slRuO6tHz7i6C+wTnYkKCKwZhkqAD9Nc8KvxlT+cAp6VjMNREnKwIdDel2kGMJRb
 Bs59xm00prmh90JqAMmJiVM0+fcJrZLjkLgqhgUaAY68qq/8OkCTTBRk8lztbdxCa5tzsR/7nfE
 2j6l3m3lLniNnkryNJ3tkDJpxhNmvuY3aL29KG4pGElJZ+Qo7dV6o2Gt3vkukCSzLR9wNrDBZ8s
 ff2/OUBH70tHxthXBek5qXQtyI4+QLubkHoYa19SIqi8gyuw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As for SVE we will need to pull parts of dynamically sized registers out of
a block of memory for SME so we will use a similar code pattern for this.
Rename the current struct sve_state_reg_region in preparation for this.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/guest.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index d15aa2da1891..8c3405b5d7b1 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -404,9 +404,9 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
  */
 #define vcpu_sve_slices(vcpu) 1
 
-/* Bounds of a single SVE register slice within vcpu->arch.sve_state */
-struct sve_state_reg_region {
-	unsigned int koffset;	/* offset into sve_state in kernel memory */
+/* Bounds of a single register slice within vcpu->arch.s[mv]e_state */
+struct vec_state_reg_region {
+	unsigned int koffset;	/* offset into s[mv]e_state in kernel memory */
 	unsigned int klen;	/* length in kernel memory */
 	unsigned int upad;	/* extra trailing padding in user memory */
 };
@@ -415,7 +415,7 @@ struct sve_state_reg_region {
  * Validate SVE register ID and get sanitised bounds for user/kernel SVE
  * register copy
  */
-static int sve_reg_to_region(struct sve_state_reg_region *region,
+static int sve_reg_to_region(struct vec_state_reg_region *region,
 			     struct kvm_vcpu *vcpu,
 			     const struct kvm_one_reg *reg)
 {
@@ -485,7 +485,7 @@ static int sve_reg_to_region(struct sve_state_reg_region *region,
 static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	int ret;
-	struct sve_state_reg_region region;
+	struct vec_state_reg_region region;
 	char __user *uptr = (char __user *)reg->addr;
 
 	/* Handle the KVM_REG_ARM64_SVE_VLS pseudo-reg as a special case: */
@@ -511,7 +511,7 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	int ret;
-	struct sve_state_reg_region region;
+	struct vec_state_reg_region region;
 	const char __user *uptr = (const char __user *)reg->addr;
 
 	/* Handle the KVM_REG_ARM64_SVE_VLS pseudo-reg as a special case: */

-- 
2.47.3


