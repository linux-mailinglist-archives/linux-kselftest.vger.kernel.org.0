Return-Path: <linux-kselftest+bounces-49460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75891D3C1B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90667482E14
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0603ED13D;
	Tue, 20 Jan 2026 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HTwqJf8d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D23ECBEE;
	Tue, 20 Jan 2026 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896054; cv=none; b=dAfB42ZJTDGpAUVduNCn8wM+DYn+ynvYIoPeQIdvzZ/eCkQvN2FOhXcCT3JG754KNhZ27lIZRB7c4wvOAOqwTdqckHH8EnqD56thb1j+YiSfDeHKUn1LVWhV5++fPbVicgtZrge5pvhOICc+fQWfnBhv4Pcq5sGylHVq40pThAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896054; c=relaxed/simple;
	bh=q68cTHZRnro7z0zbvErSz7/9Ho0MfrDygzpTL0/owiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIlRmZRIr+VEXmhpQegdGlCFYeM6bCNqfsBy5ekqHjFnXw5A76frfDTRz2eMymUOK9cxjAJrNxLvoVxzADI63bcFo56xF82+j7WNukeSo/cePNQ6LF0UnVIrjoPkmOLXzqTKOo8sX2Wy/lPtuo/SfHaeGpWeWkUwnC/qv/rAqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HTwqJf8d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K3sOXm3252508;
	Tue, 20 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ob1mlZuf6a3
	qKt/RLGrn0uawIMSCBNu0l6O01IE8x3g=; b=HTwqJf8dC9MyH49l2NSgCMRC9fN
	FBpmg7HgYjcPO9VdDFtFfB9P/TfK9ey63NZ1LnKPzXsy9HO73Sti5ADxVm9wa1dy
	47vss/El8IS+6DueILtFEFaG2fLFrnImcV3lbfTcVVGF5g1+Uvrqm5vShZFx0jxe
	C4iMhfGt2pgC9mo5rQhp3iSDG3bbhtixJrfQUJJjrDdmqL5YeW5FIGDFn/2e7NjH
	Nj0P7eYoD4yxSox+sESqdBfPfiUV+VGyGBwOE4ROH1hKUEavJNcCBkJNQ6TKV34u
	B3jU9BBgrQv3WTbWy8RlDByqF6yxNwdPaP9LQyHgZyYRKv3MZuW5TaYBftA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt27agnka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Grg007970;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80GTI007912;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80GUw007886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id BB45C253A8; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 12/27] RISC-V: KVM: Extend kvm_riscv_mmu_update_hgatp() for nested virtualization
Date: Tue, 20 Jan 2026 13:29:58 +0530
Message-ID: <20260120080013.2153519-13-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Z4Y5wbfdm6zErcMift1pGtLMBaHW6RUX
X-Proofpoint-GUID: Z4Y5wbfdm6zErcMift1pGtLMBaHW6RUX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX33fnU3c8zIr4
 gH4RfQwC6w3MhaL3EjteBQlmHFPhvHaIb9bAwX8jxbKZhSVMb937mpb8rwgD38a66K5CS+GxuZ3
 33k4pIEhVe9iyMFL+hgT6s2nGhcqEsAI3kdxoIqYCS7FvqnTYkNx79F4n+WPfgY9H64ZMRJn6Wa
 g94okMaSZkWZUafuLzP9n9Fq8cb5apLqEyoOLlphapaYuITh/HuX6yjjDBMVPtJBQiyZndTp+Uy
 cBU/y7AOy7KhDMi57bHewlTJQtCdDSZ5IWGkJetSI7pArYwUaMIoAO2pUW944VRZyxDD1xYsh1R
 SD8WZvoXPHhFY4h/XSO7Lx2hEn9zcFlkBCOX1RQobUeLAzJ1MCqpmH7blx/IrO5iYH0Rl855e4l
 5tzclSPo35dPxZxIRPxckRP1eNBNlKDHfcK4o/ooSBtINoVRk/2FdsDXaTvmdGDDn3QADfvSJkh
 7R+Um+ipi60URDRKhsA==
X-Authority-Analysis: v=2.4 cv=P6U3RyAu c=1 sm=1 tr=0 ts=696f3613 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=43aeVLiLvglnvyQWThcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The kvm_riscv_mmu_update_hgatp() will be also used for when switching
between guest HS-mode and guest VS/VU-mode so extend it accordingly.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_gstage.h |  2 ++
 arch/riscv/include/asm/kvm_mmu.h    |  2 +-
 arch/riscv/kvm/gstage.c             | 14 ++++++++++++++
 arch/riscv/kvm/mmu.c                | 18 ++++++++----------
 arch/riscv/kvm/vcpu.c               |  4 ++--
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 595e2183173e..007a5fd7a526 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -67,6 +67,8 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 
 void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end);
 
