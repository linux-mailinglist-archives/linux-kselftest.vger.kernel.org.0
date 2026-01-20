Return-Path: <linux-kselftest+bounces-49458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C2D3C1C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D28A55C1E75
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE813ED10F;
	Tue, 20 Jan 2026 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KPaTeKku"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D13DA7E6;
	Tue, 20 Jan 2026 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896052; cv=none; b=CzutOuN5y3NjIGUJyphbRn5tTFpPLCeo7wD3R0xQkhEjgCpL6y/aVWb7nxDxBK8cG05/86iOk6no2q7VTOjH+ir8i2n3IqDwYULHiF5Bp3aqUNhz+gGOz9QRGFVD1P0HHGbQzBuDSXkfLeA1z0PnP1CN8FLsEBlXV47Tbw68Gb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896052; c=relaxed/simple;
	bh=WEFkU71b46e12Bd3hZTi7CXh7Xhz03EAyNq5taOVm7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC3jus7adgF5BwvsX5hkXffC0gDUZG+/y4ytnmCGtdBpbxPi10pYFFmlhnG1KksNOOBd9Sv/AKIibZ1HZfYfUGP88CiXxEBLM3GVExQgfgSjX6d0veiMd8JoIP5cgycFdApI+nPml59AW8P/nNmOFl4WX9gMlCYAXtarN4PKexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KPaTeKku; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K33JkR3805148;
	Tue, 20 Jan 2026 08:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L6D8Q/qpBkH
	ZrHRSr2hQZStPOkorX05cYWshdwfWV/0=; b=KPaTeKkuojHsO53sjm6LoIWtaG2
	CLa+xPt91fL8X7w7OxHzoVKLEin+lLE1tsQeNRxeJoKQuqEWGo0F3X0sNBJXAxUa
	xD5AW7/QA2qcDZPQ1peQE3hi45XNnjraDFG7U36wRgy5oFl34r5hJfB/WqRjnFUB
	FkdMz2BVXRs3qHknQumIRGx3oybnQMI+ng40IWmgDHBQIOcA58CAdOIuVfevmSdM
	c3ZHypiby1gH+4TAk/vBUWd1a5DqaDce7sRVXZOHyeHF0+DXwyz5bZuWo9xq7Slj
	0CMdEXTAqWKhnc3BMhMnATONDfUzUnwk8UY6D2VkbprP1rJKqCilGLWqKLw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt1f88s3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Grh007970;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80GHN007913;
	Tue, 20 Jan 2026 08:00:16 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80Gss007892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:16 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id C207325577; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 14/27] RISC-V: KVM: Extend kvm_riscv_vcpu_update_timedelta() for nested virt
Date: Tue, 20 Jan 2026 13:30:00 +0530
Message-ID: <20260120080013.2153519-15-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX7mzwrHLk2RzX
 jG+UTSeABLqs3nocBTdnhTpWRfIcrEDS0GJAG7oTXiZ0XIOq1AyG9AhZEGjD3fIyEm8eEVVFWpG
 jlAPfSIkhbLr747vAslPfcjP3MXxVaemyRzYSb5KCRy2uXEnfFN9z6vhI0Uy3F+lJtjSMd4IeZX
 NI6suI+/SLS8VcsUh+bdHL+iD90tc90nA6Qu0CcpoJw+AEMS9mK8HzbLN+AQymIKXAqtzq4LXNU
 /1FgxxHHa9c9rUZZje7HGXVXqVfv5s0oNZrALtTMxLKkWrp1tbdbDTr+slbLlu1FliOHviKALcY
 kMZiagOLNMn6NNaSF0xIlNLXixx31VERCsN/zATu0fhza+yNc8iojV3wbGuBX9NCsnK0PB1xw6J
 yrUwyoa7aoyYX9xgQUvVLGxY3P6jjc/bG/WsidLN0ArThxtg9EjBTpOvpRYpucGdHUjlsgVM92n
 +bwWOAnqi+9WXUo5OZg==
X-Proofpoint-GUID: fTIY7cgydlf5VyitxbuTJkk2Y1FSMuol
X-Proofpoint-ORIG-GUID: fTIY7cgydlf5VyitxbuTJkk2Y1FSMuol
X-Authority-Analysis: v=2.4 cv=LdQxKzfi c=1 sm=1 tr=0 ts=696f3614 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=hMel4s6c26khOlIOFZAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

The kvm_riscv_vcpu_update_timedelta() will be also used for when
switching between guest HS-mode and guest VS/VU-mode so extend
it accordingly.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_vcpu_timer.h |  1 +
 arch/riscv/kvm/vcpu_timer.c             | 21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_timer.h b/arch/riscv/include/asm/kvm_vcpu_timer.h
index 82f7260301da..f97cf1d7d760 100644
--- a/arch/riscv/include/asm/kvm_vcpu_timer.h
+++ b/arch/riscv/include/asm/kvm_vcpu_timer.h
@@ -43,6 +43,7 @@ int kvm_riscv_vcpu_set_reg_timer(struct kvm_vcpu *vcpu,
 int kvm_riscv_vcpu_timer_init(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_timer_deinit(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_timer_reset(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_update_timedelta(struct kvm_vcpu *vcpu, bool nested_virt);
 void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu);
 void kvm_riscv_guest_timer_init(struct kvm *kvm);
 void kvm_riscv_vcpu_timer_sync(struct kvm_vcpu *vcpu);
diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index 9817ff802821..eda530228b05 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -287,15 +287,26 @@ int kvm_riscv_vcpu_timer_reset(struct kvm_vcpu *vcpu)
 	return kvm_riscv_vcpu_timer_cancel(&vcpu->arch.timer);
 }
 
-static void kvm_riscv_vcpu_update_timedelta(struct kvm_vcpu *vcpu)
+void kvm_riscv_vcpu_update_timedelta(struct kvm_vcpu *vcpu, bool nested_virt)
 {
+	struct kvm_vcpu_nested_csr *nsc = &vcpu->arch.nested.csr;
 	struct kvm_guest_timer *gt = &vcpu->kvm->arch.timer;
+	u64 ndelta = 0;
 
+	if (nested_virt) {
+		ndelta = nsc->htimedelta;
 #if defined(CONFIG_32BIT)
-	ncsr_write(CSR_HTIMEDELTA, (u32)(gt->time_delta));
-	ncsr_write(CSR_HTIMEDELTAH, (u32)(gt->time_delta >> 32));
+		ndelta |= ((u64)nsc->htimedeltah) << 32;
+#endif
+	}
+
+	ndelta += gt->time_delta;
+
+#if defined(CONFIG_32BIT)
+	ncsr_write(CSR_HTIMEDELTA, (u32)ndelta);
+	ncsr_write(CSR_HTIMEDELTAH, (u32)(ndelta >> 32));
 #else
-	ncsr_write(CSR_HTIMEDELTA, gt->time_delta);
+	ncsr_write(CSR_HTIMEDELTA, ndelta);
 #endif
 }
 
@@ -303,7 +314,7 @@ void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_timer *t = &vcpu->arch.timer;
 
-	kvm_riscv_vcpu_update_timedelta(vcpu);
+	kvm_riscv_vcpu_update_timedelta(vcpu, kvm_riscv_vcpu_nested_virt(vcpu));
 
 	if (!t->sstc_enabled)
 		return;
-- 
2.43.0


