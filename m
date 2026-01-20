Return-Path: <linux-kselftest+bounces-49442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1621DD3C195
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CF31465327
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88083D5235;
	Tue, 20 Jan 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzTZ7M+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D33BB9EB;
	Tue, 20 Jan 2026 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896036; cv=none; b=XjK63JprBxvHwlUBEJcglEDXtwv8P1LbrKJrry+rf/QwBqrQa+qrhaidwDo9NEBKa00L0yxNj0O9bhlZROGPzC8R5aGeeTEKH5MlCCBhLIlwVDFa05uWtyM9c7MKVsh+9PI03N9nAqBr/SA2T2i6euJ81aHmVF4rT18N17Ggt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896036; c=relaxed/simple;
	bh=W4PdNV6sccm31jO4xlxqF03/noqqwUURz4okGuidrnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=damRDa+yH1MV/mW2XUbc/gIo0es13kINhqjbJkurm9hSyYMKJPgS/ZOgmNRbKTwcvIxZ3QOaHtx828y8xrnNC7mq877q+JDlyi/3zGfj/lkdwIt6Phu2LpakP6TfHOeEM48mI3ANmBQHDaGxsFcFUJmjQdRbYskg/uOtFwijcCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RzTZ7M+Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K29O9Y3176513;
	Tue, 20 Jan 2026 08:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=70FVPqWOUc6
	q+nHQB3unn1JGiYC4Y+KpHz1yQ6rzxfU=; b=RzTZ7M+Y/Q2hZ7Juaa/HTZo5xC4
	0WVbbxHv0+iX8TbGvd0UqmzJNXTIyxVXcG5gu9RGv+KD05QHt55iU9ctqqzNA2xK
	uaCGx/yb/oRG4pHp9eFc/VpR0QfdYP2gvn2T/g5zWqHtKFuZxQGfYo1ZLeUDqR4b
	wN0hZq/vt6i6Q4b4XSfpMPYJxxPLQbqIlZ5tcDYkaH+9P6rJtYWBAAbQqBMNLe4I
	ibYRlFpiC95FRhdkJ3aK7J5JZVRnUa1NHwlLkU8+XmXzA49uPdI25AjfYNDONSI3
	IbSri4A7HHQC+VaecXXyx69vRGg/r6OQStDygsyRJiMysO1ZYbhiXT8bWpQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt0p2gx27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80FpJ007859;
	Tue, 20 Jan 2026 08:00:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80FQ6007834;
	Tue, 20 Jan 2026 08:00:15 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80FsL007822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:15 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 960FC21A15; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 01/27] RISC-V: KVM: Fix error code returned for Smstateen ONE_REG
Date: Tue, 20 Jan 2026 13:29:47 +0530
Message-ID: <20260120080013.2153519-2-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: RHm1NnSvan5Fuj4Vn-KmYzClBeBGL1HQ
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=696f3613 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=TSmjHFh1LFP8C4-irMcA:9
X-Proofpoint-GUID: RHm1NnSvan5Fuj4Vn-KmYzClBeBGL1HQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NiBTYWx0ZWRfX10W8eDU9xlJ2
 fpqkkTDK0+y/dyFI0hEDZbjy2BmJjzmvAvOUprJhBmlmNxdrNOt9h7PYN5ULt9tR/pplcxe0lCx
 ufS3yPj0ZL1gfH9xWbU6vTzEctbMIHxqZBw1p0EsvcMGW9NeOFpvqTnP5wvq0GA5sPB0opsZJFV
 Sh9SWcq27CMXgVHObHV+edv9HWx5gMoVlu76dptHfLWaxBBU3zuJ8EEghvv1LcByuoankAvFuun
 9f7kjeNz8uUb96uqm0F0ehGUvPf9e7jncAxX7qjCTgYmJG2Qc5TA8AY+d/dDlHThqvxc4xvA49u
 62pbhekF5/etmCJbYdZeVKth8QMIueCSp7oyZfzKoh+9KLyIgVzsMOVhzIBiLmq46Y+eIIb90pX
 65CcPtk+CpMVG9FV2cdgdfUVx9cStpU2u3I/rJAXLrzN+qgsNVmB7Gt8cmg1bIDrUUOZep6H+vF
 VOwqKwVr6Pigc7edHbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200066

Return -ENOENT for Smstateen ONE_REG when:
1) Smstateen is not enabled for a VCPU
2) When ONE_REG id is out of range

This will make Smstateen ONE_REG error codes consistent
with other ONE_REG interfaces of KVM RISC-V.

Fixes: c04913f2b54e ("RISCV: KVM: Add sstateen0 to ONE_REG")
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/vcpu_onereg.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index e7ab6cb00646..6dab4deed86d 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -549,9 +549,11 @@ static inline int kvm_riscv_vcpu_smstateen_set_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_smstateen_csr *csr = &vcpu->arch.smstateen_csr;
 
+	if (!riscv_isa_extension_available(vcpu->arch.isa, SMSTATEEN))
+		return -ENOENT;
 	if (reg_num >= sizeof(struct kvm_riscv_smstateen_csr) /
 		sizeof(unsigned long))
-		return -EINVAL;
+		return -ENOENT;
 
 	((unsigned long *)csr)[reg_num] = reg_val;
 	return 0;
@@ -563,9 +565,11 @@ static int kvm_riscv_vcpu_smstateen_get_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_smstateen_csr *csr = &vcpu->arch.smstateen_csr;
 
+	if (!riscv_isa_extension_available(vcpu->arch.isa, SMSTATEEN))
+		return -ENOENT;
 	if (reg_num >= sizeof(struct kvm_riscv_smstateen_csr) /
 		sizeof(unsigned long))
-		return -EINVAL;
+		return -ENOENT;
 
 	*out_val = ((unsigned long *)csr)[reg_num];
 	return 0;
@@ -595,10 +599,7 @@ static int kvm_riscv_vcpu_get_reg_csr(struct kvm_vcpu *vcpu,
 		rc = kvm_riscv_vcpu_aia_get_csr(vcpu, reg_num, &reg_val);
 		break;
 	case KVM_REG_RISCV_CSR_SMSTATEEN:
-		rc = -EINVAL;
-		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN))
-			rc = kvm_riscv_vcpu_smstateen_get_csr(vcpu, reg_num,
-							      &reg_val);
+		rc = kvm_riscv_vcpu_smstateen_get_csr(vcpu, reg_num, &reg_val);
 		break;
 	default:
 		rc = -ENOENT;
@@ -640,10 +641,7 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu *vcpu,
 		rc = kvm_riscv_vcpu_aia_set_csr(vcpu, reg_num, reg_val);
 		break;
 	case KVM_REG_RISCV_CSR_SMSTATEEN:
-		rc = -EINVAL;
-		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN))
-			rc = kvm_riscv_vcpu_smstateen_set_csr(vcpu, reg_num,
-							      reg_val);
+		rc = kvm_riscv_vcpu_smstateen_set_csr(vcpu, reg_num, reg_val);
 		break;
 	default:
 		rc = -ENOENT;
-- 
2.43.0


