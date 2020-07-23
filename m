Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287BB22AC59
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgGWKWf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 06:22:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgGWKWe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 06:22:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NA2JVn094777;
        Thu, 23 Jul 2020 06:22:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ecpbfhvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:16 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NA2QVo095445;
        Thu, 23 Jul 2020 06:22:16 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ecpbfhub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NAF18P017706;
        Thu, 23 Jul 2020 10:22:13 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq86274-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:22:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NAM9ko12386578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 10:22:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A07AEA4054;
        Thu, 23 Jul 2020 10:22:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE72A4064;
        Thu, 23 Jul 2020 10:22:06 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 10:22:06 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, paulus@samba.org
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/7] powerpc/watchpoint/kvm: Add infrastructure to support 2nd DAWR
Date:   Thu, 23 Jul 2020 15:50:53 +0530
Message-Id: <20200723102058.312282-3-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230072
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kvm code assumes single DAWR everywhere. Add code to support 2nd DAWR.
DAWR is a hypervisor resource and thus H_SET_MODE hcall is used to set/
unset it. Introduce new case H_SET_MODE_RESOURCE_SET_DAWR1 for 2nd DAWR.
Also, kvm will support 2nd DAWR only if CPU_FTR_DAWR1 is set.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst            |  2 ++
 arch/powerpc/include/asm/hvcall.h         |  2 ++
 arch/powerpc/include/asm/kvm_host.h       |  2 ++
 arch/powerpc/include/uapi/asm/kvm.h       |  4 +++
 arch/powerpc/kernel/asm-offsets.c         |  2 ++
 arch/powerpc/kvm/book3s_hv.c              | 41 +++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_nested.c       |  7 ++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 23 +++++++++++++
 tools/arch/powerpc/include/uapi/asm/kvm.h |  4 +++
 9 files changed, 87 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 4dc18fe6a2bf..7b1d16c2ad24 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -2242,6 +2242,8 @@ registers, find a list below:
   PPC     KVM_REG_PPC_PSSCR               64
   PPC     KVM_REG_PPC_DEC_EXPIRY          64
   PPC     KVM_REG_PPC_PTCR                64
