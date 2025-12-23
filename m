Return-Path: <linux-kselftest+bounces-47880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53047CD7AE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08DEA30C0655
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4662C029A;
	Tue, 23 Dec 2025 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6yq7dcR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0229B8EF;
	Tue, 23 Dec 2025 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452938; cv=none; b=tf9UZGOgLfNe8fhpoZnNFMragzAqj2yLCShSnEqJzXb93DblctVvXE/wK25wsH5iTYGb1TF+2M2UkvHMcrurAjXzmkeIUWeNEkGdbgg/5ZcinC+4x7O14PocINsIa4xTotbh6ZmFsLbWj5/BRyITHKQYBEinxYv4QA3WQKY2gSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452938; c=relaxed/simple;
	bh=QJhbQWLdEtLaI4QENrJxKRYB8ihqF+aPCRbKAA0Aeu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtSjLbqIvD1Pz/CtTQhtwpH/lWRuOYsAyEtK826Wk640e1W32sRL3AvBRJcrC+6iZXzA4l/xkRYLacKrDFvhb0mXUu92uF3CxxYp8/Z9ZoskIgrrTi53SPANHr0lFnbEeL4J3pEOFG7FFY8cLrwyWqODtLQ2GFgFVFmQkfJF1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6yq7dcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3947C19422;
	Tue, 23 Dec 2025 01:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452937;
	bh=QJhbQWLdEtLaI4QENrJxKRYB8ihqF+aPCRbKAA0Aeu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B6yq7dcRVieiStvuwKdBmxQcP87EWYdbzU3+1mRsDaPrBKIq2912Kn4Nyft8t6gph
	 3/VCFqvylx0GpS/uj1Ri5MXiZWWIi3nsi1rlFJ1oRBBOvqRcr/FxEJ7p4vwEG055nD
	 cBK7BWQSjTDWm4hvSWAaQmTx4ohdX4Z6AFug0JZ7Rdjc8A5BNARWp3yH+gTVTkfRFZ
	 avoV6Wq3/sgHTH6Ly2M17DIS5GMbGzOtYcDNXknOg+SuJP1fc9jyo+KEbVdbPMck8f
	 f2UKdKcY6Yrm1nlGYtJcFDLBjWErztn2ZCyuNOCdvBJ27GCk4kuO7pUcRAwxTOEP3x
	 9K/nnsxRsUqIw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:04 +0000
Subject: [PATCH v9 10/30] KVM: arm64: Document the KVM ABI for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-10-8be3867cb883@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12749; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QJhbQWLdEtLaI4QENrJxKRYB8ihqF+aPCRbKAA0Aeu8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6KUIVC2fsuYsrewvVKXdXNl018BOpe+nhuG
 4ZvdMNsGUiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnuigAKCRAk1otyXVSH
 0DexB/4y7g1ZctSoaiYQiaO3byJsvqlyMb46+vJbWdOllFxnZLjrEOId553JJC2i9D2El+uyKoB
 wvGy/7niKn0hN/px+8BbLlTSrZ1bEgbqAHNW2QhwbHihyhDRxLNc1J07poGXMQluQvH64VIGDi6
 DyNGVkfSe1reUm3/NqLVZInAo4+sgSV3nwm8eIlR1vtfRTTLxOhuC/kbWEZ053tQjzMDCJUY14R
 oVmTnjB0m9Eu8FyWWWKfPIc0L3IfbMNuhEHUGfd6GTb2ga/r4nzAH618vTqhi40/6LY/+hzFOER
 9ABc1SwuuUL6WUF+f8bU6ANmxUmzzSG/tdo2BXZDrSfDsJUn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME, the Scalable Matrix Extension, is an arm64 extension which adds
support for matrix operations, with core concepts patterned after SVE.

SVE introduced some complication in the ABI since it adds new vector
floating point registers with runtime configurable size, the size being
controlled by a parameter called the vector length (VL). To provide control
of this to VMMs we offer two phase configuration of SVE, SVE must first be
enabled for the vCPU with KVM_ARM_VCPU_INIT(KVM_ARM_VCPU_SVE), after which
vector length may then be configured but the configurably sized floating
point registers are inaccessible until finalized with a call to
KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE) after which the configurably sized
registers can be accessed.

