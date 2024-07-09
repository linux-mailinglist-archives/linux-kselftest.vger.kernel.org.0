Return-Path: <linux-kselftest+bounces-13377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A96992BA23
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127B52867B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDB11607BD;
	Tue,  9 Jul 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h+LbDsi1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B515B10D;
	Tue,  9 Jul 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529852; cv=none; b=I9uOHg30CaoMyXFamjF/UEkFX2wzm/NlDLGYSQ9hBHAtcM638RwUBth28N21x0jpsmNUdIwYUjXbuT4yyaXP/ut63h7EeINe63u3rq6MoCHE1SvJ7fG5315i2IEmVxoAWaSgY1QfOCgHJ3900JtqSPATmHM/XJaQztLII/c291w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529852; c=relaxed/simple;
	bh=/S+/mhEDSE2WXbla6zCW93xg6+VZusMpVIXgDa5X0sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OE4mXOkNbPG5omi3aBYx/ja0BM/afQRsSN2o2v8rkLlR34DL8tQIZj7wTT85AjIVtMZjUuU/sWvX9DoxJMNsx14l0jHGfw38LTUG/YlVmV0JxjKwI3CGCJw5PXWwtMam8VqkVdh9dsxV1/xEQlGQXs6PqZj/H7E078qlXwJwh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h+LbDsi1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4698wgrG009385;
	Tue, 9 Jul 2024 12:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=89xDSOUviJUo5
	rFcmxvxZ4qbOnOU7ROaCKwQLByon0U=; b=h+LbDsi10ssjUvl2gFcad2Pk7mwk7
	NEwAob3fd0gCUMyZjTi9/ChphQCZjlLpluQLKoCzxAkjnx4YyD18wYyK5DT3uJoc
	3xv7dCocAqNsXq+OgmSgfgQXWWjP/XXeSYAg9R/NqG9TX78eLLRs+zzX1t7byJME
	Ay0WzBiS9YdJHXdo3bzG/kJyLbfEifDYYKqFeYvYqpavU4wkGaJNOIvqizde8E3Y
	RLB3g5DUwXeBv3WiHtzo/kZF2ASIu349vhMgrxjurhY5ClrsnKmMdozojIAS+adK
	zJs6bQd054yl7Rs7ip11DaKkjrB6rh5ZH9SuAziaVq8EPEAquK/AtqaHQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40925q0jkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469CsU2w011243;
	Tue, 9 Jul 2024 12:57:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40925q0jkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469BBuqx024698;
	Tue, 9 Jul 2024 12:57:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8u4s54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469CvKr956361304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:57:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55D7E2004F;
	Tue,  9 Jul 2024 12:57:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC0920040;
	Tue,  9 Jul 2024 12:57:19 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.6.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 12:57:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v1 7/9] selftests: kvm: s390: Add uc_map_unmap VM test case
Date: Tue,  9 Jul 2024 14:57:02 +0200
Message-ID: <20240709125704.61312-8-schlameuss@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 8VKO4M_RqJJ4eOV3vmyKN4OXE7XDLu4j
X-Proofpoint-GUID: Kf5uCrq65uRWjrQKxMnFgLPiIxmqYhgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=893 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090082

Add a test case verifying basic running and interaction of ucontrol VMs.
Fill the segment and page tables for allocated memory and map memory on
first access.

* uc_map_unmap
  Store and load data to mapped and unmapped memory and use pic segment
  translation handling to map memory on access.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 169 +++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index deeb9d089124..4438cfc8bf53 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -19,6 +19,10 @@
 #define SYS_ADMIN_CAP 0x200000
 
 #define VM_MEM_SIZE (4 * SZ_1M)
+#define VM_MEM_EXT_SIZE (2 * SZ_1M)
+#define VM_MEM_MAX (VM_MEM_SIZE + VM_MEM_EXT_SIZE)
+
+#define PAGES_PER_SEGMENT 4
 
 /* so directly declare capget to check caps without libcap */
 int capget(cap_user_header_t header, cap_user_data_t data);
@@ -60,6 +64,23 @@ asm("test_gprs_pgm:\n"
 	"	j	0b\n"
 );
 
