Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423851649D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgBSQSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 11:18:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51140 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgBSQR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 11:17:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGDHqe099489;
        Wed, 19 Feb 2020 16:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=nFAWhcrV0joF2RtzWKkLK8Yk9RZN9qZWY971I91UZ2E=;
 b=aQ8bE6wRiQZlI7iia79jGGVgdpxCStrMqX5FNzm2zylNQt6Vd/kJ1JEriAgA655fAncm
 WEqqpgeRq/O+1dHvQ5JPu33MXBhxfLDk4wFMhuw98NSXIkwGgmUBgIt4gZehRclfzOn0
 ocXfOMKz5ARKo1tFkfEO9TxNQFGo7lxhO62ABKamTyYffdMSrLFrEAwlZhPnAef68Oq1
 FzeQrsxZYnvWBjsVxq1IcvsshY/5fZYNAvvP77b3ZwwtoKNBSPfjk2m9mbRfokmN27Qv
 FpKt1KFG+vmYTD0Q5Q4pydhLGIFBzyK4s0X//hZ8FQimI+Dt66lWHqQhJSlVlcMq/fMY MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y8udkc6h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:17:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGCDWD017246;
        Wed, 19 Feb 2020 16:17:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y8udasxbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:17:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JGHkNm009570;
        Wed, 19 Feb 2020 16:17:46 GMT
Received: from dhcp-10-175-189-86.vpn.oracle.com (/10.175.189.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 08:17:45 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 kunit-next 3/4] kunit: subtests should be indented 4 spaces according to TAP
Date:   Wed, 19 Feb 2020 16:17:09 +0000
Message-Id: <1582129030-22282-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582129030-22282-1-git-send-email-alan.maguire@oracle.com>
References: <1582129030-22282-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=3 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=3
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190122
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce KUNIT_INDENT macro which corresponds to 4-space indentation,
and use it to modify indentation from tab to 4 spaces.