SME introduces an additional independent configurable vector length
which as well as controlling the size of the new ZA register also
provides an alternative view of the configurably sized SVE registers
(known as streaming mode) with the guest able to switch between the two
modes as it pleases.  There is also a fixed sized register ZT0
introduced in SME2. As well as streaming mode the guest may enable and
disable ZA and (where SME2 is available) ZT0 dynamically independently
of streaming mode. These modes are controlled via the system register
SVCR.

We handle the configuration of the vector length for SME in a similar
manner to SVE, requiring initialization and finalization of the feature
with a pseudo register controlling the available SME vector lengths as for
SVE. Further, if the guest has both SVE and SME then finalizing one
prevents further configuration of the vector length for the other.

Where both SVE and SME are configured for the guest we always present
the SVE registers to userspace as having the larger of the configured
maximum SVE and SME vector lengths, discarding extra data at load time
and zero padding on read as required if the active vector length is
lower. Note that this means that enabling or disabling streaming mode
while the guest is stopped will not zero Zn or Pn as it will when the
guest is running, but it does allow SVCR, Zn and Pn to be read and
written in any order.

Userspace access to ZA and (if configured) ZT0 is always available, they
will be zeroed when the guest runs if disabled in SVCR and the value
read will be zero if the guest stops with them disabled. This mirrors
the behaviour of the architecture, enabling access causes ZA and ZT0 to
be zeroed, while allowing access to SVCR, ZA and ZT0 to be performed in
any order.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/virt/kvm/api.rst | 120 +++++++++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 34 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 01a3abef8abb..e024b9783932 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -406,7 +406,7 @@ Errors:
              instructions from device memory (arm64)
   ENOSYS     data abort outside memslots with no syndrome info and
              KVM_CAP_ARM_NISV_TO_USER not enabled (arm64)
-  EPERM      SVE feature set but not finalized (arm64)
+  EPERM      SVE or SME feature set but not finalized (arm64)
   =======    ==============================================================
 
 This ioctl is used to run a guest virtual cpu.  While there are no
@@ -2606,11 +2606,11 @@ Specifically:
 ======================= ========= ===== =======================================
 
 .. [1] These encodings are not accepted for SVE-enabled vcpus.  See
-       :ref:`KVM_ARM_VCPU_INIT`.
+       :ref:`KVM_ARM_VCPU_INIT`.  They are also not accepted when SME is
+       enabled without SVE and the vcpu is in streaming mode.
 
        The equivalent register content can be accessed via bits [127:0] of
-       the corresponding SVE Zn registers instead for vcpus that have SVE
-       enabled (see below).
+       the corresponding SVE Zn registers in these cases (see below).
 
 arm64 CCSIDR registers are demultiplexed by CSSELR value::
 
@@ -2641,24 +2641,39 @@ arm64 SVE registers have the following bit patterns::
   0x6050 0000 0015 060 <slice:5>        FFR bits[256*slice + 255 : 256*slice]
   0x6060 0000 0015 ffff                 KVM_REG_ARM64_SVE_VLS pseudo-register
 
-Access to register IDs where 2048 * slice >= 128 * max_vq will fail with
-ENOENT.  max_vq is the vcpu's maximum supported vector length in 128-bit
-quadwords: see [2]_ below.
+arm64 SME registers have the following bit patterns:
+
+  0x6080 0000 0017 00 <n:5> <slice:5>   ZA.H[n] bits[2048*slice + 2047 : 2048*slice]
+  0x6060 0000 0017 0100                 ZT0
+  0x6060 0000 0017 fffe                 KVM_REG_ARM64_SME_VLS pseudo-register
+
+Access to Z, P, FFR or ZA register IDs where 2048 * slice >= 128 *
+max_vq will fail with ENOENT.  max_vq is the vcpu's current maximum
+supported vector length in 128-bit quadwords: see [2]_ below.
+
+Changing the value of SVCR.SM will result in the contents of
+the Z, P and FFR registers being reset to 0.  When restoring the
+values of these registers for a VM with SME support it is
+important that SVCR.SM be configured first.
+
+Access to the ZA and ZT0 registers is only available if SVCR.ZA is set
+to 1.
 
 These registers are only accessible on vcpus for which SVE is enabled.
 See KVM_ARM_VCPU_INIT for details.
 
