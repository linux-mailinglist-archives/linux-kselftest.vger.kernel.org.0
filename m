Return-Path: <linux-kselftest+bounces-14723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407DF94613E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBACD283E8A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EDB166F26;
	Fri,  2 Aug 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M8LRgSXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C21A34C3;
	Fri,  2 Aug 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614398; cv=none; b=Fz5do/5bv5X6vWp6l4jsTj7HLtHK4C0XkA7+7S0BLffd5E7p8zP6uk7TEPMJ82NRmXaAidnfgw9UChjjzgI8cGhwobU456dd7wr7CeTAesjrjLoSG3Zs68wVVuPtarn6JcYkvl3vhXQAodFlZ6oef1/x26oi/z6OinWaM2jWRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614398; c=relaxed/simple;
	bh=oGMTRd1Xm8VYZo3Acnb9UzIAod1983sCpUHw6YDFHbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrpMNN8BS462DFGcwmreeYgNyJceKyUDYrTKoGXqv5H+MOGxDYeUZ5Zi3k/rv/4lQR45+snjdYAOSAGeVMJONExecNFC9MIqqKO8rbEzvWNQJ4lz/Cw72uIZk9LwBMzk61Mxx2ihXBONLVGyaYZCn2F0dHTIM+sod534Q5Gdqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M8LRgSXi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472FSrkc013306;
	Fri, 2 Aug 2024 15:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=X9HbMKos5B8R0xg9qxVLzEHcAv
	27CFyBU6a6FDa8TMo=; b=M8LRgSXiV1J49DRmnoWUcyL/ktWf3txh9jbyntAhR4
	8LAdxw8wlVuyf08YpgWjYWLNRfhPCjZKIgPO/UaoRI5WdiH1Y3bDmU2bxGA7BpnQ
	DfnEY0ctDXJ9EX1fam/mF60T1coIqLnSObkpY2qXZe1T83LFNEOPzg3LcmshvJ6Z
	XD69otPoMSHjZ7s3S1ZAmBRFJaBdkPxETRLtzZdQFKkKee8mQEhZTZmrwI4Z/2O3
	38YwB4KTo3V/bPaoPE0IqmMJE4xDBs2VxufFpYTkUTfKPHUs8RL64wqEr9U1Yetk
	EtJ060otbpJqNZQvJax1vq3YmEtPJjXyIE5hW4VRpwfA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s1pf048j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:46 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472Fxkg5003753;
	Fri, 2 Aug 2024 15:59:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s1pf048g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472ElfTf011143;
	Fri, 2 Aug 2024 15:59:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn7wby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472FxcOP47448530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 15:59:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D33C520049;
	Fri,  2 Aug 2024 15:59:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4151F20040;
	Fri,  2 Aug 2024 15:59:38 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.84.102])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 15:59:38 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v4 00/10] selftests: kvm: s390: Add s390x ucontrol selftests
Date: Fri,  2 Aug 2024 17:59:03 +0200
Message-ID: <20240802155913.261891-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DL8WDFs6MTZidyGVr-9k-c03JTry-Vpu
X-Proofpoint-GUID: 0T-SfdAkPb5j2f81CTBLnopgzTToGapI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxlogscore=694 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020110

This patch series adds a selftest suite to validate the s390x
architecture specific ucontrol KVM interface.

When creating a VM on s390x it is possible to create it as userspace
controlled VM or in short ucontrol VM.
These VMs delegates the management of the VM to userspace instead
of handling most events within the kernel. Consequently the userspace
has to manage interrupts, memory allocation etc.

Before this patch set this functionality lacks any public test cases.
It is desirable to add test cases for this interface to be able to
reduce the risk of breaking changes in the future.

In order to provision a ucontrol VM the kernel needs to be compiled with
the CONFIG_KVM_S390_UCONTROL enabled. The users with sys_admin capability
can then create a new ucontrol VM providing the KVM_VM_S390_UCONTROL
parameter to the KVM_CREATE_VM ioctl.

The kernels existing selftest helper functions can only be partially be
reused for these tests.

