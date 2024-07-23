Return-Path: <linux-kselftest+bounces-14066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEC939DE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E9E284589
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A114D6FB;
	Tue, 23 Jul 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c9ViyqfY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053A14BF9B;
	Tue, 23 Jul 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727131; cv=none; b=i3TMpSMBFSIEfZCyAH1PPg4QokoQXaheErcSi/8OTkBgIVYZpTpnASfn2AaK64SrkIOvyoZKoc9GgUCioXQ4nOEOgo+WngcacVy9ep5VPX4TPVHU2rb70rAGyDMNCpWF2sUeiHIqaqHn/JDm6j+lti05udB4eSUSyX+EC/VDjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727131; c=relaxed/simple;
	bh=JRwAPO+JBai+xZ94ehVPFpxaZBZNflL46NE4Xv/Dm3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpvJeJy61uKIo5f7Dcn1/cbMdWx9SIgn2dB+RYno4Df+IVlGFjimy91lgZp8avthf3NnBoqZOKwc2prFx6iHVtu3j0qCfsZ3p294V5zor+GA23mhl4cbofM9z8oat8xflwAyhVIM/yIIpzpbEvwpRnwvSy/5CfBd2Ys6uNPz3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c9ViyqfY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N8QnVk025921;
	Tue, 23 Jul 2024 09:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=AhrNXMpC07TMN
	Ih7iB9U4EOwWJ59ZFau7Tt0mk/isWU=; b=c9ViyqfYES6szhGG0U1KEiVvmavcz
	Sj8xZdZuTPudDqX8chmYotlOBegnTNxr2FU0KWGNboXHaC1ir3Cdm4scYXkdcfm4
	PS39UPSmI/mUs6lfMxDUz7uEhVnAezdd8UHVFT8cldEz4QYVOMh75X/whyXAc7W1
	sh52292aeg2GopbCGAaqRaSCHjezTkOw5QObiUMJWEuf4z01zS+1DzE36FzmOD2d
	iYL3aYHvWx4upmTqmefgB8Z1UoE50eZ0Gm7A7lzxacZoYUrFR7eYONNdy2sAuFUl
	miYu5cxqEF0x+Y3JQYdbPp+S1m0V9VXJ1QXAw/AW+NYF0IwGE4Ka4EeaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j6uardwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:06 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N9W53E024356;
	Tue, 23 Jul 2024 09:32:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j6uardwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N94x73004921;
	Tue, 23 Jul 2024 09:32:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn79qyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N9VwEE56230214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:32:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A25D72004E;
	Tue, 23 Jul 2024 09:31:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A91E20040;
	Tue, 23 Jul 2024 09:31:58 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.28.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 09:31:57 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 03/10] selftests: kvm: s390: Add s390x ucontrol test suite with hpage test
Date: Tue, 23 Jul 2024 11:31:19 +0200
Message-ID: <20240723093126.285319-4-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723093126.285319-1-schlameuss@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YUd3sRjyVNuT-FrzquwklC5V5YG2iNGQ
X-Proofpoint-ORIG-GUID: QhTM5VewiyGrqmyDY4mQ3BjwNGDAYXB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230069

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
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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


