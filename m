Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3769F1266A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLSQTQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Dec 2019 11:19:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSQTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Dec 2019 11:19:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGETXG144130;
        Thu, 19 Dec 2019 16:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=UtF7imOhmPSAXDklZ55E8gWyotvBGV1fxPBlvWgNXg4=;
 b=BwMuhclqCDRk/5p5+uSr1dgeBFeUMHqNZJZEgt6NDMAFdZDSU9YvfQCndcso1xY/tvEM
 b1c7SGbeZOfqsicbnwWD7Mhw6ifyFuxI9pkmFeQ5W9tsexpv8GZjtkQ3a6jNAOGMO5uU
 plvrVCzA8ubGr5DLLEdYbNM/It4ScnW1zd/QVi/VfsUYdjf6HX2Rlmw1aEEKO7r4t6cC
 QpYWhoJx0im7XtIyQP1/NZ+bEeLQpeLf8t2q7JgWm+NQ/SWbX6e7m6yea7RelGf+b32f
 wNrUxJ3jwCS25iHM1iuQQWnm1JlZNHmfiER/F8t6hU/9C3++mKoEfKPfE5inq4n8F7Yn Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2x01jabu2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGENdo192678;
        Thu, 19 Dec 2019 16:18:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2x0bgm3770-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:46 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJGIir0019985;
        Thu, 19 Dec 2019 16:18:44 GMT
Received: from dhcp-10-175-212-35.vpn.oracle.com (/10.175.212.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 08:18:44 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-ext4@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v7 linux-kselftest-test 6/6] kunit: update documentation to describe module-based build
Date:   Thu, 19 Dec 2019 16:17:39 +0000
Message-Id: <1576772259-31382-7-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576772259-31382-1-git-send-email-alan.maguire@oracle.com>
References: <1576772259-31382-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Documentation should describe how to build kunit and tests as
modules.

Co-developed-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/faq.rst   |  3 ++-
 Documentation/dev-tools/kunit/index.rst |  3 +++
 Documentation/dev-tools/kunit/usage.rst | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index bf20951..ea55b24 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -29,7 +29,8 @@ Yes, well, mostly.
 
 For the most part, the KUnit core framework (what you use to write the tests)
 can compile to any architecture; it compiles like just another part of the
-kernel and runs when the kernel boots. However, there is some infrastructure,
+kernel and runs when the kernel boots, or when built as a module, when the
+module is loaded.  However, there is some infrastructure,
 like the KUnit Wrapper (``tools/testing/kunit/kunit.py``) that does not support
 other architectures.
 
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 26ffb46..7ddc385 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -48,6 +48,9 @@ to a standalone program that can be run like any other program directly inside
 of a host operating system; to be clear, it does not require any virtualization
 support; it is just a regular program.
 
+Alternatively, kunit and kunit tests can be built as modules and tests will
+run when the test module is loaded.
+
 KUnit is fast. Excluding build time, from invocation to completion KUnit can run
 several dozen tests in only 10 to 20 seconds; this might not sound like a big
 deal to some people, but having such fast and easy to run tests fundamentally
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c6e6963..82f9213 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -539,6 +539,22 @@ Interspersed in the kernel logs you might see the following:
 
 Congratulations, you just ran a KUnit test on the x86 architecture!
 
+In a similar manner, kunit and kunit tests can also be built as modules,
+so if you wanted to run tests in this way you might add the following config
+options to your ``.config``:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=m
+	CONFIG_KUNIT_EXAMPLE_TEST=m
+
+Once the kernel is built and installed, a simple
+
+.. code-block:: bash
+	modprobe example-test
+
+...will run the tests.
+
 Writing new tests for other architectures
 -----------------------------------------
 
-- 
1.8.3.1

