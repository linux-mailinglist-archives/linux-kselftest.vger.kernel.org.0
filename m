Return-Path: <linux-kselftest+bounces-18066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7715D97AB98
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 08:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376622853D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9079A14D70E;
	Tue, 17 Sep 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XQf5gFSS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7E13CFB6;
	Tue, 17 Sep 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555520; cv=none; b=kwPf2vdTncu0PSklxA6VOb9mPlREC9XL4exI79DP6UZnJ6hSoSA62TcJrnhhq3As9FyS489GfUiRhzuk3aIw9TfHJq7A+YH/IFJvUp+gE0scNVzQM3ELE1icUsSYZ0H2EQVveKG57HGtfId4PQBXLYZKbwfyh8761zptDpFNNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555520; c=relaxed/simple;
	bh=1WVnjWHKVG6Htqc3+7onPrUuitR7qatpkiFEPbpJ3Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JuMVJh/6nlJVaj2kpKz00QdlYDQR5C7vaf0ejwR53mly9KWbZDRlYDs/KQCBLAJG7bosPOozLyGq3A0ojdg7FiT3vmaW33dPFduHb0THJme2d6l2bDi4Tr1PfgB9MPI8OwWxJhmtPPSvJ10MEdBl01c/w5QJ/b9EnIocniqho/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XQf5gFSS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIV0QF007593;
	Tue, 17 Sep 2024 06:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=4BnOgzF2MyUC0vvDdW2YyAHotyscs+bhTWiknVt
	hXPM=; b=XQf5gFSSG+2VOf9pZCgwKwCfoF9WaPlVGiNBQwrjoDzHYxhczJa1LCS
	9ColoSPlTtUi0zTIAzktn1kAhjbMIzfAoCkVXM8AxIk+Lm54xP6krkA9mOOEdux5
	zh9TgRbJPfaTEvdRFGIAECr2i5U1uzNFJG0sdZbhuPWNzYOm3ZutzRudZv5FRjGq
	kg/sANhr0GSZ1Dc8AT2FAKbPHWrauWLg/C3F8uxq/RlC/q7tdaE3g6CqWQ9fUB7U
	eX4B0T9S/aPJY8aqaHmPdsyyFATloB4z+FtVcc9ZXEOUdiYtGyO01db+me4nhryt
	NMoY1Ypsrz3EUi7PNmaXlSgCRVRdhAA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdebu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48H6hVHU013432;
	Tue, 17 Sep 2024 06:45:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdebty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H3SlhV024699;
	Tue, 17 Sep 2024 06:45:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mu9ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48H6j2bh45482438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 06:45:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B67D920043;
	Tue, 17 Sep 2024 06:45:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2880620040;
	Tue, 17 Sep 2024 06:45:02 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.17.198])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 06:45:02 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v4 0/4] selftests: kvm: s390: Add ucontrol memory selftests
Date: Tue, 17 Sep 2024 08:44:52 +0200
Message-ID: <20240917064456.210839-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YoERhJ-pxYUDzUja8AYgd9Ixock9fWfk
X-Proofpoint-GUID: OIwQzjDSILOINYK17IN4sCO-oeMyUbww
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=989 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170049

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
  fixup! selftests: kvm: s390: Add VM run test case

 .../selftests/kvm/s390x/ucontrol_test.c       | 264 +++++++++++++++++-
 1 file changed, 258 insertions(+), 6 deletions(-)

-- 
2.46.0


