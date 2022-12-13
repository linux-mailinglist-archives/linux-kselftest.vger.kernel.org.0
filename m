Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B664BA5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 17:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiLMQyj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 11:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiLMQy0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 11:54:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF5122503;
        Tue, 13 Dec 2022 08:54:25 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDGVLcg006987;
        Tue, 13 Dec 2022 16:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q9k6ezg/chy8ovtUFjyYTtJqZG/jjPjBRCG9jVcOZNs=;
 b=qCNlviOc1JymHh0NuvCxx18nYbU1MjQjN2TP3uI0xx/EHLSjS68AYUQDv0PXfHZfhMYd
 kiIVCP1iQzCX3KZnn0BebilYUD58ItsmkFRCSaxRinGSiZroNlPjD6fJL53RPj78gQxI
 vG7DyatpZr9L3EJowmuM+DDKFT632MWvZbFtMVwcF6ARgxAxoljx/v71fsT3u9QIUwA8
 mYG22hpYAYseBJYMzXFC7Tg2SqePU+r0F4fooV/BmoLCT9Nht459nQ4Q5JUhdcft4BH4
 ZLxRr0V0Bn9Gaur4ll4HEbjfvaxwKHbVOIfjUDDEAs+PIQVmXFbL9REjV5OFFYpT6wE5 cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mew04rnx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 16:54:20 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BDGVIES006796;
        Tue, 13 Dec 2022 16:54:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mew04rnw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 16:54:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD5UJ0t007832;
        Tue, 13 Dec 2022 16:54:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mchcf4g4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 16:54:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDGsEP65570876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 16:54:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 326C120043;
        Tue, 13 Dec 2022 16:54:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB84E20049;
        Tue, 13 Dec 2022 16:54:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 16:54:13 +0000 (GMT)
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
Subject: [PATCH v4 5/9] KVM: s390: selftest: memop: Move testlist into main
Date:   Tue, 13 Dec 2022 17:54:01 +0100
Message-Id: <20221213165405.2953539-6-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213165405.2953539-1-scgl@linux.ibm.com>
References: <20221213165405.2953539-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q9NxffpAsDA83DB3eerLsxVjjkOhm9bd
X-Proofpoint-ORIG-GUID: LTPJPW1ctFDTL8FRBhopORgZ-qAbkQmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows checking if the necessary requirements for a test case are
met via an arbitrary expression. In particular, it is easy to check if
certain bits are set in the memop extension capability.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 132 +++++++++++-----------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 286185a59238..10f34c629cac 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -690,87 +690,87 @@ static void test_errors(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
-struct testdef {
-	const char *name;
-	void (*test)(void);
-	int extension;
-} testlist[] = {
-	{
-		.name = "simple copy",
-		.test = test_copy,
-	},
-	{
-		.name = "generic error checks",
-		.test = test_errors,
-	},
-	{
-		.name = "copy with storage keys",
-		.test = test_copy_key,
-		.extension = 1,
-	},
-	{
-		.name = "copy with key storage protection override",
-		.test = test_copy_key_storage_prot_override,
-		.extension = 1,
-	},
-	{
-		.name = "copy with key fetch protection",
-		.test = test_copy_key_fetch_prot,
-		.extension = 1,
-	},
-	{
-		.name = "copy with key fetch protection override",
-		.test = test_copy_key_fetch_prot_override,
-		.extension = 1,
-	},
-	{
-		.name = "error checks with key",
-		.test = test_errors_key,
-		.extension = 1,
-	},
-	{
-		.name = "termination",
-		.test = test_termination,
-		.extension = 1,
-	},
-	{
-		.name = "error checks with key storage protection override",
-		.test = test_errors_key_storage_prot_override,
-		.extension = 1,
-	},
-	{
-		.name = "error checks without key fetch prot override",
-		.test = test_errors_key_fetch_prot_override_not_enabled,
-		.extension = 1,
-	},
-	{
-		.name = "error checks with key fetch prot override",
-		.test = test_errors_key_fetch_prot_override_enabled,
-		.extension = 1,
-	},
-};
 
 int main(int argc, char *argv[])
 {
 	int extension_cap, idx;
 
+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_MEM_OP));
+	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
 
-	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
+	struct testdef {
+		const char *name;
+		void (*test)(void);
+		bool requirements_met;
+	} testlist[] = {
+		{
+			.name = "simple copy",
+			.test = test_copy,
+			.requirements_met = true,
+		},
+		{
+			.name = "generic error checks",
+			.test = test_errors,
+			.requirements_met = true,
+		},
+		{
+			.name = "copy with storage keys",
+			.test = test_copy_key,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "copy with key storage protection override",
+			.test = test_copy_key_storage_prot_override,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "copy with key fetch protection",
+			.test = test_copy_key_fetch_prot,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "copy with key fetch protection override",
+			.test = test_copy_key_fetch_prot_override,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks with key",
+			.test = test_errors_key,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "termination",
+			.test = test_termination,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks with key storage protection override",
+			.test = test_errors_key_storage_prot_override,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks without key fetch prot override",
+			.test = test_errors_key_fetch_prot_override_not_enabled,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks with key fetch prot override",
+			.test = test_errors_key_fetch_prot_override_enabled,
+			.requirements_met = extension_cap > 0,
+		},
+	};
 
 	ksft_print_header();
-
 	ksft_set_plan(ARRAY_SIZE(testlist));
 
-	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
 	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
-		if (extension_cap >= testlist[idx].extension) {
+		if (testlist[idx].requirements_met) {
 			testlist[idx].test();
 			ksft_test_result_pass("%s\n", testlist[idx].name);
 		} else {
-			ksft_test_result_skip("%s - extension level %d not supported\n",
-					      testlist[idx].name,
-					      testlist[idx].extension);
+			ksft_test_result_skip("%s - requirements not met (kernel has extension cap %#x\n)",
+					      testlist[idx].name, extension_cap);
 		}
 	}
 
-- 
2.34.1

