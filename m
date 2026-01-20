Return-Path: <linux-kselftest+bounces-49447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC0D3C1DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23C1D5881BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746523D6686;
	Tue, 20 Jan 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUtFqEcO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8953D667E;
	Tue, 20 Jan 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896044; cv=none; b=M6VluKq4VqNeayKFdJL5hY1Og6VF4AbEV0Uxv0SE9i6+KXauLMUmUHfj50iTwK3Q49Pw8iCs/dnksmndZ0HVXkBSWR+vrl6/WafV0VWhGhVmSxc828skjF3YJJmN1q3x8OHronqlBZ4494x0eQYtfum3/08JqXGyVyvDzlioZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896044; c=relaxed/simple;
	bh=fqLMvpaycr320AAeGJ/J0OV4bHZqYfOZJoAPY3/gb8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMPwKSmQi4HRGmnYLvDRixz9LHbYeQbPLwcyUYpk4TfTF2n1A4cJk3NQ6WY4Pb47w4M4EasO0F4tTAm1lrQVc/lZXxaJv40fqdNAaLLMEmVHOrrD7zbKyFlAmq4vqFpGOtQ0ip8cxb2EjWPUhrZhGUuWipmqJp1r+CmR+kBeoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KUtFqEcO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JMlKkR2403473;
	Tue, 20 Jan 2026 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ConoLcy9POM
	eYZTFx53Pr7VCzBa+kM0N3C9Xuif/SKY=; b=KUtFqEcOAIbyU+crYRIsl5bYH/j
	Is9PBdoWo5JzRIHJjR9SnTSwFMFwrIDgUXyAnU5z92hF69T7W7Mkfum77jojKpTR
	2KGKV2ZbXCzoexfiXP0jnXMXlru1hNnbuzLBLA+EOPKPd5jDfRgu+ae6P05akKQo
	oi1o1oUPhIw9n9ZhnoiIycWvybeS/tOSE83NrN6nzc+urW9mWUaSV6X4ntuX3rMq
	w7lbrQ/kIxqYUwx+Qovu/D/gxdiaOUP9hAgbb8nZ5A8jS3z/LQMi+E9wTn4vq94C
	q5ckvX4kAimXhsBJHz6vnU+lDSmbOYL5lFNgVrIkviCf9eKzD6Y5fl2L98A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsj9ab746-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80HnN008067;
	Tue, 20 Jan 2026 08:00:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80IcL008130;
	Tue, 20 Jan 2026 08:00:18 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80IID008129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:18 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id E1AE0255C0; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 23/27] RISC-V: KVM: Add HFENCE emulation for nested virtualization
Date: Tue, 20 Jan 2026 13:30:09 +0530
Message-ID: <20260120080013.2153519-24-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: abdmktIH441IEILu0gig6XJiDGuyYNdD
X-Authority-Analysis: v=2.4 cv=N40k1m9B c=1 sm=1 tr=0 ts=696f3616 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=L8_6NSprzQnS14VTumAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX7szEMcwbwYO0
 cYfSMap9c5kHTFs9chQxjs83caa5kiJAC86K+4W7U1QwBiWwF1ZTv4kK3mitlyIm1qIRpC7r2/B
 HPi8oeTXXzWzfJm0PFmsisQFTUljT7pYechNkYI+nnZAF70pzL+VSasM6lFc2Zqf0xGA/dwIGlv
 NP+xe/igAyvOkVFFnheQd5Z0A1LuwapddjghCU7rF1ZeAs5wA7ApZQt6Ra7F25xf828v/JTgObM
 0xCmTBwstS0n0BuNg9/hdCRcDVEIUNm1BrtkLJLT9XPVAwwfGw3mWIFBm4ekzEL5aOiWcYa1w4B
 /3BC0AFMsU/EkCJLEkKkqwjRbHIfpreZAcLwJ6xVgBtl6cLApjFV6OaIUTQcx+fM53+yCREPiek
 K/ICr4TGK0O1s8MIrcRr0cRQBp+QwMDD7MiewaWLo/3bI/YnYdg8GdC4AxH0nWkSgnOh1cFda8S
 YrHDys6rUgMgaMYfp1A==
