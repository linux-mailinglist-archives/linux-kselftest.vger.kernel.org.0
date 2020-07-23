Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7522AC5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 12:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgGWKWn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 06:22:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10622 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgGWKWm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 06:22:42 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NA2a8w180188;
        Thu, 23 Jul 2020 06:22:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d91x43q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:21 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NA2kUl180815;
        Thu, 23 Jul 2020 06:22:15 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d91x43mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:15 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NAHOHl010106;
        Thu, 23 Jul 2020 10:22:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 32brbgu68r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:22:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NAKfGE63439106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 10:20:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E322FA4064;
        Thu, 23 Jul 2020 10:22:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75FC9A4062;
        Thu, 23 Jul 2020 10:22:02 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 10:22:02 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, paulus@samba.org
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/7] powerpc/watchpoint/kvm: Rename current DAWR macros and variables
Date:   Thu, 23 Jul 2020 15:50:52 +0530
Message-Id: <20200723102058.312282-2-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=994 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230072
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Power10 is introducing second DAWR. Use real register names (with
suffix 0) from ISA for current macros and variables used by kvm.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst            |  4 +--
 arch/powerpc/include/asm/kvm_host.h       |  4 +--
 arch/powerpc/include/uapi/asm/kvm.h       |  4 +--
 arch/powerpc/kernel/asm-offsets.c         |  4 +--
 arch/powerpc/kvm/book3s_hv.c              | 32 +++++++++++------------
 arch/powerpc/kvm/book3s_hv_nested.c       |  8 +++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 20 +++++++-------
 tools/arch/powerpc/include/uapi/asm/kvm.h |  4 +--
 8 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 426f94582b7a..4dc18fe6a2bf 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -2219,8 +2219,8 @@ registers, find a list below:
   PPC     KVM_REG_PPC_BESCR               64
   PPC     KVM_REG_PPC_TAR                 64
   PPC     KVM_REG_PPC_DPDES               64
-  PPC     KVM_REG_PPC_DAWR                64
-  PPC     KVM_REG_PPC_DAWRX               64
+  PPC     KVM_REG_PPC_DAWR0               64
+  PPC     KVM_REG_PPC_DAWRX0              64
   PPC     KVM_REG_PPC_CIABR               64
   PPC     KVM_REG_PPC_IC                  64
   PPC     KVM_REG_PPC_VTB                 64
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7e2d061d0445..9aa3854f0e1e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -582,8 +582,8 @@ struct kvm_vcpu_arch {
 	u32 ctrl;
 	u32 dabrx;
 	ulong dabr;
-	ulong dawr;
-	ulong dawrx;
+	ulong dawr0;
+	ulong dawrx0;
 	ulong ciabr;
 	ulong cfar;
 	ulong ppr;
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 264e266a85bf..38d61b73f5ed 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -608,8 +608,8 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_BESCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa7)
 #define KVM_REG_PPC_TAR		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa8)
 #define KVM_REG_PPC_DPDES	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa9)
-#define KVM_REG_PPC_DAWR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
-#define KVM_REG_PPC_DAWRX	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
+#define KVM_REG_PPC_DAWR0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
+#define KVM_REG_PPC_DAWRX0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
 #define KVM_REG_PPC_CIABR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xac)
 #define KVM_REG_PPC_IC		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xad)
 #define KVM_REG_PPC_VTB		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xae)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6657dc6b2336..e76bffe348e1 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -547,8 +547,8 @@ int main(void)
 	OFFSET(VCPU_CTRL, kvm_vcpu, arch.ctrl);
 	OFFSET(VCPU_DABR, kvm_vcpu, arch.dabr);
 	OFFSET(VCPU_DABRX, kvm_vcpu, arch.dabrx);
-	OFFSET(VCPU_DAWR, kvm_vcpu, arch.dawr);
-	OFFSET(VCPU_DAWRX, kvm_vcpu, arch.dawrx);
+	OFFSET(VCPU_DAWR0, kvm_vcpu, arch.dawr0);
+	OFFSET(VCPU_DAWRX0, kvm_vcpu, arch.dawrx0);
 	OFFSET(VCPU_CIABR, kvm_vcpu, arch.ciabr);
 	OFFSET(VCPU_HFLAGS, kvm_vcpu, arch.hflags);
 	OFFSET(VCPU_DEC, kvm_vcpu, arch.dec);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 89afcc5f60ca..28200e4f5d27 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -778,8 +778,8 @@ static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
 			return H_UNSUPPORTED_FLAG_START;
 		if (value2 & DABRX_HYP)
 			return H_P4;
