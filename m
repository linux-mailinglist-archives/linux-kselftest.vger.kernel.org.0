Return-Path: <linux-kselftest+bounces-49468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C14B2D3C21B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 749C2488739
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A941E407578;
	Tue, 20 Jan 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nfKD9Axj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9C3EFD3C;
	Tue, 20 Jan 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896106; cv=none; b=lvLSmpUpFFJCQUMgSDvrKblt/zxpNTacdYYvYES7uSjp6P7OYZmgNwwyTJ/shCV5nomJU2+wqtOc2I5iIKLHy6g15y/BYwgWL3wKSEebqNdh4OkUv7RTAVrupp4QQd6qtRU3FdB/NqT4EeVKQfPlG/rxTWm6SY8HCxg7EjA3MeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896106; c=relaxed/simple;
	bh=qRHT3Bwd/tFKV09+THFmxlg618zx/62x6LXtz/hYopA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy5R5OERXw0m74mqgXQRUlHv6ikfUarRM66y+ZeD4+gzflRxxW9dyAWhjnRnK1I90rD8Y3VtA9xDOlF6ljYrCkiKpxVV6lXBl0IPxSbG/XAqcTcyC+8c+1/frO7ZXQo2MD5MsmFZeQirzcFcGvqhX47iBAsK7t1Mpy8T75oC2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nfKD9Axj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K6i5tL428970;
	Tue, 20 Jan 2026 08:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=clkTiWO3w3L
	dqdEoz1Y9Sfhoe+F8p1H6M58Cqy8+GKQ=; b=nfKD9Axj3bDIN6sI8wiANvtKIFJ
	SP8zNMp5zQzsCRBvK2NIbRByuHFjTPBlROyCtvqbRwOUbaIqcpKIYbfKFxecF5bi
	tYCYoyvo2PXQtKDMs5fub5f60yrDSOvSmgu7NzK61My0YA24bD+5SIA9Nl4oRbkX
	UBvvckMysJETTXijnA7XU7ekz/Y7kVqtFPMcHMGoBWzwGDGZkiDOrs0diVIrnN4y
	Hx1OeK49UqgyBTZY85PZsjiUWTM+6BfgZg45yJ0EL9cW/6tPNQopCRYp+b0XuC4e
	2XXGQqxZVPjA1UcB54/ztwasYNcsowiJwp1VrmJToK2FxRmMZX5TxYOwyaA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4ps0760-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Fmp007858;
	Tue, 20 Jan 2026 08:00:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Fid007830;
	Tue, 20 Jan 2026 08:00:15 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80FM3007827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:15 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 9C35E22E55; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 03/27] RISC-V: KVM: Check host Ssaia extension when creating AIA irqchip
Date: Tue, 20 Jan 2026 13:29:49 +0530
Message-ID: <20260120080013.2153519-4-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: wv0PW4tQO34BjBtgqhOrlWBGOWveZafC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX8SmRcLR88iyw
 wA45dWqYtmxZsfLRRwWJg90p3EhhHV9gypFgS8jvwzSNhbLQUb1ww5+wESysoDty9Aiy5LzBP1w
 YK0mhWsmOF2GvqEUHHz2UPQV7AnPQtoVz+NfcM0oBUhuJzkeAaudjD7B43kweAlhfvmHwmL4j9y
 FOQ0KhDc4tK7NTsk2wpwTZcveZ+tKylpEHMayX+GKkZHDTp3mMegFxS82XrFUE3jovQssaMQyK1
 XKIAeI74RsO7px11cYzvIIsaLihLZr5BGnYFTfJ7WoTHuNcQmIVW2rYRwFDjNpOzdY0bdPC1yZ/
 9kHjPgf8hWbmFLaes03nDIET4aSNpjchU2X/gelzErQ4YhZhYHlHd2oiuIuO330zNOMJhESu6/W
 uCygplKSqTDZsCQTv0ku9a9a7Y0roOBdKecAC9qq1H3LknLvSbusXvCB2si3OPhUD4h4ohSH7RF
 c/yl6n6lDptlOgElR4Q==
X-Authority-Analysis: v=2.4 cv=PdfyRyhd c=1 sm=1 tr=0 ts=696f3612 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=au0ipJX4zbpoNYeZlWMA:9
X-Proofpoint-GUID: wv0PW4tQO34BjBtgqhOrlWBGOWveZafC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

The KVM user-space may create KVM AIA irqchip before checking
VCPU Ssaia extension availability so KVM AIA irqchip must fail
when host does not have Ssaia extension.

Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irqchip")
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/aia_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index b195a93add1c..bed4d2c8c44c 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -11,6 +11,7 @@
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
+#include <linux/cpufeature.h>
 
 static int aia_create(struct kvm_device *dev, u32 type)
 {
@@ -22,6 +23,9 @@ static int aia_create(struct kvm_device *dev, u32 type)
 	if (irqchip_in_kernel(kvm))
 		return -EEXIST;
 
+	if (!riscv_isa_extension_available(NULL, SSAIA))
+		return -ENODEV;
+
 	ret = -EBUSY;
 	if (kvm_trylock_all_vcpus(kvm))
 		return ret;
-- 
2.43.0


