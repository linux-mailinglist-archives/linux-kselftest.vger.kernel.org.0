Return-Path: <linux-kselftest+bounces-49453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9AD3C1CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E981B589584
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6233E8C46;
	Tue, 20 Jan 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhXrUy27"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D43D6495;
	Tue, 20 Jan 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896046; cv=none; b=W2Vhvbky7kCb5M+VutZA5xh7Tkp8z8cCjiaLCCGZx33fqBIfPRd14KRcitzfGziEGqS6Jc0/fjPJL/+1XOrgWPliHTbaNGILIYSQZF4MVbaWtdsQwqFz0e8Yx49nS5ElQO6bbEWPH1y1YbrhbL7Fyep5jrZinlC2JmD+LneBTOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896046; c=relaxed/simple;
	bh=DGvnzBBTcW2GRobHAD/nwxigQsFWDnCQw2ymRHIwZsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nusjXFYKxmlNa8w+wsWnxPRoFDbb/NisDrRMN4JxAlAau9sywopnkAMMQlXtigv0sJ7FnImeFW5YFRDkZ0tBAIMV5KWeHEp2++6uQb2u35LSmZwq8oGe1g7DJVS2ednU/bWhYN4bDMD59qVdLNUXUjjQqFFZt7ZUuhNN7xtbx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhXrUy27; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K29HEp3176259;
	Tue, 20 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9kYDxHs9MRU
	Ovyl0H/A1mVAYEIz1SCyJy7D2jJRTaKg=; b=RhXrUy27cJw67DkPxH5Iu04DnmJ
	qIkMoiCAQ/o304Lu4rsqIqsqexdr3GJqsay66HhcibmMqj3gjwBI6UW8BVXMiPR5
	IaY+NbqP9bL9WBKkYbytAMFN3WrsA1HOkgFIn0b1OGpItEIz/7rXACtjagGhlBWr
	k+j6z7UwD22bQk6jp/BgtVSmwZ9A7VgJotlmZCnYFiokDRC9NuA5Dg4g9FCPBayE
	cqerBLt2dzB0yFcWKqvz/VxdbQ0EGXsHUShufNPFDuoCClrmZUsW3Kxrq6+tGINl
	WB5hupx+/S9NbavnfbGL9Rc6ShaDv6uKLbeeqMUT1HqdpYX/2DlPlmOJm2g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt0p2gx2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K7wBd6005898;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Fif007830;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80Gnd007888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id B47DA24A88; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 10/27] RISC-V: KVM: Initial skeletal nested virtualization support
Date: Tue, 20 Jan 2026 13:29:56 +0530
Message-ID: <20260120080013.2153519-11-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: A-H8m3biAm9lUrVhm-KcP6w4kSxmRuIR
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=696f3614 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=13pBwPEtajaBZmoNmVIA:9
X-Proofpoint-GUID: A-H8m3biAm9lUrVhm-KcP6w4kSxmRuIR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NiBTYWx0ZWRfX1Mx7RIqQSOHk
 0bVcBzYgSrimIUNBUQs8PJzQj9UY1ipZ7U+4ZFn1sZl8RS+lFOznenPCYmyKUUskcYzQVTeZIuL
 B+nF5W7NEkiQImXRPkUVSnu2ThiR1ovvlhsvswwgiMKT+9vLAhwMEArwnqUXOt69iLSN0W/2h/W
 NmxAs2YX1izxc/bexbZWMFTUiAXdbYD3F199WOSOy/aMhlKMXYM8ywjHhQ1Tw0oisuo6eGITn6P
 SFXwbMybPrUvlfVycHYDTs/PePEYSGYxzFM6cgZ/FrD2e6wUj1duslvX0TtZcQlfsY7t0Mp7hSa
 EhoZiD+GedG106sO2lPVLlkZAA205s5iP+778rdqahnrkAJKhNyocstNV78y86I/yr/cXWCva1D
 wIknjm9Qds8Fs0OsJ9wbLaiyn1IRjR9jPEAqcCvysjcL1qSO04LPo56SgTRowZDrCpxjr5xzbx7
 FXxZ1S4Q0XOJpQ1c9EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200066

Add initial skeletal nested virtualization support which is disabled
by default and needs to be explicitly enabled using module parameter.

