Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A0A4C49AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 16:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiBYPx7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 10:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242398AbiBYPx6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 10:53:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B91D3AE3;
        Fri, 25 Feb 2022 07:53:26 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PEHE29008642;
        Fri, 25 Feb 2022 15:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=b/9bBvjgzbg022NLVuh043z7Uu3m1YE7tOn1F7kdD1c=;
 b=RgdMBpQChEWsZ7tIPSYhFwPVF4bFYtQGFCopMFwU3NeGe52GOk2Gvf8fCFvuD39nx7EY
 RWvV4s0pN9J0+fkehbdvLY7TtFMawUOkgk9jk4TyAEDvk3TZCltY+V3TEV7iu3Bo5MXZ
 mVd6u4TNmMCTIG2sY+BHqeD57qyVilAcyzfpGXjCSD0hPPM0jiTDCN4JBXGMOpcqhq0S
 7727UQR2Fzp90YMygxV6qdeohfnJUfFQaqzmzeXBJqfaKcmNrGUayEUHdoTc3mwi7iAg
 4J8FfCoJzHK5Cpc3KBIzsWo+AZv5GIakltLFLchjyWbOtPGWh9zHl6nG0ScSQKoQhR5s 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ef0r9jmtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:23 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21PEHQKm009028;
        Fri, 25 Feb 2022 15:53:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ef0r9jmsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PFqnpQ022412;
        Fri, 25 Feb 2022 15:53:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqtjsskj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PFrFc557606446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:53:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1357DAE04D;
        Fri, 25 Feb 2022 15:53:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB185AE05A;
        Fri, 25 Feb 2022 15:53:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 15:53:14 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] KVM: s390: selftests: Split memop tests
Date:   Fri, 25 Feb 2022 16:53:07 +0100
Message-Id: <20220225155311.3540514-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225155311.3540514-1-scgl@linux.ibm.com>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220225155311.3540514-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wYo0Q6dVzu2kln6hsDRmnDdG9oKCOCHT
X-Proofpoint-GUID: PgIM61WcF7KBblBLUh_6OmG24Rq7pvTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_09,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split success case/copy test from error test, making them independent.
This means they do not share state and are easier to understand.
Also, new test can be added in the same manner without affecting the old
ones. In order to make that simpler, introduce functionality for the
setup of commonly used variables.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 137 +++++++++++++---------
 1 file changed, 82 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index d19c3ffdea3f..b9b673acb766 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -18,71 +18,82 @@
 static uint8_t mem1[65536];
 static uint8_t mem2[65536];
 
-static void guest_code(void)
+struct test_default {
+	struct kvm_vm *kvm_vm;
+	struct kvm_run *run;
+	int size;
+};
+
+static struct test_default test_default_init(void *guest_code)
 {
-	int i;
+	struct test_default t;
 
-	for (;;) {
-		for (i = 0; i < sizeof(mem2); i++)
-			mem2[i] = mem1[i];
-		GUEST_SYNC(0);
-	}
+	t.size = min((size_t)kvm_check_cap(KVM_CAP_S390_MEM_OP), sizeof(mem1));
+	t.kvm_vm = vm_create_default(VCPU_ID, 0, guest_code);
+	t.run = vcpu_state(t.kvm_vm, VCPU_ID);
+	return t;
 }
 
-int main(int argc, char *argv[])
+static void guest_copy(void)
 {
-	struct kvm_vm *vm;
-	struct kvm_run *run;
-	struct kvm_s390_mem_op ksmo;
-	int rv, i, maxsize;
-
-	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
-
-	maxsize = kvm_check_cap(KVM_CAP_S390_MEM_OP);
-	if (!maxsize) {
-		print_skip("CAP_S390_MEM_OP not supported");
-		exit(KSFT_SKIP);
-	}
-	if (maxsize > sizeof(mem1))
-		maxsize = sizeof(mem1);
+	memcpy(&mem2, &mem1, sizeof(mem2));
+	GUEST_SYNC(0);
+}
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+static void test_copy(void)
+{
+	struct test_default t = test_default_init(guest_copy);
+	struct kvm_s390_mem_op ksmo;
+	int i;
 
 	for (i = 0; i < sizeof(mem1); i++)
 		mem1[i] = i * i + i;
 
 	/* Set the first array */
-	ksmo.gaddr = addr_gva2gpa(vm, (uintptr_t)mem1);
+	ksmo.gaddr = addr_gva2gpa(t.kvm_vm, (uintptr_t)mem1);
 	ksmo.flags = 0;
-	ksmo.size = maxsize;
+	ksmo.size = t.size;
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 
 	/* Let the guest code copy the first array to the second */
-	vcpu_run(vm, VCPU_ID);
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
+	vcpu_run(t.kvm_vm, VCPU_ID);
+	TEST_ASSERT(t.run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "Unexpected exit reason: %u (%s)\n",
-		    run->exit_reason,
-		    exit_reason_str(run->exit_reason));
+		    t.run->exit_reason,
+		    exit_reason_str(t.run->exit_reason));
 
 	memset(mem2, 0xaa, sizeof(mem2));
 
 	/* Get the second array */
 	ksmo.gaddr = (uintptr_t)mem2;
 	ksmo.flags = 0;
