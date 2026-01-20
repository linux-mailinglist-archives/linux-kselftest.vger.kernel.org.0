Return-Path: <linux-kselftest+bounces-49455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B677ED3C1DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BF615A2C73
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542533E8C61;
	Tue, 20 Jan 2026 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nEdwJW87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482E3D7D8F;
	Tue, 20 Jan 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896047; cv=none; b=KyYP8RRrnefESJa7vmYblHaLLKXKzpuZbSQP5m4e96h9EXMg7mpNK3zUqmR4twXBtXwGiIpgBTV+CB2yP8ZbAV+IIJLbUqXnHimB8O8FstM4RoEDO6FOmi5WTMLySyLFKCNdiYgixZZuYVcZTjNWl3L2qSomyFlT5Lt1OjpRlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896047; c=relaxed/simple;
	bh=o1JTCfXHpCnSwp9BgXcxfhsrA+JQY7YGZLt5B8bVDNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqCaFjOXHagN5+imya1mo/FnqDJyv1xOYgxOVUD3vowAfDlCeGjsNpNPSMEBUaqdIp5NLgKfS8nV/xM0UoxNob5bbTs1FnKbrN5SYG+KEC+DukV+CP2iOGP4tLd/fM8fdAidunuh7qvMIpNK6VtILuC4YUJ0jb8x4IqTp/HmdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nEdwJW87; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K5dHvq774045;
	Tue, 20 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=T6Ez3auc9ue
	xU0ztDJfjojD1To7INeoURgJTkVoDe80=; b=nEdwJW87Dn3at7qarIsoXj7GFG5
	bAoI6cCap4uSNhqKs7zXNOFhJJJ8QsW/S+4aBSrCC1Bmsfp0JNAxn81nCIrNheZu
	nXNngI7wRDLpS7Nb+SeJBDP6gXq3kWIQFVKObQ6o5Tc0hu+h7Yx/4nmQAlKpsakI
	sDWpMlZq/2+QwWtf1+qG8MAWuq2kAP4C0kK761UhrnO0gKqQsdrlsbaaowfcsHK8
	dErqMNqncuwuPYoI6wc0xW5Cj6gCgagxqq12C5hDt4PmKe7WzZdvOubD2uHmnn3Q
	m/H3XzStRJBZYHZbkVPcv7W/nmKH4xD1pcDfHRKJwvj9qdsJX7sbgI5UXYw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsj9ab742-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Gjm007953;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80GTG007912;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80GWo007895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id A6E5A2357F; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 06/27] RISC-V: KVM: Move timer state defines closer to struct in UAPI header
Date: Tue, 20 Jan 2026 13:29:52 +0530
Message-ID: <20260120080013.2153519-7-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 0tnOb3vpKejYEJZVmkCAg62gljMbCZS9
X-Authority-Analysis: v=2.4 cv=N40k1m9B c=1 sm=1 tr=0 ts=696f3614 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=dDnfVlE4-D7SnBb_pXQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX/J9pMM/gsq/B
 wCUL6IzDRdd1Yr4Gwu6A6JkrrxcgqHXqTObcHp7e3M0kpUT7wzUq+/k8/jryWL7HhbNrWS2dJJK
 i9k2M+HGfob/DqRMZykVi4oxzNSsiZeG34lM7cwWtALrWeZ4/wubddZgFCRf+L4lqzzgVs98QJl
 NoHpazyRSePkKXfqgucn8n4sKzb2LVouRxcrxjcGuLeZh7gZEmattaLaf0vSiTInHYxx6/p3OYg
 3VhHlWDAaq8zYF7yXixiqpQ8eSkXQ4Xi7iiqu/PYjL9GjWlRz9Z7ItodMaKkUD+ahbMJGO66En5
 lT8KVlzq5wfesxK08gLNaVjaV64CKCpvpo2F8eBtUm8+uAydP7RY1n9ChzNnOettJNQ6jOJW0nK
 cWjd9LiMxR4G5NYkT6idGu3M1i1ummo5eUW3EBIVr3faV1TeNlz84MbBR80aQXEh/n0/eoesuOn
 HHbeHsS5FL4r9L7Vnrw==
X-Proofpoint-GUID: 0tnOb3vpKejYEJZVmkCAg62gljMbCZS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The KVM_RISCV_TIMER_STATE_xyz defines specify possible values of the
"state" member in struct kvm_riscv_timer so move these defines closer
to struct kvm_riscv_timer in uapi/asm/kvm.h.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 6a89c1d00a72..504e73305343 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -110,6 +110,10 @@ struct kvm_riscv_timer {
 	__u64 state;
 };
 
+/* Possible states for kvm_riscv_timer */
+#define KVM_RISCV_TIMER_STATE_OFF	0
+#define KVM_RISCV_TIMER_STATE_ON	1
+
 /*
  * ISA extension IDs specific to KVM. This is not the same as the host ISA
  * extension IDs as that is internal to the host and should not be exposed
@@ -238,10 +242,6 @@ struct kvm_riscv_sbi_fwft {
 	struct kvm_riscv_sbi_fwft_feature pointer_masking;
 };
 
-/* Possible states for kvm_riscv_timer */
-#define KVM_RISCV_TIMER_STATE_OFF	0
-#define KVM_RISCV_TIMER_STATE_ON	1
-
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_RISCV_TYPE_MASK		0x00000000FF000000
 #define KVM_REG_RISCV_TYPE_SHIFT	24
-- 
2.43.0


