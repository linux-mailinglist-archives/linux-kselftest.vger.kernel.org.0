Return-Path: <linux-kselftest+bounces-21661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3769C18ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 10:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C180E2831B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69FA1E049C;
	Fri,  8 Nov 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LvFdkqRf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D21D0B8A;
	Fri,  8 Nov 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057419; cv=none; b=ODhL1RvHq82+NlnPUTBbKIQzM+d5sf5I/d5Gxl/4tB4mGnwzO9G/qLO/OxplkePQKDYoumycQ3uUs72jTkvadWZeVhpeSgE56V4RNBzAahXNJm//JWABMghOyWTBYqMLSUG0yFgFdHqYrBZsj79J3om6t/Qrb9Gcj7RPT3sEFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057419; c=relaxed/simple;
	bh=fJLEPWOkCvP1z3IZrZstjDvjQxvdBwlSAqrPMvkxiR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV8Mwb2g74aXOM6Y/MhOpCZzYdbQRWIxtemDMkLkPSG8YbJTuu7GDElwWhwcnmDcZQx7Rws5NP0l3eGFEJ3YDhePygJ1uLnxiw2bdu7I5LspoRcatcJn7tdf4ExcsPc8gFnTsd5QUhxrbyQN5nVwWEMHrIQ+i5u61KYmALFHEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LvFdkqRf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A889uVO020745;
	Fri, 8 Nov 2024 09:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BabBlwg3HFRgOZHlb
	LgtwxjDSS4kHfDhWBZRVYlpFrQ=; b=LvFdkqRf+u8unTuE84rPcGEDs2/z0rUxT
	D8FS7whpHvI+WPL4Ss0PPSF2zmjyryrBSbJ19CoGNxak3qWPrxbNg7nwF0vOGmBJ
	KRP1iIBjWdX1kjPVAXU5k6AAvmHGJfA3M3z9A3hG5fu+zx+07TpE2WjH/q4nCPLJ
	3BsemZig2Bof4uX2YxqBPAmywuGMzErm4uUdNX1SaPTvpNNRrUrCdoFqFN2dwTsG
	nUoC1Da6N8CH+6d2Vo9233ZZz9Z1Y81+WBrART7E3QFfvFBpwd5LHo1HPQUfRkXb
	1Zv9Cq8bIemD9qaDWwpcI/AOpUhhzR5rzRBwk1K0fpSZ82Jzv5W0g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sew0g7sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 09:16:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7NjEIY019625;
	Fri, 8 Nov 2024 09:16:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj9upq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 09:16:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A89GmHr33555106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 09:16:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 880472004B;
	Fri,  8 Nov 2024 09:16:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D89CE20049;
	Fri,  8 Nov 2024 09:16:47 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.25.81])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2024 09:16:47 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v7 2/5] selftests: kvm: s390: Add uc_skey VM test case
Date: Fri,  8 Nov 2024 10:16:20 +0100
Message-ID: <20241108091620.289406-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107141024.238916-3-schlameuss@linux.ibm.com>
References: <20241107141024.238916-3-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N723-qSEUFLPuwgD73VD3S4k0pZZ7BVt
X-Proofpoint-ORIG-GUID: N723-qSEUFLPuwgD73VD3S4k0pZZ7BVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 mlxlogscore=989 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080074

Add a test case manipulating s390 storage keys from within the ucontrol
VM.

Storage key instruction (ISKE, SSKE and RRBE) intercepts and
Keyless-subset facility are disabled on first use, where the skeys are
setup by KVM in non ucontrol VMs.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---

Resending this part as I did slightly mess up the rebase.

---
 .../selftests/kvm/include/s390x/processor.h   |   6 +
 .../selftests/kvm/s390x/ucontrol_test.c       | 145 +++++++++++++++++-
 2 files changed, 149 insertions(+), 2 deletions(-)

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
index 3e649b12a0b9..ad95087cc74c 100644
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
@@ -298,8 +325,50 @@ static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) *self)
 	}
 }
 
-/* verify SIEIC exit
+/*
+ * Handle the SIEIC exit
  * * fail on codes not expected in the test cases
+ * Returns if interception is handled / execution can be continued
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
+ * * fail on codes not expected in the test cases
+ * Returns if interception is handled / execution can be continued
  */
 static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 {
@@ -315,7 +384,10 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
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
@@ -472,4 +544,73 @@ TEST_F(uc_kvm, uc_gprs)
 	ASSERT_EQ(1, sync_regs->gprs[0]);
 }
 
+TEST_F(uc_kvm, uc_skey)
+{
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
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
+
+	/*
+	 * Bail out and skip the test after uc_skey_enable was executed but iske
+	 * is still intercepted. Instructions are not handled by the kernel.
+	 * Thus there is no need to test this here.
+	 */
+	TEST_ASSERT_EQ(0, sie_block->cpuflags & CPUSTAT_KSS);
+	TEST_ASSERT_EQ(0, sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE));
+	TEST_ASSERT_EQ(KVM_EXIT_S390_SIEIC, self->run->exit_reason);
+	TEST_ASSERT_EQ(ICPT_INST, sie_block->icptcode);
+	TEST_REQUIRE(sie_block->ipa != 0xb229);
+
+	/* ISKE contd. */
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