+void kvm_riscv_gstage_update_hgatp(phys_addr_t pgd_phys, unsigned long vmid);
+
 void kvm_riscv_gstage_mode_detect(void);
 
 #endif
diff --git a/arch/riscv/include/asm/kvm_mmu.h b/arch/riscv/include/asm/kvm_mmu.h
index 5439e76f0a96..cc5994ec2805 100644
--- a/arch/riscv/include/asm/kvm_mmu.h
+++ b/arch/riscv/include/asm/kvm_mmu.h
@@ -16,6 +16,6 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		      struct kvm_gstage_mapping *out_map);
 int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm);
 void kvm_riscv_mmu_free_pgd(struct kvm *kvm);
-void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu);
+void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu, bool nested_virt);
 
 #endif
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index b67d60d722c2..7834e1178b68 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pgtable.h>
 #include <asm/kvm_gstage.h>
+#include <asm/kvm_nacl.h>
 
 #ifdef CONFIG_64BIT
 unsigned long kvm_riscv_gstage_mode __ro_after_init = HGATP_MODE_SV39X4;
@@ -313,6 +314,19 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 	}
 }
 
+void kvm_riscv_gstage_update_hgatp(phys_addr_t pgd_phys, unsigned long vmid)
+{
+	unsigned long hgatp = kvm_riscv_gstage_mode << HGATP_MODE_SHIFT;
+
+	hgatp |= (vmid << HGATP_VMID_SHIFT) & HGATP_VMID;
+	hgatp |= (pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
+
+	ncsr_write(CSR_HGATP, hgatp);
+
+	if (!kvm_riscv_gstage_vmid_bits())
+		kvm_riscv_local_hfence_gvma_all();
+}
+
 void __init kvm_riscv_gstage_mode_detect(void)
 {
 #ifdef CONFIG_64BIT
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 0b75eb2a1820..250606f5aa41 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -14,7 +14,6 @@
 #include <linux/kvm_host.h>
 #include <linux/sched/signal.h>
 #include <asm/kvm_mmu.h>
-#include <asm/kvm_nacl.h>
 
 static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 {
@@ -597,16 +596,15 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
 }
 
-void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
+void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu, bool nested_virt)
 {
-	unsigned long hgatp = kvm_riscv_gstage_mode << HGATP_MODE_SHIFT;
+	struct kvm_vcpu_nested_swtlb *nst = &vcpu->arch.nested.swtlb;
 	struct kvm_arch *k = &vcpu->kvm->arch;
+	unsigned long vmid = READ_ONCE(k->vmid.vmid);
 
-	hgatp |= (READ_ONCE(k->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
-	hgatp |= (k->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
-
-	ncsr_write(CSR_HGATP, hgatp);
-
-	if (!kvm_riscv_gstage_vmid_bits())
-		kvm_riscv_local_hfence_gvma_all();
+	if (nested_virt)
+		kvm_riscv_gstage_update_hgatp(nst->shadow_pgd_phys,
+					      kvm_riscv_gstage_nested_vmid(vmid));
+	else
+		kvm_riscv_gstage_update_hgatp(k->pgd_phys, vmid);
 }
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 859c8e71df65..178a4409d4e9 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -585,7 +585,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		csr_write(CSR_VSATP, csr->vsatp);
 	}
 
-	kvm_riscv_mmu_update_hgatp(vcpu);
+	kvm_riscv_mmu_update_hgatp(vcpu, kvm_riscv_vcpu_nested_virt(vcpu));
 
 	kvm_riscv_vcpu_timer_restore(vcpu);
 
@@ -677,7 +677,7 @@ static int kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
 			kvm_riscv_reset_vcpu(vcpu, true);
 
 		if (kvm_check_request(KVM_REQ_UPDATE_HGATP, vcpu))
-			kvm_riscv_mmu_update_hgatp(vcpu);
+			kvm_riscv_mmu_update_hgatp(vcpu, kvm_riscv_vcpu_nested_virt(vcpu));
 
 		if (kvm_check_request(KVM_REQ_FENCE_I, vcpu))
 			kvm_riscv_fence_i_process(vcpu);
-- 
2.43.0


