Return-Path: <linux-kselftest+bounces-21616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7A89C089F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15E5B2269F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB5212EE3;
	Thu,  7 Nov 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="est/mzpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE6212D15;
	Thu,  7 Nov 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988816; cv=none; b=tBFhOjIHw8wMx3vsK7L0ftu/BRU3XjTEGnK5GNyiP5l7gRYNyDDt99b40GFK9ZBNtU2H7pM09ArEgYrfBJ35JHDBHUh8hFOWiTwzDPrnsIHwa6ewWzLZpMG8lTKvVxH6uf9U9uXUlbPeqWcYx5kt/9AKRkqkj/Dg/lk/lqDo4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988816; c=relaxed/simple;
	bh=iq6DAdQIRaZvWkmzepjntWW5vksSWQLsxCK4eVySb80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u76G71yz9Gpru7PB1sEmoN48MD2QCRf4RP0aRcdgE/VHYL509W0QCBU7msjEDO9rcyMpT5GJqtHouCSdFxMmMcohavXtesV9kV9wGQfatQJVVHnkTiTXLZ2h6vkBL9LJZsHMBhBtfg0swna+kJZsjNVLAhT1gracOMFUd8ptYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=est/mzpe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7E9uId031248;
	Thu, 7 Nov 2024 14:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5HgN7AsomUIK+0ZKL8G9kZwooD3hI9sMpOuiPCMTi
	8E=; b=est/mzpeqSflfJeIJiDWZaQgH10lB2vDufYbqD0BYnrj2Wl/Dyx3KoYz/
	Y4gk5kFulGgawZdt+AyCCmTOqO0Th13FFQffOXw5M1n/oDEhUgHTkmEiILULo+Dk
	Kf/ODFjhV0VDPj3bGcsdxswcLwJT1sk2zfkyBcXm//GbXwg12Jj6k7EipXDibJ33
	Uz+HHEAbIKCbfXakO/KBwPE6pzp6pa3WZp/+n2sQaO2Vjy/aUwVZntDyrBm5LmSy
	bj/PDTuoyzrM41wzR3no+fPOtVOwFL83UzBMikqR5soUXNxx/v+DoctYjSBDgTmF
	pg5WlWqcMWtoX3mkF0KY6YkpMnFoQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmrr4kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:10:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DhvW1019625;
	Thu, 7 Nov 2024 14:10:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj87vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:10:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7EAXTM35127974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 14:10:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20B712004B;
	Thu,  7 Nov 2024 14:10:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFD7920049;
	Thu,  7 Nov 2024 14:10:32 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.152.222.253])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 14:10:32 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v7 0/5] selftests: kvm: s390: Add ucontrol memory selftests
Date: Thu,  7 Nov 2024 15:10:19 +0100
Message-ID: <20241107141024.238916-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4y-_h8GtILUojSmEPdJJcAGKbR1BSrPl
X-Proofpoint-GUID: 4y-_h8GtILUojSmEPdJJcAGKbR1BSrPl
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070110

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

v7:
- skip uc_skey test when execution is in vsie

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
 .../selftests/kvm/s390x/ucontrol_test.c       | 321 +++++++++++++++++-
 2 files changed, 319 insertions(+), 8 deletions(-)

-- 
2.47.0


