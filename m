Return-Path: <linux-kselftest+bounces-49452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8383D3C210
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7BE5893B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AE3DA7FA;
	Tue, 20 Jan 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kvpt8YLS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09243D7D7F;
	Tue, 20 Jan 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896046; cv=none; b=IjalCi64hneJb32rrlGv2dIPSy50IgJye3Qq1caK1/qmfx+AxWKRkJo0oEfkWAAN3ZqJfercrm9XJH2vqQ8W0SJuCH48e0xS4H6DxYU1MerpvOUCNDu4ZuYMTMzETsust3xQJC51PLi5cbH5LHPKbllxEwA0yPRMCJcTNJsnsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896046; c=relaxed/simple;
	bh=PCGndHbRQF5H5t9Opu5GiIbc1JBh+pV3A4QhhjB4scY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jczXArlsSrFATRAwoowj1iq7+h4q2/ewmnfTTGe5NaePHVv/uqovGIWgePodIpA9NoOeA4pylr1VbJfLyup52i9vcKGH3mnfkw/BJv+Ikv4/WHW8YQImSRvbSt+iZq6hiYgSjs7EF4yNKp81cPGU5gxgRArCxewSaj1rJl4n9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kvpt8YLS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K6D3Pu774067;
	Tue, 20 Jan 2026 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=esXaYSax2EA
	Ikw2Su+ePpoRTacWSAxDU18uVB39dYfQ=; b=kvpt8YLS/qeycvIuhFgLS0jADWF
	J3FOW+Xs03YNar6ssW5uZDRMtfW60wmu4pQ3BQPBgYzNVT918U4/BvzSRAEYC761
	JVEEqHFMUi0wqnFqRf8YKiQt1ygC6cGuOcMvug8AttKmywY5jkBAjScaOGo4IpEA
	mkPqlrucfDvB/RK1pscVvVS5Bu33DD/edBRPIJWUSIXsmq5Mhk/L4COjzzh+87kE
	xnlBb8+0b5FY1Akh/ffHNI6v+N3L8Hu7Zi14rP4zXIMyat0SIY3vOP6ZKDuRCNXL
	UfNDeXj2xZD/3sDMHoeBtVekqbCt75v01rNXHhYhOCT2Y2AvpT7etz0i5vw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsj9ab744-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80GKl007950;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Fax007833;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80HYc008010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id E896C255C7; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 25/27] RISC-V: KVM: selftests: Add nested virt state to get-reg-list test
Date: Tue, 20 Jan 2026 13:30:11 +0530
Message-ID: <20260120080013.2153519-26-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: jfjisKgTv3Rcb7Vy3etZYEBnEMc2_Pxp
X-Authority-Analysis: v=2.4 cv=N40k1m9B c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=yqHYUEKHaMYeqMlJOSMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX8tNBNjMAUcx8
 Wi165lsbMtOLYwGIpjq2R8cFql2gOXvtTQKgf6apBjYm2a509i2b0D9cWuCI/FgEm36W0lKKZ3N
 ZIp04SKkLOjFAEBPJWIMo+atJHcNvvqP1GwdPw2Lmuyy8L5nlJqbj4s+fY1sAgTorKX8IHeiXLf
 Gm9sjDp2vIMtfnmajMFPMvsa3yHtqs9IB1bR/EbTsGWlr+ADPxPpGfAOkC7f4iF+H+7sLZH5Gcu
 wGUF+VPvum1ju1q9PmUV+FXLFRFjjmQbYs0Qzw5l6diLhSTQtG4ypE6ywqczZ8rsRLAAMARKxGt
 G/FuO5/kMHzs5tZ8bM1MvbujtD5KsNRAu79SvnwLTZSMi8PpODooFaSk2om+XHpWshLUl9KnGWN
 gWGapwnDBna/G9cQyDypjxs3dov6ADjbsDIo0UPSkURgoxHFPHfdNghwWxNu8FsvODy0gYZAx1g
 Ukrk7B5iziaWpacuyYg==
X-Proofpoint-GUID: jfjisKgTv3Rcb7Vy3etZYEBnEMc2_Pxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The KVM RISC-V allows Guest/VM nested vitualization state to be
accessed via ONE_REG so add this to get-reg-list test.

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8d6b951434eb..53af7a453327 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -314,6 +314,8 @@ static const char *core_id_to_str(const char *prefix, __u64 id)
 			   reg_off - KVM_REG_RISCV_CORE_REG(regs.t3) + 3);
 	case KVM_REG_RISCV_CORE_REG(mode):
 		return "KVM_REG_RISCV_CORE_REG(mode)";
+	case KVM_REG_RISCV_CORE_REG(virt):
+		return "KVM_REG_RISCV_CORE_REG(virt)";
 	}
 
 	return strdup_printf("%lld /* UNKNOWN */", reg_off);
@@ -855,6 +857,7 @@ static __u64 base_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t5),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t6),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(mode),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(virt),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sstatus),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sie),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(stvec),
-- 
2.43.0


