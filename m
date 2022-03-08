Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3C4D187B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 13:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347038AbiCHNAD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 08:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346994AbiCHM76 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 07:59:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FDF2C12B;
        Tue,  8 Mar 2022 04:58:55 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228BYAvC017483;
        Tue, 8 Mar 2022 12:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FUIJ2h0hGI+wGRKZxTbWNPxejq/VKs2ZPHWzmZawBVs=;
 b=ZCsLX4H6zxlWk21/WZMyTeiZA3jtPVw5twHOHnVJ+KVyIA8iWXlwQJVtVhMsBq3cDBRc
 xNUmP3FpL+6eB707oW4M6hnMqiKKxK3amR81yJNI69oRfvvBuYv4zuBYAud3aPMg6cuS
 f5xliJppjpBBzLWfAcLQx+4dzlvHXVW9oX+awzrqOmGbTEyegJkshhqt9F7kYbyK1M9X
 9qbKiG1pckz/E66tsq5EVFA6vYKjv7UVO8Nm/CAUt3S3acKlDZO5hjMl71gdZu5fltBC
 tc8glezKcQcK6yfEALa+MKwfz3ba2EtajzNHgQF73AuPMrie6UAkcva/UjVKHOwOYNi/ /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0scg6m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:52 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228CgPfV003542;
        Tue, 8 Mar 2022 12:58:52 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0scg6kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:52 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228CrcRX017957;
        Tue, 8 Mar 2022 12:58:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3ekyg96dwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228CwlUh50528542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 12:58:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3582C11C058;
        Tue,  8 Mar 2022 12:58:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC14011C054;
        Tue,  8 Mar 2022 12:58:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 12:58:46 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] KVM: s390: selftests: Add error memop tests
Date:   Tue,  8 Mar 2022 13:58:41 +0100
Message-Id: <20220308125841.3271721-6-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308125841.3271721-1-scgl@linux.ibm.com>
References: <20220308125841.3271721-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RXuaMq1tvDyP4dZ0aV40ib1TK4COWNRY
X-Proofpoint-GUID: ZKbA5SUpBLlRs9_Rx8BRXIDtKA9oWabB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test that errors occur if key protection disallows access, including
tests for storage and fetch protection override. Perform tests for both
logical vcpu and absolute vm ioctls.
Also extend the existing tests to the vm ioctl.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 137 ++++++++++++++++++++--
 1 file changed, 124 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index c46d47672e2a..638a0609426a 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -422,6 +422,46 @@ static void test_copy_key_fetch_prot(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+#define ERR_PROT_MOP(...)							\
+({										\
+	int rv;									\
+										\
+	rv = ERR_MOP(__VA_ARGS__);						\
+	TEST_ASSERT(rv == 4, "Should result in protection exception");		\
+})
+
+static void test_errors_key(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vm/vcpu, mismatching keys, fetch protection in effect */
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, t.size, GADDR_V(mem2), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, WRITE, mem1, t.size, GADDR_V(mem1), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, t.size, GADDR_V(mem2), KEY(2));
+
+	kvm_vm_free(t.kvm_vm);
+}
+
+static void test_errors_key_storage_prot_override(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	t.run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
+	t.run->kvm_dirty_regs = KVM_SYNC_CRS;
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vm, mismatching keys, storage protection override not applicable to vm */
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, WRITE, mem1, t.size, GADDR_V(mem1), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, t.size, GADDR_V(mem2), KEY(2));
+
+	kvm_vm_free(t.kvm_vm);
+}
+
 const uint64_t last_page_addr = -PAGE_SIZE;
 
 static void guest_copy_key_fetch_prot_override(void)
