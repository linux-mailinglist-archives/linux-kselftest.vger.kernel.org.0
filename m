Return-Path: <linux-kselftest+bounces-49446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50510D3C196
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04371586B69
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1693D6690;
	Tue, 20 Jan 2026 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kAMDQLCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756823D6673;
	Tue, 20 Jan 2026 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896043; cv=none; b=l5js+Urf+0ou5jgcEEUziZZsgu8TdxgwZTqhqDlpSFi+kgVezqTynetKye7dVierAp8hShRJt68qXYG+kuQMztn6jcJ5JHrng05M4eyjCbSUNc3KrzXxcj0hIXRual3WeLRPtcmBJlgkHPlcUnSUuFDTVhVLOM6xqcUCAu/EjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896043; c=relaxed/simple;
	bh=AbuEi3ON0yHojvExQ5DSpAm165nUF1PkHdjiAiKqgpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxQcurYuNRlbdS2KD/RnepU4ttsIlDn46zZluACryVOY0/vRdprU7cO/a+Xw4F1Mfb4WZa3iwv7ulf/8+rZ7+v3BUGZOaKDaViBXO4w9z1tIGt+m3t/jEcAbeWT12HY8eMgve5LqWapYdvvxfJgrBLAvEsYysSR+kzAIbJX21BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kAMDQLCf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K6iel23154093;
	Tue, 20 Jan 2026 08:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8OuUQbrQgmZ
	HCSbCkZ/7w9QZEB4haD24UAPXzHec4+Y=; b=kAMDQLCfvy5m2ZYuI5lcocipcNB
	Q2Sh0wiTNFoPdDEMCwpb2vnwf/Pe0rCxk92SWTQDaQwQlNAN2EthPf9wnuZNCYpY
	fPuZ6tW27Yd9qp42wmLsTYiQuhlVF0N1ibOt7JqZ0LJxZg/UeuEi3eItGJIrHOaX
	Vm10pfyXAwnK7vb2vNc5bVnA1eQL/x3ELO6EHQFnFAY90AEoJzG9gzGYjd/r1Q32
	pqtIUT4De+qQ61+e24N/DoOF52zEkBlrWIFOLXv74AsT1crOMhWWAmdGXBfUBQt6
	jaU/Z2WTPU1vVUlIcOOqzgSs+C+eZA0ZW49hCQYVcoguitmSv4LIfqAa1hQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4q507ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80GKk007950;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80FQQ007831;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80GZC007893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id BEB3825506; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 13/27] RISC-V: KVM: Extend kvm_riscv_vcpu_config_load() for nested virtualization
Date: Tue, 20 Jan 2026 13:29:59 +0530
Message-ID: <20260120080013.2153519-14-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX1F0e7WxQZRYm
 PyYQRk13kmsnobj1Yb8u0XNBK5lk4uXZhHJnaswoS8gOKvtoVphtHeiJMi+gRwy4zT6dNMlnBOG
 BokzFcxhCW3TJmPQEcAgly8L5qxfZLeUyWsmzmqG0iNUmFhVOnecB0CNzk1IUWNUv1nqeFwy3Rn
 /ToOxo/UPt7GIYVuBuuPj3srPnZi9Y8TRHaRo1Mx+gb8GKlr7n9i6cw8tCN6uCHmKE//LEWUWAN
 xGerYGYfYlaqnUGEfb0TC5J5SelTpwGgLagKTCpLePoAZaWUmOYKCRRO7Wd4P7/eWPYXSYtrZqP
 n4s32VVGUfj8SFJigrZXlBZnDCO4JxQ/9Mquox8U1biIXp24zecDRUrvVH0J4GDKQ+12CiLLJae
 AJx8MCFf1Pj9OCLBnlIlbk4a0hrTwptM0MLy8+K4LOybi+cDfFZEhL46JdS4DVryBuxiiyxRJ8z
 qtte/5Z0926ww1fPP8A==
X-Proofpoint-GUID: Y3S_rLnd4miq4swMHOYbJsoKOaAkVvYB
X-Proofpoint-ORIG-GUID: Y3S_rLnd4miq4swMHOYbJsoKOaAkVvYB
X-Authority-Analysis: v=2.4 cv=MNFtWcZl c=1 sm=1 tr=0 ts=696f3617 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=RZcOP4xzeWknupDpA_gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

