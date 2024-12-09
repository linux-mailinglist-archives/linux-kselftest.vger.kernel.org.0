Return-Path: <linux-kselftest+bounces-23018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB29E91B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FC6165AD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF83421E083;
	Mon,  9 Dec 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PObiW5p3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413E21D00F;
	Mon,  9 Dec 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742453; cv=none; b=HVjRN6a12YI7S/HW004MQYqrix+Yg+tv9cdO5e0P/qKlkmSZ18+W8UdY8CQ+mQUu3xtdItNJkDD3+3MB4FKz9IT2jir+NI8yfzWk4SbVdwuKmhXA7yUIVcnEFyGHC0qdnaeoNleALrTfuO97f8ggcTscaMlUkWlL/lqzjBaiXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742453; c=relaxed/simple;
	bh=vaNbmqHN2E+RRqrSoMD3L9X04xWDI7ABfyBLyHddJEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRdHwDZY5SmLn73p7LaUx0Yn5ruGdBOM8+mKj99qxNb/24SdBUl4sPXbongR8mY9sCQbu7sfdqo+xBfKR0y0d4Hdm/X9EbRtLExHasH1TvJsshQWYc7HGsYNVShScG63uS19dFa4u5eQuLsiSsecwgYy85nccPUwfaNHs6o3m60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PObiW5p3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9ABGsC026201;
	Mon, 9 Dec 2024 11:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=35HsWKt6Z/AelSJVC9dl6RNXa3hC1xcYrtxXfCY8+
	cs=; b=PObiW5p3q047N/LXo3HjSc6R6fLFMG5w2M4CoYz7VyKOah2YN3nBCpZ2d
	6q5ETxNOTZhm08x9bi/TWhIJDZAriDip5zKuAiqjaJPpb8ULhbbndB99M13M9jBs
	ni+RAZ1aP4O1bA/nWAoAuniigHe6aqd72U1T7gU7cIDEQg9f9QQ4usoIPJWrOUe4
	myylnzEcvL9BFsDEM0jVHKiF8/Esx8qLvq7HKSALaG0M+yluhsoxo6SNxHhWH7H2
	eUw5hfIQEkIjkYtyaNTpQfT0FpjPxxPjjwxFBWIIrbzFhValAeN7vKAXntNkMUTE
	vb7rQKKUHn8rLE8NnOvfV8nFWUd4g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38gvhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B97SqLZ023039;
	Mon, 9 Dec 2024 11:07:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjp174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9B7Lg853150054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:07:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 364522004B;
	Mon,  9 Dec 2024 11:07:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB86020040;
	Mon,  9 Dec 2024 11:07:20 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:07:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 0/6] selftests: kvm: s390: Reject invalid ioctls on ucontrol VMs
Date: Mon,  9 Dec 2024 12:07:11 +0100
Message-ID: <20241209110717.77279-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lRM2N99RlyVkpiyY3kKPEP5USxndJL9A
X-Proofpoint-ORIG-GUID: lRM2N99RlyVkpiyY3kKPEP5USxndJL9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=664
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090086

This patch series adds more test case issuing ioctls to ucontrol VMs and
its floating interrupt controller.
The test cases trigger three possible null pointer dereferences within
the handling of the KVM_DEV_FLIC_APF_ENABLE,
KVM_DEV_FLIC_APF_DISABLE_WAIT and KVM_SET_GSI_ROUTING ioctl.

All of these issues do only exist on ucontrol VMs. Fixes for the issues
are included within the patch series.

Christoph Schlameuss (6):
  kvm: s390: Reject setting flic pfault attributes on ucontrol VMs
  selftests: kvm: s390: Add ucontrol flic attr selftests
  kvm: s390: Reject KVM_SET_GSI_ROUTING on ucontrol VMs
  selftests: kvm: s390: Add ucontrol gis routing test
  selftests: kvm: s390: Streamline uc_skey test to issue iske after sske
  selftests: kvm: s390: Add has device attr check to uc_attr_mem_limit
    selftest

 arch/s390/kvm/interrupt.c                     |   6 +
 .../selftests/kvm/s390x/ucontrol_test.c       | 196 ++++++++++++++++--
 2 files changed, 184 insertions(+), 18 deletions(-)

-- 
2.47.1


