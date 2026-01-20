Return-Path: <linux-kselftest+bounces-49454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF0D3C1D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD1E9449015
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C843E8C5A;
	Tue, 20 Jan 2026 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTH1r/ad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4853D7D7D;
	Tue, 20 Jan 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896047; cv=none; b=oAhtsAm42befqDwVejDptZR5cdKnu1zfPrM+FY4W1O4E5Yi7OWpCR99xLt8yBtWU1dpbNqrB0W8Ft4KlAzRDtOaOVqoKX3WVtuOpDinb0nWMkNFtKKG82SZ7A8xg6gIse+SP7Yn96SsR2jkbWlTgl05U/zVOhhIJVb1n6uQLqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896047; c=relaxed/simple;
	bh=YlXuMhlZRy5ozkPGgqP38Mt0O5yk1eKr6X3plSu/s6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRcz2AywzFx2mtfShTCwWR4Z7aisAO+ZiQwbZ7h7cRdp6buR13KRDXpSj/tMCsM4YlLj6nRDntY1wL0XCpuS24F2+p0WYcJfu+8c9JvLevZP8zSoQjyMUWYJQZIZizBkPYmd8P/AKjGE3owo0qwV388kF0IlzJ2WkJ39kVYOBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTH1r/ad; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K71b4d1408562;
	Tue, 20 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L++kpcd7KOu
	l9dMbaYb8MD4bLI6ftzFmLkUggwFirac=; b=NTH1r/adh/TVDnf3favynKo9a8k
	vBolegeF0CmOr3lJ9yVsmpHmZzBB5MXXsJTyKPSKxEVmDbbDdx23bzoo8sDtQKdy
	WN6mWYZmbT+OGnznFi7ygwLULp4JsfP16YNfumguDBnaUTVl8ps4CB/BkaTa7mU6
	OxD2N9M/ZWPk14d5uBrUqZMfnj1u3FZ3E4R9g80+PPP3IoSzThaiiVP4Vh/jMZOU
	5vm7tU5av3wtCCvGq6ZY1NVKPussJ2joykAuTOjAKzePTe9ks/XPvHwbMAp4jDGB
	wC1z0X7uIxL7pw+eJ23qqRGvK8UImsVxi2qYpNORkzTzXDC+n6W9gm8Apnw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4y2r59v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80FVH007880;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Fav007833;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80G9K007890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id ADA422497B; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 08/27] RISC-V: KVM: Factor-out VCPU config into separate sources
Date: Tue, 20 Jan 2026 13:29:54 +0530
Message-ID: <20260120080013.2153519-9-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX1ZXCikkOMv9d
 gUcAgrJMaUp6jdsuhLZuCY0DOpalYzCilSOuKtEhAOkdZfIm+2j9elSqGifVv8eBPvaqY/c0ghX
 jVVK4i/POH3BDbag1wUeaeZyxrelHLEuFv1Ff39KKHnFwoFv7pkbe9a7b8J5zuGcakdcBN9fHuQ
 BoonhESFX7EyGCsbiZxsBJe3f06XlXaJWMO7iib3+Axt/c2mjmXfLW5e4dl7wv73dlGsMdpbes+
 IAJDA3cMczcTTr2FKW6NLrF4fapqrqC0dRKaUIMmCafzR9HzrKHti3XwyCo6ZSl5qvyUcpB8krs
 2DoXVZathLy5tjQ8StL1BilXJoaLZBsg63vyu2vFbxeOGkvEEPCF0uATAtImT11ZcWxo/1abBDr
 JNBhvZAtIDC7OaRcOyO7oiqYgNmZE/3msdwLFKXU8gwlwTAM3qcpQkorFuV/b+eNV9EKKYcdwas
 55bGv8ZmUC6dM1R2vcg==
X-Authority-Analysis: v=2.4 cv=Ds1bOW/+ c=1 sm=1 tr=0 ts=696f3614 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=Smcp_bM4Nrcbihfk0HMA:9
X-Proofpoint-GUID: 6XEuFKLRJqunCHBz5LjaNXZrZAL1D_-d
X-Proofpoint-ORIG-GUID: 6XEuFKLRJqunCHBz5LjaNXZrZAL1D_-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

