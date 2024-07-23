Return-Path: <linux-kselftest+bounces-14073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3472939DF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C0A1C21EB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027114F132;
	Tue, 23 Jul 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ONLbLAml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9614E2E9;
	Tue, 23 Jul 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727134; cv=none; b=Yv/fX9RBjbKxuDZUUJbFVURsZV0UIrb2W9NwMh1toPMEBfRlQ+4wcQdGu4TpkzxsdIfxPTVtpxJl4SAIbaeBET1yi3+ugBfGPLY1cST17Vjy8sOZ4TadyvN+tv7ERLzpNRGm/Kcyt4wT+zm5rZYEJYS/G+QG92XqqfgqoKbRk5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727134; c=relaxed/simple;
	bh=J/PTCEwvvqNMO6/U1EIk5NeUGHGTDJUFB5r/p8LKo5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9VxcXxf2rsv56l2DkeWO4JJYIhna2/g62hEcF40Cgqe0LwHIOx0xZ6cn+rsVwDyqURHp51hkhwOwFmx67lf6pycsYL/7sCJuhFN9tOdVPdeoNmFqd8+q2om/qtNHFzul+um+PTFcqA4NJc8Z0cxCxT0r3m29+6stmXZJcWWcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ONLbLAml; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N8RmYQ002209;
	Tue, 23 Jul 2024 09:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=wvl386dljUZxW
	SOFQknbxOvY3scLXyB8vkPfJNj7LOg=; b=ONLbLAmlEH4CJ0pV/j4eeXzJhdx5W
	Kj2ZmVyuABlvuDoVoSEnndwCdCbMYx7HWiq9fz9HTUCohIvdGZFow6cTu8qnjSVI
	ToH0vhJebsQdnQus3LoFhmUBlOfKkI/+oRbCkDtVQgQb/3acUDZycjfkE9GoQfP9
	9f2TuYWw1cEqbK2ehliwoGkf7cQywCwC9nqMui5pM+ORZTdcrCMiTTDRNn2b5ES4
	Dncq9e5ewuq3iOXUX+Y8A8t2m4qb6W6LoiizvYVeXOtGEyRzq71lPme4x0KXZNsR
	N7ZI+9QrkDwNECRbP1z9st88GMPfXz5Q2d9CtNo/9YJPJYorQZFsSgIJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j7qfg9wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:09 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N9W8gG030532;
	Tue, 23 Jul 2024 09:32:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j7qfg9wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9Cx8M006165;
	Tue, 23 Jul 2024 09:32:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2p9nua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N9W2UU51642848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:32:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F2320049;
	Tue, 23 Jul 2024 09:32:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9830420040;
	Tue, 23 Jul 2024 09:32:01 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.28.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 09:32:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 08/10] selftests: kvm: s390: Add uc_skey VM test case
Date: Tue, 23 Jul 2024 11:31:24 +0200
Message-ID: <20240723093126.285319-9-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: nj1yOmrTPkUV-0G1DTShrP231kiLRkfi
X-Proofpoint-ORIG-GUID: Xy40iuvgWpAbTl41QIcGb2V9k_2QnpX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=810
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407230069

Add a test case manipulating s390 storage keys from within the ucontrol
VM.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 85 ++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index a39c560ba42e..79992621c0b5 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -83,6 +83,32 @@ asm("test_mem_pgm:\n"
 	"	j	0b\n"
 );
 
+/* Test program manipulating storage keys */
+extern char test_skey_pgm[];
+asm("test_skey_pgm:\n"
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
@@ -391,10 +417,67 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
 	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
 }
 
-TEST_F(uc_kvm, uc_map_unmap)
+TEST_F(uc_kvm, uc_skey)
 {
+	u64 test_vaddr = self->base_gpa + VM_MEM_SIZE - (SZ_1M / 2);
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
 	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_run *run = self->run;
+	u8 skeyvalue = 0x34;
+
+	init_st_pt(self);
+
+	/* copy test_skey_pgm to code_hva / code_gpa */
+	TH_LOG("copy code %p to vm mapped memory %p / %p",
+	       &test_skey_pgm, (void *)self->code_hva, (void *)self->code_gpa);
+	memcpy((void *)self->code_hva, &test_skey_pgm, PAGE_SIZE);
+
+	/* set register content for test_skey_pgm to access not mapped memory */
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
+	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
+	run->psw_addr = self->code_gpa;
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(true, uc_handle_exit(self));
+	ASSERT_EQ(0, sync_regs->gprs[0]);
+	ASSERT_EQ(KVM_EXIT_S390_SIEIC, run->exit_reason);
+	ASSERT_EQ(ICPT_STOP, sie_block->icptcode);
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
+TEST_F(uc_kvm, uc_map_unmap)
+{
 	struct kvm_s390_sie_block *sie_block = self->sie_block;
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
 	struct kvm_run *run = self->run;
 	int rc;
 
-- 
2.45.2


