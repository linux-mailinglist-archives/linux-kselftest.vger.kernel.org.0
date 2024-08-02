Return-Path: <linux-kselftest+bounces-14727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F4894614C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E87B24AFB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB52101A0;
	Fri,  2 Aug 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oFA2qgnJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC21E3CA2;
	Fri,  2 Aug 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614401; cv=none; b=qMGEBOWAsrnFJu0w/sruReuQT8gudBr4BsukbOJokgBIKGGG64d2tkUCAKu7iaLfuBHqwyQ8TuaBX4pFkSXQBiXkrHWAF2VdhDKJMtwM17hNTyr0cK+deWhHFqfCikpP1bDB/tS5jO92aJRUp76CsNfkwRLSYKF9t86iuGXi43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614401; c=relaxed/simple;
	bh=rpOoKWpLE+oth6d7mwiHM0vzA9myxl4LTgGdrL3wCXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXxJg6PCtvqQRqJs73OtQMVP2muPT1z9Xui+ei40hpmwAaVS1Rfg8ECQXidn39ktMsm/bXIKVGfeiZhNjAnsQoOCA5zOWTqvODrNcLhAkNJYMDBahp5BtACcFvyQP5VWF82bt7m+4fM6C+wCBeMDTbJang5cl4GG/egjTemZm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oFA2qgnJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472Dh4n0010343;
	Fri, 2 Aug 2024 15:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=UYLHe7pZi+ZfA
	rub9q6KTae3Lfb84VeVT03bxRAi/CU=; b=oFA2qgnJPl7Dxou7/Bp2mqCXTOeDK
	eW4trLShPK4RVuuyI33q5mHbgkii3g3NYO5XGtsNg+vE4zb/LBGzNq0n4Y/bpaIQ
	iqb/u8vmCJ6wTBYFcRRMB+ZACbLeAqxHJ5PSBwawaZhlmgJZMpcU1B1VQRlP6/dI
	Ai4yRQdEcMP8BtJ7s+AJvM+hgZ33z8DIxFaxaqq35J4TthW+DF6ichceZOD5nSjR
	6hSgHrRwzQFI/TNU9Xzf3hqtqf/BiVXz/rMA+IS1zxmzK1FGBqCr1uORu0NNpeC3
	C+Ft5kqsJbYPaTbXdZVcCKLFZ0rCJCha7MdZHF9QhzTGNK0etBMBjg/mA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ryx6rd8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:52 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472Fxp2F019211;
	Fri, 2 Aug 2024 15:59:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ryx6rd8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472EgHSw018969;
	Fri, 2 Aug 2024 15:59:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q7y1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472FxiY120513214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 15:59:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6BDF20049;
	Fri,  2 Aug 2024 15:59:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E249720040;
	Fri,  2 Aug 2024 15:59:43 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.84.102])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 15:59:43 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v4 08/10] selftests: kvm: s390: Add uc_skey VM test case
Date: Fri,  2 Aug 2024 17:59:11 +0200
Message-ID: <20240802155913.261891-9-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802155913.261891-1-schlameuss@linux.ibm.com>
References: <20240802155913.261891-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 24mKS9ulVHyQM98MJP4SzeXbSsNnXHrW
X-Proofpoint-ORIG-GUID: T5Pb1L6eAz_mSJ0E9Av7yz0mzjQjYqRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=885 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020110

Add a test case manipulating s390 storage keys from within the ucontrol
VM.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 72ad30fbe4ac..30160347a937 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -81,6 +81,32 @@ asm("test_mem_asm:\n"
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
@@ -388,6 +414,58 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
 	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
 }
 
+TEST_F(uc_kvm, uc_skey)
+{
+	u64 test_vaddr = self->base_gpa + VM_MEM_SIZE - (SZ_1M / 2);
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_run *run = self->run;
+	u8 skeyvalue = 0x34;
+
+	init_st_pt(self);
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
+	run->kvm_dirty_regs |= KVM_SYNC_CRS;
+	TH_LOG("set CR0 to 0x%llx", sync_regs->crs[0]);
+
+	self->sie_block->ictl |= ICTL_OPEREXC | ICTL_PINT;
+	self->sie_block->cpuflags &= ~CPUSTAT_KSS;
+	/* DAT enabled + 64 bit mode */
+	run->psw_mask = 0x0400000180000000ULL;
+	run->psw_addr = self->code_gpa;
+
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	ASSERT_EQ(2, sync_regs->gprs[0]);
+	ASSERT_EQ(0x06, sync_regs->gprs[1]);
+	uc_assert_diag44(self);
+
+	sync_regs->gprs[1] = skeyvalue;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	ASSERT_EQ(3, sync_regs->gprs[0]);
+	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
+	uc_assert_diag44(self);
+
+	sync_regs->gprs[1] = skeyvalue;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	ASSERT_EQ(4, sync_regs->gprs[0]);
+	ASSERT_EQ(skeyvalue & 0xfb, sync_regs->gprs[1]);
+	uc_assert_diag44(self);
+}
+
 TEST_F(uc_kvm, uc_map_unmap)
 {
 	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
-- 
2.45.2


