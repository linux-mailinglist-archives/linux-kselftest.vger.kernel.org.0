Return-Path: <linux-kselftest+bounces-21615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91A9C089B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 15:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3741C231BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918C628F1;
	Thu,  7 Nov 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F+W10vFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0118FDAF;
	Thu,  7 Nov 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988815; cv=none; b=quRFdkd4D0/3c919IWnTN+AEBZQdjtg3GiluMzq6Lcd5d54gv5+Dgv6bPNDT97WNJmF+rK4lu4O5CuAluz8C4+l4kFhPzQ6iS8bwmk5Y0KCiFzjLYT5Y/dempWFpEeEkbmowdU7BQCfHBX0JwBjsABjMNv7oTPiMYABayc/pDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988815; c=relaxed/simple;
	bh=6lOJEzI0QWAPdZ6l1fS/HVSCwwtzhcGUDdy6aty1/hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEMVQGi2xq0W9lkczUPw6wlBoqdV4wHn9ydi5V2AB0815ZKMBi3beyV+PNq7HKDhHwHQv4qNWp4TbxFKvlOxdPpPj0TB2YiOq5gMge70Byn9tMTO/0SdhRFt3xQPEttyoc/KHjrF5Lj0iowSycsuCZ6scVAQXIqDHG9TK1A8p1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F+W10vFb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DlntN024334;
	Thu, 7 Nov 2024 14:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O6grBrTenTP7F/myh
	ynBewmjPvgmcxywUYxsrPoXA9M=; b=F+W10vFbvvGaGDblQn/qvU1+f+xrjsBM6
	Xu5ko5RU+XfOjTBFBq2zlF7PIqf8/dAvVkYI5sQC1+NQTEhm2wPJNqfVL0SOJbkT
	fXIFdq+7MrpOwyfcUz6YeBPGF5zun18zFCwJ3zvKI4Q2lL11sF/N4dGH89QZ554g
	kE/oL+BDShMTibDafaVXvModvYaDtJMBs1YSmSzTTySNh8wHhbLZ2eOQqnEXpO9Z
	6/bL0puIiJ3NcJ/2Tn7hP+zasy7p/yyo08yrvnVciYJifZ/J+5kvae3FnB3jI0Aw
	JdGFqr5vrCQDYrmiu77E0DdqmGKVwYo3hkoAoJr3Kx9pRkLtRsGLQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmnr6s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:10:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7D7xG2024174;
	Thu, 7 Nov 2024 14:10:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsyydvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:10:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7EAYbC55902538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 14:10:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4493F20049;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1708C20040;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.152.222.253])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v7 1/5] selftests: kvm: s390: Add uc_map_unmap VM test case
Date: Thu,  7 Nov 2024 15:10:20 +0100
Message-ID: <20241107141024.238916-2-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107141024.238916-1-schlameuss@linux.ibm.com>
References: <20241107141024.238916-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9KSk1NtHTq1jgbpNFJ95MPpC5LK2wCls
X-Proofpoint-ORIG-GUID: 9KSk1NtHTq1jgbpNFJ95MPpC5LK2wCls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=844
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070110

Add a test case verifying basic running and interaction of ucontrol VMs.
Fill the segment and page tables for allocated memory and map memory on
first access.

* uc_map_unmap
  Store and load data to mapped and unmapped memory and use pic segment
  translation handling to map memory on access.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 145 +++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index f257beec1430..3e649b12a0b9 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -16,7 +16,11 @@
 #include <linux/capability.h>
 #include <linux/sizes.h>
 
+#define PGM_SEGMENT_TRANSLATION 0x10
+
 #define VM_MEM_SIZE (4 * SZ_1M)
+#define VM_MEM_EXT_SIZE (2 * SZ_1M)
+#define VM_MEM_MAX_M ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M)
 
 /* so directly declare capget to check caps without libcap */
 int capget(cap_user_header_t header, cap_user_data_t data);
@@ -58,6 +62,23 @@ asm("test_gprs_asm:\n"
 	"	j	0b\n"
 );
 
+/* Test program manipulating memory */
+extern char test_mem_asm[];
+asm("test_mem_asm:\n"
+	"xgr	%r0, %r0\n"
+
+	"0:\n"
+	"	ahi	%r0,1\n"
+	"	st	%r1,0(%r5,%r6)\n"
+
+	"	xgr	%r1,%r1\n"
+	"	l	%r1,0(%r5,%r6)\n"
+	"	ahi	%r0,1\n"
+	"	diag	0,0,0x44\n"
+
+	"	j	0b\n"
+);
+
 FIXTURE(uc_kvm)
 {
 	struct kvm_s390_sie_block *sie_block;
@@ -67,6 +88,7 @@ FIXTURE(uc_kvm)
 	uintptr_t base_hva;
 	uintptr_t code_hva;
 	int kvm_run_size;
+	vm_paddr_t pgd;
 	void *vm_mem;
 	int vcpu_fd;
 	int kvm_fd;
@@ -116,7 +138,7 @@ FIXTURE_SETUP(uc_kvm)
 	self->base_gpa = 0;
 	self->code_gpa = self->base_gpa + (3 * SZ_1M);
 
-	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_SIZE);
+	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_MAX_M * SZ_1M);
 	ASSERT_NE(NULL, self->vm_mem) TH_LOG("malloc failed %u", errno);
 	self->base_hva = (uintptr_t)self->vm_mem;
 	self->code_hva = self->base_hva - self->base_gpa + self->code_gpa;
@@ -222,6 +244,60 @@ TEST(uc_cap_hpage)
 	close(kvm_fd);
 }
 
