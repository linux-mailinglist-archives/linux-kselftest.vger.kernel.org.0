Return-Path: <linux-kselftest+bounces-23023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC29E91C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5891887140
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C122145E;
	Mon,  9 Dec 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JfDIbA4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAAE21E092;
	Mon,  9 Dec 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742456; cv=none; b=eILaNXSeDNvim61dCWGdPyaLPdVcp3y9qVcJ7Xp3Ue6zJwbfsb0sO7O1r1g5Zp3rgi+bFKf5RBpoCVPdAobj/0ZgPs2aNdFXU0S3XOrZz4y0h2NT2LnB98roS94bpFyTJp7WiHN4mlIt8ndZHqgL4HFzBp5zVHuvzMbip2fBzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742456; c=relaxed/simple;
	bh=djd6MJW/2LGfUDl+xDRhSN+G/7HVpLguZkpCu3HFhJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8ydMo5a52nbCE6OBpD7oQenHFuldKclruVV+Y4CLg1LjXaARo8n2g256jgirigVFWCTQIZHm2p5Q0F2lQZyoA1id3tdJJm+QtJV3Q4Ee7jkwwclYjVm9aailSLQmKAN8nPQdKvb08Jy+XKoicamPutGEZMWRjwo1Zr33Yj6miU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JfDIbA4/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MotfM008466;
	Mon, 9 Dec 2024 11:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eeBMDI0kP+FxyT4dt
	LaNx29dbsp9ZBEPwfu5vflKj/w=; b=JfDIbA4/cCYvb+9mIayhzc/lBgMEpQfSo
	Ui5JkNPPiFAwyosLe16F3jXUeSoTGz6YtIssS+DZ8AAKnE/+Tk6xcEXKI5cxutDO
	dB+gT4o4vK9lqj6bbhIDEkc6s7I+/L42rRfAxbS9/xqBRk+uUlCIGXjdb0Z/UwB+
	qdS/B/6Fxy6DFgNRpffUCPC91VNwkBb3ix1HvUIL6q8/Hudyw8XUzHtPdT78KMyc
	zJ7hfoXN4TVrJRc7kKsIvfw4xcmGr4YKg/o36lVCLlxZLllmDTQOlY3QxFydbZol
	+mpRrk2HkMGWVfz05LVPicgCtpnHE0uKgNK8/yx3705Y3o3jG0M5Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0x7y5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99c9i5016910;
	Mon, 9 Dec 2024 11:07:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12xxews-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9B7P2X35652154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:07:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2EB520043;
	Mon,  9 Dec 2024 11:07:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E8182004B;
	Mon,  9 Dec 2024 11:07:25 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:07:25 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 5/6] selftests: kvm: s390: Streamline uc_skey test to issue iske after sske
Date: Mon,  9 Dec 2024 12:07:16 +0100
Message-ID: <20241209110717.77279-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209110717.77279-1-schlameuss@linux.ibm.com>
References: <20241209110717.77279-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xL0l9NC9hRSIu2X_T9mgtBpXJyX6ZWVK
X-Proofpoint-ORIG-GUID: xL0l9NC9hRSIu2X_T9mgtBpXJyX6ZWVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=914
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090086

In some rare situations a non default storage key is already set on the
memory used by the test. Within normal VMs the key is reset / zapped
when the memory is added to the VM. This is not the case for ucontrol
VMs. With the initial iske check removed this test case can work in all
situations. The function of the iske instruction is still validated by
the remaining code.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
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


