Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6B4EF895
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348676AbiDAREw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 13:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348568AbiDAREv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 13:04:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E015D3AF;
        Fri,  1 Apr 2022 10:03:01 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231GnVqJ004982;
        Fri, 1 Apr 2022 17:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9VAWfenq1mhREH3i+JnXMVSGzVqfc+IrlSBvMyELv3w=;
 b=cmmFZqh8Ye7zlcqI+uKNoxnzOWUqL0e9C2XspmKeunvMnxQDlRg/VAtwFuUWRRIYVsLb
 uN1bWUfgMWuVY8H+6d6ssFZx1u3ezpfy0/omabv9qCI0awLH2S6gDd8FmLkmzzmBawix
 +PH45VSqAwkNju2o9HLhuBW6bwGmOHsl6Gls0mcGeL03Yh2adimMqopzVZUDcVo0dKVN
 6PWMU/bdqiQxHrKYTabBcu0QGWKH63xxcc0tIxbEcVNqfGFJcIXaelpesK4LLMtMdM3R
 iqFOxGQ8H6+uEzBF8Y7qCG+qHrfMwxfuzSBDC1+Ppi+0eNCm4+eKLaU7aSOb6GWxAZhO LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f632kbh9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:57 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 231GwbZX018559;
        Fri, 1 Apr 2022 17:02:57 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f632kbh89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:56 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 231GwjaU002821;
        Fri, 1 Apr 2022 17:02:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3f1t3j3ea3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 231H2pIu49480156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 17:02:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08AEB42041;
        Fri,  1 Apr 2022 17:02:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AA7942042;
        Fri,  1 Apr 2022 17:02:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Apr 2022 17:02:50 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/2] KVM: s390: selftest: Test suppression indication on key prot exception
Date:   Fri,  1 Apr 2022 19:02:47 +0200
Message-Id: <20220401170247.1287354-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401170247.1287354-1-scgl@linux.ibm.com>
References: <20220401170247.1287354-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eINMjY6oIqFiZbS5Gz3Q6Rq7pD20b0T3
X-Proofpoint-ORIG-GUID: -Hbk7NcmumST8qQHOu9E2lpx-RuwTh1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check that suppression is not indicated on injection of a key checked
protection exception caused by a memop after it already modified guest
memory, as that violates the definition of suppression.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 43 ++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index b04c2c1b3c30..93664fbf0fef 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -194,6 +194,7 @@ static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
 #define SIDA_OFFSET(o) ._sida_offset = 1, .sida_offset = (o)
 #define AR(a) ._ar = 1, .ar = (a)
 #define KEY(a) .f_key = 1, .key = (a)
+#define INJECT .f_inject = 1
 
 #define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
 
@@ -430,9 +431,18 @@ static void test_copy_key_fetch_prot(void)
 	TEST_ASSERT(rv == 4, "Should result in protection exception");		\
 })
 
+static void guest_error_key(void)
+{
+	GUEST_SYNC(STAGE_INITED);
+	set_storage_key_range(mem1, PAGE_SIZE, 0x18);
+	set_storage_key_range(mem1 + PAGE_SIZE, sizeof(mem1) - PAGE_SIZE, 0x98);
+	GUEST_SYNC(STAGE_SKEYS_SET);
+	GUEST_SYNC(STAGE_IDLED);
+}
+
 static void test_errors_key(void)
 {
-	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
+	struct test_default t = test_default_init(guest_error_key);
 
 	HOST_SYNC(t.vcpu, STAGE_INITED);
 	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
@@ -446,6 +456,36 @@ static void test_errors_key(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+static void test_termination(void)
+{
+	struct test_default t = test_default_init(guest_error_key);
+	uint64_t prefix;
+	uint64_t teid;
+	uint64_t psw[2];
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vcpu, mismatching keys after first page */
+	ERR_PROT_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), KEY(1), INJECT);
+	/*
+	 * The memop injected a program exception and the test needs to check the
+	 * Translation-Exception Identification (TEID). It is necessary to run
+	 * the guest in order to be able to read the TEID from guest memory.
+	 * Set the guest program new PSW, so the guest state is not clobbered.
+	 */
+	prefix = t.run->s.regs.prefix;
+	psw[0] = t.run->psw_mask;
+	psw[1] = t.run->psw_addr;
+	MOP(t.vm, ABSOLUTE, WRITE, psw, sizeof(psw), GADDR(prefix + 464));
+	HOST_SYNC(t.vcpu, STAGE_IDLED);
+	MOP(t.vm, ABSOLUTE, READ, &teid, sizeof(teid), GADDR(prefix + 168));
+	/* Bits 56, 60, 61 form a code, 0 being the only one allowing for termination */
+	ASSERT_EQ(teid & 0x4c, 0);
+
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void test_errors_key_storage_prot_override(void)
 {
 	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
@@ -668,6 +708,7 @@ int main(int argc, char *argv[])
 		test_copy_key_fetch_prot();
 		test_copy_key_fetch_prot_override();
 		test_errors_key();
+		test_termination();
 		test_errors_key_storage_prot_override();
 		test_errors_key_fetch_prot_override_not_enabled();
 		test_errors_key_fetch_prot_override_enabled();
-- 
2.32.0

