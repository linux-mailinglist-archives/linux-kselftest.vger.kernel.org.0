Return-Path: <linux-kselftest+bounces-35753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C90AE8113
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E837AFE54
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4D2DECB7;
	Wed, 25 Jun 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgTl2jrV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B92DECB6;
	Wed, 25 Jun 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850724; cv=none; b=EPWGbgu3soH5vziLo2Z6KBVspEPXc5+jPSOp11LxMdgbcER0th3lF60HJKNNj3YZEZ75uaJQmeT3t8ABBqNbDmWoQ5nT4XKI0ZlJGYQcTaKmvS+9Kd3hODX+VrgvHaykrmizwGJYCX8JFT3gcV5TCi1E4sRC25weVrSjdYRi3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850724; c=relaxed/simple;
	bh=FGfyXKa2C4wb1SSfPWxzcHzcNsoJwcHmagxEbVLDdH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhkVLPRXHsEoFzGxfCh5kR6efFZ/cd50jX8L1QpNUzVqGZHNli8TycFQ1sgExr1qcz/s35W79/NKahTIZCGL0nce93lHUMHUU/UdK2ErzaV5SB4BQee5FEwWXTwk4uvE51xMI10lsbgN9J/F/3IHNPL0raaMnSr1KudxlZABWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgTl2jrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC6AC4CEEE;
	Wed, 25 Jun 2025 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850723;
	bh=FGfyXKa2C4wb1SSfPWxzcHzcNsoJwcHmagxEbVLDdH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tgTl2jrVWqjE1YK0FjmGs1c06hLwrBEVIWIrBhEB0pFKcxvkKBWgoKdcIhL3fDcAf
	 h1Glbh7aPpn01g+Bx9ZF1x+om+KLyP76o1kG3CYxklVQ1NL+HV3F5YSJ0m6cIrrtL+
	 qIgfylvHSreFAVf5dvyOU1HXzZiSYPBS2CrbfdKRz12dhrIWZKcQlV/nnEezHrXMM5
	 viunA/p8MVIymW4mFgVYRQULDIXCJbNBaXTHJCKuacChsA56KfV2UnAtmwhzSpX8yL
	 BVqjehgtKRQxeJi6+Gs4EicadjtkDN8nC4Cs0IHaa0vp/seewPmblwQCOSKS5nJThA
	 5Kc240EA01SoA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:01 +0100
Subject: [PATCH v6 10/28] KVM: arm64: Document the KVM ABI for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-10-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13384; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FGfyXKa2C4wb1SSfPWxzcHzcNsoJwcHmagxEbVLDdH0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xsJ37tlp20+X7rdcBHtJLvIGb9VbDbWZZbU
 tBlGG+Y99+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcbAAKCRAk1otyXVSH
 0KYkB/0V8tmomAQudd3oVecLMwVu7oLtn88bck65fFXizImflz3gBX9/w+v5y2nQaAnFI68iKht
 tU1HO1B8oWK5GpZFK78uhTiocqH84f9BQQN1XRRQvNLNRfkBJ4qRx7SwipF4yr96HV0PZ7Qr8sj
 PT1XOA4FCWThipR+TblhR+B9bkQ1AIMsFRwinS8M/M7R+tpak9Xym7AV9F+NO5ePZlADqfYr1e9
 UMV4jhav2vWMEtiTcoGdZYrtArB+l41ss9AhAVckG1uh7CANGMksDdh7ET6YxvP3uxezyfUfacC
 6RohFUfpvMgi16eUgxF1+NJi3u0MX/X5QAPhAtQv9Ou5C8EB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME, the Scalable Matrix Extension, is an arm64 extension which adds
support for matrix operations, with core concepts patterned after SVE.

SVE introduced some complication in the ABI since it adds new vector
floating point registers with runtime configurable size, the size being
controlled by a prameter called the vector length (VL). To provide control
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

If SME is enabled for a guest without SVE then the FPSIMD Vn registers
must be accessed via the low 128 bits of the SVE Zn registers as is the
case when SVE is enabled. This is not ideal but allows access to SVCR and
the registers in any order without duplication or ambiguity about which
values should take effect. This may be an issue for VMMs that are
unaware of SME on systems that implement it without SVE if they let SME
be enabled, the lack of access to Vn may surprise them, but it seems
like an unusual implementation choice.

