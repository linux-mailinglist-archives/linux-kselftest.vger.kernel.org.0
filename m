Return-Path: <linux-kselftest+bounces-13373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466AB92BA17
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DD7B262D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25F15F31D;
	Tue,  9 Jul 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LfbAauA+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94015B987;
	Tue,  9 Jul 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529850; cv=none; b=cFDqXBkV5DcWxxjKbpB5jWrU2ceUn6slnPhNzhuoGqxX3h80UP8zKsRBWQJhLeFJMEuDUPNTBSXbH6qcZKy3fOWtNXTiMgotnPpPANu4jxPM9BRk0mqoK0IXTwu1bEh14Urp+t8FXliGnIDPwEWxJaws5JPm7iQNgR2qd/akABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529850; c=relaxed/simple;
	bh=EvXtxCanCDxoR16lKE9U8z7G+6JH/u3HJXRDsXkSYgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwQYAQI0ll1+DZ0s1fNWJUnszOTTgmlEecklvOTzTI+r3IIKcWu8wbmbV9tO+BhxKhqACsXtxkByb8AWJHoVfnEVaNLUQTzt9PkhLh6+XVTroN0BCVj39rAEt0DG+tPbIFkyFhujaEQzsAJxVyCF+o+/FpSItkQiGcu8ebCgRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LfbAauA+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469ARQNb000777;
	Tue, 9 Jul 2024 12:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=0QLUBM52IZHtz
	q2swqmnLKx9AAAiUo2TViY95spYmy0=; b=LfbAauA+2JmjG0XhAF1UXyUHhKWoB
	dP+2Eot4jEH+geRXcikBGYrBrMNhOE0RxIHny9dGGWL11HH/+r8fluji8dfcmAnH
	l8BTAVKhBPOGGirRVDdIRAzRxM60q4rgTrnYnmDHIdUaSkz1AgE0ssLjZwJfoXul
	JjjUO3xJgPHIwaKEbbc1n+bneclA17df1dAcPo+cL8Ga03VhVwW8xiKZK57hijHl
	090yG7ue/oSAM+aSGMcIbYsBFT7msvLqgAoAVci1O+H47XLGCQRIxkYg2IJbTKSF
	lhXrhG+bFQsT+fGrYPT8rkxRDeOGgyt5+ZOYoTaScfM0oQm/z60T2JDJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4090ug0ted-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469CvOj9029181;
	Tue, 9 Jul 2024 12:57:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4090ug0tea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4699tTu0006967;
	Tue, 9 Jul 2024 12:57:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmc7v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469CvIuR52101488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:57:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 516D820043;
	Tue,  9 Jul 2024 12:57:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B877E20040;
	Tue,  9 Jul 2024 12:57:17 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.6.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 12:57:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v1 4/9] selftests: kvm: s390: Add test fixture and simple VM setup tests
Date: Tue,  9 Jul 2024 14:56:59 +0200
Message-ID: <20240709125704.61312-5-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: vi6UKkAZFTb_CPu-5aXC3QWGDYOTbi1P
X-Proofpoint-ORIG-GUID: uweKfVO2koZEWiK8r2uwxUAPsOQr5XLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=318
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090080

Add a uc_kvm fixture to create and destroy a ucontrol VM.

* uc_sie_assertions asserts basic settings in the SIE as setup by the
  kernel.
* uc_attr_mem_limit asserts the memory limit is max value and cannot be
  set (not supported).
* uc_no_dirty_log asserts dirty log is not supported.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index a706a9f2b9ea..44945af6d47d 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -9,12 +9,16 @@
  */
 #include "kselftest_harness.h"
 #include "kvm_util.h"
+#include "processor.h"
+#include "sie.h"
 
 #include <linux/capability.h>
 #include <linux/sizes.h>
 
 #define SYS_ADMIN_CAP 0x200000
 
+#define VM_MEM_SIZE (4 * SZ_1M)
+
 /* so directly declare capget to check caps without libcap */
 int capget(cap_user_header_t header, cap_user_data_t data);
 
@@ -38,6 +42,132 @@ void require_ucontrol_admin(void)
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
 }
 