+/* calculate host virtual addr from guest physical addr */
+static void *gpa2hva(FIXTURE_DATA(uc_kvm) *self, u64 gpa)
+{
+	return (void *)(self->base_hva - self->base_gpa + gpa);
+}
+
+/* map / make additional memory available */
+static int uc_map_ext(FIXTURE_DATA(uc_kvm) *self, u64 vcpu_addr, u64 length)
+{
+	struct kvm_s390_ucas_mapping map = {
+		.user_addr = (u64)gpa2hva(self, vcpu_addr),
+		.vcpu_addr = vcpu_addr,
+		.length = length,
+	};
+	pr_info("ucas map %p %p 0x%llx",
+		(void *)map.user_addr, (void *)map.vcpu_addr, map.length);
+	return ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map);
+}
+
+/* unmap previously mapped memory */
+static int uc_unmap_ext(FIXTURE_DATA(uc_kvm) *self, u64 vcpu_addr, u64 length)
+{
+	struct kvm_s390_ucas_mapping map = {
+		.user_addr = (u64)gpa2hva(self, vcpu_addr),
+		.vcpu_addr = vcpu_addr,
+		.length = length,
+	};
+	pr_info("ucas unmap %p %p 0x%llx",
+		(void *)map.user_addr, (void *)map.vcpu_addr, map.length);
+	return ioctl(self->vcpu_fd, KVM_S390_UCAS_UNMAP, &map);
+}
+
+/* handle ucontrol exit by mapping the accessed segment */
+static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) *self)
+{
+	struct kvm_run *run = self->run;
+	u64 seg_addr;
+	int rc;
+
+	TEST_ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
+	switch (run->s390_ucontrol.pgm_code) {
+	case PGM_SEGMENT_TRANSLATION:
+		seg_addr = run->s390_ucontrol.trans_exc_code & ~(SZ_1M - 1);
+		pr_info("ucontrol pic segment translation 0x%llx, mapping segment 0x%lx\n",
+			run->s390_ucontrol.trans_exc_code, seg_addr);
+		/* map / make additional memory available */
+		rc = uc_map_ext(self, seg_addr, SZ_1M);
+		TEST_ASSERT_EQ(0, rc);
+		break;
+	default:
+		TEST_FAIL("UNEXPECTED PGM CODE %d", run->s390_ucontrol.pgm_code);
+	}
+}
+
 /* verify SIEIC exit
  * * fail on codes not expected in the test cases
  */
@@ -255,6 +331,12 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
 	struct kvm_run *run = self->run;
 
 	switch (run->exit_reason) {
+	case KVM_EXIT_S390_UCONTROL:
+		/** check program interruption code
+		 * handle page fault --> ucas map
+		 */
+		uc_handle_exit_ucontrol(self);
+		break;
 	case KVM_EXIT_S390_SIEIC:
 		return uc_handle_sieic(self);
 	default:
@@ -286,6 +368,67 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
 	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
 }
 
+TEST_F(uc_kvm, uc_map_unmap)
+{
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_run *run = self->run;
+	const u64 disp = 1;
+	int rc;
+
+	/* copy test_mem_asm to code_hva / code_gpa */
+	TH_LOG("copy code %p to vm mapped memory %p / %p",
+	       &test_mem_asm, (void *)self->code_hva, (void *)self->code_gpa);
+	memcpy((void *)self->code_hva, &test_mem_asm, PAGE_SIZE);
+
+	/* DAT disabled + 64 bit mode */
+	run->psw_mask = 0x0000000180000000ULL;
+	run->psw_addr = self->code_gpa;
+
+	/* set register content for test_mem_asm to access not mapped memory*/
+	sync_regs->gprs[1] = 0x55;
+	sync_regs->gprs[5] = self->base_gpa;
+	sync_regs->gprs[6] = VM_MEM_SIZE + disp;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+
+	/* run and expect to fail with ucontrol pic segment translation */
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(1, sync_regs->gprs[0]);
+	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
+
+	ASSERT_EQ(PGM_SEGMENT_TRANSLATION, run->s390_ucontrol.pgm_code);
+	ASSERT_EQ(self->base_gpa + VM_MEM_SIZE, run->s390_ucontrol.trans_exc_code);
+
+	/* fail to map memory with not segment aligned address */
+	rc = uc_map_ext(self, self->base_gpa + VM_MEM_SIZE + disp, VM_MEM_EXT_SIZE);
+	ASSERT_GT(0, rc)
+		TH_LOG("ucas map for non segment address should fail but didn't; "
+		       "result %d not expected, %s", rc, strerror(errno));
+
+	/* map / make additional memory available */
+	rc = uc_map_ext(self, self->base_gpa + VM_MEM_SIZE, VM_MEM_EXT_SIZE);
+	ASSERT_EQ(0, rc)
+		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	uc_assert_diag44(self);
+
+	/* assert registers and memory are in expected state */
+	ASSERT_EQ(2, sync_regs->gprs[0]);
+	ASSERT_EQ(0x55, sync_regs->gprs[1]);
+	ASSERT_EQ(0x55, *(u32 *)gpa2hva(self, self->base_gpa + VM_MEM_SIZE + disp));
+
+	/* unmap and run loop again */
+	rc = uc_unmap_ext(self, self->base_gpa + VM_MEM_SIZE, VM_MEM_EXT_SIZE);
+	ASSERT_EQ(0, rc)
+		TH_LOG("ucas unmap result %d not expected, %s", rc, strerror(errno));
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(3, sync_regs->gprs[0]);
+	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
+	ASSERT_EQ(PGM_SEGMENT_TRANSLATION, run->s390_ucontrol.pgm_code);
+	/* handle ucontrol exit and remap memory after previous map and unmap */
+	ASSERT_EQ(true, uc_handle_exit(self));
+}
+
 TEST_F(uc_kvm, uc_gprs)
 {
 	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
-- 
2.47.0


