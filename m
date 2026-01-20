Return-Path: <linux-kselftest+bounces-49457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90935D3C1D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B584B48013A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F443E95B0;
	Tue, 20 Jan 2026 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WFG/Y1wj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AC3DA7CE;
	Tue, 20 Jan 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896048; cv=none; b=LZYFKcdm8XLgGcYIQV5Sj9YRtRdtd6jTxjAay5VR4JeoZc1YV63iWCHA01EkfBoS77kaFOldhb1xqdUTZj/w/TSs/BgMHleAXC92smldbIRO7O/Spvyi85NG+qQl3n3H0HMM0iAxoqUviY8Q+4lguVvsaWIu5FIBVR/i/7NFfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896048; c=relaxed/simple;
	bh=1FyrtY4z7us8w5KanNxSMTQ2WvxgFZYFi7FpMJmW/zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOQRK884sV/Ib7oRIryuqWN7SYOG/J7Pz6z7gYGm6MQW/u+hMVQVflj9UAC1WJd0kJCuyI0wNXPeRnUV3mOw9AbK6mb/9aLpT3tyfr+jOjuY35g9uxxMjmpIz9124kNRUHNRe3Dv9pvh5NO1ENGgmYlji8wlQCbxbeR+CSoIjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WFG/Y1wj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K5UoPW774076;
	Tue, 20 Jan 2026 08:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cZTpAxcP9z8
	a0OAJSNBpKMeHkvi2gDPdFbwYijflKWU=; b=WFG/Y1wjJqKUhXPnQKLEQHp1nHW
	MVUcQ+ivNzfuw5VqaNwwlRYUeJmRsK23eckHoC8G8ogpuUis/sAQe/Xet9cHsVa5
	dTBd0qm/I8FUyoK4wTowL8kwbxScwxIHHwO+oUAWlZrXUQ5fDgDp3NydJ5ZDPoNF
	ApXnP4DfnGH7w3EKxUjSXhTz9npJgq+HyuhPgM74vzfbNyed4VSxGfWM27urwOa/
	rbr1SaI/2EM7TCco0q4D/jMblOElc2B7seavorEa2VcArq3ldvIi/xGDpxOSn/W0
	mdp4dfxn8DEBeAgprhnpOSkNuX+aPpbG2oXQcqvShyoypvPfeZbasuTy7JA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsj9ab743-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80HnM008067;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80GTK007912;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80Hvk008004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id C5BE325579; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH 15/27] RISC-V: KVM: Extend trap redirection for nested virtualization
Date: Tue, 20 Jan 2026 13:30:01 +0530
Message-ID: <20260120080013.2153519-16-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
References: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FK8E5Qck1I85jUPsO4PK6KZvLfW3BGez
X-Authority-Analysis: v=2.4 cv=N40k1m9B c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=8oevvQFq_g5LQl22nIQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX5ARfViYaB5HK
 CGiafPRidv14WLMTRrOofrsaahTngq2zUuPBTL48Af7MwSV/xh26u08xFWJEnK98odIRcKNtBG1
 yIyYGIAfcvOi0rcDk+cjdYHChkOQ+zLCO5kDOoRQdqIA6A1GDN007vpbCT8SW0BVp3u308HlcCk
 2/SHdfxT5SynNw+PJMZkvnwCkBoEd8/mu3x4J+M0XpHjeAqoyXZMvjwgEcIsJb1bivUmucbE60c
 uuuPbstCya1rWoQOI26QjeYDKBJBRir/W27+dYX4zKQjeDZ5JEQtEDGC5HFOOkpJN+q6dXVHc8+
 YlnkSCm09npLIJhK6DqgMRb2pss3ac6aFPkLJ8PzAs+uEyjHimcF0yan2KaE2f178yCBnEMBmxe
 Lb9N2gQSO0qPjJLEhiN0FOb9vkppZxEMKfX/aQviQZycpAB+A1O1n5MzWxG9uT5L3aofhGNx2+K
 tS+BOqmj/wAl48XBLvg==