X-Proofpoint-GUID: abdmktIH441IEILu0gig6XJiDGuyYNdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The Guest HS-mode (aka L1/guest hypervisor) needs HFENCE instructions
for TLB maintenance of the nested guest physical addresses so add
corresponding HFENCE emulation.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/insn.h            |  6 ++
 arch/riscv/include/asm/kvm_vcpu_nested.h |  4 ++
 arch/riscv/kvm/vcpu_insn.c               | 10 +++
 arch/riscv/kvm/vcpu_nested_insn.c        | 86 ++++++++++++++++++++++++
 4 files changed, 106 insertions(+)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 24a8abb3283c..6896ba0581b5 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -340,6 +340,12 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 #define INSN_MASK_WRS		0xffffffff
 #define INSN_MATCH_WRS		0x00d00073
 
+#define INSN_MASK_HFENCE_VVMA	0xfe007fff
+#define INSN_MATCH_HFENCE_VVMA	0x22000073
+
+#define INSN_MASK_HFENCE_GVMA	0xfe007fff
+#define INSN_MATCH_HFENCE_GVMA	0x62000073
+
 #define INSN_MATCH_CSRRW	0x1073
 #define INSN_MASK_CSRRW		0x707f
 #define INSN_MATCH_CSRRS	0x2073
