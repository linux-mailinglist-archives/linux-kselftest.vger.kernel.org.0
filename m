Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87F7664D42
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjAJU1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjAJU0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:26:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB4C5D40A;
        Tue, 10 Jan 2023 12:26:48 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJg630018333;
        Tue, 10 Jan 2023 20:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6uvng8xL5Bn+rEjeHfV5ejsTfeOIVOj1jBKo1ovV3lI=;
 b=fLSA/ojPACJHDXBEpCC/6aj4zBLyOeSy0gLXeIATnm4STm5cjNo/KZX+s6JXyPBO3aoW
 PFumPlsaAHzKndCLv59u4XjoZYLGkNTm9iI0+lJ4sKtlleU1sPmp5JfUswH3rHw8Pp6y
 nfkEIhZn7KjcwsOQ3fDjT7wxrbL1rJ8IY41ItMb2yvw0SlIeJm78604hzAi4hQo+ohJb
 oaavP90/Bf6CspJzvOsaZmPw6D1m1OMIDBqh3HYAtg3zTQqRokzqr0XPfgnncR1aJr6S
 p6UNW7OqNET0Ib2WkkRv/I5vSEMsrp068PS0kdiUNaKWvnFdDfeVx+2bWcz5sItxcFw0 ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1edd8yh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:46 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AKHklC002068;
        Tue, 10 Jan 2023 20:26:45 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1edd8yg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:43 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30AICHUG000580;
        Tue, 10 Jan 2023 20:26:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6ndgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AKQcIM24380000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 20:26:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E175120040;
        Tue, 10 Jan 2023 20:26:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EF8820043;
        Tue, 10 Jan 2023 20:26:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 20:26:37 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 04/10] KVM: s390: selftest: memop: Replace macros by functions
Date:   Tue, 10 Jan 2023 21:26:26 +0100
Message-Id: <20230110202632.2533978-5-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110202632.2533978-1-scgl@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UeXZcr_zYf4T1kaLXjre6NeSw_Uhk7ZI
X-Proofpoint-GUID: vI5E8h5jRyAgMT4sOpALuPVxxYc78lDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the DEFAULT_* test helpers by functions, as they don't
need the exta flexibility.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 82 +++++++++++------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 9c05d1205114..df1c726294b2 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -48,6 +48,8 @@ struct mop_desc {
 	uint8_t key;
 };
 
