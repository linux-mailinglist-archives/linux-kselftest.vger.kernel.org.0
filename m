Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089831F6F47
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFKVRL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 17:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgFKVRL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 17:17:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A0FC08C5C1;
        Thu, 11 Jun 2020 14:17:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q8so8017815iow.7;
        Thu, 11 Jun 2020 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLt18Y6W5gGwuw6RcLD1KD4cexUWiAcYxlXCoMhY/Zk=;
        b=tP05nD18zyaPnjbVlSYPcWkm5O+mR5kSp+Bea8c0B39sT1mHxTIWV/AbGudu3IWuwj
         rA7CYX35ckaGfR3Fq+P2SHJ8tG1CSzGoiwj/W1rceGoumqMrwGrSA9nK498/cEZeR5j7
         YcRWV7ySvYHPI/YKRyZ1aIcVDRDfX2L7cNax4ynlrFvKuykNAAiG/+6+JBsrvaMAKyDc
         tkzquw62Z67g0/IuY5fyBvSy2tflDQXnCmbdW0d9AWvR44z9E6r5gBLIr1d0VVxpojJo
         BHykrz3Ooe6M5dNES1lPjZRBOrN7e7nBQzL7S+NtPdKAUCXuONCdVdDM6ZUUMz3u4klb
         XjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLt18Y6W5gGwuw6RcLD1KD4cexUWiAcYxlXCoMhY/Zk=;
        b=J3RoNFvTAY5rN9hyGCb9J8WgYgKZnn3J0ToNSjG8ZUVCIYeY3onOsKUWbK33PQybhz
         rHCyYUN4ox57nQ3pcI60AeYwwI0RLmfdHzTqqUaExSnJa788ejypBV0TSV6+PKdl13XH
         wUDPRXD2NUDBUa5xjY5xze35GeMPeLT+kPkLWdaDHBGdOGvXITAqtuWPXTHWn7I5MQ0c
         /teIYjL1VECOlNSWmkxRhUfu1LmvKvsVc+xaB2A72s3Yq0ovjsPMfG++6wXF4IgbiTk+
         VTst1jlSNcYDxJ8+Us6F6FMUe0D1qZ8CGDbqtzVqtZtQw/0DE5xQxhbUjw9PWj+2EOuh
         QduQ==
X-Gm-Message-State: AOAM532B3ufWDMt0LT12AUqMnKk0U6nsI+53WMcGU04IDHVbDSdYqn37
        XG3LiDKoehc4A9vB6Pg4hzg=
X-Google-Smtp-Source: ABdhPJykLH7xMIrgm/4Hl6xB7+2dr3D8cF3Z326nWJplAsfWiRQQc5uMdx6aA8SYE8/hbgBv9SxK+w==
X-Received: by 2002:a6b:5f06:: with SMTP id t6mr10095418iob.88.1591910230430;
        Thu, 11 Jun 2020 14:17:10 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id n7sm2031738ile.76.2020.06.11.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 14:17:09 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com
Cc:     Uriel Guajardo <urielguajardo@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: show error if kunit results are not present
Date:   Thu, 11 Jun 2020 21:05:45 +0000
Message-Id: <20200611210545.173886-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Currently, if the kernel is configured incorrectly or if it crashes before any
kunit tests are run, kunit finishes without error, reporting
that 0 test cases were run.

To fix this, an error is shown when the tap header is not found, which
indicates that kunit was not able to run at all.

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 tools/testing/kunit/kunit_parser.py               |   8 ++++----
 tools/testing/kunit/kunit_tool_test.py            |  11 +++++++++++
 .../kunit/test_data/test_insufficient_memory.log  | Bin 0 -> 856 bytes
 3 files changed, 15 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_insufficient_memory.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 64aac9dcd431..f13e0c0d6663 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -265,11 +265,9 @@ def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
 	return bubble_up_errors(lambda x: x.status, test_suite_list)
 
 def parse_test_result(lines: List[str]) -> TestResult:
-	if not lines:
-		return TestResult(TestStatus.NO_TESTS, [], lines)
 	consume_non_diagnositic(lines)
-	if not parse_tap_header(lines):
-		return None
+	if not lines or not parse_tap_header(lines):
+		return TestResult(TestStatus.NO_TESTS, [], lines)
 	test_suites = []
 	test_suite = parse_test_suite(lines)
 	while test_suite:
@@ -282,6 +280,8 @@ def parse_run_tests(kernel_output) -> TestResult:
 	failed_tests = 0
 	crashed_tests = 0
 	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+	if test_result.status == TestStatus.NO_TESTS:
+		print_with_timestamp(red('[ERROR] ') + 'no kunit output detected')
 	for test_suite in test_result.suites:
 		if test_suite.status == TestStatus.SUCCESS:
 			print_suite_divider(green('[PASSED] ') + test_suite.name)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 984588d6ba95..4a7ef2eef831 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -170,6 +170,17 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
 		file.close()
 
+	def test_no_kunit_output(self):
+		crash_log = get_absolute_path(
+			'test_data/test_insufficient_memory.log')
+		file = open(crash_log)
+		print_mock = mock.patch('builtins.print').start()
+		result = kunit_parser.parse_run_tests(
+			kunit_parser.isolate_kunit_output(file.readlines()))
+		print_mock.assert_any_call(StrContains("no kunit output detected"))
+		print_mock.stop()
+		file.close()
+
 	def test_crashed_test(self):
 		crashed_log = get_absolute_path(
 			'test_data/test_is_test_passed-crash.log')
diff --git a/tools/testing/kunit/test_data/test_insufficient_memory.log b/tools/testing/kunit/test_data/test_insufficient_memory.log
new file mode 100644
index 0000000000000000000000000000000000000000..6c9e4da7b6d763a03c0c83302b2faa6dc21a6ea6
GIT binary patch
literal 856
zcmbu6Piw<448`yH6xx0L3mw^@hf#VOv}5$J+fZ#KHj8CrJK6H>=Z2=CgO$<hA}n~n
z_av{ZCy=#qP-&xMfG4=6vR)i)5n%+={(WUX@f3QQc$@8JeI=@sWh+JEQ*#MXVFVXF
z3Ic%)LLrv~p$(Btnp72VZT95Dcs$;|{9!uqlCTqzsVj`yGB}JvL1F#T<`SpJ4?L6&
zvLJa#bUk?B5jWafHpCGc^cwdSg)SXJ+Sp0$Q$V&%X;`!D6P@>grwf=!Y9>J$&;ioE
z(YWH`vCdK5Yv8@UZFe8*_w@>lK?j;o`2XCkM`zDc9)5TBu*ma#3i~#uEu#ge+Mv@N
z!H}`OJ&aI@v}o*ZK;I-rL20Tal*zuYY-cSL^z~bR2OA<uaygqX^7-Rzeh;N?h?hs>
F><3Em&*A_8

literal 0
HcmV?d00001

-- 
2.27.0.278.ge193c7cf3a9-goog