-		vcpu->arch.dawr  = value1;
-		vcpu->arch.dawrx = value2;
+		vcpu->arch.dawr0  = value1;
+		vcpu->arch.dawrx0 = value2;
 		return H_SUCCESS;
 	case H_SET_MODE_RESOURCE_ADDR_TRANS_MODE:
 		/* KVM does not support mflags=2 (AIL=2) */
@@ -1724,11 +1724,11 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_VTB:
 		*val = get_reg_val(id, vcpu->arch.vcore->vtb);
 		break;
-	case KVM_REG_PPC_DAWR:
-		*val = get_reg_val(id, vcpu->arch.dawr);
+	case KVM_REG_PPC_DAWR0:
+		*val = get_reg_val(id, vcpu->arch.dawr0);
 		break;
-	case KVM_REG_PPC_DAWRX:
-		*val = get_reg_val(id, vcpu->arch.dawrx);
+	case KVM_REG_PPC_DAWRX0:
+		*val = get_reg_val(id, vcpu->arch.dawrx0);
 		break;
 	case KVM_REG_PPC_CIABR:
 		*val = get_reg_val(id, vcpu->arch.ciabr);
@@ -1938,11 +1938,11 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_VTB:
 		vcpu->arch.vcore->vtb = set_reg_val(id, *val);
 		break;
-	case KVM_REG_PPC_DAWR:
-		vcpu->arch.dawr = set_reg_val(id, *val);
+	case KVM_REG_PPC_DAWR0:
+		vcpu->arch.dawr0 = set_reg_val(id, *val);
 		break;
-	case KVM_REG_PPC_DAWRX:
-		vcpu->arch.dawrx = set_reg_val(id, *val) & ~DAWRX_HYP;
+	case KVM_REG_PPC_DAWRX0:
+		vcpu->arch.dawrx0 = set_reg_val(id, *val) & ~DAWRX_HYP;
 		break;
 	case KVM_REG_PPC_CIABR:
 		vcpu->arch.ciabr = set_reg_val(id, *val);
@@ -3397,8 +3397,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	int trap;
 	unsigned long host_hfscr = mfspr(SPRN_HFSCR);
 	unsigned long host_ciabr = mfspr(SPRN_CIABR);
-	unsigned long host_dawr = mfspr(SPRN_DAWR0);
-	unsigned long host_dawrx = mfspr(SPRN_DAWRX0);
+	unsigned long host_dawr0 = mfspr(SPRN_DAWR0);
+	unsigned long host_dawrx0 = mfspr(SPRN_DAWRX0);
 	unsigned long host_psscr = mfspr(SPRN_PSSCR);
 	unsigned long host_pidr = mfspr(SPRN_PID);
 
@@ -3427,8 +3427,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	mtspr(SPRN_SPURR, vcpu->arch.spurr);
 
 	if (dawr_enabled()) {
-		mtspr(SPRN_DAWR0, vcpu->arch.dawr);
-		mtspr(SPRN_DAWRX0, vcpu->arch.dawrx);
+		mtspr(SPRN_DAWR0, vcpu->arch.dawr0);
+		mtspr(SPRN_DAWRX0, vcpu->arch.dawrx0);
 	}
 	mtspr(SPRN_CIABR, vcpu->arch.ciabr);
 	mtspr(SPRN_IC, vcpu->arch.ic);
@@ -3480,8 +3480,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	      (local_paca->kvm_hstate.fake_suspend << PSSCR_FAKE_SUSPEND_LG));
 	mtspr(SPRN_HFSCR, host_hfscr);
 	mtspr(SPRN_CIABR, host_ciabr);
