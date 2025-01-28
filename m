Return-Path: <linux-kselftest+bounces-25308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DEDA20B34
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 14:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2548F18863CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0919CCEC;
	Tue, 28 Jan 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZCpRcnZB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734D26ACD;
	Tue, 28 Jan 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070306; cv=none; b=KK6sbWRAm/otTf3yYhRwuYBtlNVP9LRRSV7fI4sNeXWL2fIJ1ZjY6JG6Ew3me5bTzpyDiAnFp8VBCOnJ13Czgnx8jwhuvn0n/AV+r9VYBlhIrpPkkAKXp4F7WceqK8P5OT0bnCq47p0QBlix4GDCZp37FwYfsvXmUWh9KvLQGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070306; c=relaxed/simple;
	bh=R1CkjN6rnlBEidy6zaoQEIIz7xKKK7Xxsrb1UAcj6ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=On2iFkJxhMJ7NkQLviTgOfymwu4/3y4utC1m8T4NKIT/sgLGLCS6Sl7NzxrssNIjcL4UVJzxYnpHGaisKgbL6EMdKzknJdZNKrS/YoASIDEm3nu3Dbc/RpkKvE5+zzzlx5XSOxxH1abBh9GSdO4bOgD2qnx4LbYt3atirW6G0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZCpRcnZB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SAF9lc019191;
	Tue, 28 Jan 2025 13:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6Eu73WL2s2EjQr7dSMUh8LPNNPnizN+fc1HdpKeCv
	OM=; b=ZCpRcnZBoL/utG9bmelX2vglJeyyRC1pgF/3dKwG+CvgLdiV2ANdnwuP+
	39QiOXRE8/c2sCXhWpjOzXeUv5Sy8YYBw86UQ68839ikkOyyHDC9nQQ7njrW18yO
	duogt9pnSIPAn+m4nWbW34DhKN0UAcHEEOOqtwkgKx88yedDVcKIyjjiY3hc6J3m
	F8Aula+988dywdH2fB1iUA+AHKLwN6K2WlCo6e2mPdaHbyLs/iUIU/LFca2eAzLT
	ll0cvFNE4vGvlcppuXfapKSwGoE+hq73cZ5g+PVDuUUUoXA2HBg4jGVU4w4QtF+S
	6zQbPzekm0tN/rvGkWW+ccunM3/Ng==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecytcuqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:18:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S98ZGG019368;
	Tue, 28 Jan 2025 13:18:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9mucdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:18:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SDI9sJ16056690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 13:18:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06F0A20043;
	Tue, 28 Jan 2025 13:18:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3C7A20040;
	Tue, 28 Jan 2025 13:18:08 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.155.210.150])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 13:18:08 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] KVM: s390: selftests: Streamline uc_skey test to issue iske after sske
Date: Tue, 28 Jan 2025 14:18:03 +0100
Message-ID: <20250128131803.1047388-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j9wogvxXEIjg4NMZ98cxzp41Q6fNKwgg
X-Proofpoint-ORIG-GUID: j9wogvxXEIjg4NMZ98cxzp41Q6fNKwgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=963 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280099

In some rare situations a non default storage key is already set on the
memory used by the test. Within normal VMs the key is reset / zapped
when the memory is added to the VM. This is not the case for ucontrol
VMs. With the initial iske check removed this test case can work in all
situations. The function of the iske instruction is still validated by
the remaining code.

Fixes: 0185fbc6a2d3 ("KVM: s390: selftests: Add uc_skey VM test case")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390/ucontrol_test.c        | 24 +++++--------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390/ucontrol_test.c b/tools/testing/selftests/kvm/s390/ucontrol_test.c
index 135ee22856cf..d1080020a243 100644
--- a/tools/testing/selftests/kvm/s390/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390/ucontrol_test.c
@@ -88,10 +88,6 @@ asm("test_skey_asm:\n"
 	"	ahi	%r0,1\n"
 	"	st	%r1,0(%r5,%r6)\n"
 
-	"	iske	%r1,%r6\n"
-	"	ahi	%r0,1\n"
-	"	diag	0,0,0x44\n"
-
 	"	sske	%r1,%r6\n"
 	"	xgr	%r1,%r1\n"
 	"	iske	%r1,%r6\n"
@@ -596,7 +592,9 @@ TEST_F(uc_kvm, uc_skey)
 	ASSERT_EQ(true, uc_handle_exit(self));
 	ASSERT_EQ(1, sync_regs->gprs[0]);
 
-	/* ISKE */
+	/* SSKE + ISKE */
+	sync_regs->gprs[1] = skeyvalue;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
 	ASSERT_EQ(0, uc_run_once(self));
 
 	/*
@@ -608,21 +606,11 @@ TEST_F(uc_kvm, uc_skey)
 	TEST_ASSERT_EQ(0, sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE));
 	TEST_ASSERT_EQ(KVM_EXIT_S390_SIEIC, self->run->exit_reason);
 	TEST_ASSERT_EQ(ICPT_INST, sie_block->icptcode);
-	TEST_REQUIRE(sie_block->ipa != 0xb229);
+	TEST_REQUIRE(sie_block->ipa != 0xb22b);
 
-	/* ISKE contd. */
+	/* SSKE + ISKE contd. */
 	ASSERT_EQ(false, uc_handle_exit(self));
 	ASSERT_EQ(2, sync_regs->gprs[0]);
-	/* assert initial skey (ACC = 0, R & C = 1) */
-	ASSERT_EQ(0x06, sync_regs->gprs[1]);
-	uc_assert_diag44(self);
-
-	/* SSKE + ISKE */
-	sync_regs->gprs[1] = skeyvalue;
-	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
-	ASSERT_EQ(0, uc_run_once(self));
-	ASSERT_EQ(false, uc_handle_exit(self));
-	ASSERT_EQ(3, sync_regs->gprs[0]);
 	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
 	uc_assert_diag44(self);
 
@@ -631,7 +619,7 @@ TEST_F(uc_kvm, uc_skey)
 	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
 	ASSERT_EQ(0, uc_run_once(self));
 	ASSERT_EQ(false, uc_handle_exit(self));
-	ASSERT_EQ(4, sync_regs->gprs[0]);
+	ASSERT_EQ(3, sync_regs->gprs[0]);
 	/* assert R reset but rest of skey unchanged */
 	ASSERT_EQ(skeyvalue & 0xfa, sync_regs->gprs[1]);
 	ASSERT_EQ(0, sync_regs->gprs[1] & 0x04);
-- 
2.48.1