The VCPU config deals with hideleg, hedeleg, henvcfg, and hstateenX
CSR configuration for each VCPU. Factor-out VCPU config into separate
sources so that VCPU config can do things differently for guest HS-mode
and guest VS/VU-mode.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_host.h        |  20 +----
 arch/riscv/include/asm/kvm_vcpu_config.h |  25 ++++++
 arch/riscv/kvm/Makefile                  |   1 +
 arch/riscv/kvm/main.c                    |   4 +-
 arch/riscv/kvm/vcpu.c                    |  79 ++++--------------
 arch/riscv/kvm/vcpu_config.c             | 101 +++++++++++++++++++++++
 6 files changed, 144 insertions(+), 86 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_config.h
 create mode 100644 arch/riscv/kvm/vcpu_config.c

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index f3a41a1be678..11c3566318ae 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -18,6 +18,7 @@
 #include <asm/ptrace.h>
 #include <asm/kvm_tlb.h>
 #include <asm/kvm_vmid.h>
+#include <asm/kvm_vcpu_config.h>
 #include <asm/kvm_vcpu_fp.h>
 #include <asm/kvm_vcpu_insn.h>
 #include <asm/kvm_vcpu_sbi.h>
@@ -47,18 +48,6 @@
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
 
-#define KVM_HEDELEG_DEFAULT		(BIT(EXC_INST_MISALIGNED) | \
-					 BIT(EXC_INST_ILLEGAL)     | \
-					 BIT(EXC_BREAKPOINT)      | \
-					 BIT(EXC_SYSCALL)         | \
-					 BIT(EXC_INST_PAGE_FAULT) | \
-					 BIT(EXC_LOAD_PAGE_FAULT) | \
-					 BIT(EXC_STORE_PAGE_FAULT))
-
-#define KVM_HIDELEG_DEFAULT		(BIT(IRQ_VS_SOFT)  | \
-					 BIT(IRQ_VS_TIMER) | \
-					 BIT(IRQ_VS_EXT))
-
 #define KVM_DIRTY_LOG_MANUAL_CAPS	(KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 					 KVM_DIRTY_LOG_INITIALLY_SET)
 
@@ -167,13 +156,6 @@ struct kvm_vcpu_csr {
 	unsigned long senvcfg;
 };
 
-struct kvm_vcpu_config {
-	u64 henvcfg;
-	u64 hstateen0;
-	unsigned long hedeleg;
-	unsigned long hideleg;
-};
-
 struct kvm_vcpu_smstateen_csr {
 	unsigned long sstateen0;
 };
diff --git a/arch/riscv/include/asm/kvm_vcpu_config.h b/arch/riscv/include/asm/kvm_vcpu_config.h
new file mode 100644
index 000000000000..fcc15a0296b3
--- /dev/null
+++ b/arch/riscv/include/asm/kvm_vcpu_config.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#ifndef __KVM_VCPU_RISCV_CONFIG_H
+#define __KVM_VCPU_RISCV_CONFIG_H
+
+#include <linux/types.h>
+
+struct kvm_vcpu;
+
+struct kvm_vcpu_config {
+	u64 henvcfg;
+	u64 hstateen0;
+	unsigned long hedeleg;
+	unsigned long hideleg;
+};
+
+void kvm_riscv_vcpu_config_init(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_config_guest_debug(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu);
+
+#endif
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 07eab96189e7..296c2ba05089 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -21,6 +21,7 @@ kvm-y += mmu.o
 kvm-y += nacl.o
 kvm-y += tlb.o
 kvm-y += vcpu.o
+kvm-y += vcpu_config.o
 kvm-y += vcpu_exit.o
 kvm-y += vcpu_fp.o
 kvm-y += vcpu_insn.o
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 45536af521f0..588a84783dff 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -41,8 +41,8 @@ int kvm_arch_enable_virtualization_cpu(void)
 	if (rc)
 		return rc;
 
-	csr_write(CSR_HEDELEG, KVM_HEDELEG_DEFAULT);
-	csr_write(CSR_HIDELEG, KVM_HIDELEG_DEFAULT);
+	csr_write(CSR_HEDELEG, 0);
+	csr_write(CSR_HIDELEG, 0);
 
 	/* VS should access only the time counter directly. Everything else should trap */
 	csr_write(CSR_HCOUNTEREN, 0x02);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 494e0517ca4e..62599fc002e8 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -133,11 +133,12 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	/* Mark this VCPU never ran */
 	vcpu->arch.ran_atleast_once = false;
 
-	vcpu->arch.cfg.hedeleg = KVM_HEDELEG_DEFAULT;
-	vcpu->arch.cfg.hideleg = KVM_HIDELEG_DEFAULT;
 	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
 	bitmap_zero(vcpu->arch.isa, RISCV_ISA_EXT_MAX);
 
+	/* Setup VCPU config */
+	kvm_riscv_vcpu_config_init(vcpu);
+
 	/* Setup ISA features available to VCPU */
 	kvm_riscv_vcpu_setup_isa(vcpu);
 
@@ -530,57 +531,25 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
-	if (dbg->control & KVM_GUESTDBG_ENABLE) {
+	if (dbg->control & KVM_GUESTDBG_ENABLE)
 		vcpu->guest_debug = dbg->control;
-		vcpu->arch.cfg.hedeleg &= ~BIT(EXC_BREAKPOINT);
-	} else {
+	else
 		vcpu->guest_debug = 0;
-		vcpu->arch.cfg.hedeleg |= BIT(EXC_BREAKPOINT);
-	}
-
+	kvm_riscv_vcpu_config_guest_debug(vcpu);
 	return 0;
 }
 
