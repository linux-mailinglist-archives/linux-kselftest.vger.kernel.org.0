Return-Path: <linux-kselftest+bounces-49469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC8D3C239
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2F8F48917F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10740B6C7;
	Tue, 20 Jan 2026 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yu7v27Oh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2C40757B;
	Tue, 20 Jan 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896109; cv=none; b=uXFxi5B8yRFxxgDCWoESi72BgmbJ3JOfFWIcQNUtTnd0BUBSPnQtS2ccopO9X4zlNfN5v07dyqVnhsPHagdDw0MnbtKQHxP0NzpV0QBXVIaCJ6dHKlQ6tvcp27eRacb1IbDX4mmg8ABG4e6ewrs4J2t029ky7Q3rRQvTPJYik2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896109; c=relaxed/simple;
	bh=wX4+r9jxxF2JRJLxGaBk5KaPvCH4hawwigCqtLbn9h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROw10IL85ttUC5semDqmZjlQpXXSJRdjZsQlwtWubDh9HT1olgTfC+X+RJt9dGRRWPAEnLFBi3FVWx6tYP/ISocbHzepVAKjtJSkR60fEL0c24s+AId06dYtQ1yDZhuhPiqC/h+dDLpd2FnoHCL6bLmyiBAVcFKgh7XtNOWrgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yu7v27Oh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7wab71880737;
	Tue, 20 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lnXUeh5HB3t
	5EGQEEa9IHj7uua0btt3BQXfARvYjb5A=; b=Yu7v27OhfrPR6oxBtu8MBLrrwQK
	9MV2f0EEijQ285fLYz0Qm3S7vn11LbAn9RcXi8bGh8emK3d0VZRAT/zYBpXzlS2S
	+ba7hQoKdT1x4nGpoRystSUe/zcTvh+FjXYAwvinBs0a+I6ENLi3ODUleEMXMBl7
	4tTojh1raw6GeaTGsGvKTl8K8+89Oelex9j1L3GvgGxR0zAg3w0NAPgbpofyW12Q
	y6LaEnYhb1MDcdppg1ig2IJTBBz34R0M/4CXcVTFe1X9aJaXGMoHDon1JTW69fQf
	gjPbzkbRDoAPgl917yz4DFIV1IFjrLeBKwg85/99rnB2uIki9rcj0BfavCQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgfrbk2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K7wCU2005905;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Gx4007908;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80Gf8007887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id A383D23545; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 05/27] RISC-V: KVM: Factor-out ISA checks into separate sources
Date: Tue, 20 Jan 2026 13:29:51 +0530
Message-ID: <20260120080013.2153519-6-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 0ZnyS2FO5-5ENTark0teSfZdY73eOxuk
X-Proofpoint-GUID: 0ZnyS2FO5-5ENTark0teSfZdY73eOxuk
X-Authority-Analysis: v=2.4 cv=c4OmgB9l c=1 sm=1 tr=0 ts=696f3614 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=FDWiWJIJNkNkmATpyzQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NiBTYWx0ZWRfXxx6aBy/WNB9P
 HjqRuuFV9lkezZwkPxcnMQ64sQy0R+AIZBgxoQavHuN1I7Py3BDG83/Zk4PVIgBQMd0J8BvU9PD
 9JkCmoluVKH3v/k/XXgYMHOVTQ/Zxedh3Sloqgmx9uAGkuk70INcarpw90MXvRNnUJF0RM8Ycem
 x/a3UmSadEqGAPYPIzbEHBcwSJJUhSeJtbwa4myUKRxkssPSnNUL8VajTK+t9aGvOsg3zyirD93
 EQmYnOLjHqaQVUTFSUEJja1I46YTeek2M7x2M4JLCPnU1fVLkrXErCvm7nlxWPTgJKrTEKclIH7
 jzd6NZrV9QvBUpThkkBIAgeraB9WTEpgcHZf+VqQIETVahs0Fe8LeVFOZ4KWtDsWk8KW6lav2FA
 /qNRDwmd8Ad4WiVkE+iwEiIK2of/SqKbYB1bUPi9cTqE5T5cxJdpkJ15AP3oJh4l6qh0gmjlHBW
 zvRywf/ASb3ABG4twqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200066