-In addition, except for KVM_REG_ARM64_SVE_VLS, these registers are not
-accessible until the vcpu's SVE configuration has been finalized
-using KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE).  See KVM_ARM_VCPU_INIT
-and KVM_ARM_VCPU_FINALIZE for more information about this procedure.
+In addition, except for KVM_REG_ARM64_SVE_VLS and
+KVM_REG_ARM64_SME_VLS, these registers are not accessible until the
+vcpu's SVE and SME configuration has been finalized using
+KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC).  See KVM_ARM_VCPU_INIT and
+KVM_ARM_VCPU_FINALIZE for more information about this procedure.
 
-KVM_REG_ARM64_SVE_VLS is a pseudo-register that allows the set of vector
-lengths supported by the vcpu to be discovered and configured by
-userspace.  When transferred to or from user memory via KVM_GET_ONE_REG
-or KVM_SET_ONE_REG, the value of this register is of type
-__u64[KVM_ARM64_SVE_VLS_WORDS], and encodes the set of vector lengths as
-follows::
+KVM_REG_ARM64_SVE_VLS and KVM_ARM64_VCPU_SME_VLS are pseudo-registers
+that allows the set of vector lengths supported by the vcpu to be
+discovered and configured by userspace.  When transferred to or from
+user memory via KVM_GET_ONE_REG or KVM_SET_ONE_REG, the value of this
+register is of type __u64[KVM_ARM64_SVE_VLS_WORDS], and encodes the
+set of vector lengths as follows::
 
   __u64 vector_lengths[KVM_ARM64_SVE_VLS_WORDS];
 
@@ -2670,19 +2685,25 @@ follows::
 	/* Vector length vq * 16 bytes not supported */
 
 .. [2] The maximum value vq for which the above condition is true is
-       max_vq.  This is the maximum vector length available to the guest on
-       this vcpu, and determines which register slices are visible through
-       this ioctl interface.
+       max_vq.  This is the maximum vector length currently available to
+       the guest on this vcpu, and determines which register slices are
+       visible through this ioctl interface.
+
+       If SME is supported then the max_vq used for the Z and P registers
+       while SVCR.SM is 1 this vector length will be the maximum SME
+       vector length max_vq_sme available for the guest, otherwise it
+       will be the maximum SVE vector length max_vq_sve available.
 
 (See Documentation/arch/arm64/sve.rst for an explanation of the "vq"
 nomenclature.)
 
-KVM_REG_ARM64_SVE_VLS is only accessible after KVM_ARM_VCPU_INIT.
-KVM_ARM_VCPU_INIT initialises it to the best set of vector lengths that
-the host supports.
+KVM_REG_ARM64_SVE_VLS and KVM_REG_ARM_SME_VLS are only accessible
+after KVM_ARM_VCPU_INIT.  KVM_ARM_VCPU_INIT initialises them to the
+best set of vector lengths that the host supports.
 
-Userspace may subsequently modify it if desired until the vcpu's SVE
-configuration is finalized using KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE).
+Userspace may subsequently modify these registers if desired until the
+vcpu's SVE and SME configuration is finalized using
+KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC).
 
 Apart from simply removing all vector lengths from the host set that
 exceed some value, support for arbitrarily chosen sets of vector lengths
@@ -2690,8 +2711,8 @@ is hardware-dependent and may not be available.  Attempting to configure
 an invalid set of vector lengths via KVM_SET_ONE_REG will fail with
 EINVAL.
 
