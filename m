Return-Path: <linux-kselftest+bounces-49465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE907D3C218
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8A594867C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577D3F0757;
	Tue, 20 Jan 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iENyfGdU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8E3BC4EF;
	Tue, 20 Jan 2026 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896100; cv=none; b=UaG0vRCj1X8bWojpyEBobfU5ZLzdfuu9suamD/C0HVuYuVXhM+n7pleZi9E+QD+X3jrmaz2KVAd3DCUir5xagLNAHEHarQu8F4ZnvwvzG4qTZmwnE4OpcCQTYbXcgB/zIAuvOxGoEHUQ8ZPPYV3jCz9oSB01VYJwmHDYDgVMqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896100; c=relaxed/simple;
	bh=g46CI2WfXTFqmoP2zy62Sc8WQLTbmKWBP4l66sGkuP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMQLhyINnGgS4TNGpEIiITJAPruqzeT31G/FHeN1m1AEZG0wl1LSIBSfnfNWqNsEXslenHgzlAIzcCH4v6JdTcLJrJSL+Re7WraqAvoVUEhvRtSgcRKopJg1T1AoVbk6AqA/HlXL279cH34SeomnC5G4I07R970e+MSuAwYahVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iENyfGdU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K2Q9sD1347376;
	Tue, 20 Jan 2026 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kMvVQvpRPSs
	IMOl6BNi/dRloose089q9kZNUJhwzxjc=; b=iENyfGdUPqRssdzkS17WwHcKii2
	e0Jfarpyexa7w+wMlhhnH/WVCuShZC1HC0ViclXF5S4jI7w36Lvv/hTTrMMVPXMv
	1FIoRirnnLlZwTHG44dKUmAIQhR+jWuTPdkHMb2UsEOLxtiREoBIdC3s5dymrFZd
	f0AGJ2xl5WiueWwu6WTxI9BWvPOeoIk19Jqbb0WiCf52vxuSbfWANyN+1EwrKWZl
	edtRMb89lTnEd5d0wGCBXQuC116YCsCiFgBwOSzC7eGVcNTMr3TnDfft9GedZ8Va
	v8aJ9DuGZeBm/s4tTGuELu70WYWpvxhCoJU4dD0N+JaoAOm5uYUq10WsiNg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsnpdjedj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80FXG007882;
	Tue, 20 Jan 2026 08:00:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80HCt008032;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80H1x008015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id E50DA255C5; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 24/27] RISC-V: KVM: Add ONE_REG interface for nested virtualization state
Date: Tue, 20 Jan 2026 13:30:10 +0530
Message-ID: <20260120080013.2153519-25-anup.patel@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=NtncssdJ c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=JxPYNFsx4Yjzc9TJBFQA:9
X-Proofpoint-GUID: 2_KmVGgggJ2UfCAc-tHIh_DNPc4h2pEu
X-Proofpoint-ORIG-GUID: 2_KmVGgggJ2UfCAc-tHIh_DNPc4h2pEu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfXyw91g80ff35X
 DCsg2Fe669mN8XnLU1roJSHlFnrGx2KKkZOG+Vb3SyomrevPwM6fmQGrXIL/obv/YLWWj04zYyl
 8q1g+vvcM+QYzLsI0YPRW8n4GH+vk7Tf1INJYXDDHbd7147YzaLvygq9cb4JpwX15i+GStjTYW5
 7nkVLKJguVAdT5Sq8z24wfz95bemOchxhgBWGQL52CHRzzDz8wYB5QFkc7AQE1FVITJZtgGamYg
 BXKdiVEGhppvF9M7VqE8j2EAw9pVjOLxLORZUo4cp0EyQSculfJnCSX8NMNOkWoMW4d1vlwtvGu
 2l4j7Bn2tISnwPuvWdnUNsC+9MCth3/870LR8Zje0BHHdeCKAowX3VI+4lA7iQzh17gzWrse1ZI
 ioDSREaWgCZ3kSTIB9lJv1/L9mj27CgHzl3MavrJUBGNeBRBAOWvGc1Hh7Gk5A+dOMX+0gHdV3x
 k+sAc1jIgcLPSgvB6Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

Add nested virtualization state to CORE registers of the KVM RISC-V
ONE_REG interface so that it can be updated from KVM user-space in
the same way as privileged mode.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 504e73305343..f62eaa47745b 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -65,6 +65,7 @@ struct kvm_riscv_config {
 struct kvm_riscv_core {
 	struct user_regs_struct regs;
 	unsigned long mode;
+	unsigned long virt;
 };
 
 /* Possible privilege modes for kvm_riscv_core */
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 6b16eee2c833..5f0d10beeb98 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -219,6 +219,8 @@ static int kvm_riscv_vcpu_get_reg_core(struct kvm_vcpu *vcpu,
 	else if (reg_num == KVM_REG_RISCV_CORE_REG(mode))
 		reg_val = (cntx->sstatus & SR_SPP) ?
 				KVM_RISCV_MODE_S : KVM_RISCV_MODE_U;
+	else if (reg_num == KVM_REG_RISCV_CORE_REG(virt))
+		reg_val = kvm_riscv_vcpu_nested_virt(vcpu);
 	else
 		return -ENOENT;
 
@@ -257,6 +259,9 @@ static int kvm_riscv_vcpu_set_reg_core(struct kvm_vcpu *vcpu,
 			cntx->sstatus |= SR_SPP;
 		else
 			cntx->sstatus &= ~SR_SPP;
+	} else if (reg_num == KVM_REG_RISCV_CORE_REG(virt)) {
+		if (riscv_isa_extension_available(vcpu->arch.isa, h))
+			kvm_riscv_vcpu_nested_virt(vcpu) = !!reg_val;
 	} else
 		return -ENOENT;
 
-- 
2.43.0


