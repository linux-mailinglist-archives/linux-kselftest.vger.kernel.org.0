Return-Path: <linux-kselftest+bounces-49450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 123B4D3C204
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C558588BD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886A3DA7D3;
	Tue, 20 Jan 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4JhbWtF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E83D668A;
	Tue, 20 Jan 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896045; cv=none; b=bwC9qo7mnNmJeECU5YaFB20/nLb73ZI90qALEn378ZLdQNIDuIV5qUoJ6c8oReX6KKOXF0RAWyPqY8/rVdfaUikqZCnEabsMytb4sXx0FC1cwmZaIwJ3IFgWUYWyxBzUqZb9b8k6NZPcXsHAb+BJJCvi6FFCb8RDJEINDO9XEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896045; c=relaxed/simple;
	bh=uNSPbnEf33sR7ihnB4jeFzLlWXz9LTlnI30oZddGjDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8WTKalwrA47+WgNU9R9HEh62d/L4CTzslytxvdhLAredQcjRML4Dsq4eVe1R72BdLiEp3amorpxssRyu+gD3uvLW8t4XMmCNMW07q0HJGgMVsCqxtxUBFelT8+LxGCXHOjAmhYW4vyXvWObwSDFn5pftwpE2voPnUpyw8V8ZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4JhbWtF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K17xuk3365643;
	Tue, 20 Jan 2026 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rcsDzpMo0Th
	b56cqXKbD+YTojQBIHFq9n8MgkUX7bqw=; b=Z4JhbWtFZiS4lOY+tiq4hFYAbh3
	WTREaoof70npYTckaC67q8jwUavnZwMZ16ZCWFSmnR+nSO1rLEwPCpcetMoIwR4U
	G5xsyHCpBH7Ef2RW8CWyR+4zeS7SVj+/XzXpoTDY7PSxg0F+T8a1jDQixiQk96Ph
	Hx6fX6vToQpTGpXLU3VVrjfsBQ2hNvCW10JLUv+0dMdxoPXGp1xECptz9/N6MERX
	G0+CUNk9NEYKqIuPbP3a+VimvSmZm9s9BYYJAZFGrAYEoZ8S6g1GYdl5iJeUtEXp
	P7ckaY+MLLVkQmShVxtN+RSSrl8XRbT24pU4HZXDUIMSEx88Yx6X+G/CIWw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsysb11kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Faw007861;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80HCr008032;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80HNL008011
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id DDEFA255BF; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 22/27] RISC-V: KVM: Add CSR emulation for nested virtualization
Date: Tue, 20 Jan 2026 13:30:08 +0530
Message-ID: <20260120080013.2153519-23-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-GUID: KnUPrRoIuk3XdF44qv9HxwbtwpD7ZMCV
X-Authority-Analysis: v=2.4 cv=XJ89iAhE c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=cExkyNWOVb-4EhKGL30A:9
X-Proofpoint-ORIG-GUID: KnUPrRoIuk3XdF44qv9HxwbtwpD7ZMCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX933scbiWUobF
 NBGt7U+OgRcqMNS2Xd76HoqteKnH+h1+YBADMKa+zx07Yl8XGPrhKMDnv97hCUm9muGPVVloDFK
 IYfygMHr/1bEyyQlnFBYEZIhGdEA5cfMDubkzjTzVNxnQXB9sDEE+ttlg++G3Frmo8xruuVw27h
 N6MaY1SgZ0FmE0Ia8MigkFDBOtEntEMsHAX6A0XjTWoh/EacPIipgA1U2GXFSBpKD8nl8i3Yhxh
 dFfl1BeVg9M676yRggvU53nz6kI6+4tIa60bYYZyQU/o7VY4uH+Zd4zFNKbx9wXuJThig7y/vvB
 0yg+h8B7k/ifKvGsHACJVObf3nG6b1JmgeHlddLcJsCEQGV690HM7zRvbMvyWVLxio66iCG0RLX
 JnyLA/wZirq1eLlNWvSza6L1mgWtHNltweHuPl8KfUdhTIJWlfEjq3mCkUNjDhwBY0K+yVb6vfe
 vEQi/3fxVDFfncy0f7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The Guest HS-mode (aka L1/guest hypervisor) needs H-extension CSRs
