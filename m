Return-Path: <linux-kselftest+bounces-19712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E9B99E142
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776CC1C213F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593DF1C7B99;
	Tue, 15 Oct 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qVObh8T4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9F1C877E;
	Tue, 15 Oct 2024 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981479; cv=none; b=g3GmPaDmw7A0zgo8ARhQNsVPfuifLuC0OZ3YTi/L9ztKS5FExxhiMv4VQElVSmp2wfAO3qb8cM7ZPnWoIEVXSFcEYfSci6a59X4KaHFgKw5VejxEAVUQSFbJ03ZFcos7+35FGafuxJAizHAxmEZ/KtKezJ1scJV4wZEqSVLi47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981479; c=relaxed/simple;
	bh=7pIgEl1lGk8Yt1yy8wVxEkt0HBmRLwLD1k8S//kLCkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czwejxakgzK2I/aTfr9iNmwh/EW3OH93PtUo4kawLmGJffDpnNIxzV9YDF4rYXWKWkLEQdQd/kc0rDQ6GV4fqV8MPSe+EQxQ1waNskyLuYAhkuEYUU8oH/Wx0WsBzCieovAe1+7IjcN0GC606aXO22CWZ2tSMEq2kArsF9nxsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qVObh8T4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8PH6C023732;
	Tue, 15 Oct 2024 08:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x5Vn7kDWtMI35+EMF
	oeqEk8t8FAHbqERFHdhGlNFX/0=; b=qVObh8T4uVKkdrLDTYovqYojRMapFTChf
	iz7+VCAa4PPlJhXzZSvUrS7pJ1JLa7Qv9XQ8U/dtZ2TpHgbU9sEsbfXsPWqvZn3F
	P9g83YjV023Qc1Thzl82UA3+/dkJBB635C/idFrdHq93gg4VQjdNwTegMFMHNorN
	DyYK9dD54vQgEOmWpah8N9XHnfQIhwGouC7v5fkDVMQtBDHBdWPvE8OwN6NWzBzN
	g7Lsd0+5xQahnTo8gUm1obAQp9d6DnO2MGGyffUo3Ttr8XpUHUlbtmYxvLi3l8ra
	l0i/98t4xmtItmJUBsypglVFjZZQlenlGBC5mqxOL9k52jYPE6XTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4r1wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49F8bsUB020017;
	Tue, 15 Oct 2024 08:37:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4r1wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7TuK3002473;
	Tue, 15 Oct 2024 08:37:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emjsg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8bneW32834128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:37:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43CAD20040;
	Tue, 15 Oct 2024 08:37:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4E142004B;
	Tue, 15 Oct 2024 08:37:48 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.49.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 08:37:48 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v6 2/5] selftests: kvm: s390: Add uc_skey VM test case
Date: Tue, 15 Oct 2024 10:37:41 +0200
Message-ID: <20241015083744.761838-3-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015083744.761838-1-schlameuss@linux.ibm.com>
References: <20241015083744.761838-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0Lpu0mpELYK-PEUdo-5ys7-Ira6n5Jsr
X-Proofpoint-ORIG-GUID: Sc7_82VsXh7Ge3_pICr-bwnsWWHDEglm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150056

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
index 3e649b12a0b9..9568a4e03e4b 100644
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
+ * Disable skey intercepts and rewind last instruction
+ * (KVM would init the skeys here)
+ */
+static void uc_skey_enable(FIXTURE_DATA(uc_kvm) *self)
+{
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
+	int ilen = insn_length(sie_block->ipa >> 8);
+	struct kvm_run *run = self->run;
+
+	/* disable KSS */
+	sie_block->cpuflags &= ~CPUSTAT_KSS;
+	/* disable skey inst interception */
+	sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
+
+	/* rewind to reexecute intercepted instruction */
+	run->psw_addr = run->psw_addr - ilen;
+	pr_info("rewind guest addr to 0x%.16llx\n", run->psw_addr);
+}
+
+/*
+ * Handle the instruction intercept
+ * Returns if interception is handled / execution can be continued
+ */
+static bool uc_handle_insn_ic(FIXTURE_DATA(uc_kvm) *self)
+{
+	struct kvm_run *run = self->run;
+
+	switch (run->s390_sieic.ipa) {
+	case 0xB229: /* ISKE */
+	case 0xB22b: /* SSKE */
+	case 0xB22a: /* RRBE */
+		uc_skey_enable(self);
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


