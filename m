Return-Path: <linux-kselftest+bounces-14454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D378D9409E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB652855D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F8919307E;
	Tue, 30 Jul 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jRzUqsYM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8011922DA;
	Tue, 30 Jul 2024 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324282; cv=none; b=jKa3mQIPC9M3HqpBVPTYJo8DN8F7NP7gbITViscEFJktvXFIASIjFQotmgKgQO6UAd89BMzAN2CDSq3xhTWcHjiOmqbdvNDlCFvnOmNCXBA4s19zauiGmKXdSBm7OpBmdWIjihr1/+zA2hJEmPgAJu/37dUsfSjzgLUDqiM1sY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324282; c=relaxed/simple;
	bh=q1tyQEs7i1pdW8QrXQnxXUg5iHI6OGE14cBdf+BjPbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTJizI0VRn5hxKo9a3KRGpiUkDpGne5j7uyjLkdsmlkSZ6RCIbcBivGqeTojRIbPIFkR6Cfk+lK5GdRM4eN3pr7v2CpqE2lnBCuAjFf37Ugk9HrM1r0YmFrbs57St04NnRf/nn/sSIocdoWQTvJPjWvpVXkuA9n7x8Ff8QSvQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jRzUqsYM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U5U7QP000939;
	Tue, 30 Jul 2024 07:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=l3V6hV9IcIucE
	WoEs+XRqPoyDjvdPL+TKpZR1jB5ZEk=; b=jRzUqsYMS1ycpkQILUJA3OarRAmgB
	oYJ1Wqbe8T99EOer6FGKw9gCqe7b+sZ01SX8KJwTOa+Y7Laj5RpaCKiX8emP/ud4
	CMHyzVYMOOmYbzf6xGxGqcOFWP2EcRmPtJ1vB9rFAIxFtBXbdKWqp9RzSscKo/dL
	jJuOhJX5+waYp4xuDRj/LEZ5h0B7f5O+GtpTwah2AyuvNJFZ68pp9rGH81yquSmN
	FEya1sTDJAwJrv+/fwZNXMQKcnEtEIrAsIhkQ9PD9XL2i1w33HVS3Hur0MmmdhyF
	u3RmJkKKyUOH2oE1SPLplqGzukozfrYmNcjAUSJp1YI1R7iFrnBaShfOg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pt2a0eqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:29 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46U7OTal001216;
	Tue, 30 Jul 2024 07:24:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pt2a0eqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U5bNfY009211;
	Tue, 30 Jul 2024 07:24:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx2u41t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46U7OMs755443942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 07:24:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B75CA20067;
	Tue, 30 Jul 2024 07:24:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BEEA20040;
	Tue, 30 Jul 2024 07:24:22 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.13.169])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jul 2024 07:24:22 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v3 03/10] selftests: kvm: s390: Add s390x ucontrol test suite with hpage test
Date: Tue, 30 Jul 2024 09:24:06 +0200
Message-ID: <20240730072413.143556-4-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730072413.143556-1-schlameuss@linux.ibm.com>
References: <20240730072413.143556-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I3Na3Ro40ZoaznD1VWzYS5-_UGN2J928
X-Proofpoint-GUID: PzeGeNCvxMaH6Y0fjTdgwR3kP-DTpD4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300054

Add test suite to validate the s390x architecture specific ucontrol KVM
interface.

Make use of the selftest test harness.

* uc_cap_hpage testcase verifies that a ucontrol VM cannot be run with
  hugepages.

To allow testing of the ucontrol interface the kernel needs a
non-default config containing CONFIG_KVM_S390_UCONTROL.
This config needs to be set to built-in (y) as this cannot be built as
module.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  1 +
 tools/testing/selftests/kvm/s390x/config      |  2 +
 .../selftests/kvm/s390x/ucontrol_test.c       | 76 +++++++++++++++++++
 4 files changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390x/config
 create mode 100644 tools/testing/selftests/kvm/s390x/ucontrol_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 6d9381d60172..f2a30a58cd71 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -5,3 +5,4 @@
 !*.h
 !*.S
 !*.sh
+!config
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 48d32c5aa3eb..b3dc0a5bf0d4 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -186,6 +186,7 @@ TEST_GEN_PROGS_s390x += s390x/tprot
 TEST_GEN_PROGS_s390x += s390x/cmma_test
 TEST_GEN_PROGS_s390x += s390x/debug_test
 TEST_GEN_PROGS_s390x += s390x/shared_zeropage_test
+TEST_GEN_PROGS_s390x += s390x/ucontrol_test
 TEST_GEN_PROGS_s390x += demand_paging_test
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += guest_print_test
diff --git a/tools/testing/selftests/kvm/s390x/config b/tools/testing/selftests/kvm/s390x/config
new file mode 100644
index 000000000000..23270f2d679f
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390x/config
@@ -0,0 +1,2 @@
+CONFIG_KVM=y
+CONFIG_KVM_S390_UCONTROL=y
diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
new file mode 100644
index 000000000000..cd68e7e37d35
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test code for the s390x kvm ucontrol interface
+ *
+ * Copyright IBM Corp. 2024
+ *
+ * Authors:
+ *  Christoph Schlameuss <schlameuss@linux.ibm.com>
+ */
+#include "kselftest_harness.h"
+#include "kvm_util.h"
+
+#include <linux/capability.h>
+#include <linux/sizes.h>
+
+/* so directly declare capget to check caps without libcap */
+int capget(cap_user_header_t header, cap_user_data_t data);
+
+/**
+ * In order to create user controlled virtual machines on S390,
+ * check KVM_CAP_S390_UCONTROL and use the flag KVM_VM_S390_UCONTROL
+ * as privileged user (SYS_ADMIN).
+ */
+void require_ucontrol_admin(void)
+{
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	int rc;
+
+	rc = capget(&hdr, data);
+	TEST_ASSERT_EQ(0, rc);
+	TEST_REQUIRE((data->effective & CAP_TO_MASK(CAP_SYS_ADMIN)) > 0);
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
+}
+
+/**
+ * Assert HPAGE CAP cannot be enabled on UCONTROL VM
+ */
+TEST(uc_cap_hpage)
+{
+	int rc, kvm_fd, vm_fd, vcpu_fd;
+	struct kvm_enable_cap cap = {
+		.cap = KVM_CAP_S390_HPAGE_1M,
+	};
+
+	require_ucontrol_admin();
+
+	kvm_fd = open_kvm_dev_path_or_exit();
+	vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, KVM_VM_S390_UCONTROL);
+	ASSERT_GE(vm_fd, 0);
+
+	/* assert hpages are not supported on ucontrol vm */
+	rc = ioctl(vm_fd, KVM_CHECK_EXTENSION, KVM_CAP_S390_HPAGE_1M);
+	EXPECT_EQ(0, rc);
+
+	/* Test that KVM_CAP_S390_HPAGE_1M can't be enabled for a ucontrol vm */
+	rc = ioctl(vm_fd, KVM_ENABLE_CAP, cap);
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* assert HPAGE CAP is rejected after vCPU creation */
+	vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
+	ASSERT_GE(vcpu_fd, 0);
+	rc = ioctl(vm_fd, KVM_ENABLE_CAP, cap);
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EBUSY, errno);
+
+	close(vcpu_fd);
+	close(vm_fd);
+	close(kvm_fd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.45.2


