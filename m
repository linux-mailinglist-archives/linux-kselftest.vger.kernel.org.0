Return-Path: <linux-kselftest+bounces-13376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9746792BA20
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9172867E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCB81607A0;
	Tue,  9 Jul 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iF3Jct1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FA15EFC0;
	Tue,  9 Jul 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529851; cv=none; b=OubYD9oWj8if4wBVb72uOrJCxFFRv8E5UxV0rYozxJmrc1AHJjK6OfLATbMBsaAHpBoIU52LSE71/ed8kagnu4vdUBkBmSsjnmn1VOG7VzFCnZ5IY7mlPpHMtCh2RPpXY8FJIjVY1ofAqW3scnYTUOSi9XEwL59xPAG5NpPiFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529851; c=relaxed/simple;
	bh=msL/lsdn9Lyl0BFWNUoxtcqtBDNSiF8VQ58BbTEVHnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt/c63pHyB3T4jBxbMaZ6crkktlVuXUc90+RK1nEZYhHwQilfx+t0a9CpIJLgrB4jghneKIUO4cKflaUcZCeHny6iot1EB2P7nyun2c0VFNvGP7s+/OHb+ul+hHp36vts2kpwds595vb6Pi/BUsWquWB3IqnuLOr20ohWwfeqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iF3Jct1N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CWUiT027445;
	Tue, 9 Jul 2024 12:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=GwHQ/XUT7RYWN
	tumElVB8ptiohn+XIosb6iPaWj8GdE=; b=iF3Jct1NQqJh47avaPgZQXhWj1cBi
	kuWoitocKjrqHjjnJKolcT/5RI2ViQDpRdZaV+1Mpiv6Z0VPuKXtHoSSpEkvfLt7
	PkxlsGuXJA8otCYvZonW7zCUczBuslw/whNxPTdwAs+AqVFMn05R73E+ofHD7rr0
	uTrNVaaIqKti3VWkISIRCA98xBZOzN0dqAml3oiarSYyWCcAozaD7oKf0sW12OF+
	faiLR2WsDgpZTZiGL0fhNxFugWhfNlZypTKGxFIiyGoUhJ+9sfGf+ERYG0CaVZGu
	WgkmRdj650hfvSelqg2Hj0BPGnZ0hfLPKbmASok0XbMaqn31CdVAmDt4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4092ks8gr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469CvQHY031109;
	Tue, 9 Jul 2024 12:57:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4092ks8gr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469CFo0i025952;
	Tue, 9 Jul 2024 12:57:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmmeev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469CvJRT52167020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:57:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C092004E;
	Tue,  9 Jul 2024 12:57:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 182D520040;
	Tue,  9 Jul 2024 12:57:19 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.6.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 12:57:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v1 6/9] selftests: kvm: s390: Add VM run test case
Date: Tue,  9 Jul 2024 14:57:01 +0200
Message-ID: <20240709125704.61312-7-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709125704.61312-1-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G7DVg4i5oyLA3gHiEbFPmMR5uLScex1-
X-Proofpoint-ORIG-GUID: xtDFrr2iIAktc73e6Xcx3MiZ0cleWHU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=771 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090082

Add test case running code interacting with registers within a
ucontrol VM.

* Add uc_gprs test case

The test uses the same VM setup using the fixture and debug macros
introduced in earlier patches in this series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 5c009ee27fd2..deeb9d089124 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -43,6 +43,23 @@ void require_ucontrol_admin(void)
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
 }
 
+/* Test program setting some registers and looping */
+extern char test_gprs_pgm[];
+asm("test_gprs_pgm:\n"
+	"xgr	%r0, %r0\n"
+	"lgfi	%r1,1\n"
+	"lgfi	%r2,2\n"
+	"lgfi	%r3,3\n"
+	"lgfi	%r4,4\n"
+	"lgfi	%r5,5\n"
+	"lgfi	%r6,6\n"
+	"lgfi	%r7,7\n"
+	"0:\n"
+	"	diag	0,0,0x44\n"
+	"	ahi	%r0,1\n"
+	"	j	0b\n"
+);
+
 FIXTURE(uc_kvm)
 {
 	struct kvm_s390_sie_block *sie_block;
@@ -206,4 +223,118 @@ TEST(uc_cap_hpage)
 	close(kvm_fd);
 }
 
