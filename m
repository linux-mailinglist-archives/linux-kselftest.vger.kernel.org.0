Return-Path: <linux-kselftest+bounces-4882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D6858815
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 22:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE21A1C21517
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4356F14600B;
	Fri, 16 Feb 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qel7xIzt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBC137C58;
	Fri, 16 Feb 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119390; cv=none; b=ov18dq6F5p4VGHtNABQfsdjJ5sqpwkxqwrf7SwmdeUuOTiUIlz1r31mXNOEXygg6RbGF1uAX+m9wnzWnYAzGOQfvTEbB2wgSMMIINnl4YcBjO1VbqRA/NcLEBsaLkQKY+d3OVmLOQTm2cVmzI7Gqi98auCFax+HRORzmgLQAjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119390; c=relaxed/simple;
	bh=t9ZRITE3zrgADLFU3FQuBVtZmSwGF7KVewwa+Uh4xws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNpp5FjeXDujpYrjeFdSapdI4ETcQ6PLtdYK3okfJW2y5ONHY9kT9JUWiuGg9LA69k61qeMtKonzrOz4AOpHLeiquKg2aMw0j1lF6cur3o68namwShJfRT+Oivza4v8UqDdiE/1uqBFMS+cOG2a7BBzarnK4cC0ce6D8ryC0alA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qel7xIzt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GL1j4H019487;
	Fri, 16 Feb 2024 21:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8rQ1ueVy3dy3KyeaJkZznLRa2iw5LVCPKJmkRpc9kXQ=;
 b=Qel7xIztuQeejWVwW3gXxyXSCdRnVCejJ9uTKHpwB/vr0iE02OCm24083TU5Egmg2AIe
 QstAa6q0dmR2K0hddiaerMlIcyps68OTGEjhvXkk/4toLs/okfTP5xjAjnFiSiYdv+jo
 utsdgLNhVFavm/61uFwQuR6EfIpo6+AZ0HW627tqKy9iR9rl8q2z6YI+tNhhcufj/qBn
 cb0xRhc3pQLV/0g2eA97rE4GsaQryYmFW5E4HJ31fxdo0FVYPBU+RQTkMVOXIrSJuvR6
 kgMrmZDV5d7eI/6QSv0xAHszGpNIEsuuewemxGOpHeo/gFKR6j103BySMTd6nO+446tw sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wadvqj9v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:24 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GLOSsB015398;
	Fri, 16 Feb 2024 21:36:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wadvqj9uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GJFlcg016203;
	Fri, 16 Feb 2024 21:36:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6myn5u5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GLaIYs64029006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:36:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C3292004B;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A02C20040;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 01966E0086; Fri, 16 Feb 2024 22:36:17 +0100 (CET)
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
Subject: [PATCH v3 1/2] KVM: s390: fix access register usage in ioctls
Date: Fri, 16 Feb 2024 22:36:15 +0100
Message-Id: <20240216213616.3819805-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216213616.3819805-1-farman@linux.ibm.com>
References: <20240216213616.3819805-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3R3xHlvNdN68UpzQNGmX4LsFG2R-UGk8
X-Proofpoint-ORIG-GUID: JJYcNozO0clRO1F667fqgusPTDBUPzhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_21,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160169

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

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/gaccess.c          | 3 ++-
 arch/s390/kvm/kvm-s390.c         | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

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


