Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794821849D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 15:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCMOrM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 10:47:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50642 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCMOrM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 10:47:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEdgkl099079;
        Fri, 13 Mar 2020 14:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Bv9nOnLm2ONHio6hokKq2BdqwaVrr/CkDV2+/x9JvxA=;
 b=PFkkDu3qTKUEeDTnwfPo+Wk7XCGQ+a1dd2iI1gArobIOFrszD47a6xQmgfKIeQl6sd4A
 q9uZrb+ukfaN2cB48KFIc1AwB7sXSx4LscJN3577/1LB69vvbrmTczHJ2lay0rMOvOOK
 +CZkqARm7N4GsEuwMcE3VsVJtYE1wNnLpNeTl27qkz1Tc9VdiEumSVQDP69YmOTyRpkN
 4rYvfCJn+N0WVcRXUmyZQ9LkAYjAdeGlhuiUJ+LrV9RBFX9YcDGWINHu8htGAf8wK/DR
 n7R8vELlbpEfXf0kdBEO4+kkFFzYTYJi5pqLXYEBqLumolUw7hF+kia+bJKjsDVdG4Oo ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yqtavm741-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 14:47:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEcH6C010936;
        Fri, 13 Mar 2020 14:45:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yqtact4nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 14:45:04 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DEj2mi002895;
        Fri, 13 Mar 2020 14:45:02 GMT
Received: from dhcp-10-175-173-225.vpn.oracle.com (/10.175.173.225)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Mar 2020 07:45:02 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 kunit-next 2/4] kunit: add log test
Date:   Fri, 13 Mar 2020 14:44:40 +0000
Message-Id: <1584110682-3837-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
References: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=3
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130077
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

the logging test ensures multiple strings logged appear in the
log string associated with the test when CONFIG_KUNIT_DEBUGFS is
enabled.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
---
 lib/kunit/kunit-test.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index aceb5bf..359bc26 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -329,6 +329,45 @@ static void kunit_resource_test_exit(struct kunit *test)
 	.exit = kunit_resource_test_exit,
 	.test_cases = kunit_resource_test_cases,
 };
-kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite);
+
+static void kunit_log_test(struct kunit *test);
+
+static struct kunit_case kunit_log_test_cases[] = {
+	KUNIT_CASE(kunit_log_test),
+	{}
+};
+
+static struct kunit_suite kunit_log_test_suite = {
+	.name = "kunit-log-test",
+	.test_cases = kunit_log_test_cases,
+};
+
+
+static void kunit_log_test(struct kunit *test)
+{
+	struct kunit_suite *suite = &kunit_log_test_suite;
+
+	kunit_log(KERN_INFO, test, "put this in log.");
+	kunit_log(KERN_INFO, test, "this too.");
+	kunit_log(KERN_INFO, suite, "add to suite log.");
+	kunit_log(KERN_INFO, suite, "along with this.");
+
+#ifdef CONFIG_KUNIT_DEBUGFS
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(test->log, "put this in log."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(test->log, "this too."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(suite->log, "add to suite log."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(suite->log, "along with this."));
+#else
+	KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, suite->log, (char *)NULL);
+#endif
+}
+
+kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
+		  &kunit_log_test_suite);
 
 MODULE_LICENSE("GPL v2");
-- 
1.8.3.1

