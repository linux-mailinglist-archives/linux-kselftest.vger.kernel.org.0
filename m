Return-Path: <linux-kselftest+bounces-13372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DCA92BA13
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47EB1F23A8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AB15ECF2;
	Tue,  9 Jul 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a92kv/Dp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91715B10D;
	Tue,  9 Jul 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529849; cv=none; b=XWNSgPGWYSkwvFJqJ3SWjZrrw9+ROECjO/Cs/qU0TA9iQ3Ns/m3jjtOnscUclJPYm98++FEk7cHUWdvYwRA5nMqduU3dAWAv1NTnqx5A/RIr6xCzo8fN5AQnhDmcbA8IGCoU7PLwWFSZfzDgggixBKo0yz9koQe0xyfSOKQJrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529849; c=relaxed/simple;
	bh=znhZbxn2LLB6jYKKYb09+HOsY4UnAwDAKKnMCWVlU7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Po8X1zOCNyKeZD7m07LQOzskIhWbMBBE9y5v+sfq7trKrHlKAb9mOSkkyThikdR+n/rwHZY2WE8BNlK+V/Q+K7MwLHIOrhts1zKrQ47I/007pZN7Qqdpm1e7raR+f1OWScyrQmMLwJN/IH8vRDIoGcmh5+9xymDJXn1Mj+xsnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a92kv/Dp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BPFSO014952;
	Tue, 9 Jul 2024 12:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=luY8Nw37jd19OHYjBGh3BpdpWY
	Wx6plh3np9KK0QtZo=; b=a92kv/Dp25VzNxDMFslA70s8Xxm1lTlei9dS02D/TU
	7B0pWQTiAjpJ0LxLxk26fD02insvnVYZt/VkxWAN71Kv95AekfKOcBOlAs+O2Y1h
	CjC1NR33ubLYeXwRp6pD9FLFf6pdyfFsZy4tphZ3KdRtWOIsMtsXeSPaYFaNL61P
	mqltQHaesp+VVkcGNbJuOWwoGTY4GBxRtz5eI+4fXg7xj9Re8BTl7ZowhaffyGVN
	qDiuyTNqsaYyOnzWV6wN0vsT4Ql/F38ZLp3OjmU5UJ3zMdBvFQpgOv88dMCpTMcj
	UYGC8c8+eJ6wZf4whnPBBIT6FAevDaMa1ORF7un6qvgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408v1yhbu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:22 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469CvMaQ017088;
	Tue, 9 Jul 2024 12:57:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408v1yhbu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469CVrVi024600;
	Tue, 9 Jul 2024 12:57:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmmeeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469CvFkN53346580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:57:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF8420043;
	Tue,  9 Jul 2024 12:57:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 003FA20040;
	Tue,  9 Jul 2024 12:57:15 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.6.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 12:57:14 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v1 0/9] selftests: kvm: s390: Add s390x ucontrol selftests
Date: Tue,  9 Jul 2024 14:56:55 +0200
Message-ID: <20240709125704.61312-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9DqWQq9eulL8ml0sgsyx8FxKRdI9Bv8-
X-Proofpoint-ORIG-GUID: QNZwjQxDqcxNQH4xRtvoSNnaEAE0T_lK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=593 clxscore=1011
 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090082

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


Christoph Schlameuss (9):
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

 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/s390x/debug_print.h |  78 +++
 .../selftests/kvm/include/s390x/processor.h   |   5 +
 .../testing/selftests/kvm/include/s390x/sie.h | 240 +++++++
 .../selftests/kvm/lib/s390x/processor.c       |  10 +-
 tools/testing/selftests/kvm/s390x/cmma_test.c |   7 +-
 tools/testing/selftests/kvm/s390x/config      |   2 +
 .../testing/selftests/kvm/s390x/debug_test.c  |   4 +-
 tools/testing/selftests/kvm/s390x/memop.c     |   4 +-
 tools/testing/selftests/kvm/s390x/tprot.c     |   5 +-
 .../selftests/kvm/s390x/ucontrol_test.c       | 612 ++++++++++++++++++
 12 files changed, 953 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/debug_print.h
 create mode 100644 tools/testing/selftests/kvm/include/s390x/sie.h
 create mode 100644 tools/testing/selftests/kvm/s390x/config
 create mode 100644 tools/testing/selftests/kvm/s390x/ucontrol_test.c


base-commit: 256abd8e550ce977b728be79a74e1729438b4948
-- 
2.45.2


