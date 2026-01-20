Return-Path: <linux-kselftest+bounces-49448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99749D3C1A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8190F409817
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5E3D7D8D;
	Tue, 20 Jan 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="os9+6AD8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A13D668B;
	Tue, 20 Jan 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896045; cv=none; b=Zuy0Y0MoIvLaKtpoMfcu+DCfK+nyt1pMf9nYUx6x/kN8q5bLL9Z2wQAnaw79VO9dLw/tbcsZL4ObH6yiUFK7nEfpDFb5yz2MXX59eFlol/bMF6jN07XN0KeCfsa6dFKl/fTqwhWrAskOEStqeEypZwfHj2/2JknhR71hkBZWqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896045; c=relaxed/simple;
	bh=JJwVSFTAYXKv6TxqTfWoyd66les6J9Xz9kau0yOaAZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrrvnosOo/WdYCgzoWLvfBnAcktowpkYJzo+v1TH8+jwSfcXnlvxCtmFnEogvkAqarpRM2+k05aiPVaUUzyVj5I1zwxW7bqqCq8DYwJBNwxZsJAo4i4F/cBtQnoXAA+GuneRuoYuMT314dRO3g2lXUUhXGH9e/rVyfzJB0wQkIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=os9+6AD8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K61UEs3772334;
	Tue, 20 Jan 2026 08:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fqLR+g9k8Wx
	r7mfZBi668HZxe5EI2BvZng4BOHJrIJk=; b=os9+6AD8dCKVRTm4M4ujp1dL+on
	VDkPyMBbvHTjpv0b8eo1SrDiczYAKkvXKz4j+tjA2lykLdLGxZXjHStUp5MWv8p1
	NvFeErzQHlaW93DzTbVqLmpBY+3GFEc0ZCWn0Aj2F0tA7BpOeqO8W8SCciiF7E4r
	i6pPaRSmnNQJZckSDTOgioAHFXK8nKPl/e8oeKwb6nL9XtSMXh+sLBgjoPlGAn/C
	meoTGCHxkw0HpYnLDtgbzXVgpSHquKqJmzPK8I5Hb6XYMbUjm0OFCU78Gf838wfN
	3BV7m3ge6kQkoH+C/yb0864dj2VC+BuB8qtkXcLm/ZjWMS1ZqwSDzmSniFA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt42wrbpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Grj007970;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80GHP007913;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80HYf008008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id C90EB2557B; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 16/27] RISC-V: KVM: Check and inject nested virtual interrupts
Date: Tue, 20 Jan 2026 13:30:02 +0530
Message-ID: <20260120080013.2153519-17-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-GUID: _BKBdn4pUfwjnC74SjKJ7oSMnO0xFpYw
X-Authority-Analysis: v=2.4 cv=eJMeTXp1 c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=4oXJvcVr6o6G8wQTZ_MA:9
X-Proofpoint-ORIG-GUID: _BKBdn4pUfwjnC74SjKJ7oSMnO0xFpYw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfXyaunJ5xEwBd2
 5Oh2Vgc8eBM/efoUK0/CpltJtuhULQCSd6c6ZD6xlTZ6uxIXVewVN5/5bTqZNw+H2sMD1AH2H+H
 b85R6frNf/CNNQrMQ7Vcy9YFBLOQsrHryCAj+CTu0RCHaq5iW4ll4bUGSNPVU3PaH33r57RVKCC
 pPvulvNFNCbT/5f5YJyPv2pJW02VGJRORXxq/ZHVaCGYXs+dy0NEdgw02qpteBuB1RHLUdWszS4
 u2Y74ngU+LefvjdK8kmyApCRV6yRR28IifldCgEmtDDrIuM/nuGX7oHCyh+pXJmKe5G1IwcuUlS
 KXh0QPffi8a2yknNR5u0/VC9Wfg0BmoKh/gQcz3TP+x1fzcNz346qy3Oqs5/8wSCTI81NEwmTs9
 kUBscGumVsVOz76jnM4bQis4gqxUCqMLpzWpwQr6QB3eo+gyp++mlrlj/fHtmM2SAAGAoubmWoj
 V/4lUVpHpAXW5m0PpWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