for hypervisor functionality so add corresponding CSR emulation.

Both, Guest HS-mode (aka L1/guest hypervisor) and Guest VS-mode (aka
L2/nested guest) will be running in actual VS-mode which complicates
receiving Guest HS-mode interrupts while Guest VS-mode is running.
To simplify this, trap-n-emulate SIE and SIP CSRs for Guest VS-mode
(aka L2/nested guest) using hvictl.VTI bit.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/csr.h             |  17 ++
 arch/riscv/include/asm/kvm_vcpu_nested.h |  42 +++
 arch/riscv/kvm/Makefile                  |   1 +
 arch/riscv/kvm/vcpu_insn.c               |   2 +
 arch/riscv/kvm/vcpu_nested.c             |   3 +-
 arch/riscv/kvm/vcpu_nested_csr.c         | 361 +++++++++++++++++++++++
 6 files changed, 424 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/kvm/vcpu_nested_csr.c

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 4a37a98398ad..7fba082d4a26 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -17,6 +17,7 @@
 #define SR_SPP		_AC(0x00000100, UL) /* Previously Supervisor */
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
+#define SR_MXR		_AC(0x00080000, UL) /* Make eXecutable Readable */
 
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
@@ -59,6 +60,7 @@
 /* SATP flags */
 #ifndef CONFIG_64BIT
 #define SATP_PPN	_AC(0x003FFFFF, UL)
+#define SATP_MODE	_AC(0x80000000, UL)
 #define SATP_MODE_32	_AC(0x80000000, UL)
 #define SATP_MODE_SHIFT	31
 #define SATP_ASID_BITS	9
@@ -66,6 +68,7 @@
 #define SATP_ASID_MASK	_AC(0x1FF, UL)
 #else
 #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
+#define SATP_MODE	_AC(0xF000000000000000, UL)
 #define SATP_MODE_39	_AC(0x8000000000000000, UL)
 #define SATP_MODE_48	_AC(0x9000000000000000, UL)
 #define SATP_MODE_57	_AC(0xa000000000000000, UL)
@@ -74,6 +77,8 @@
 #define SATP_ASID_SHIFT	44
 #define SATP_ASID_MASK	_AC(0xFFFF, UL)
 #endif
+#define SATP_MODE_OFF	_AC(0, UL)
+#define SATP_ASID	(SATP_ASID_MASK << SATP_ASID_SHIFT)
 
 /* Exception cause high bit - is an interrupt if set */
 #define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
@@ -151,11 +156,13 @@
 #define HGATP_MODE_SV57X4	_AC(10, UL)
 
 #define HGATP32_MODE_SHIFT	31
+#define HGATP32_MODE		GENMASK(31, 31)
 #define HGATP32_VMID_SHIFT	22
 #define HGATP32_VMID		GENMASK(28, 22)
 #define HGATP32_PPN		GENMASK(21, 0)
 
 #define HGATP64_MODE_SHIFT	60
+#define HGATP64_MODE		GENMASK(63, 60)
 #define HGATP64_VMID_SHIFT	44
 #define HGATP64_VMID		GENMASK(57, 44)
 #define HGATP64_PPN		GENMASK(43, 0)
@@ -167,11 +174,13 @@
 #define HGATP_VMID_SHIFT	HGATP64_VMID_SHIFT
 #define HGATP_VMID		HGATP64_VMID
 #define HGATP_MODE_SHIFT	HGATP64_MODE_SHIFT
+#define HGATP_MODE		HGATP64_MODE
 #else
 #define HGATP_PPN		HGATP32_PPN
 #define HGATP_VMID_SHIFT	HGATP32_VMID_SHIFT
 #define HGATP_VMID		HGATP32_VMID
 #define HGATP_MODE_SHIFT	HGATP32_MODE_SHIFT
