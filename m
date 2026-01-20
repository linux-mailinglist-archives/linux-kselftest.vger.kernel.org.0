Return-Path: <linux-kselftest+bounces-49463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D18D3C21D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88D0448634D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E33F0742;
	Tue, 20 Jan 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onk8IxR0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A883BC4F5;
	Tue, 20 Jan 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896099; cv=none; b=VQuWp1p6JzyLrE4hKiTr5hYs6Iw69DkX10e+uwaarOt97K0hmIFm8f96CtdG2im7BJT0VSbyi4Tq0Ue+CJiKzYZpmURnDhG5A7OYzCJdMU2XXOt4XEP8tqLhhOMCi5U//IaU2fKb0CcbmNvLgYr7o4GkEBz6E8D9kSM0D3l3mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896099; c=relaxed/simple;
	bh=WPn68J/6QxYCovjy/AH0wnVqsdoT9SvQrhF95FI6O0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsSYEbz+M3RXh9drCfhp4+2IJ53cD0uAIC/cRbWbhTkK1+uDyWk1yuU/aTxys8p8AUNehZ8qxwy+DwRWSmLolnIm0zsA0loYQjzUvr+0MRPkuPdIoJCnYnFlOzSq1lF9kDlOnbiWtstPFDN6dacro4rKdBa6WIA8qrDNGP03mMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onk8IxR0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K2D8RZ1347458;
	Tue, 20 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uT1QR2lKFew
	zApX0UhiqpQcsJ1t14DmjyExDwez53vc=; b=onk8IxR0/4EddUErBlXMgSW2Bla
	voeSL9WE3UhI+EQMNUD2O/0KSVuRYVYr8ndTY/D/MocaQHkZZWMBXSdU2yQRlZxE
	V7/eybNZx8BxJccCKr377wb//VS9gkJlwyYsCrlQ11klrAIf273Z83SzyiD6Us7M
	xWthiaRng36HUgy50IR4almDGGNqvEVFuRxKZbptCJF2RCI26PbS0I1KKGD302yn
	2NpXxuzZ5KJFZJOIHBargDa0hvpl+QPgLvmS4nOA8r/Lemg2cA1DwxMS04ADjfD+
	d0hn2PXzwxJ9BBuHjSR8qIcBdodRdbT5jiviRXWGKmDv2oe5ImCCJZhEHzg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsnpdjedc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80GwZ007949;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Gqq007909;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80GIO007894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id B0F34249B0; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 09/27] RISC-V: KVM: Don't check hstateen0 when updating sstateen0 CSR
Date: Tue, 20 Jan 2026 13:29:55 +0530
Message-ID: <20260120080013.2153519-10-anup.patel@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=NtncssdJ c=1 sm=1 tr=0 ts=696f3613 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=BHuQUpDX5hp_vwuhbhkA:9
X-Proofpoint-GUID: uzd_8_rk-e-uacfRhm3J0h18fdBTMksv
X-Proofpoint-ORIG-GUID: uzd_8_rk-e-uacfRhm3J0h18fdBTMksv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX/vmX/woHFKEO
 uFTrfR/LC+6Q+jFVKH4ucbVxTlTB+7XAjYld2+T+Tlw+Go6aUtFWe2+wuNGS+TfoQBTH8t7CT4K
 Mha8QNzy/eTevOmkCcexTSjdPXdh1DOBDkwaWkooNx+j2+aKldn43cEnfl/xPr91Fd8A/eR+YKD
 856uvn/37sXuLML3ZIZ6vo2xIPzLxfjRqN4zFU7fAYb2goEHE/r63PzMxsSdQe3pHSB2T0TLJnH
 eVRpAeUn/MDas5fx64MURxf8RBV1IHnfG8HsLHP0YBL57fyPfnzRtdTIlpZyt2lXlMfJLUZxRiM
 xxfESaUwOGwhQt//MGCg9W4UCPPJ0hxVVTM1ii1WP9KF9+dXTvz8Aa35yR5Fg2p0SA4w8B2jUYN
 3VNcFKd6yazFK8ThkrsQxrVLs0zlDbEycFgNj1J9jBnJStOxUOT+QmIGsZzVREkRBCiCr3Zo1ny
 Wzn8vYmxmLr7zWat8HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The hstateen0 will be programmed differently for guest HS-mode
and guest VS/VU-mode so don't check hstateen0.SSTATEEN0 bit when
updating sstateen0 CSR in kvm_riscv_vcpu_swap_in_guest_state()
and kvm_riscv_vcpu_swap_in_host_state().

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/vcpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 62599fc002e8..93c731da67f6 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -702,28 +702,22 @@ static __always_inline void kvm_riscv_vcpu_swap_in_guest_state(struct kvm_vcpu *
 {
 	struct kvm_vcpu_smstateen_csr *smcsr = &vcpu->arch.smstateen_csr;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
-	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
 
 	vcpu->arch.host_scounteren = csr_swap(CSR_SCOUNTEREN, csr->scounteren);
 	vcpu->arch.host_senvcfg = csr_swap(CSR_SENVCFG, csr->senvcfg);
-	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN) &&
-	    (cfg->hstateen0 & SMSTATEEN0_SSTATEEN0))
-		vcpu->arch.host_sstateen0 = csr_swap(CSR_SSTATEEN0,
-						     smcsr->sstateen0);
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN))
+		vcpu->arch.host_sstateen0 = csr_swap(CSR_SSTATEEN0, smcsr->sstateen0);
 }
 
 static __always_inline void kvm_riscv_vcpu_swap_in_host_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_smstateen_csr *smcsr = &vcpu->arch.smstateen_csr;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
-	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
 
 	csr->scounteren = csr_swap(CSR_SCOUNTEREN, vcpu->arch.host_scounteren);
 	csr->senvcfg = csr_swap(CSR_SENVCFG, vcpu->arch.host_senvcfg);
-	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN) &&
-	    (cfg->hstateen0 & SMSTATEEN0_SSTATEEN0))
-		smcsr->sstateen0 = csr_swap(CSR_SSTATEEN0,
-					    vcpu->arch.host_sstateen0);
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN))
+		smcsr->sstateen0 = csr_swap(CSR_SSTATEEN0, vcpu->arch.host_sstateen0);
 }
 
 /*
-- 
2.43.0


