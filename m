Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3481614AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2020 15:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgBQO2k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Feb 2020 09:28:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58342 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgBQO2k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Feb 2020 09:28:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HEN6Qa058298;
        Mon, 17 Feb 2020 14:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=rvjBuDyfVNBls+ThGPIURngXyhQh6dEGJ4EnlquIlCU=;
 b=VtShXl5aDN7qEyrgXOGhw2cylyYTYOIxVU4JIBFSzmwdyJ6439ik3xVH9d8X5kYHzyRL
 KxoKpUnX0tdkiBBtooAOAAwTMHZJBOHCiAFyO0e6U1NRb2g6tcakEpDFm4K1rGAqwfQO
 FNAAkxZ+OediCIvOOgZ2fnB4F+KFdPrIVn+/FthC+CNPTigkoNIQPoIgqu4kt4SvSJcZ
 39x4hboOkA11fnVUrtcgyS084t/NMnSzhizGsxj42Dl6pB6rYLf1WmBO7Qf3Y9ccA+0O
 eoLyR3Iy2t/Oe5GHcQgynmwDiz+Fajte3F0mb1/Dws1p/WSj55vBMv9+S7y1ub6tAXiS BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y68kqrhkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:28:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HESAk1069756;
        Mon, 17 Feb 2020 14:28:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y6t6tsvp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:28:35 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01HESWe4008304;
        Mon, 17 Feb 2020 14:28:32 GMT
Received: from dhcp-10-175-161-198.vpn.oracle.com (/10.175.161.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 06:28:31 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 kunit-next 2/3] kunit: add log test
Date:   Mon, 17 Feb 2020 14:27:39 +0000
Message-Id: <1581949660-20113-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581949660-20113-1-git-send-email-alan.maguire@oracle.com>
References: <1581949660-20113-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=3 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=3 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170119
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

the logging test ensures multiple strings logged appear in the
log string associated with the test when CONFIG_KUNIT_DEBUGFS is
enabled.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/kunit/kunit-test.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index aceb5bf..0789060 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -329,6 +329,31 @@ static void kunit_resource_test_exit(struct kunit *test)
 	.exit = kunit_resource_test_exit,
 	.test_cases = kunit_resource_test_cases,
 };
-kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite);
+
+static void kunit_log_test(struct kunit *test)
+{
+	kunit_log(KERN_INFO, test, "put this in log.");
+	kunit_log(KERN_INFO, test, "this too.");
+
+#ifdef CONFIG_KUNIT_DEBUGFS
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(test->log, "put this in log."));
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+				     strstr(test->log, "this too."));
+#endif
+}
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
+kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
+		  &kunit_log_test_suite);
 
 MODULE_LICENSE("GPL v2");
-- 
1.8.3.1

