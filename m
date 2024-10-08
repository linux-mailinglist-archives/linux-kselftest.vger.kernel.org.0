Return-Path: <linux-kselftest+bounces-19216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C7994118
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C179284EF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B731DF73F;
	Tue,  8 Oct 2024 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MoEIjsOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C81DF73D;
	Tue,  8 Oct 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373395; cv=none; b=Uu75zqSTo7VcL1qmgKiU2W9mTClzslSEVGvbgX6zfqZtWQtD4Zl4D/blDGEkoHIpq8zXC+Em7nQ1G0nCIZagEkjAZ84snEu6J4il8NNf6x7EsxSCf8vS5K7AjNxXPcElhn5iUmFCp930gzVV5JHHozjZEv5csYEmp+RvsjHuAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373395; c=relaxed/simple;
	bh=7FRlIliq27zXHguXCltoOt9VyJ4lxNOoIBHajbDy63w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZuoBonbGcZ+BcLGqgebwxrikvTxc1nmxS8QnvXR+kozeQmsjs1HUAEERzkDUy7yjxTsmxjxBkpxqRFPk2YohYkaZZeZgi94zpSdj2Q+Kted+xkxq0QJaUMdrA2OzGDK9dfruS8rtBm0Kmfawr9y+0zsTlrJVmgSNYDPO3KZgt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MoEIjsOY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984lrpN016830;
	Tue, 8 Oct 2024 07:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=hKS1bW6mmbr8fi7/huVE/RPWDrCa6ZF2CK89uS9
	g7PQ=; b=MoEIjsOYW4wtviRFaSA1+1PiG1JcgktYFqn5zEMtwYszWKwo8QColyZ
	mGzefHCnMoqXyVJ7RXhzb8TWtiGXxaN6Fq39c3X1snkFfDHK/Or19fTYVbeSsQCR
	OzQwibQ/wTRpZi+7y35ash+o8ePte17ICExebvityFrRkqRSr+pDKIUY60wmtdHu
	0jKNSvGor8swUlzzlw1jv98ze+jVqP6iPGJRkDxTstVshChOl4N+VDt2HXAbvgDD
	lmF1isByd9hmKKQ3jFF+Sm2i/s1EhPeuaJhOAvghKw7nn4E07h2U73At25C9zYPx
	sEl9+rSoGEbSZ77TfbGetRd25aE3MQA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424x168nnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4987diP0009876;
	Tue, 8 Oct 2024 07:43:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424x168nna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4985cDqY013857;
	Tue, 8 Oct 2024 07:43:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss31mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4987gx5X52036012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 07:43:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E174B2004B;
	Tue,  8 Oct 2024 07:42:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47F4220040;
	Tue,  8 Oct 2024 07:42:59 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.23.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 07:42:59 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v5 0/4] selftests: kvm: s390: Add ucontrol memory selftests
Date: Tue,  8 Oct 2024 09:42:49 +0200
Message-ID: <20241008074253.370481-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6_ZB5olabV3mkGPgqyZURHKHrz6qbNJG
X-Proofpoint-GUID: hsgmLJomMCVH38_JrJwSGkEK85SGsG3w
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_05,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080047

This patch series adds a some not yet picked selftests to the kvm s390x
selftest suite.

The additional test cases are covering:
* Assert KVM_EXIT_S390_UCONTROL exit on not mapped memory access
* Assert functionality of storage keys in ucontrol VM
* Assert that memory region operations are rejected for ucontrol VMs

Running the test cases requires sys_admin capabilities to start the
ucontrol VM.
This can be achieved by running as root or with a command like:

    sudo setpriv --reuid nobody --inh-caps -all,+sys_admin \
      --ambient-caps -all,+sys_admin --bounding-set -all,+sys_admin \
      ./ucontrol_test

---

The patches in this series have been part of the previous patch series.
The test cases added here do depend on the fixture added in the earlier
patches.
From v5 PATCH 7-9 the segment and page table generation has been removed
and DAT
has been disabled. Since DAT is not necessary to validate the KVM code.

https://lore.kernel.org/kvm/20240807154512.316936-1-schlameuss@linux.ibm.com/

v5:
- rebased to current upstream master
- corrected assertion on 0x00 to 0
- reworded fixup commit so that it can be merged on top of current
  upstream

v4:
- fix whitespaces in pointer function arguments (thanks Claudio)
- fix whitespaces in comments (thanks Janosch)

v3:
- fix skey assertion (thanks Claudio)
- introduce a wrapper around UCAS map and unmap ioctls to improve
  readability (Claudio)
- add an displacement to accessed memory to assert translation
  intercepts actually point to segments to the uc_map_unmap test
- add an misaligned failing mapping try to the uc_map_unmap test

v2:
- Reenable KSS intercept and handle it within skey test.
- Modify the checked register between storing (sske) and reading (iske)
  it within the test program to make sure the.
- Add an additional state assertion in the end of uc_skey
- Fix some typos and white spaces.

v1:
- Remove segment and page table generation and disable DAT. This is not
  necessary to validate the KVM code.

Christoph Schlameuss (4):
  selftests: kvm: s390: Add uc_map_unmap VM test case
  selftests: kvm: s390: Add uc_skey VM test case
  selftests: kvm: s390: Verify reject memory region operations for
    ucontrol VMs
  selftests: kvm: s390: Fix whitespace confusion in ucontrol test

 .../selftests/kvm/s390x/ucontrol_test.c       | 262 +++++++++++++++++-
 1 file changed, 257 insertions(+), 5 deletions(-)


base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
-- 
2.46.2