X-Proofpoint-GUID: FK8E5Qck1I85jUPsO4PK6KZvLfW3BGez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The L0/host hypervisor must always redirect traps to the L1/guest
hypervisor so extend KVM RISC-V to perform the necessary nested
world-switch when redirecting traps.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_host.h        |   3 +
 arch/riscv/include/asm/kvm_vcpu_nested.h |  12 ++
 arch/riscv/kvm/vcpu_exit.c               |  28 +++-
 arch/riscv/kvm/vcpu_nested.c             | 162 +++++++++++++++++++++++
 4 files changed, 201 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 3b58953eb4eb..c510564a09a2 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -289,6 +289,9 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vcpu *vcpu,
 					 bool read_insn,
 					 unsigned long guest_addr,
 					 struct kvm_cpu_trap *trap);
+void kvm_riscv_vcpu_trap_smode_redirect(struct kvm_vcpu *vcpu,
+					struct kvm_cpu_trap *trap,
+					bool prev_priv);
 void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
 				  struct kvm_cpu_trap *trap);
 int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
diff --git a/arch/riscv/include/asm/kvm_vcpu_nested.h b/arch/riscv/include/asm/kvm_vcpu_nested.h
index 4234c6e81bb6..6bfb67702610 100644
--- a/arch/riscv/include/asm/kvm_vcpu_nested.h
+++ b/arch/riscv/include/asm/kvm_vcpu_nested.h
@@ -75,6 +75,18 @@ void kvm_riscv_vcpu_nested_swtlb_reset(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_nested_swtlb_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_nested_swtlb_deinit(struct kvm_vcpu *vcpu);
 
+enum kvm_vcpu_nested_set_virt_event {
+	NESTED_SET_VIRT_EVENT_TRAP = 0,
+	NESTED_SET_VIRT_EVENT_SRET
+};
+
+void kvm_riscv_vcpu_nested_set_virt(struct kvm_vcpu *vcpu,
+				    enum kvm_vcpu_nested_set_virt_event event,
+				    bool virt, bool spvp, bool gva);
+void kvm_riscv_vcpu_nested_trap_redirect(struct kvm_vcpu *vcpu,
+					 struct kvm_cpu_trap *trap,
+					 bool prev_priv);
+
 void kvm_riscv_vcpu_nested_reset(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_nested_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_nested_deinit(struct kvm_vcpu *vcpu);
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 4f63548e582f..aeec4c4eee06 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -149,19 +149,21 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vcpu *vcpu,
 }
 
 /**
- * kvm_riscv_vcpu_trap_redirect -- Redirect trap to Guest
+ * kvm_riscv_vcpu_trap_smode_redirect -- Redirect S-mode trap to Guest
  *
  * @vcpu: The VCPU pointer
  * @trap: Trap details
+ * @prev_priv: Previous privilege mode (true: S-mode, false: U-mode)
  */
-void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
-				  struct kvm_cpu_trap *trap)
+void kvm_riscv_vcpu_trap_smode_redirect(struct kvm_vcpu *vcpu,
+					struct kvm_cpu_trap *trap,
+					bool prev_priv)
 {
 	unsigned long vsstatus = ncsr_read(CSR_VSSTATUS);
 
 	/* Change Guest SSTATUS.SPP bit */
 	vsstatus &= ~SR_SPP;
-	if (vcpu->arch.guest_context.sstatus & SR_SPP)
+	if (prev_priv)
 		vsstatus |= SR_SPP;
 
 	/* Change Guest SSTATUS.SPIE bit */
@@ -187,6 +189,24 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
 	vcpu->arch.guest_context.sstatus |= SR_SPP;
 }
 
