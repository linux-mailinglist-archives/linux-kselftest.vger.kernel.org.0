Return-Path: <linux-kselftest+bounces-4257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BAD84D07E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141EA1C20DA5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CEF128374;
	Wed,  7 Feb 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHLPd4gT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D3126F0C;
	Wed,  7 Feb 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328754; cv=none; b=R/bnNnR9Ee3d8B2RXxnC+CtOWIj8jxBtERd6vpJ6Uc8D8fkA/PFEZqi6VDnNly6q2sx78xmjjor2SEOXjQwc6z1oegmOZY8YNRI/eUzI2hMNEngV2ApvbbszA3KrmDfq3ELe0sJgRSgIFyvmowICoAJDR95Xmg1oxZprS0vMmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328754; c=relaxed/simple;
	bh=CuYDQvdxxw4eRy/EkzJIG8807riNAmdDprp/aAi8Qi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqNCnz79aPUsDELIkldNr/2E6aQ6Qgzk3r50U+o/66a0ZwzJzntWEtaOAWLH5Uf644iDePtNANXJR+Sz80rzRBkoglGR3lxTpNfka13RnkRDrNJKZsf/QNETUINlWdk/fi6nbNfMNgRujTS9RVyFouDC4KywtMNOTeWd37O+xWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHLPd4gT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328749; x=1738864749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CuYDQvdxxw4eRy/EkzJIG8807riNAmdDprp/aAi8Qi0=;
  b=jHLPd4gTh0gbi6tqn1Bi/w/hoP1dHqusk7cmgPPGsQO6URHH7kRTxLve
   B0uEnS3XxHTZRRUWixwBR+0NB1TMq4tDHr3KE1gHA3xGnYbyrpEF92j/M
   Q43mJFZJXAptvO7k4jD066tKE7DecqWVicQZhNAqg0RhCQchb93DpAs7m
   gyE5DOWeGaMwOYIhaTziBuQB97+yQo/fBRB4UtDzFtNT+NpbY+oLGcjgj
   rn3FqQ580A+F01dtYTSWK6fhPEQHksBZ9dHXOQsbCNSQZXC/71xBEKfOD
   lNhc0uYo3uaeA/20yPUUudb3Cz/cUX7DwPur2EA+NQt9nWNrDgdza4iqO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622562"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622562"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020724"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:55 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com,
	xin@zytor.com
Subject: [PATCH v2 10/25] KVM: VMX: Add support for FRED context save/restore
Date: Wed,  7 Feb 2024 09:26:30 -0800
Message-ID: <20240207172646.3981-11-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle host initiated FRED MSR access requests to allow FRED context
to be set/get from user level.

During VM save/restore and live migration, FRED context needs to be
saved/restored, which requires FRED MSRs to be accessed from a user
level application, e.g., Qemu.

Note, handling of MSR_IA32_FRED_SSP0, i.e., MSR_IA32_PL0_SSP, is not
added yet, which is done in the KVM CET patch set.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Changes since v1:
* Use kvm_cpu_cap_has() instead of cpu_feature_enabled() (Chao Gao).
* Fail host requested FRED MSRs access if KVM cannot virtualize FRED
  (Chao Gao).
* Handle the case FRED MSRs are valid but KVM cannot virtualize FRED
  (Chao Gao).
* Add sanity checks when writing to FRED MSRs.
---
 arch/x86/kvm/vmx/vmx.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c     | 47 +++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 264378c3b784..ee61d2c25cb0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1420,6 +1420,24 @@ static void vmx_write_guest_kernel_gs_base(struct vcpu_vmx *vmx, u64 data)
 	preempt_enable();
 	vmx->msr_guest_kernel_gs_base = data;
 }
+
+static u64 vmx_read_guest_fred_rsp0(struct vcpu_vmx *vmx)
+{
+	preempt_disable();
+	if (vmx->guest_state_loaded)
+		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
+	preempt_enable();
+	return vmx->msr_guest_fred_rsp0;
+}
+
+static void vmx_write_guest_fred_rsp0(struct vcpu_vmx *vmx, u64 data)
+{
+	preempt_disable();
+	if (vmx->guest_state_loaded)
+		wrmsrl(MSR_IA32_FRED_RSP0, data);
+	preempt_enable();
+	vmx->msr_guest_fred_rsp0 = data;
+}
 #endif
 
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
@@ -2019,6 +2037,33 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_KERNEL_GS_BASE:
 		msr_info->data = vmx_read_guest_kernel_gs_base(vmx);
 		break;
