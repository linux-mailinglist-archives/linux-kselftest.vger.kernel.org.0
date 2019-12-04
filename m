Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA343112E54
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfLDP2M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 10:28:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35456 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfLDP2L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 10:28:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FOJ5Z121548;
        Wed, 4 Dec 2019 15:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=AN47JONeK8oCX+YPtCKA7vbhhvfwmEGZgeS7UlEbne0=;
 b=jhlZU+2Rzbv6gVANMI57IXf4244XikpH3LuIp0X0SonT0d1oWbooii/I/o40Vc417Vkm
 JXnLIm8pTR2vkCTK0/YGs2RkZ9AT47NhF9QLRaIiycld3boG2vIUSOK7WG2KGBWj697F
 cfBINSL1CSr5qFdSYb+vlUfZO8JozZlscwcZeuOJwVwdwMD8aQNIIl+nANbYSaLZiw9J
 qH/wOseYpTNM3ZceqU0TrZpTbiEf1qbrx+R+AEtGFAqNlePYWdjGoiGAFTz+t+W8sOGJ
 2Xv/lT4fpuEC27mEEcxqLdmbyfl5UnqL3NojSts8/VGvgBgaTuzKZzloiXwGD750KS8G 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wkfuufa02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:27:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FOGXE011427;
        Wed, 4 Dec 2019 15:27:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wp17e470u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:27:51 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB4FRnmC001349;
        Wed, 4 Dec 2019 15:27:49 GMT
Received: from dhcp-10-175-179-22.vpn.oracle.com (/10.175.179.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 07:27:49 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
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
Subject: [PATCH v6 linux-kselftest-test 1/6] kunit: move string-stream.h to lib/kunit
Date:   Wed,  4 Dec 2019 15:27:09 +0000
Message-Id: <1575473234-5443-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
References: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040128
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

string-stream interfaces are not intended for external use;
move them from include/kunit to lib/kunit accordingly.

Co-developed-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/assert.h                 | 3 ++-
 lib/kunit/assert.c                     | 2 ++
 lib/kunit/string-stream-test.c         | 3 ++-
 lib/kunit/string-stream.c              | 3 ++-
 {include => lib}/kunit/string-stream.h | 0
 lib/kunit/test.c                       | 2 ++
 6 files changed, 10 insertions(+), 3 deletions(-)
 rename {include => lib}/kunit/string-stream.h (100%)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index db6a0fc..ad889b5 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -9,10 +9,11 @@
 #ifndef _KUNIT_ASSERT_H
 #define _KUNIT_ASSERT_H
 
-#include <kunit/string-stream.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 
 struct kunit;
+struct string_stream;
 
 /**
  * enum kunit_assert_type - Type of expectation/assertion.
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 86013d4..9aca71c 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -7,6 +7,8 @@
  */
 #include <kunit/assert.h>
 
+#include "string-stream.h"
+
 void kunit_base_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
 {
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 76cc05e..6c70dc8 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -6,10 +6,11 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/slab.h>
 
+#include "string-stream.h"
+
 static void string_stream_test_empty_on_creation(struct kunit *test)
 {
 	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index e6d17aa..3503920 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -6,11 +6,12 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
+#include "string-stream.h"
+
 struct string_stream_fragment_alloc_context {
 	struct kunit *test;
 	int len;
diff --git a/include/kunit/string-stream.h b/lib/kunit/string-stream.h
similarity index 100%
rename from include/kunit/string-stream.h
rename to lib/kunit/string-stream.h
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c83c0fa..36ebf47 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
 
+#include "string-stream.h"
+
 static void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
-- 
1.8.3.1

