Return-Path: <linux-kselftest+bounces-2393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A119481CCEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F82C1F23A42
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6A28DCC;
	Fri, 22 Dec 2023 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzRSz5+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13F33076;
	Fri, 22 Dec 2023 16:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738A5C433CC;
	Fri, 22 Dec 2023 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262153;
	bh=8JPJwupq2N62+vagV/qpJNnQsJBqVRrsTh5n42UTrZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nzRSz5+McKQrXgOPwiks2RJnXeBpgQjIQOFTAFPsq4yMtWTFRCYrkP1HyBMkd4lk0
	 MJEm33tXncRddiX7X0lsNLMftQ+8GEyUP1nOgNpEoH9Iv1DpHkrIMC9YnU0YZDSLfL
	 59yS53biNZ4vSPBbjmYYFrLTYf8Ndi0x0wsq55O19d2frMhK0I2/jBtlkaMd7yBHrZ
	 4ECzAKIb0dnm4YHD2HJDtjQtluBT12ak3UT/S3wwoOBGlqSu4dfs3ynhHNkH7xsAUn
	 tu3XtcD3rUeHETqMHRaj7SCeKCnqXUkS7EQxTbvjB+Xv/GvR9/IWiHkOqtlRjVhHv2
	 9mGIWtwhNgq7Q==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:24 +0000
Subject: [PATCH RFC v2 16/22] KVM: arm64: Rename sve_state_reg_region
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-16-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2327; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8JPJwupq2N62+vagV/qpJNnQsJBqVRrsTh5n42UTrZQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeIRiPy0lE/vz/C66LTUXlOWNxZsB/57nIQiF+U
 6d7xTDmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3iAAKCRAk1otyXVSH0PFKB/
 99h3j1FJgKhk6Ik6EikbiORGh7Yo98WP2TCowPa7BlOPTPIme9xHk2powADCEsAv1OUvxMsSxAU2cV
 688Odait7xB6eiLZ9ISDdR4zvqY/yhKzC7yOQ7pg99TB6gPReDmfd68vTpBzP9albmHMX+gy0r5XWk
 geqcniPApfckLYRBpC6DQ2gUQW8CqeHF0derFTIiusOT7bhpGa87dnyobDwf/+IEECBflLdBFWb0eC
 8v+i1MtpiyztQ5nTJT7sslMe5+t8Dro+5+wWNr/4f2jqEffCrUuMHeu8X3z4quk37VgZqOTGZYD4l5
 JWPMO5HQFwRP8kxLOc6bKi9duVVlMl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As for SVE we will need to pull parts of dynamically sized registers out of
a block of memory for SME so we will use a similar code pattern for this.
Rename the current struct sve_state_reg_region in preparation for this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/guest.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 30446ae357f0..1d161fa7c2be 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -418,9 +418,9 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
@@ -429,7 +429,7 @@ struct sve_state_reg_region {
  * Validate SVE register ID and get sanitised bounds for user/kernel SVE
  * register copy
  */
-static int sve_reg_to_region(struct sve_state_reg_region *region,
+static int sve_reg_to_region(struct vec_state_reg_region *region,
 			     struct kvm_vcpu *vcpu,
 			     const struct kvm_one_reg *reg)
 {
@@ -499,7 +499,7 @@ static int sve_reg_to_region(struct sve_state_reg_region *region,
 static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	int ret;
-	struct sve_state_reg_region region;
+	struct vec_state_reg_region region;
 	char __user *uptr = (char __user *)reg->addr;
 
 	/* Handle the KVM_REG_ARM64_SVE_VLS pseudo-reg as a special case: */
@@ -525,7 +525,7 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	int ret;
-	struct sve_state_reg_region region;
+	struct vec_state_reg_region region;
 	const char __user *uptr = (const char __user *)reg->addr;
 
 	/* Handle the KVM_REG_ARM64_SVE_VLS pseudo-reg as a special case: */

-- 
2.30.2


