Return-Path: <linux-kselftest+bounces-23053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25599E9A69
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 16:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C458280E76
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715321BEF7C;
	Mon,  9 Dec 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qGzGFngJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98A1C5CAB;
	Mon,  9 Dec 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757851; cv=none; b=pQ8SN+oA539mvnUqROdZ/ncL5fWmtbhTTb9HGOpVsAGTQTVAHYaRpRPqqgg1ey35jmVdKXanySl4NwyJ/YFnSadAC2eVzcaN+tjmqVjm9UXnexk0LpVcVtsyZY1X+uWNbwMdJR5sjvY35RTchtIz1gFG75e3rCBfKBb8BlQvmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757851; c=relaxed/simple;
	bh=s+/PYJABUFFCtEQ6iAnEZZPPJMH6272x2LO8Tbe0yJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKvTHieqg43RiZ5tusk4tP4YpsLeKbIgdld0CKaUKM1WCrPEE0GUjpVKowa4aY4xJlQWtvo0gFtTGIXpNf9TUhob2kVXFPwm/kFuFTQwVATmMIi6ohnflOCZ8250WrGG7LSdTtgWm7EGltsh1+WncQJTmYcIlEA7MY5ZBoLWupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qGzGFngJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B95TZdc030022;
	Mon, 9 Dec 2024 15:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K/8EXueonT4iBNN7V
	lIZg2lxatjHHmWlmlFEHDx1pDw=; b=qGzGFngJ5H6c5uLP//8NamGGZCvKh72ZR
	Z0mHetQSEPqUv2O/KusBdCi00tqX527JzZQSIqvEv1+FKAjL7SE4io9nDjh/M25q
	dyiI/DPIkwAhOLWvOhFuIOq+brVmHRrh4XH/n/ucgSTRNTuCdTQTTROWHPWayzAC
	Q5OiSXIawPKTjKdhGruD48X6doElRX4X5DJupn1/q/j8bHgxWZ73DCcPlQ8zBnWi
	/SyQKHFcAAB1uiQRTGzfxmq+a6Bg6clL5uWZB3LKo4/gsEy37B0lx1NsY7Epu5t/
	k9m3XAF9uUFcoM5jQ/px1xX3aXZFoxcahnseHwF3Utr0CxqCJr8zw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0x94bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:24:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9BkuAU023015;
	Mon, 9 Dec 2024 15:24:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjpydb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:24:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9FO0IV35389760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 15:24:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC42F20043;
	Mon,  9 Dec 2024 15:24:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 814E520040;
	Mon,  9 Dec 2024 15:23:59 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 15:23:59 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 5/6] selftests: kvm: s390: Streamline uc_skey test to issue iske after sske
Date: Mon,  9 Dec 2024 16:23:34 +0100
Message-ID: <20241209152334.208112-3-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209110717.77279-6-schlameuss@linux.ibm.com>
References: <20241209152334.208112-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d9TUX568LvLw4xCXmFrhjknecxvIRsfv
X-Proofpoint-ORIG-GUID: d9TUX568LvLw4xCXmFrhjknecxvIRsfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=901
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090117

In some rare situations a non default storage key is already set on the
memory used by the test. Within normal VMs the key is reset / zapped
when the memory is added to the VM. This is not the case for ucontrol
VMs. With the initial iske check removed this test case can work in all
situations. The function of the iske instruction is still validated by
the remaining code.

Fixes: 7d900f8ac191 ("selftests: kvm: s390: Add uc_skey VM test case")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---

Added fixes comment.

---
 .../selftests/kvm/s390x/ucontrol_test.c       | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index d3a5dbfabade..755cd31e6387 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
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
@@ -593,7 +589,9 @@ TEST_F(uc_kvm, uc_skey)
 	ASSERT_EQ(true, uc_handle_exit(self));
 	ASSERT_EQ(1, sync_regs->gprs[0]);
 
-	/* ISKE */
+	/* SSKE + ISKE */
+	sync_regs->gprs[1] = skeyvalue;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
 	ASSERT_EQ(0, uc_run_once(self));
 
 	/*
@@ -607,19 +605,9 @@ TEST_F(uc_kvm, uc_skey)
 	TEST_ASSERT_EQ(ICPT_INST, sie_block->icptcode);
 	TEST_REQUIRE(sie_block->ipa != 0xb229);
 
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
 
@@ -628,7 +616,7 @@ TEST_F(uc_kvm, uc_skey)
 	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
 	ASSERT_EQ(0, uc_run_once(self));
 	ASSERT_EQ(false, uc_handle_exit(self));
-	ASSERT_EQ(4, sync_regs->gprs[0]);
+	ASSERT_EQ(3, sync_regs->gprs[0]);
 	/* assert R reset but rest of skey unchanged */
 	ASSERT_EQ(skeyvalue & 0xfa, sync_regs->gprs[1]);
 	ASSERT_EQ(0, sync_regs->gprs[1] & 0x04);
-- 
2.47.1


