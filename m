Return-Path: <linux-kselftest+bounces-23019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB1A9E91BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E641887835
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F421E090;
	Mon,  9 Dec 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hsjJyd9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817621D015;
	Mon,  9 Dec 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742454; cv=none; b=EBCYHezaoDItqJpVcPq3grQ7oju10/PlIpeut++tJrS+y7fTdvvSimh71WyrixmVGIuyVvZs0JBz6SQ3FODlM83v8YnQydVcURMAYGaCevpBg8JoVHOGgJnUUPeWjjuvYCxZCFFUdpYC6/GsTnemYoWoItfrCkuwgpufdPE+WOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742454; c=relaxed/simple;
	bh=SkohOH3IVePyGW8+1NVUsviezzJw9M7C9age5bPnX2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+DU20zAXUMPT/eH46cXeJ9XwWsNjq8lNxR5sYpJ2KK2nVNlfpAECnFleWHL5iLnIOQvkzcMryQCnRmJuQErg8Ddrhyp0lUc1CZF3nlkz39NZxtyOozPNi02GJNTS7iaMkSwt0S9GZEZikwd6OurjKMDtT+3HQof/HWv48IDl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hsjJyd9D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Aei9k011210;
	Mon, 9 Dec 2024 11:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7nm06ya67cLBtHkdT
	Dq/1GFvduq1/+F3RDKhiAtAoaE=; b=hsjJyd9DAcvp6kT6rKA8DWTOiLJaZP4Ds
	6WlcUAwHCQXpzIAOxyRlxNgqepij+Lpv2kEBdlhBHZRl3IJAXCpdNd9mp5YraSmB
	vslAS5eF5gNjl9PE0YztX8p7ZE2R91rKhQsJ8Uhbwy8Xc58qLo29uc2DZqhjiqln
	c5jcLC3cd7vIz3k30GSCh2mfbI1v87Y9lBFo0DBEAJ3XOZ/7sSwV+W1V/1fG/sQe
	fU63BAV+fhr7zOhw/F7f6CcKG5RIlvJeMB74Ure83yx3t50BNQBK27fDw7e+7eCy
	dZuFaVnrwIM8vl3fKZdu0M0FOOI1bWmS59BQvPoKjS4CgVoo7d0/g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq0anf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B982Hdg017428;
	Mon, 9 Dec 2024 11:07:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1dxa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9B7Ni942205666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:07:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C9AF2004B;
	Mon,  9 Dec 2024 11:07:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D452B20040;
	Mon,  9 Dec 2024 11:07:22 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:07:22 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 1/6] kvm: s390: Reject setting flic pfault attributes on ucontrol VMs
Date: Mon,  9 Dec 2024 12:07:12 +0100
Message-ID: <20241209110717.77279-2-schlameuss@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: A1rZHKnIRmuBnPi4inbGRHfBniPZpoyb
X-Proofpoint-GUID: A1rZHKnIRmuBnPi4inbGRHfBniPZpoyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=452 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090086

Prevent null pointer dereference when processing the
KVM_DEV_FLIC_APF_ENABLE and KVM_DEV_FLIC_APF_DISABLE_WAIT ioctls in the
interrupt controller.

Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++++
 1 file changed, 4 insertions(+)

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


