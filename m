Return-Path: <linux-kselftest+bounces-23052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA329E9A65
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 16:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57EA1612F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFCD1C5CC7;
	Mon,  9 Dec 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JefX7EKM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA161BEF7C;
	Mon,  9 Dec 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757849; cv=none; b=Tw3tKo/s1qLtsE32Yz2A0Tj80qcH1VXfALehtnZvxi70x0Q7AVdQDdRrU3sjN1PwV7sEBQtrS9zxlATHl89/xWL2IVh0KSLuFfJYGLDxmKUxOX8tDky6HfIF8JpryQpUWVwP4lK4br7KCi02tmDKFG9v7jP9fjXGkz4Fv210QyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757849; c=relaxed/simple;
	bh=lT0m8oYQ9lX3AvF2BLs9nIUmq5RpPOD8OABP8ANbGNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw7MI6vXKZ0v4kMZ9k1BrbKPpCqLm6UJOGQvzMbNnJw9Ziq2CmN0lJA8Kf9zRgFsyE7wY0bKkgtgDUNE0+kE8cKb3MHbUZ3TC7r6ChcLrT01HkcrFngeWive/tjQr9UlNjvve4jeqZBE7eLbsfd6erlDAHOqAwBPvjuopwO9/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JefX7EKM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9DMQYT026166;
	Mon, 9 Dec 2024 15:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X6NKjKK2fcPVyrS7w
	p9ZDNFRmOOyv4pjSUrNKZHreoY=; b=JefX7EKMV9uTG6twBJAXcy/2vVWI3vkaN
	FJHwL3xjB2hjOp080GiNk/Pg4p8BPBV7CLr1pwapvFYh8TIRss0OwArpbzwPVsgu
	kv9K0zSUBZaiDdcSfbsdWcCjHXBIinpQeEiHI75t98UxSkwpJ8GBWjYbtewvoTK/
	ybtbjMySe6YxakSuvMtgIZCPGz4/ksjWdZ3Q86URRJvhS08uclgsD45DD2oDR6zz
	Hu+jsDkntohxhVyC958Tdn89rUP6GqOIafXq4Sotl45zaqXAIn/rwJSp09OS3Xaz
	fdLkuoWBHURacg20McbULZ/97b8miGsXcFW/AVCiKKcm63IK3YG5g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8j46y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:24:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CJI04017397;
	Mon, 9 Dec 2024 15:24:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1evrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:24:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9FNxYY60621294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 15:23:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55FBE20043;
	Mon,  9 Dec 2024 15:23:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC1220040;
	Mon,  9 Dec 2024 15:23:58 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 15:23:57 +0000 (GMT)
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
Subject: [PATCH v1 3/6] kvm: s390: Reject KVM_SET_GSI_ROUTING on ucontrol VMs
Date: Mon,  9 Dec 2024 16:23:33 +0100
Message-ID: <20241209152334.208112-2-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209110717.77279-4-schlameuss@linux.ibm.com>
References: <20241209152334.208112-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yD96tGqsGPRpRLjWytu5LNnu3LtYI-ub
X-Proofpoint-ORIG-GUID: yD96tGqsGPRpRLjWytu5LNnu3LtYI-ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=554
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090117

Prevent null pointer dereference when processing
KVM_IRQ_ROUTING_S390_ADAPTER routing entries.
The ioctl cannot be processed for ucontrol VMs.

Fixes: f65470661f36 ("KVM: s390/interrupt: do not pin adapter interrupt pages")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---

Added documentation and fixes comment.

---
 Documentation/virt/kvm/api.rst | 3 +++
 arch/s390/kvm/interrupt.c      | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 454c2aaa155e..f15b61317aad 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1914,6 +1914,9 @@ No flags are specified so far, the corresponding field must be set to zero.
   #define KVM_IRQ_ROUTING_HV_SINT 4
   #define KVM_IRQ_ROUTING_XEN_EVTCHN 5
 
+On s390, adding a KVM_IRQ_ROUTING_S390_ADAPTER is rejected on ucontrol VMs with
+error -EINVAL.
+
 flags:
 
 - KVM_MSI_VALID_DEVID: used along with KVM_IRQ_ROUTING_MSI routing entry
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 22d73c13e555..d4f031e086fc 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2898,6 +2898,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
 	switch (ue->type) {
 	/* we store the userspace addresses instead of the guest addresses */
 	case KVM_IRQ_ROUTING_S390_ADAPTER:
+		if (kvm_is_ucontrol(kvm))
+			return -EINVAL;
 		e->set = set_adapter_int;
 		uaddr =  gmap_translate(kvm->arch.gmap, ue->u.adapter.summary_addr);
 		if (uaddr == -EFAULT)
-- 
2.47.1


