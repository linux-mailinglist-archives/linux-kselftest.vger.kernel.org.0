Return-Path: <linux-kselftest+bounces-19215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C6B994115
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7470284646
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD89D17E004;
	Tue,  8 Oct 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k3m4WjCo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224251B9845;
	Tue,  8 Oct 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373392; cv=none; b=ZtAjGZZimqxyBibPBW4rKnKhbzrTOUUShQk5DnpckCHrQlV9LR63VXLmYvLMpsfceCmeGGDPxRkYhiGmwjVtzhOvZJv8fZbh2ZNvhlv/eyaqiGNqV+SewWuafVAmCWX5+fE79zQnSDfU01Jwn3oeLjJeinFRUOjba5ozVm39cLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373392; c=relaxed/simple;
	bh=zwWaIh0RHKWYeP779Dpd3aLPjn/eBQMtqd08Gyf7qm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8LD0FDFN5y/KgBwVIUo9JMc+GKyFCUAwUPvWA3boyOZFp6XKawxwTh7cOka1jH/zeLj+A6xS2k8Z4VdV3HIa+Kt37+mySCfKjfmjOJJAdhwRjscTGovnKjC+rtEW/wTN3BdwxzXlDeonk+kYLCgKusqPrzbzA/wDRiCInJrGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k3m4WjCo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4985jSZR019768;
	Tue, 8 Oct 2024 07:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=in3o0CueVKGjw
	mRwzDQgHjjqqU+cMSFVTiLb+CQKvrw=; b=k3m4WjCoPPx3bNE9bnVQTNcusd6Oy
	LT2CqT6oFAZ6tuyViJ4OWyTM6bWuIWMN8SU0H9ulQ5sro+eVePLx+Z4LBD/8v4qd
	OCXPIPuydVhA6wTsZlWmiiBv9B/mu0/O5H04cX5qwYWTzst7ZJyr/SsEST4GGBNx
	YsqXHi8Uek7ztPYHEBEJ6JklXZbeC8N4Wmm7oqesdUV/4JoJEaUo63JxM4NI2Ai1
	uff7/+0z2+2d6ItOPxXu25SxcHMO7Z7dpMpstD4LcZWTle3ghLblbNDQh570C1GE
	tUX/Pa+9H7TQNEQb9m/g87i9DFN3lfcUzty3qtVRh4G+AbR+BcKt45TDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424x4nrqyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4987h7EP003834;
	Tue, 8 Oct 2024 07:43:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424x4nrqy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4983Z9jV022830;
	Tue, 8 Oct 2024 07:43:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0thbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4987h3sk56426994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 07:43:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 775EE2004B;
	Tue,  8 Oct 2024 07:43:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D176A20043;
	Tue,  8 Oct 2024 07:43:02 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.23.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 07:43:02 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v5 2/4] selftests: kvm: s390: Add uc_skey VM test case
Date: Tue,  8 Oct 2024 09:42:51 +0200
Message-ID: <20241008074253.370481-3-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008074253.370481-1-schlameuss@linux.ibm.com>
References: <20241008074253.370481-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QGqAhfZLADHgFalS9BwJYPDScdIzFpcE
X-Proofpoint-ORIG-GUID: XhHt0MitjYKbUYRd2LJPE2kWe3z8WkdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_05,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=979
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080047

Add a test case manipulating s390 storage keys from within the ucontrol
VM.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 3e649b12a0b9..f022322a00d4 100644
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
@@ -300,6 +327,7 @@ static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) *self)
 
 /* verify SIEIC exit
  * * fail on codes not expected in the test cases
+ * Returns if interception is handled / execution can be continued
  */
 static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 {
@@ -316,6 +344,10 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 		/* end execution in caller on intercepted instruction */
 		pr_info("sie instruction interception\n");
 		return false;
+	case ICPT_KSS:
+		/* disable KSS and continue; KVM would init the skeys here */
+		sie_block->cpuflags &= ~CPUSTAT_KSS;
+		return true;
 	case ICPT_OPEREXC:
 		/* operation exception */
 		TEST_FAIL("sie exception on %.4x%.8x", sie_block->ipa, sie_block->ipb);
@@ -472,4 +504,59 @@ TEST_F(uc_kvm, uc_gprs)
 	ASSERT_EQ(1, sync_regs->gprs[0]);
 }
 
+TEST_F(uc_kvm, uc_skey)
+{
+	u64 test_vaddr = VM_MEM_SIZE - (SZ_1M / 2);
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
+	/* SSKE */
+	sync_regs->gprs[1] = skeyvalue;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	ASSERT_EQ(3, sync_regs->gprs[0]);
+	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
+	uc_assert_diag44(self);
+
+	/* RRBE */
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
2.46.2


