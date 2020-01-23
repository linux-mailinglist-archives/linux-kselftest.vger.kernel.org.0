Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1F146BAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAWOrx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 09:47:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33116 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgAWOrs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 09:47:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NERiCK095224;
        Thu, 23 Jan 2020 14:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=e9LPuLPpovv+Q98nj95t1aZnDoW6xo0plszUK4bYMs4=;
 b=WaYfx3zUb9D/oUA1kcnLqNlhq0rM8RqglnIbm5g2m7ZLFatt1YR1M2vciDbrQE4gZmBL
 xiX7StzRlYhQSoIkaUhycVSnsvNTF7fAnUlRY7eQcYBflSvpdFmPTPTA9PbBFihP+v0K
 vdRCNa2g2H2dpDolKcBrEWCX07pOskk4uzz8+4ICQ+G7zL7VLSO39Rcuop2kYz5qoK4w
 7UZPYgN2yc78A47V5/6ZynTSvHe4QKOVLAPBW8iB8VgjxSi9C/SwZ3qtGkK1WeBjJGQA
 R2y0Tu4LN/5hk5Rj5VLa/EdoVRPakqb1s2aZABDo9ydmLyb0XG65a1eEzZvVSFLOkOSF GA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xktnrjhnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 14:47:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NETGju113719;
        Thu, 23 Jan 2020 14:47:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xpt6pf628-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 14:47:43 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00NElfYJ030974;
        Thu, 23 Jan 2020 14:47:41 GMT
Received: from dhcp-10-175-173-105.vpn.oracle.com (/10.175.173.105)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 06:47:41 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH kunit 3/3] kunit: update documentation to describe debugfs representation
Date:   Thu, 23 Jan 2020 14:47:20 +0000
Message-Id: <1579790840-27009-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579790840-27009-1-git-send-email-alan.maguire@oracle.com>
References: <1579790840-27009-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230124
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Documentation should describe debugfs layout and semantics.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/dev-tools/kunit/usage.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 7cd56a1..b1ebf9f 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -590,3 +590,23 @@ able to run one test case per invocation.
 
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
+
-- 
1.8.3.1

