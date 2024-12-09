Return-Path: <linux-kselftest+bounces-23051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC06B9E9A64
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 16:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291C31885EE5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210A1BEF8E;
	Mon,  9 Dec 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bwv5I1Qa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4A233132;
	Mon,  9 Dec 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757849; cv=none; b=Bt5AnTTi5D+ByHpaBLZSGtookrta8m7/OV9Lt/PBwPcr7V6AOXTxfSuo2NNy8Vgv9/fkMTEb0b417A3s+JPQnQ93oF5bH8EbQ+xCNvlGuLhyGldXU7jK67dmYawcNmYKw3Wcm/GsPlZ73Q58pXFp/cnqEsEuiAg6g6gC4kd05qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757849; c=relaxed/simple;
	bh=1bqTI0gV5hzNQXTniSw+DnQQc+f6sOgdKZ667Yt0eMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjXh12X9FRRWLhpWqX9PtYTgkIMuwcMLDQVNF5CRR0+/Fd/e1pm4GNafrvG+MQhDuNnLbZyxBAb5K2fd7zRtWYS9Bi+whNC7Gc+a2GzLn4l/1yzJhNr9URVR2ld2+8hidwHZ6zSjW0M50/pfUqUZ4ttbEKvmv4WJIYJUfBHMBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bwv5I1Qa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Ah1p0024353;
	Mon, 9 Dec 2024 15:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p60V8L9gjD8iwlB2i
	9zuwMrCp+XbLbBlby3+xu3ylY8=; b=Bwv5I1Qa98XVxWMtBYasqS1rPgYVPHLlV
	SlgyU09wNH4HjeEHVZp+mqNc75w9IWf4SjshFzP50VCeBhiLZxIkP+5+5COmGMI+
	Pye4Tocfv3QncpGMbV1BwYgvNhFSblD8dW9NaXCnpycU3TKFtX+R+HWzJol4NiPq
	jh9IlrVB4Xnzu+1dkMJGLBqgXxcJ30joP6Vztak1pO95y54N/YHoMTWOrAau9DdO
	4ADTlIzfV7/OWf0FKM0TQM4uy1ZDKWO9ToyeZNqiVwm+Sk8emRUlir9EMacn1QH5
	5Bwe7UV54vOfVtqB06QzqlpEFjEKKIEo7zJn1wvA//N9lYVPmxJIQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsj98ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:24:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Dit3M016926;
	Mon, 9 Dec 2024 15:24:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12xydec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:24:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9FNvrR53150004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 15:23:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4F3720043;
	Mon,  9 Dec 2024 15:23:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B30C320040;
	Mon,  9 Dec 2024 15:23:56 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 15:23:56 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 1/6] kvm: s390: Reject setting flic pfault attributes on ucontrol VMs
Date: Mon,  9 Dec 2024 16:23:32 +0100
Message-ID: <20241209152334.208112-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209110717.77279-2-schlameuss@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f8NT5PTv2pwd8pb0KnwW47oQRKqz5q__
X-Proofpoint-ORIG-GUID: f8NT5PTv2pwd8pb0KnwW47oQRKqz5q__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=686
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090117

Prevent null pointer dereference when processing the
KVM_DEV_FLIC_APF_ENABLE and KVM_DEV_FLIC_APF_DISABLE_WAIT ioctls in the
interrupt controller.

Fixes: 3c038e6be0e2 ("KVM: async_pf: Async page fault support on s390")
Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---

Added documentation and fixes comment.

---
 Documentation/virt/kvm/devices/s390_flic.rst | 4 ++++
 arch/s390/kvm/interrupt.c                    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/virt/kvm/devices/s390_flic.rst b/Documentation/virt/kvm/devices/s390_flic.rst
index ea96559ba501..b784f8016748 100644
--- a/Documentation/virt/kvm/devices/s390_flic.rst
+++ b/Documentation/virt/kvm/devices/s390_flic.rst
@@ -58,11 +58,15 @@ Groups:
     Enables async page faults for the guest. So in case of a major page fault
     the host is allowed to handle this async and continues the guest.
 
+    -EINVAL is returned when called on the FLIC of a ucontrol VM.
+
   KVM_DEV_FLIC_APF_DISABLE_WAIT
     Disables async page faults for the guest and waits until already pending
     async page faults are done. This is necessary to trigger a completion interrupt
     for every init interrupt before migrating the interrupt list.
 
+    -EINVAL is returned when called on the FLIC of a ucontrol VM.
+
   KVM_DEV_FLIC_ADAPTER_REGISTER
     Register an I/O adapter interrupt source. Takes a kvm_s390_io_adapter
     describing the adapter to register::
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index ea8dce299954..22d73c13e555 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2678,9 +2678,13 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		kvm_s390_clear_float_irqs(dev->kvm);
 		break;
 	case KVM_DEV_FLIC_APF_ENABLE:
+		if (kvm_is_ucontrol(dev->kvm))
+			return -EINVAL;
 		dev->kvm->arch.gmap->pfault_enabled = 1;
 		break;
 	case KVM_DEV_FLIC_APF_DISABLE_WAIT:
+		if (kvm_is_ucontrol(dev->kvm))
+			return -EINVAL;
 		dev->kvm->arch.gmap->pfault_enabled = 0;
 		/*
 		 * Make sure no async faults are in transition when
-- 
2.47.1


