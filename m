Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B45E131B68
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2020 23:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgAFW3b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jan 2020 17:29:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFW3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jan 2020 17:29:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006MJCTw024329;
        Mon, 6 Jan 2020 22:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=FMTka2tq0Ww+f56DW10Z393U8mQlGGQbjP9PPcNcr+w=;
 b=E97vGWUdIy6QWXMK24CJbanWUE9oq7OhLBacd3Bhz6akGkpyH4FJ5cAHEtE1du8jVAcc
 ufRZ/C1Tb8xQ6hVXUckNnK4/UBGs3ZDWFdkR7qh08VX4WuuEkN0nSvaTfPUzFs0Xa0Gk
 h3yT/3R/yarrJ09vSOeKoB6XjAA1Rw7q9YV9DmZ11DMtHXrJKrvOoY1t07+YlnNOAwcJ
 ui9KdSbYnMMTW3nlOqXpZOW76jTDNODiTwAq3Yjv4JUfSlYTeRDvqDi4F2X41/SAfY7e
 rNY6fk0DhkFWMm21PxaZEQvJM5ij8YObdmh43Y9UUvm3O95R84ibtc+I0M1cnum8DUio Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xajnpsyh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 22:29:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006MJNjS182889;
        Mon, 6 Jan 2020 22:29:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xb467jd17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 22:29:08 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 006MT7H7028972;
        Mon, 6 Jan 2020 22:29:07 GMT
Received: from dhcp-10-175-162-40.vpn.oracle.com (/10.175.162.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 14:29:07 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     shuah@kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RESEND PATCH v7 linux-kselftest-test 5/6] kunit: allow kunit to be loaded as a module
Date:   Mon,  6 Jan 2020 22:28:22 +0000
Message-Id: <1578349703-15650-6-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578349703-15650-1-git-send-email-alan.maguire@oracle.com>
References: <1578349703-15650-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060185
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Making kunit itself buildable as a module allows for "always-on"
kunit configuration; specifying CONFIG_KUNIT=m means the module
is built but only used when loaded.  Kunit test modules will load
kunit.ko as an implicit dependency, so simply running
"modprobe my-kunit-tests" will load the tests along with the kunit
module and run them.

Co-developed-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/Kconfig  |  2 +-
 lib/kunit/Makefile |  4 +++-
 lib/kunit/test.c   | 13 +++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 9ebd5e6..065aa16 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig KUNIT
-	bool "KUnit - Enable support for unit tests"
+	tristate "KUnit - Enable support for unit tests"
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index bc6e5e54..fab5564 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,4 +1,6 @@
-obj-$(CONFIG_KUNIT) +=			test.o \
+obj-$(CONFIG_KUNIT) +=			kunit.o
+
+kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 87b5cf1..9242f93 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -486,3 +486,16 @@ void kunit_cleanup(struct kunit *test)
 	}
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
+
+static int __init kunit_init(void)
+{
+	return 0;
+}
+late_initcall(kunit_init);
+
+static void __exit kunit_exit(void)
+{
+}
+module_exit(kunit_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.1