+/**
+ * kvm_riscv_vcpu_trap_redirect -- Redirect HS-mode trap to Guest
+ *
+ * @vcpu: The VCPU pointer
+ * @trap: Trap details
+ */
+void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
+				  struct kvm_cpu_trap *trap)
+{
+	bool prev_priv = (vcpu->arch.guest_context.sstatus & SR_SPP) ? true : false;
+
+	/* Update Guest nested state */
+	kvm_riscv_vcpu_nested_trap_redirect(vcpu, trap, prev_priv);
+
+	/* Update Guest supervisor state */
+	kvm_riscv_vcpu_trap_smode_redirect(vcpu, trap, prev_priv);
+}
+
 static inline int vcpu_redirect(struct kvm_vcpu *vcpu, struct kvm_cpu_trap *trap)
 {
 	int ret = -EFAULT;
diff --git a/arch/riscv/kvm/vcpu_nested.c b/arch/riscv/kvm/vcpu_nested.c
index 3c30d35b3b39..214206fc28bb 100644
--- a/arch/riscv/kvm/vcpu_nested.c
+++ b/arch/riscv/kvm/vcpu_nested.c
@@ -3,13 +3,175 @@
  * Copyright (c) 2026 Qualcomm Technologies, Inc.
  */
 
+#include <linux/smp.h>
 #include <linux/kvm_host.h>
+#include <asm/kvm_nacl.h>
+#include <asm/kvm_mmu.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_nested_available);
 
 static bool __read_mostly enable_nested_virt;
 module_param(enable_nested_virt, bool, 0644);
 
+void kvm_riscv_vcpu_nested_set_virt(struct kvm_vcpu *vcpu,
+				    enum kvm_vcpu_nested_set_virt_event event,
+				    bool virt, bool spvp, bool gva)
+{
+	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
+	struct kvm_vcpu_nested_csr *nsc = &ns->csr;
+	unsigned long tmp, sr_fs_vs_mask = 0;
+	int cpu;
+
+	/* If H-extension is not available for VCPU then do nothing */
+	if (!riscv_isa_extension_available(vcpu->arch.isa, h))
+		return;
+
+	/* Grab the CPU to ensure we remain on same CPU */
+	cpu = get_cpu();
+
+	/* Skip hardware CSR update if no change in virt state */
+	if (virt == ns->virt)
+		goto skip_csr_update;
+
+	/* Update config CSRs (aka hedeleg, hideleg, henvcfg, and hstateeX) */
+	kvm_riscv_vcpu_config_load(vcpu, virt);
+
+	/* Update time delta */
+	kvm_riscv_vcpu_update_timedelta(vcpu, virt);
+
+	/* Update G-stage page table */
+	kvm_riscv_mmu_update_hgatp(vcpu, virt);
+
+	/* Swap hardware vs<xyz> CSRs except vsie and vsstatus */
+	nsc->vstvec = ncsr_swap(CSR_VSTVEC, nsc->vstvec);
+	nsc->vsscratch = ncsr_swap(CSR_VSSCRATCH, nsc->vsscratch);
+	nsc->vsepc = ncsr_swap(CSR_VSEPC, nsc->vsepc);
+	nsc->vscause = ncsr_swap(CSR_VSCAUSE, nsc->vscause);
+	nsc->vstval = ncsr_swap(CSR_VSTVAL, nsc->vstval);
+	nsc->vsatp = ncsr_swap(CSR_VSATP, nsc->vsatp);
+
+	/* Update vsstatus CSR */
+	if (riscv_isa_extension_available(vcpu->arch.isa, f) ||
+	    riscv_isa_extension_available(vcpu->arch.isa, d))
+		sr_fs_vs_mask |= SR_FS;
+	if (riscv_isa_extension_available(vcpu->arch.isa, v))
+		sr_fs_vs_mask |= SR_VS;
+	if (virt) {
+		/*
+		 * Update vsstatus in following manner:
+		 * 1) Swap hardware vsstatus (i.e. virtual-HS mode sstatus) with
+		 *    vsstatus in nested virtualization context (i.e. virtual-VS
+		 *    mode sstatus)
+		 * 2) Swap host sstatus.[FS|VS] (i.e. HS mode sstatus.[FS|VS])
+		 *    with the vsstatus.[FS|VS] saved in nested virtualization
+		 *    context (i.e. virtual-HS mode sstatus.[FS|VS])
+		 */
+		nsc->vsstatus = ncsr_swap(CSR_VSSTATUS, nsc->vsstatus);
+		tmp = vcpu->arch.guest_context.sstatus & sr_fs_vs_mask;
+		vcpu->arch.guest_context.sstatus &= ~sr_fs_vs_mask;
+		vcpu->arch.guest_context.sstatus |= (nsc->vsstatus & sr_fs_vs_mask);
+		nsc->vsstatus &= ~sr_fs_vs_mask;
+		nsc->vsstatus |= tmp;
+	} else {
+		/*
+		 * Update vsstatus in following manner:
+		 * 1) Swap host sstatus.[FS|VS] (i.e. virtual-HS mode sstatus.[FS|VS])
+		 *    with vsstatus.[FS|VS] saved in the nested virtualization
+		 *    context (i.e. HS mode sstatus.[FS|VS])
+		 * 2) Swap hardware vsstatus (i.e. virtual-VS mode sstatus) with
+		 *    vsstatus in nested virtualization context (i.e. virtual-HS
+		 *    mode sstatus)
+		 */
+		tmp = vcpu->arch.guest_context.sstatus & sr_fs_vs_mask;
+		vcpu->arch.guest_context.sstatus &= ~sr_fs_vs_mask;
+		vcpu->arch.guest_context.sstatus |= (nsc->vsstatus & sr_fs_vs_mask);
+		nsc->vsstatus &= ~sr_fs_vs_mask;
+		nsc->vsstatus |= tmp;
+		nsc->vsstatus = ncsr_swap(CSR_VSSTATUS, nsc->vsstatus);
+	}
+
+skip_csr_update:
+	if (event != NESTED_SET_VIRT_EVENT_SRET) {
+		/* Update guest hstatus.SPV bit */
+		nsc->hstatus &= ~HSTATUS_SPV;
+		nsc->hstatus |= (ns->virt) ? HSTATUS_SPV : 0;
+
+		/* Update guest hstatus.SPVP bit */
+		if (ns->virt) {
+			nsc->hstatus &= ~HSTATUS_SPVP;
+			if (spvp)
+				nsc->hstatus |= HSTATUS_SPVP;
+		}
+
+		/* Update guest hstatus.GVA bit */
+		if (event == NESTED_SET_VIRT_EVENT_TRAP) {
+			nsc->hstatus &= ~HSTATUS_GVA;
+			nsc->hstatus |= (gva) ? HSTATUS_GVA : 0;
+		}
+	}
+
+	/* Update host SRET trapping */
+	vcpu->arch.guest_context.hstatus &= ~HSTATUS_VTSR;
+	if (virt) {
+		if (nsc->hstatus & HSTATUS_VTSR)
+			vcpu->arch.guest_context.hstatus |= HSTATUS_VTSR;
+	} else {
+		if (nsc->hstatus & HSTATUS_SPV)
+			vcpu->arch.guest_context.hstatus |= HSTATUS_VTSR;
+	}
+
+	/* Update host VM trapping */
+	vcpu->arch.guest_context.hstatus &= ~HSTATUS_VTVM;
+	if (virt && (nsc->hstatus & HSTATUS_VTVM))
+		vcpu->arch.guest_context.hstatus |= HSTATUS_VTVM;
+
+	/* Update virt flag */
+	ns->virt = virt;
+
+	/* Release CPU */
+	put_cpu();
+}
+
+void kvm_riscv_vcpu_nested_trap_redirect(struct kvm_vcpu *vcpu,
+					 struct kvm_cpu_trap *trap,
+					 bool prev_priv)
+{
+	bool gva;
+
+	/* Do nothing if H-extension is not available for VCPU */
+	if (!riscv_isa_extension_available(vcpu->arch.isa, h))
+		return;
+
+	/* Determine GVA bit state */
+	gva = false;
+	switch (trap->scause) {
+	case EXC_INST_MISALIGNED:
+	case EXC_INST_ACCESS:
+	case EXC_LOAD_MISALIGNED:
+	case EXC_LOAD_ACCESS:
+	case EXC_STORE_MISALIGNED:
+	case EXC_STORE_ACCESS:
+	case EXC_INST_PAGE_FAULT:
+	case EXC_LOAD_PAGE_FAULT:
+	case EXC_STORE_PAGE_FAULT:
+	case EXC_INST_GUEST_PAGE_FAULT:
+	case EXC_LOAD_GUEST_PAGE_FAULT:
+	case EXC_STORE_GUEST_PAGE_FAULT:
+		gva = true;
+		break;
+	default:
+		break;
+	}
+
+	/* Update Guest HTVAL and HTINST */
+	vcpu->arch.nested.csr.htval = trap->htval;
+	vcpu->arch.nested.csr.htinst = trap->htinst;
+
+	/* Turn-off nested virtualization for virtual-HS mode */
+	kvm_riscv_vcpu_nested_set_virt(vcpu, NESTED_SET_VIRT_EVENT_TRAP,
+				       false, prev_priv, gva);
+}
+
 void kvm_riscv_vcpu_nested_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
-- 
2.43.0


