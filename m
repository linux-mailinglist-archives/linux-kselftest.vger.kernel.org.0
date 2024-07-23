Return-Path: <linux-kselftest+bounces-14068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE1939DE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F00F1F23131
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9390214E2E1;
	Tue, 23 Jul 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pG2Ql5Of"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1F14D432;
	Tue, 23 Jul 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727132; cv=none; b=BXagHfniaSXkxODJrrYyIKNsUtsyrjBbep7SXGPAsSbWE54wqt4a7HxtXaHL5hOtDL+lPXjb1REW4e21Dderse2qfXRrvWRDzZH46IlqJnueVANqsU3ndloLo++uw1DA0z9maEiaoQaSlr3VzwL6jVR/BIZMLfRKNsLKbN7IdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727132; c=relaxed/simple;
	bh=f5smg5nLrkQWVYhKiY3CHFpG9kgHIiwO0tc7vK1+Gog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXLw/j0QvgBK96DChqkuBpclsBOZrVrXl/oaLn8SM3mGpgE4wBSuVDqz0gJ0iNmA4PxShz8JbjjLvBhzSf9qe6nNCjqlTQKuR92ti02WpO2vBe6FPoHyCxr05ovghL7FtlrTL27mTxS2Xo4DjDPnQkWnC9MG8+Ak2rtel1iaXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pG2Ql5Of; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N8QHjJ027710;
	Tue, 23 Jul 2024 09:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=mTiORae4fO3QnxSZi64LA/mdHe
	QAXFMdnrahKk2VS0E=; b=pG2Ql5Of8BOtlVwbgfig/5P21w6N0nt0kfMkDVrVQX
	O1JJe8Vt4sJlsxJq2GMWR8Fvu0EhA0hdGQ4nKLBQyQwvscRO6hf/GkXKRJbMA2Nu
	EnLjdo2ZrYGKxLagJ0F4nk7uyISPYA4Rui8rTKuk+5BDxsDXfQQskVVqbxymF6xF
	KBRSGDVfgPHECuYLrCjGoYtqvclK1dZ5aXvQ6bwWKoMGwFqOFjLsudWhdws5+lSn
	jLXe7IayaCsB/YjMpxj0CXOjGMqOMjrX8Kf9oXo/SFxTfRVcHWxQD+MLWZ4q3DpN
	8sJHs1eqwHmtW5xfzOk8YNd5i+M/jiMGIZicw4OE0JPw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hwma1dyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:01 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N9TNi6021421;
	Tue, 23 Jul 2024 09:32:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hwma1dye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N5kdYQ005776;
	Tue, 23 Jul 2024 09:31:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2p9ntt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:31:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N9VsWf56230254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:31:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1359D2004E;
	Tue, 23 Jul 2024 09:31:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 740CE20049;
	Tue, 23 Jul 2024 09:31:53 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.28.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 09:31:53 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 00/10] selftests: kvm: s390: Add s390x ucontrol selftests
Date: Tue, 23 Jul 2024 11:31:16 +0200
Message-ID: <20240723093126.285319-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4b9AZbJQh6fag_PntW3vvL9hySAgwnHZ
X-Proofpoint-GUID: ESRV06PVpZHFbXE2WyLtIsuFsuxHdQAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=623 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230065

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

 arch/s390/Kconfig.debug                       |   3 +
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
 .../selftests/kvm/s390x/ucontrol_test.c       | 614 ++++++++++++++++++
 13 files changed, 949 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/debug_print.h
 create mode 100644 tools/testing/selftests/kvm/include/s390x/sie.h
 create mode 100644 tools/testing/selftests/kvm/s390x/config
 create mode 100644 tools/testing/selftests/kvm/s390x/ucontrol_test.c


base-commit: 66ebbdfdeb093e097399b1883390079cd4c3022b
-- 
2.45.2


