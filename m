Return-Path: <linux-kselftest+bounces-23020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984969E91B0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E84A2818E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804FF21E099;
	Mon,  9 Dec 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yws98zxI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC621D019;
	Mon,  9 Dec 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742454; cv=none; b=ZwuOZQse2/5dN4U+wiGpW9CmNOH7asVR+JRCQS9rN+nWWduwS4jMaTw/LSEFL7MKRVbOclI6QiFdrhCzZV4awO3yDyaZzC7eT2mAmw/p5sliZ+c/z+Tn9OfX2ehbNQUYVpgNHbefvaSsF350o+MIIVQJNy06Dyo3j+qLkzY4gN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742454; c=relaxed/simple;
	bh=WPeA4EGDZk+ccGormQuFLlWWzmuKEoE2qZ4QG/URbUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TF9B84cFdXj7zRKGCLUTvR1p9AVgtV38nKnjXtPk2EIWV4RCp0K/0qPqAzoHfXfbJ6xFB2yNoseH86pd/mrHL7eqLTVxh1WYwUXKCniUYMVIrd38MBI1A/928ePWOv/9XdRmuj8kOiHW8aR2RdhrJ1btwcY137mW9vYbrizk4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yws98zxI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NjLpf016921;
	Mon, 9 Dec 2024 11:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=58VrcdrLf1Ke/bfKi
	Tr7jj6voshAvZBLb8cIovv6reg=; b=Yws98zxI+k9VbSmP0hwsd7+y+dV6/YcZG
	mI051+WYIOm9ab+dWbzE6KX+EkkCOq+sS9NeCg5i+efX6C0R++PifRMpvgNLRsEq
	sjUoblf2fKPG42iV07O3DvPdonX3e/9KFx7rOXlCgHzc91CH1bP3FG1DzQcJnBgy
	3VjKxRKlKe0U/KKU19xdY00HskEzak5uRcYsOIRZv/bRGItLxtYaio33Rewz6qwn
	q6qNUCzmVBAM78K2JwdyxvVAHFfWPkHABBI1rLbSimSbdKpt8f/gtwKYmaOE/K7u
	Ukhemm2N9Cum7oxJYP5nJ0xrIffl1JjBXuK4aykNrh86/Svd3FsHQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38gvhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B97nwNW023029;
	Mon, 9 Dec 2024 11:07:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjp17d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9B7OX656426858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:07:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82B0820043;
	Mon,  9 Dec 2024 11:07:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06E1B20040;
	Mon,  9 Dec 2024 11:07:24 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:07:23 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 3/6] kvm: s390: Reject KVM_SET_GSI_ROUTING on ucontrol VMs
Date: Mon,  9 Dec 2024 12:07:14 +0100
Message-ID: <20241209110717.77279-4-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209110717.77279-1-schlameuss@linux.ibm.com>
References: <20241209110717.77279-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xoq6o0zwZdznxpR4-DwN7BjthtbyiDsp
X-Proofpoint-ORIG-GUID: xoq6o0zwZdznxpR4-DwN7BjthtbyiDsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=599
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090086

Prevent null pointer dereference when processing
KVM_IRQ_ROUTING_S390_ADAPTER routing entries.
The ioctl cannot be processed for ucontrol VMs.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 ++
 1 file changed, 2 insertions(+)

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


