Return-Path: <linux-kselftest+bounces-26616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9D3A3542D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0126E16D9D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D060E198857;
	Fri, 14 Feb 2025 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+F4oTkp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB114A630;
	Fri, 14 Feb 2025 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498505; cv=none; b=RhzP16kptaYVyHBOB+3Bfzouoj9ZZ8cs/4AS9w8Kx4J4N7xS8pO3VF10U3mvan9VDciMd25GZw2pS1I/eFlSMs8wIan0vaX2UHbVPCWyGEJ6CyAQEzlakI3iKMidQxEFzGF0TwlRtS8N/IGmEr937MP9J5DQ8mt+wVpyp5Gn9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498505; c=relaxed/simple;
	bh=7oEn9JxWKjIxLobpHaNyNb12TZw6+6uiwp1XA6eEegM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wa79P8j5SHq6GyIB+iQ40FuGEHrgC9Fnh314rzFiTHg2xmFIqSwJai9oqDs7ywZLQsOiSeZpPU3G9IUWBvtB0Qk4WAJ5V7ggfhGaz8Ad4hXa5x96SMWQOkWuMzDnA6uu2PWTooT9MIy0uFMKu71QVUUy1Coml7/RFVihJ5gL8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+F4oTkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8B2C4CED1;
	Fri, 14 Feb 2025 02:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498505;
	bh=7oEn9JxWKjIxLobpHaNyNb12TZw6+6uiwp1XA6eEegM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p+F4oTkpozV7snpFt3fdCgJVq6nKLyg+8JltSzmOX0er8Pnhusvsvnt2Ow0F1/38D
	 CsNUDXU+zlkiX7W9PJutlWUeM6gVTR5UhMwtnz/zhBW5NEamT1NdIE28m7VZ6Nq+jl
	 jUDppL4qH/OkikFuN5Ss3C5P4TfTuPZo5/cfvTT/kxQkNTovI+MDjJA0BdQVIRgyZW
	 T4rItVd5tOdlW7IiITsS8JlTiMyDDq0g7W2mfNTV140LGv1Pwh+xHO56tUvVschtDv
	 cAEteINxVg8RnZ78/1p7KoWv1mI/SzYskTdfa4Pz1P8FY9zRSNTToo30EmLi1I+ZLY
	 RpAMhMt+x3J+w==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:55 +0000
Subject: [PATCH v4 12/27] KVM: arm64: Rename sve_state_reg_region
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-12-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
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
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7oEn9JxWKjIxLobpHaNyNb12TZw6+6uiwp1XA6eEegM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPJB9CR2UPbX0fWpOibgiY5nxylbHYm5jWAgsCo
 Jsy7w6iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jyQAKCRAk1otyXVSH0EfWCA
 CEkw7voavvsVuT5pnWuMXdHPi0zjHWDseDCrnmxlGUHHB9AYDra2ISrlAWxVf5nw5nV0QQ3BSZJhh5
 bow6ezrC/HZJJBr6rTKKfbS1mMBNSqH8SjY2ilujeh/JYS1V3ZW9P6qumTwadR81zhb/fFrxwtH0w2
 QFynp5VAST+RMHDUPTgiOJBMHURjQ3wAWVqXLfVq2Y+S2RlYBWX14aQ3n8b6aEk09GI/lpoT5cVK5S
 xOHqIkKXOZS9bgxxDCtV8ap4fho4yX3DQN5nkgw+K/YYapMwFvzYskdMIoxM++2lhbvJbGYLRwfd+X
 8t/IBJmcgFcCk4aGTOQEO+nmmJp/sh
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
index 73e714133bb647c1d50fc67d5c8bf0569520a537..bb4b91e4392359026a4115468138f16f48a5b850 100644
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


