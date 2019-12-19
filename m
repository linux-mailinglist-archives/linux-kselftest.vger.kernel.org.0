Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240EC126697
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 17:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLSQTH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Dec 2019 11:19:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36798 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSQTH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Dec 2019 11:19:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGESuZ126871;
        Thu, 19 Dec 2019 16:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=FMTka2tq0Ww+f56DW10Z393U8mQlGGQbjP9PPcNcr+w=;
 b=mEXjeIfrH2maUOwfgqL+jL0Ow/iWIHIKMrS+3Do8UoTktYhtOqtqf84sIhG7Xjx2xZQu
 yaC61kZ5z+yT+0yRw3QISt3RLl5jgxBblU0N04uXQA5AFm17MEUPTZSCAoTorr/0E+Tr
 pLgdHnt4j1JjrPbTe/TxujpgOT38rwCNhpZhZmaRXX0juAeW3/MwDQ9zRB82RP0rSBkw
 uIWM2dfq/EMHMsbDpZu2/9tgUzOt6XBvFKao2GznaJ1/Fz93TBCfeC/AiBhziSNFhKrM
 +hdzgVSB7sUxV1z2Gig1mfGxp2oTGqCOhqGHx/fNOgJpuIQosxMCnxxHDvBIjnJ/kpDb JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2x01knkurt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEMr3136447;
        Thu, 19 Dec 2019 16:18:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wyut5jjex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:41 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJGIcrE019862;
        Thu, 19 Dec 2019 16:18:38 GMT
Received: from dhcp-10-175-212-35.vpn.oracle.com (/10.175.212.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 08:18:38 -0800
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
Subject: [PATCH v7 linux-kselftest-test 5/6] kunit: allow kunit to be loaded as a module
Date:   Thu, 19 Dec 2019 16:17:38 +0000
Message-Id: <1576772259-31382-6-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576772259-31382-1-git-send-email-alan.maguire@oracle.com>
References: <1576772259-31382-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
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

