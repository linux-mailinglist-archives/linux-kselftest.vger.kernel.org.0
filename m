Return-Path: <linux-kselftest+bounces-14451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259939409DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496A41C22EFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 07:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C586191496;
	Tue, 30 Jul 2024 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZqgEr7A9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8919048D;
	Tue, 30 Jul 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324281; cv=none; b=lNV3L5AAUIh/AgcYU6xVSSNKz71jsLpSqrk9UmDruHBfcmBF/V4vIw+hyhN2vakDDGbM3k63nxdFrMs6SzTMz8vJguPj81UgMoiU1BUhh6SskRWEnw/Uc7NaZZgCkwbN3WMrgBUuF6BH115kBEjX9jJkV4HieHWpvJs0Qbp8jKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324281; c=relaxed/simple;
	bh=Tpyf7GvaMMq8t4b4guvknh49drMVxlzja4LOQc75OTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AeEaoNHEwIIbQhxMUPWUu49VgTAf8jmYSl5VpumoynBst835F77nty1APfslVob2sCQPmMi24RCi4lAtN9DxGNG1khocFtDJzL+0JKaaUeFhHYpZ8v4eNDq9o4v9bQ7mwddifhwnVTmwxOLw2QlmE8LOPLBLehiIQZqKkcqNtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZqgEr7A9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U5UBd5000958;
	Tue, 30 Jul 2024 07:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=4m6wzgDkgmQVzWmywm2p6+e+if
	N0wp/kLwW7hhPH5GY=; b=ZqgEr7A9F1XYN2jxWh/gVPGcmW80P521eo+vzIELdX
	ZVC4YmKOCyHul3/BNJ7C3w7Fuqn7HhPtoDjFcQIakdnQrrQWaCCSLrGMOtlASlDm
	6wCjQFDaWfe9UwnvsAr7QMZRL1HjPQKLmiwBIXWfvdxTCjsA6tniKh7JlBZH7Sl9
	W2ClBjelX0Ka19ZQNxpqM8F3Hq4LMS0uK4LFSTsZVAfmAOMHmvz5LYJbpCks3KHX
	doRBcP2V56GIUgcHGSSjlg5BgZZiex+ECepRWL/SxIipAFuZOOemq9kenWPF0j4m
	z/v1KccvnUX62FhR36PbRTLplPoXl1WSjPPoYqyMHprw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pt2a0epv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:25 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46U7OPqr001087;
	Tue, 30 Jul 2024 07:24:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pt2a0ept-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U7JrTL018867;
	Tue, 30 Jul 2024 07:24:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pkf77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46U7OIOu51839282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 07:24:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7836F2006A;
	Tue, 30 Jul 2024 07:24:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E01D22005A;
	Tue, 30 Jul 2024 07:24:17 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.13.169])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jul 2024 07:24:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v3 00/10] selftests: kvm: s390: Add s390x ucontrol selftests
Date: Tue, 30 Jul 2024 09:24:03 +0200
Message-ID: <20240730072413.143556-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5G50sOiLIWNx6UJU_wnnFpqB9685k5ks
X-Proofpoint-GUID: 6RaM34Tp7k-myF48f8VNEFSU658O096r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=445 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300054

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

V1 -> V2:
- add ucontrol to s390 debug config (new patch)
- PATCH 2: changed atomic_t to __u32 (thanks Claudio)
- PATCH 4: reformatted comment in FIXTURE_SETUP(uc_kvm)
- PATCH 5: refactored to display 8 byte blocks + more internal reuse
           (thanksClaudio)
- PATCH 7: make use of more declarative defines instead of magic values
- PATCH 8: make use of more declarative defines instead of magic values
           (thanks Claudio)
- PATCH 9: add reference to fix verified by the test case

V2 -> V3:
- Remove stopped bit before starting the VM (no initial stop in multiple
  test cases) (thanks Janosch)
- PATCH 2:
  - Clarified SIE control block vs SIE instruction (thanks Janosch)
- PATCH 3:
  - Make use of CAP_TO_MASK(CAP_SYS_ADMIN) instead of custom define (thanks
    Janosch)
  - Removed Reviewed-By: Claudio
- PATCH 4:
  - Remove erroneous 1MB offset from self->base_hva (thanks Janosch)
- PATCH 6-8: Change name of test program _pgm to _asm to prevent confusion
- PATCH 10: Move KVM_S390_UCONTROL default option to actual debug config
            (thanks Christian)


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


base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
-- 
2.45.2


