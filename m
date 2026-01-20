Return-Path: <linux-kselftest+bounces-49466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D12D3C241
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 922C55A4A10
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A93F076F;
	Tue, 20 Jan 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7McZPqh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01863EFD3C;
	Tue, 20 Jan 2026 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896100; cv=none; b=cBSz9QnO4idOFa/WSX2zwSW8fqd3q3lE0k7xeJirynKGnn3tTkY34PvypVd3OsDLh38O1JVYjdCYFZdt6kLbcNe8xrA7lJepAVc/jZMHEF7d0qElF1oZT1FVHLC5nWuSaaYC+z982ZSrLTfRGN3qVaT4HwVwfQbY0l7gOEBLHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896100; c=relaxed/simple;
	bh=HDoGEUUxPtRhpsVsLTe4I4uX6ZD/ZJkS/M2lXsYWTPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKP3UgxqoYFiskeeXzRPAdOKIJnB0ALnTNFQV9dAlA231TLnRGnNYkKh2p2RUP4b6+IghWX0225V/xBX1XKJsa4cRSwJ1KKp3WKCreMz9B+C0HFFqqk8RYd8kj8ELFiyBQ8s5SFe6LwrgsWjQoXoTYv7v0ZB4Vy4UDpXkpRH0Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7McZPqh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K33JkS3805148;
	Tue, 20 Jan 2026 08:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=k3qGz3Rblrc
	b9ISXBRSzABNxhdgMZw/6Mvr/NKKhNJg=; b=f7McZPqhKqMoo7xkpEMQvO4k+kl
	H60qdw7XHvxLnebKCPhT9/G222lDwJhvRQKTLslZ5b5Jxf1TO5hgTHcYYGzWjRTi
	4GK82cLEHiHsNYkgGyM0tnlPwLUs/J04IWyPC49aTgWVFHtu8S1/O8mpUTw+fAjZ
	oBkHTpch5/NKyg2EMOhwmOYCmhZzHs/3QYvM4S4Snyj/DfqmQL3Cz1iSlcTgVwiq
	KjeROZfn7E5zaOSRiL+A8WMWv62Oez349ikYW2/ozhndkTjhsqfZ66lqcCpK8BBy
	7OsLg0kqeMk+vh0T3mJqV0EuWCfLoMYNwHXeKkqVF0A2n4f8ktX+PrMQM5w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt1f88s3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80FXF007882;
	Tue, 20 Jan 2026 08:00:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80H7s008018;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80HsI008014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id D64C3255BA; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 20/27] RISC-V: KVM: Redirect nested WFI and WRS traps
Date: Tue, 20 Jan 2026 13:30:06 +0530
Message-ID: <20260120080013.2153519-21-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX4rqYEaBmBokw
 ISbTz1Lt5NvpfoOpasHR9mBkKYZxpTrfiIUy6Lrf8B5pPOGpc7AiXiCRVN2u2OsYway3vHigxAU
 6djDeim8HrOGJYppJR4IWf0h++7JBzD/6fU0q42ZYvDW+kUSj2BY0bZu8KDNOMek+VcApKbQS3Y
 Udwl5c9g9LkqfYzxWcrTCI38w1o3mL+1JCs3kVoNwEWBNuBdQjaDDSAQGC5Gojkri3BydGT55pf
 OcUJmiYQfsgC7bzcS9G6ERKCXYO2Aqd2gRLsqS146zsUkXiMGdCLJs/PXnWhGNt37xKliUBgm14
 +glLbQPYNPADlDiNrvfKz+oE+uYvSzBjnJUkou2FaRTWmk13GJItIOhrX69k3weptPVgVkyLWeg
 kyQ/R2Pdn8VeIaFJNgtyYJwlVh//UP0QdEebeEn4Acb4f0p88qRiuOYPkSz4DzhU2Rek3NV+Qay
 zRcXuxh6gTt0EqQUEyw==
X-Proofpoint-GUID: d8IJ7E8xQi7iPq3-DN5_WzGnVQS7vUMK
X-Proofpoint-ORIG-GUID: d8IJ7E8xQi7iPq3-DN5_WzGnVQS7vUMK
X-Authority-Analysis: v=2.4 cv=LdQxKzfi c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=UROabCUrXZ3gi7iQ-dkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

The WFI and WRS virtual instruction traps from Guest VS/VU-mode
(aka L2/nested guest) should be redirected to Guest HS-mode (aka
L1/guest hypervisor).

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/vcpu_insn.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 745cd654df94..ebd0cfc1bf30 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -76,6 +76,20 @@ void kvm_riscv_vcpu_wfi(struct kvm_vcpu *vcpu)
 
 static int wfi_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 {
+	/*
+	 * Trap from virtual-VS/VU modes should be forwarded to
+	 * virtual-HS mode as a virtual instruction trap.
+	 */
+	if (kvm_riscv_vcpu_nested_virt(vcpu))
+		return KVM_INSN_VIRTUAL_TRAP;
+
+	/*
+	 * Trap from virtual-U mode should be forwarded to
+	 * virtual-HS mode as illegal instruction trap.
+	 */
+	if (!(vcpu->arch.guest_context.hstatus & HSTATUS_SPVP))
+		return KVM_INSN_ILLEGAL_TRAP;
+
 	vcpu->stat.wfi_exit_stat++;
 	kvm_riscv_vcpu_wfi(vcpu);
 	return KVM_INSN_CONTINUE_NEXT_SEPC;
@@ -83,6 +97,20 @@ static int wfi_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 
 static int wrs_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 {
+	/*
+	 * Trap from virtual-VS/VU modes should be forwarded to
+	 * virtual-HS mode as a virtual instruction trap.
+	 */
+	if (kvm_riscv_vcpu_nested_virt(vcpu))
+		return KVM_INSN_VIRTUAL_TRAP;
+
+	/*
+	 * Trap from virtual-U mode should be forwarded to
+	 * virtual-HS mode as illegal instruction trap.
+	 */
+	if (!(vcpu->arch.guest_context.hstatus & HSTATUS_SPVP))
+		return KVM_INSN_ILLEGAL_TRAP;
+
 	vcpu->stat.wrs_exit_stat++;
 	kvm_vcpu_on_spin(vcpu, vcpu->arch.guest_context.sstatus & SR_SPP);
 	return KVM_INSN_CONTINUE_NEXT_SEPC;
-- 
2.43.0


