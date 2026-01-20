Return-Path: <linux-kselftest+bounces-49456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D32D3C22E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0D244FBD53
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769093E9598;
	Tue, 20 Jan 2026 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLEDVYdo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FF3DA7CD;
	Tue, 20 Jan 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896048; cv=none; b=TgF9ytEMH2W9ITlc14cl2oJv0hNim4m9n0At09N5zKwF6SFX9T0S/VQwybknHLATpzeq1IOnLEGwE16mWCQKlqWv/7HKIRYGTZxYdFJZCMg2z4Edmt0qP6IFEe2Pdn4hbaeI91OE3yBTVheqUZXZPzVKZ0pXKa9FPwEN8EbBaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896048; c=relaxed/simple;
	bh=3fKtYCMra5MdC4giM/DlD0yvCQZY1/ynYgUxVQ1m2ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5X6TJCCJtjL14HjZHSBV5RLpyRgID3F3ocLmxZ8UtTJ/uGIrpGxooE3CJzahii5B00XMzw5/vD2diSXXK3rltxX/TZRn+Iqlb1dLhYRNCvU/8Tq1OGulvzqKxylfOnA/XMXhLkCu70+zuSw38XSq7DS1RfWOD8DP5AyjpC+Dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLEDVYdo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K18Uo53366428;
	Tue, 20 Jan 2026 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qI6wNHPUAM5
	kV1n4KodkogzZYXjOHHmvxwFuF+H/mNU=; b=GLEDVYdopU+rHz9Qn55XEC0I0t7
	EKianR2ONjjFuyLO2p/BGwvhpmS1UEaD7FOFGY2q8AEHABfoHoGcF8lOye7RC5ik
	uop8SeYxSXUUdpF+n1ZSFivPsr/12wdcUeB0aVQR7fZTYbA2mRVc2ymwXG0cTs6U
	tzbIS3rpez2LqUc9o+hRgNqetyo7XO5WfrrDON/vt7a8MIe2Fz+Xz6KnNUojibAx
	qLGVut1HzOJoOreRbLjnWXSvI9aN9vauDTmOMiNGU1RpT2aFRMMVUt4jkaOxh94U
	ih2nrW/nlIQgljbsaL5/fWuhHpefmwMheBCgVt5Ygo0xDTAQd0pEEFRzZYw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsysb11kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Fms007858;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80FZc007832;
	Tue, 20 Jan 2026 08:00:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80HHU008007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:17 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id D3101255B8; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
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
Subject: [PATCH 19/27] RISC-V: KVM: Redirect nested supervisor ecall and breakpoint traps
Date: Tue, 20 Jan 2026 13:30:05 +0530
Message-ID: <20260120080013.2153519-20-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-GUID: qAwbtOiHlOC7r_BIXwCYL-lBI9TlGOD0
X-Authority-Analysis: v=2.4 cv=XJ89iAhE c=1 sm=1 tr=0 ts=696f3615 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=e_FZhwwmXlOSAvXo2IMA:9
X-Proofpoint-ORIG-GUID: qAwbtOiHlOC7r_BIXwCYL-lBI9TlGOD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX32zTKRgHLzXw
 1Z05zNKr7gROMUr244TOpz6f74vJBbim2dgKY8+Nf+dd07q8H2jxx7CgnBEET0K3YzB1UHQfKz3
 uVQv5Xe2ScLIGDb1irgCjJLsEZ8gMSYtKpH+vZNJkyPFg4WtXQu3N0NqFKXA7SqLiEOqDJu6fPw
 7t/TNdjYVx/U4URTSJtnfrUtdW682jCWnV7nKKYkVlRJwbi5E5apGcQ8nYT0hsrMJAG5QiRAvu6
 gQC2fumEBa4zQrUMDhU0QiR3+25OY6ZEBLrGi+LU9qIxEBLdcw3GTlgPF76P53KO80hps7v/w2A
 xEJAourWMhwJkMQKOw/WnKdCXRz8ewN+nT2qTFIDOo9xYtr6FO31vitieYdZECkpwJ8e/6IjksY
 P7oOMseahCKH/xgf0/naXKY0HN43Q8qtPikE2E7nLiO+4RbOIWGny4zHGDMLoPXNPdr8hkY7Z7i
 4xLDVXORROufuhDngMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

The supervisor ecall and breakpoint traps from Guest VS/VU-mode
(aka L2/nested guest) should be redirected to Guest HS-mode (aka
L1/guest hypervisor).

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/vcpu_exit.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index aeec4c4eee06..6627c2c25a71 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -274,12 +274,18 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			ret = gstage_page_fault(vcpu, run, trap);
 		break;
 	case EXC_SUPERVISOR_SYSCALL:
-		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
+		if (kvm_riscv_vcpu_nested_virt(vcpu))
+			ret = vcpu_redirect(vcpu, trap);
+		else if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
 			ret = kvm_riscv_vcpu_sbi_ecall(vcpu, run);
 		break;
 	case EXC_BREAKPOINT:
-		run->exit_reason = KVM_EXIT_DEBUG;
-		ret = 0;
+		if (kvm_riscv_vcpu_nested_virt(vcpu)) {
+			ret = vcpu_redirect(vcpu, trap);
+		} else {
+			run->exit_reason = KVM_EXIT_DEBUG;
+			ret = 0;
+		}
 		break;
 	default:
 		break;
-- 
2.43.0