For SME unware VMMs on systems with both SVE and SME support the SVE
registers may be larger than expected, this should be less disruptive
than on a system without SVE as they will simply ignore the high bits of
the registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/virt/kvm/api.rst | 117 +++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 35 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 9abf93ee5f65..00195e837b5f 100644
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
@@ -2593,12 +2593,12 @@ Specifically:
   0x6020 0000 0010 00d5 FPCR        32  fp_regs.fpcr
 ======================= ========= ===== =======================================
 
-.. [1] These encodings are not accepted for SVE-enabled vcpus.  See
-       :ref:`KVM_ARM_VCPU_INIT`.
+.. [1] These encodings are not accepted for SVE enabled vcpus.  See
+       :ref:`KVM_ARM_VCPU_INIT`.  They are also not accepted when SME is
+       enabled without SVE and the vcpu is in streaming mode.
 
        The equivalent register content can be accessed via bits [127:0] of
-       the corresponding SVE Zn registers instead for vcpus that have SVE
-       enabled (see below).
+       the corresponding SVE Zn registers in these cases (see below).
 
 arm64 CCSIDR registers are demultiplexed by CSSELR value::
 
@@ -2629,24 +2629,34 @@ arm64 SVE registers have the following bit patterns::
   0x6050 0000 0015 060 <slice:5>        FFR bits[256*slice + 255 : 256*slice]
   0x6060 0000 0015 ffff                 KVM_REG_ARM64_SVE_VLS pseudo-register
 
-Access to register IDs where 2048 * slice >= 128 * max_vq will fail with
-ENOENT.  max_vq is the vcpu's maximum supported vector length in 128-bit
-quadwords: see [2]_ below.
+arm64 SME registers have the following bit patterns:
+
+  0x6080 0000 0017 00 <n:5> <slice:5>   ZA.H[n] bits[2048*slice + 2047 : 2048*slice]
+  0x60XX 0000 0017 0100                 ZT0
+  0x6060 0000 0017 fffe                 KVM_REG_ARM64_SME_VLS pseudo-register
+
+Access to Z, P or ZA register IDs where 2048 * slice >= 128 * max_vq
+will fail with ENOENT.  max_vq is the vcpu's maximum supported vector
+length in 128-bit quadwords: see [2]_ below.
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
 
@@ -2658,19 +2668,25 @@ follows::
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
+       then while SVCR.SM is 1 this vector length will be the maximum SME
+       vector length available for the guest, otherwise it will be the
+       maximum SVE vector length available.
 
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
@@ -2678,8 +2694,8 @@ is hardware-dependent and may not be available.  Attempting to configure
 an invalid set of vector lengths via KVM_SET_ONE_REG will fail with
 EINVAL.
 
-After the vcpu's SVE configuration is finalized, further attempts to
-write this register will fail with EPERM.
+After the vcpu's SVE or SME configuration is finalized, further
+attempts to write these registers will fail with EPERM.
 
 arm64 bitmap feature firmware pseudo-registers have the following bit pattern::
 
@@ -3462,6 +3478,7 @@ The initial values are defined as:
 	- General Purpose registers, including PC and SP: set to 0
 	- FPSIMD/NEON registers: set to 0
 	- SVE registers: set to 0
+	- SME registers: set to 0
 	- System registers: Reset to their architecturally defined
 	  values as for a warm reset to EL1 (resp. SVC) or EL2 (in the
 	  case of EL2 being enabled).
@@ -3505,7 +3522,7 @@ Possible features:
 
 	- KVM_ARM_VCPU_SVE: Enables SVE for the CPU (arm64 only).
 	  Depends on KVM_CAP_ARM_SVE.
-	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
 
 	   * After KVM_ARM_VCPU_INIT:
 
@@ -3513,7 +3530,7 @@ Possible features:
 	        initial value of this pseudo-register indicates the best set of
 	        vector lengths possible for a vcpu on this host.
 
-	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC}):
 
 	      - KVM_RUN and KVM_GET_REG_LIST are not available;
 
@@ -3526,11 +3543,40 @@ Possible features:
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
+	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC}):
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
@@ -5113,11 +5159,12 @@ Errors:
 
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
2.39.5


