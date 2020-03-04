Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E7F178F58
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 12:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgCDLIK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 06:08:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34212 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbgCDLIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 06:08:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024B46vf167257;
        Wed, 4 Mar 2020 11:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=BabazQ5yP//ASrPjsFgmGIuh28CWLBs/R03HwSSNcmU=;
 b=bz7/VMDYrY9wwas4kpdEkI6DP0kdmz6zQjg+3JR6W3Y92NutFSpqLWKdwwK78y26TUMI
 1URPnmKOUJ4Zne2gldyjkOH9pJ36t2KYrb6gglj0edjEXehtjslqIaXqs4d+3JKYaA9S
 vn28djzQApY5VX8VydTjsHMdrwo9vBvlSBf93+89nWwnNsrxEXh3YRXTYd6QR983W/aK
 rAviWa6EkNR7f9eDQ5eNlJwn+ZjPuW8PbJM9KDrCCPJBuNdH7w/KJz7l51johhyemNHq
 Ua+yFimiQ0BCxb1PxAI0YKgD5p0BrWIw/MSrG4NCsRn+axdwLrekZAEYKadXc0vuKh4x bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yffwqwm7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 11:07:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024B3TYt027639;
        Wed, 4 Mar 2020 11:07:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yg1h0nbv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 11:07:52 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024B7pDv012708;
        Wed, 4 Mar 2020 11:07:51 GMT
Received: from dhcp-10-175-165-222.vpn.oracle.com (/10.175.165.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 03:07:50 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 kunit-next 2/4] kunit: add log test
Date:   Wed,  4 Mar 2020 11:07:14 +0000
Message-Id: <1583320036-442-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583320036-442-1-git-send-email-alan.maguire@oracle.com>
References: <1583320036-442-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=3 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=3
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040086
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

the logging test ensures multiple strings logged appear in the
log string associated with the test when CONFIG_KUNIT_DEBUGFS is
enabled.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
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