+/* verify SIEIC exit
+ * * reset stop requests
+ * * fail on codes not expected in the test cases
+ */
+static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
+{
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
+	struct kvm_run *run = self->run;
+
+	/* check SIE interception code */
+	pr_info("sieic: 0x%2x 0x%4x 0x%4x\n",
+		run->s390_sieic.icptcode,
+		run->s390_sieic.ipa,
+		run->s390_sieic.ipb);
+	switch (run->s390_sieic.icptcode) {
+	case ICPT_STOP:
+		/* stopped via sie V P --> ignore */
+		/* reset stop request */
+		sie_block->cpuflags = sie_block->cpuflags & ~CPUSTAT_STOP_INT;
+		pr_info("sie V P - cleared %.4x\n", sie_block->cpuflags);
+		break;
+	case ICPT_INST:
+		/* end execution in caller on intercepted instruction */
+		return false;
+	default:
+		TEST_FAIL("UNEXPECTED SIEIC CODE %d", run->s390_sieic.icptcode);
+	}
+	return true;
+}
+
+/* verify VM state on exit */
+static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
+{
+	struct kvm_run *run = self->run;
+
+	switch (run->exit_reason) {
+	case KVM_EXIT_S390_SIEIC:
+		return uc_handle_sieic(self);
+	default:
+		pr_info("exit_reason %2d not handled\n", run->exit_reason);
+	}
+	return true;
+}
+
+/* run the VM until interrupted */
+static int uc_run_once(FIXTURE_DATA(uc_kvm) * self)
+{
+	int rc;
+
+	rc = ioctl(self->vcpu_fd, KVM_RUN, NULL);
+	print_run(self->run, self->sie_block);
+	pr_debug("run %d / %d %s\n", rc, errno, strerror(errno));
+	return rc;
+}
+
+static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
+{
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
+
+	/* assert vm was interrupted by diag 0x0044 */
+	TEST_ASSERT_EQ(KVM_EXIT_S390_SIEIC, self->run->exit_reason);
+	TEST_ASSERT_EQ(ICPT_INST, sie_block->icptcode);
+	TEST_ASSERT_EQ(0x8300, sie_block->ipa);
+	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
+}
+
+TEST_F(uc_kvm, uc_gprs)
+{
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
+	struct kvm_run *run = self->run;
+	struct kvm_regs regs = {};
+
+	/* Set registers to values that are different from the ones that we expect below */
+	for (int i = 0; i < 8; i++)
+		sync_regs->gprs[i] = 8;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+
+	/* copy test_gprs_pgm to code_hva / code_gpa */
+	TH_LOG("copy code %p to vm mapped memory %p / %p",
+	       &test_gprs_pgm, (void *)self->code_hva, (void *)self->code_gpa);
+	memcpy((void *)self->code_hva, &test_gprs_pgm, PAGE_SIZE);
+
+	run->psw_mask = 0x0000000180000000ULL;  /* DAT disabled + 64 bit mode */
+	run->psw_addr = self->code_gpa;
+
+	/* run VM and expect immediate stop */
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(true, uc_handle_exit(self));
+	ASSERT_EQ(self->code_gpa, sie_block->psw_addr);
+
+	/* run and expect interception of diag 44 */
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	uc_assert_diag44(self);
+
+	/* Retrieve and check guest register values */
+	ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_GET_REGS, &regs));
+	for (int i = 0; i < 8; i++) {
+		ASSERT_EQ(i, regs.gprs[i]);
+		ASSERT_EQ(i, sync_regs->gprs[i]);
+	}
+
+	/* run and expect interception of diag 44 again */
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	uc_assert_diag44(self);
+
+	/* check continued increment of register 0 value */
+	ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_GET_REGS, &regs));
+	ASSERT_EQ(1, regs.gprs[0]);
+	ASSERT_EQ(1, sync_regs->gprs[0]);
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2


