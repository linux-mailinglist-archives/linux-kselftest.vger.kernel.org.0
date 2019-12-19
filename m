Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96B3612668A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 17:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSQSu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Dec 2019 11:18:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36296 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSQSt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Dec 2019 11:18:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEKAA126744;
        Thu, 19 Dec 2019 16:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=AN47JONeK8oCX+YPtCKA7vbhhvfwmEGZgeS7UlEbne0=;
 b=Ry6oRZxA8O6KJNa7FVLJ0/tVgQJcGuP+b7sjlE0OiVdu+lsBPMskmozpdHCQdpYRtiNX
 IOhmNUHZJF6bn/+MPudu8tgsa761/qKB9V4HoOQ2jGOzMC1uSys4l+dnzdcNpneaTYqA
 v7Td5fX0set5RzK8jxyh9i/0Q+o5FMgSt84gv8fp4I6iG4QX6A4Mpdx+6VGOdfNCLO9E
 wqp6I3wfXuGBrR4SAnJf/ufLjGy8x+2Ih/bp81i2elXwWOifXcStzLL80ByKoSAJTJNi
 xZPNOPB9xel1RhXvohZVD3GBxVFoWccL0c/05j+iq4kNh2oMQIvUkpZ2FnhUg8lPH7w6 dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2x01knkup2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGELEj035118;
        Thu, 19 Dec 2019 16:18:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wyxqhwy0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBJGIFfh017466;
        Thu, 19 Dec 2019 16:18:16 GMT
Received: from dhcp-10-175-212-35.vpn.oracle.com (/10.175.212.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 08:18:14 -0800
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
Subject: [PATCH v7 linux-kselftest-test 1/6] kunit: move string-stream.h to lib/kunit
Date:   Thu, 19 Dec 2019 16:17:34 +0000
Message-Id: <1576772259-31382-2-git-send-email-alan.maguire@oracle.com>
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
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
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

