Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08286DB595
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438238AbfJQSJf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 14:09:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46502 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395292AbfJQSJf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 14:09:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI4AdW147084;
        Thu, 17 Oct 2019 18:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=/8CLOJ2pMliNyB2yJzLsx8/lcr53M3C2bB3rrY57eoo=;
 b=KdagHJpyvyhx599KlPuq2xRqro59GE4MfcxdBTnht334R9kXUT5zxMYRgmOL0qesnvKD
 dhXJNY/CANLBPVmiQ7YDIVNbHc6/UZLVE9Px0aAOjeATT9F5tvJP1k7L0zmFWy3/Azkt
 AvMzwmny8NSsOo1OjfjbXzAD5gO63R8HQnKgGXlI4c7ApugHPoUtgh4lEktq2sqxo9bX
 COsXB1dNk2gCDjpv4wX+IXz4dAxehnUBQ2hCnCO1TWKTrp0IV9kSxZBudYkhBRXWoXq9
 sd6WsVPGmlOVZs0KpcpqBcWKjbqGJRAigDqSfIBYIkgFFvFpdWIBIW8m111dJHV6oyyI aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vk7frqxxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:08:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI8KKA176273;
        Thu, 17 Oct 2019 18:08:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vpvtm1nwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:08:24 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9HI83Nq020236;
        Thu, 17 Oct 2019 18:08:03 GMT
Received: from dhcp-10-175-161-223.vpn.oracle.com (/10.175.161.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:08:02 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v3 linux-kselftest-test 5/6] kunit: allow kunit to be loaded as a module
Date:   Thu, 17 Oct 2019 19:07:18 +0100
Message-Id: <1571335639-21675-6-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170163
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

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 lib/kunit/Kconfig     | 2 +-
 lib/kunit/Makefile    | 4 +++-
 lib/kunit/test.c      | 2 ++
 lib/kunit/try-catch.c | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

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
index 769d940..8e2635a 100644
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
index e8b2443..c0ace36 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -523,3 +523,5 @@ void *kunit_find_symbol(const char *sym)
 	return ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL(kunit_find_symbol);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 1c1e9af..72fc8ed 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -31,6 +31,8 @@ static int kunit_generic_run_threadfn_adapter(void *data)
 	complete_and_exit(try_catch->try_completion, 0);
 }
 
+KUNIT_VAR_SYMBOL(sysctl_hung_task_timeout_secs, unsigned long);
+
 static unsigned long kunit_test_timeout(void)
 {
 	unsigned long timeout_msecs;
@@ -52,6 +54,7 @@ static unsigned long kunit_test_timeout(void)
 	 * For more background on this topic, see:
 	 * https://mike-bland.com/2011/11/01/small-medium-large.html
 	 */
+	KUNIT_INIT_VAR_SYMBOL(NULL, sysctl_hung_task_timeout_secs);
 	if (sysctl_hung_task_timeout_secs) {
 		/*
 		 * If sysctl_hung_task is active, just set the timeout to some
-- 
1.8.3.1

