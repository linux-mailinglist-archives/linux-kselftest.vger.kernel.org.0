Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34980194190
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 15:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgCZOcY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 10:32:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51178 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZOcY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 10:32:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QET77b005362;
        Thu, 26 Mar 2020 14:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=FAXjI9acl3BvhqBVLHwTP8ZVKrXH638AdGx3om6kJNQ=;
 b=t9E6Huvstyz8STIUPEnc9UwPHsnn4KcIAfs9xFb/XSxy5CTk1RWl/Mg7Q+rQ3PY8lkBy
 HIwyE2P7psHnwTy2TAZiXNEJOaaMvW5ryn8/ViLoeT2PawEl2QCjoilfXbWhhYYPUyQ6
 XETCBpu0l4IpmJ+EsoWMb3FPqzkfB048oFFKNUH8Kuknhlwbh6wKU72G/2guoRS0hUZ7
 mAnSnYRY1sQp3ILeVMBc6rQkGCLVLBi6gNlRAViuAkHZzROinEXyGQwXswASFZBBFuvG
 SF06/2+mV83/+uYZn+iZcIUy067Hpe5gjcA7oHiohoaJgHR/GxlbAE8BBLFiv1c4bfHr iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavmg4es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:32:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QEQbsw162134;
        Thu, 26 Mar 2020 14:32:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30073dk1av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:32:15 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QEWEUQ012449;
        Thu, 26 Mar 2020 14:32:14 GMT
Received: from localhost.uk.oracle.com (/10.175.198.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 07:32:13 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org
Subject: [PATCH v8 kunit-next 4/4] kunit: update documentation to describe debugfs representation
Date:   Thu, 26 Mar 2020 14:25:10 +0000
Message-Id: <1585232710-322-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585232710-322-1-git-send-email-alan.maguire@oracle.com>
References: <1585232710-322-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260112
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Documentation should describe debugfs layout and semantics.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/dev-tools/kunit/usage.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 607758a..473a236 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -591,3 +591,17 @@ able to run one test case per invocation.
 
 .. TODO(brendanhiggins@google.com): Add an actual example of an architecture
    dependent KUnit test.
+
+KUnit debugfs representation
+============================
+When kunit test suites are initialized, they create an associated directory
+in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
+
+- results: "cat results" displays results of each test case and the results
+  of the entire suite for the last test run.
+
+The debugfs representation is primarily of use when kunit test suites are
+run in a native environment, either as modules or builtin.  Having a way
+to display results like this is valuable as otherwise results can be
+intermixed with other events in dmesg output.  The maximum size of each
+results file is KUNIT_LOG_SIZE bytes (defined in include/kunit/test.h).
-- 
1.8.3.1