+const uint8_t NO_KEY = 0xff;
+
 static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
 {
 	struct kvm_s390_mem_op ksmo = {
@@ -85,7 +87,7 @@ static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
 		ksmo.flags |= KVM_S390_MEMOP_F_INJECT_EXCEPTION;
 	if (desc->_set_flags)
 		ksmo.flags = desc->set_flags;
-	if (desc->f_key) {
+	if (desc->f_key && desc->key != NO_KEY) {
 		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
 		ksmo.key = desc->key;
 	}
@@ -268,34 +270,28 @@ static void prepare_mem12(void)
 #define ASSERT_MEM_EQ(p1, p2, size) \
 	TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
 
-#define DEFAULT_WRITE_READ(copy_cpu, mop_cpu, mop_target_p, size, ...)		\
-({										\
-	struct test_info __copy_cpu = (copy_cpu), __mop_cpu = (mop_cpu);	\
-	enum mop_target __target = (mop_target_p);				\
-	uint32_t __size = (size);						\
-										\
-	prepare_mem12();							\
-	CHECK_N_DO(MOP, __mop_cpu, __target, WRITE, mem1, __size,		\
-			GADDR_V(mem1), ##__VA_ARGS__);				\
-	HOST_SYNC(__copy_cpu, STAGE_COPIED);					\
-	CHECK_N_DO(MOP, __mop_cpu, __target, READ, mem2, __size,		\
-			GADDR_V(mem2), ##__VA_ARGS__);				\
-	ASSERT_MEM_EQ(mem1, mem2, __size);					\
-})
+static void default_write_read(struct test_info copy_cpu, struct test_info mop_cpu,
+			       enum mop_target mop_target, uint32_t size, uint8_t key)
+{
+	prepare_mem12();
+	CHECK_N_DO(MOP, mop_cpu, mop_target, WRITE, mem1, size,
+		   GADDR_V(mem1), KEY(key));
+	HOST_SYNC(copy_cpu, STAGE_COPIED);
+	CHECK_N_DO(MOP, mop_cpu, mop_target, READ, mem2, size,
+		   GADDR_V(mem2), KEY(key));
+	ASSERT_MEM_EQ(mem1, mem2, size);
+}
 
-#define DEFAULT_READ(copy_cpu, mop_cpu, mop_target_p, size, ...)		\
-({										\
-	struct test_info __copy_cpu = (copy_cpu), __mop_cpu = (mop_cpu);	\
-	enum mop_target __target = (mop_target_p);				\
-	uint32_t __size = (size);						\
-										\
-	prepare_mem12();							\
-	CHECK_N_DO(MOP, __mop_cpu, __target, WRITE, mem1, __size,		\
-			GADDR_V(mem1));						\
-	HOST_SYNC(__copy_cpu, STAGE_COPIED);					\
-	CHECK_N_DO(MOP, __mop_cpu, __target, READ, mem2, __size, ##__VA_ARGS__);\
-	ASSERT_MEM_EQ(mem1, mem2, __size);					\
-})
+static void default_read(struct test_info copy_cpu, struct test_info mop_cpu,
+			 enum mop_target mop_target, uint32_t size, uint8_t key)
+{
+	prepare_mem12();
+	CHECK_N_DO(MOP, mop_cpu, mop_target, WRITE, mem1, size, GADDR_V(mem1));
+	HOST_SYNC(copy_cpu, STAGE_COPIED);
+	CHECK_N_DO(MOP, mop_cpu, mop_target, READ, mem2, size,
+		   GADDR_V(mem2), KEY(key));
+	ASSERT_MEM_EQ(mem1, mem2, size);
+}
 
 static void guest_copy(void)
 {
@@ -310,7 +306,7 @@ static void test_copy(void)
 
 	HOST_SYNC(t.vcpu, STAGE_INITED);
 
-	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size);
+	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, NO_KEY);
 
 	kvm_vm_free(t.kvm_vm);
 }
@@ -357,26 +353,26 @@ static void test_copy_key(void)
 	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
 
 	/* vm, no key */
-	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size);
+	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, NO_KEY);
 
 	/* vm/vcpu, machting key or key 0 */
-	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(0));
-	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(9));
-	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size, KEY(0));
-	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size, KEY(9));
+	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 0);
+	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 9);
+	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, 0);
+	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, 9);
 	/*
 	 * There used to be different code paths for key handling depending on
 	 * if the region crossed a page boundary.
 	 * There currently are not, but the more tests the merrier.
 	 */
-	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, 1, KEY(0));
-	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, 1, KEY(9));
-	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, 1, KEY(0));
-	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, 1, KEY(9));
+	default_write_read(t.vcpu, t.vcpu, LOGICAL, 1, 0);
+	default_write_read(t.vcpu, t.vcpu, LOGICAL, 1, 9);
+	default_write_read(t.vcpu, t.vm, ABSOLUTE, 1, 0);
+	default_write_read(t.vcpu, t.vm, ABSOLUTE, 1, 9);
 
 	/* vm/vcpu, mismatching keys on read, but no fetch protection */
-	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(2));
-	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem1), KEY(2));
+	default_read(t.vcpu, t.vcpu, LOGICAL, t.size, 2);
+	default_read(t.vcpu, t.vm, ABSOLUTE, t.size, 2);
 
 	kvm_vm_free(t.kvm_vm);
 }
@@ -409,7 +405,7 @@ static void test_copy_key_storage_prot_override(void)
 	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
 
 	/* vcpu, mismatching keys, storage protection override in effect */
-	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(2));
+	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 2);
 
 	kvm_vm_free(t.kvm_vm);
 }
@@ -422,8 +418,8 @@ static void test_copy_key_fetch_prot(void)
 	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
 
 	/* vm/vcpu, matching key, fetch protection in effect */
-	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(9));
-	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem2), KEY(9));
+	default_read(t.vcpu, t.vcpu, LOGICAL, t.size, 9);
+	default_read(t.vcpu, t.vm, ABSOLUTE, t.size, 9);
 
 	kvm_vm_free(t.kvm_vm);
 }
-- 
2.34.1