+FIXTURE(uc_kvm)
+{
+	struct kvm_s390_sie_block *sie_block;
+	struct kvm_run *run;
+	uintptr_t base_gpa;
+	uintptr_t code_gpa;
+	uintptr_t base_hva;
+	uintptr_t code_hva;
+	int kvm_run_size;
+	void *vm_mem;
+	int vcpu_fd;
+	int kvm_fd;
+	int vm_fd;
+};
+
+/**
+ * create VM with single vcpu, map kvm_run and SIE control block for easy access
+ */
+FIXTURE_SETUP(uc_kvm)
+{
+	struct kvm_s390_vm_cpu_processor info;
+	int rc;
+
+	require_ucontrol_admin();
+
+	self->kvm_fd = open_kvm_dev_path_or_exit();
+	self->vm_fd = ioctl(self->kvm_fd, KVM_CREATE_VM, KVM_VM_S390_UCONTROL);
+	ASSERT_GE(self->vm_fd, 0);
+
+	kvm_device_attr_get(self->vm_fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_PROCESSOR, &info);
+	TH_LOG("create VM 0x%llx", info.cpuid);
+
+	self->vcpu_fd = ioctl(self->vm_fd, KVM_CREATE_VCPU, 0);
+	ASSERT_GE(self->vcpu_fd, 0);
+
+	self->kvm_run_size = ioctl(self->kvm_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
+	ASSERT_GE(self->kvm_run_size, sizeof(struct kvm_run))
+		  TH_LOG(KVM_IOCTL_ERROR(KVM_GET_VCPU_MMAP_SIZE, self->kvm_run_size));
+	self->run = (struct kvm_run *)mmap(NULL, self->kvm_run_size,
+		    PROT_READ | PROT_WRITE, MAP_SHARED, self->vcpu_fd, 0);
+	ASSERT_NE(self->run, MAP_FAILED);
+	/**
+	 * For virtual cpus that have been created with S390 user
+	 * controlled virtual machines,
+	 * the resulting vcpu fd can be memory mapped at page offset
+	 * KVM_S390_SIE_PAGE_OFFSET in order to obtain a memory map
+	 * of the virtual cpu's hardware control block.
+	 */
+	self->sie_block = (struct kvm_s390_sie_block *)mmap(NULL, PAGE_SIZE,
+			  PROT_READ | PROT_WRITE, MAP_SHARED,
+			  self->vcpu_fd, KVM_S390_SIE_PAGE_OFFSET << PAGE_SHIFT);
+	ASSERT_NE(self->sie_block, MAP_FAILED);
+
+	TH_LOG("VM created %p %p", self->run, self->sie_block);
+
+	self->base_gpa = 0;
+	self->code_gpa = self->base_gpa + (3 * SZ_1M);
+
+	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_SIZE);
+	ASSERT_NE(NULL, self->vm_mem) TH_LOG("malloc failed %u", errno);
+	self->base_hva = (uintptr_t)self->vm_mem + SZ_1M;
+	self->code_hva = self->base_hva - self->base_gpa + self->code_gpa;
+	struct kvm_s390_ucas_mapping map = {
+		.user_addr = self->base_hva,
+		.vcpu_addr = self->base_gpa,
+		.length = VM_MEM_SIZE,
+	};
+	TH_LOG("ucas map %p %p 0x%llx",
+	       (void *)map.user_addr, (void *)map.vcpu_addr, map.length);
+	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map);
+	ASSERT_EQ(0, rc) TH_LOG("ucas map result %d not expected, %s",
+				rc, strerror(errno));
+
+	TH_LOG("page in %p", (void *)self->base_gpa);
+	rc = ioctl(self->vcpu_fd, KVM_S390_VCPU_FAULT, self->base_gpa);
+	ASSERT_EQ(0, rc) TH_LOG("vcpu fault (%p) result %d not expected, %s",
+				(void *)self->base_hva, rc, strerror(errno));
+}
+
+FIXTURE_TEARDOWN(uc_kvm)
+{
+	munmap(self->sie_block, PAGE_SIZE);
+	munmap(self->run, self->kvm_run_size);
+	close(self->vcpu_fd);
+	close(self->vm_fd);
+	close(self->kvm_fd);
+	free(self->vm_mem);
+}
+
+TEST_F(uc_kvm, uc_sie_assertions)
+{
+	/* assert interception of Code 08 (Program Interruption) is set */
+	EXPECT_EQ(0, self->sie_block->ecb & ECB_SPECI);
+}
+
+TEST_F(uc_kvm, uc_attr_mem_limit)
+{
+	u64 limit;
+	struct kvm_device_attr attr = {
+		.group = KVM_S390_VM_MEM_CTRL,
+		.attr = KVM_S390_VM_MEM_LIMIT_SIZE,
+		.addr = (unsigned long)&limit,
+	};
+	int rc;
+
+	rc = ioctl(self->vm_fd, KVM_GET_DEVICE_ATTR, &attr);
+	EXPECT_EQ(0, rc);
+	EXPECT_EQ(~0UL, limit);
+
+	/* assert set not supported */
+	rc = ioctl(self->vm_fd, KVM_SET_DEVICE_ATTR, &attr);
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EINVAL, errno);
+}
+
+TEST_F(uc_kvm, uc_no_dirty_log)
+{
+	struct kvm_dirty_log dlog;
+	int rc;
+
+	rc = ioctl(self->vm_fd, KVM_GET_DIRTY_LOG, &dlog);
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EINVAL, errno);
+}
+
 /**
  * Assert HPAGE CAP cannot be enabled on UCONTROL VM
  */
-- 
2.45.2


