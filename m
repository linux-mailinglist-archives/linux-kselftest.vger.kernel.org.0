Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9439B4C49AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbiBYPx6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 10:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242392AbiBYPx5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 10:53:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C61CF08A;
        Fri, 25 Feb 2022 07:53:24 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PFn91H004613;
        Fri, 25 Feb 2022 15:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8Y2ABjpYWWnR/LlVofE7lC41+UQ0SvBEyLm6aY2bLMI=;
 b=sXafDwAaKwFqjINTLEKR29ag3If4e96ivSsODIZISFvBAi3VemtQJW4+e1e2rB+Ccl4i
 8gi8D9hrHs/HJXRDljyUa3BqKX1Q99ppoHfjS6Ci1xV5E69RNFD94+ZkwivJUhSHYbA3
 lBAKGxOvQxi8LPAlGTLHetykS9+BBxmKB/RRcnPzP8pBW3Z4EFJmZzX3wuqpDm1bC7LR
 MLSZBCA/bQ+uMpZpI3vf7aUEOpeViSzn6m8dKlMJBBS6pGwyCOO1si2gWvTepQK6Vz9w
 y0li18BoK7ojj5DyVyWS0gmMfppDOhdk8FF+c3v2bYkorjbE6k8G7waGaeqjH0nCfypE Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ef23c82t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:21 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21PFoQSV007135;
        Fri, 25 Feb 2022 15:53:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ef23c82s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PFqCZ5023975;
        Fri, 25 Feb 2022 15:53:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear69sp5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PFrGJC41091496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:53:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2702AE04D;
        Fri, 25 Feb 2022 15:53:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57884AE051;
        Fri, 25 Feb 2022 15:53:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 15:53:16 +0000 (GMT)
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
Date:   Fri, 25 Feb 2022 16:53:11 +0100
Message-Id: <20220225155311.3540514-6-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225155311.3540514-1-scgl@linux.ibm.com>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220225155311.3540514-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yCVIEmE--z8Ap-Vm-KPZ26c0IvIkOik8
X-Proofpoint-ORIG-GUID: ANgpY0w4ZPrbAyX5ToMmdfPqgR4hQlZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_09,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250091
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
 tools/testing/selftests/kvm/s390x/memop.c | 136 +++++++++++++++++++---
 1 file changed, 123 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 088d1cc61709..55048bfecdcb 100644
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
@@ -481,6 +521,57 @@ static void test_copy_key_fetch_prot_override(void)
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
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, 2048, GADDR(0), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, 2048, GADDR_V(guest_0_page), KEY(2));
+
+out:
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void guest_idle(void)
 {
 	GUEST_SYNC(STAGE_INITED); /* for consistencies sake */
@@ -488,39 +579,54 @@ static void guest_idle(void)
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
@@ -560,6 +666,10 @@ int main(int argc, char *argv[])
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

