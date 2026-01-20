Return-Path: <linux-kselftest+bounces-49467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C6AD3C27E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97F955C70C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42733F23DA;
	Tue, 20 Jan 2026 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dkb2rthB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647E38A71C;
	Tue, 20 Jan 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896105; cv=none; b=Oa966zkY35a5grQ2BPqxCvjndR/+tIaa9oateSkt/icTqU0IGTagq4HGm0TPWm3xxxjkHZgGuPyBWuX+u9MBb7QdXVXfmucup5LpWo9yCU2O/hDAhzk7V/5oCtjOzmA7SEIlBgb8vqW70D3C84JVyjvzaNAuY0fgQ/4szrvR5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896105; c=relaxed/simple;
	bh=kKNGfoHOlJofoflIqaWCUP3OtdJcAWZtDyf5omhfyvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uW0sBeP+volbCFDjfNx132/kU1BFJkAkjkRxyUyU60kcOQtnekLx4oZN0yjFug8+P2TpFYUWtcvaILwn4fKGzqS/y6VqndGLS57DSGUBj6seQkXCcgYKIfiy5HhQaqREHEsO5mcghX697U7H2fdw1CSkx7R1E/JT/1In9idH2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dkb2rthB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K3sKYb3252356;
	Tue, 20 Jan 2026 08:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=08CXMH+3fio
	nZGdpPyb35qu77Wxs/Hrd6CJ6+uGPU8Q=; b=Dkb2rthB20MzKZxEopF5OCe3iLi
	bArT7Pi16THAvNJV2j+nIwn8fEJuU0VkBI5UWa/rLG+XPQXwVx3tff8mh7QV3QmJ
	N41Tkmug/3S5LCFj2VPNS+U7H/NnxT0C3BzT6PJL/o9G/O63iuR0fixqZNkrwYVC
	tvJsRnSnOEqmaXJL3J1DTPWO6iG+Nxy1Ukh3XSfFg6oR9S+0g1wAz9qtIz31eJkr
	5am//e0ESS8L8xvw84cB3Yycx/dRNQq44B+aipiQy8g3D5nrzNm74VvtiffGEMpq
	XiB7jaEgKxFbflX8v1urWihVBjeOQG9enCJuCI/MAWXMHc9fYgUDMONbg9Q==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt27agnkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80FpM007859;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Hkh008019;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80HvQ008002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id D9EFA255BC; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 21/27] RISC-V: KVM: Implement remote HFENCE SBI calls for guest
Date: Tue, 20 Jan 2026 13:30:07 +0530
Message-ID: <20260120080013.2153519-22-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 86ExNjxOIc_1yLbhKSgAAF7EJzDnkKsX
X-Proofpoint-GUID: 86ExNjxOIc_1yLbhKSgAAF7EJzDnkKsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX0iEVDQ4tTi7Q
 /Dnrmd+gAQNWM7YFy8v5ZyV+ckIXogrXpsNhNu0Uo+32umJt1/ameMGF8g+g0qHjPH6rfbWMkEu
 hRNmRWxuojt3VsJTXyVFpztLPE4KH8fAR5y+Z+PhWPwD/FiVdeXih7vG9ZGMoWP9m4N4jvRyg2Y
 mCDPukdfK8k7sIXlEEXj5z7xfo5d+uHDohVpotsD38/BXNvtKu30pavuf98ZypHbGpHJvAz2eSD
 VFn55fdqIIEw/2lZ354xeyy43sxWRLXXVwOmgn9n1mcjbdPqbDabvHmKf+BTPu++T13jBAOCADP
 wkX8JXiCSpkQEqdOH0+7XXt6McTLFIihTtyK6Zj8KCxTqnTfuHHapB2CyaEAA8SlQrx4DqQeNK9
 D73mMYW8luFLga09HKyjMa2uNZFtCkuvDMLJFA0FhPDlZnMLECj0RBHlfRHVReIsnn8h/PbyTrI
 BLYIIJI4yDv1e8ehoAQ==
