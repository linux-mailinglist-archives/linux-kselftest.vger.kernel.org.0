Return-Path: <linux-kselftest+bounces-49449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3135D3C19E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C260F467572
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40C3D7D9B;
	Tue, 20 Jan 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l7XFxBTs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B73D6694;
	Tue, 20 Jan 2026 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896045; cv=none; b=q4v9agcjxRkXEIp6Rw2Bnt9ZruMxAw+bJJCXW3R/MvyBQAdLhYkrnqOa6rVdC5QoJumIrYRJTSFOtYNYpwZW4MrNvKduJzLFw/paxfEZSxgsnZXuBy6Fh7zwNNbVO20ETbpGyNrv/6G2x/747hq1jQJknIXgYJj1HgF3P0LQypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896045; c=relaxed/simple;
	bh=VgH5a43SMvQV3lMV6vB4kgt0xSUDF1qkB+VL5phpLos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7t7YX4tJTPAyXj2wgwllnOWsiDlugAMaZ/5L1ZktG0+zNx5reFvW5sGdRnmlPq/093PZkVFnz+VkU0zHqHDHbUxUGW44/L6yhbi1nlsQ4yuIkNKukoTb4OXHcF7J/JBa8qiKYsdHLsge7jqkSEbgE4ZvIf5igdJPChg2VGU6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l7XFxBTs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K71Z4u1408482;
	Tue, 20 Jan 2026 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R8FQczWtBUy
	5v1pZmDCxmjtbD0OvwMcba0xNdmFzHV4=; b=l7XFxBTsa+3WWzGbTlDuezdZYdf
	+gkxX6/VKNoaPK9SSVYNOtDKAG0Hv/guXZdg5Z6g+8TZjcaku72Z0+qeANdh0TtE
	4dbEKUWtcTao9t/7mxWyDg5WhtXtxcF5yF2Q87XszKqpjJTX6L+Nkh6eikLgWCR1
	i5KBAdUQNYJQ04ibNByoPHAm9qV/e+SUrpo8Y1HBXInzyA1XIYnARClX5DJXLHjd
	9RlU2z+WzKXG+b2SbIX7suUjoVWNOokHIVNJxEJB2Z8r4vWPHpoXja5/CnnirzO8
	FOm1Dv7kaektgbXR4eLXjH8LblC5IrbeHjfdVlqED6HSZDCY1U8lCwrSPxg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4y2r5a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80G0a007954;
	Tue, 20 Jan 2026 08:00:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80FZe007832;
	Tue, 20 Jan 2026 08:00:18 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80H7Z008013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:18 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id CFCAE25597; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 18/27] RISC-V: KVM: Trap-n-emulate SRET for Guest HS-mode
Date: Tue, 20 Jan 2026 13:30:04 +0530
Message-ID: <20260120080013.2153519-19-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfXyK6u780okVE7
 aLxDXZePncjbDgTdiv1jihYvHt/Cepr1RqJtMijVZy8Hzti3/8FRj8eTP6YQ7GaahSRPNyJixsE
 ++hXGY36MfXLqYBnOuX5PpjOCyIGOk4Vlwm2VIbrXxmIcVCRhcx0v2f1k/8HS/4/I9fizs8DlCR
 5krU6RIEaPMZ4DJlUCqnXdLgOeiqygweLGoz+FHJf98JvuusJpIY67n5v1qka2nX3+6j0Ndxnj9
 8QpUD/ky6yYPNNW7wrRd0vv3ObdMthgLDPgT+0V5eSywIFpHUJei8XNxQc9MF1VcZh6VwAFrfKF
 ymiiLNvh2tYJokhVb6MYMTVl4/PsHna2VKcQU2dKmHwf4YwyLGEngAsGNVFQT3rV9vyUVC9ia9i
 cUPCQ+Zamskj0qT7PstAk0cZg9hD5m3A407TCuJE2B9QseBydRT8HDMyTlRDJZ76WcI9Zpls8eG
 a4udiD1+6exiyXmBDxQ==
X-Authority-Analysis: v=2.4 cv=Ds1bOW/+ c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=geURt3utUUeLdx-e4vsA:9
X-Proofpoint-GUID: 6T3tHglOs3WQkVdbI-7TE9YEkgg7akAs
X-Proofpoint-ORIG-GUID: 6T3tHglOs3WQkVdbI-7TE9YEkgg7akAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

The guest HS-mode (aka L1/guest hypervisor) can enter Guest VS/VU-mode
(aka L2/nested guest) using the SRET instruction. To achieve this, host
host hypervisor must trap-n-emulate SRET instruction for guest HS-mode
(aka L1/guest hypervisor) using host hstatus.VTSR bit.

