Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8467BE76
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjAYV0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjAYV0b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:26:31 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1974645F77;
        Wed, 25 Jan 2023 13:26:30 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLccc031857;
        Wed, 25 Jan 2023 21:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OoOmQi9nf/ZBs15rZtxyQ2kOQX+7SKcY74nT2D1EOo0=;
 b=Ag1bWLgEIukISYkcbneNVv5lS1irTAQ1frpDK0xZdKX08uAvvOJ/TU4mzFYYicYYAnU9
 rOVzSSlF4IuBRMdstQfTXmNl76sHN8uq5cfq0NJuHPncx6J+39AFWiYOi82SyAFPe5Cb
 yrBqGGzX5db5MACVYE19XLd1+5ci4dHDMmgJGfYPfMXms4dVvtVBqXnky+/Z2kzidMbl
 /+CMY23UMYMtdFVf8x8GK0e/3RgieV8TyFIxv7gN2u+oPCo9MeBsnMHIZRbheC8pVO4d
 K39r5KFSQnPGHbE6Bdd2NVemo27Vie43o0Yzv7rTXPTYxH4Xzc/QX8JkmTwkly52Mf4u gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vd40jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:24 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PKd9IA005991;
        Wed, 25 Jan 2023 21:26:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vd40hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PHPu7t010402;
        Wed, 25 Jan 2023 21:26:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6nkn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLQHIt26018534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:26:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A460C20040;
        Wed, 25 Jan 2023 21:26:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BE4320043;
        Wed, 25 Jan 2023 21:26:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:26:17 +0000 (GMT)
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
Subject: [PATCH v6 03/14] KVM: s390: selftest: memop: Move testlist into main
Date:   Wed, 25 Jan 2023 22:25:57 +0100
Message-Id: <20230125212608.1860251-4-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125212608.1860251-1-scgl@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gRRpk_wwThv3nZjyEI2x8lS3Zf3B7iP-
X-Proofpoint-ORIG-GUID: ZdWxZukjGH1UL9spU0TNNbrZ3WsanfSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250187
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
 tools/testing/selftests/kvm/s390x/memop.c | 131 +++++++++++-----------
 1 file changed, 66 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index df1c726294b2..bbc191a13760 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -690,85 +690,86 @@ static void test_errors(void)
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
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_MEM_OP));
+	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
 
-	ksft_print_header();
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
 
+	ksft_print_header();
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
+			ksft_test_result_skip("%s - requirements not met (kernel has extension cap %#x)\n",
+					      testlist[idx].name, extension_cap);
 		}
 	}
 
-- 
2.34.1

