Return-Path: <linux-kselftest+bounces-5076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B830785C763
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 22:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4A81C21DDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 21:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA1C76C9C;
	Tue, 20 Feb 2024 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tFrPDZ6e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC9151CC8;
	Tue, 20 Feb 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463545; cv=none; b=YpQwYH9SjhKcMX1VgvQQKxQcYs+c9+8A3Pi+lEqy0ZO1wvQsgt41742DEYs0RGdx6IpCVnPN052E+8/bixc0HG30LdxosxaEKihL+OZeFp39ahkCufZUyFNnHe119w0Bl1vKCy7t8aN80qd4yEu+aujU9FN2m2zK6L22VoF7ICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463545; c=relaxed/simple;
	bh=VT/U3EO+ktEfC+VjYyJdMzY1Z+i06a3szoAgL5db0lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFI7ql6D7k28ZtYzz0ihyEdbk+kcCFVNpbi/CaNvIHy5HhCBvZT8a3sodr6pMgiI7ZUR4zmziIVYzKDclyIDUFeiCSBPTeDvunGaTcS5y6g7EWNsOHOFlaiWWzyvnjjR+vkPBl5DdsT5jP4W/ZWEoJkn6r56MTm7dxe13LLa1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tFrPDZ6e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KK1CvB014861;
	Tue, 20 Feb 2024 21:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=19WihYNIrLNyTeLOooB44fJUY5UTGBk4JF+0ztIFYcc=;
 b=tFrPDZ6eKBk9MP35iKYuyWdcCN8C5Kj1jAvmvC/SRCCCu8txph38bD5DlkfL9ZoDYpgx
 D13cV+UHrHeLBNDIO3cf5xYXWlwQ2rHocvlWufUe9wIW5P9xFF/H8ZvUAMwrJ2+QOY8M
 PIpgTs9Qc/JBR6LCdBix8bJGbeAi+EWQaUkJnYimTcQxfeqWe+6tf3p/STacfHPAeRCQ
 z3KEEzo5aqjvo8dAIICPkUZte+fLB0Qzo+nxRkWkxfB2caB9lwLhrNBd0vi6pDxORI4m
 VOtWCLO+rQXBUAuxMo/QToBEp3oTpElXueyjZGu6nAsOV3YLPbFc2rl1DAyZfwKQ6snd Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wd1esu2un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KL2Hka001676;
	Tue, 20 Feb 2024 21:12:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wd1esu2ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KIY6YP014427;
	Tue, 20 Feb 2024 21:12:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u2jb52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KLCDcc16777772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 21:12:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B1F2004F;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8700120040;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 3AFE3E02C0; Tue, 20 Feb 2024 22:12:13 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v4 1/2] KVM: s390: fix access register usage in ioctls
Date: Tue, 20 Feb 2024 22:12:10 +0100
Message-Id: <20240220211211.3102609-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240220211211.3102609-1-farman@linux.ibm.com>
References: <20240220211211.3102609-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yGfGthPE3GdgawBbB827mSu4py9EpJo-
X-Proofpoint-GUID: iNPsbPqxsVs6JKwKyJIn0naDIfRag3TN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200151

The routine ar_translation() can be reached by both the instruction
intercept path (where the access registers had been loaded with the
guest register contents), and the MEM_OP ioctls (which hadn't).
Since this routine saves the current registers to vcpu->run,
this routine erroneously saves host registers into the guest space.

Introduce a boolean in the kvm_vcpu_arch struct to indicate whether
the registers contain guest contents. If they do (the instruction
intercept path), the save can be performed and the AR translation
is done just as it is today. If they don't (the MEM_OP path), the
AR can be read from vcpu->run without stashing the current contents.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 2 ++
 arch/s390/kvm/gaccess.c          | 3 ++-
 arch/s390/kvm/kvm-s390.c         | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 52664105a473..aee2d3a6254b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -765,6 +765,8 @@ struct kvm_vcpu_arch {
 	__u64 cputm_start;
 	bool gs_enabled;
 	bool skey_enabled;
+	/* Indicator if the access registers have been loaded from guest */
+	bool acrs_loaded;
 	struct kvm_s390_pv_vcpu pv;
 	union diag318_info diag318_info;
 };
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 5bfcc50c1a68..b4c805092021 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -391,7 +391,8 @@ static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, u8 ar,
 	if (ar >= NUM_ACRS)
 		return -EINVAL;
 
-	save_access_regs(vcpu->run->s.regs.acrs);
+	if (vcpu->arch.acrs_loaded)
+		save_access_regs(vcpu->run->s.regs.acrs);
 	alet.val = vcpu->run->s.regs.acrs[ar];
 
 	if (ar == 0 || alet.val == 0) {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ea63ac769889..61092f0e0a66 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3951,6 +3951,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 				    KVM_SYNC_ARCH0 |
 				    KVM_SYNC_PFAULT |
 				    KVM_SYNC_DIAG318;
+	vcpu->arch.acrs_loaded = false;
 	kvm_s390_set_prefix(vcpu, 0);
 	if (test_kvm_facility(vcpu->kvm, 64))
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_RICCB;
@@ -4951,6 +4952,7 @@ static void sync_regs(struct kvm_vcpu *vcpu)
 	}
 	save_access_regs(vcpu->arch.host_acrs);
 	restore_access_regs(vcpu->run->s.regs.acrs);
+	vcpu->arch.acrs_loaded = true;
 	/* save host (userspace) fprs/vrs */
 	save_fpu_regs();
 	vcpu->arch.host_fpregs.fpc = current->thread.fpu.fpc;
@@ -5021,6 +5023,7 @@ static void store_regs(struct kvm_vcpu *vcpu)
 	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
 	save_access_regs(vcpu->run->s.regs.acrs);
 	restore_access_regs(vcpu->arch.host_acrs);
+	vcpu->arch.acrs_loaded = false;
 	/* Save guest register state */
 	save_fpu_regs();
 	vcpu->run->s.regs.fpc = current->thread.fpu.fpc;
-- 
2.40.1


