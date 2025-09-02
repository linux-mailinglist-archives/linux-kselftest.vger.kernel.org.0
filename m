Return-Path: <linux-kselftest+bounces-40571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F102B3FE47
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEAF2C3C7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC930101F;
	Tue,  2 Sep 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aspx+jBo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E13009EF;
	Tue,  2 Sep 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813508; cv=none; b=B9M8mobgNiB4gU7ST7DgpEaAFcdQ6HKBMIslTWY0/J+TZU9KMrCLrS1qY/2fZCoGNQ3pZ5rB3Nh1gDjuoMhurNobavsBtXHyhAxaip5W/4swKee74QG/IXKcqQIGorX3DMUkcBTP1wwK784hiir+LoAdyghW0+TIuY/Tpxm6AOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813508; c=relaxed/simple;
	bh=rH9XhgZQjPqeyn6F/14r2eQpDtg8OcPKafzcMuvwg9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHws7UD08q1XbECDeoQP/ZINcwYrja7Ah0UBAJUJ8IEO+R5lGLYbODG6jdyo1L9olTmoOxq0Dmjk1a8YA1d/r07p3K/mAvhtfwoVzWZ52hvsY30CpYJ2jV95L5jPuuWVTPpFDSPr5jDYC1dfLbmymMr0ucRy0s9ps0ENTznxf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aspx+jBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8431BC4CEF8;
	Tue,  2 Sep 2025 11:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813508;
	bh=rH9XhgZQjPqeyn6F/14r2eQpDtg8OcPKafzcMuvwg9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Aspx+jBogE0Yab7GP1A39kEqFlA5TIxA8bTHyZkhSYtzwNnkVPLXlzzrFQx6eDPtQ
	 D7wQIs71HcIV31O+Ift0jWXt4i+ttZLd0DhRPLEMS8xkCbk9Gk1YCimIsyl7AjdxBc
	 EiWdJwQ9ugQ1qC/NATXW3EjqH3hlpDw37HZlGDdd/hHQzRs7bnw0FjmNDHxNf2EtAP
	 G3G1byPlsdurp5k5/nyp9VrHeV5LKHwrEKAYEenmBZEkkzlFRv86bEHJp1DnV2gEzI
	 aQvsHCrHqqfIb/v70lOnqNaxhtUWpmiueDKDyE7vB6a0lg/HQK9vCpnvsFlfZYtkjj
	 HbiVw5jBTE6Xg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:14 +0100
Subject: [PATCH v8 11/29] KVM: arm64: Document the KVM ABI for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-11-2cb2199c656c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13253; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rH9XhgZQjPqeyn6F/14r2eQpDtg8OcPKafzcMuvwg9Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBottiCaWSJ78p62BFgyuPzqc0yuQRvQzsxHwPYa
 0qgXjhYuJ2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYggAKCRAk1otyXVSH
 0GFJB/9Pco9YWrN6dV58T0Q6JrCmysPVZAJFs9sMsCCy3wGaDztvDTiilnsEodlpBEogrBCGKnI
 +aF6+LimnvadNMfYUU+0hBxzOZl/lDOJg6VO0oRgqn47W5LUnAQ+KEpOeHUPU1atptr3fhjjbtW
 SlM/olzWwD4rU1JOj00gh8olIsRFSg1jeaLJ1O6G/G9+lspgahwd6Cy3+u8/lcZHiS8UgZXRA5g
 3zwHAlQzHftvUmjafozH6mP9EdfvbBYCBel/1up4Hi9JJ+iouXLajPTRJfv9aNYgP3pGVG8tOlq
 OUiOp5mVoVXusWLMEPySm0fcwCdwNI3NYRP/qUBY0Cpdttc/
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
 Documentation/virt/kvm/api.rst | 115 +++++++++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 34 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6aa40ee05a4a..94a22407a1d4 100644
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
@@ -2601,11 +2601,11 @@ Specifically:
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
 
@@ -2636,24 +2636,34 @@ arm64 SVE registers have the following bit patterns::
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
 
@@ -2665,19 +2675,25 @@ follows::
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
@@ -2685,8 +2701,8 @@ is hardware-dependent and may not be available.  Attempting to configure
 an invalid set of vector lengths via KVM_SET_ONE_REG will fail with
 EINVAL.
 
-After the vcpu's SVE configuration is finalized, further attempts to
-write this register will fail with EPERM.
+After the vcpu's SVE or SME configuration is finalized, further
+attempts to write these registers will fail with EPERM.
 
 arm64 bitmap feature firmware pseudo-registers have the following bit pattern::
 
@@ -3469,6 +3485,7 @@ The initial values are defined as:
 	- General Purpose registers, including PC and SP: set to 0
 	- FPSIMD/NEON registers: set to 0
 	- SVE registers: set to 0
+	- SME registers: set to 0
 	- System registers: Reset to their architecturally defined
 	  values as for a warm reset to EL1 (resp. SVC) or EL2 (in the
 	  case of EL2 being enabled).
@@ -3512,7 +3529,7 @@ Possible features:
 
 	- KVM_ARM_VCPU_SVE: Enables SVE for the CPU (arm64 only).
 	  Depends on KVM_CAP_ARM_SVE.
-	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
 
 	   * After KVM_ARM_VCPU_INIT:
 
@@ -3520,7 +3537,7 @@ Possible features:
 	        initial value of this pseudo-register indicates the best set of
 	        vector lengths possible for a vcpu on this host.
 
-	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
 
 	      - KVM_RUN and KVM_GET_REG_LIST are not available;
 
@@ -3533,11 +3550,40 @@ Possible features:
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
@@ -5120,11 +5166,12 @@ Errors:
 
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


