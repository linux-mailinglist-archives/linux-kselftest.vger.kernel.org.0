Return-Path: <linux-kselftest+bounces-17932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960F977EE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 13:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5575C1C226E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688F1D88AA;
	Fri, 13 Sep 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NwkCqi+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477E2C80;
	Fri, 13 Sep 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228384; cv=none; b=lRIZVc4ck7FRXEdAy0jAepoAmJCgHLfMLJKeD0Gv6CSscKo8BKOLFzHpKPztoKORwCmPPSMgLZIi1KrX0jU2/nIgYZjGPCwOxY/u5y/0WDbrQ1byO9za5vNsG4Sca4UX8D1zM3ZfgXc7Llpg1F2sayzFEuSIILEYyxaafrxz1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228384; c=relaxed/simple;
	bh=wOJG/w8FDLA3spe5ZJ7QpB8SpblXAsXbIk5tDVSnXgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHJUmz50HecEavv5uu1ziXQNSvLBBombignb/GQIRkPB2k2JFWt7Wi19Gg8Yep5/7/x4sFPXzBi9wc/rPr3raLX15VnNGdGongMbt2csgfv/FERh4Ca5SL4DCK38ILefdoZoRGkHtqXO3a+iWnJrMAI8FXDrj3+hG8vu3/b5E+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NwkCqi+Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D1sOQg015997;
	Fri, 13 Sep 2024 11:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=8Q+4sro5+TJX3aVi7+a2u52iQNa42Zx+UZXHFfF
	AfoY=; b=NwkCqi+QmVYqd2zeLZMWHb00kbv5mXmv4dd6Z5dk+NyEqq9Rjrkrr1o
	ANQcZdiKtM1i9dEYQzL16KU3QzYVnftFKkSeP0ZZEfp9SjiLG9Lpcd7N7S1Zqgx9
	ke57oM+W+6LFDmQrwweT6UpFYefHIfE5oWxdRlnBXscCLngAkuMOE1o1mvqmsb13
	IgzBFZhXt4qG21CMH8eBXN6Uh1MooB+cmIRPR4V2I88qkD57hV67ieRMtZJulYNU
	Mx0fybNbU8OiOcFQLbJBu8KuI7UNdWR6/kFoPtoBUp3Esc7FqC4QiTq0m+rKclYo
	3dhHX0tgOOn7Vymj8SqNNXD/R4ex9mQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg01fnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 11:52:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DBqvBJ016566;
	Fri, 13 Sep 2024 11:52:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg01fnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 11:52:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DBaNVk003176;
	Fri, 13 Sep 2024 11:52:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15ue2tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 11:52:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48DBqrcY33620668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 11:52:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5516120043;
	Fri, 13 Sep 2024 11:52:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE8920040;
	Fri, 13 Sep 2024 11:52:52 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.50.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Sep 2024 11:52:52 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v3 0/3] selftests: kvm: s390: Add ucontrol memory selftests
Date: Fri, 13 Sep 2024 13:52:45 +0200
Message-ID: <20240913115248.211071-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3kXoN2JHeVX1ep7JeAZNaXJS5XPduGPY
X-Proofpoint-ORIG-GUID: VYJp0lY-n3vBNEKcqR5DWgTUgvYM7DRK
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
 definitions=2024-09-13_09,2024-09-13_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=980 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130080

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

Christoph Schlameuss (3):
  selftests: kvm: s390: Add uc_map_unmap VM test case
  selftests: kvm: s390: Add uc_skey VM test case
  selftests: kvm: s390: Verify reject memory region operations for
    ucontrol VMs

 .../selftests/kvm/s390x/ucontrol_test.c       | 256 +++++++++++++++++-
 1 file changed, 254 insertions(+), 2 deletions(-)

-- 
2.46.0


