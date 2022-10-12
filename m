Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD725FCC8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJLU4c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 16:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJLU40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 16:56:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F49B89971;
        Wed, 12 Oct 2022 13:56:24 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKTGcQ000386;
        Wed, 12 Oct 2022 20:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YSZ+usY1ssTcxPrpTFJu8X9D9bf2bob5i6NaDofwJPg=;
 b=EfWEImbQb84OWcZkZ5Q7MQ2mZwOzrR/oWLg4Pn7s1FCwU8KJFNqVosw1AbqhhO9mNxDY
 tHRYeFDUqbT6y/83Jkf6JrRlXK5BkKkdIbQ/2KnyKTktOvjB+Uqvy4Zg1Pe+y3480kYJ
 D5voIEBiEWI8Rqq6k6LBrfHPSomEJOdMgeNFlGRsQbSzO9ky+Ii7adhTMb20M50jhGyG
 gWQFbnGr31ud7rvCjItldw578S3yMvJKbABGif0vjQq/aqhK/T5r/aLhZTeDLk01adn6
 0YdeBESfAJhSQ+rHcEP2fBFumIf7Bxzd8vnMtCMnwzKUnpWjduKXxwzOlxVK1CaWdAeV zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k64npgkk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:20 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CKUQAi008221;
        Wed, 12 Oct 2022 20:56:20 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k64npgkjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:19 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29CKrH1q020509;
        Wed, 12 Oct 2022 20:56:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3k30fj4xey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29CKuEM21311328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:56:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 289585204E;
        Wed, 12 Oct 2022 20:56:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AD1065204F;
        Wed, 12 Oct 2022 20:56:13 +0000 (GMT)
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
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 5/9] KVM: s390: selftest: memop: Replace macros by functions
Date:   Wed, 12 Oct 2022 22:56:05 +0200
Message-Id: <20221012205609.2811294-6-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012205609.2811294-1-scgl@linux.ibm.com>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zOXi6M_p1epjuZSiJT2tJ8NiwnbLqD4I
X-Proofpoint-ORIG-GUID: hu5vkm7br6RaD0R0uNZJGBsdNCiCPkpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the DEFAULT_* test helpers by functions, as they don't
need the exta flexibility.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 82 +++++++++++------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 69869c7e2ab1..286185a59238 100644
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

