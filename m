Return-Path: <linux-kselftest+bounces-40573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7AB3FE50
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615CC2C5CC0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F02FB63C;
	Tue,  2 Sep 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeapaFPs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AAE2F618B;
	Tue,  2 Sep 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813519; cv=none; b=oBFCtD0OYA04fK+1xsfr64wsw+6v3AtJW92y7tWpsnecWEESl2jknP43gnBA3T3JJ/D1JMGjtMINPK7ZH3zXZx+Lt2MEjMIf8pYMxtxwdTamcgwZzE4DRPi7xIatAChI1jTsP9P5+8zPTLHjX9elUF1Xy3HAKnPFotyuNHdbUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813519; c=relaxed/simple;
	bh=JcuB5ad9okGlXfOvq/M2PLI+WEiTQG4p3nyWXh3yr4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMufDyhfbGgJL1wmHSp0qJNTANjrdw4JDMPIIbD5XbhDcurb1A6V2Pj6B04mLYg2GW3btiQcWBPljX0+XTgO9tn1PikvG5tV+4OZ4F0XBaCx9FDYKWlS1Xa0fSX8/SupJ8TNvfUx4X1oQ5I3KEmhjL+4I7hEUvvXucayzhdNb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeapaFPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC115C4CEED;
	Tue,  2 Sep 2025 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813519;
	bh=JcuB5ad9okGlXfOvq/M2PLI+WEiTQG4p3nyWXh3yr4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HeapaFPsOuaJuO8zENcjOE77JPfBIwTOCMRrOra9z3WeFMngcAPJKqaFJY/e/yfYM
	 mNt/A7C0RKNhGCBWgCtniznsK6akAv2OIxdm2b6h4KnFVklRih0/y7S6NBs0vv452k
	 a7HG+FK3Xbf4M7DORn781fDwLR0AdilYZVtS4BfK2WqNEdTYWspQ6pFPCJ8gTaaeZp
	 4OWMDXRpeRgbLUvCYbFutsjDwnbgmgxfGYc9XXde3+C1UjylpQbjDj+EZJ0wW2bKS0
	 xGkcV7p2F4TwnCwl8yjV/MkAMnEQTpNGW0K1P2eogzF9JCtWisQ205ueDpmsyOJiP0
	 62RyA2f5gIxiQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:16 +0100
Subject: [PATCH v8 13/29] KVM: arm64: Rename sve_state_reg_region
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-13-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JcuB5ad9okGlXfOvq/M2PLI+WEiTQG4p3nyWXh3yr4c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBottiEVhFwdz/qXdy0wHnP9UFZExCHy+Qz/8oSH
 DRaKuGMIy+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYhAAKCRAk1otyXVSH
 0AQ1B/9U8a+0/H9lS9eFV2eD1eghMokg0qYk+XDngVDPJbeIAVtzGUxmw0PRQ3a7Fi3IUQnkEiB
 sHmCZGWKhUu9sYMMPQUir4KMBl0OdEHARSv5E964K8JjF1alpWxdweqJWWb8zQ23LjmfDbvbXCY
 UsEFyjrr8Pa4HAjIfxApuT9a9b7sdO9AWAqsDWYxmNdMF7dbcPBCDu34S2DrSLW/iJUuY7o+e3W
 METIAtW0nlQoSZxWPhcPaamINw0qKMm7nWlp7T12Km2L3KYPCQaKpJNUE7LIV5E2GKOrBuYaXk9
 QYhxDMus1mGYBXj7BagdJR6gkrTyIlD+Ao9GwXMF+g8KXXBh
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