+  PPC     KVM_REG_PPC_DAWR1               64
+  PPC     KVM_REG_PPC_DAWRX1              64
   PPC     KVM_REG_PPC_TM_GPR0             64
   ...
   PPC     KVM_REG_PPC_TM_GPR31            64
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 33793444144c..03f401d7be41 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -538,6 +538,8 @@ struct hv_guest_state {
 	s64 tb_offset;
 	u64 dawr0;
 	u64 dawrx0;
+	u64 dawr1;
+	u64 dawrx1;
 	u64 ciabr;
 	u64 hdec_expiry;
 	u64 purr;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 9aa3854f0e1e..bda839edd5fe 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -584,6 +584,8 @@ struct kvm_vcpu_arch {
 	ulong dabr;
 	ulong dawr0;
 	ulong dawrx0;
+	ulong dawr1;
+	ulong dawrx1;
 	ulong ciabr;
 	ulong cfar;
 	ulong ppr;
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 38d61b73f5ed..c5c0f128b46f 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -640,6 +640,10 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
 #define KVM_REG_PPC_PTCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc0)
 
+/* POWER10 registers. */
+#define KVM_REG_PPC_DAWR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc1)
+#define KVM_REG_PPC_DAWRX1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc2)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e76bffe348e1..ef2c0f3f5a7b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -549,6 +549,8 @@ int main(void)
 	OFFSET(VCPU_DABRX, kvm_vcpu, arch.dabrx);
 	OFFSET(VCPU_DAWR0, kvm_vcpu, arch.dawr0);
 	OFFSET(VCPU_DAWRX0, kvm_vcpu, arch.dawrx0);
+	OFFSET(VCPU_DAWR1, kvm_vcpu, arch.dawr1);
+	OFFSET(VCPU_DAWRX1, kvm_vcpu, arch.dawrx1);
 	OFFSET(VCPU_CIABR, kvm_vcpu, arch.ciabr);
 	OFFSET(VCPU_HFLAGS, kvm_vcpu, arch.hflags);
 	OFFSET(VCPU_DEC, kvm_vcpu, arch.dec);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 28200e4f5d27..24575520b2ea 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -781,6 +781,20 @@ static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
 		vcpu->arch.dawr0  = value1;
 		vcpu->arch.dawrx0 = value2;
 		return H_SUCCESS;
+	case H_SET_MODE_RESOURCE_SET_DAWR1:
+		if (!kvmppc_power8_compatible(vcpu))
+			return H_P2;
+		if (!ppc_breakpoint_available())
+			return H_P2;
+		if (!cpu_has_feature(CPU_FTR_DAWR1))
+			return H_P2;
+		if (mflags)
+			return H_UNSUPPORTED_FLAG_START;
+		if (value2 & DABRX_HYP)
+			return H_P4;
+		vcpu->arch.dawr1  = value1;
+		vcpu->arch.dawrx1 = value2;
+		return H_SUCCESS;
 	case H_SET_MODE_RESOURCE_ADDR_TRANS_MODE:
 		/* KVM does not support mflags=2 (AIL=2) */
 		if (mflags != 0 && mflags != 3)
@@ -1730,6 +1744,12 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_DAWRX0:
 		*val = get_reg_val(id, vcpu->arch.dawrx0);
 		break;
+	case KVM_REG_PPC_DAWR1:
+		*val = get_reg_val(id, vcpu->arch.dawr1);
+		break;
+	case KVM_REG_PPC_DAWRX1:
+		*val = get_reg_val(id, vcpu->arch.dawrx1);
+		break;
 	case KVM_REG_PPC_CIABR:
 		*val = get_reg_val(id, vcpu->arch.ciabr);
 		break;
@@ -1944,6 +1964,12 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_DAWRX0:
 		vcpu->arch.dawrx0 = set_reg_val(id, *val) & ~DAWRX_HYP;
 		break;
+	case KVM_REG_PPC_DAWR1:
+		vcpu->arch.dawr1 = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_DAWRX1:
+		vcpu->arch.dawrx1 = set_reg_val(id, *val) & ~DAWRX_HYP;
+		break;
 	case KVM_REG_PPC_CIABR:
 		vcpu->arch.ciabr = set_reg_val(id, *val);
 		/* Don't allow setting breakpoints in hypervisor code */
@@ -3401,6 +3427,13 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	unsigned long host_dawrx0 = mfspr(SPRN_DAWRX0);
 	unsigned long host_psscr = mfspr(SPRN_PSSCR);
 	unsigned long host_pidr = mfspr(SPRN_PID);
+	unsigned long host_dawr1 = 0;
+	unsigned long host_dawrx1 = 0;
+
+	if (cpu_has_feature(CPU_FTR_DAWR1)) {
+		host_dawr1 = mfspr(SPRN_DAWR1);
+		host_dawrx1 = mfspr(SPRN_DAWRX1);
+	}
 
 	hdec = time_limit - mftb();
 	if (hdec < 0)
@@ -3429,6 +3462,10 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	if (dawr_enabled()) {
 		mtspr(SPRN_DAWR0, vcpu->arch.dawr0);
 		mtspr(SPRN_DAWRX0, vcpu->arch.dawrx0);
+		if (cpu_has_feature(CPU_FTR_DAWR1)) {
+			mtspr(SPRN_DAWR1, vcpu->arch.dawr1);
+			mtspr(SPRN_DAWRX1, vcpu->arch.dawrx1);
+		}
 	}
 	mtspr(SPRN_CIABR, vcpu->arch.ciabr);
 	mtspr(SPRN_IC, vcpu->arch.ic);
@@ -3482,6 +3519,10 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	mtspr(SPRN_CIABR, host_ciabr);
 	mtspr(SPRN_DAWR0, host_dawr0);
 	mtspr(SPRN_DAWRX0, host_dawrx0);
+	if (cpu_has_feature(CPU_FTR_DAWR1)) {
+		mtspr(SPRN_DAWR1, host_dawr1);
+		mtspr(SPRN_DAWRX1, host_dawrx1);
+	}
 	mtspr(SPRN_PID, host_pidr);
 
 	/*
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 629f74edab22..03a3c7c5dc28 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -35,6 +35,8 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	hr->tb_offset = vc->tb_offset;
 	hr->dawr0 = vcpu->arch.dawr0;
 	hr->dawrx0 = vcpu->arch.dawrx0;
+	hr->dawr1 = vcpu->arch.dawr1;
+	hr->dawrx1 = vcpu->arch.dawrx1;
 	hr->ciabr = vcpu->arch.ciabr;
 	hr->purr = vcpu->arch.purr;
 	hr->spurr = vcpu->arch.spurr;
@@ -72,6 +74,8 @@ static void byteswap_hv_regs(struct hv_guest_state *hr)
 	hr->tb_offset = swab64(hr->tb_offset);
 	hr->dawr0 = swab64(hr->dawr0);
 	hr->dawrx0 = swab64(hr->dawrx0);
+	hr->dawr1 = swab64(hr->dawr1);
+	hr->dawrx1 = swab64(hr->dawrx1);
 	hr->ciabr = swab64(hr->ciabr);
 	hr->hdec_expiry = swab64(hr->hdec_expiry);
 	hr->purr = swab64(hr->purr);
@@ -138,6 +142,7 @@ static void sanitise_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 
 	/* Don't let data address watchpoint match in hypervisor state */
 	hr->dawrx0 &= ~DAWRX_HYP;
+	hr->dawrx1 &= ~DAWRX_HYP;
 
 	/* Don't let completed instruction address breakpt match in HV state */
 	if ((hr->ciabr & CIABR_PRIV) == CIABR_PRIV_HYPER)
@@ -153,6 +158,8 @@ static void restore_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	vcpu->arch.hfscr = hr->hfscr;
 	vcpu->arch.dawr0 = hr->dawr0;
 	vcpu->arch.dawrx0 = hr->dawrx0;
+	vcpu->arch.dawr1 = hr->dawr1;
+	vcpu->arch.dawrx1 = hr->dawrx1;
 	vcpu->arch.ciabr = hr->ciabr;
 	vcpu->arch.purr = hr->purr;
 	vcpu->arch.spurr = hr->spurr;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e562a9acbc2a..2006ec149532 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -57,6 +57,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 #define STACK_SLOT_HFSCR	(SFS-72)
 #define STACK_SLOT_AMR		(SFS-80)
 #define STACK_SLOT_UAMOR	(SFS-88)
+#define STACK_SLOT_DAWR1	(SFS-96)
+#define STACK_SLOT_DAWRX1	(SFS-104)
 /* the following is used by the P9 short path */
 #define STACK_SLOT_NVGPRS	(SFS-152)	/* 18 gprs */
 
@@ -715,6 +717,12 @@ BEGIN_FTR_SECTION
 	std	r7, STACK_SLOT_DAWRX0(r1)
 	std	r8, STACK_SLOT_IAMR(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+BEGIN_FTR_SECTION
+	mfspr	r6, SPRN_DAWR1
+	mfspr	r7, SPRN_DAWRX1
+	std	r6, STACK_SLOT_DAWR1(r1)
+	std	r7, STACK_SLOT_DAWRX1(r1)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S | CPU_FTR_DAWR1)
 
 	mfspr	r5, SPRN_AMR
 	std	r5, STACK_SLOT_AMR(r1)
@@ -805,6 +813,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	ld	r6, VCPU_DAWRX0(r4)
 	mtspr	SPRN_DAWR0, r5
 	mtspr	SPRN_DAWRX0, r6
+BEGIN_FTR_SECTION
+	ld	r5, VCPU_DAWR1(r4)
+	ld	r6, VCPU_DAWRX1(r4)
+	mtspr	SPRN_DAWR1, r5
+	mtspr	SPRN_DAWRX1, r6
+END_FTR_SECTION_IFSET(CPU_FTR_DAWR1)
 1:
 	ld	r7, VCPU_CIABR(r4)
 	ld	r8, VCPU_TAR(r4)
@@ -1769,6 +1783,12 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_DAWR0, r6
 	mtspr	SPRN_DAWRX0, r7
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+BEGIN_FTR_SECTION
+	ld	r6, STACK_SLOT_DAWR1(r1)
+	ld	r7, STACK_SLOT_DAWRX1(r1)
+	mtspr	SPRN_DAWR1, r6
+	mtspr	SPRN_DAWRX1, r7
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S | CPU_FTR_DAWR1)
 BEGIN_FTR_SECTION
 	ld	r5, STACK_SLOT_TID(r1)
 	ld	r6, STACK_SLOT_PSSCR(r1)
@@ -3335,6 +3355,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	mtspr	SPRN_IAMR, r0
 	mtspr	SPRN_CIABR, r0
 	mtspr	SPRN_DAWRX0, r0
+BEGIN_FTR_SECTION
+	mtspr	SPRN_DAWRX1, r0
+END_FTR_SECTION_IFSET(CPU_FTR_DAWR1)
 
 BEGIN_MMU_FTR_SECTION
 	b	4f
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 38d61b73f5ed..c5c0f128b46f 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -640,6 +640,10 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
 #define KVM_REG_PPC_PTCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc0)
 
+/* POWER10 registers. */
+#define KVM_REG_PPC_DAWR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc1)
+#define KVM_REG_PPC_DAWRX1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc2)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
-- 
2.26.2

