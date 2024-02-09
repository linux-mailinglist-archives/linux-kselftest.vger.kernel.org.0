Return-Path: <linux-kselftest+bounces-4479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022EB84FDDD
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277E01C2455F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085ADF55;
	Fri,  9 Feb 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AQUaB5km"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86F63C7;
	Fri,  9 Feb 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511555; cv=none; b=GZD8EcDxHjPBlKH45BNu/V9FIV8gNqDOuOnZabtlZLq/PRBs225EhQSvM7E/KST8N6CDN2Mnnt7Ea9ndGaWoySHfchQI/LR3WFKiKnNbXlhSKAUyupi149/In140xI5eKNIbYYKe4EL7JR7I/qH/0xYJpyKRsQKI8U5DHxqPAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511555; c=relaxed/simple;
	bh=PD07SeOABZayD4OWAL8QdWxQx1v17dIX5YvQ0fCXp4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6uaj6Saw9tGGoiT1EGXWhNelYIhoxQyXtYFNjRqYgnmH4QtJGqaC8XBMclLrOSxqK4FHTUew6Q7blBVjsF9pm2YsZWVOR/5tKL6oBHAlZt5q5k31jKtrHIyZHx9wi9xW8PKargy4gKIupntLmybEmYdEme3kV24fuN40MVcsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AQUaB5km; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419KTAtO011265;
	Fri, 9 Feb 2024 20:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K4gtnh476TX/A61y3OtVnsTBa0d5b5KaeIXQ9TZxKRE=;
 b=AQUaB5kmADQB18xgIDbabVFaRZ6hZDwsTWE6/eU5Wulr9fax/Rda64W9pFqJSSa8LVsP
 M9EzX0LRe1vXqhvC1B/XIlzSbDK11IrsH24rlxvZd/REWGLj90FZ7GiN2UTBCcoLSwZ/
 AfFR30zRKmlHzgBMod+3vlB1wGSlsRcSTpCR1zM1EuywtD1gXn8UzlmWsuv3EE+cTec2
 5anlFSAoBDKla/QBlGTMQdE+Mp9yR2aw+O+/tCDXMTsMTjDodCXXkQrx8K8V0OV6TrGo
 bp6A3wybvKTXzjrDIikjDo1zEOWA+yD2FUX4nbEmC++LRK+udWV9S4uM24fIDE5Yphal 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5u48gcbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:45:50 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419KTcM2013189;
	Fri, 9 Feb 2024 20:45:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5u48gcbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:45:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 419J6oKs008770;
	Fri, 9 Feb 2024 20:45:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20705hxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:45:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419KjhPS1180206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 20:45:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285522004E;
	Fri,  9 Feb 2024 20:45:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1425A20040;
	Fri,  9 Feb 2024 20:45:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 20:45:43 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id C1507E0361; Fri,  9 Feb 2024 21:45:42 +0100 (CET)
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
Subject: [PATCH v1 1/2] KVM: s390: load guest access registers in MEM_OP ioctl
Date: Fri,  9 Feb 2024 21:45:38 +0100
Message-Id: <20240209204539.4150550-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209204539.4150550-1-farman@linux.ibm.com>
References: <20240209204539.4150550-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5yEmu3T270wcXNTRm5Tls-8dh99XcRt9
X-Proofpoint-GUID: l02bWChYgKUh-LfbocEAajv9bCNNlCOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090150

The routine ar_translation() is called by get_vcpu_asce(), which is
called by both the instruction intercept path (where the access
registers had been loaded with the guest's values), and the MEM_OP
ioctl (which hadn't). This means that any ALET the guest expects to
be used would be ignored.

Furthermore, the logic in ar_translation() will store the contents
of the access registers back to the KVM_RUN struct. This unexpected
change of AR values can lead to problems after invoking the MEM_OP,
for example an ALET Specification Exception.

Fix this by swapping the host/guest access registers around the
MEM_OP ioctl, in the same way that the KVM_RUN ioctl does with
sync_regs()/store_regs(). The full register swap isn't needed here,
since only the access registers are used in this interface.

Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ea63ac769889..c2dfeea55dcf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5391,6 +5391,10 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 			return -ENOMEM;
 	}
 
+	/* Swap host/guest access registers in the event of a MEM_OP with AR specified */
+	save_access_regs(vcpu->arch.host_acrs);
+	restore_access_regs(vcpu->run->s.regs.acrs);
+
 	acc_mode = mop->op == KVM_S390_MEMOP_LOGICAL_READ ? GACC_FETCH : GACC_STORE;
 	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
 		r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
@@ -5420,6 +5424,8 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 		kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 
 out_free:
+	save_access_regs(vcpu->run->s.regs.acrs);
+	restore_access_regs(vcpu->arch.host_acrs);
 	vfree(tmpbuf);
 	return r;
 }
-- 
2.40.1


