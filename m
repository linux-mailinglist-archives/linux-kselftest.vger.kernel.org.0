Return-Path: <linux-kselftest+bounces-19738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3AA99EF0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB6428557B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7E26296;
	Tue, 15 Oct 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pB7I58eP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A81FC7EC;
	Tue, 15 Oct 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001753; cv=none; b=aNW2yBWIMsd4kI4Hos1t0FEqPgDZI1Wi8bQ238UGZgdmi061djqsbjc7OxDM7lE8ySDGkqhEiQGQwO0S64ZlN/srK+gc9Uzpyi9Fg1xbKXN0rihTFFa1t1jNrjiJ/mFl/eyeHFcdG3YA7daikLK8tGArOsP0JRSTVfRpEjfTi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001753; c=relaxed/simple;
	bh=5QlgKUP0FqDWz0mf7J+wSsfDQqYtpu9QzrfNuDK4O84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzHI7c2t9rcK4H7jFNQVc8P5iVC4FAh1AxU9V5UQegfo93x5ito4fqtt2HpvB3fNO9H91+DuZnQ5OmTk+Zbx/qP4LNs3akk7TdmyqOnxFqcnK8Pi/gCH0DF7s+4Z4vw/v5s0CJEkZlSYyl2V0fgQkA3ILDhjvTa6xU3WSvPN9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pB7I58eP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FDl3V7015707;
	Tue, 15 Oct 2024 14:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bewSTRoEObq+Dfbba
	UNd3Xydy/dtNiJvglZ4kAtOxPM=; b=pB7I58ePCu7OKS58nxAaXILl7Xg1LHDQO
	bxK24zDLyOPq9vvEljpULZ6A4scxmOxz2SJxBpUZEgYpo4koW32TfMXWhRniB2Ko
	gdU1L87pTItSUumvfav/jyuMtPyWkX9tIkLs/UigAnc1/eP04dws+Y7Gn1iSnLXV
	sNy2Nez+0PKQnDEgqQk5zvsPTaS5AoRjs1jna9NCBF+BVeNz/f++fiO3XvD8g/om
	0bC59lWvgge5cEkHUVXkTsmZQhvVwtMeBVsSmqkV5A1GpA4h0s/dJF9RyiBovx2y
	1gls6CoidyVgC4xka5/8yzFFHIv5nwC+4LEyXET52zHY/B9/swXDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429sk186kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:15:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FEBcFR027041;
	Tue, 15 Oct 2024 14:15:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429sk186kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:15:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCC8cm005936;
	Tue, 15 Oct 2024 14:15:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650uwxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:15:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FEFgDJ50135514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 14:15:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC16320043;
	Tue, 15 Oct 2024 14:15:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4547E2004D;
	Tue, 15 Oct 2024 14:15:42 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 14:15:42 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v6 2/5] selftests: kvm: s390: Add uc_skey VM test case
Date: Tue, 15 Oct 2024 16:15:39 +0200
Message-ID: <20241015141539.57638-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <D4WF2493HS7M.QHC37L73T9L5@linux.ibm.com>
References: <D4WF2493HS7M.QHC37L73T9L5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: auVmy2ukenBgACERGVvkhjw0As5cBpxn
X-Proofpoint-GUID: EZWq22tTPCdYeRJE6dvb8Oi3AeT8KhPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150097

Add a test case manipulating s390 storage keys from within the ucontrol
VM.

Storage key instruction (ISKE, SSKE and RRBE) intercepts and
Keyless-subset facility are disabled on first use, where the skeys are
setup by KVM in non ucontrol VMs.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/include/s390x/processor.h   |   6 +
 .../selftests/kvm/s390x/ucontrol_test.c       | 130 +++++++++++++++++-
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/s390x/processor.h b/tools/testing/selftests/kvm/include/s390x/processor.h
index 481bd2fd6a32..33fef6fd9617 100644
--- a/tools/testing/selftests/kvm/include/s390x/processor.h
+++ b/tools/testing/selftests/kvm/include/s390x/processor.h
@@ -32,4 +32,10 @@ static inline void cpu_relax(void)
 	barrier();
 }
 
+/* Get the instruction length */
+static inline int insn_length(unsigned char code)
+{
+	return ((((int)code + 64) >> 7) + 1) << 1;
+}
+
 #endif
diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 3e649b12a0b9..c1bc199d6e85 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -79,6 +79,33 @@ asm("test_mem_asm:\n"
 	"	j	0b\n"
 );
 