@@ -481,6 +521,58 @@ static void test_copy_key_fetch_prot_override(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+static void test_errors_key_fetch_prot_override_not_enabled(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot_override);
+	vm_vaddr_t guest_0_page, guest_last_page;
+
+	guest_0_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, 0);
+	guest_last_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, last_page_addr);
+	if (guest_0_page != 0 || guest_last_page != last_page_addr) {
+		print_skip("did not allocate guest pages at required positions");
+		goto out;
+	}
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vcpu, mismatching keys on fetch, fetch protection override not enabled */
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, 2048, GADDR_V(0), KEY(2));
+
+out:
+	kvm_vm_free(t.kvm_vm);
+}
+
+static void test_errors_key_fetch_prot_override_enabled(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot_override);
+	vm_vaddr_t guest_0_page, guest_last_page;
+
+	guest_0_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, 0);
+	guest_last_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, last_page_addr);
+	if (guest_0_page != 0 || guest_last_page != last_page_addr) {
+		print_skip("did not allocate guest pages at required positions");
+		goto out;
+	}
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	t.run->s.regs.crs[0] |= CR0_FETCH_PROTECTION_OVERRIDE;
+	t.run->kvm_dirty_regs = KVM_SYNC_CRS;
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/*
+	 * vcpu, mismatching keys on fetch,
+	 * fetch protection override does not apply because memory range acceeded
+	 */
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, 2048 + 1, GADDR_V(0), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, PAGE_SIZE + 2048 + 1,
+				 GADDR_V(guest_last_page), KEY(2));
+	/* vm, fetch protected override does not apply */
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, 2048, GADDR(0), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, 2048, GADDR_V(guest_0_page), KEY(2));
+
+out:
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void guest_idle(void)
 {
 	GUEST_SYNC(STAGE_INITED); /* for consistency's sake */
@@ -488,39 +580,54 @@ static void guest_idle(void)
 		GUEST_SYNC(STAGE_IDLED);
 }
 
-static void test_errors(void)
+static void _test_errors_common(struct test_vcpu vcpu, enum mop_target target, int size)
 {
-	struct test_default t = test_default_init(guest_idle);
 	int rv;
 
-	HOST_SYNC(t.vcpu, STAGE_INITED);
-
 	/* Bad size: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, -1, GADDR_V(mem1));
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, -1, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
 
 	/* Zero size: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, 0, GADDR_V(mem1));
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, 0, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && (errno == EINVAL || errno == ENOMEM),
 		    "ioctl allows 0 as size");
 
 	/* Bad flags: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), SET_FLAGS(-1));
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, size, GADDR_V(mem1), SET_FLAGS(-1));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags");
 
-	/* Bad operation: */
-	rv = ERR_MOP(t.vcpu, INVALID, WRITE, mem1, t.size, GADDR_V(mem1));
-	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
-
 	/* Bad guest address: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR((void *)~0xfffUL), CHECK_ONLY);
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, size, GADDR((void *)~0xfffUL), CHECK_ONLY);
 	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
 
 	/* Bad host address: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, 0, t.size, GADDR_V(mem1));
+	rv = ERR_MOP(vcpu, target, WRITE, 0, size, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == EFAULT,
 		    "ioctl does not report bad host memory address");
 
+	/* Bad key: */
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, size, GADDR_V(mem1), KEY(17));
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows invalid key");
+}
+
+static void test_errors(void)
+{
+	struct test_default t = test_default_init(guest_idle);
+	int rv;
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
+	_test_errors_common(t.vcpu, LOGICAL, t.size);
+	_test_errors_common(t.vm, ABSOLUTE, t.size);
+
+	/* Bad operation: */
+	rv = ERR_MOP(t.vcpu, INVALID, WRITE, mem1, t.size, GADDR_V(mem1));
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
+	/* virtual addresses are not translated when passing INVALID */
+	rv = ERR_MOP(t.vm, INVALID, WRITE, mem1, PAGE_SIZE, GADDR(0));
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
+
 	/* Bad access register: */
 	t.run->psw_mask &= ~(3UL << (63 - 17));
 	t.run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
@@ -560,6 +667,10 @@ int main(int argc, char *argv[])
 		test_copy_key_storage_prot_override();
 		test_copy_key_fetch_prot();
 		test_copy_key_fetch_prot_override();
+		test_errors_key();
+		test_errors_key_storage_prot_override();
+		test_errors_key_fetch_prot_override_not_enabled();
+		test_errors_key_fetch_prot_override_enabled();
 	} else {
 		print_skip("storage key memop extension not supported");
 	}
-- 
2.32.0