Subsequent patches will further improve and complete the nested
virtualization support.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_host.h        |  5 ++
 arch/riscv/include/asm/kvm_vcpu_nested.h | 83 ++++++++++++++++++++++++
 arch/riscv/kvm/Makefile                  |  2 +
 arch/riscv/kvm/isa.c                     |  2 +-
 arch/riscv/kvm/main.c                    |  5 ++
 arch/riscv/kvm/vcpu.c                    | 20 +++++-
 arch/riscv/kvm/vcpu_exit.c               | 22 ++++++-
 arch/riscv/kvm/vcpu_nested.c             | 48 ++++++++++++++
 arch/riscv/kvm/vcpu_nested_swtlb.c       | 70 ++++++++++++++++++++
 9 files changed, 253 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_nested.h
 create mode 100644 arch/riscv/kvm/vcpu_nested.c
 create mode 100644 arch/riscv/kvm/vcpu_nested_swtlb.c

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 11c3566318ae..3b58953eb4eb 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -25,6 +25,7 @@
 #include <asm/kvm_vcpu_sbi_fwft.h>
 #include <asm/kvm_vcpu_timer.h>
 #include <asm/kvm_vcpu_pmu.h>
+#include <asm/kvm_vcpu_nested.h>
 
 #define KVM_MAX_VCPUS			1024
 