+	case MSR_IA32_FRED_RSP0:
+		msr_info->data = vmx_read_guest_fred_rsp0(vmx);
+		break;
+	case MSR_IA32_FRED_RSP1:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP1);
+		break;
+	case MSR_IA32_FRED_RSP2:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP2);
+		break;
+	case MSR_IA32_FRED_RSP3:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP3);
+		break;
+	case MSR_IA32_FRED_STKLVLS:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_STKLVLS);
+		break;
+	case MSR_IA32_FRED_SSP1:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP1);
+		break;
+	case MSR_IA32_FRED_SSP2:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP2);
+		break;
+	case MSR_IA32_FRED_SSP3:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP3);
+		break;
+	case MSR_IA32_FRED_CONFIG:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_CONFIG);
+		break;
 #endif
 	case MSR_EFER:
 		return kvm_get_msr_common(vcpu, msr_info);
@@ -2226,6 +2271,33 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx_update_exception_bitmap(vcpu);
 		}
 		break;
+	case MSR_IA32_FRED_RSP0:
+		vmx_write_guest_fred_rsp0(vmx, data);
+		break;
+	case MSR_IA32_FRED_RSP1:
+		vmcs_write64(GUEST_IA32_FRED_RSP1, data);
+		break;
+	case MSR_IA32_FRED_RSP2:
+		vmcs_write64(GUEST_IA32_FRED_RSP2, data);
+		break;
+	case MSR_IA32_FRED_RSP3:
+		vmcs_write64(GUEST_IA32_FRED_RSP3, data);
+		break;
+	case MSR_IA32_FRED_STKLVLS:
+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, data);
+		break;
+	case MSR_IA32_FRED_SSP1:
+		vmcs_write64(GUEST_IA32_FRED_SSP1, data);
+		break;
+	case MSR_IA32_FRED_SSP2:
+		vmcs_write64(GUEST_IA32_FRED_SSP2, data);
+		break;
+	case MSR_IA32_FRED_SSP3:
+		vmcs_write64(GUEST_IA32_FRED_SSP3, data);
+		break;
+	case MSR_IA32_FRED_CONFIG:
+		vmcs_write64(GUEST_IA32_FRED_CONFIG, data);
+		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
 		if (is_guest_mode(vcpu))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 363b1c080205..4e8d60f248e3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1451,6 +1451,9 @@ static const u32 msrs_to_save_base[] = {
 	MSR_STAR,
 #ifdef CONFIG_X86_64
 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
+	MSR_IA32_FRED_RSP0, MSR_IA32_FRED_RSP1, MSR_IA32_FRED_RSP2,
+	MSR_IA32_FRED_RSP3, MSR_IA32_FRED_STKLVLS, MSR_IA32_FRED_SSP1,
+	MSR_IA32_FRED_SSP2, MSR_IA32_FRED_SSP3, MSR_IA32_FRED_CONFIG,
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
@@ -1892,6 +1895,30 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 			return 1;
 
 		data = (u32)data;
+		break;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
+		if (index != MSR_IA32_FRED_STKLVLS && is_noncanonical_address(data, vcpu))
+			return 1;
+		if ((index >= MSR_IA32_FRED_RSP0 && index <= MSR_IA32_FRED_RSP3) &&
+		    (data & GENMASK_ULL(5, 0)))
+			return 1;
+		if ((index >= MSR_IA32_FRED_SSP1 && index <= MSR_IA32_FRED_SSP3) &&
+		    (data & GENMASK_ULL(2, 0)))
+			return 1;
+
+		if (host_initiated) {
+			if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
+				return 1;
+		} else {
+			/*
+			 * Inject #GP upon FRED MSRs accesses from a non-FRED guest,
+			 * which also ensures no malicious guest can write to FRED
+			 * MSRs to corrupt host FRED MSRs.
+			 */
+			if (!guest_can_use(vcpu, X86_FEATURE_FRED))
+				return 1;
+		}
+
 		break;
 	}
 
@@ -1936,6 +1963,22 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDPID))
 			return 1;
 		break;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
+		if (host_initiated) {
+			if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
+				return 1;
+		} else {
+			/*
+			 * Inject #GP upon FRED MSRs accesses from a non-FRED guest,
+			 * which also ensures no malicious guest can write to FRED
+			 * MSRs to corrupt host FRED MSRs.
+			 */
+			if (!guest_can_use(vcpu, X86_FEATURE_FRED))
+				return 1;
+		}
+
+		break;
+
 	}
 
 	msr.index = index;
@@ -7364,6 +7407,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
 			return;
 		break;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
+		if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
+			return;
+		break;
 	default:
 		break;
 	}
-- 
2.43.0