+/* Test program manipulating storage keys */
+extern char test_skey_asm[];
+asm("test_skey_asm:\n"
+	"xgr	%r0, %r0\n"
+
+	"0:\n"
+	"	ahi	%r0,1\n"
+	"	st	%r1,0(%r5,%r6)\n"
+
+	"	iske	%r1,%r6\n"
+	"	ahi	%r0,1\n"
+	"	diag	0,0,0x44\n"
+
+	"	sske	%r1,%r6\n"
+	"	xgr	%r1,%r1\n"
+	"	iske	%r1,%r6\n"
+	"	ahi	%r0,1\n"
+	"	diag	0,0,0x44\n"
+
+	"	rrbe	%r1,%r6\n"
+	"	iske	%r1,%r6\n"
+	"	ahi	%r0,1\n"
+	"	diag	0,0,0x44\n"
+
+	"	j	0b\n"
+);
+
 FIXTURE(uc_kvm)
 {
 	struct kvm_s390_sie_block *sie_block;
@@ -298,8 +325,49 @@ static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) *self)
 	}
 }
 
-/* verify SIEIC exit
+/*
+ * Disable skey intercepts
+ * (KVM would init the skeys here)
+ */
+static void uc_skey_enable(FIXTURE_DATA(uc_kvm) *self)
+{
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
+
+	/* disable KSS */
+	sie_block->cpuflags &= ~CPUSTAT_KSS;
+	/* disable skey inst interception */
+	sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
+}
+
+/*
+ * Handle the instruction intercept
+ * Returns if interception is handled / execution can be continued
+ */
+static bool uc_handle_insn_ic(FIXTURE_DATA(uc_kvm) *self)
+{
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
+	int ilen = insn_length(sie_block->ipa >> 8);
+	struct kvm_run *run = self->run;
+
+	switch (run->s390_sieic.ipa) {
+	case 0xB229: /* ISKE */
+	case 0xB22b: /* SSKE */
+	case 0xB22a: /* RRBE */
+		uc_skey_enable(self);
+
+		/* rewind to reexecute intercepted instruction */
+		run->psw_addr = run->psw_addr - ilen;
+		pr_info("rewind guest addr to 0x%.16llx\n", run->psw_addr);
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * Handle the SIEIC exit
  * * fail on codes not expected in the test cases
+ * Returns if interception is handled / execution can be continued
  */
 static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 {
@@ -315,7 +383,10 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 	case ICPT_INST:
 		/* end execution in caller on intercepted instruction */
 		pr_info("sie instruction interception\n");
-		return false;
+		return uc_handle_insn_ic(self);
+	case ICPT_KSS:
+		uc_skey_enable(self);
+		return true;
 	case ICPT_OPEREXC:
 		/* operation exception */
 		TEST_FAIL("sie exception on %.4x%.8x", sie_block->ipa, sie_block->ipb);
@@ -472,4 +543,59 @@ TEST_F(uc_kvm, uc_gprs)
 	ASSERT_EQ(1, sync_regs->gprs[0]);
 }
 
+TEST_F(uc_kvm, uc_skey)
+{
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	u64 test_vaddr = VM_MEM_SIZE - (SZ_1M / 2);
+	struct kvm_run *run = self->run;
+	const u8 skeyvalue = 0x34;
+
+	/* copy test_skey_asm to code_hva / code_gpa */
+	TH_LOG("copy code %p to vm mapped memory %p / %p",
+	       &test_skey_asm, (void *)self->code_hva, (void *)self->code_gpa);
+	memcpy((void *)self->code_hva, &test_skey_asm, PAGE_SIZE);
+
+	/* set register content for test_skey_asm to access not mapped memory */
+	sync_regs->gprs[1] = skeyvalue;
+	sync_regs->gprs[5] = self->base_gpa;
+	sync_regs->gprs[6] = test_vaddr;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+
+	/* DAT disabled + 64 bit mode */
+	run->psw_mask = 0x0000000180000000ULL;
+	run->psw_addr = self->code_gpa;
+
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(true, uc_handle_exit(self));
+	ASSERT_EQ(1, sync_regs->gprs[0]);
+
+	/* ISKE */
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	ASSERT_EQ(2, sync_regs->gprs[0]);
+	/* assert initial skey (ACC = 0, R & C = 1) */
+	ASSERT_EQ(0x06, sync_regs->gprs[1]);
+	uc_assert_diag44(self);
+
+	/* SSKE + ISKE */
+	sync_regs->gprs[1] = skeyvalue;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	ASSERT_EQ(3, sync_regs->gprs[0]);
+	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
+	uc_assert_diag44(self);
+
+	/* RRBE + ISKE */
+	sync_regs->gprs[1] = skeyvalue;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	ASSERT_EQ(4, sync_regs->gprs[0]);
+	/* assert R reset but rest of skey unchanged */
+	ASSERT_EQ(skeyvalue & 0xfa, sync_regs->gprs[1]);
+	ASSERT_EQ(0, sync_regs->gprs[1] & 0x04);
+	uc_assert_diag44(self);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.0