+/* Test program manipulating memory */
+extern char test_mem_pgm[];
+asm("test_mem_pgm:\n"
+	"xgr	%r0, %r0\n"
+
+	"0:\n"
+	"	ahi	%r0,1\n"
+	"	st	%r1,0(%r5,%r6)\n"
+
+	"	xgr	%r1, %r1\n"
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
@@ -69,6 +90,7 @@ FIXTURE(uc_kvm)
 	uintptr_t base_hva;
 	uintptr_t code_hva;
 	int kvm_run_size;
+	vm_paddr_t pgd;
 	void *vm_mem;
 	int vcpu_fd;
 	int kvm_fd;
@@ -119,7 +141,7 @@ FIXTURE_SETUP(uc_kvm)
 	self->base_gpa = 0;
 	self->code_gpa = self->base_gpa + (3 * SZ_1M);
 
-	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_SIZE);
+	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_SIZE + VM_MEM_EXT_SIZE);
 	ASSERT_NE(NULL, self->vm_mem) TH_LOG("malloc failed %u", errno);
 	self->base_hva = (uintptr_t)self->vm_mem + SZ_1M;
 	self->code_hva = self->base_hva - self->base_gpa + self->code_gpa;
@@ -223,6 +245,75 @@ TEST(uc_cap_hpage)
 	close(kvm_fd);
 }
 
+/* calculate host virtual addr from guest physical addr */
+static void *gpa2hva(FIXTURE_DATA(uc_kvm) * self, u64 gpa)
+{
+	return (void *)(self->base_hva - self->base_gpa + gpa);
+}
+
+/* initialize segment and page tables for uc_kvm tests */
+static void init_st_pt(FIXTURE_DATA(uc_kvm) * self)
+{
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_run *run = self->run;
+	void *se_addr;
+	int si, pi;
+	u64 *phd;
+
+	self->pgd = self->base_gpa + SZ_1M; /* set PASCE addr */
+	phd = gpa2hva(self, self->pgd);
+	memset(phd, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
+
+	for (si = 0; si < ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M); si++) {
+		/* create ste */
+		phd[si] = (self->pgd
+			+ (PAGES_PER_SEGMENT * PAGE_SIZE
+				* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M))
+			+ (PAGES_PER_SEGMENT * PAGE_SIZE * si)) & ~0x7fful;
+		se_addr = gpa2hva(self, phd[si]);
+		memset(se_addr, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
+		for (pi = 0; pi < (SZ_1M / PAGE_SIZE); pi++) {
+			/* create pte */
+			((u64 *)se_addr)[pi] = (self->base_gpa
+				+ (si * SZ_1M) + (pi * PAGE_SIZE)) & ~0xffful;
+		}
+	}
+	pr_debug("segment table entry %p (0x%lx) --> %p\n",
+		 phd, phd[0], gpa2hva(self, (phd[0] & ~0x7fful)));
+	print_hex_bytes("st", (u64)phd, 64);
+	print_hex_bytes("pt", (u64)gpa2hva(self, phd[0]), 128);
+	print_hex_bytes("pt+", (u64)
+			gpa2hva(self, phd[0] + (PAGES_PER_SEGMENT * PAGE_SIZE
+			* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M)) - 0x64), 128);
+
+	sync_regs->crs[1] = self->pgd | 0x3;	/* PASCE TT=00 for segment table */
+	run->kvm_dirty_regs |= KVM_SYNC_CRS;
+}
+
+static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
+{
+	struct kvm_run *run = self->run;
+
+	TEST_ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
+	switch (run->s390_ucontrol.pgm_code) {
+	case 0x10 /* PIC_SEGMENT_TRANSLATION */:
+		pr_info("ucontrol pic segment translation 0x%llx\n",
+			run->s390_ucontrol.trans_exc_code);
+		/* map / make additional memory available */
+		struct kvm_s390_ucas_mapping map2 = {
+			.user_addr = (u64)gpa2hva(self, run->s390_ucontrol.trans_exc_code),
+			.vcpu_addr = run->s390_ucontrol.trans_exc_code,
+			.length = VM_MEM_EXT_SIZE,
+		};
+		pr_info("ucas map %p %p 0x%llx\n",
+			(void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
+		TEST_ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2));
+		break;
+	default:
+		TEST_FAIL("UNEXPECTED PGM CODE %d", run->s390_ucontrol.pgm_code);
+	}
+}
+
 /* verify SIEIC exit
  * * reset stop requests
  * * fail on codes not expected in the test cases
@@ -246,7 +337,11 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 		break;
 	case ICPT_INST:
 		/* end execution in caller on intercepted instruction */
