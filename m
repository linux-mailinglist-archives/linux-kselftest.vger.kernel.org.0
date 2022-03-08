Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392354D1878
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 13:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbiCHM7z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 07:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346925AbiCHM7z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 07:59:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538BB2C11B;
        Tue,  8 Mar 2022 04:58:55 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228CWCGY031155;
        Tue, 8 Mar 2022 12:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZYgl6Z7QRHHN16SOIA6mwvzcDKQialozPe3MqItHNMo=;
 b=mnyi0BMY2dmriqMeX1Kp6NtBqqbdVJwlHa1PqDhHV3GGQkLvrlBM7G9jU2vuGvzz/cSC
 3NNlaqhVGAtps13BVcHSFE67cL2H12iMDEfQsb+TiSFib+CE7VEsrjGEUuWWch4fWBR4
 65i6Z1e+Lyh5Ws6NfW/0nCEFHTnZlUknpcKxGbpb06IxWCggfoikvCNG7SuUZwDa8aZC
 pdnbwYAmaHrujP6KRdG3pZZEbmR8OdAyAwjQrGOmGIPAxePBNwNaiDM/h6aikke+Um63
 b6WzYz94/bnk+i2KOd1W4x/YIfDGdTFoiOSmQXcCYbOtHm/mSVJmxThdTsb9f7TX5i5i Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep0bd0upg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:52 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228CjwMp010645;
        Tue, 8 Mar 2022 12:58:51 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep0bd0up4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:51 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228CrXLx004295;
        Tue, 8 Mar 2022 12:58:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3ekyg96dk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228Cwkeb50200980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 12:58:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B9EA11C054;
        Tue,  8 Mar 2022 12:58:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 072CA11C058;
        Tue,  8 Mar 2022 12:58:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 12:58:45 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] KVM: s390: selftests: Add named stages for memop test
Date:   Tue,  8 Mar 2022 13:58:39 +0100
Message-Id: <20220308125841.3271721-4-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308125841.3271721-1-scgl@linux.ibm.com>
References: <20220308125841.3271721-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NyRIC5Op45rEtdUJ-7P656XZUHW71K5e
X-Proofpoint-ORIG-GUID: FfeAsujkrZmkrDsJCGb2zXyS8grkS7Y5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The stages synchronize guest and host execution.
This helps the reader and constraits the execution of the test -- if the
observed staging differs from the expected the test fails.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 44 +++++++++++++++++------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index e2ad3d70bae4..88ce2d670ed5 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -218,10 +218,32 @@ static struct test_default test_default_init(void *guest_code)
 	return t;
 }
 
+enum stage {
+	/* Synced state set by host, e.g. DAT */
+	STAGE_INITED,
+	/* Guest did nothing */
+	STAGE_IDLED,
+	/* Guest copied memory (locations up to test case) */
+	STAGE_COPIED,
+};
+
+#define HOST_SYNC(vcpu_p, stage)					\
+({									\
+	struct test_vcpu __vcpu = (vcpu_p);				\
+	struct ucall uc;						\
+	int __stage = (stage);						\
+									\
+	vcpu_run(__vcpu.vm, __vcpu.id);					\
+	get_ucall(__vcpu.vm, __vcpu.id, &uc);				\
+	ASSERT_EQ(uc.cmd, UCALL_SYNC);					\
+	ASSERT_EQ(uc.args[1], __stage);					\
+})									\
+
 static void guest_copy(void)
 {
+	GUEST_SYNC(STAGE_INITED);
 	memcpy(&mem2, &mem1, sizeof(mem2));
-	GUEST_SYNC(0);
+	GUEST_SYNC(STAGE_COPIED);
 }
 
 static void test_copy(void)
@@ -232,16 +254,13 @@ static void test_copy(void)
 	for (i = 0; i < sizeof(mem1); i++)
 		mem1[i] = i * i + i;
 
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
 	/* Set the first array */
-	MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size,
-	    GADDR(addr_gva2gpa(t.kvm_vm, (uintptr_t)mem1)));
+	MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1));
 
 	/* Let the guest code copy the first array to the second */
-	vcpu_run(t.kvm_vm, VCPU_ID);
-	TEST_ASSERT(t.run->exit_reason == KVM_EXIT_S390_SIEIC,
-		    "Unexpected exit reason: %u (%s)\n",
-		    t.run->exit_reason,
-		    exit_reason_str(t.run->exit_reason));
+	HOST_SYNC(t.vcpu, STAGE_COPIED);
 
 	memset(mem2, 0xaa, sizeof(mem2));
 
@@ -256,8 +275,9 @@ static void test_copy(void)
 
 static void guest_idle(void)
 {
+	GUEST_SYNC(STAGE_INITED); /* for consistency's sake */
 	for (;;)
-		GUEST_SYNC(0);
+		GUEST_SYNC(STAGE_IDLED);
 }
 
 static void test_errors(void)
@@ -265,6 +285,8 @@ static void test_errors(void)
 	struct test_default t = test_default_init(guest_idle);
 	int rv;
 
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
 	/* Bad size: */
 	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, -1, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
@@ -294,11 +316,11 @@ static void test_errors(void)
 	/* Bad access register: */
 	t.run->psw_mask &= ~(3UL << (63 - 17));
 	t.run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
-	vcpu_run(t.kvm_vm, VCPU_ID);              /* To sync new state to SIE block */
+	HOST_SYNC(t.vcpu, STAGE_IDLED); /* To sync new state to SIE block */
 	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), AR(17));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
 	t.run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
-	vcpu_run(t.kvm_vm, VCPU_ID);                  /* Run to sync new state */
+	HOST_SYNC(t.vcpu, STAGE_IDLED); /* Run to sync new state */
 
 	/* Check that the SIDA calls are rejected for non-protected guests */
 	rv = ERR_MOP(t.vcpu, SIDA, READ, mem1, 8, GADDR(0), SIDA_OFFSET(0x1c0));
-- 
2.32.0

