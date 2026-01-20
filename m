Return-Path: <linux-kselftest+bounces-49462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 711BAD3C1CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 025574669B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79FB3B8BB3;
	Tue, 20 Jan 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DfTgalRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111363B8BA9;
	Tue, 20 Jan 2026 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896095; cv=none; b=WJreIWwtN1MKbgub10o9E7PMxgJRpVinrHQ9kZuPEJVLwf0pT65DF5qp2fc1LVHMHyaEsMFNMTBxGzhxhh/M+5SFtj9ua8tRZ8agNqiGAhVv2BuWot1d9AiBUyGdLevuk0xmKJyL/PtU3qkc1OW2L/2/EMLpfAIv2SViQVwcFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896095; c=relaxed/simple;
	bh=4fb7vrv3n2d5WIlSacydWTSdBsTfaasSJ/xf35ao1OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttjdANvHMtRZdnvrqMSS4KdEO4i8nevi8OvXmsGOetZvkyAWiipgiEvWuEs5OfSJW11vLry/s9Gp+LOH0UcfhIIOcQptrQIJqtnb/vzgEGXZhi7Q7pork+Br69kAmbkDbaHKhxVtXen4i4sQUUHUSmVLaUJO9VPmu4ZmbuxK8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DfTgalRq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K33HNt3805126;
	Tue, 20 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wTwGUvXPNkh
	i00Bckxai6W1K9UCx0dIgkJ+74D0lC90=; b=DfTgalRq9yuDmHOKyQJreWlzb06
	+9xwhXEBnYuXMV+VdT8DXutnXOpMCeUSmbfEUbt9BK8S3uP5pmI27QMzpOW3jJ3N
	Qm7mVF4ppCNJzpHxvlt7SYjhqRLiXLk/kPaXmvg5PlsfPtiJn6toaa/J1msybSYW
	xVL5jV/sEBjowPcv94p1jLFw0ny4efTPhyBz+yFbN+uc4wp2PfgvySl3FojIH2YL
	geCpCx05c0m+TetZkKvnR3C2NleZjchO/ZgwbASL6DYxFxM4jwSpF5ypTgeMl/J6
	DvzV5BPNI+Ku/2cpN1uCq2g0kpAmlBQL3d/yfugXDcJ+Nh1js/WUAc0jhCQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt1f88s3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Gwa007949;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80FQ8007834;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80G9C007889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id B7DE925050; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 11/27] RISC-V: KVM: Use half VMID space for nested guest
Date: Tue, 20 Jan 2026 13:29:57 +0530
Message-ID: <20260120080013.2153519-12-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfXxSZgNiD2xzl3
 O7ekqi/owUIdOk+iiFPTVMV8uywl0u/D3B6mnsHEIPviSe/YOBKQ8Jy+unJebkuAdPVOzJ2w4TK
 ECinXzxxg9niSfccQRJxiuEqRH9nqhm7hQxPVCcqRhXCVeGAbWn8cKatimMuwTk35Wz/gl77p6a
 OV8GDI9dPmyu21mLYKLghU7roQ3Gl9o/F/4/J+gXTw6c4SEiYicil21jFAYBLdEQ1oXIWhOt8/v
 1VYEMqJlBQMiMR/29sd/kpOoRlOD4DKZp8DcMdoM/Dhp/y6hI35A3Mn1U3XPMB6MrcB8BNUA2eD
 uc1YmK6Q+S6hgalnMz7VN1HArmBTbEyB4h+t6VjE2PP4qxxuFq1jjmCP356fSA1JeRJK1uTPzsW
 mI74Yd0pPkhe5hlhi7speoQMTP7HT0IofkbLQFF7rI2PK+lrA/QSMwzpJcJepXDtA0a+g9Ybtcz
 MQu8wWVEPpCL8COjwlQ==
X-Proofpoint-GUID: 0sv9t_hnm_GzgT4RGiCnwb7eh4l0Ch5d
X-Proofpoint-ORIG-GUID: 0sv9t_hnm_GzgT4RGiCnwb7eh4l0Ch5d
X-Authority-Analysis: v=2.4 cv=LdQxKzfi c=1 sm=1 tr=0 ts=696f3613 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=8kQOq8E8dDssKVZDBeIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

A single guest with nested virtualization needs two VMIDs: one for
the guest hypervisor (L1) and another for the nested guest (L2).

To support this, divide the VMID space into two equal parts when
nested virtualization is enabled.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_vmid.h |  1 +
 arch/riscv/kvm/main.c             |  4 ++--
 arch/riscv/kvm/tlb.c              | 11 +++++++++--
 arch/riscv/kvm/vmid.c             | 33 ++++++++++++++++++++++++++++---
 4 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vmid.h b/arch/riscv/include/asm/kvm_vmid.h
