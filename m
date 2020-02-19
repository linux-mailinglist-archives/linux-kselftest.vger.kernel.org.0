Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35D41649CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgBSQSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 11:18:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60278 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBSQR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 11:17:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGE34L020290;
        Wed, 19 Feb 2020 16:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=BabazQ5yP//ASrPjsFgmGIuh28CWLBs/R03HwSSNcmU=;
 b=RxIsPImK5cTvv3+Ld5Cjc8mJHvCjyKkH9PZJGO67oCu5v6M0nLHAGN4N94cDPT+PA9kH
 MXsuaGi2jl9+5mTl2RC8focBsaSdkxdxDk9CLGt1OlC6wv9l5E4PV5xdKna4Fh5CZzXw
 H2d/NHNFZaJWliQpQcpp8j4U/VAYHS0r5n40OrInOPi2I5lWBPH9ql1WzB/pRFjx9wYq
 e624qs8aospfhv5cYTDsVxp7Dym5OMgYxDhwjkbFZd23QJxMhSyl7sSOBTakyJI0crum
 JK/U4gF2ICMsG7Cq/wPwZBLIB2w/Pe1183w3/AZ5o6Riqvz4dLciIrw/A09kb976f8mZ 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y8ud146kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:17:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGHmja004901;
        Wed, 19 Feb 2020 16:17:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y8ud665ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:17:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JGHge2009501;
        Wed, 19 Feb 2020 16:17:43 GMT
Received: from dhcp-10-175-189-86.vpn.oracle.com (/10.175.189.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 08:17:42 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 kunit-next 2/4] kunit: add log test
Date:   Wed, 19 Feb 2020 16:17:08 +0000
Message-Id: <1582129030-22282-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582129030-22282-1-git-send-email-alan.maguire@oracle.com>
References: <1582129030-22282-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=3 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=3 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190122
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