-static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
-{
-	const unsigned long *isa = vcpu->arch.isa;
-	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
-
-	if (riscv_isa_extension_available(isa, SVPBMT))
-		cfg->henvcfg |= ENVCFG_PBMTE;
-
-	if (riscv_isa_extension_available(isa, SSTC))
-		cfg->henvcfg |= ENVCFG_STCE;
-
-	if (riscv_isa_extension_available(isa, ZICBOM))
-		cfg->henvcfg |= (ENVCFG_CBIE | ENVCFG_CBCFE);
-
-	if (riscv_isa_extension_available(isa, ZICBOZ))
-		cfg->henvcfg |= ENVCFG_CBZE;
-
-	if (riscv_isa_extension_available(isa, SVADU) &&
-	    !riscv_isa_extension_available(isa, SVADE))
-		cfg->henvcfg |= ENVCFG_ADUE;
-
-	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
-		cfg->hstateen0 |= SMSTATEEN0_HSENVCFG;
-		if (riscv_isa_extension_available(isa, SSAIA))
-			cfg->hstateen0 |= SMSTATEEN0_AIA_IMSIC |
-					  SMSTATEEN0_AIA |
-					  SMSTATEEN0_AIA_ISEL;
-		if (riscv_isa_extension_available(isa, SMSTATEEN))
-			cfg->hstateen0 |= SMSTATEEN0_SSTATEEN0;
-	}
-
-	if (vcpu->guest_debug)
-		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
-}
-
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	void *nsh;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
-	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	/*
+	 * Load VCPU config CSRs before other CSRs because
+	 * the read/write behaviour of certain CSRs change
+	 * based on VCPU config CSRs.
+	 */
+	kvm_riscv_vcpu_config_load(vcpu);
 
 	if (kvm_riscv_nacl_sync_csr_available()) {
 		nsh = nacl_shmem();
@@ -591,18 +560,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		nacl_csr_write(nsh, CSR_VSEPC, csr->vsepc);
 		nacl_csr_write(nsh, CSR_VSCAUSE, csr->vscause);
 		nacl_csr_write(nsh, CSR_VSTVAL, csr->vstval);
-		nacl_csr_write(nsh, CSR_HEDELEG, cfg->hedeleg);
-		nacl_csr_write(nsh, CSR_HIDELEG, cfg->hideleg);
 		nacl_csr_write(nsh, CSR_HVIP, csr->hvip);
 		nacl_csr_write(nsh, CSR_VSATP, csr->vsatp);
-		nacl_csr_write(nsh, CSR_HENVCFG, cfg->henvcfg);
-		if (IS_ENABLED(CONFIG_32BIT))
-			nacl_csr_write(nsh, CSR_HENVCFGH, cfg->henvcfg >> 32);
-		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
-			nacl_csr_write(nsh, CSR_HSTATEEN0, cfg->hstateen0);
-			if (IS_ENABLED(CONFIG_32BIT))
-				nacl_csr_write(nsh, CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
-		}
 	} else {
 		csr_write(CSR_VSSTATUS, csr->vsstatus);
 		csr_write(CSR_VSIE, csr->vsie);
@@ -611,18 +570,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		csr_write(CSR_VSEPC, csr->vsepc);
 		csr_write(CSR_VSCAUSE, csr->vscause);
 		csr_write(CSR_VSTVAL, csr->vstval);
-		csr_write(CSR_HEDELEG, cfg->hedeleg);
-		csr_write(CSR_HIDELEG, cfg->hideleg);
 		csr_write(CSR_HVIP, csr->hvip);
 		csr_write(CSR_VSATP, csr->vsatp);
-		csr_write(CSR_HENVCFG, cfg->henvcfg);
-		if (IS_ENABLED(CONFIG_32BIT))
-			csr_write(CSR_HENVCFGH, cfg->henvcfg >> 32);
-		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
-			csr_write(CSR_HSTATEEN0, cfg->hstateen0);
-			if (IS_ENABLED(CONFIG_32BIT))
-				csr_write(CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
-		}
 	}
 
 	kvm_riscv_mmu_update_hgatp(vcpu);