-	mtspr(SPRN_DAWR0, host_dawr);
-	mtspr(SPRN_DAWRX0, host_dawrx);
+	mtspr(SPRN_DAWR0, host_dawr0);
+	mtspr(SPRN_DAWRX0, host_dawrx0);
 	mtspr(SPRN_PID, host_pidr);
 
 	/*
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 2c849a65db77..629f74edab22 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -33,8 +33,8 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	hr->dpdes = vc->dpdes;
 	hr->hfscr = vcpu->arch.hfscr;
 	hr->tb_offset = vc->tb_offset;
-	hr->dawr0 = vcpu->arch.dawr;
-	hr->dawrx0 = vcpu->arch.dawrx;
+	hr->dawr0 = vcpu->arch.dawr0;
+	hr->dawrx0 = vcpu->arch.dawrx0;
 	hr->ciabr = vcpu->arch.ciabr;
 	hr->purr = vcpu->arch.purr;
 	hr->spurr = vcpu->arch.spurr;
@@ -151,8 +151,8 @@ static void restore_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	vc->pcr = hr->pcr | PCR_MASK;
 	vc->dpdes = hr->dpdes;
 	vcpu->arch.hfscr = hr->hfscr;
-	vcpu->arch.dawr = hr->dawr0;
-	vcpu->arch.dawrx = hr->dawrx0;
+	vcpu->arch.dawr0 = hr->dawr0;
+	vcpu->arch.dawrx0 = hr->dawrx0;
 	vcpu->arch.ciabr = hr->ciabr;
 	vcpu->arch.purr = hr->purr;
 	vcpu->arch.spurr = hr->spurr;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 71943892c81c..e562a9acbc2a 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -52,8 +52,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 #define STACK_SLOT_PID		(SFS-32)
 #define STACK_SLOT_IAMR		(SFS-40)
 #define STACK_SLOT_CIABR	(SFS-48)
-#define STACK_SLOT_DAWR		(SFS-56)
-#define STACK_SLOT_DAWRX	(SFS-64)
+#define STACK_SLOT_DAWR0	(SFS-56)
+#define STACK_SLOT_DAWRX0	(SFS-64)
 #define STACK_SLOT_HFSCR	(SFS-72)
 #define STACK_SLOT_AMR		(SFS-80)
 #define STACK_SLOT_UAMOR	(SFS-88)
@@ -711,8 +711,8 @@ BEGIN_FTR_SECTION
 	mfspr	r7, SPRN_DAWRX0
 	mfspr	r8, SPRN_IAMR
 	std	r5, STACK_SLOT_CIABR(r1)
-	std	r6, STACK_SLOT_DAWR(r1)
-	std	r7, STACK_SLOT_DAWRX(r1)
+	std	r6, STACK_SLOT_DAWR0(r1)
+	std	r7, STACK_SLOT_DAWRX0(r1)
 	std	r8, STACK_SLOT_IAMR(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
@@ -801,8 +801,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	lbz	r5, 0(r5)
 	cmpdi	r5, 0
 	beq	1f
-	ld	r5, VCPU_DAWR(r4)
-	ld	r6, VCPU_DAWRX(r4)
+	ld	r5, VCPU_DAWR0(r4)
+	ld	r6, VCPU_DAWRX0(r4)
 	mtspr	SPRN_DAWR0, r5
 	mtspr	SPRN_DAWRX0, r6
 1:
@@ -1759,8 +1759,8 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/* Restore host values of some registers */
 BEGIN_FTR_SECTION
 	ld	r5, STACK_SLOT_CIABR(r1)
-	ld	r6, STACK_SLOT_DAWR(r1)
-	ld	r7, STACK_SLOT_DAWRX(r1)
+	ld	r6, STACK_SLOT_DAWR0(r1)
+	ld	r7, STACK_SLOT_DAWRX0(r1)
 	mtspr	SPRN_CIABR, r5
 	/*
 	 * If the DAWR doesn't work, it's ok to write these here as
@@ -2566,8 +2566,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	rlwimi	r5, r4, 5, DAWRX_DR | DAWRX_DW
 	rlwimi	r5, r4, 2, DAWRX_WT
 	clrrdi	r4, r4, 3
-	std	r4, VCPU_DAWR(r3)
-	std	r5, VCPU_DAWRX(r3)
+	std	r4, VCPU_DAWR0(r3)
+	std	r5, VCPU_DAWRX0(r3)
 	/*
 	 * If came in through the real mode hcall handler then it is necessary
 	 * to write the registers since the return path won't. Otherwise it is
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 264e266a85bf..38d61b73f5ed 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -608,8 +608,8 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_BESCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa7)
 #define KVM_REG_PPC_TAR		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa8)
 #define KVM_REG_PPC_DPDES	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa9)
-#define KVM_REG_PPC_DAWR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
-#define KVM_REG_PPC_DAWRX	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
+#define KVM_REG_PPC_DAWR0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
+#define KVM_REG_PPC_DAWRX0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
 #define KVM_REG_PPC_CIABR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xac)
 #define KVM_REG_PPC_IC		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xad)
 #define KVM_REG_PPC_VTB		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xae)
-- 
2.26.2

