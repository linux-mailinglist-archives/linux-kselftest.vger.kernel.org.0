Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BE9178F54
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 12:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgCDLIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 06:08:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44172 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDLIB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 06:08:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024B3kJp008287;
        Wed, 4 Mar 2020 11:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=JLdZ0cB8n+9TLXBTjDiTs1wJ2xozCxHqyOnmFBylWSM=;
 b=joS53tQJZ4l++bXwLXk5tmxJglpt0QPN8/1/FqNFRe00fbelvYUjOKDEgxLKJTpPr1hN
 w4AGIkpVAzT45nhi/sgCnJSkvuJDP0zp236Y+Oe2OErd3+REzfg4BHdn7mHgCrUoihhF
 Hh3vRCbUBGzQ+r6c850BJfSV72354mbPUIQPkRtgN/VovNuQ8rHy/eFCY9IBbHNrIDmR
 h8Lpj3bdDTy99a62izQnA8/SxPV+E+NSuXN8tlJPHv18a8PVCZeNGTIapjOUf8OfrR8o
 Tk7HBw4PV0t6E9WC8RMSktUNhYjCQ+EwY0vwZPU9cU0mV+aSTfFGkJ7lC2c+4K7d7LMv bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2yffcunq9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 11:07:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024B2h24152477;
        Wed, 4 Mar 2020 11:07:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yg1epj2pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 11:07:55 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024B7sEK012783;
        Wed, 4 Mar 2020 11:07:54 GMT
Received: from dhcp-10-175-165-222.vpn.oracle.com (/10.175.165.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 03:07:53 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 kunit-next 3/4] kunit: subtests should be indented 4 spaces according to TAP
Date:   Wed,  4 Mar 2020 11:07:15 +0000
Message-Id: <1583320036-442-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583320036-442-1-git-send-email-alan.maguire@oracle.com>
References: <1583320036-442-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=3 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=3 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040086
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
index f7b2ed4c..d49cdb4 100644
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
index 908e643..3fdc1f9 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -96,7 +96,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
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

