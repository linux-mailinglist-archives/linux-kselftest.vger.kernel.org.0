Return-Path: <linux-kselftest+bounces-15420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA644953789
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB47288E62
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8421B32BF;
	Thu, 15 Aug 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H5q0xaPK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538DB1B1514;
	Thu, 15 Aug 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736752; cv=none; b=qBYqdJJLCqkjwIKN2x00gImU/1CG6PZ+H3u+JF4mInxjeg/CqC8+o883f3PFjxiKXWbcxy1rqNFq+lOqFz3BoK6D1vrYafuEbAXPACTRGhy3QRNWXX0u7UhM9fNH/NEUmf1EgzLIWkH2iDqd+g3guanqGvKDRQXBOkuhuDjAZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736752; c=relaxed/simple;
	bh=edBwqE+wrBaEIctZOh47a4lNAa9iXs3lgp0m+iwxjrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCmsveuDqDFWohgM+JoRQtL1OZBkKgPZzay6bQyc/RHeHDhf/qPOldEkPdd67iIxqnlXo4bPvAO391A4AHINBlBcKHvwjWqXpuqBuzBImQSYtpHpq2I77803Dk/ZBSltbZnAWb3kJpmg8hOwR9qksXLSYhsrP6Ky8l9ghOhUZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H5q0xaPK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F9WY9A011815;
	Thu, 15 Aug 2024 15:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Wd1pO/P9aQBYI
	L4x8SHcyfm0mUZ25eG/Z7miO6ghFuE=; b=H5q0xaPKXwCOrx74SQvn2uMBlETJF
	QhImjkSB21KhUXTxO1wa4YPx+9On3zyc3b8bmwKukaAGn3VjrDq5lmvsK1av+u00
	4nZfXMaJiyQgceAKchWb4Xq0Z8GOP/xNnnI/X7nL6qldROZSJS4n/cLRn54PKd0g
	XTZG5P07rBud9lFwRTYGvPgY6H46o7T2Rpipn4tGkQuJjqyTnfU0cfTu6BoaBrfd
	9MAnNVIq7er0KRwCXbLyoa6ZUrdAN7++VivFT6VRo7j3VewwZS8kiUANxStdpCjy
	zQD3VWWKvXrVMARzPLuG1xezezjiM5ARa7sCQv0acEWM14GejtVlTGn9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6cd1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47FFjf6q005465;
	Thu, 15 Aug 2024 15:45:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6cd1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47FFXTGM020929;
	Thu, 15 Aug 2024 15:45:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn83f06h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47FFjY5Q33751784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:45:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D572004D;
	Thu, 15 Aug 2024 15:45:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 137BC20040;
	Thu, 15 Aug 2024 15:45:34 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.32.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Aug 2024 15:45:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH 2/3] selftests: kvm: s390: Add uc_skey VM test case
Date: Thu, 15 Aug 2024 17:45:28 +0200
Message-ID: <20240815154529.628087-3-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815154529.628087-1-schlameuss@linux.ibm.com>
References: <20240815154529.628087-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0oEvUGWNLoIY2-32YwGyFsP1nhsho6qt
X-Proofpoint-ORIG-GUID: -iIE4ZwptEimLZtd7XS18RpGHpM4Nw8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_08,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=914 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150113

Add a test case manipulating s390 storage keys from within the ucontrol
VM.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 41306bb52f29..5f8815a80544 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -79,6 +79,32 @@ asm("test_mem_asm:\n"
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
@@ -345,6 +371,56 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
 	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
 }
 
+TEST_F(uc_kvm, uc_skey)
+{
+	u64 test_vaddr = self->base_gpa + VM_MEM_SIZE - (SZ_1M / 2);
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_run *run = self->run;
+	u8 skeyvalue = 0x34;
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
+	self->sie_block->ictl |= ICTL_OPEREXC | ICTL_PINT;
+	self->sie_block->cpuflags &= ~CPUSTAT_KSS;
+	/* DAT disabled + 64 bit mode */
+	run->psw_mask = 0x0000000180000000ULL;
+	run->psw_addr = self->code_gpa;
+
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	ASSERT_EQ(2, sync_regs->gprs[0]);
+	/* assert initial skey (ACC = 0, R & C = 1) */
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
+	/* assert R reset but rest of skey unchanged*/
+	ASSERT_EQ(skeyvalue & 0xfa, sync_regs->gprs[1]);
+	ASSERT_EQ(0x00, sync_regs->gprs[1] & 0x04);
+	uc_assert_diag44(self);
+}
+
 TEST_F(uc_kvm, uc_map_unmap)
 {
 	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
-- 
2.46.0