-	ksmo.size = maxsize;
+	ksmo.size = t.size;
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
 	ksmo.buf = (uintptr_t)mem2;
 	ksmo.ar = 0;
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 
-	TEST_ASSERT(!memcmp(mem1, mem2, maxsize),
+	TEST_ASSERT(!memcmp(mem1, mem2, t.size),
 		    "Memory contents do not match!");
 
+	kvm_vm_free(t.kvm_vm);
+}
+
+static void guest_idle(void)
+{
+	for (;;)
+		GUEST_SYNC(0);
+}
+
+static void test_errors(void)
+{
+	struct test_default t = test_default_init(guest_idle);
+	struct kvm_s390_mem_op ksmo;
+	int rv;
+
 	/* Check error conditions - first bad size: */
 	ksmo.gaddr = (uintptr_t)mem1;
 	ksmo.flags = 0;
@@ -90,7 +101,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
 
 	/* Zero size: */
@@ -100,65 +111,65 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && (errno == EINVAL || errno == ENOMEM),
 		    "ioctl allows 0 as size");
 
 	/* Bad flags: */
 	ksmo.gaddr = (uintptr_t)mem1;
 	ksmo.flags = -1;
-	ksmo.size = maxsize;
+	ksmo.size = t.size;
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags");
 
 	/* Bad operation: */
 	ksmo.gaddr = (uintptr_t)mem1;
 	ksmo.flags = 0;
-	ksmo.size = maxsize;
+	ksmo.size = t.size;
 	ksmo.op = -1;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
 
 	/* Bad guest address: */
 	ksmo.gaddr = ~0xfffUL;
 	ksmo.flags = KVM_S390_MEMOP_F_CHECK_ONLY;
-	ksmo.size = maxsize;
+	ksmo.size = t.size;
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
 
 	/* Bad host address: */
 	ksmo.gaddr = (uintptr_t)mem1;
 	ksmo.flags = 0;
-	ksmo.size = maxsize;
+	ksmo.size = t.size;
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = 0;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EFAULT,
 		    "ioctl does not report bad host memory address");
 
 	/* Bad access register: */
-	run->psw_mask &= ~(3UL << (63 - 17));
-	run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
-	vcpu_run(vm, VCPU_ID);              /* To sync new state to SIE block */
+	t.run->psw_mask &= ~(3UL << (63 - 17));
+	t.run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
+	vcpu_run(t.kvm_vm, VCPU_ID);              /* To sync new state to SIE block */
 	ksmo.gaddr = (uintptr_t)mem1;
 	ksmo.flags = 0;
-	ksmo.size = maxsize;
+	ksmo.size = t.size;
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 17;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
-	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
-	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
+	t.run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
+	vcpu_run(t.kvm_vm, VCPU_ID);                  /* Run to sync new state */
 
 	/* Check that the SIDA calls are rejected for non-protected guests */
 	ksmo.gaddr = 0;
@@ -167,15 +178,31 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_SIDA_READ;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.sida_offset = 0x1c0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL,
 		    "ioctl does not reject SIDA_READ in non-protected mode");
 	ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL,
 		    "ioctl does not reject SIDA_WRITE in non-protected mode");
 
-	kvm_vm_free(vm);
+	kvm_vm_free(t.kvm_vm);
+}
+
+int main(int argc, char *argv[])
+{
+	int memop_cap;
+
+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
+
+	memop_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP);
+	if (!memop_cap) {
+		print_skip("CAP_S390_MEM_OP not supported");
+		exit(KSFT_SKIP);
+	}
+
+	test_copy();
+	test_errors();
 
 	return 0;
 }
-- 
2.32.0