index db61b0525a8d..3048e12a639c 100644
--- a/arch/riscv/include/asm/kvm_vmid.h
+++ b/arch/riscv/include/asm/kvm_vmid.h
@@ -19,6 +19,7 @@ struct kvm_vmid {
 
 void __init kvm_riscv_gstage_vmid_detect(void);
 unsigned long kvm_riscv_gstage_vmid_bits(void);
+unsigned long kvm_riscv_gstage_nested_vmid(unsigned long vmid);
 int kvm_riscv_gstage_vmid_init(struct kvm *kvm);
 bool kvm_riscv_gstage_vmid_ver_changed(struct kvm_vmid *vmid);
 void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu);
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 5b4bf972d242..28044eefda47 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -123,8 +123,6 @@ static int __init riscv_kvm_init(void)
 		return -ENODEV;
 	}
 
-	kvm_riscv_gstage_vmid_detect();
-
 	rc = kvm_riscv_aia_init();
 	if (rc && rc != -ENODEV) {
 		kvm_riscv_nacl_exit();
@@ -133,6 +131,8 @@ static int __init riscv_kvm_init(void)
 
 	kvm_riscv_nested_init();
 
+	kvm_riscv_gstage_vmid_detect();
+
 	kvm_info("hypervisor extension available\n");
 
 	if (kvm_riscv_nacl_available()) {
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index ff1aeac4eb8e..a95aa5336560 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -160,7 +160,7 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
 
 void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
 {
-	unsigned long vmid;
+	unsigned long vmid, nvmid;
 
 	if (!kvm_riscv_gstage_vmid_bits() ||
 	    vcpu->arch.last_exit_cpu == vcpu->cpu)
@@ -180,12 +180,19 @@ void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
 	vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
 	kvm_riscv_local_hfence_gvma_vmid_all(vmid);
 
+	nvmid = kvm_riscv_gstage_nested_vmid(vmid);
+	if (vmid != nvmid)
+		kvm_riscv_local_hfence_gvma_vmid_all(nvmid);
+
 	/*
 	 * Flush VS-stage TLB entries for implementation where VS-stage
 	 * TLB does not cahce guest physical address and VMID.
 	 */
-	if (static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa))
+	if (static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa)) {
 		kvm_riscv_local_hfence_vvma_all(vmid);
+		if (vmid != nvmid)
+			kvm_riscv_local_hfence_vvma_all(nvmid);
+	}
 }
 
 void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
index cf34d448289d..2ddd95fe2d9c 100644
--- a/arch/riscv/kvm/vmid.c
+++ b/arch/riscv/kvm/vmid.c
@@ -25,6 +25,8 @@ static DEFINE_SPINLOCK(vmid_lock);
 
 void __init kvm_riscv_gstage_vmid_detect(void)
 {
+	unsigned long min_vmids;
+
 	/* Figure-out number of VMID bits in HW */
 	csr_write(CSR_HGATP, (kvm_riscv_gstage_mode << HGATP_MODE_SHIFT) | HGATP_VMID);
 	vmid_bits = csr_read(CSR_HGATP);
@@ -35,8 +37,23 @@ void __init kvm_riscv_gstage_vmid_detect(void)
 	/* We polluted local TLB so flush all guest TLB */
 	kvm_riscv_local_hfence_gvma_all();
 
-	/* We don't use VMID bits if they are not sufficient */
-	if ((1UL << vmid_bits) < num_possible_cpus())
+	/*
+	 * A single guest with nested virtualization needs two
+	 * VMIDs: one for the guest hypervisor (L1) and another
+	 * for the nested guest (L2).
+	 *
+	 * Potentially, we can have a separate guest running on
+	 * each host CPU so the number of VMIDs should not be:
+	 *
+	 * 1. less than the number of host CPUs for
+	 *    nested virtualization disabled
+	 * 2. less than twice the number of host CPUs for
+	 *    nested virtualization enabled
+	 */
+	min_vmids = num_possible_cpus();
+	if (kvm_riscv_nested_available())
+		min_vmids = min_vmids * 2;
+	if (BIT(vmid_bits) < min_vmids)
 		vmid_bits = 0;
 }
 
@@ -45,6 +62,13 @@ unsigned long kvm_riscv_gstage_vmid_bits(void)
 	return vmid_bits;
 }
 
+unsigned long kvm_riscv_gstage_nested_vmid(unsigned long vmid)
+{
+	if (kvm_riscv_nested_available())
+		return vmid | BIT(vmid_bits - 1);
+	return vmid;
+}
+
 int kvm_riscv_gstage_vmid_init(struct kvm *kvm)
 {
 	/* Mark the initial VMID and VMID version invalid */
@@ -112,7 +136,10 @@ void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu)
 
 	vmid->vmid = vmid_next;
 	vmid_next++;
-	vmid_next &= (1 << vmid_bits) - 1;
+	if (kvm_riscv_nested_available())
+		vmid_next &= BIT(vmid_bits - 1) - 1;
+	else
+		vmid_next &= BIT(vmid_bits) - 1;
 
 	WRITE_ONCE(vmid->vmid_version, READ_ONCE(vmid_version));
 
-- 
2.43.0


