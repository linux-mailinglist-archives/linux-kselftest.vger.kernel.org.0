Return-Path: <linux-kselftest+bounces-23394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1A19F2CD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EDE1884C03
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5512010E2;
	Mon, 16 Dec 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wthwa10z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7020101F;
	Mon, 16 Dec 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340931; cv=none; b=TcuGKsTjcoyMiopmFvZHYHgfCrAWI439jAEZYwT4HA6BWa09dGacHCfRJiytyaLq/IGh+7fp29hywhLQZzuWQinRndHyjW1oMhiupHzfIuwa/7AxwqKPH7304sGBXOuIayAwH7meY3gHP6O3z/ZEZ/D4D9tLrHxpq5hf98KZKy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340931; c=relaxed/simple;
	bh=5jAI0h++OOxhIWM6GHqVKPy8bN5H25ksk7ZCALqiArM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgTehmE35dfIYelApQ/WiwJE4vGib4aYg9OByXhJKWoku+Sfdk/xSICCUbjXxwJVEsR8jjlFpXVGwXMUVZL7c6GLNDM4aSqHnDmtyAb8+ZYxNA+PKIszsVrNTsbxxyXipMYcszAtTZSCjD6PHvR2rUWm0pENg/t+dDMrQQh5sJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wthwa10z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85WIF027022;
	Mon, 16 Dec 2024 09:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zTldxmkncTdQy32zv
	EOGj3sxoP9wK9eN/7HdUbQ/4Gw=; b=Wthwa10zGlrte1u0wK3wEp7Y0CAINjyah
	Em6qtvIa5ISfOBuOmSCzlNIpP/zyMnvRy31TnHFwA8Kk468tCVVcopnsgPTBA3YD
	C1LIRfVHZxq5NSVbfYhvXU7RQvH0Jl47l319HFo9JhQTUnn1iqTFLj6cVU3DiyE9
	9a/L3dSx9nnTOfJwfH7Gyw7CRN1Jdc11SXZVUZHuCPMjOpxXv5KHY/yJcurHwaFP
	6afT5LHzhAa4a1P94ab6MHHuTAl4DQKFYk4zhXppDtwm9y6jLQzXH/VSsWZkgvQI
	4neUfGSyGPEuzFlSOzRO1svG/VP5tMjXBAQ3FtHGW2pa563FUBNjQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd28asd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG4kYcW005544;
	Mon, 16 Dec 2024 09:22:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbmw81n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9M0io36372952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:22:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8DDF2004B;
	Mon, 16 Dec 2024 09:22:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4B4820040;
	Mon, 16 Dec 2024 09:21:59 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.0.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 09:21:59 +0000 (GMT)
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
Subject: [PATCH v2 3/6] kvm: s390: Reject KVM_SET_GSI_ROUTING on ucontrol VMs
Date: Mon, 16 Dec 2024 10:21:37 +0100
Message-ID: <20241216092140.329196-4-schlameuss@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GaZQVaLXlOzS6elBlm15XPZGs2JE9kY0
X-Proofpoint-GUID: GaZQVaLXlOzS6elBlm15XPZGs2JE9kY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=541 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160074

Prevent null pointer dereference when processing
KVM_IRQ_ROUTING_S390_ADAPTER routing entries.
The ioctl cannot be processed for ucontrol VMs.

Fixes: f65470661f36 ("KVM: s390/interrupt: do not pin adapter interrupt pages")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
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


