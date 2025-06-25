Return-Path: <linux-kselftest+bounces-35755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB6AE8115
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852CA169568
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5F2E0B6F;
	Wed, 25 Jun 2025 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+2H7eTT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410102E0B6B;
	Wed, 25 Jun 2025 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850731; cv=none; b=EqEStT1LaFVut6tQktgGR3GZMrzgrk845znwU1zZsvr5j3LBim3qEvdoPUlHRyFBdM2QiofZ8XlgEwmjFUcjlqkG/vxiFOXWnXTDLeNH03kiQaD+LkCWNahLKf4KV+Fw2nNpdgpn+FYzvB82kjMEU4bb7X512ZFYgyCu1qF4rGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850731; c=relaxed/simple;
	bh=W9U/EIqt1ZpD/AI0aRJHQ2z1yafgwHeiK/I9nw34e+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQjj6SiyUHmZXJGRfsnjFQlQanOc29xajrYphEp/V13BtBaBk9Gk7YN/frhtv1apB1MEXPyHcNyp88ZYLcqr0KppFyKcbjEt8M/3dkUWE6ZQUWik2mE9a6A/2e7FMxOhdE8CW7Y4UYIurMH9sXRqazSMVFgJZ5066/ByvWO4BcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+2H7eTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9485C4CEF0;
	Wed, 25 Jun 2025 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850731;
	bh=W9U/EIqt1ZpD/AI0aRJHQ2z1yafgwHeiK/I9nw34e+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V+2H7eTTou2LPmRsoyHFKKW1ucbit5iYvbYi4C3q+ILw1gKSwzmwacAh8GO1c0oz9
	 aEytJrH4MjW2EOHusaGO3U75kFTJTcKkHIjMWyIqNJTYyQn9HxRRMrO5VR2+wACRkl
	 Ntn+uVseUE1USrafH9aeCVXM8f0oStjmhUj+/EE84U32wahg5VZe1ysgp7/+CjDar6
	 LAMrqX9A+vv6i6pw3lk2DW0SzoIZhvkiEoEAWoaZmov7+NsDx8u3NBNUoTD2K7UW1y
	 mssUg7N/B1LGwkU6GT+I65Z8kvH4epxCTDDjG0/5rSYSm53xuOMZPUMVJJvSo7dWs1
	 nYbG2m1hIi6ag==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:03 +0100
Subject: [PATCH v6 12/28] KVM: arm64: Rename sve_state_reg_region
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-12-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W9U/EIqt1ZpD/AI0aRJHQ2z1yafgwHeiK/I9nw34e+w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xu1x252uqPWFtsJ5pFaS4eq2IsZBBfqJWWR
 hyeVIEB1h+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcbgAKCRAk1otyXVSH
 0NpiB/9JcI9+qT73DRGWHjX2UOalqsoDE3sFgxVxQQxSlsakg2y3vXLZBMiG3jkT5VkNzAMGk2U
 pU/so4MdpUXjALC1Aux116+razdU+6Ya0qra3CWDQ2l9VtV7wCM7joxe45sDjiUPfOmt3SqM1CT
 xYexjAgSdfjWs0yXEG6tBZfZOKoGgFXaK342+DGIt9V3SSysH0Sm00EcXmuNH4SRQCLHRZLOVJu
 hfMYBjjGAY7XLrEKM9oVMzTJ3B95B1ZGobsWzF2xIv/uwht0ZcbA2XsQuQCpRdP/+8l1xuzeJQI
 FHrPa9yrwV/8rfHQMAwxuP0Vf61x4xx6PTuhPVLLEHDSix0Q
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
index 73e714133bb6..bb4b91e43923 100644
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