-After the vcpu's SVE configuration is finalized, further attempts to
-write this register will fail with EPERM.
+After the vcpu's SVE or SME configuration is finalized, further
+attempts to write these registers will fail with EPERM.
 
 arm64 bitmap feature firmware pseudo-registers have the following bit pattern::
 
@@ -3490,6 +3511,7 @@ The initial values are defined as:
 	- General Purpose registers, including PC and SP: set to 0
 	- FPSIMD/NEON registers: set to 0
 	- SVE registers: set to 0
+	- SME registers: set to 0
 	- System registers: Reset to their architecturally defined
 	  values as for a warm reset to EL1 (resp. SVC) or EL2 (in the
 	  case of EL2 being enabled).
@@ -3533,7 +3555,7 @@ Possible features:
 
 	- KVM_ARM_VCPU_SVE: Enables SVE for the CPU (arm64 only).
 	  Depends on KVM_CAP_ARM_SVE.
-	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
 
 	   * After KVM_ARM_VCPU_INIT:
 
@@ -3541,7 +3563,7 @@ Possible features:
 	        initial value of this pseudo-register indicates the best set of
 	        vector lengths possible for a vcpu on this host.
 
-	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
 
 	      - KVM_RUN and KVM_GET_REG_LIST are not available;
 
@@ -3554,11 +3576,40 @@ Possible features:
 	        KVM_SET_ONE_REG, to modify the set of vector lengths available
 	        for the vcpu.
 
-	   * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	   * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
 
 	      - the KVM_REG_ARM64_SVE_VLS pseudo-register is immutable, and can
 	        no longer be written using KVM_SET_ONE_REG.
 
+	- KVM_ARM_VCPU_SME: Enables SME for the CPU (arm64 only).
+	  Depends on KVM_CAP_ARM_SME.
+	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
+
+	   * After KVM_ARM_VCPU_INIT:
+
+	      - KVM_REG_ARM64_SME_VLS may be read using KVM_GET_ONE_REG: the
+	        initial value of this pseudo-register indicates the best set of
+	        vector lengths possible for a vcpu on this host.
+
+	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
+
+	      - KVM_RUN and KVM_GET_REG_LIST are not available;
+
+	      - KVM_GET_ONE_REG and KVM_SET_ONE_REG cannot be used to access
+	        the scalable architectural SVE registers
+	        KVM_REG_ARM64_SVE_ZREG(), KVM_REG_ARM64_SVE_PREG() or
+	        KVM_REG_ARM64_SVE_FFR, the matrix register
+		KVM_REG_ARM64_SME_ZA() or the LUT register KVM_REG_ARM64_ZT();
+
+	      - KVM_REG_ARM64_SME_VLS may optionally be written using
+	        KVM_SET_ONE_REG, to modify the set of vector lengths available
+	        for the vcpu.
+
+	   * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
+
+	      - the KVM_REG_ARM64_SME_VLS pseudo-register is immutable, and can
+	        no longer be written using KVM_SET_ONE_REG.
+
 	- KVM_ARM_VCPU_HAS_EL2: Enable Nested Virtualisation support,
 	  booting the guest from EL2 instead of EL1.
 	  Depends on KVM_CAP_ARM_EL2.
@@ -5143,11 +5194,12 @@ Errors:
 
 Recognised values for feature:
 
-  =====      ===========================================
-  arm64      KVM_ARM_VCPU_SVE (requires KVM_CAP_ARM_SVE)
-  =====      ===========================================
+  =====      ==============================================================
+  arm64      KVM_ARM_VCPU_VEC (requires KVM_CAP_ARM_SVE or KVM_CAP_ARM_SME)
+  arm64      KVM_ARM_VCPU_SVE (alias for KVM_ARM_VCPU_VEC)
+  =====      ==============================================================
 
-Finalizes the configuration of the specified vcpu feature.
+Finalizes the configuration of the specified vcpu features.
 
 The vcpu must already have been initialised, enabling the affected feature, by
 means of a successful :ref:`KVM_ARM_VCPU_INIT <KVM_ARM_VCPU_INIT>` call with the

-- 
2.47.3