When entering guest in virtual-VS/VU mode (aka nested guest),
check and inject nested virtual interrupt right before guest
entry.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_vcpu_nested.h |  1 +
 arch/riscv/kvm/vcpu.c                    |  3 ++
 arch/riscv/kvm/vcpu_nested.c             | 49 ++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_nested.h b/arch/riscv/include/asm/kvm_vcpu_nested.h
index 6bfb67702610..6d9d252a378c 100644
--- a/arch/riscv/include/asm/kvm_vcpu_nested.h
+++ b/arch/riscv/include/asm/kvm_vcpu_nested.h
@@ -86,6 +86,7 @@ void kvm_riscv_vcpu_nested_set_virt(struct kvm_vcpu *vcpu,
 void kvm_riscv_vcpu_nested_trap_redirect(struct kvm_vcpu *vcpu,
 					 struct kvm_cpu_trap *trap,
 					 bool prev_priv);
+void kvm_riscv_vcpu_nested_vsirq_process(struct kvm_vcpu *vcpu);
 
 void kvm_riscv_vcpu_nested_reset(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_nested_init(struct kvm_vcpu *vcpu);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 077637aff9a2..f8c4344c2b1f 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -934,6 +934,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		kvm_riscv_local_tlb_sanitize(vcpu);
 
+		/* Check and inject nested virtual interrupts */
+		kvm_riscv_vcpu_nested_vsirq_process(vcpu);
+
 		trace_kvm_entry(vcpu);
 
 		guest_timing_enter_irqoff();
diff --git a/arch/riscv/kvm/vcpu_nested.c b/arch/riscv/kvm/vcpu_nested.c
index 214206fc28bb..9b2b3369a232 100644
--- a/arch/riscv/kvm/vcpu_nested.c
+++ b/arch/riscv/kvm/vcpu_nested.c
@@ -172,6 +172,55 @@ void kvm_riscv_vcpu_nested_trap_redirect(struct kvm_vcpu *vcpu,
 				       false, prev_priv, gva);
 }
 
+void kvm_riscv_vcpu_nested_vsirq_process(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
+	struct kvm_vcpu_nested_csr *nsc = &ns->csr;
+	struct kvm_cpu_trap trap;
+	unsigned long irqs;
+	bool next_spp;
+	int vsirq;
+
+	/* Do nothing if nested virtualization is OFF */
+	if (!ns->virt)
+		return;
+
+	/* Determine the virtual-VS mode interrupt number */
+	vsirq = 0;
+	irqs = nsc->hvip;
+	irqs &= nsc->vsie << VSIP_TO_HVIP_SHIFT;
+	irqs &= nsc->hideleg;
+	if (irqs & BIT(IRQ_VS_EXT))
+		vsirq = IRQ_S_EXT;
+	else if (irqs & BIT(IRQ_VS_TIMER))
+		vsirq = IRQ_S_TIMER;
+	else if (irqs & BIT(IRQ_VS_SOFT))
+		vsirq = IRQ_S_SOFT;
+	if (vsirq <= 0)
+		return;
+
+	/*
+	 * Determine whether we are resuming in virtual-VS mode
+	 * or virtual-VU mode.
+	 */
+	next_spp = !!(vcpu->arch.guest_context.sstatus & SR_SPP);
+
+	/*
+	 * If we are going to virtual-VS mode and interrupts are
+	 * disabled then do nothing.
+	 */
+	if (next_spp && !(ncsr_read(CSR_VSSTATUS) & SR_SIE))
+		return;
+
+	/* Take virtual-VS mode interrupt */
+	trap.scause = CAUSE_IRQ_FLAG | vsirq;
+	trap.sepc = vcpu->arch.guest_context.sepc;
+	trap.stval = 0;
+	trap.htval = 0;
+	trap.htinst = 0;
+	kvm_riscv_vcpu_trap_smode_redirect(vcpu, &trap, next_spp);
+}
+
 void kvm_riscv_vcpu_nested_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_nested *ns = &vcpu->arch.nested;
-- 
2.43.0


