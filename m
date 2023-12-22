Return-Path: <linux-kselftest+bounces-2382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C575A81CCC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B82F285973
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7D24A05;
	Fri, 22 Dec 2023 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE83PAOl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E62C849;
	Fri, 22 Dec 2023 16:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EDBC433C8;
	Fri, 22 Dec 2023 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262115;
	bh=KvDjESbMxbmCmpnpBwH6uYeBo57eTgRTVhw2kOd8cI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gE83PAOliBpOunTogbAhI/kWop+Go0NddAPZ1WQmkcxDNCIIxYgs+x6Lo2lew/Ol3
	 FEq1Lyog4suncqPeXVnevIQco5zX2y8xjO1R2FD/6o3d+YqxCtqemkLeiRUY4zkt5K
	 dp+0T372/nmcGLga//v866YFDZ/DT/6vsmbb38iekFbk12OQSh0CLLLe33y8rO8CAC
	 mighgnVKIVLdgO8U3bI1IvinF2mYcOHNeG4OTGUrMF4anMB+XYGP6ecBC3fLN4kCua
	 5m/P7wTiqThjdu3QlTk4onyHA2okO3Ju1npdeCyyNVloD3JoVbSPfZs7E39MHgl9/R
	 KkZKJSlckr5bg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:13 +0000
Subject: [PATCH RFC v2 05/22] KVM: arm64: Document the KVM ABI for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-5-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12731; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KvDjESbMxbmCmpnpBwH6uYeBo57eTgRTVhw2kOd8cI8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbd/llKStZnbJCf3FNCwtzAjmS6EdwZtAOTK11Fn
 Da0/KwiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3fwAKCRAk1otyXVSH0INaB/
 0cWbMnZncTaSH3DTrIe8VAjrMHW7Dv5JAI3O39ys0x8quGlKPnar2NLLQxgo5Uqxkxmxa2gl1haHrt
 RbjY6e882GpkY6X5yc+MRWG0IJrehws2sPSf1xY6O2hYRN2g+T/2raWNKzIDQ5nWXMcgYo92WjE6Wr
 ANgqqnE+A4O71ERAzc+UTvEsfQh9VO58iWoswOdBqCrF6JxcthQOciU6+cyKPq92DfCcplMhyXUqxM
 7dwMXr1DRvf1eRH8zKHO0UiV4lUEU9ecuC2mmrxmis8SdscbtGCPA3/Uznr56eEOPi9NDC4cZY5ib3
 NloIpJzaHNyJ9tBIcWbDdJcud25x/z
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME, the Scalable Matrix Extension, is an arm64 extension which adds support
for matrix operations, with core concepts patterned after SVE.

SVE introduced some complication in the ABI since it adds new vector
floating point registers with runtime configurable size, the size being
controlled by a prameter called the vector length (VL). To provide control
of this to VMMs we offer two phase configuration of SVE, SVE must first be
enabled for the vCPU with KVM_ARM_VCPU_INIT(KVM_ARM_VCPU_SVE), after which
vector length may then be configured but the configurably sized floating
point registers are inaccessible until finalized with a call to
KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE) after which the configurably sized
registers can be accessed.

SME introduces an additional independent configurable vector length which
as well as controlling the size of the new ZA register also provides an
alternative view of the configurably sized SVE registers (known as streaming
mode) with the guest able to switch between the two modes as it pleases.
There is also a fixed sized register ZT0 introduced in SME2. As well as
streaming mode the guest may enable and disable ZA and (where SME2 is
available) ZT0 dynamically independently of streaming mode. These modes are
controlled via the system register SVCR.

We handle the configuration of the vector length for SME in a similar
manner to SVE, requiring initialization and finalization of the feature
with a pseudo register controlling the available SME vector lengths as for
SVE. Further, if the guest has both SVE and SME then finalizing one
prevents further configuration of the vector length for the other.

Where both SVE and SME are configured for the guest we always present the
SVE registers to userspace as having the larger of the configured maximum
SVE and SME vector lengths, discarding extra data at load time and zero
padding on read as required if the active vector length is lower. Note that
this means that enabling or disabling streaming mode while the guest is
stopped will not zero Zn or Pn as it will when the guest is running, but it
does allow SVCR, Zn and Pn to be read and written in any order.

