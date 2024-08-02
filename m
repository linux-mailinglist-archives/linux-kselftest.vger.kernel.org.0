Return-Path: <linux-kselftest+bounces-14726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A9946147
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924A82854DE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 16:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7751E485F;
	Fri,  2 Aug 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s3ZGfbwn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455371C5786;
	Fri,  2 Aug 2024 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614400; cv=none; b=cmPNABU/YIkPW60xBhqAqS4vmWnGdAJ15IcvhTsDwq30VAqgt3bb2yy61px71Pm9TzGw2vSUYTX3zaZKLR3pQ+CCE6e/wC88qGFVdvoldfDfMSzaMdDNs4Ajy2+uYsKhUrg8dTIao0xvsr8SEbQiazghKBZ0E/2bNeAzTxYNntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614400; c=relaxed/simple;
	bh=+RLoBvDm35Qrmy+cMt/S5qzx3VvUgODBHxubsDUmEmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbV8GZ4Nuxxb/egGYuHMImENyxlA1CydhhBWUMHHJT3k7nnq9fsTSeozP6mRQv1e/Tj9iiu2avt03Cub+qZoi7zVrZrWMgXsLGsDjKeWDkrzbs8aN6Nsxkj39yYAb+CiyHu6fsFUlNM+Ot31TpA5pxpcEXdHOzYPlCLUFowzapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s3ZGfbwn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472Fxdmk029525;
	Fri, 2 Aug 2024 15:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=81XXP1+1lH0Ek
	MD58w+vrWq/xB6RJ98HCmtcRdmaeqg=; b=s3ZGfbwny0QGoupfjZMwngf6YPSxM
	9SHslwXXyUc1gL5wLSAGnoT93lH8vYD5xgPwOKUAJIw1izu3bmjO4owEXTOJzLLo
	qtuUC3gW/ClLI4PBa0Mw7VekUk8s3Gsbg9H5mv9bzivYLLlPjVL1k2x2XEAmqQRn
	/bXKx30HuKJ+zSX+FiNDriUrXUWUJK4lCffNMWyxROpIvKoytrt26UTp51hZTLMJ
	5Vss2es+e+zb5nSafPtEV9bWO5Gk0i5qS+lY+d1hmGxjrcS0H2fXnHrhyjuxLmig
	uCeP+doLx9EBtVyeQH+I4EOIoXpKArXgPloYboWROLnpFGK8MFnBHYk0Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s2jk002d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:50 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472Fxo86029651;
	Fri, 2 Aug 2024 15:59:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s2jk002b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472EiQgL011142;
	Fri, 2 Aug 2024 15:59:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn7wc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472FxhhM51249584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 15:59:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DCA12004D;
	Fri,  2 Aug 2024 15:59:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7739620040;
	Fri,  2 Aug 2024 15:59:42 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.84.102])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 15:59:42 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v4 06/10] selftests: kvm: s390: Add VM run test case
Date: Fri,  2 Aug 2024 17:59:09 +0200
Message-ID: <20240802155913.261891-7-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: lh8w1vzo9skXBttK_yWEQnrO_4LzzMeg
X-Proofpoint-ORIG-GUID: uolFKjWs2HxGhMlTx7aVDLlNlmOBVCgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=760 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020110

Add test case running code interacting with registers within a
ucontrol VM.

* Add uc_gprs test case

The test uses the same VM setup using the fixture and debug macros
introduced in earlier patches in this series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index d103a92e7495..030c59010fe1 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -7,6 +7,7 @@
  * Authors:
  *  Christoph Schlameuss <schlameuss@linux.ibm.com>
  */
+#include "debug_print.h"
 #include "kselftest_harness.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -40,6 +41,23 @@ void require_ucontrol_admin(void)
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
 }
 
+/* Test program setting some registers and looping */
+extern char test_gprs_asm[];
+asm("test_gprs_asm:\n"
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
@@ -204,4 +222,112 @@ TEST(uc_cap_hpage)
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
+	pr_info("sieic: 0x%.2x 0x%.4x 0x%.4x\n",
+		run->s390_sieic.icptcode,
+		run->s390_sieic.ipa,
+		run->s390_sieic.ipb);
+	switch (run->s390_sieic.icptcode) {
+	case ICPT_INST:
+		/* end execution in caller on intercepted instruction */
+		pr_info("sie instruction interception\n");
+		return false;
+	case ICPT_OPEREXC:
+		/* operation exception */
+		TEST_FAIL("sie exception on %.4x%.8x", sie_block->ipa, sie_block->ipb);
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
+	print_regs(self->run);
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
+	struct kvm_run *run = self->run;
+	struct kvm_regs regs = {};
+
+	/* Set registers to values that are different from the ones that we expect below */
+	for (int i = 0; i < 8; i++)
+		sync_regs->gprs[i] = 8;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+
+	/* copy test_gprs_asm to code_hva / code_gpa */
+	TH_LOG("copy code %p to vm mapped memory %p / %p",
+	       &test_gprs_asm, (void *)self->code_hva, (void *)self->code_gpa);
+	memcpy((void *)self->code_hva, &test_gprs_asm, PAGE_SIZE);
+
+	/* DAT disabled + 64 bit mode */
+	run->psw_mask = 0x0000000180000000ULL;
+	run->psw_addr = self->code_gpa;
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