X-Authority-Analysis: v=2.4 cv=P6U3RyAu c=1 sm=1 tr=0 ts=696f3614 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=fGIoQw85HC73EzAJJ9gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The remote HFENCE SBI calls can now be implemented as operations
on the nested g-stage page table emulated for the guest.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_host.h        |   2 +
 arch/riscv/include/asm/kvm_tlb.h         |  37 ++++++-
 arch/riscv/include/asm/kvm_vcpu_nested.h |  14 +++
 arch/riscv/kvm/tlb.c                     | 124 +++++++++++++++++++++++
 arch/riscv/kvm/vcpu_nested_swtlb.c       |  76 ++++++++++++++
 arch/riscv/kvm/vcpu_sbi_replace.c        |  63 +++++++++++-
 6 files changed, 310 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index c510564a09a2..2f097459ee14 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -47,6 +47,8 @@
 	KVM_ARCH_REQ_FLAGS(5, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
 #define KVM_REQ_NESTED_SWTLB		KVM_ARCH_REQ(7)
+#define KVM_REQ_NESTED_HFENCE_GVMA_ALL	KVM_ARCH_REQ(8)
+#define KVM_REQ_NESTED_HFENCE_VVMA_ALL	KVM_ARCH_REQ(9)
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
 
diff --git a/arch/riscv/include/asm/kvm_tlb.h b/arch/riscv/include/asm/kvm_tlb.h
index a0e7099bcb85..591b8735000f 100644
--- a/arch/riscv/include/asm/kvm_tlb.h
+++ b/arch/riscv/include/asm/kvm_tlb.h
@@ -15,7 +15,11 @@ enum kvm_riscv_hfence_type {
 	KVM_RISCV_HFENCE_VVMA_ASID_GVA,
 	KVM_RISCV_HFENCE_VVMA_ASID_ALL,
 	KVM_RISCV_HFENCE_VVMA_GVA,
-	KVM_RISCV_HFENCE_VVMA_ALL
+	KVM_RISCV_HFENCE_VVMA_ALL,
+	KVM_RISCV_NESTED_HFENCE_GVMA_GPA,
+	KVM_RISCV_NESTED_HFENCE_GVMA_VMID_GPA,
+	KVM_RISCV_NESTED_HFENCE_VVMA_GVA,
+	KVM_RISCV_NESTED_HFENCE_VVMA_ASID_GVA,
 };
 
 struct kvm_riscv_hfence {
@@ -56,6 +60,8 @@ void kvm_riscv_tlb_flush_process(struct kvm_vcpu *vcpu);
 void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu);
 void kvm_riscv_hfence_vvma_all_process(struct kvm_vcpu *vcpu);
 void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu);
+void kvm_riscv_nested_hfence_gvma_all_process(struct kvm_vcpu *vcpu);
+void kvm_riscv_nested_hfence_vvma_all_process(struct kvm_vcpu *vcpu);
 
 void kvm_riscv_fence_i(struct kvm *kvm,
 		       unsigned long hbase, unsigned long hmask);
@@ -82,4 +88,33 @@ void kvm_riscv_hfence_vvma_all(struct kvm *kvm,
 			       unsigned long hbase, unsigned long hmask,
 			       unsigned long vmid);
 
+void kvm_riscv_nested_hfence_gvma_gpa(struct kvm *kvm,
+				      unsigned long hbase, unsigned long hmask,
+				      gpa_t gpa, gpa_t gpsz,
+				      unsigned long order);
+void kvm_riscv_nested_hfence_gvma_all(struct kvm *kvm,
+				      unsigned long hbase, unsigned long hmask);
+void kvm_riscv_nested_hfence_gvma_vmid_gpa(struct kvm *kvm,
+					   unsigned long hbase, unsigned long hmask,
+					   gpa_t gpa, gpa_t gpsz,
+					   unsigned long order, unsigned long vmid);
+void kvm_riscv_nested_hfence_gvma_vmid_all(struct kvm *kvm,
+					   unsigned long hbase, unsigned long hmask,
+					   unsigned long vmid);
+void kvm_riscv_nested_hfence_vvma_gva(struct kvm *kvm,
+				      unsigned long hbase, unsigned long hmask,
+				      unsigned long gva, unsigned long gvsz,
+				      unsigned long order, unsigned long vmid);
+void kvm_riscv_nested_hfence_vvma_all(struct kvm *kvm,
+				      unsigned long hbase, unsigned long hmask,
+				      unsigned long vmid);
+void kvm_riscv_nested_hfence_vvma_asid_gva(struct kvm *kvm,
+					   unsigned long hbase, unsigned long hmask,
+					   unsigned long gva, unsigned long gvsz,
+					   unsigned long order, unsigned long asid,
+					   unsigned long vmid);
+void kvm_riscv_nested_hfence_vvma_asid_all(struct kvm *kvm,
+					   unsigned long hbase, unsigned long hmask,
+					   unsigned long asid, unsigned long vmid);
+
 #endif