The KVM ISA extension related checks are not VCPU specific and
should be factored out of vcpu_onereg.c into separate sources.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_host.h |   4 -
 arch/riscv/include/asm/kvm_isa.h  |  20 +++
 arch/riscv/kvm/Makefile           |   1 +
 arch/riscv/kvm/aia_device.c       |   1 +
 arch/riscv/kvm/isa.c              | 251 +++++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_fp.c          |   1 +
 arch/riscv/kvm/vcpu_onereg.c      | 257 +-----------------------------
 arch/riscv/kvm/vcpu_pmu.c         |   3 +-
 arch/riscv/kvm/vcpu_timer.c       |   1 +
 arch/riscv/kvm/vcpu_vector.c      |   1 +
 10 files changed, 286 insertions(+), 254 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_isa.h
 create mode 100644 arch/riscv/kvm/isa.c

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 47a350c25555..24585304c02b 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -308,10 +308,6 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 
 void __kvm_riscv_switch_to(struct kvm_vcpu_arch *vcpu_arch);
 
-int __kvm_riscv_isa_check_host(unsigned long kvm_ext, unsigned long *guest_ext);
-#define kvm_riscv_isa_check_host(ext)	\
-	__kvm_riscv_isa_check_host(KVM_RISCV_ISA_EXT_##ext, NULL)
-
 void kvm_riscv_vcpu_setup_isa(struct kvm_vcpu *vcpu);
 unsigned long kvm_riscv_vcpu_num_regs(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
diff --git a/arch/riscv/include/asm/kvm_isa.h b/arch/riscv/include/asm/kvm_isa.h
new file mode 100644
index 000000000000..bc4b956d5f17
--- /dev/null
+++ b/arch/riscv/include/asm/kvm_isa.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#ifndef __KVM_RISCV_ISA_H
+#define __KVM_RISCV_ISA_H
+
+#include <linux/types.h>
+
+unsigned long kvm_riscv_base2isa_ext(unsigned long base_ext);
+
+int __kvm_riscv_isa_check_host(unsigned long ext, unsigned long *base_ext);
+#define kvm_riscv_isa_check_host(ext)	\
+	__kvm_riscv_isa_check_host(KVM_RISCV_ISA_EXT_##ext, NULL)
+
+bool kvm_riscv_isa_enable_allowed(unsigned long ext);
+bool kvm_riscv_isa_disable_allowed(unsigned long ext);
+
+#endif
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 3b8afb038b35..07eab96189e7 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -15,6 +15,7 @@ kvm-y += aia_aplic.o
 kvm-y += aia_device.o
 kvm-y += aia_imsic.o
 kvm-y += gstage.o
+kvm-y += isa.o
 kvm-y += main.o
 kvm-y += mmu.o
 kvm-y += nacl.o
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index 4cecab9bf102..77629b7eac09 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -12,6 +12,7 @@
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
 #include <linux/cpufeature.h>
+#include <asm/kvm_isa.h>
 
 static int aia_create(struct kvm_device *dev, u32 type)
 {
diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
new file mode 100644
index 000000000000..e860f6d79bb0
--- /dev/null
+++ b/arch/riscv/kvm/isa.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ */
+
+#include <linux/errno.h>
+#include <linux/kvm_host.h>
+#include <linux/cpufeature.h>
+#include <linux/pgtable.h>
+#include <asm/kvm_isa.h>
+#include <asm/vector.h>
+
+#define KVM_ISA_EXT_ARR(ext)		\
+[KVM_RISCV_ISA_EXT_##ext] = RISCV_ISA_EXT_##ext
+
+/* Mapping between KVM ISA Extension ID & guest ISA extension ID */
+static const unsigned long kvm_isa_ext_arr[] = {
+	/* Single letter extensions (alphabetically sorted) */
+	[KVM_RISCV_ISA_EXT_A] = RISCV_ISA_EXT_a,
+	[KVM_RISCV_ISA_EXT_C] = RISCV_ISA_EXT_c,
+	[KVM_RISCV_ISA_EXT_D] = RISCV_ISA_EXT_d,
+	[KVM_RISCV_ISA_EXT_F] = RISCV_ISA_EXT_f,
+	[KVM_RISCV_ISA_EXT_H] = RISCV_ISA_EXT_h,
+	[KVM_RISCV_ISA_EXT_I] = RISCV_ISA_EXT_i,
+	[KVM_RISCV_ISA_EXT_M] = RISCV_ISA_EXT_m,
+	[KVM_RISCV_ISA_EXT_V] = RISCV_ISA_EXT_v,
+	/* Multi letter extensions (alphabetically sorted) */
+	KVM_ISA_EXT_ARR(SMNPM),
+	KVM_ISA_EXT_ARR(SMSTATEEN),
+	KVM_ISA_EXT_ARR(SSAIA),
+	KVM_ISA_EXT_ARR(SSCOFPMF),
+	KVM_ISA_EXT_ARR(SSNPM),
+	KVM_ISA_EXT_ARR(SSTC),
+	KVM_ISA_EXT_ARR(SVADE),
+	KVM_ISA_EXT_ARR(SVADU),
+	KVM_ISA_EXT_ARR(SVINVAL),
+	KVM_ISA_EXT_ARR(SVNAPOT),
+	KVM_ISA_EXT_ARR(SVPBMT),
+	KVM_ISA_EXT_ARR(SVVPTC),
+	KVM_ISA_EXT_ARR(ZAAMO),
+	KVM_ISA_EXT_ARR(ZABHA),
+	KVM_ISA_EXT_ARR(ZACAS),
+	KVM_ISA_EXT_ARR(ZALASR),
+	KVM_ISA_EXT_ARR(ZALRSC),
+	KVM_ISA_EXT_ARR(ZAWRS),
+	KVM_ISA_EXT_ARR(ZBA),
+	KVM_ISA_EXT_ARR(ZBB),
+	KVM_ISA_EXT_ARR(ZBC),
+	KVM_ISA_EXT_ARR(ZBKB),
+	KVM_ISA_EXT_ARR(ZBKC),
+	KVM_ISA_EXT_ARR(ZBKX),
+	KVM_ISA_EXT_ARR(ZBS),
+	KVM_ISA_EXT_ARR(ZCA),
+	KVM_ISA_EXT_ARR(ZCB),
+	KVM_ISA_EXT_ARR(ZCD),
+	KVM_ISA_EXT_ARR(ZCF),
+	KVM_ISA_EXT_ARR(ZCLSD),
+	KVM_ISA_EXT_ARR(ZCMOP),
+	KVM_ISA_EXT_ARR(ZFA),
+	KVM_ISA_EXT_ARR(ZFBFMIN),
+	KVM_ISA_EXT_ARR(ZFH),
+	KVM_ISA_EXT_ARR(ZFHMIN),
+	KVM_ISA_EXT_ARR(ZICBOM),
+	KVM_ISA_EXT_ARR(ZICBOP),
+	KVM_ISA_EXT_ARR(ZICBOZ),
+	KVM_ISA_EXT_ARR(ZICCRSE),
+	KVM_ISA_EXT_ARR(ZICNTR),
+	KVM_ISA_EXT_ARR(ZICOND),
+	KVM_ISA_EXT_ARR(ZICSR),
+	KVM_ISA_EXT_ARR(ZIFENCEI),
+	KVM_ISA_EXT_ARR(ZIHINTNTL),
+	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
+	KVM_ISA_EXT_ARR(ZIHPM),
+	KVM_ISA_EXT_ARR(ZILSD),
+	KVM_ISA_EXT_ARR(ZIMOP),
+	KVM_ISA_EXT_ARR(ZKND),
+	KVM_ISA_EXT_ARR(ZKNE),
+	KVM_ISA_EXT_ARR(ZKNH),
+	KVM_ISA_EXT_ARR(ZKR),
+	KVM_ISA_EXT_ARR(ZKSED),
+	KVM_ISA_EXT_ARR(ZKSH),
+	KVM_ISA_EXT_ARR(ZKT),
+	KVM_ISA_EXT_ARR(ZTSO),
+	KVM_ISA_EXT_ARR(ZVBB),
+	KVM_ISA_EXT_ARR(ZVBC),
+	KVM_ISA_EXT_ARR(ZVFBFMIN),
+	KVM_ISA_EXT_ARR(ZVFBFWMA),
+	KVM_ISA_EXT_ARR(ZVFH),
+	KVM_ISA_EXT_ARR(ZVFHMIN),
+	KVM_ISA_EXT_ARR(ZVKB),
+	KVM_ISA_EXT_ARR(ZVKG),
+	KVM_ISA_EXT_ARR(ZVKNED),
+	KVM_ISA_EXT_ARR(ZVKNHA),
+	KVM_ISA_EXT_ARR(ZVKNHB),
+	KVM_ISA_EXT_ARR(ZVKSED),
+	KVM_ISA_EXT_ARR(ZVKSH),
+	KVM_ISA_EXT_ARR(ZVKT),
+};
+
+unsigned long kvm_riscv_base2isa_ext(unsigned long base_ext)
+{
+	unsigned long i;
+
+	for (i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
+		if (kvm_isa_ext_arr[i] == base_ext)
+			return i;
+	}
+
+	return KVM_RISCV_ISA_EXT_MAX;
+}
+
+int __kvm_riscv_isa_check_host(unsigned long ext, unsigned long *base_ext)
+{
+	unsigned long host_ext;
+
+	if (ext >= KVM_RISCV_ISA_EXT_MAX ||
+	    ext >= ARRAY_SIZE(kvm_isa_ext_arr))
+		return -ENOENT;
+
+	switch (kvm_isa_ext_arr[ext]) {
+	case RISCV_ISA_EXT_SMNPM:
+		/*
+		 * Pointer masking effective in (H)S-mode is provided by the
+		 * Smnpm extension, so that extension is reported to the guest,
+		 * even though the CSR bits for configuring VS-mode pointer
+		 * masking on the host side are part of the Ssnpm extension.
+		 */
+		host_ext = RISCV_ISA_EXT_SSNPM;
+		break;
+	default:
+		host_ext = kvm_isa_ext_arr[ext];
+		break;
+	}
+
+	if (!__riscv_isa_extension_available(NULL, host_ext))
+		return -ENOENT;
+
+	if (base_ext)
+		*base_ext = kvm_isa_ext_arr[ext];
+
+	return 0;
+}
+
+bool kvm_riscv_isa_enable_allowed(unsigned long ext)
+{
+	switch (ext) {
+	case KVM_RISCV_ISA_EXT_H:
+		return false;
+	case KVM_RISCV_ISA_EXT_SSCOFPMF:
+		/* Sscofpmf depends on interrupt filtering defined in ssaia */
+		return !kvm_riscv_isa_check_host(SSAIA);
+	case KVM_RISCV_ISA_EXT_SVADU:
+		/*
+		 * The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero.
+		 * Guest OS can use Svadu only when host OS enable Svadu.
+		 */
+		return arch_has_hw_pte_young();
+	case KVM_RISCV_ISA_EXT_V:
+		return riscv_v_vstate_ctrl_user_allowed();
+	default:
+		break;
+	}
+
+	return true;
+}
+
+bool kvm_riscv_isa_disable_allowed(unsigned long ext)
+{
+	switch (ext) {
+	/* Extensions which don't have any mechanism to disable */
+	case KVM_RISCV_ISA_EXT_A:
+	case KVM_RISCV_ISA_EXT_C:
+	case KVM_RISCV_ISA_EXT_I:
+	case KVM_RISCV_ISA_EXT_M:
+	/* There is not architectural config bit to disable sscofpmf completely */
+	case KVM_RISCV_ISA_EXT_SSCOFPMF:
+	case KVM_RISCV_ISA_EXT_SSNPM:
+	case KVM_RISCV_ISA_EXT_SSTC:
+	case KVM_RISCV_ISA_EXT_SVINVAL:
+	case KVM_RISCV_ISA_EXT_SVNAPOT:
+	case KVM_RISCV_ISA_EXT_SVVPTC:
+	case KVM_RISCV_ISA_EXT_ZAAMO:
+	case KVM_RISCV_ISA_EXT_ZABHA:
+	case KVM_RISCV_ISA_EXT_ZACAS:
+	case KVM_RISCV_ISA_EXT_ZALASR:
+	case KVM_RISCV_ISA_EXT_ZALRSC:
+	case KVM_RISCV_ISA_EXT_ZAWRS:
+	case KVM_RISCV_ISA_EXT_ZBA:
+	case KVM_RISCV_ISA_EXT_ZBB:
+	case KVM_RISCV_ISA_EXT_ZBC:
+	case KVM_RISCV_ISA_EXT_ZBKB:
+	case KVM_RISCV_ISA_EXT_ZBKC:
+	case KVM_RISCV_ISA_EXT_ZBKX:
+	case KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_RISCV_ISA_EXT_ZCA:
+	case KVM_RISCV_ISA_EXT_ZCB:
+	case KVM_RISCV_ISA_EXT_ZCD:
+	case KVM_RISCV_ISA_EXT_ZCF:
+	case KVM_RISCV_ISA_EXT_ZCMOP:
+	case KVM_RISCV_ISA_EXT_ZFA:
+	case KVM_RISCV_ISA_EXT_ZFBFMIN:
+	case KVM_RISCV_ISA_EXT_ZFH:
+	case KVM_RISCV_ISA_EXT_ZFHMIN:
+	case KVM_RISCV_ISA_EXT_ZICBOP:
+	case KVM_RISCV_ISA_EXT_ZICCRSE:
+	case KVM_RISCV_ISA_EXT_ZICNTR:
+	case KVM_RISCV_ISA_EXT_ZICOND:
+	case KVM_RISCV_ISA_EXT_ZICSR:
+	case KVM_RISCV_ISA_EXT_ZIFENCEI:
+	case KVM_RISCV_ISA_EXT_ZIHINTNTL:
+	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
+	case KVM_RISCV_ISA_EXT_ZIHPM:
+	case KVM_RISCV_ISA_EXT_ZIMOP:
+	case KVM_RISCV_ISA_EXT_ZKND:
+	case KVM_RISCV_ISA_EXT_ZKNE:
+	case KVM_RISCV_ISA_EXT_ZKNH:
+	case KVM_RISCV_ISA_EXT_ZKR:
+	case KVM_RISCV_ISA_EXT_ZKSED:
+	case KVM_RISCV_ISA_EXT_ZKSH:
+	case KVM_RISCV_ISA_EXT_ZKT:
+	case KVM_RISCV_ISA_EXT_ZTSO:
+	case KVM_RISCV_ISA_EXT_ZVBB:
+	case KVM_RISCV_ISA_EXT_ZVBC:
+	case KVM_RISCV_ISA_EXT_ZVFBFMIN:
+	case KVM_RISCV_ISA_EXT_ZVFBFWMA:
+	case KVM_RISCV_ISA_EXT_ZVFH:
+	case KVM_RISCV_ISA_EXT_ZVFHMIN:
+	case KVM_RISCV_ISA_EXT_ZVKB:
+	case KVM_RISCV_ISA_EXT_ZVKG:
+	case KVM_RISCV_ISA_EXT_ZVKNED:
+	case KVM_RISCV_ISA_EXT_ZVKNHA:
+	case KVM_RISCV_ISA_EXT_ZVKNHB:
+	case KVM_RISCV_ISA_EXT_ZVKSED:
+	case KVM_RISCV_ISA_EXT_ZVKSH:
+	case KVM_RISCV_ISA_EXT_ZVKT:
+		return false;
+	/* Extensions which can be disabled using Smstateen */
+	case KVM_RISCV_ISA_EXT_SSAIA:
+		return riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN);
+	case KVM_RISCV_ISA_EXT_SVADE:
+		/*
+		 * The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero.
+		 * Svade can't be disabled unless we support Svadu.
+		 */
+		return arch_has_hw_pte_young();
+	default:
+		break;
+	}
+
+	return true;
+}
diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
index 32ab5938a2ec..49ad7446d2bb 100644
--- a/arch/riscv/kvm/vcpu_fp.c
+++ b/arch/riscv/kvm/vcpu_fp.c
@@ -12,6 +12,7 @@
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
 #include <asm/cpufeature.h>
+#include <asm/kvm_isa.h>
 
 #ifdef CONFIG_FPU
 void kvm_riscv_vcpu_fp_reset(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index f0f8c293d950..6b16eee2c833 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -14,260 +14,19 @@
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
+#include <asm/kvm_isa.h>
 #include <asm/kvm_vcpu_vector.h>
-#include <asm/pgtable.h>
-#include <asm/vector.h>
 
 #define KVM_RISCV_BASE_ISA_MASK		GENMASK(25, 0)
 
-#define KVM_ISA_EXT_ARR(ext)		\
-[KVM_RISCV_ISA_EXT_##ext] = RISCV_ISA_EXT_##ext
-
-/* Mapping between KVM ISA Extension ID & guest ISA extension ID */
-static const unsigned long kvm_isa_ext_arr[] = {
-	/* Single letter extensions (alphabetically sorted) */
-	[KVM_RISCV_ISA_EXT_A] = RISCV_ISA_EXT_a,
-	[KVM_RISCV_ISA_EXT_C] = RISCV_ISA_EXT_c,
-	[KVM_RISCV_ISA_EXT_D] = RISCV_ISA_EXT_d,
-	[KVM_RISCV_ISA_EXT_F] = RISCV_ISA_EXT_f,
-	[KVM_RISCV_ISA_EXT_H] = RISCV_ISA_EXT_h,
-	[KVM_RISCV_ISA_EXT_I] = RISCV_ISA_EXT_i,
-	[KVM_RISCV_ISA_EXT_M] = RISCV_ISA_EXT_m,
-	[KVM_RISCV_ISA_EXT_V] = RISCV_ISA_EXT_v,
-	/* Multi letter extensions (alphabetically sorted) */
-	KVM_ISA_EXT_ARR(SMNPM),
-	KVM_ISA_EXT_ARR(SMSTATEEN),
-	KVM_ISA_EXT_ARR(SSAIA),
-	KVM_ISA_EXT_ARR(SSCOFPMF),
-	KVM_ISA_EXT_ARR(SSNPM),
-	KVM_ISA_EXT_ARR(SSTC),
-	KVM_ISA_EXT_ARR(SVADE),
-	KVM_ISA_EXT_ARR(SVADU),
-	KVM_ISA_EXT_ARR(SVINVAL),
-	KVM_ISA_EXT_ARR(SVNAPOT),
-	KVM_ISA_EXT_ARR(SVPBMT),
-	KVM_ISA_EXT_ARR(SVVPTC),
-	KVM_ISA_EXT_ARR(ZAAMO),
-	KVM_ISA_EXT_ARR(ZABHA),
-	KVM_ISA_EXT_ARR(ZACAS),
-	KVM_ISA_EXT_ARR(ZALASR),
-	KVM_ISA_EXT_ARR(ZALRSC),
-	KVM_ISA_EXT_ARR(ZAWRS),
-	KVM_ISA_EXT_ARR(ZBA),
-	KVM_ISA_EXT_ARR(ZBB),
-	KVM_ISA_EXT_ARR(ZBC),
-	KVM_ISA_EXT_ARR(ZBKB),
-	KVM_ISA_EXT_ARR(ZBKC),
-	KVM_ISA_EXT_ARR(ZBKX),
-	KVM_ISA_EXT_ARR(ZBS),
-	KVM_ISA_EXT_ARR(ZCA),
-	KVM_ISA_EXT_ARR(ZCB),
-	KVM_ISA_EXT_ARR(ZCD),
-	KVM_ISA_EXT_ARR(ZCF),
-	KVM_ISA_EXT_ARR(ZCLSD),
-	KVM_ISA_EXT_ARR(ZCMOP),
-	KVM_ISA_EXT_ARR(ZFA),
-	KVM_ISA_EXT_ARR(ZFBFMIN),
-	KVM_ISA_EXT_ARR(ZFH),
-	KVM_ISA_EXT_ARR(ZFHMIN),
-	KVM_ISA_EXT_ARR(ZICBOM),
-	KVM_ISA_EXT_ARR(ZICBOP),
-	KVM_ISA_EXT_ARR(ZICBOZ),
-	KVM_ISA_EXT_ARR(ZICCRSE),
-	KVM_ISA_EXT_ARR(ZICNTR),
-	KVM_ISA_EXT_ARR(ZICOND),
-	KVM_ISA_EXT_ARR(ZICSR),
-	KVM_ISA_EXT_ARR(ZIFENCEI),
-	KVM_ISA_EXT_ARR(ZIHINTNTL),
-	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
-	KVM_ISA_EXT_ARR(ZIHPM),
-	KVM_ISA_EXT_ARR(ZILSD),
-	KVM_ISA_EXT_ARR(ZIMOP),
-	KVM_ISA_EXT_ARR(ZKND),
-	KVM_ISA_EXT_ARR(ZKNE),
-	KVM_ISA_EXT_ARR(ZKNH),
-	KVM_ISA_EXT_ARR(ZKR),
-	KVM_ISA_EXT_ARR(ZKSED),
-	KVM_ISA_EXT_ARR(ZKSH),
-	KVM_ISA_EXT_ARR(ZKT),
-	KVM_ISA_EXT_ARR(ZTSO),
-	KVM_ISA_EXT_ARR(ZVBB),
-	KVM_ISA_EXT_ARR(ZVBC),
-	KVM_ISA_EXT_ARR(ZVFBFMIN),
-	KVM_ISA_EXT_ARR(ZVFBFWMA),
-	KVM_ISA_EXT_ARR(ZVFH),
-	KVM_ISA_EXT_ARR(ZVFHMIN),
-	KVM_ISA_EXT_ARR(ZVKB),
-	KVM_ISA_EXT_ARR(ZVKG),
-	KVM_ISA_EXT_ARR(ZVKNED),
-	KVM_ISA_EXT_ARR(ZVKNHA),
-	KVM_ISA_EXT_ARR(ZVKNHB),
-	KVM_ISA_EXT_ARR(ZVKSED),
-	KVM_ISA_EXT_ARR(ZVKSH),
-	KVM_ISA_EXT_ARR(ZVKT),
-};
-
-static unsigned long kvm_riscv_vcpu_base2isa_ext(unsigned long base_ext)
-{
-	unsigned long i;
-
-	for (i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
-		if (kvm_isa_ext_arr[i] == base_ext)
-			return i;
-	}
-
-	return KVM_RISCV_ISA_EXT_MAX;
-}
-
-int __kvm_riscv_isa_check_host(unsigned long kvm_ext, unsigned long *base_ext)
-{
-	unsigned long host_ext;
-
-	if (kvm_ext >= KVM_RISCV_ISA_EXT_MAX ||
-	    kvm_ext >= ARRAY_SIZE(kvm_isa_ext_arr))
-		return -ENOENT;
-
-	switch (kvm_isa_ext_arr[kvm_ext]) {
-	case RISCV_ISA_EXT_SMNPM:
-		/*
-		 * Pointer masking effective in (H)S-mode is provided by the
-		 * Smnpm extension, so that extension is reported to the guest,
-		 * even though the CSR bits for configuring VS-mode pointer
-		 * masking on the host side are part of the Ssnpm extension.
-		 */
-		host_ext = RISCV_ISA_EXT_SSNPM;
-		break;
-	default:
-		host_ext = kvm_isa_ext_arr[kvm_ext];
-		break;
-	}
-
-	if (!__riscv_isa_extension_available(NULL, host_ext))
-		return -ENOENT;
-
-	if (base_ext)
-		*base_ext = kvm_isa_ext_arr[kvm_ext];
-
-	return 0;
-}
-
-static bool kvm_riscv_vcpu_isa_enable_allowed(unsigned long ext)
-{
-	switch (ext) {
-	case KVM_RISCV_ISA_EXT_H:
-		return false;
-	case KVM_RISCV_ISA_EXT_SSCOFPMF:
-		/* Sscofpmf depends on interrupt filtering defined in ssaia */
-		return !kvm_riscv_isa_check_host(SSAIA);
-	case KVM_RISCV_ISA_EXT_SVADU:
-		/*
-		 * The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero.
-		 * Guest OS can use Svadu only when host OS enable Svadu.
-		 */
-		return arch_has_hw_pte_young();
-	case KVM_RISCV_ISA_EXT_V:
-		return riscv_v_vstate_ctrl_user_allowed();
-	default:
-		break;
-	}
-
-	return true;
-}
-
-static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
-{
-	switch (ext) {
-	/* Extensions which don't have any mechanism to disable */
-	case KVM_RISCV_ISA_EXT_A:
-	case KVM_RISCV_ISA_EXT_C:
-	case KVM_RISCV_ISA_EXT_I:
-	case KVM_RISCV_ISA_EXT_M:
-	/* There is not architectural config bit to disable sscofpmf completely */
-	case KVM_RISCV_ISA_EXT_SSCOFPMF:
-	case KVM_RISCV_ISA_EXT_SSNPM:
-	case KVM_RISCV_ISA_EXT_SSTC:
-	case KVM_RISCV_ISA_EXT_SVINVAL:
-	case KVM_RISCV_ISA_EXT_SVNAPOT:
-	case KVM_RISCV_ISA_EXT_SVVPTC:
-	case KVM_RISCV_ISA_EXT_ZAAMO:
-	case KVM_RISCV_ISA_EXT_ZABHA:
-	case KVM_RISCV_ISA_EXT_ZACAS:
-	case KVM_RISCV_ISA_EXT_ZALASR:
-	case KVM_RISCV_ISA_EXT_ZALRSC:
-	case KVM_RISCV_ISA_EXT_ZAWRS:
-	case KVM_RISCV_ISA_EXT_ZBA:
-	case KVM_RISCV_ISA_EXT_ZBB:
-	case KVM_RISCV_ISA_EXT_ZBC:
-	case KVM_RISCV_ISA_EXT_ZBKB:
-	case KVM_RISCV_ISA_EXT_ZBKC:
-	case KVM_RISCV_ISA_EXT_ZBKX:
-	case KVM_RISCV_ISA_EXT_ZBS:
-	case KVM_RISCV_ISA_EXT_ZCA:
-	case KVM_RISCV_ISA_EXT_ZCB:
-	case KVM_RISCV_ISA_EXT_ZCD:
-	case KVM_RISCV_ISA_EXT_ZCF:
-	case KVM_RISCV_ISA_EXT_ZCMOP:
-	case KVM_RISCV_ISA_EXT_ZFA:
-	case KVM_RISCV_ISA_EXT_ZFBFMIN:
-	case KVM_RISCV_ISA_EXT_ZFH:
-	case KVM_RISCV_ISA_EXT_ZFHMIN:
-	case KVM_RISCV_ISA_EXT_ZICBOP:
-	case KVM_RISCV_ISA_EXT_ZICCRSE:
-	case KVM_RISCV_ISA_EXT_ZICNTR:
-	case KVM_RISCV_ISA_EXT_ZICOND:
-	case KVM_RISCV_ISA_EXT_ZICSR:
-	case KVM_RISCV_ISA_EXT_ZIFENCEI:
-	case KVM_RISCV_ISA_EXT_ZIHINTNTL:
-	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
-	case KVM_RISCV_ISA_EXT_ZIHPM:
-	case KVM_RISCV_ISA_EXT_ZIMOP:
-	case KVM_RISCV_ISA_EXT_ZKND:
-	case KVM_RISCV_ISA_EXT_ZKNE:
-	case KVM_RISCV_ISA_EXT_ZKNH:
-	case KVM_RISCV_ISA_EXT_ZKR:
-	case KVM_RISCV_ISA_EXT_ZKSED:
-	case KVM_RISCV_ISA_EXT_ZKSH:
-	case KVM_RISCV_ISA_EXT_ZKT:
-	case KVM_RISCV_ISA_EXT_ZTSO:
-	case KVM_RISCV_ISA_EXT_ZVBB:
-	case KVM_RISCV_ISA_EXT_ZVBC:
-	case KVM_RISCV_ISA_EXT_ZVFBFMIN:
-	case KVM_RISCV_ISA_EXT_ZVFBFWMA:
-	case KVM_RISCV_ISA_EXT_ZVFH:
-	case KVM_RISCV_ISA_EXT_ZVFHMIN:
-	case KVM_RISCV_ISA_EXT_ZVKB:
-	case KVM_RISCV_ISA_EXT_ZVKG:
-	case KVM_RISCV_ISA_EXT_ZVKNED:
-	case KVM_RISCV_ISA_EXT_ZVKNHA:
-	case KVM_RISCV_ISA_EXT_ZVKNHB:
-	case KVM_RISCV_ISA_EXT_ZVKSED:
-	case KVM_RISCV_ISA_EXT_ZVKSH:
-	case KVM_RISCV_ISA_EXT_ZVKT:
-		return false;
-	/* Extensions which can be disabled using Smstateen */
-	case KVM_RISCV_ISA_EXT_SSAIA:
-		return riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN);
-	case KVM_RISCV_ISA_EXT_SVADE:
-		/*
-		 * The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero.
-		 * Svade can't be disabled unless we support Svadu.
-		 */
-		return arch_has_hw_pte_young();
-	default:
-		break;
-	}
-
-	return true;
-}
-
 void kvm_riscv_vcpu_setup_isa(struct kvm_vcpu *vcpu)
 {
 	unsigned long guest_ext, i;
 
-	for (i = 0; i < ARRAY_SIZE(kvm_isa_ext_arr); i++) {
+	for (i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
 		if (__kvm_riscv_isa_check_host(i, &guest_ext))
 			continue;
-		if (kvm_riscv_vcpu_isa_enable_allowed(i))
+		if (kvm_riscv_isa_enable_allowed(i))
 			set_bit(guest_ext, vcpu->arch.isa);
 	}
 }
@@ -361,15 +120,15 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
 		if (!vcpu->arch.ran_atleast_once) {
 			/* Ignore the enable/disable request for certain extensions */
 			for (i = 0; i < RISCV_ISA_EXT_BASE; i++) {
-				isa_ext = kvm_riscv_vcpu_base2isa_ext(i);
+				isa_ext = kvm_riscv_base2isa_ext(i);
 				if (isa_ext >= KVM_RISCV_ISA_EXT_MAX) {
 					reg_val &= ~BIT(i);
 					continue;
 				}
-				if (!kvm_riscv_vcpu_isa_enable_allowed(isa_ext))
+				if (!kvm_riscv_isa_enable_allowed(isa_ext))
 					if (reg_val & BIT(i))
 						reg_val &= ~BIT(i);
-				if (!kvm_riscv_vcpu_isa_disable_allowed(isa_ext))
+				if (!kvm_riscv_isa_disable_allowed(isa_ext))
 					if (!(reg_val & BIT(i)))
 						reg_val |= BIT(i);
 			}
@@ -693,10 +452,10 @@ static int riscv_vcpu_set_isa_ext_single(struct kvm_vcpu *vcpu,
 		 * extension can be disabled
 		 */
 		if (reg_val == 1 &&
-		    kvm_riscv_vcpu_isa_enable_allowed(reg_num))
+		    kvm_riscv_isa_enable_allowed(reg_num))
 			set_bit(guest_ext, vcpu->arch.isa);
 		else if (!reg_val &&
-			 kvm_riscv_vcpu_isa_disable_allowed(reg_num))
+			 kvm_riscv_isa_disable_allowed(reg_num))
 			clear_bit(guest_ext, vcpu->arch.isa);
 		else
 			return -EINVAL;
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 9759143c1785..5d37830c59b6 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -7,15 +7,16 @@
  */
 
 #define pr_fmt(fmt)	"riscv-kvm-pmu: " fmt
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
 #include <linux/perf/riscv_pmu.h>
 #include <asm/csr.h>
+#include <asm/kvm_isa.h>
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/kvm_vcpu_pmu.h>
 #include <asm/sbi.h>
-#include <linux/bitops.h>
 
 #define kvm_pmu_num_counters(pmu) ((pmu)->num_hw_ctrs + (pmu)->num_fw_ctrs)
 #define get_event_type(x) (((x) & SBI_PMU_EVENT_IDX_TYPE_MASK) >> 16)
diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index cac4f3a5f213..9817ff802821 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 #include <clocksource/timer-riscv.h>
 #include <asm/delay.h>
+#include <asm/kvm_isa.h>
 #include <asm/kvm_nacl.h>
 #include <asm/kvm_vcpu_timer.h>
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 8c7315a96b9e..a36e9e2c28df 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -12,6 +12,7 @@
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
 #include <asm/cpufeature.h>
+#include <asm/kvm_isa.h>
 #include <asm/kvm_vcpu_vector.h>
 #include <asm/vector.h>
 
-- 
2.43.0


