Return-Path: <linux-kselftest+bounces-23680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586059F972A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37274188BE25
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593722618F;
	Fri, 20 Dec 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVIUMkZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D421C17E;
	Fri, 20 Dec 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713507; cv=none; b=sE5Sw2ECZKlc3OmjsGhutL/tlSssU+u6zZw42HYexLLbZ99ZuYMv2wsiaSJ1qLZ2k5nMRRGtDCULT7B5f5O//AJ4EztdZY2aYdzi7igtwxR2gx8ZTQiByT6mcy7B9hgjW09rPeb6zmfpfJ+reawbTPEfEU6XkmmePcc+juuGetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713507; c=relaxed/simple;
	bh=UbPAO2RjCbS5UdMd6M1SYfFSDmJ+s49CndGfTDSD4Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/EwJfm759JGoxhvhhdbuawKeWVBP4UzyMSq6yt5I+sz2wCVz1Nk/n0/5SiXBRtxI6X4bhjtjdj3ApftcpfSxR36RmB1Clq7A2QdeyFsUijoR5U2BHFYDADnZHCAJva2sXCa+O+0pHjNSrEVDw1P+jVN1wgxVgMa77JOnqN58wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVIUMkZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F7FC4CEDE;
	Fri, 20 Dec 2024 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713506;
	bh=UbPAO2RjCbS5UdMd6M1SYfFSDmJ+s49CndGfTDSD4Tg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qVIUMkZ2FTeYFFW6MzulXykk/p6vUYIuFCiTtX1PTCRXOJd5AFNunEsurBUu++y7J
	 xfsfagZ2OLab8zRFcKJporZxAKrl63777HR6iOLKuiXGKWwnpNAU9pLEYtUpovTG4+
	 X7SEHmlsZ6A9Mab8h3eRsdN0/dsAhuNafPiYubis834JW540tzWX/GxRNF2TPmMn7k
	 OBIKLj8KBNH4L8kL0n6rggloUFaWLMm/qUX8Q3xIOkaa50ji5CNihmRc92KfGSFoIl
	 dc4iYAx+ME8kWPPEU0v5v3vAPP73OlwNdUv//bqer9/beEdYHly9wscjZNSBtXD+ST
	 NSx6V+hPhEvUQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:38 +0000
Subject: [PATCH RFC v3 13/27] KVM: arm64: Rename sve_state_reg_region
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-13-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UbPAO2RjCbS5UdMd6M1SYfFSDmJ+s49CndGfTDSD4Tg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBezixYsQFK0OuTzhIjDQ9L5vedbkx8KdXI+oJ+
 MByXF6GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgXgAKCRAk1otyXVSH0DFgB/
 4n1MpQ+jOywpaT+XfkmFTNXoUjjcWniJR6PZzwE3f/+HiNUo7qNhJmrjK4WsmqxJDxxFW9GI2MOtNe
 1Oc4OSu2kyc25wQX2pJwzaP/jF+V2xx92SI9d+ipJJBr+IZtrKO52UBsPn+iMl4b1ksBSH14nh7b0U
 Kf35rjwc8MK8u18CbYpLcNvYHDJD4LFxEXEvRB9xKwnmXnYnlEng9XAyAr7h4lPlgnwA1gzEb307k3
 GCa+eAw6IZIY46Hb3Ww8rWz6S6ofTp7BozSAkednJfD+05rJXn6vHelrW5zgwIXkBZfIYcfaI8qV6D
 sn02KtcFvcJndag9PqRThjvba09EZ7
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
index 62ff51d6e4584acc71205f5d4b1d2f3d2e2d2f88..cde733417f25b5af4f5e996f91c2b962a4d361fd 100644
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


