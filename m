Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDA1849CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgCMOpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 10:45:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48474 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgCMOpO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 10:45:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEeVIN099755;
        Fri, 13 Mar 2020 14:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=opcYGX3adc8m4vqnW3qxRXkyoQvhcC+ntoEq5pKqfYc=;
 b=eCZ0zMTWhmdxkulC+/jGTeypEETPjJ1QvRDc4afCEqGr5RRiX2HrjskJm0yq1ngyVYFB
 RkjwmBEQmu42fu9YZ+sfPFk7v7863jKAhGbn6bGqRA2Btd0IrV0yp7I5KGX0AGJpTOTQ
 /b4luFXzC0zxADCMKaBDFK7pO4AlHADEK2UxQiCj7UFPre+SfITsbfwy9Rcws+2/GT6l
 OE+1w3p0dQh/lbglH7mXP+fDfYMgan7vjNpmJA897cDmk2FKhkVkmWgJ6kBy9JdicZFJ
 +5aIIOYqlAfMXsKqw9eeK+CI+KCB89GVt+vSjEjGeHRYRDcK6HBay+P4eRPSZxXuIyHV VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yqtavm6qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 14:45:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEcF1Y010639;
        Fri, 13 Mar 2020 14:45:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yqtact4vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 14:45:06 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02DEj5lD019547;
        Fri, 13 Mar 2020 14:45:05 GMT
Received: from dhcp-10-175-173-225.vpn.oracle.com (/10.175.173.225)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Mar 2020 07:45:05 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 kunit-next 3/4] kunit: subtests should be indented 4 spaces according to TAP
Date:   Fri, 13 Mar 2020 14:44:41 +0000
Message-Id: <1584110682-3837-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
References: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=4
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=4
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130077
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce KUNIT_INDENT macro which corresponds to 4-space indentation,
and use it to modify indentation from tab to 4 spaces.

Suggested-by: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
---
 include/kunit/test.h                |  7 +++-
 lib/kunit/assert.c                  | 79 +++++++++++++++++++------------------
 lib/kunit/test.c                    |  6 +--
 tools/testing/kunit/kunit_parser.py | 10 ++---
 4 files changed, 54 insertions(+), 48 deletions(-)

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
index a3fa21f..e9609c2 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -69,8 +69,8 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
 static void kunit_print_subtest_start(struct kunit_suite *suite)
 {
 	kunit_print_tap_version();
-	kunit_log(KERN_INFO, suite, "\t# Subtest: %s", suite->name);
-	kunit_log(KERN_INFO, suite, "\t1..%zd",
+	kunit_log(KERN_INFO, suite, KUNIT_INDENT "# Subtest: %s", suite->name);
+	kunit_log(KERN_INFO, suite, KUNIT_INDENT "1..%zd",
 		  kunit_suite_num_test_cases(suite));
 }
 
@@ -96,7 +96,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 			kunit_status_to_string(is_ok),
 			test_number, description);
 	else
-		kunit_log(KERN_INFO, test, "\t%s %zd - %s",
+		kunit_log(KERN_INFO, test, KUNIT_INDENT "%s %zd - %s",
 			  kunit_status_to_string(is_ok),
 			  test_number, description);
 }
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 4ffbae0..14265a5 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -91,7 +91,7 @@ def print_log(log):
 	for m in log:
 		print_with_timestamp(m)
 
-TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
+TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
 
 def consume_non_diagnositic(lines: List[str]) -> None:
 	while lines and not TAP_ENTRIES.match(lines[0]):
@@ -104,7 +104,7 @@ def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
 
 OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
-OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
+OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
 
@@ -133,7 +133,7 @@ def parse_ok_not_ok_test_case(lines: List[str],
 	else:
 		return False
 
-SUBTEST_DIAGNOSTIC = re.compile(r'^\t# .*?: (.*)$')
+SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# .*?: (.*)$')
 DIAGNOSTIC_CRASH_MESSAGE = 'kunit test case crashed!'
 
 def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
@@ -160,7 +160,7 @@ def parse_test_case(lines: List[str], expecting_test_case: bool) -> TestCase:
 	else:
 		return None
 
-SUBTEST_HEADER = re.compile(r'^\t# Subtest: (.*)$')
+SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
 
 def parse_subtest_header(lines: List[str]) -> str:
 	consume_non_diagnositic(lines)
@@ -173,7 +173,7 @@ def parse_subtest_header(lines: List[str]) -> str:
 	else:
 		return None
 
-SUBTEST_PLAN = re.compile(r'\t[0-9]+\.\.([0-9]+)')
+SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
 def parse_subtest_plan(lines: List[str]) -> int:
 	consume_non_diagnositic(lines)
-- 
1.8.3.1

