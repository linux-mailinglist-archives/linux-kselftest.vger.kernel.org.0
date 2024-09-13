Return-Path: <linux-kselftest+bounces-17933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A242E977EEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 13:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261451F2257C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0082C80;
	Fri, 13 Sep 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GrBekTXg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D01D88A4;
	Fri, 13 Sep 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228387; cv=none; b=GfQ243AcG6NNGLw6QuXFcZ3wkaVGwMSZXBf/vGLx8z4Xt0ODP9/rryPuRGE20dc+lkMX/8Mj+w/MUQREx/0dCA1XaQUrgQBYRmfYpdJ4BNHh91MAPfFruCq7emJs8DsGkPwPcknxeClc8Tfg7k81ZiVJixSP0B2m5EvpeTu3dRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228387; c=relaxed/simple;
	bh=gUJCHLhQKdVQ4wUxajfxRwOgNrKyeaUkGEiRMhaimZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoOkz3XmSwkeEg1SgEC89POBmEtxlNw9QwAquZdGydxo4k+VtqhIDajn3WE+bFpuVT8tPIgrMf6J7hbqnFvNlJ1twCXTGbkq53qu0OLphVxj6hdj01i2iAnQtiht1/Fb3CnxT13wAs0599lcDSIjHCKe+zjQIxliyrEzqhmUTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GrBekTXg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D3pmAa001547;
	Fri, 13 Sep 2024 11:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=u61GbNrvmk69l
	SITaPFcfFs89/HJGp4kXZjAZjOGzME=; b=GrBekTXglYW6jKwCnEyDafogY0ZOE
	+5STPkddFc9T85JlSXDY4F/btztswXjgKiZQ3vYKPpGaSk+3xlvVbw0gcXayENWg
	l3/U0tgAakpFesXSkal92jK/Wb5tMG8QCcFrAwlUL95h7egWh8WQVuQ+S4a+E321
	+cgikyLl7ZwrhhfA2NIHPPYYvw4wKil9JGS55/9Ng37UquffrRxsG+VGWJifsSm9
	b+P3qBrpiBz0gknl7Q4vL0SeV0vMlS2ZOgaPN17xuynBFODi3Cn4vPcWfEDTm/Yb
	E7LLi+AWEbUI+FWB1p7M9ah9MubR2X5p/FM1h5NwQB7lgTdHwHM4HrTJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qsy4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 11:53:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DBr0VJ027639;
	Fri, 13 Sep 2024 11:53:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qsy4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 11:53:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D8uZ8c032099;
	Fri, 13 Sep 2024 11:52:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nn5uad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 11:52:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48DBqtfM44695980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 11:52:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D3F20043;
	Fri, 13 Sep 2024 11:52:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0610D20040;
	Fri, 13 Sep 2024 11:52:55 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.50.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Sep 2024 11:52:54 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v3 1/3] selftests: kvm: s390: Add uc_map_unmap VM test case
Date: Fri, 13 Sep 2024 13:52:46 +0200
Message-ID: <20240913115248.211071-2-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913115248.211071-1-schlameuss@linux.ibm.com>
References: <20240913115248.211071-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _NHsg3OPbd0p3IEiYfJrH4IBC1kuDAoK
X-Proofpoint-ORIG-GUID: 1XbXEP5OtjqRM1HQ1BqLB7tyws1hCxKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_09,2024-09-13_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=841 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130080

Add a test case verifying basic running and interaction of ucontrol VMs.
Fill the segment and page tables for allocated memory and map memory on
first access.

* uc_map_unmap
  Store and load data to mapped and unmapped memory and use pic segment
  translation handling to map memory on access.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 145 +++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 030c59010fe1..084cea02c2fa 100644
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
+static void *gpa2hva(FIXTURE_DATA(uc_kvm) * self, u64 gpa)
+{
+	return (void *)(self->base_hva - self->base_gpa + gpa);
+}
+
+/* map / make additional memory available */
+static int uc_map_ext(FIXTURE_DATA(uc_kvm) * self, u64 vcpu_addr, u64 length)
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
+static int uc_unmap_ext(FIXTURE_DATA(uc_kvm) * self, u64 vcpu_addr, u64 length)
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
+static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
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
  * * reset stop requests
  * * fail on codes not expected in the test cases
@@ -256,6 +332,12 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
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
@@ -287,6 +369,67 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
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
2.46.0