Suggested-by: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/kunit/test.h |  7 ++++-
 lib/kunit/assert.c   | 79 ++++++++++++++++++++++++++--------------------------
 lib/kunit/test.c     |  2 +-
 3 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 7ce5125..d32a119 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -84,6 +84,10 @@ struct kunit_resource {
 /* Size of log associated with test. */
 #define KUNIT_LOG_SIZE	512
 
+/* TAP specifies subtest indentation of 4 spaces. */
+#define KUNIT_INDENT	"    "
+#define KUNIT_INDENT2	KUNIT_INDENT KUNIT_INDENT
+
 /**
  * struct kunit_case - represents an individual test case.
  *
@@ -395,7 +399,8 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 	} while (0)
 
 #define kunit_printk(lvl, test, fmt, ...)				\
-	kunit_log(lvl, test, "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
+	kunit_log(lvl, test, KUNIT_INDENT "# %s: " fmt, (test)->name,	\
+		  ##__VA_ARGS__)
 
 /**
  * kunit_info() - Prints an INFO level message associated with @test.
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index b24bebc..17b0214 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -6,6 +6,7 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 #include <kunit/assert.h>
+#include <kunit/test.h>
 
 #include "string-stream.h"
 
@@ -53,12 +54,12 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 	kunit_base_assert_format(assert, stream);
 	if (unary_assert->expected_true)
 		string_stream_add(stream,
-				 "\tExpected %s to be true, but is false\n",
-				 unary_assert->condition);
+				  KUNIT_INDENT "Expected %s to be true, but is false\n",
+				  unary_assert->condition);
 	else
 		string_stream_add(stream,
-				 "\tExpected %s to be false, but is true\n",
-				 unary_assert->condition);
+				  KUNIT_INDENT "Expected %s to be false, but is true\n",
+				  unary_assert->condition);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
@@ -72,13 +73,13 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	kunit_base_assert_format(assert, stream);
 	if (!ptr_assert->value) {
 		string_stream_add(stream,
-				 "\tExpected %s is not null, but is\n",
-				 ptr_assert->text);
+				  KUNIT_INDENT "Expected %s is not null, but is\n",
+				  ptr_assert->text);
 	} else if (IS_ERR(ptr_assert->value)) {
 		string_stream_add(stream,
-				 "\tExpected %s is not error, but is: %ld\n",
-				 ptr_assert->text,
-				 PTR_ERR(ptr_assert->value));
+				  KUNIT_INDENT "Expected %s is not error, but is: %ld\n",
+				  ptr_assert->text,
+				  PTR_ERR(ptr_assert->value));
 	}
 	kunit_assert_print_msg(assert, stream);
 }
@@ -92,16 +93,16 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
-			 "\tExpected %s %s %s, but\n",
-			 binary_assert->left_text,
-			 binary_assert->operation,
-			 binary_assert->right_text);
-	string_stream_add(stream, "\t\t%s == %lld\n",
-			 binary_assert->left_text,
-			 binary_assert->left_value);
-	string_stream_add(stream, "\t\t%s == %lld",
-			 binary_assert->right_text,
-			 binary_assert->right_value);
+			  KUNIT_INDENT "Expected %s %s %s, but\n",
+			  binary_assert->left_text,
+			  binary_assert->operation,
+			  binary_assert->right_text);
+	string_stream_add(stream, KUNIT_INDENT2 "%s == %lld\n",
+			  binary_assert->left_text,
+			  binary_assert->left_value);
+	string_stream_add(stream, KUNIT_INDENT "%s == %lld",
+			  binary_assert->right_text,
+			  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
@@ -114,16 +115,16 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
-			 "\tExpected %s %s %s, but\n",
-			 binary_assert->left_text,
-			 binary_assert->operation,
-			 binary_assert->right_text);
-	string_stream_add(stream, "\t\t%s == %pK\n",
-			 binary_assert->left_text,
-			 binary_assert->left_value);
-	string_stream_add(stream, "\t\t%s == %pK",
-			 binary_assert->right_text,
-			 binary_assert->right_value);
+			  KUNIT_INDENT "Expected %s %s %s, but\n",
+			  binary_assert->left_text,
+			  binary_assert->operation,
+			  binary_assert->right_text);
+	string_stream_add(stream, KUNIT_INDENT2 "%s == %pK\n",
+			  binary_assert->left_text,
+			  binary_assert->left_value);
+	string_stream_add(stream, KUNIT_INDENT2 "%s == %pK",
+			  binary_assert->right_text,
+			  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
@@ -136,16 +137,16 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
-			 "\tExpected %s %s %s, but\n",
-			 binary_assert->left_text,
-			 binary_assert->operation,
-			 binary_assert->right_text);
-	string_stream_add(stream, "\t\t%s == %s\n",
-			 binary_assert->left_text,
-			 binary_assert->left_value);
-	string_stream_add(stream, "\t\t%s == %s",
-			 binary_assert->right_text,
-			 binary_assert->right_value);
+			  KUNIT_INDENT "Expected %s %s %s, but\n",
+			  binary_assert->left_text,
+			  binary_assert->operation,
+			  binary_assert->right_text);
+	string_stream_add(stream, KUNIT_INDENT2 "%s == %s\n",
+			  binary_assert->left_text,
+			  binary_assert->left_value);
+	string_stream_add(stream, KUNIT_INDENT2 "%s == %s",
+			  binary_assert->right_text,
+			  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c0f65b9..a6e0b36 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -71,7 +71,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 			kunit_status_to_string(is_ok),
 			test_number, description);
 	else
-		kunit_log(KERN_INFO, test, "\t%s %zd - %s",
+		kunit_log(KERN_INFO, test, KUNIT_INDENT "%s %zd - %s",
 			  kunit_status_to_string(is_ok),
 			  test_number, description);
 }
-- 
1.8.3.1

