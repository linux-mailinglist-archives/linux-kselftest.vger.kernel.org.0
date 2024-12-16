Return-Path: <linux-kselftest+bounces-23398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228199F2CDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C03166D2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F56202C45;
	Mon, 16 Dec 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GoqHdN0l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6111FFC6E;
	Mon, 16 Dec 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340938; cv=none; b=Eu6SL1rBqQFv0hMVNpdgnP4PRHiFfQonmqhsCztzCfZkPHRD0laBEoyxn75MxQ4wAYeBE1w/UiZuYB3iJft5RTAKbvIfsrmMFHFEOyv6QPKmr+EGMsJBjfY2ys5ybQG1UMn0F++z1RZoDC1XYSj5/IPGIBJyHu8w6B5MKsq7hTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340938; c=relaxed/simple;
	bh=qW+vm4m+APf6pUaHyUDS9sIWffeWj2PiIMAA0cE9GdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnuOLh9q+KXh3z3nW94+ITRaX6phCSG96XGJClbMEMOOFRRWglqk8yEYMZ1LkVx0cMHuscqtjEe6YshsesmIE6/SeicaeGC8p/23/Oy05WwvHzC3z5PSrVx0aRc1XEuoalOmJwcKbJIaw5cLHQIzgJu8LcgOyo+U+SSd9QYmbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GoqHdN0l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFNxBPa008225;
	Mon, 16 Dec 2024 09:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mwwACa2qlkNCkcmRz
	wabhKHcHa7VksaqjcdEleuJpoI=; b=GoqHdN0lYjfgU+r7tAd3SuhODWszZu0Ks
	X73lUdjmFgH0arQAVFjpDWO7F2wOVHU9k6mZK10tbXL7ThiTAXlpgUbXfDuZh79C
	Ch/ciB2KZNHbx4bh06C/oJd8EV8oeTA02s+SqApg6PZVujqj8L8isX6cENq3G0OJ
	BO4DtG9lzdEYBo2Kuly+3SK2qy/BApj6oXg65f9ZrzVSF55uksIxlIkCTnZ7+B9g
	L4nAa/x40YHEWfIeiy41ovCcDrS3U/412rhI3yYpADrerWMTym6INjZjk2Kvv6Pv
	bciGke6I5Iqh5w624QoYW79tR23QTyJO61C1jbBra7aE6L0ICorPg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j98h20dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8O0MF029321;
	Mon, 16 Dec 2024 09:22:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsdetb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9M2kq31326578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:22:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 601B62004B;
	Mon, 16 Dec 2024 09:22:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A312B20040;
	Mon, 16 Dec 2024 09:22:01 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.0.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 09:22:01 +0000 (GMT)
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
Subject: [PATCH v2 5/6] selftests: kvm: s390: Streamline uc_skey test to issue iske after sske
Date: Mon, 16 Dec 2024 10:21:39 +0100
Message-ID: <20241216092140.329196-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216092140.329196-1-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XJgknQPVDfm5RMlgMW4ollLFotvmjCjl
X-Proofpoint-GUID: XJgknQPVDfm5RMlgMW4ollLFotvmjCjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=911 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160074

In some rare situations a non default storage key is already set on the
memory used by the test. Within normal VMs the key is reset / zapped
when the memory is added to the VM. This is not the case for ucontrol
VMs. With the initial iske check removed this test case can work in all
situations. The function of the iske instruction is still validated by
the remaining code.

Fixes: 7d900f8ac191 ("selftests: kvm: s390: Add uc_skey VM test case")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 8f306395696e..ef3e391811b3 100644
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