Userspace access to ZA and (if configured) ZT0 is always available, they
will be zeroed when the guest runs if disabled in SVCR and the value read
will be zero if the guest stops with them disabled. This mirrors the
behaviour of the architecture, enabling access causes ZA and ZT0 to be
zeroed, while allowing access to SVCR, ZA and ZT0 to be performed in any
order.

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
 Documentation/virt/kvm/api.rst | 104 +++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 31 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7025b3751027..b64541fa3e2a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -374,7 +374,7 @@ Errors:
              instructions from device memory (arm64)
   ENOSYS     data abort outside memslots with no syndrome info and
              KVM_CAP_ARM_NISV_TO_USER not enabled (arm64)
-  EPERM      SVE feature set but not finalized (arm64)
+  EPERM      SVE or SME feature set but not finalized (arm64)
   =======    ==============================================================
 
 This ioctl is used to run a guest virtual cpu.  While there are no
@@ -2585,12 +2585,13 @@ Specifically:
   0x6020 0000 0010 00d5 FPCR        32  fp_regs.fpcr
 ======================= ========= ===== =======================================
 
-.. [1] These encodings are not accepted for SVE-enabled vcpus.  See
+.. [1] These encodings are not accepted for SVE or SME enabled vcpus.  See
        KVM_ARM_VCPU_INIT.
 
        The equivalent register content can be accessed via bits [127:0] of
        the corresponding SVE Zn registers instead for vcpus that have SVE
-       enabled (see below).
+       or SME enabled (see below).  Note carefully that this is true even
+       when only SVE is supported.
 
 arm64 CCSIDR registers are demultiplexed by CSSELR value::
 
@@ -2621,24 +2622,31 @@ arm64 SVE registers have the following bit patterns::
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
 
 These registers are only accessible on vcpus for which SVE is enabled.
 See KVM_ARM_VCPU_INIT for details.
 
-In addition, except for KVM_REG_ARM64_SVE_VLS, these registers are not
-accessible until the vcpu's SVE configuration has been finalized
-using KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE).  See KVM_ARM_VCPU_INIT
-and KVM_ARM_VCPU_FINALIZE for more information about this procedure.
+In addition, except for KVM_REG_ARM64_SVE_VLS and
+KVM_REG_ARM64_SME_VLS, these registers are not accessible until the
+vcpu's SVE configuration has been finalized using
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
 
@@ -2652,17 +2660,20 @@ follows::
 .. [2] The maximum value vq for which the above condition is true is
        max_vq.  This is the maximum vector length available to the guest on
        this vcpu, and determines which register slices are visible through
-       this ioctl interface.
+       this ioctl interface.  If both SVE and SME are supported for the
+       guest this will be the larger of the two vector lengths regardless
+       of streaming mode being active.
 
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
@@ -2670,8 +2681,8 @@ is hardware-dependent and may not be available.  Attempting to configure
 an invalid set of vector lengths via KVM_SET_ONE_REG will fail with
 EINVAL.
 
-After the vcpu's SVE configuration is finalized, further attempts to
-write this register will fail with EPERM.
+After the vcpu's SVE or SME configuration is finalized, further
+attempts to write these registers will fail with EPERM.
 
 arm64 bitmap feature firmware pseudo-registers have the following bit pattern::
 
@@ -3454,6 +3465,7 @@ The initial values are defined as:
 	- General Purpose registers, including PC and SP: set to 0
 	- FPSIMD/NEON registers: set to 0
 	- SVE registers: set to 0
+	- SME registers: set to 0
 	- System registers: Reset to their architecturally defined
 	  values as for a warm reset to EL1 (resp. SVC)
 
@@ -3496,7 +3508,7 @@ Possible features:
 
 	- KVM_ARM_VCPU_SVE: Enables SVE for the CPU (arm64 only).
 	  Depends on KVM_CAP_ARM_SVE.
-	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
 
 	   * After KVM_ARM_VCPU_INIT:
 
@@ -3504,7 +3516,7 @@ Possible features:
 	        initial value of this pseudo-register indicates the best set of
 	        vector lengths possible for a vcpu on this host.
 
-	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
+	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC}):
 
 	      - KVM_RUN and KVM_GET_REG_LIST are not available;
 
@@ -3517,11 +3529,40 @@ Possible features:
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
 4.83 KVM_ARM_PREFERRED_TARGET
 -----------------------------
 
@@ -5055,11 +5096,12 @@ Errors:
 
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
 means of a successful KVM_ARM_VCPU_INIT call with the appropriate flag set in

-- 
2.30.2


