Return-Path: <linux-kselftest+bounces-31008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9AA91075
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD0519081FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6317204599;
	Thu, 17 Apr 2025 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZB1ePwA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C818FC67;
	Thu, 17 Apr 2025 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849589; cv=none; b=Dt57PJ0RsMFiZW6+mzhuMqqOtbexXCXJA9flFSRxCbkyNZAiN8rAbZ7Io7Z9Kv+EuwT9od8BYQ1a0A184o/gvlMSWUzR2dr4EICOEq/gFWaEHljzNa9r3RVFR7JR/OMzQbky5pXX745iWkfpIG+Fin5NAI/MIBXfQNidqMWyWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849589; c=relaxed/simple;
	bh=W9U/EIqt1ZpD/AI0aRJHQ2z1yafgwHeiK/I9nw34e+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0Tbt02ZWYQo19fIVz78MnyDwyodpTcYPov+TV5HB352DowfMokSA470pqF2H7nvtGsdFLT2T5xQQqHZP1oP7lp3iwTehlT8//4hBse0HL5ycz4O8mk5zyHzjuW4ZEM/CtmCJk9QeTW+ZYuDzfX99y7/8ykZEJXh2OaCT2CWE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZB1ePwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F318EC4CEEC;
	Thu, 17 Apr 2025 00:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849589;
	bh=W9U/EIqt1ZpD/AI0aRJHQ2z1yafgwHeiK/I9nw34e+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XZB1ePwAD4xn+kJoCzFpd9PuTtr6S5KPxV1NdK5h9rwlIB1fu5BOjaSBoMLeoFljC
	 d3hoM788Nb2Q+znfBYo4J6DY7y81WsdY+s7T9yORk++gvuL6ynpUsZPVfUE8aYIe17
	 /SiZPeyr00dmOmuwOsBZlignpz70ACSVrF61s+Dg5sgauSXzyjis7sSg2mdR5yChuM
	 mieHx3FL76zZvMhquRJwjoUQRUdp4le58Y+M+/7N0alMge8/YXpohKgTZfZwp75AcQ
	 1b9woftk7JTlKNLalyIPwAzViDxFF1psLyyfseKG2pxHmpagbnFHMU+M/qgRi7CdXq
	 eLtRvkvHIQr0g==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:16 +0100
Subject: [PATCH v5 12/28] KVM: arm64: Rename sve_state_reg_region
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-12-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W9U/EIqt1ZpD/AI0aRJHQ2z1yafgwHeiK/I9nw34e+w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEp4aYB+lTSBEvBGlKqa5ArcHrjS9+NUYvf34HDS
 cs96KduJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKeAAKCRAk1otyXVSH0IxnB/
 oDVpFjTwsx42rNNBW7KDL0zDS+LJuIuMIdcu0iQzS3p6e6NkHvYdCO4fht5WtwUKx+dquGFKVQc5af
 DXiz4X8MJ4NbvNT7t1dMMrJIVYg5rcVqj3h2EXiw7HxLT9Au/UdbwfwZlLzbNs8dk+JKGfcg5piFig
 WLlJoOys7FyombKnLbu/Vz2KqHF5s8mIL0orW/zYKSf0iZfOM5R0AQbxlNVzckUcTAzfWzh6CP6XZI
 GMHWMx9RdUdUFuRXJIgJeCfpy797RhiTnFcO4vHoa0vavS9oNL+tqKluCpfKYyVENkUXF/tEFqEOQ7
 IHZBdPE+BY7TnXf5jCQPFrxg9EgSVb
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