@@ -45,6 +46,7 @@
 #define KVM_REQ_HFENCE			\
 	KVM_ARCH_REQ_FLAGS(5, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
+#define KVM_REQ_NESTED_SWTLB		KVM_ARCH_REQ(7)
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
 
@@ -203,6 +205,9 @@ struct kvm_vcpu_arch {
 	/* CPU reset state of Guest VCPU */
 	struct kvm_vcpu_reset_state reset_state;
 
+	/* CPU nested virtualization context of Guest VCPU */
+	struct kvm_vcpu_nested nested;
+
 	/*
 	 * VCPU interrupts
 	 *
diff --git a/arch/riscv/include/asm/kvm_vcpu_nested.h b/arch/riscv/include/asm/kvm_vcpu_nested.h
new file mode 100644
index 000000000000..4234c6e81bb6
--- /dev/null
+++ b/arch/riscv/include/asm/kvm_vcpu_nested.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#ifndef __RISCV_VCPU_NESTED_H__
+#define __RISCV_VCPU_NESTED_H__
+
+#include <linux/jump_label.h>
+#include <linux/kvm_types.h>
+#include <asm/kvm_mmu.h>
+
+DECLARE_STATIC_KEY_FALSE(kvm_riscv_nested_available);
+#define kvm_riscv_nested_available() \
+	static_branch_unlikely(&kvm_riscv_nested_available)
+
+struct kvm_vcpu_nested_swtlb {
+	/* Software TLB request */
+	struct {
+		bool pending;
+		struct kvm_gstage_mapping guest;
+		struct kvm_gstage_mapping host;
+	} request;
+
+	/* Shadow G-stage page table for guest VS/VU-mode */
+	pgd_t *shadow_pgd;
+	phys_addr_t shadow_pgd_phys;
+};
+
+struct kvm_vcpu_nested_csr {
+	unsigned long hstatus;
+	unsigned long hedeleg;
+	unsigned long hideleg;
+	unsigned long hvip;
+	unsigned long hcounteren;
+	unsigned long htimedelta;
+	unsigned long htimedeltah;
+	unsigned long htval;
+	unsigned long htinst;
+	unsigned long henvcfg;
+	unsigned long henvcfgh;
+	unsigned long hgatp;
+	unsigned long vsstatus;
+	unsigned long vsie;
+	unsigned long vstvec;
+	unsigned long vsscratch;
+	unsigned long vsepc;
+	unsigned long vscause;
+	unsigned long vstval;
+	unsigned long vsatp;
+};
+
+struct kvm_vcpu_nested {
+	/* Nested virt state */
+	bool virt;
+
+	/* Nested software TLB request */
+	struct kvm_vcpu_nested_swtlb swtlb;
+
+	/* Nested CSR state */
+	struct kvm_vcpu_nested_csr csr;
+};
+
+#define kvm_riscv_vcpu_nested_virt(__vcpu) ((__vcpu)->arch.nested.virt)
+
+int kvm_riscv_vcpu_nested_swtlb_xlate(struct kvm_vcpu *vcpu,
+				      const struct kvm_cpu_trap *trap,
+				      struct kvm_gstage_mapping *out_map,
+				      struct kvm_cpu_trap *out_trap);
+void kvm_riscv_vcpu_nested_swtlb_process(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_nested_swtlb_request(struct kvm_vcpu *vcpu,
+					 const struct kvm_gstage_mapping *guest_map,
+					 const struct kvm_gstage_mapping *host_map);
+void kvm_riscv_vcpu_nested_swtlb_reset(struct kvm_vcpu *vcpu);
+int kvm_riscv_vcpu_nested_swtlb_init(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_nested_swtlb_deinit(struct kvm_vcpu *vcpu);
+
+void kvm_riscv_vcpu_nested_reset(struct kvm_vcpu *vcpu);
+int kvm_riscv_vcpu_nested_init(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_nested_deinit(struct kvm_vcpu *vcpu);
+void kvm_riscv_nested_init(void);
+
+#endif
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 296c2ba05089..a8806b69205f 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -25,6 +25,8 @@ kvm-y += vcpu_config.o
 kvm-y += vcpu_exit.o
 kvm-y += vcpu_fp.o
 kvm-y += vcpu_insn.o
+kvm-y += vcpu_nested.o
+kvm-y += vcpu_nested_swtlb.o
 kvm-y += vcpu_onereg.o
 kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
 kvm-y += vcpu_sbi.o
diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
index e860f6d79bb0..1566d01fc52e 100644
--- a/arch/riscv/kvm/isa.c
+++ b/arch/riscv/kvm/isa.c
@@ -145,7 +145,7 @@ bool kvm_riscv_isa_enable_allowed(unsigned long ext)
 {
 	switch (ext) {
 	case KVM_RISCV_ISA_EXT_H:
-		return false;
+		return kvm_riscv_nested_available();
 	case KVM_RISCV_ISA_EXT_SSCOFPMF:
 		/* Sscofpmf depends on interrupt filtering defined in ssaia */
 		return !kvm_riscv_isa_check_host(SSAIA);
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 588a84783dff..5b4bf972d242 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -131,6 +131,8 @@ static int __init riscv_kvm_init(void)
 		return rc;
 	}
 
+	kvm_riscv_nested_init();
+
 	kvm_info("hypervisor extension available\n");
 
 	if (kvm_riscv_nacl_available()) {
@@ -172,6 +174,9 @@ static int __init riscv_kvm_init(void)
 		kvm_info("AIA available with %d guest external interrupts\n",
 			 kvm_riscv_aia_nr_hgei);
 
+	if (kvm_riscv_nested_available())
+		kvm_info("nested virtualization available\n");
+
 	kvm_riscv_setup_vendor_features();
 
 	kvm_register_perf_callbacks(NULL);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 93c731da67f6..859c8e71df65 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -94,6 +94,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_reset)
 
 	kvm_riscv_vcpu_context_reset(vcpu, kvm_sbi_reset);
 
+	kvm_riscv_vcpu_nested_reset(vcpu);
+
 	kvm_riscv_vcpu_fp_reset(vcpu);
 
 	kvm_riscv_vcpu_vector_reset(vcpu);
@@ -152,10 +154,16 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	spin_lock_init(&vcpu->arch.reset_state.lock);
 
-	rc = kvm_riscv_vcpu_alloc_vector_context(vcpu);
+	rc = kvm_riscv_vcpu_nested_init(vcpu);
 	if (rc)
 		return rc;
 
+	rc = kvm_riscv_vcpu_alloc_vector_context(vcpu);
+	if (rc) {
+		kvm_riscv_vcpu_nested_deinit(vcpu);
+		return rc;
+	}
+
 	/* Setup VCPU timer */
 	kvm_riscv_vcpu_timer_init(vcpu);
 
@@ -205,6 +213,9 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 	/* Free vector context space for host and guest kernel */
 	kvm_riscv_vcpu_free_vector_context(vcpu);
+
+	/* Cleanup VCPU nested state */
+	kvm_riscv_vcpu_nested_deinit(vcpu);
 }
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
@@ -683,6 +694,13 @@ static int kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
 			kvm_riscv_vcpu_record_steal_time(vcpu);
 
+		/*
+		 * Process nested software TLB request after handling
+		 * various HFENCE requests.
+		 */
+		if (kvm_check_request(KVM_REQ_NESTED_SWTLB, vcpu))
+			kvm_riscv_vcpu_nested_swtlb_process(vcpu);
+
 		if (kvm_dirty_ring_check_request(vcpu))
 			return 0;
 	}
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 0bb0c51e3c89..4f63548e582f 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -15,14 +15,29 @@
 static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			     struct kvm_cpu_trap *trap)
 {
-	struct kvm_gstage_mapping host_map;
+	struct kvm_gstage_mapping guest_map, host_map;
 	struct kvm_memory_slot *memslot;
 	unsigned long hva, fault_addr;
+	struct kvm_cpu_trap out_trap;
 	bool writable;
 	gfn_t gfn;
 	int ret;
 
-	fault_addr = (trap->htval << 2) | (trap->stval & 0x3);
+	if (kvm_riscv_vcpu_nested_virt(vcpu)) {
+		memset(&out_trap, 0, sizeof(out_trap));
+		ret = kvm_riscv_vcpu_nested_swtlb_xlate(vcpu, trap, &guest_map, &out_trap);
+		if (ret <= 0)
+			return ret;
+		fault_addr = __page_val_to_pfn(pte_val(guest_map.pte)) << PAGE_SHIFT;
+
+		if (out_trap.scause) {
+			kvm_riscv_vcpu_trap_redirect(vcpu, &out_trap);
+			return 1;
+		}
+	} else {
+		fault_addr = (trap->htval << 2) | (trap->stval & 0x3);
+	}
+
 	gfn = fault_addr >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
 	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
@@ -49,6 +64,9 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	if (ret < 0)
 		return ret;
 
+	if (kvm_riscv_vcpu_nested_virt(vcpu) && !pte_none(host_map.pte))
+		kvm_riscv_vcpu_nested_swtlb_request(vcpu, &guest_map, &host_map);
+
 	return 1;
 }
 
diff --git a/arch/riscv/kvm/vcpu_nested.c b/arch/riscv/kvm/vcpu_nested.c
new file mode 100644
index 000000000000..3c30d35b3b39
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_nested.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#include <linux/kvm_host.h>
+
+DEFINE_STATIC_KEY_FALSE(kvm_riscv_nested_available);
+
+static bool __read_mostly enable_nested_virt;
+module_param(enable_nested_virt, bool, 0644);
+
+void kvm_riscv_vcpu_nested_reset(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
+	struct kvm_vcpu_nested_csr *ncsr = &vcpu->arch.nested.csr;
+
+	ns->virt = false;
+	kvm_riscv_vcpu_nested_swtlb_reset(vcpu);
+	memset(ncsr, 0, sizeof(*ncsr));
+}
+
+int kvm_riscv_vcpu_nested_init(struct kvm_vcpu *vcpu)
+{
+	return kvm_riscv_vcpu_nested_swtlb_init(vcpu);
+}
+
+void kvm_riscv_vcpu_nested_deinit(struct kvm_vcpu *vcpu)
+{
+	kvm_riscv_vcpu_nested_swtlb_deinit(vcpu);
+}
+
+void kvm_riscv_nested_init(void)
+{
+	/*
+	 * Nested virtualization uses hvictl CSR hence only
+	 * available when AIA is available.
+	 */
+	if (!kvm_riscv_aia_available())
+		return;
+
+	/* Check state of module parameter */
+	if (!enable_nested_virt)
+		return;
+
+	/* Enable KVM nested virtualization support */
+	static_branch_enable(&kvm_riscv_nested_available);
+}
diff --git a/arch/riscv/kvm/vcpu_nested_swtlb.c b/arch/riscv/kvm/vcpu_nested_swtlb.c
new file mode 100644
index 000000000000..1d9faf50a61f
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_nested_swtlb.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#include <linux/kvm_host.h>
+
+int kvm_riscv_vcpu_nested_swtlb_xlate(struct kvm_vcpu *vcpu,
+				      const struct kvm_cpu_trap *trap,
+				      struct kvm_gstage_mapping *out_map,
+				      struct kvm_cpu_trap *out_trap)
+{
+	/* TODO: */
+	return 0;
+}
+
+void kvm_riscv_vcpu_nested_swtlb_process(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_nested_swtlb *nst = &vcpu->arch.nested.swtlb;
+
+	WARN_ON(!nst->request.pending);
+
+	/* TODO: */
+
+	nst->request.pending = false;
+}
+
+void kvm_riscv_vcpu_nested_swtlb_request(struct kvm_vcpu *vcpu,
+					 const struct kvm_gstage_mapping *guest_map,
+					 const struct kvm_gstage_mapping *host_map)
+{
+	struct kvm_vcpu_nested_swtlb *nst = &vcpu->arch.nested.swtlb;
+
+	WARN_ON(nst->request.pending);
+
+	nst->request.pending = true;
+	memcpy(&nst->request.guest, guest_map, sizeof(*guest_map));
+	memcpy(&nst->request.host, host_map, sizeof(*host_map));
+
+	kvm_make_request(KVM_REQ_NESTED_SWTLB, vcpu);
+}
+
+void kvm_riscv_vcpu_nested_swtlb_reset(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_nested_swtlb *nst = &vcpu->arch.nested.swtlb;
+
+	memset(nst, 0, sizeof(*nst));
+}
+
+int kvm_riscv_vcpu_nested_swtlb_init(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_nested_swtlb *nst = &vcpu->arch.nested.swtlb;
+	struct page *pgd_page;
+
+	pgd_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
+			       get_order(kvm_riscv_gstage_pgd_size));
+	if (!pgd_page)
+		return -ENOMEM;
+	nst->shadow_pgd = page_to_virt(pgd_page);
+	nst->shadow_pgd_phys = page_to_phys(pgd_page);
+
+	return 0;
+}
+
+void kvm_riscv_vcpu_nested_swtlb_deinit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_nested_swtlb *nst = &vcpu->arch.nested.swtlb;
+
+	free_pages((unsigned long)nst->shadow_pgd, get_order(kvm_riscv_gstage_pgd_size));
+}
-- 
2.43.0


