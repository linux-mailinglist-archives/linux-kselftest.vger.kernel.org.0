Return-Path: <linux-kselftest+bounces-49464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22FD3C1FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78D12486517
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F33F074B;
	Tue, 20 Jan 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0aUWJXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1E3EFD36;
	Tue, 20 Jan 2026 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896099; cv=none; b=Bi+vTiVZygugQzSbbfZ+VeH0P59kaNCkTI5GLbOh6HaIzGFJW+neV71+BEfsb9fW6UY/DTnOJRSmwl/8P7TcBy6nuvJ37FEykO/9y6urVkxmpo3RYV2Obev5qcDxPJlzRe9JShSZ6niibCIpwNhtL5oPQq1Pe6lILrQQGle52k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896099; c=relaxed/simple;
	bh=YSvtfkLWCQaLegLAqsZzbM9D9UMUrjfCxPfvchg1Ncs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqYUZd4aXdVGmjfIbX+H7LencQ2DxiGDG87Ao9PLXombAvNM1M4ah3h5ZqScEIwUftf+xg4riIoSqXQ7LBTj2Nh9pB6ifdqgX+sxXoIT12gCl6lq0GAnLNyMpvVdmAc6CANTf9f9yxc8+lpwM0fvxuubww66nCS9SMQDNrh9anQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0aUWJXL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K341Fd3808948;
	Tue, 20 Jan 2026 08:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wRexMEpQkzq
	WKlM9nEAeBfg4ZM2Tv2hbPeIIaNjzgsc=; b=E0aUWJXLgwmDX1/SzIYS02Lw4a8
	TLWyuc4nABRb7pIBjb1Yk4Hi8gluWKCztpcIXVb4wZc44FkiyneqZC1G5gnfhzSV
	MfcFBhZPWd+AbDtTRaqhXFU/jInLxwVvjXazyD+f75FTHW5XY5vUV5Lcr6LVu1aZ
	E/r+ifYdOnS0U94ZdK1LFts6b9a5CD7R2tbjznF9HZayY+1uNaFMwWrMq9OoDu27
	tgBczJhDQkGCu8MgWR4+x5uxiNElZ7YOyEGjJ3cyzEDFuV5Ju53mJiBNC4DjzGUn
	ZaI4tUqnp3diBIC21h1TUfyLZPqhjtO0lILyQTFnW548fQuena2nJQGuISw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt1f88s3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80FK3007860;
	Tue, 20 Jan 2026 08:00:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80FQO007831;
	Tue, 20 Jan 2026 08:00:15 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80FkG007824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:15 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 98EB922C26; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 02/27] RISC-V: KVM: Fix error code returned for Ssaia ONE_REG
Date: Tue, 20 Jan 2026 13:29:48 +0530
Message-ID: <20260120080013.2153519-3-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfXxEKujc5OFdDq
 FVH6jhav7K0hEWytF9jITbTJza+fKkqdBVf/awY0OAphcVsoR7oEcZYSnj3s2cwJeqJwhv5Y0b0
 2bjunb4VPeEol7kYerJ9lbO2h5tr514Zt/B06u87EbZiojb6geY2Objn7Ks9ZfxbuPqMM2oy38W
 GVucTc8GN8l/4sdthL1nzpmM73cxHgOe6J6pfgOMiLvKcJ7+s6IYhaNk3WEsh9eVVx+DPp+RGlH
 BIO7ye2y6fXaMnZcscR5OCDFCUtI3XBH8WhZzVr0BqhFZUhefuPPBRqZNWnJkuOoFj8dDREVT92
 IEyGfVAcDaI5Upih6v4+I2A8eziBkZAigh+MDIFKuCEQamWa+zDDiqmpF6U8q8ny9oSUv+XFZB+
 En/qfSr81NOq29CNzt1VxlCNY5flqCTrms+kWo64C1wXjO1nJ+ZvEFvczq5UN8/Urfim2QdmbJK
 AByYS9ZYZCZERgCDeYA==
X-Proofpoint-GUID: XO-LWzVym6x4vct65yqZWddQUdLfyh-6
X-Proofpoint-ORIG-GUID: XO-LWzVym6x4vct65yqZWddQUdLfyh-6
X-Authority-Analysis: v=2.4 cv=LdQxKzfi c=1 sm=1 tr=0 ts=696f3612 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=_CP9wF37UZ2j3KDzhjgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065

Return -ENOENT for Ssaia ONE_REG when Ssaia is not enabled
for a VCPU.

This will make Ssaia ONE_REG error codes consistent with
other ONE_REG interfaces of KVM RISC-V.

Fixes: 2a88f38cd58d ("RISC-V: KVM: return ENOENT in *_one_reg() when reg is unknown")
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/aia.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index dad318185660..31baea9f0589 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -183,6 +183,8 @@ int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
+	if (!riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
+		return -ENOENT;
 	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long))
 		return -ENOENT;
 
@@ -199,6 +201,8 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
+	if (!riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
+		return -ENOENT;
 	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long))
 		return -ENOENT;
 
-- 
2.43.0


