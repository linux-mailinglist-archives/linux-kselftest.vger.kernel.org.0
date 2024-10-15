Return-Path: <linux-kselftest+bounces-19710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53DE99E13E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1E3282503
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B51CACE3;
	Tue, 15 Oct 2024 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PBrfiXyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41A18BBA2;
	Tue, 15 Oct 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981477; cv=none; b=DWK70rX6J7elEVGml/t/tmGLiTQRhcfgNQY1k6135ken+u/6U2QcPNEKTdF+sxS5X+dMRRecn6POfXJbjjrzFUCuij4JhC+nhG4+I8ENKqpx33XUCucndBR2ieI5Hd69gYWISP3a/a18X8ZTf6B2WtS3bPROsJZ3aN1oDkSA73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981477; c=relaxed/simple;
	bh=F9ueS+dNmRkuyX9QYkquSySPmhLTtLSQqrPlotxkaKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1AppHOyS2GEnEKFjNq6DWX81L1PAJQLafsuA4+RgZObujxNqra1XXaANS0GWoDCgyv5H7viXhg818aznEPxs1NfXBa5Slxl9HutxAO3+KmtTGJCJCyfpHYoyXxb5cmDxLn8zyCYClP2EYEk/lBV8jMQ5Kn2TXiQVs7bJNxaA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PBrfiXyI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8PH6R023744;
	Tue, 15 Oct 2024 08:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6glPATeFjxG1ODmP5jwuFdfonqDpgJ7kmijdoCVfx
	xE=; b=PBrfiXyIieQ5to17u7DC+l6KkDBcjZOQciEANtPQpjbLs9/KD9QRaKkea
	+x2KLyM5KPBSr8k2rbOT7VfKdlxK9sD34guMkv140tjYQBus7DKy7Zl+Ji1qBbCR
	AXQ44mWjZzDOPgCUIgOhTjjoFhGQRbXJAMOTcVW+4KRlCqwhpxjXCJ87oAEo9KHz
	s+TslvupeCPrVd5754HnzeiKuXCODXHKc+DWWxDoliAP7kH+JHy8KECUPxu6AjED
	locIZIAH/yIXGD/qBTN0XaAoNikGasL8RvpCKFBIGdBhV8BGQc3qlGuSNGnHQHPc
	wY28u8ekmkoPEVO/c/+1RCAU4nXNQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4r1wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49F8brcq019934;
	Tue, 15 Oct 2024 08:37:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4r1w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7P3m9002426;
	Tue, 15 Oct 2024 08:37:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emjsfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8bmGk46792982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:37:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0019D2004D;
	Tue, 15 Oct 2024 08:37:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 723DC20040;
	Tue, 15 Oct 2024 08:37:47 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.49.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 08:37:47 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v6 0/5] selftests: kvm: s390: Add ucontrol memory selftests
Date: Tue, 15 Oct 2024 10:37:39 +0200
Message-ID: <20241015083744.761838-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: roxp-UIrA0yR0NgccKW0tciolRG2_vcs
X-Proofpoint-ORIG-GUID: 5cag4k0GCNRThDkqY-y5VLKu2caXhnRb
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
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150056

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

v6:
- add instruction intercept handling for skey specific instructions
  (iske, sske, rrbe) in addition to kss intercept to work properly on
  all machines
- reorder local variables
- fixup some method comments
- add a patch correcting the IP.b value length a debug message

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

Christoph Schlameuss (5):
  selftests: kvm: s390: Add uc_map_unmap VM test case
  selftests: kvm: s390: Add uc_skey VM test case
  selftests: kvm: s390: Verify reject memory region operations for
    ucontrol VMs
  selftests: kvm: s390: Fix whitespace confusion in ucontrol test
  selftests: kvm: s390: correct IP.b length in uc_handle_sieic debug
    output

 .../selftests/kvm/include/s390x/processor.h   |   6 +
 .../selftests/kvm/s390x/ucontrol_test.c       | 307 +++++++++++++++++-
 2 files changed, 305 insertions(+), 8 deletions(-)


base-commit: eca631b8fe808748d7585059c4307005ca5c5820
-- 
2.47.0


