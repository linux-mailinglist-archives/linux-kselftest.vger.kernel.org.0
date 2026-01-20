Return-Path: <linux-kselftest+bounces-49451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C825D3C216
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D519F580753
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340EF3DA7E3;
	Tue, 20 Jan 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tn83sPQ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837E3D6684;
	Tue, 20 Jan 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896045; cv=none; b=kHTSImeTMYwRAfkpKNAmgthXc8o84/gjkRnz09C7d4ZpOGuwvV4q4n/Z+A+k6LbXumNeo/S8pnljgVFENLm0QYRxY610e2HwcbpI0Yqio59wmj6+vo9FQLPH0MpGvWcDt/+05af3vG3q/IEZVihtTKFRWm6bcEkzbfWn1hPKZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896045; c=relaxed/simple;
	bh=eBpMBxruGbgF40h6bzfkptmfq/7SNuUv8SOYFXPuInk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaMcdnNVQIJxURmjY4mEnuETKOT+6JtCsF9rahBCakiuDjn922fhiq/O7e/+/Qy8f6qdLX8NnLURsqKQeLQqaFH3jOOvGcKXvfRFwlU3BRWz3s1HBu9c1xdO1dzp0Ozn9uZ9Vq86fUI30YfSHuxQyK+o/4SVhqtQkcSEVpF9bQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tn83sPQ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K6i30o428958;
	Tue, 20 Jan 2026 08:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KU8did4VXBp
	kNoW3wwE6ucF+QiiR7rYgBUo365iyrKY=; b=Tn83sPQ14Vesi4X4fyNreUe9wvy
	lr47xpiHqSXV3xJiyV4Rbv/UF8Yh1/8ib06dVwA7b8ykLkAJFkczBqJQy9WhcyQK
	KMfPqe9Tex8Wt+1A+CCBIzJ5z9lcdQMiz6TX29yo/PfLNx5vSl4goSKNucY7/DjH
	GRECVdwCeuiWmYiTagyrm1DpWGNKZxa2BbmwqCjpBSEmVE3Cu1zQ6KVo6sjUb1YC
	2u8IA5ejKrKkel4b7SEDrIauvWUNW4g4ydvHQ4DcWONNKAlhIUjWVDaxX0Tur3/s
	YjnCT0O5/1A6FGmtwcwrNBslWORecm9fZ50CjkgyG7s1yVT3zMP6+gTlYvg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4ps076b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80HnL008067;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Gqs007909;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80HBb008006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id CC69D25585; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 17/27] RISC-V: KVM: Extend kvm_riscv_isa_check_host() for nested virt
Date: Tue, 20 Jan 2026 13:30:03 +0530
Message-ID: <20260120080013.2153519-18-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: l5u5lEFmf-jH5jOVDXIG6vIm_8sdL45b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX/DJBCGyJHWBo
 MrMTgyEnmAQO4NXaSGteLSNk34Zw20GcKyGxtuyQOLGDWC+JLLea8z75Q/rwhTDi8C2Mr5YHpvO
 UwatjF33JYLn0sH7+qFOxNbYYTqFVjoqPx+aJdEXCoZfB9c0QRE8KHXG2TU4GVSJtHygWOFqx0A
 rSap5ebKKE9P7xB7AEfs04ParMY9Wgq4UiS/0UiParvU1bK3lNRijO7AvUG8gElHsRKmjVRJ+P4
 v/rfWva3XylTHbI38XYoklbB46vpYCMGcMJeMr4WKHRYKdW4jFKJvrXLtpd7oJsRoEV76jtWCrp
 9n4We+cNBGJvtcd6uqG0rWk9GDfs0sRsME+wBsnORXJDvuQG/XH8Woi9rm09yrv374TIfE1sre6
 Igf0KtawJZzkiC2vtNDHVkZER6bttozy+yJGs99U1+wQM1E9QMrFAgQjsTKn5yf4DTB35Qu2WeF
 qwoqLj+J1OoBBPf3CjQ==
X-Authority-Analysis: v=2.4 cv=PdfyRyhd c=1 sm=1 tr=0 ts=696f3614 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=IcsGow7upkUQ9H4TgUEA:9
X-Proofpoint-GUID: l5u5lEFmf-jH5jOVDXIG6vIm_8sdL45b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

Nested virtualization for various ISA extensions will be enabled
gradually so extend kvm_riscv_isa_check_host() such that certain
ISA extensions can be disabled when nested virtualization is
available.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/isa.c | 178 ++++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 85 deletions(-)

diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
index 1566d01fc52e..e469c350f5bb 100644
--- a/arch/riscv/kvm/isa.c
+++ b/arch/riscv/kvm/isa.c
@@ -10,91 +10,96 @@
 #include <asm/kvm_isa.h>
 #include <asm/vector.h>
 
-#define KVM_ISA_EXT_ARR(ext)		\
-[KVM_RISCV_ISA_EXT_##ext] = RISCV_ISA_EXT_##ext
+struct kvm_isa_ext {
+	unsigned long ext;
+	bool nested;
+};
+
+#define KVM_ISA_EXT_ARR(ext, nested)		\
+[KVM_RISCV_ISA_EXT_##ext] = { RISCV_ISA_EXT_##ext, nested }
 
 /* Mapping between KVM ISA Extension ID & guest ISA extension ID */
-static const unsigned long kvm_isa_ext_arr[] = {
+static const struct kvm_isa_ext kvm_isa_ext_arr[] = {
 	/* Single letter extensions (alphabetically sorted) */
-	[KVM_RISCV_ISA_EXT_A] = RISCV_ISA_EXT_a,
-	[KVM_RISCV_ISA_EXT_C] = RISCV_ISA_EXT_c,
-	[KVM_RISCV_ISA_EXT_D] = RISCV_ISA_EXT_d,
-	[KVM_RISCV_ISA_EXT_F] = RISCV_ISA_EXT_f,
-	[KVM_RISCV_ISA_EXT_H] = RISCV_ISA_EXT_h,
-	[KVM_RISCV_ISA_EXT_I] = RISCV_ISA_EXT_i,
-	[KVM_RISCV_ISA_EXT_M] = RISCV_ISA_EXT_m,
-	[KVM_RISCV_ISA_EXT_V] = RISCV_ISA_EXT_v,
+	[KVM_RISCV_ISA_EXT_A] = { RISCV_ISA_EXT_a, true },
+	[KVM_RISCV_ISA_EXT_C] = { RISCV_ISA_EXT_c, true },
+	[KVM_RISCV_ISA_EXT_D] = { RISCV_ISA_EXT_d, true },
+	[KVM_RISCV_ISA_EXT_F] = { RISCV_ISA_EXT_f, true },
+	[KVM_RISCV_ISA_EXT_H] = { RISCV_ISA_EXT_h, true },
+	[KVM_RISCV_ISA_EXT_I] = { RISCV_ISA_EXT_i, true },
+	[KVM_RISCV_ISA_EXT_M] = { RISCV_ISA_EXT_m, true },
+	[KVM_RISCV_ISA_EXT_V] = { RISCV_ISA_EXT_v, true },
 	/* Multi letter extensions (alphabetically sorted) */
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
+	KVM_ISA_EXT_ARR(SMNPM, false),
+	KVM_ISA_EXT_ARR(SMSTATEEN, false),
+	KVM_ISA_EXT_ARR(SSAIA, false),
+	KVM_ISA_EXT_ARR(SSCOFPMF, false),
+	KVM_ISA_EXT_ARR(SSNPM, false),
+	KVM_ISA_EXT_ARR(SSTC, false),
+	KVM_ISA_EXT_ARR(SVADE, true),
+	KVM_ISA_EXT_ARR(SVADU, true),
+	KVM_ISA_EXT_ARR(SVINVAL, false),
+	KVM_ISA_EXT_ARR(SVNAPOT, false),
+	KVM_ISA_EXT_ARR(SVPBMT, false),
+	KVM_ISA_EXT_ARR(SVVPTC, true),
+	KVM_ISA_EXT_ARR(ZAAMO, true),
+	KVM_ISA_EXT_ARR(ZABHA, true),
+	KVM_ISA_EXT_ARR(ZACAS, true),
+	KVM_ISA_EXT_ARR(ZALASR, true),
+	KVM_ISA_EXT_ARR(ZALRSC, true),
+	KVM_ISA_EXT_ARR(ZAWRS, false),
+	KVM_ISA_EXT_ARR(ZBA, true),
+	KVM_ISA_EXT_ARR(ZBB, true),
+	KVM_ISA_EXT_ARR(ZBC, true),
+	KVM_ISA_EXT_ARR(ZBKB, true),
+	KVM_ISA_EXT_ARR(ZBKC, true),
+	KVM_ISA_EXT_ARR(ZBKX, true),
+	KVM_ISA_EXT_ARR(ZBS, true),
+	KVM_ISA_EXT_ARR(ZCA, true),
+	KVM_ISA_EXT_ARR(ZCB, true),
+	KVM_ISA_EXT_ARR(ZCD, true),
+	KVM_ISA_EXT_ARR(ZCF, true),
+	KVM_ISA_EXT_ARR(ZCLSD, true),
+	KVM_ISA_EXT_ARR(ZCMOP, true),
+	KVM_ISA_EXT_ARR(ZFA, true),
+	KVM_ISA_EXT_ARR(ZFBFMIN, true),
+	KVM_ISA_EXT_ARR(ZFH, true),
+	KVM_ISA_EXT_ARR(ZFHMIN, true),
+	KVM_ISA_EXT_ARR(ZICBOM, false),
+	KVM_ISA_EXT_ARR(ZICBOP, false),
+	KVM_ISA_EXT_ARR(ZICBOZ, false),
+	KVM_ISA_EXT_ARR(ZICCRSE, true),
+	KVM_ISA_EXT_ARR(ZICNTR, true),
+	KVM_ISA_EXT_ARR(ZICOND, true),
+	KVM_ISA_EXT_ARR(ZICSR, true),
+	KVM_ISA_EXT_ARR(ZIFENCEI, true),
+	KVM_ISA_EXT_ARR(ZIHINTNTL, true),
+	KVM_ISA_EXT_ARR(ZIHINTPAUSE, true),
+	KVM_ISA_EXT_ARR(ZIHPM, true),
+	KVM_ISA_EXT_ARR(ZILSD, true),
+	KVM_ISA_EXT_ARR(ZIMOP, true),
+	KVM_ISA_EXT_ARR(ZKND, true),
+	KVM_ISA_EXT_ARR(ZKNE, true),
+	KVM_ISA_EXT_ARR(ZKNH, true),
+	KVM_ISA_EXT_ARR(ZKR, true),
+	KVM_ISA_EXT_ARR(ZKSED, true),
+	KVM_ISA_EXT_ARR(ZKSH, true),
+	KVM_ISA_EXT_ARR(ZKT, true),
+	KVM_ISA_EXT_ARR(ZTSO, true),
+	KVM_ISA_EXT_ARR(ZVBB, true),
+	KVM_ISA_EXT_ARR(ZVBC, true),
+	KVM_ISA_EXT_ARR(ZVFBFMIN, true),
+	KVM_ISA_EXT_ARR(ZVFBFWMA, true),
+	KVM_ISA_EXT_ARR(ZVFH, true),
+	KVM_ISA_EXT_ARR(ZVFHMIN, true),
+	KVM_ISA_EXT_ARR(ZVKB, true),
+	KVM_ISA_EXT_ARR(ZVKG, true),
+	KVM_ISA_EXT_ARR(ZVKNED, true),
+	KVM_ISA_EXT_ARR(ZVKNHA, true),
+	KVM_ISA_EXT_ARR(ZVKNHB, true),
+	KVM_ISA_EXT_ARR(ZVKSED, true),
+	KVM_ISA_EXT_ARR(ZVKSH, true),
+	KVM_ISA_EXT_ARR(ZVKT, true),
 };
 
 unsigned long kvm_riscv_base2isa_ext(unsigned long base_ext)
@@ -102,7 +107,7 @@ unsigned long kvm_riscv_base2isa_ext(unsigned long base_ext)
 	unsigned long i;
 
 	for (i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
-		if (kvm_isa_ext_arr[i] == base_ext)
+		if (kvm_isa_ext_arr[i].ext == base_ext)
 			return i;
 	}
 
@@ -117,7 +122,10 @@ int __kvm_riscv_isa_check_host(unsigned long ext, unsigned long *base_ext)
 	    ext >= ARRAY_SIZE(kvm_isa_ext_arr))
 		return -ENOENT;
 
-	switch (kvm_isa_ext_arr[ext]) {
+	if (kvm_riscv_nested_available() && !kvm_isa_ext_arr[ext].nested)
+		return -ENOENT;
+
+	switch (kvm_isa_ext_arr[ext].ext) {
 	case RISCV_ISA_EXT_SMNPM:
 		/*
 		 * Pointer masking effective in (H)S-mode is provided by the
@@ -128,7 +136,7 @@ int __kvm_riscv_isa_check_host(unsigned long ext, unsigned long *base_ext)
 		host_ext = RISCV_ISA_EXT_SSNPM;
 		break;
 	default:
-		host_ext = kvm_isa_ext_arr[ext];
+		host_ext = kvm_isa_ext_arr[ext].ext;
 		break;
 	}
 
@@ -136,7 +144,7 @@ int __kvm_riscv_isa_check_host(unsigned long ext, unsigned long *base_ext)
 		return -ENOENT;
 
 	if (base_ext)
-		*base_ext = kvm_isa_ext_arr[ext];
+		*base_ext = kvm_isa_ext_arr[ext].ext;
 
 	return 0;
 }
-- 
2.43.0