The kvm_riscv_vcpu_config_load() will be also used for when switching
between guest HS-mode and guest VS/VU-mode so extend it accordingly.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_vcpu_config.h |  2 +-
 arch/riscv/kvm/vcpu.c                    |  2 +-
 arch/riscv/kvm/vcpu_config.c             | 55 ++++++++++++++++++------
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_config.h b/arch/riscv/include/asm/kvm_vcpu_config.h
index fcc15a0296b3..be7bffb6a428 100644
--- a/arch/riscv/include/asm/kvm_vcpu_config.h
+++ b/arch/riscv/include/asm/kvm_vcpu_config.h
@@ -20,6 +20,6 @@ struct kvm_vcpu_config {
 void kvm_riscv_vcpu_config_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_config_guest_debug(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *vcpu);
-void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu, bool nested_virt);
 
 #endif
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 178a4409d4e9..077637aff9a2 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -560,7 +560,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 * the read/write behaviour of certain CSRs change
 	 * based on VCPU config CSRs.
 	 */
-	kvm_riscv_vcpu_config_load(vcpu);
+	kvm_riscv_vcpu_config_load(vcpu, kvm_riscv_vcpu_nested_virt(vcpu));
 
 	if (kvm_riscv_nacl_sync_csr_available()) {
 		nsh = nacl_shmem();
diff --git a/arch/riscv/kvm/vcpu_config.c b/arch/riscv/kvm/vcpu_config.c
index eb7374402b07..6c49bd6f83c5 100644
--- a/arch/riscv/kvm/vcpu_config.c
+++ b/arch/riscv/kvm/vcpu_config.c
@@ -69,33 +69,62 @@ void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *vcpu)
 		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
 }
 
-void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu)
+void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu, bool nested_virt)
 {
+	struct kvm_vcpu_nested_csr *nsc = &vcpu->arch.nested.csr;
 	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+	unsigned long hedeleg, hideleg, tmp;
+	u64 henvcfg, hstateen0;
 	void *nsh;
 
+	if (nested_virt) {
+		hedeleg = nsc->hedeleg;
+		hideleg = 0;
+		henvcfg = 0;
+		hstateen0 = 0;
+	} else {
+		hedeleg = cfg->hedeleg;
+		hideleg = cfg->hideleg;
+		henvcfg = cfg->henvcfg;
+		hstateen0 = cfg->hstateen0;
+	}
+
 	if (kvm_riscv_nacl_sync_csr_available()) {
 		nsh = nacl_shmem();
-		nacl_csr_write(nsh, CSR_HEDELEG, cfg->hedeleg);
-		nacl_csr_write(nsh, CSR_HIDELEG, cfg->hideleg);
-		nacl_csr_write(nsh, CSR_HENVCFG, cfg->henvcfg);
+		nacl_csr_write(nsh, CSR_HEDELEG, hedeleg);
+		nacl_csr_write(nsh, CSR_HIDELEG, hideleg);
+		nacl_csr_write(nsh, CSR_HENVCFG, henvcfg);
 		if (IS_ENABLED(CONFIG_32BIT))
-			nacl_csr_write(nsh, CSR_HENVCFGH, cfg->henvcfg >> 32);
+			nacl_csr_write(nsh, CSR_HENVCFGH, henvcfg >> 32);
 		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
-			nacl_csr_write(nsh, CSR_HSTATEEN0, cfg->hstateen0);
+			nacl_csr_write(nsh, CSR_HSTATEEN0, hstateen0);
 			if (IS_ENABLED(CONFIG_32BIT))
-				nacl_csr_write(nsh, CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
+				nacl_csr_write(nsh, CSR_HSTATEEN0H, hstateen0 >> 32);
+		}
+		if (kvm_riscv_aia_available()) {
+			tmp = nacl_csr_read(nsh, CSR_HVICTL);
+			if (nested_virt)
+				tmp |= HVICTL_VTI;
+			else
+				tmp &= ~HVICTL_VTI;
+			nacl_csr_write(nsh, CSR_HVICTL, tmp);
 		}
 	} else {
-		csr_write(CSR_HEDELEG, cfg->hedeleg);
-		csr_write(CSR_HIDELEG, cfg->hideleg);
-		csr_write(CSR_HENVCFG, cfg->henvcfg);
+		csr_write(CSR_HEDELEG, hedeleg);
+		csr_write(CSR_HIDELEG, hideleg);
+		csr_write(CSR_HENVCFG, henvcfg);
 		if (IS_ENABLED(CONFIG_32BIT))
-			csr_write(CSR_HENVCFGH, cfg->henvcfg >> 32);
+			csr_write(CSR_HENVCFGH, henvcfg >> 32);
 		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
-			csr_write(CSR_HSTATEEN0, cfg->hstateen0);
+			csr_write(CSR_HSTATEEN0, hstateen0);
 			if (IS_ENABLED(CONFIG_32BIT))
-				csr_write(CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
+				csr_write(CSR_HSTATEEN0H, hstateen0 >> 32);
+		}
+		if (kvm_riscv_aia_available()) {
+			if (nested_virt)
+				csr_set(CSR_HVICTL, HVICTL_VTI);
+			else
+				csr_clear(CSR_HVICTL, HVICTL_VTI);
 		}
 	}
 }
-- 
2.43.0