The test cases cover existing special handling of ucontrol VMs within the
implementation and basic VM creation and handling cases:
* Reject setting HPAGE when VM is ucontrol
* Assert KVM_GET_DIRTY_LOG is rejected
* Assert KVM_S390_VM_MEM_LIMIT_SIZE is rejected
* Assert state of initial SIE flags setup by the kernel
* Run simple program in VM with and without DAT
* Assert KVM_EXIT_S390_UCONTROL exit on not mapped memory access
* Assert functionality of storage keys in ucontrol VM

Running the test cases requires sys_admin capabilities to start the
ucontrol VM.
This can be achieved by running as root or with a command like:

    sudo setpriv --reuid nobody --inh-caps -all,+sys_admin \
      --ambient-caps -all,+sys_admin --bounding-set -all,+sys_admin \
      ./ucontrol_test

The patch set does also contain some code cleanup / consolidation of
architecture specific defines that are now used in multiple test cases.

---

v4:
- PATCH 5: Remove not yet used include for debug print functions
- PATCH 6: Add include for debug print functions (removed from patch 5)
           Remove no longer needed code since stopped but is reset
           before starting since v3 (thanks Janosch)
           Adjust test output to use leading zeros instead of spaces in sieic
- PATCH 7: Rename constant to PGM_SEGMENT_TRANSLATION (thanks Janosch)
           Put comments on their own lines

v3:
- Remove stopped bit before starting the VM (no initial stop in multiple
  test cases) (thanks Janosch)
- PATCH 2: Clarified SIE control block vs SIE instruction (thanks
           Janosch)
- PATCH 3: Make use of CAP_TO_MASK(CAP_SYS_ADMIN) instead of custom
           define (thanks Janosch)
           Removed Reviewed-By: Claudio
- PATCH 4: Remove erroneous 1MB offset from self->base_hva (thanks
           Janosch)
- PATCH 6-8: Change name of test program _pgm to _asm to prevent confusion
- PATCH 10: Move KVM_S390_UCONTROL default option to actual debug config
            (thanks Christian)

v2:
- add ucontrol to s390 debug config (new patch)
- PATCH 2: changed atomic_t to __u32 (thanks Claudio)
- PATCH 4: reformatted comment in FIXTURE_SETUP(uc_kvm)
- PATCH 5: refactored to display 8 byte blocks + more internal reuse
           (thanks Claudio)
- PATCH 7: make use of more declarative defines instead of magic values
- PATCH 8: make use of more declarative defines instead of magic values
           (thanks Claudio)
- PATCH 9: add reference to fix verified by the test case


Christoph Schlameuss (10):
  selftests: kvm: s390: Define page sizes in shared header
  selftests: kvm: s390: Add kvm_s390_sie_block definition for userspace
    tests
  selftests: kvm: s390: Add s390x ucontrol test suite with hpage test
  selftests: kvm: s390: Add test fixture and simple VM setup tests
  selftests: kvm: s390: Add debug print functions
  selftests: kvm: s390: Add VM run test case
  selftests: kvm: s390: Add uc_map_unmap VM test case
  selftests: kvm: s390: Add uc_skey VM test case
  selftests: kvm: s390: Verify reject memory region operations for
    ucontrol VMs
  s390: Enable KVM_S390_UCONTROL config in debug_defconfig

 arch/s390/configs/debug_defconfig             |   1 +
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/s390x/debug_print.h |  69 ++
 .../selftests/kvm/include/s390x/processor.h   |   5 +
 .../testing/selftests/kvm/include/s390x/sie.h | 240 +++++++
 .../selftests/kvm/lib/s390x/processor.c       |  10 +-
 tools/testing/selftests/kvm/s390x/cmma_test.c |   7 +-
 tools/testing/selftests/kvm/s390x/config      |   2 +
 .../testing/selftests/kvm/s390x/debug_test.c  |   4 +-
 tools/testing/selftests/kvm/s390x/memop.c     |   4 +-
 tools/testing/selftests/kvm/s390x/tprot.c     |   5 +-
 .../selftests/kvm/s390x/ucontrol_test.c       | 596 ++++++++++++++++++
 13 files changed, 929 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/debug_print.h
 create mode 100644 tools/testing/selftests/kvm/include/s390x/sie.h
 create mode 100644 tools/testing/selftests/kvm/s390x/config
 create mode 100644 tools/testing/selftests/kvm/s390x/ucontrol_test.c


base-commit: c0ecd6388360d930440cc5554026818895199923
-- 
2.45.2