diff --git a/arch/riscv/include/asm/kvm_vcpu_nested.h b/arch/riscv/include/asm/kvm_vcpu_nested.h
index 665c60f09ee6..4935ab0db1a2 100644
--- a/arch/riscv/include/asm/kvm_vcpu_nested.h
+++ b/arch/riscv/include/asm/kvm_vcpu_nested.h
@@ -69,6 +69,20 @@ int kvm_riscv_vcpu_nested_swtlb_xlate(struct kvm_vcpu *vcpu,
 				      const struct kvm_cpu_trap *trap,
 				      struct kvm_gstage_mapping *out_map,
 				      struct kvm_cpu_trap *out_trap);
+void kvm_riscv_vcpu_nested_swtlb_vvma_flush(struct kvm_vcpu *vcpu,
+					    unsigned long vaddr, unsigned long size,
+					    unsigned long order, unsigned long vmid);
+void kvm_riscv_vcpu_nested_swtlb_vvma_flush_asid(struct kvm_vcpu *vcpu,
+						 unsigned long vaddr, unsigned long size,
+						 unsigned long order, unsigned long vmid,
+						 unsigned long asid);
+void kvm_riscv_vcpu_nested_swtlb_gvma_flush(struct kvm_vcpu *vcpu,
+					    gpa_t addr, gpa_t size, unsigned long order);
+void kvm_riscv_vcpu_nested_swtlb_gvma_flush_vmid(struct kvm_vcpu *vcpu,
+						 gpa_t addr, gpa_t size, unsigned long order,
+						 unsigned long vmid);
+void kvm_riscv_vcpu_nested_swtlb_host_flush(struct kvm_vcpu *vcpu,
+					    gpa_t addr, gpa_t size, unsigned long order);
 void kvm_riscv_vcpu_nested_swtlb_process(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_nested_swtlb_request(struct kvm_vcpu *vcpu,
 					 const struct kvm_gstage_mapping *guest_map,
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index a95aa5336560..1b48a5ff81d1 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -210,6 +210,7 @@ void kvm_riscv_tlb_flush_process(struct kvm_vcpu *vcpu)
 		nacl_hfence_gvma_vmid_all(nacl_shmem(), vmid);
 	else
 		kvm_riscv_local_hfence_gvma_vmid_all(vmid);
+	kvm_riscv_vcpu_nested_swtlb_host_flush(vcpu, 0, 0, 0);
 }
 
 void kvm_riscv_hfence_vvma_all_process(struct kvm_vcpu *vcpu)
@@ -223,6 +224,16 @@ void kvm_riscv_hfence_vvma_all_process(struct kvm_vcpu *vcpu)
 		kvm_riscv_local_hfence_vvma_all(vmid);
 }
 
+void kvm_riscv_nested_hfence_gvma_all_process(struct kvm_vcpu *vcpu)
+{
+	kvm_riscv_vcpu_nested_swtlb_gvma_flush(vcpu, 0, 0, 0);
+}
+
+void kvm_riscv_nested_hfence_vvma_all_process(struct kvm_vcpu *vcpu)
+{
+	kvm_riscv_vcpu_nested_swtlb_vvma_flush(vcpu, 0, 0, 0, -1UL);
+}
+
 static bool vcpu_hfence_dequeue(struct kvm_vcpu *vcpu,
 				struct kvm_riscv_hfence *out_data)
 {
@@ -287,12 +298,14 @@ void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
 			else
 				kvm_riscv_local_hfence_gvma_vmid_gpa(d.vmid, d.addr,
 								     d.size, d.order);
+			kvm_riscv_vcpu_nested_swtlb_host_flush(vcpu, d.addr, d.size, d.order);
 			break;
 		case KVM_RISCV_HFENCE_GVMA_VMID_ALL:
 			if (kvm_riscv_nacl_available())
 				nacl_hfence_gvma_vmid_all(nacl_shmem(), d.vmid);
 			else
 				kvm_riscv_local_hfence_gvma_vmid_all(d.vmid);
+			kvm_riscv_vcpu_nested_swtlb_host_flush(vcpu, 0, 0, 0);
 			break;
 		case KVM_RISCV_HFENCE_VVMA_ASID_GVA:
 			kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD);