@@ -871,7 +820,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 
 	if (!vcpu->arch.ran_atleast_once)
-		kvm_riscv_vcpu_setup_config(vcpu);
+		kvm_riscv_vcpu_config_ran_once(vcpu);
 
 	/* Mark this VCPU ran at least once */
 	vcpu->arch.ran_atleast_once = true;
diff --git a/arch/riscv/kvm/vcpu_config.c b/arch/riscv/kvm/vcpu_config.c
new file mode 100644
index 000000000000..eb7374402b07
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_config.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_nacl.h>
+
+#define KVM_HEDELEG_DEFAULT	(BIT(EXC_INST_MISALIGNED) | \
+				 BIT(EXC_INST_ILLEGAL)     | \
+				 BIT(EXC_BREAKPOINT)      | \
+				 BIT(EXC_SYSCALL)         | \
+				 BIT(EXC_INST_PAGE_FAULT) | \
+				 BIT(EXC_LOAD_PAGE_FAULT) | \
+				 BIT(EXC_STORE_PAGE_FAULT))
+
+#define KVM_HIDELEG_DEFAULT	(BIT(IRQ_VS_SOFT)  | \
+				 BIT(IRQ_VS_TIMER) | \
+				 BIT(IRQ_VS_EXT))
+
+void kvm_riscv_vcpu_config_init(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.cfg.hedeleg = KVM_HEDELEG_DEFAULT;
+	vcpu->arch.cfg.hideleg = KVM_HIDELEG_DEFAULT;
+}
+
+void kvm_riscv_vcpu_config_guest_debug(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	if (vcpu->guest_debug)
+		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
+	else
+		cfg->hedeleg |= BIT(EXC_BREAKPOINT);
+}
+
+void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *vcpu)
+{
+	const unsigned long *isa = vcpu->arch.isa;
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	if (riscv_isa_extension_available(isa, SVPBMT))
+		cfg->henvcfg |= ENVCFG_PBMTE;
+
+	if (riscv_isa_extension_available(isa, SSTC))
+		cfg->henvcfg |= ENVCFG_STCE;
+
+	if (riscv_isa_extension_available(isa, ZICBOM))
+		cfg->henvcfg |= (ENVCFG_CBIE | ENVCFG_CBCFE);
+
+	if (riscv_isa_extension_available(isa, ZICBOZ))
+		cfg->henvcfg |= ENVCFG_CBZE;
+
+	if (riscv_isa_extension_available(isa, SVADU) &&
+	    !riscv_isa_extension_available(isa, SVADE))
+		cfg->henvcfg |= ENVCFG_ADUE;
+
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
+		cfg->hstateen0 |= SMSTATEEN0_HSENVCFG;
+		if (riscv_isa_extension_available(isa, SSAIA))
+			cfg->hstateen0 |= SMSTATEEN0_AIA_IMSIC |
+					  SMSTATEEN0_AIA |
+					  SMSTATEEN0_AIA_ISEL;
+		if (riscv_isa_extension_available(isa, SMSTATEEN))
+			cfg->hstateen0 |= SMSTATEEN0_SSTATEEN0;
+	}
+
+	if (vcpu->guest_debug)
+		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
+}
+
+void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+	void *nsh;
+
+	if (kvm_riscv_nacl_sync_csr_available()) {
+		nsh = nacl_shmem();
+		nacl_csr_write(nsh, CSR_HEDELEG, cfg->hedeleg);
+		nacl_csr_write(nsh, CSR_HIDELEG, cfg->hideleg);
+		nacl_csr_write(nsh, CSR_HENVCFG, cfg->henvcfg);
+		if (IS_ENABLED(CONFIG_32BIT))
+			nacl_csr_write(nsh, CSR_HENVCFGH, cfg->henvcfg >> 32);
+		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
+			nacl_csr_write(nsh, CSR_HSTATEEN0, cfg->hstateen0);
+			if (IS_ENABLED(CONFIG_32BIT))
+				nacl_csr_write(nsh, CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
+		}
+	} else {
+		csr_write(CSR_HEDELEG, cfg->hedeleg);
+		csr_write(CSR_HIDELEG, cfg->hideleg);
+		csr_write(CSR_HENVCFG, cfg->henvcfg);
+		if (IS_ENABLED(CONFIG_32BIT))
+			csr_write(CSR_HENVCFGH, cfg->henvcfg >> 32);
+		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
+			csr_write(CSR_HSTATEEN0, cfg->hstateen0);
+			if (IS_ENABLED(CONFIG_32BIT))
+				csr_write(CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
+		}
+	}
+}
-- 
2.43.0


