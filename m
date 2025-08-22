Return-Path: <linux-kselftest+bounces-39633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B258B30B3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D9A162478
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FE8281370;
	Fri, 22 Aug 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxJBRy4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E41E51FE;
	Fri, 22 Aug 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827716; cv=none; b=dIx0BInMuKT/rZeXrSwjwnm1eTBUKds3OCD7cKg+oNfAC0PutaPq1FKuT5/PZe44CAPAU5Fsn/bDsNPD29IdbovyL4ts6HNqvlzreBpPKGkIsqNlGN3FjBpjAwEvle/gMDP3RwoRiKGSWwKSrNxi6MDXTDger74QNDVWZyHqfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827716; c=relaxed/simple;
	bh=JcuB5ad9okGlXfOvq/M2PLI+WEiTQG4p3nyWXh3yr4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJOx2zejJvPg6gaqFFunQ8mAqS7qBjL1HqbB7LxSeInGB/osraRH1Ev7vYAh3XgWZn6cO56s3HUIXlpS0mM8xPslCZwRpZypBBrNrcAgnNk0mq3RVYGNWynXKCV0lng+UkD4pBSQLnGz0Exd6F8F9kAHpDBykkZaFTmdvfUslnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxJBRy4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C949C4CEED;
	Fri, 22 Aug 2025 01:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827716;
	bh=JcuB5ad9okGlXfOvq/M2PLI+WEiTQG4p3nyWXh3yr4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TxJBRy4BElKmGssn/oPyIydK7siRMUN67lZC2fbwAQAUHx3OXdkSY/SRCeLVVGYZ/
	 1G//mwpqC3mDnyp/T0PogWKZQHRm32/6WBh/vATFEP+a6sEH6jJXHBA/iw9rDslucI
	 R/HYclgTmiY4lA0hs9O0/sW6drG4DHWSr4GIRHRDlsvRPFDaHULQORSJIsZcyA2f8v
	 B+wMt95zPHMio3fH1ZNj/FysRHJJl/nPk23h8sxeHVr9V3CWSYzTQE+AJFi3jGpcHA
	 qlGiCAWvWDjtXCUO9rDmuxMMoChpiiixb+9iVa5ERhDI6LZWrXFzz4NTqFlFAtsVfu
	 ci5+zfkagLJHQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:42 +0100
Subject: [PATCH v7 13/29] KVM: arm64: Rename sve_state_reg_region
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-13-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
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
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JcuB5ad9okGlXfOvq/M2PLI+WEiTQG4p3nyWXh3yr4c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop83C32/fF+7vJ0QyOE9+3q+NxhA/xjngeyDc0
 QcIxgvldM2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNwgAKCRAk1otyXVSH
 0P4rB/4vaaQhmA5bOgn6t6N+tIcos+QUPnK4+NAYZT7YjYjib34p6kw1JAcMmYbNJLzM7SBki6D
 pixEtkvuxIRciZcrQgb9XkMMielc1vXkq9ETfDrYcKuagLtrXZES0Llz162JyrYm1r6RNUPJXCc
 QXUJhmeIvnnV8xLR4BVjYUgYXsot9eFxPQ5QO85rFnB5mLJqbPq8ohNmPZE9HtLxf3UrfA8cGJM
 jO6XPLJrQtc1aTWlJo5l0a2yVhIKLkIaawX+mdU8G3BwQ/fbm92A8bS9Ugcs+lEZ6oNdbvGQKqn
 TIEUPQX5TEMVtuk1iM/6SnqFUHZdONrkDjMJ5w3v6uwueMvq
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
index f38b95a73169..6eb273b525d5 100644
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
2.39.5