@@ -464,6 +477,117 @@ void kvm_riscv_hfence_vvma_all(struct kvm *kvm,
 			    KVM_REQ_HFENCE_VVMA_ALL, &data);
 }
 
+void kvm_riscv_nested_hfence_gvma_gpa(struct kvm *kvm,
+				      unsigned long hbase, unsigned long hmask,
+				      gpa_t gpa, gpa_t gpsz,
+				      unsigned long order)
+{
+	struct kvm_riscv_hfence data = {0};
+
+	data.type = KVM_RISCV_NESTED_HFENCE_GVMA_GPA;
+	data.addr = gpa;
+	data.size = gpsz;
+	data.order = order;
+	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE,
+			    KVM_REQ_NESTED_HFENCE_GVMA_ALL, &data);
+}
+
+void kvm_riscv_nested_hfence_gvma_all(struct kvm *kvm,
+				      unsigned long hbase, unsigned long hmask)
+{
+	make_xfence_request(kvm, hbase, hmask, KVM_REQ_NESTED_HFENCE_GVMA_ALL,
+			    KVM_REQ_NESTED_HFENCE_GVMA_ALL, NULL);
+}
+
+void kvm_riscv_nested_hfence_gvma_vmid_gpa(struct kvm *kvm,
+					   unsigned long hbase, unsigned long hmask,
+					   gpa_t gpa, gpa_t gpsz,
+					   unsigned long order, unsigned long vmid)
+{
+	struct kvm_riscv_hfence data;
+
+	data.type = KVM_RISCV_NESTED_HFENCE_GVMA_VMID_GPA;
+	data.asid = 0;
+	data.vmid = vmid;
+	data.addr = gpa;
+	data.size = gpsz;
+	data.order = order;
+	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE,
+			    KVM_REQ_NESTED_HFENCE_GVMA_ALL, &data);
+}
+
+void kvm_riscv_nested_hfence_gvma_vmid_all(struct kvm *kvm,
+					   unsigned long hbase, unsigned long hmask,
+					   unsigned long vmid)
+{
+	struct kvm_riscv_hfence data = {0};
+
+	data.type = KVM_RISCV_NESTED_HFENCE_GVMA_VMID_GPA;
+	data.vmid = vmid;
+	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE,
+			    KVM_REQ_NESTED_HFENCE_GVMA_ALL, &data);
+}
+
+void kvm_riscv_nested_hfence_vvma_gva(struct kvm *kvm,
+				      unsigned long hbase, unsigned long hmask,
+				      unsigned long gva, unsigned long gvsz,
+				      unsigned long order, unsigned long vmid)
+{
+	struct kvm_riscv_hfence data;
+
+	data.type = KVM_RISCV_NESTED_HFENCE_VVMA_GVA;
+	data.asid = 0;
+	data.vmid = vmid;
+	data.addr = gva;
+	data.size = gvsz;
+	data.order = order;
+	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE,
+			    KVM_REQ_NESTED_HFENCE_VVMA_ALL, &data);
+}
+
+void kvm_riscv_nested_hfence_vvma_all(struct kvm *kvm,
+				      unsigned long hbase, unsigned long hmask,
+				      unsigned long vmid)
+{
+	struct kvm_riscv_hfence data = {0};
+
+	data.type = KVM_RISCV_NESTED_HFENCE_VVMA_GVA;
+	data.vmid = vmid;
+	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE,
+			    KVM_REQ_NESTED_HFENCE_VVMA_ALL, &data);
+}
+
+void kvm_riscv_nested_hfence_vvma_asid_gva(struct kvm *kvm,
+					   unsigned long hbase, unsigned long hmask,
+					   unsigned long gva, unsigned long gvsz,
+					   unsigned long order, unsigned long asid,
+					   unsigned long vmid)
+{
+	struct kvm_riscv_hfence data;
+
+	data.type = KVM_RISCV_NESTED_HFENCE_VVMA_ASID_GVA;
+	data.asid = asid;
+	data.vmid = vmid;
+	data.addr = gva;
+	data.size = gvsz;
+	data.order = order;
+	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE,
+			    KVM_REQ_NESTED_HFENCE_VVMA_ALL, &data);
+}
+
+void kvm_riscv_nested_hfence_vvma_asid_all(struct kvm *kvm,
+					   unsigned long hbase, unsigned long hmask,
+					   unsigned long asid, unsigned long vmid)
+{
+	struct kvm_riscv_hfence data = {0};
+
+	data.type = KVM_RISCV_NESTED_HFENCE_VVMA_ASID_GVA;
+	data.asid = asid;
+	data.vmid = vmid;
+	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE,
+			    KVM_REQ_NESTED_HFENCE_VVMA_ALL, &data);
+}
+
 int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 nr_pages)
 {
 	kvm_riscv_hfence_gvma_vmid_gpa(kvm, -1UL, 0,
diff --git a/arch/riscv/kvm/vcpu_nested_swtlb.c b/arch/riscv/kvm/vcpu_nested_swtlb.c
index 1d9faf50a61f..7dabfc1c3e16 100644
--- a/arch/riscv/kvm/vcpu_nested_swtlb.c
+++ b/arch/riscv/kvm/vcpu_nested_swtlb.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <asm/kvm_nacl.h>
 
 int kvm_riscv_vcpu_nested_swtlb_xlate(struct kvm_vcpu *vcpu,
 				      const struct kvm_cpu_trap *trap,
@@ -14,6 +15,81 @@ int kvm_riscv_vcpu_nested_swtlb_xlate(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+void kvm_riscv_vcpu_nested_swtlb_vvma_flush(struct kvm_vcpu *vcpu,
+					    unsigned long vaddr, unsigned long size,
+					    unsigned long order, unsigned long vmid)
+{
+	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
+	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
+
+	if (vmid != -1UL && ((ns->csr.hgatp & HGATP_VMID) >> HGATP_VMID_SHIFT) != vmid)
+		return;
+
+	vmid = kvm_riscv_gstage_nested_vmid(READ_ONCE(v->vmid));
+	if (!vaddr && !size && !order) {
+		if (kvm_riscv_nacl_available())
+			nacl_hfence_vvma_all(nacl_shmem(), vmid);
+		else
+			kvm_riscv_local_hfence_vvma_all(vmid);
+	} else {
+		if (kvm_riscv_nacl_available())
+			nacl_hfence_vvma(nacl_shmem(), vmid, vaddr, size, order);
+		else
+			kvm_riscv_local_hfence_vvma_gva(vmid, vaddr, size, order);
+	}
+}
+
+void kvm_riscv_vcpu_nested_swtlb_vvma_flush_asid(struct kvm_vcpu *vcpu,
+						 unsigned long vaddr, unsigned long size,
+						 unsigned long order, unsigned long vmid,
+						 unsigned long asid)
+{
+	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
+	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
+
+	if (vmid != -1UL && ((ns->csr.hgatp & HGATP_VMID) >> HGATP_VMID_SHIFT) != vmid)
+		return;
+
+	vmid = kvm_riscv_gstage_nested_vmid(READ_ONCE(v->vmid));
+	if (!vaddr && !size && !order) {
+		if (kvm_riscv_nacl_available())
+			nacl_hfence_vvma_asid_all(nacl_shmem(), vmid, asid);
+		else
+			kvm_riscv_local_hfence_vvma_asid_all(vmid, asid);
+	} else {
+		if (kvm_riscv_nacl_available())
+			nacl_hfence_vvma_asid(nacl_shmem(), vmid, asid,
+					      vaddr, size, order);
+		else
+			kvm_riscv_local_hfence_vvma_asid_gva(vmid, asid, vaddr,
+							     size, order);
+	}
+}
+
+void kvm_riscv_vcpu_nested_swtlb_gvma_flush(struct kvm_vcpu *vcpu,
+					    gpa_t addr, gpa_t size, unsigned long order)
+{
+	/* TODO: */
+}
+
+void kvm_riscv_vcpu_nested_swtlb_gvma_flush_vmid(struct kvm_vcpu *vcpu,
+						 gpa_t addr, gpa_t size, unsigned long order,
+						 unsigned long vmid)
+{
+	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
+
+	if (vmid != -1UL && ((ns->csr.hgatp & HGATP_VMID) >> HGATP_VMID_SHIFT) != vmid)
+		return;
+
+	kvm_riscv_vcpu_nested_swtlb_gvma_flush(vcpu, addr, size, order);
+}
+
+void kvm_riscv_vcpu_nested_swtlb_host_flush(struct kvm_vcpu *vcpu,
+					    gpa_t addr, gpa_t size, unsigned long order)
+{
+	/* TODO: */
+}
+
 void kvm_riscv_vcpu_nested_swtlb_process(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_nested_swtlb *nst = &vcpu->arch.nested.swtlb;
diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 506a510b6bff..d60c7b05cd02 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -123,14 +123,67 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
 		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_ASID_SENT);
 		break;
 	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
+		/* Not supported if VCPU does not have H-extension */
+		if (!riscv_isa_extension_available(vcpu->arch.isa, h)) {
+			retdata->err_val = SBI_ERR_NOT_SUPPORTED;
+			break;
+		}
+
+		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
+			kvm_riscv_nested_hfence_gvma_all(vcpu->kvm, hbase, hmask);
+		else
+			kvm_riscv_nested_hfence_gvma_gpa(vcpu->kvm, hbase, hmask,
+							 cp->a2, cp->a3, PAGE_SHIFT);
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_GVMA_SENT);
+		break;
 	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID:
+		/* Not supported if VCPU does not have H-extension */
+		if (!riscv_isa_extension_available(vcpu->arch.isa, h)) {
+			retdata->err_val = SBI_ERR_NOT_SUPPORTED;
+			break;
+		}
+
+		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
+			kvm_riscv_nested_hfence_gvma_vmid_all(vcpu->kvm,
+							      hbase, hmask, cp->a4);
+		else
+			kvm_riscv_nested_hfence_gvma_vmid_gpa(vcpu->kvm, hbase, hmask,
+							      cp->a2, cp->a3,
+							      PAGE_SHIFT, cp->a4);
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_GVMA_VMID_SENT);
+		break;
 	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA:
+		/* Not supported if VCPU does not have H-extension */
+		if (!riscv_isa_extension_available(vcpu->arch.isa, h)) {
+			retdata->err_val = SBI_ERR_NOT_SUPPORTED;
+			break;
+		}
+
+		vmid = (vcpu->arch.nested.csr.hgatp & HGATP_VMID) >> HGATP_VMID_SHIFT;
+		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
+			kvm_riscv_nested_hfence_vvma_all(vcpu->kvm, hbase, hmask, vmid);
+		else
+			kvm_riscv_nested_hfence_vvma_gva(vcpu->kvm, hbase, hmask,
+							 cp->a2, cp->a3, PAGE_SHIFT, vmid);
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_SENT);
+		break;
 	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
-		/*
-		 * Until nested virtualization is implemented, the
-		 * SBI HFENCE calls should return not supported
-		 * hence fallthrough.
-		 */
+		/* Not supported if VCPU does not have H-extension */
+		if (!riscv_isa_extension_available(vcpu->arch.isa, h)) {
+			retdata->err_val = SBI_ERR_NOT_SUPPORTED;
+			break;
+		}
+
+		vmid = (vcpu->arch.nested.csr.hgatp & HGATP_VMID) >> HGATP_VMID_SHIFT;
+		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
+			kvm_riscv_nested_hfence_vvma_asid_all(vcpu->kvm, hbase, hmask,
+							      cp->a4, vmid);
+		else
+			kvm_riscv_nested_hfence_vvma_asid_gva(vcpu->kvm, hbase, hmask,
+							      cp->a2, cp->a3, PAGE_SHIFT,
+							      cp->a4, vmid);
+		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_ASID_SENT);
+		break;
 	default:
 		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 	}
-- 
2.43.0


