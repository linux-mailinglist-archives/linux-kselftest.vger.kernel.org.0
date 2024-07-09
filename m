Return-Path: <linux-kselftest+bounces-13371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537AD92BA10
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D79286776
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCFA15ECD0;
	Tue,  9 Jul 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cQmhUSAu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC515B57D;
	Tue,  9 Jul 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529849; cv=none; b=Y86wO/zh29w2BPo/MFsNFYZ3hqEa/g18qh02GqBIeKv3Su8ntXDWvJLRo0/O2pll1l8HdixZVi/z8npZJcMAsU+A/2hjmreLNPQxXZ3RG+YnoGBsbd15j0mMu9wfmi+t6Oi51tp09v+ey71NN5MvzoZZ9Atk23/IXFSG1/W17TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529849; c=relaxed/simple;
	bh=bcR+ALDuwiDM+mkEY22n9NwJDHMxkik7jTDzEyuPdd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muwPNcUACHwEnBsbrFE2qTNMwOmOZt2EulHue1zcIgpcllGUbR2sIoxkj+P0rKXqP+tmSv5/lIK3npMZHFF+IzkhwTpetZw9o4VzLqCv6ULaehKplqdz6xjaMyPf9MOE78O1vyakdt67i2jW38hj5K/yDmip1fVgESDqrmMTCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cQmhUSAu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CvPO8003168;
	Tue, 9 Jul 2024 12:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=MwvJR2AR7Vd9X
	O0PjCNgmL3b7LA9YsaYuqd9GjPPN0k=; b=cQmhUSAu3kuyNm5knn9agqzIkWzv/
	aTsfGbLcynTZftqRF2dushKq+20iBcD1SJqqtfLIO7bBHxPQkvqiWYSHo97uMBJ6
	AuW1/xJA6EO3su/ZNBJuX5QPOxYx7Cr7GgGhL8pawaH/9nhq+MknLMARUTDaQ5mV
	0I2dtvh0M1uLIkSD3cVsggV7w0G9gqYkwQNk8Pc70PKT7DdqXGTgadN4awu+5Hh/
	DJcUmS7vfuf0i6Rdg0DRq0qvLg160CvgGZ/ba70cUX9ZSfuluFlUbvn5+sSLrjrs
	4mwpZEw/r1zEqcwFyff2T3OV3IoJh/L1MOuOsXI3vjRO6mH7psJ3iaiUA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4093fv0bev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469CvOto003156;
	Tue, 9 Jul 2024 12:57:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4093fv0bes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4699tTtx006967;
	Tue, 9 Jul 2024 12:57:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmc7v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469CvHel25166572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:57:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A15252004F;
	Tue,  9 Jul 2024 12:57:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1387C20040;
	Tue,  9 Jul 2024 12:57:17 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.6.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 12:57:16 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v1 3/9] selftests: kvm: s390: Add s390x ucontrol test suite with hpage test
Date: Tue,  9 Jul 2024 14:56:58 +0200
Message-ID: <20240709125704.61312-4-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709125704.61312-1-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JpKRFGV2MopqVqk0RO3K2zg1W6GBXuRK
X-Proofpoint-GUID: vWsYnheSPAOyDYUQWviRAC_X0mW66MJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 mlxlogscore=969 impostorscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090082

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
 .../selftests/kvm/s390x/ucontrol_test.c       | 78 +++++++++++++++++++
 4 files changed, 82 insertions(+)
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
index ac280dcba996..3b33b3975c93 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -184,6 +184,7 @@ TEST_GEN_PROGS_s390x += s390x/tprot
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
index 000000000000..a706a9f2b9ea
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -0,0 +1,78 @@
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
+#define SYS_ADMIN_CAP 0x200000
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
+	TEST_REQUIRE((data->effective & SYS_ADMIN_CAP) > 0);
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