Trapping all SRET instructions executed by guest HS-mode (aka L1/guest
hypervisor) will impact performance so host hypervisor will only set
hstatus.VTSR bit when guest sets HSTATUS.SPV bit and hstatus.VTSR bit
is cleared by SRET emulation upon entry into guest VS/VU-mode.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/insn.h            |  3 ++
 arch/riscv/include/asm/kvm_vcpu_nested.h |  2 +
 arch/riscv/kvm/Makefile                  |  1 +
 arch/riscv/kvm/vcpu_insn.c               |  6 +++
 arch/riscv/kvm/vcpu_nested_insn.c        | 54 ++++++++++++++++++++++++
 5 files changed, 66 insertions(+)
 create mode 100644 arch/riscv/kvm/vcpu_nested_insn.c

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index c3005573e8c9..24a8abb3283c 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -331,6 +331,9 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 #define INSN_OPCODE_SHIFT	2
 #define INSN_OPCODE_SYSTEM	28
 
+#define INSN_MASK_SRET		0xffffffff
+#define INSN_MATCH_SRET		0x10200073
+
 #define INSN_MASK_WFI		0xffffffff
 #define INSN_MATCH_WFI		0x10500073
 
diff --git a/arch/riscv/include/asm/kvm_vcpu_nested.h b/arch/riscv/include/asm/kvm_vcpu_nested.h
index 6d9d252a378c..665c60f09ee6 100644
--- a/arch/riscv/include/asm/kvm_vcpu_nested.h
+++ b/arch/riscv/include/asm/kvm_vcpu_nested.h
@@ -63,6 +63,8 @@ struct kvm_vcpu_nested {
 
 #define kvm_riscv_vcpu_nested_virt(__vcpu) ((__vcpu)->arch.nested.virt)
 
+int kvm_riscv_vcpu_nested_insn_sret(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn);
+
 int kvm_riscv_vcpu_nested_swtlb_xlate(struct kvm_vcpu *vcpu,
 				      const struct kvm_cpu_trap *trap,
 				      struct kvm_gstage_mapping *out_map,
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index a8806b69205f..c0534d4a469e 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -26,6 +26,7 @@ kvm-y += vcpu_exit.o
 kvm-y += vcpu_fp.o
 kvm-y += vcpu_insn.o
 kvm-y += vcpu_nested.o
+kvm-y += vcpu_nested_insn.o
 kvm-y += vcpu_nested_swtlb.o
 kvm-y += vcpu_onereg.o
 kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 4d89b94128ae..745cd654df94 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -9,6 +9,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
+#include <asm/kvm_vcpu_nested.h>
 
 struct insn_func {
 	unsigned long mask;
@@ -257,6 +258,11 @@ static const struct insn_func system_opcode_funcs[] = {
 		.match = INSN_MATCH_CSRRCI,
 		.func  = csr_insn,
 	},
+	{
+		.mask  = INSN_MASK_SRET,
+		.match = INSN_MATCH_SRET,
+		.func  = kvm_riscv_vcpu_nested_insn_sret,
+	},
 	{
 		.mask  = INSN_MASK_WFI,
 		.match = INSN_MATCH_WFI,
diff --git a/arch/riscv/kvm/vcpu_nested_insn.c b/arch/riscv/kvm/vcpu_nested_insn.c
new file mode 100644
index 000000000000..8f5b2992dbb9
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_nested_insn.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_nacl.h>
+#include <asm/kvm_vcpu_insn.h>
+
+int kvm_riscv_vcpu_nested_insn_sret(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
+{
+	unsigned long vsstatus, next_sepc, next_spp;
+	bool next_virt;
+
+	/*
+	 * Trap from virtual-VS/VU modes should be forwarded to
+	 * virtual-HS mode as a virtual instruction trap.
+	 */
+	if (kvm_riscv_vcpu_nested_virt(vcpu))
+		return KVM_INSN_VIRTUAL_TRAP;
+
+	/*
+	 * Trap from virtual-U mode should be forwarded to
+	 * virtual-HS mode as illegal instruction trap.
+	 */
+	if (!(vcpu->arch.guest_context.hstatus & HSTATUS_SPVP))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	vsstatus = ncsr_read(CSR_VSSTATUS);
+
+	/*
+	 * Find next nested virtualization mode, next privilege mode,
+	 * and next sepc
+	 */
+	next_virt = (vcpu->arch.nested.csr.hstatus & HSTATUS_SPV) ? true : false;
+	next_sepc = ncsr_read(CSR_VSEPC);
+	next_spp = vsstatus & SR_SPP;
+
+	/* Update Guest sstatus.sie */
+	vsstatus &= ~SR_SIE;
+	vsstatus |= (vsstatus & SR_SPIE) ? SR_SIE : 0;
+	ncsr_write(CSR_VSSTATUS, vsstatus);
+
+	/* Update return address and return privilege mode*/
+	vcpu->arch.guest_context.sepc = next_sepc;
+	vcpu->arch.guest_context.sstatus &= ~SR_SPP;
+	vcpu->arch.guest_context.sstatus |= next_spp;
+
+	/* Set nested virtualization state based on guest hstatus.SPV */
+	kvm_riscv_vcpu_nested_set_virt(vcpu, NESTED_SET_VIRT_EVENT_SRET,
+				       next_virt, false, false);
+
+	return KVM_INSN_CONTINUE_SAME_SEPC;
+}
-- 
2.43.0