+#define HGATP_MODE		HGATP32_MODE
 #endif
 
 /* VSIP & HVIP relation */
@@ -237,6 +246,14 @@
 #define MSECCFG_PMM_PMLEN_7		ENVCFG_PMM_PMLEN_7
 #define MSECCFG_PMM_PMLEN_16		ENVCFG_PMM_PMLEN_16
 
+#define CSR_NUM_PRIV_SHIFT	8
+#define CSR_NUM_PRIV_MASK	0x3
+
+#define CSR_PRIV_USER		0
+#define CSR_PRIV_SUPERVISOR	1
+#define CSR_PRIV_HYPERVISOR	2
+#define CSR_PRIV_MACHINE	3
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
diff --git a/arch/riscv/include/asm/kvm_vcpu_nested.h b/arch/riscv/include/asm/kvm_vcpu_nested.h
index 4935ab0db1a2..5262ec4f37b7 100644
--- a/arch/riscv/include/asm/kvm_vcpu_nested.h
+++ b/arch/riscv/include/asm/kvm_vcpu_nested.h
@@ -65,6 +65,48 @@ struct kvm_vcpu_nested {
 
 int kvm_riscv_vcpu_nested_insn_sret(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn);
 
+int kvm_riscv_vcpu_nested_smode_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
+					unsigned long *val, unsigned long new_val,
+					unsigned long wr_mask);
+int kvm_riscv_vcpu_nested_hext_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
+				       unsigned long *val, unsigned long new_val,
+				       unsigned long wr_mask);
+
+#define KVM_RISCV_VCPU_NESTED_SMODE_CSR_FUNCS \
+{ .base = CSR_SIE,      .count = 1, .func = kvm_riscv_vcpu_nested_smode_csr_rmw }, \
+{ .base = CSR_SIEH,     .count = 1, .func = kvm_riscv_vcpu_nested_smode_csr_rmw }, \
+{ .base = CSR_SIP,      .count = 1, .func = kvm_riscv_vcpu_nested_smode_csr_rmw }, \
+{ .base = CSR_SIPH,     .count = 1, .func = kvm_riscv_vcpu_nested_smode_csr_rmw },
+
+#define KVM_RISCV_VCPU_NESTED_HEXT_CSR_FUNCS \
+{ .base = CSR_HSTATUS,  .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HEDELEG,  .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HIDELEG,  .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HIE,      .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HTIMEDELTA, .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HCOUNTEREN, .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HGEIE,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HENVCFG,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HTIMEDELTAH,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HENVCFGH,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HTVAL,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HIP,      .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HVIP,     .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HTINST,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HGATP,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_HGEIP,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSSTATUS,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSIE,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSTVEC,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSSCRATCH,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSEPC,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSCAUSE,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSTVAL,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSIP,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw }, \
+{ .base = CSR_VSATP,    .count = 1, .func = kvm_riscv_vcpu_nested_hext_csr_rmw },
+
+void kvm_riscv_vcpu_nested_csr_reset(struct kvm_vcpu *vcpu);
+
 int kvm_riscv_vcpu_nested_swtlb_xlate(struct kvm_vcpu *vcpu,
 				      const struct kvm_cpu_trap *trap,
 				      struct kvm_gstage_mapping *out_map,
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index c0534d4a469e..40f385f229f4 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -26,6 +26,7 @@ kvm-y += vcpu_exit.o
 kvm-y += vcpu_fp.o
 kvm-y += vcpu_insn.o
 kvm-y += vcpu_nested.o
+kvm-y += vcpu_nested_csr.o
 kvm-y += vcpu_nested_insn.o
 kvm-y += vcpu_nested_swtlb.o
 kvm-y += vcpu_onereg.o
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index ebd0cfc1bf30..0246ca2d5e93 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -142,6 +142,8 @@ static const struct csr_func csr_funcs[] = {
 	KVM_RISCV_VCPU_AIA_CSR_FUNCS
 	KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
 	{ .base = CSR_SEED, .count = 1, .func = seed_csr_rmw },
+	KVM_RISCV_VCPU_NESTED_SMODE_CSR_FUNCS
+	KVM_RISCV_VCPU_NESTED_HEXT_CSR_FUNCS
 };
 
 /**
diff --git a/arch/riscv/kvm/vcpu_nested.c b/arch/riscv/kvm/vcpu_nested.c
index 9b2b3369a232..1b4898d9c72c 100644
--- a/arch/riscv/kvm/vcpu_nested.c
+++ b/arch/riscv/kvm/vcpu_nested.c
@@ -224,11 +224,10 @@ void kvm_riscv_vcpu_nested_vsirq_process(struct kvm_vcpu *vcpu)
 void kvm_riscv_vcpu_nested_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
-	struct kvm_vcpu_nested_csr *ncsr = &vcpu->arch.nested.csr;
 
 	ns->virt = false;
 	kvm_riscv_vcpu_nested_swtlb_reset(vcpu);
-	memset(ncsr, 0, sizeof(*ncsr));
+	kvm_riscv_vcpu_nested_csr_reset(vcpu);
 }
 
 int kvm_riscv_vcpu_nested_init(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_nested_csr.c b/arch/riscv/kvm/vcpu_nested_csr.c
new file mode 100644
index 000000000000..0e427f224954
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_nested_csr.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/pgtable.h>
+#include <asm/csr.h>
+
+#define NESTED_SIE_WRITEABLE		(BIT(IRQ_S_SOFT) | BIT(IRQ_S_TIMER) | BIT(IRQ_S_EXT))
+#define NESTED_HVIP_WRITEABLE		(BIT(IRQ_VS_SOFT) | BIT(IRQ_VS_TIMER) | BIT(IRQ_VS_EXT))
+#define NESTED_HIDELEG_WRITEABLE	NESTED_HVIP_WRITEABLE
+#define NESTED_HEDELEG_WRITEABLE	\
+	(BIT(EXC_INST_MISALIGNED) |	\
+	 BIT(EXC_INST_ACCESS) |		\
+	 BIT(EXC_INST_ILLEGAL) |	\
+	 BIT(EXC_BREAKPOINT) |		\
+	 BIT(EXC_LOAD_MISALIGNED) |	\
+	 BIT(EXC_LOAD_ACCESS) |		\
+	 BIT(EXC_STORE_MISALIGNED) |	\
+	 BIT(EXC_STORE_ACCESS) |	\
+	 BIT(EXC_SYSCALL) |		\
+	 BIT(EXC_INST_PAGE_FAULT) |	\
+	 BIT(EXC_LOAD_PAGE_FAULT) |	\
+	 BIT(EXC_STORE_PAGE_FAULT))
+#define NESTED_HCOUNTEREN_WRITEABLE	-1UL
+#define NESTED_VSIE_WRITEABLE		NESTED_SIE_WRITEABLE
+#define NESTED_VSCAUSE_WRITEABLE	GENMASK(4, 0)
+
+int kvm_riscv_vcpu_nested_smode_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
+					unsigned long *val, unsigned long new_val,
+					unsigned long wr_mask)
+{
+	struct kvm_vcpu_nested_csr *nsc = &vcpu->arch.nested.csr;
+	unsigned long *csr, csr_rdor = 0;
+	unsigned long writeable_mask = 0;
+#ifdef CONFIG_32BIT
+	unsigned long zero = 0;
+#endif
+	int csr_shift = 0;
+
+	/*
+	 * These CSRs should never trap for virtual-HS/U modes because
+	 * we only emulate these CSRs for virtual-VS/VU modes.
+	 */
+	if (!kvm_riscv_vcpu_nested_virt(vcpu))
+		return -EINVAL;
+
+	/*
+	 * Access of these CSRs from virtual-VU mode should be forwarded
+	 * as illegal instruction trap to virtual-HS mode.
+	 */
+	if (!(vcpu->arch.guest_context.hstatus & HSTATUS_SPVP))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	switch (csr_num) {
+	case CSR_SIE:
+		csr = &nsc->vsie;
+		writeable_mask = NESTED_SIE_WRITEABLE & (nsc->hideleg >> VSIP_TO_HVIP_SHIFT);
+		break;
+#ifdef CONFIG_32BIT
+	case CSR_SIEH:
+		csr = &zero;
+		break;
+#endif
+	case CSR_SIP:
+		csr = &nsc->hvip;
+		csr_shift = VSIP_TO_HVIP_SHIFT;
+		writeable_mask = BIT(IRQ_VS_EXT) & nsc->hideleg;
+		break;
+#ifdef CONFIG_32BIT
+	case CSR_SIPH:
+		csr = &zero;
+		break;
+#endif
+	default:
+		return KVM_INSN_ILLEGAL_TRAP;
+	}
+
+	if (val)
+		*val = (csr_shift < 0) ? (*csr | csr_rdor) << -csr_shift :
+					 (*csr | csr_rdor) >> csr_shift;
+
+	if (wr_mask) {
+		writeable_mask = (csr_shift < 0) ?
+				  writeable_mask >> -csr_shift :
+				  writeable_mask << csr_shift;
+		wr_mask = (csr_shift < 0) ?
+			   wr_mask >> -csr_shift : wr_mask << csr_shift;
+		new_val = (csr_shift < 0) ?
+			   new_val >> -csr_shift : new_val << csr_shift;
+		wr_mask &= writeable_mask;
+		*csr = (*csr & ~wr_mask) | (new_val & wr_mask);
+	}
+
+	return KVM_INSN_CONTINUE_NEXT_SEPC;
+}
+
+static int __riscv_vcpu_nested_hext_csr_rmw(struct kvm_vcpu *vcpu,
+					    bool priv_check, unsigned int csr_num,
+					    unsigned long *val, unsigned long new_val,
+					    unsigned long wr_mask)
+{
+	unsigned int csr_priv = (csr_num >> CSR_NUM_PRIV_SHIFT) & CSR_NUM_PRIV_MASK;
+	struct kvm_vcpu_nested_csr *nsc = &vcpu->arch.nested.csr;
+	unsigned long mode, zero = 0, writeable_mask = 0;
+	bool read_only = false, nuke_swtlb = false;
+	unsigned long *csr, csr_rdor = 0;
+	int csr_shift = 0;
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
+	if (priv_check && kvm_riscv_vcpu_nested_virt(vcpu))
+		return (csr_priv == CSR_PRIV_HYPERVISOR) ?
+			KVM_INSN_VIRTUAL_TRAP : KVM_INSN_ILLEGAL_TRAP;
+
+	/*
+	 * H-extension CSRs not allowed in virtual-U mode so forward trap
+	 * as illegal instruction trap to virtual-HS mode.
+	 */
+	if (priv_check && !(vcpu->arch.guest_context.hstatus & HSTATUS_SPVP))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	switch (csr_num) {
+	case CSR_HSTATUS:
+		csr = &nsc->hstatus;
+		writeable_mask = HSTATUS_VTSR | HSTATUS_VTW | HSTATUS_VTVM |
+				 HSTATUS_HU | HSTATUS_SPVP | HSTATUS_SPV |
+				 HSTATUS_GVA;
+		if (wr_mask & HSTATUS_SPV) {
+			/*
+			 * If hstatus.SPV == 1 then enable host SRET
+			 * trapping for the virtual-HS mode which will
+			 * allow host to do nested world-switch upon
+			 * next SRET instruction executed by the
+			 * virtual-HS-mode.
+			 *
+			 * If hstatus.SPV == 0 then disable host SRET
+			 * trapping for the virtual-HS mode which will
+			 * ensure that host does not do any nested
+			 * world-switch for SRET instruction executed
+			 * virtual-HS mode for general interrupt and
+			 * trap handling.
+			 */
+			vcpu->arch.guest_context.hstatus &= ~HSTATUS_VTSR;
+			vcpu->arch.guest_context.hstatus |= (new_val & HSTATUS_SPV) ?
+							    HSTATUS_VTSR : 0;
+		}
+		break;
+	case CSR_HEDELEG:
+		csr = &nsc->hedeleg;
+		writeable_mask = NESTED_HEDELEG_WRITEABLE;
+		break;
+	case CSR_HIDELEG:
+		csr = &nsc->hideleg;
+		writeable_mask = NESTED_HIDELEG_WRITEABLE;
+		break;
+	case CSR_HVIP:
+		csr = &nsc->hvip;
+		writeable_mask = NESTED_HVIP_WRITEABLE;
+		break;
+	case CSR_HIE:
+		csr = &nsc->vsie;
+		csr_shift = -VSIP_TO_HVIP_SHIFT;
+		writeable_mask = NESTED_HVIP_WRITEABLE;
+		break;
+	case CSR_HIP:
+		csr = &nsc->hvip;
+		writeable_mask = BIT(IRQ_VS_SOFT);
+		break;
+	case CSR_HGEIP:
+		csr = &zero;
+		read_only = true;
+		break;
+	case CSR_HGEIE:
+		csr = &zero;
+		break;
+	case CSR_HCOUNTEREN:
+		csr = &nsc->hcounteren;
+		writeable_mask = NESTED_HCOUNTEREN_WRITEABLE;
+		break;
+	case CSR_HTIMEDELTA:
+		csr = &nsc->htimedelta;
+		writeable_mask = -1UL;
+		break;
+#ifndef CONFIG_64BIT
+	case CSR_HTIMEDELTAH:
+		csr = &nsc->htimedeltah;
+		writeable_mask = -1UL;
+		break;
+#endif
+	case CSR_HTVAL:
+		csr = &nsc->htval;
+		writeable_mask = -1UL;
+		break;
+	case CSR_HTINST:
+		csr = &nsc->htinst;
+		writeable_mask = -1UL;
+		break;
+	case CSR_HGATP:
+		csr = &nsc->hgatp;
+		writeable_mask = HGATP_MODE | HGATP_VMID | HGATP_PPN;
+		if (wr_mask & HGATP_MODE) {
+			mode = (new_val & HGATP_MODE) >> HGATP_MODE_SHIFT;
+			switch (mode) {
+			/*
+			 * Intentionally support only Sv39x4 on RV64 and
+			 * Sv32x4 on RV32 for guest G-stage so that software
+			 * page table walks on guest G-stage are faster.
+			 */
+#ifdef CONFIG_64BIT
+			case HGATP_MODE_SV39X4:
+				if (kvm_riscv_gstage_mode != HGATP_MODE_SV57X4 &&
+				    kvm_riscv_gstage_mode != HGATP_MODE_SV48X4 &&
+				    kvm_riscv_gstage_mode != HGATP_MODE_SV39X4)
+					mode = HGATP_MODE_OFF;
+				break;
+#else
+			case HGATP_MODE_SV32X4:
+				if (kvm_riscv_gstage_mode != HGATP_MODE_SV32X4)
+					mode = HGATP_MODE_OFF;
+				break;
+#endif
+			default:
+				mode = HGATP_MODE_OFF;
+				break;
+			}
+			new_val &= ~HGATP_MODE;
+			new_val |= (mode << HGATP_MODE_SHIFT) & HGATP_MODE;
+			if ((new_val ^ nsc->hgatp) & HGATP_MODE)
+				nuke_swtlb = true;
+		}
+		if (wr_mask & HGATP_VMID) {
+			if ((new_val ^ nsc->hgatp) & HGATP_VMID)
+				nuke_swtlb = true;
+		}
+		break;
+	case CSR_HENVCFG:
+		csr = &nsc->henvcfg;
+#ifdef CONFIG_64BIT
+		writeable_mask = ENVCFG_STCE;
+#endif
+		break;
+#ifdef CONFIG_32BIT
+	case CSR_HENVCFGH:
+		csr = &nsc->henvcfgh;
+		writeable_mask = ENVCFG_STCE >> 32;
+		break;
+#endif
+	case CSR_VSSTATUS:
+		csr = &nsc->vsstatus;
+		writeable_mask = SR_SIE | SR_SPIE | SR_SPP | SR_SUM | SR_MXR | SR_FS | SR_VS;
+		break;
+	case CSR_VSIP:
+		csr = &nsc->hvip;
+		csr_shift = VSIP_TO_HVIP_SHIFT;
+		writeable_mask = BIT(IRQ_VS_SOFT) & nsc->hideleg;
+		break;
+	case CSR_VSIE:
+		csr = &nsc->vsie;
+		writeable_mask = NESTED_VSIE_WRITEABLE & (nsc->hideleg >> VSIP_TO_HVIP_SHIFT);
+		break;
+	case CSR_VSTVEC:
+		csr = &nsc->vstvec;
+		writeable_mask = -1UL;
+		break;
+	case CSR_VSSCRATCH:
+		csr = &nsc->vsscratch;
+		writeable_mask = -1UL;
+		break;
+	case CSR_VSEPC:
+		csr = &nsc->vsepc;
+		writeable_mask = -1UL;
+		break;
+	case CSR_VSCAUSE:
+		csr = &nsc->vscause;
+		writeable_mask = NESTED_VSCAUSE_WRITEABLE;
+		break;
+	case CSR_VSTVAL:
+		csr = &nsc->vstval;
+		writeable_mask = -1UL;
+		break;
+	case CSR_VSATP:
+		csr = &nsc->vsatp;
+		writeable_mask = SATP_MODE | SATP_ASID | SATP_PPN;
+		if (wr_mask & SATP_MODE) {
+			mode = new_val & SATP_MODE;
+			switch (mode) {
+#ifdef CONFIG_64BIT
+			case SATP_MODE_57:
+				if (!pgtable_l5_enabled)
+					mode = SATP_MODE_OFF;
+				break;
+			case SATP_MODE_48:
+				if (!pgtable_l5_enabled && !pgtable_l4_enabled)
+					mode = SATP_MODE_OFF;
+				break;
+			case SATP_MODE_39:
+				break;
+#else
+			case SATP_MODE_32:
+				break;
+#endif
+			default:
+				mode = SATP_MODE_OFF;
+				break;
+			}
+			new_val &= ~SATP_MODE;
+			new_val |= mode & SATP_MODE;
+		}
+		break;
+	default:
+		return KVM_INSN_ILLEGAL_TRAP;
+	}
+
+	if (val)
+		*val = (csr_shift < 0) ? (*csr | csr_rdor) << -csr_shift :
+					 (*csr | csr_rdor) >> csr_shift;
+
+	if (read_only) {
+		return KVM_INSN_ILLEGAL_TRAP;
+	} else if (wr_mask) {
+		writeable_mask = (csr_shift < 0) ?
+				  writeable_mask >> -csr_shift :
+				  writeable_mask << csr_shift;
+		wr_mask = (csr_shift < 0) ?
+			   wr_mask >> -csr_shift : wr_mask << csr_shift;
+		new_val = (csr_shift < 0) ?
+			   new_val >> -csr_shift : new_val << csr_shift;
+		wr_mask &= writeable_mask;
+		*csr = (*csr & ~wr_mask) | (new_val & wr_mask);
+	}
+
+	if (nuke_swtlb)
+		kvm_riscv_vcpu_nested_swtlb_gvma_flush(vcpu, 0, 0, 0);
+
+	return KVM_INSN_CONTINUE_NEXT_SEPC;
+}
+
+int kvm_riscv_vcpu_nested_hext_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
+				       unsigned long *val, unsigned long new_val,
+				       unsigned long wr_mask)
+{
+	return __riscv_vcpu_nested_hext_csr_rmw(vcpu, true, csr_num, val, new_val, wr_mask);
+}
+
+void kvm_riscv_vcpu_nested_csr_reset(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_nested_csr *nsc = &vcpu->arch.nested.csr;
+
+	memset(nsc, 0, sizeof(*nsc));
+}
-- 
2.43.0


