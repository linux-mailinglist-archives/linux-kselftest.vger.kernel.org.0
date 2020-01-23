Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138FB147113
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAWSrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:47:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgAWSra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:47:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NINnI3120077;
        Thu, 23 Jan 2020 18:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=Qp7vLIF4+itHswU2F+ettpG5KHMtj1kxr7/UZnRz1cc=;
 b=CoItWY00Zn1CxIClVQ4vLU7iSfJUbplp87vOgqqjvhTJcsSdzkxgGIVsL5lGUceaskO9
 aKSISFa/+nnyd0wlP0m2N3j9XUkm1VF/X87v6bW9QFBBm+lTqQt4E2vxmPybNyJV77wC
 gkxHzNzteQh25R5dlDznEoKg2CjQH+mxAlRwlSqzipJeZqGBwwvhMORvrYs1uu8BQBUq
 3yyhZQhJm20/xMjR77fSm7WVg13pXRxrhvVJl31ml+EQtvTHsHv5p91DJfK27tZspdGi
 cHj1P+cidS8YGwRWG+ThpRc6XsDXgTwOP2lSMhkGbv0n1lW27sBLOI6afMCycdlZSy48 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xktnrm5jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 18:47:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NINbbW163465;
        Thu, 23 Jan 2020 18:47:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xpq0x4fjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 18:47:24 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00NIlOqb016319;
        Thu, 23 Jan 2020 18:47:24 GMT
Received: from dhcp-10-175-166-237.vpn.oracle.com (/10.175.166.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 10:47:23 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 kunit-next 3/3] kunit: update documentation to describe debugfs representation
Date:   Thu, 23 Jan 2020 18:47:01 +0000
Message-Id: <1579805221-31905-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
References: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230141
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Documentation should describe debugfs layout and semantics.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/dev-tools/kunit/usage.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 7cd56a1..b05c843 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -590,3 +590,22 @@ able to run one test case per invocation.
 
 .. TODO(brendanhiggins@google.com): Add an actual example of an architecture
    dependent KUnit test.
+
+KUnit debugfs representation
+============================
+When kunit test suites are initialized, they create an associated directory
+in /sys/kernel/debug/kunit/<test-suite>.  The directory contains two files
+
+- results: "cat results" displays results of last test run
+- run: "cat run" runs the test suite and displays the results
+
+Thus to re-run all currently loaded suites and display results, we can do this:
+
+```
+$ cat /sys/kernel/debug/kunit/*/run
+```
+
+The debugfs representation is primarily of use when kunit test suites are
+run in a native environment, either as modules or builtin.  Having a way
+to display results like this is valuable as otherwise results can be
+intermixed with other events in dmesg output.
-- 
1.8.3.1