diff --git a/arch/riscv/include/asm/kvm_vcpu_nested.h b/arch/riscv/include/asm/kvm_vcpu_nested.h
index 5262ec4f37b7..db6d89cf9771 100644
--- a/arch/riscv/include/asm/kvm_vcpu_nested.h
+++ b/arch/riscv/include/asm/kvm_vcpu_nested.h
@@ -64,6 +64,10 @@ struct kvm_vcpu_nested {
 #define kvm_riscv_vcpu_nested_virt(__vcpu) ((__vcpu)->arch.nested.virt)
 
 int kvm_riscv_vcpu_nested_insn_sret(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn);
+int kvm_riscv_vcpu_nested_insn_hfence_vvma(struct kvm_vcpu *vcpu, struct kvm_run *run,
+					   ulong insn);
+int kvm_riscv_vcpu_nested_insn_hfence_gvma(struct kvm_vcpu *vcpu, struct kvm_run *run,
+					   ulong insn);
 
 int kvm_riscv_vcpu_nested_smode_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
 					unsigned long *val, unsigned long new_val,
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 0246ca2d5e93..8f11cda133ac 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -303,6 +303,16 @@ static const struct insn_func system_opcode_funcs[] = {
 		.match = INSN_MATCH_WRS,
 		.func  = wrs_insn,
 	},
+	{
+		.mask  = INSN_MASK_HFENCE_VVMA,
+		.match = INSN_MATCH_HFENCE_VVMA,
+		.func  = kvm_riscv_vcpu_nested_insn_hfence_vvma,
+	},
+	{
+		.mask  = INSN_MASK_HFENCE_GVMA,
+		.match = INSN_MATCH_HFENCE_GVMA,
+		.func  = kvm_riscv_vcpu_nested_insn_hfence_gvma,
+	},
 };
 
 static int system_opcode_insn(struct kvm_vcpu *vcpu, struct kvm_run *run,
diff --git a/arch/riscv/kvm/vcpu_nested_insn.c b/arch/riscv/kvm/vcpu_nested_insn.c
index 8f5b2992dbb9..7e57d3215930 100644
--- a/arch/riscv/kvm/vcpu_nested_insn.c
+++ b/arch/riscv/kvm/vcpu_nested_insn.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <asm/insn.h>
 #include <asm/kvm_nacl.h>
 #include <asm/kvm_vcpu_insn.h>
 
@@ -52,3 +53,88 @@ int kvm_riscv_vcpu_nested_insn_sret(struct kvm_vcpu *vcpu, struct kvm_run *run,
 
 	return KVM_INSN_CONTINUE_SAME_SEPC;
 }
+
+int kvm_riscv_vcpu_nested_insn_hfence_vvma(struct kvm_vcpu *vcpu, struct kvm_run *run,
+					   ulong insn)
+{
+	unsigned int vmid = (vcpu->arch.nested.csr.hgatp & HGATP_VMID) >> HGATP_VMID_SHIFT;
+	unsigned long vaddr = GET_RS1(insn, &vcpu->arch.guest_context);
+	unsigned int asid = GET_RS2(insn, &vcpu->arch.guest_context);
+	unsigned int rs1_num = (insn >> SH_RS1) & MASK_RX;
+	unsigned int rs2_num = (insn >> SH_RS2) & MASK_RX;
+
+	/*
+	 * If H-extension is not available for VCPU then forward trap
+	 * as illegal instruction trap to virtual-HS mode.
+	 */
+	if (!riscv_isa_extension_available(vcpu->arch.isa, h))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	/*
+	 * Trap from virtual-VS and virtual-VU modes should be forwarded
+	 * to virtual-HS mode as a virtual instruction trap.
+	 */
+	if (kvm_riscv_vcpu_nested_virt(vcpu))
+		return KVM_INSN_VIRTUAL_TRAP;
+
+	/*
+	 * H-extension instructions not allowed in virtual-U mode so
+	 * forward trap as illegal instruction trap to virtual-HS mode.
+	 */
+	if (!(vcpu->arch.guest_context.hstatus & HSTATUS_SPVP))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	if (!rs1_num && !rs2_num)
+		kvm_riscv_vcpu_nested_swtlb_vvma_flush(vcpu, 0, 0, 0, vmid);
+	else if (!rs1_num && rs2_num)
+		kvm_riscv_vcpu_nested_swtlb_vvma_flush_asid(vcpu, 0, 0, 0, vmid, asid);
+	else if (rs1_num && !rs2_num)
+		kvm_riscv_vcpu_nested_swtlb_vvma_flush(vcpu, vaddr, PAGE_SIZE, PAGE_SHIFT, vmid);
+	else
+		kvm_riscv_vcpu_nested_swtlb_vvma_flush_asid(vcpu, vaddr, PAGE_SIZE, PAGE_SHIFT,
+							    vmid, asid);
+
+	return KVM_INSN_CONTINUE_NEXT_SEPC;
+}
+
+int kvm_riscv_vcpu_nested_insn_hfence_gvma(struct kvm_vcpu *vcpu, struct kvm_run *run,
+					   ulong insn)
+{
+	unsigned int vmid = GET_RS2(insn, &vcpu->arch.guest_context);
+	gpa_t gaddr = GET_RS1(insn, &vcpu->arch.guest_context) << 2;
+	unsigned int rs1_num = (insn >> SH_RS1) & MASK_RX;
+	unsigned int rs2_num = (insn >> SH_RS2) & MASK_RX;
+
+	/*
+	 * If H-extension is not available for VCPU then forward trap
+	 * as illegal instruction trap to virtual-HS mode.
+	 */
+	if (!riscv_isa_extension_available(vcpu->arch.isa, h))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	/*
+	 * Trap from virtual-VS and virtual-VU modes should be forwarded
+	 * to virtual-HS mode as a virtual instruction trap.
+	 */
+	if (kvm_riscv_vcpu_nested_virt(vcpu))
+		return KVM_INSN_VIRTUAL_TRAP;
+
+	/*
+	 * H-extension instructions not allowed in virtual-U mode so
+	 * forward trap as illegal instruction trap to virtual-HS mode.
+	 */
+	if (!(vcpu->arch.guest_context.hstatus & HSTATUS_SPVP))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	if (!rs1_num && !rs2_num)
+		kvm_riscv_vcpu_nested_swtlb_gvma_flush(vcpu, 0, 0, 0);
+	else if (!rs1_num && rs2_num)
+		kvm_riscv_vcpu_nested_swtlb_gvma_flush_vmid(vcpu, 0, 0, 0, vmid);
+	else if (rs1_num && !rs2_num)
+		kvm_riscv_vcpu_nested_swtlb_gvma_flush(vcpu, gaddr, PAGE_SIZE, PAGE_SHIFT);
+	else
+		kvm_riscv_vcpu_nested_swtlb_gvma_flush_vmid(vcpu, gaddr, PAGE_SIZE, PAGE_SHIFT,
+							    vmid);
+
+	return KVM_INSN_CONTINUE_NEXT_SEPC;
+}
-- 
2.43.0


