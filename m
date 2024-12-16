Return-Path: <linux-kselftest+bounces-23393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B639F2CCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028B5166D98
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34E200BBD;
	Mon, 16 Dec 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UlMKMS2T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2551FFC68;
	Mon, 16 Dec 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340929; cv=none; b=et4FS8S8iK4CnGDZOrowdIT+M6+j4UnUOjBI94O5Cl4GObEeHXf+yn6Cj1txhs3OF44oa58zhJj8xQXOFEl8lX4hJuTDz/we9OL5JRF/NrVlsY30YrtOw6tdsZl3HQDS5p3jqyIJ/DH301uXHcq1ud8rSYhjlgKVkanTijGvv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340929; c=relaxed/simple;
	bh=Os/W+aDq16zedvVbNZyhVyIOycTJMHypKTDKRMZIx90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOqM6tCugYJV8ALTUN2hQu4NemVv61mnNeoFDUU4dpDSX5vWPm1+KByyTF5VDIXovdmDRrbDixFh3p2Z7JMB7YD1zRIWud7PO4FNrlNLpLPKPwp9MR5SYAZXvED7yQQWRUHFUkpJRZ/+r8f5goHzp4kjqrAOW1qMa9I9JVCeoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UlMKMS2T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFNaFge019517;
	Mon, 16 Dec 2024 09:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Uumz/cfkkP8SE93T/
	q0y69bMndxcNuc22uLhOh5aCd0=; b=UlMKMS2Tc0Gvuf30V6nPXU0sbJkrXpZfj
	YvBiz+Y5YchDSFFgYy90dRJXAmZV4BWd2P0vdLBmGqS5nnHZuUv/QqjD69qn9T75
	M1rfF48U9S2pL37ZGmPInq4ZG/UIg95o4uZIN6xWItW6OwSpSCcs1REPGZFAtaPU
	Y9sDwSABIkZC85oGOtJezZywgtETqkPKWcRsTPhmx8KtUAo6IwQ1r76HEJFqgJNS
	nYOn3QER09fvHotT3XBO9FWyEjfwIa/4B9lp9B3R8bdj+HHSQhSprkjG48Vf0uX2
	J2KxezFBn1g4tjfImOMj8JlOWs1h9gKdiPWVxDENsAWv66PK+S0Pg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j8xahwa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG4paf9005488;
	Mon, 16 Dec 2024 09:22:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbmw81m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9Lx7Z35914470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:21:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E889F2004B;
	Mon, 16 Dec 2024 09:21:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3466420040;
	Mon, 16 Dec 2024 09:21:58 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.0.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 09:21:58 +0000 (GMT)
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
Subject: [PATCH v2 1/6] kvm: s390: Reject setting flic pfault attributes on ucontrol VMs
Date: Mon, 16 Dec 2024 10:21:35 +0100
Message-ID: <20241216092140.329196-2-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216092140.329196-1-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RdzZBTYOoDGCNjQqdpKhgfCafpBnB8ox
X-Proofpoint-ORIG-GUID: RdzZBTYOoDGCNjQqdpKhgfCafpBnB8ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=675 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160074

Prevent null pointer dereference when processing the
KVM_DEV_FLIC_APF_ENABLE and KVM_DEV_FLIC_APF_DISABLE_WAIT ioctls in the
interrupt controller.

Fixes: 3c038e6be0e2 ("KVM: async_pf: Async page fault support on s390")
Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
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


