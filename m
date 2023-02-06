Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9C68C390
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBFQqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBFQqR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:46:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9E25E2A;
        Mon,  6 Feb 2023 08:46:16 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316GiX3Y011204;
        Mon, 6 Feb 2023 16:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6ZKGTGisiG1NUcLFCh1Mfp6s/BU1778FXmqAZc03Oco=;
 b=IrBnjAHvCsakX9yGJiMIr/GwOkEgkfKx1r4rJUXpD+/L8Dwv3hgOTSZCIDqask+4rAm/
 Clml5yKP7tIbyMCol2aLppHsbZ7BrVCKPDEDeRyLnrAWF5lCGn1xZ9eB3Q7EjjEzryCG
 5AtC/cXiKwhWnKgeWMT68NvSW+SD28OIx7hjdAt+T06DcyJUoYr+MD1NrAzbNd3EVDmZ
 CphgOxR1Vugs+3O+ui7Twunu6RTgaALe6AIyFJd1ahutVEFnzVagmpbo7WXZILowz6yN
 YevJYP/QiORiyQolRJPIdkQieSIGZZenBCufXHkocmzYeCpp/opmhNIfe7Sac995eD+C vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk51mgp6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:12 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316GiWBq011125;
        Mon, 6 Feb 2023 16:46:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk51mgp5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3160HbkX023711;
        Mon, 6 Feb 2023 16:46:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06tmsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316Gk5i952560284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52BF020040;
        Mon,  6 Feb 2023 16:46:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D563F20043;
        Mon,  6 Feb 2023 16:46:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 16:46:04 +0000 (GMT)
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
Subject: [PATCH v7 02/14] KVM: s390: selftest: memop: Replace macros by functions
Date:   Mon,  6 Feb 2023 17:45:50 +0100
Message-Id: <20230206164602.138068-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206164602.138068-1-scgl@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _NwVI0_C46PXwMces2IpmRDTmyO7LbHB
X-Proofpoint-ORIG-GUID: pOILngav9fNyYGZC5wGg8ge7lqYTV09B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the DEFAULT_* test helpers by functions, as they don't
need the extra flexibility.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
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
2.37.2