+		pr_info("sie instruction interception\n");
 		return false;
+	case ICPT_OPEREXC:
+		/* operation exception */
+		TEST_FAIL("sie exception on %.4x%.8x", sie_block->ipa, sie_block->ipb);
 	default:
 		TEST_FAIL("UNEXPECTED SIEIC CODE %d", run->s390_sieic.icptcode);
 	}
@@ -259,6 +354,11 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
 	struct kvm_run *run = self->run;
 
 	switch (run->exit_reason) {
+	case KVM_EXIT_S390_UCONTROL:
+		/* check program interruption code */
+		/* handle page fault --> ucas map */
+		uc_handle_exit_ucontrol(self);
+		break;
 	case KVM_EXIT_S390_SIEIC:
 		return uc_handle_sieic(self);
 	default:
@@ -289,6 +389,73 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
 	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
 }
 
+TEST_F(uc_kvm, uc_map_unmap)
+{
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
+	struct kvm_run *run = self->run;
+	int rc;
+
+	init_st_pt(self);
+
+	/* copy test_mem_pgm to code_hva / code_gpa */
+	TH_LOG("copy code %p to vm mapped memory %p / %p",
+	       &test_mem_pgm, (void *)self->code_hva, (void *)self->code_gpa);
+	memcpy((void *)self->code_hva, &test_mem_pgm, PAGE_SIZE);
+
+	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
+	run->psw_addr = self->code_gpa;
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(0, sync_regs->gprs[0]);
+	ASSERT_EQ(13, run->exit_reason);
+	ASSERT_EQ(40, sie_block->icptcode);
+	ASSERT_EQ(true, uc_handle_exit(self));
+
+	/* set register content for test_mem_pgm to access not mapped memory*/
+	sync_regs->gprs[1] = 0x55;
+	sync_regs->gprs[5] = self->base_gpa;
+	sync_regs->gprs[6] = VM_MEM_SIZE;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+
+	/* run and expect to fail witch ucontrol pic segment translation */
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(1, sync_regs->gprs[0]);
+	ASSERT_EQ(20, run->exit_reason);
+
+	ASSERT_EQ(0x10, run->s390_ucontrol.pgm_code); /* PIC_SEGMENT_TRANSLATION */
+	ASSERT_EQ(self->base_gpa + VM_MEM_SIZE, run->s390_ucontrol.trans_exc_code);
+	/* map / make additional memory available */
+	struct kvm_s390_ucas_mapping map2 = {
+		.user_addr = (u64)gpa2hva(self, self->base_gpa + VM_MEM_SIZE),
+		.vcpu_addr = self->base_gpa + VM_MEM_SIZE,
+		.length = VM_MEM_EXT_SIZE,
+	};
+	TH_LOG("ucas map %p %p 0x%llx",
+	       (void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
+	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2);
+	ASSERT_EQ(0, rc)
+		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	uc_assert_diag44(self);
+
+	/* assert registers and memory are in expected state */
+	ASSERT_EQ(2, sync_regs->gprs[0]);
+	ASSERT_EQ(0x55, sync_regs->gprs[1]);
+	ASSERT_EQ(0x55, *(u32 *)gpa2hva(self, self->base_gpa + VM_MEM_SIZE));
+
+	/* unmap and run loop again */
+	TH_LOG("ucas unmap %p %p 0x%llx",
+	       (void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
+	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_UNMAP, &map2);
+	ASSERT_EQ(0, rc)
+		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(3, sync_regs->gprs[0]);
+	ASSERT_EQ(20, run->exit_reason);
+	ASSERT_EQ(true, uc_handle_exit(self));
+}
+
 TEST_F(uc_kvm, uc_gprs)
 {
 	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
-- 
2.45.2


