Return-Path: <linux-kselftest+bounces-4815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12C856EEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 21:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025AE2885FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00813B2BD;
	Thu, 15 Feb 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SgBiEI31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA789139564;
	Thu, 15 Feb 2024 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030437; cv=none; b=HC+U76c+tcRcFNQI4vy+iCvuP5noG4efb8p8PIDimfwKkBnIWEXWOx56oL+1Q94piwrkEaQ7ktMvTvuUtYFCFwUfx8NcHtKQwWMgxl1AqIOd7t9XoQ05ifG0XjHeETIHX7ZTei66dkLMzo3sL4rNWF3YYAp/vHky2wpbM99KPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030437; c=relaxed/simple;
	bh=G0zJqsDUc41gb3Kka5WJ84MT9pk4cB8dr7nP6TY/hKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALWbmDnrSv+KF4Rp7y//3Gtqv+QBnlW/MRELTvP6gweX4ibTc90Z5IYXhLqIuuLMEXLIkO0rGjDD4yTrozs8g2JkHrGVt3G/cnRmHRWoF5CtPLpVAkWC/dsgfNXYZCRUSVwaDMbTWLJ3QXCRH3N+vslUzNyhDllZR1st4u9Ks9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SgBiEI31; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FKWetK001647;
	Thu, 15 Feb 2024 20:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NL7OiQirKaWjRtmxHdcy7aF+ciWmfv9QysceRLSgPPQ=;
 b=SgBiEI319ITiiOAysEhXTsNwOV4JCnKesqq3u9J7ojIBn7x0fPY8Cgg3b7JOF8kvB+DP
 YcDVlKEt2WSqjuZvSs0/zPwPjs++Mttb0r1azC5Pl3+MDRaVxN0Mq+1sDtkjjPym7aUG
 ojOhmIr0101i474gIdljC3zanFtM2WVybTi44ErI3PIgHcebWMwMN4d2Svd2NJS15nsu
 8Ac5Ajb+8w8PwNn4EmEvo8oV2KNiwYAURbi6ua/nXBMrGBpysheniF+F/GS1dDnj7vNM
 KX0llE8wdmkf7GDIF87iZnAiThohvzj/RJntk2nfTAfYXAVkhOcgykIq8oCMoqFmFeKV Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9sqy0bu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:53 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FKXmPI006041;
	Thu, 15 Feb 2024 20:53:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9sqy0bth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJTaTj024908;
	Thu, 15 Feb 2024 20:53:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpq88n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FKrkdF524876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:53:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE9020043;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A5AE20040;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id D5978E03DB; Thu, 15 Feb 2024 21:53:45 +0100 (CET)
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
        linux-kselftest@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 1/2] KVM: s390: load guest access registers in MEM_OP ioctl
Date: Thu, 15 Feb 2024 21:53:43 +0100
Message-Id: <20240215205344.2562020-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240215205344.2562020-1-farman@linux.ibm.com>
References: <20240215205344.2562020-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FzUESSDCGudW1CSJ7W_OQvNSNb_pq4pr
X-Proofpoint-ORIG-GUID: JMZIQVfs-POTq0yiv-ayNE4gGCkKoqTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150167

The routine ar_translation() can be reached by both the instruction
intercept path (where the access registers had been loaded with the
guest register contents), and the MEM_OP ioctls (which hadn't).
This latter case means that any ALET the guest expects to be used
would be ignored.

Fix this by swapping the host/guest access registers around the
MEM_OP ioctl, in the same way that the KVM_RUN ioctl does with
sync_regs()/store_regs(). The full register swap isn't needed here,
since only the access registers are used in this interface.

Introduce a boolean in the kvm_vcpu_arch struct to indicate the
guest ARs have been loaded into the registers. This permits a
warning to be emitted if entering this path without a proper
register setup.

Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/gaccess.c          |  2 ++
 arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 52664105a473..c86215eb4ca7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -765,6 +765,7 @@ struct kvm_vcpu_arch {
 	__u64 cputm_start;
 	bool gs_enabled;
 	bool skey_enabled;
+	bool acrs_loaded;
 	struct kvm_s390_pv_vcpu pv;
 	union diag318_info diag318_info;
 };
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 5bfcc50c1a68..33587bb4c9e8 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -391,6 +391,8 @@ static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, u8 ar,
 	if (ar >= NUM_ACRS)
 		return -EINVAL;
 
+	WARN_ON_ONCE(!vcpu->arch.acrs_loaded);
+
 	save_access_regs(vcpu->run->s.regs.acrs);
 	alet.val = vcpu->run->s.regs.acrs[ar];
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ea63ac769889..c60ec561f7f1 100644
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
@@ -5391,6 +5394,11 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 			return -ENOMEM;
 	}
 
+	/* Swap host/guest access registers */
+	save_access_regs(vcpu->arch.host_acrs);
+	restore_access_regs(vcpu->run->s.regs.acrs);
+	vcpu->arch.acrs_loaded = true;
+
 	acc_mode = mop->op == KVM_S390_MEMOP_LOGICAL_READ ? GACC_FETCH : GACC_STORE;
 	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
 		r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
@@ -5420,6 +5428,9 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 		kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 
 out_free:
+	save_access_regs(vcpu->run->s.regs.acrs);
+	restore_access_regs(vcpu->arch.host_acrs);
+	vcpu->arch.acrs_loaded = false;
 	vfree(tmpbuf);
 	return r;
 }
-- 
2.40.1


