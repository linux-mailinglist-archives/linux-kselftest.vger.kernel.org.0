Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D5E29538C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503767AbgJUUjU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503605AbgJUUjU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 16:39:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F58C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 13:39:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k9so3518742ybf.18
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=b1umzvlGhO00O3+bWPexwSNZ9i6JQ+0lmukCzM058aM=;
        b=LI1PAYlv5RLhZbICd0vdEZEo8RO2vdUlcVR9fiwfc+quDZDfph349CCJ5fHSEfb0RE
         uUTRfkbOeaMZ3P9Lj9gRYfG+qdic1IyV1TB3wqTnTSSSa7nfRRbWkVCEoNfLIgDC+DCd
         jO27of2wmRdp5pmRufO4DXdDe4pUk/qxfE3GYYr/fdaZOBa4A3MaBFSjAKlCnWWMdssk
         WUVXhIp24SpNKFtoN2MwN2DVVr7lbhGIlZc8UBc6ec4zK+dACwovpdZ3INDGwEIxtA/J
         zuyNfm5n3GJlZA00mxp5Mp/XjTpgpYbsM43JEBZt8xweBXd1KLTihtZ+e3Q/Cr8yCK3+
         0/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=b1umzvlGhO00O3+bWPexwSNZ9i6JQ+0lmukCzM058aM=;
        b=AkgPVT6SyslWxYQmYKRJzeO1OT+TKXEny3ezG145/e22p9sw7VMRLTmNQRMf1aJnku
         X/Y7tvy/TGlbJD0HIbtBQ8Nd+05ZUgMe/2SVkjbweMLPjowczg1h0B7wtqxJSFbykXJ9
         jqBtWGrVNng0FCNQAUqLV+5uXRTmcN6umpA4wgQrUkL0o+b0zTZ7pxpfBTBGNKwrzJPk
         eh57oe7iKDk7+cs2+V5Vv9t8bTqq10dVgE8ascxsnY0zhgo5roEBQW9ZglWkqLJum3qm
         003tjsXYia5TDAwYf4IiwS9QDaDb1GICWkSmyKK/duYELkz3NP/hERmwK/MYQEuo2dDX
         OmSg==
X-Gm-Message-State: AOAM5315RbAu/V4uwBXqZYbwYNiCjKVaBqSAJtQujyzty+fm7ALweWz2
        h1xK26/XVKULAPV1z5D7pPFP4Y5EsCqRWnKnGcRAZA==
X-Google-Smtp-Source: ABdhPJwidW1lQLyLv1HQyKeLWvHMLJWRFBSLnKYm67K5Edffnc7w/BXg3c4zprLIBFJ1Pd7bU5Y6e1iiYTvcj3mvOylhWQ==
Sender: "brendanhiggins via sendgmr" 
        <brendanhiggins@mactruck.svl.corp.google.com>
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:c634:6bff:fe71:d8d1])
 (user=brendanhiggins job=sendgmr) by 2002:a25:e710:: with SMTP id
 e16mr7836816ybh.429.1603312759128; Wed, 21 Oct 2020 13:39:19 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:39:14 -0700
Message-Id: <20201021203914.2650778-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v1] kunit: tools: fix kunit_tool tests for parsing test plans
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some tests logs for kunit_tool tests are missing their test plans
causing their tests to fail; fix this by adding the test plans.

Fixes: 45dcbb6f5ef7 ("kunit: test: add test plan to KUnit TAP format")
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit_tool_test.py        |  32 ++++++++++++++----
 .../test_data/test_config_printk_time.log     | Bin 1584 -> 1605 bytes
 .../test_data/test_interrupted_tap_output.log | Bin 1982 -> 2003 bytes
 .../test_data/test_kernel_panic_interrupt.log | Bin 1321 -> 1342 bytes
 .../test_data/test_multiple_prefixes.log      | Bin 1832 -> 1861 bytes
 .../kunit/test_data/test_pound_no_prefix.log  | Bin 1193 -> 1200 bytes
 .../kunit/test_data/test_pound_sign.log       | Bin 1656 -> 1676 bytes
 7 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 99c3c5671ea48..0b60855fb8198 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -179,7 +179,7 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock = mock.patch('builtins.print').start()
 		result = kunit_parser.parse_run_tests(
 			kunit_parser.isolate_kunit_output(file.readlines()))
-		print_mock.assert_any_call(StrContains("no kunit output detected"))
+		print_mock.assert_any_call(StrContains('no tests run!'))
 		print_mock.stop()
 		file.close()
 
@@ -198,39 +198,57 @@ class KUnitParserTest(unittest.TestCase):
 			'test_data/test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = get_absolute_path(
 			'test_data/test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = get_absolute_path(
 			'test_data/test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_prefix_poundsign(self):
 		pound_log = get_absolute_path('test_data/test_pound_sign.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_kernel_panic_end(self):
 		panic_log = get_absolute_path('test_data/test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.TEST_CRASHED,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_pound_no_prefix(self):
 		pound_log = get_absolute_path('test_data/test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 class KUnitJsonTest(unittest.TestCase):
 
diff --git a/tools/testing/kunit/test_data/test_config_printk_time.log b/tools/testing/kunit/test_data/test_config_printk_time.log
index c02ca773946d641291e27d44d73174cc16a17d9d..6bdb57f76eacef0396e68942cb3fa983b6992bab 100644
GIT binary patch
delta 25
hcmdnMbChSob{0cDJ>$uC%rcYXnAkR+OlM`}0sw1)2Xg=b

delta 10
RcmX@gvw>&A_Kl}2Spgdh1kV5f

diff --git a/tools/testing/kunit/test_data/test_interrupted_tap_output.log b/tools/testing/kunit/test_data/test_interrupted_tap_output.log
index 5c73fb3a1c6fd13a9b163a48d02eb33b0315a375..1fb677728abeb0fe6aa5edb3a0387c05906b9815 100644
GIT binary patch
delta 21
dcmdnTf0=*6b{0cDJ>$t2n3Xo3{L0421prz=2g3jW

delta 17
Zcmcc2zmI>y_Q@YucqXy1ZM^%H4FE=v2d@AC

diff --git a/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
index c045eee75f27fefaabf3ba073d9e282721c19a67..a014ffe9725e3c4e81697f742cee2652a41b2108 100644
GIT binary patch
delta 25
hcmZ3<wU2AUb{0cDJ>$uC%rcYXnAkR+OkiQ;0sv{Y2U!3B

delta 10
RcmdnTwUTSX_Kl~DSO6Mc1hoJF

diff --git a/tools/testing/kunit/test_data/test_multiple_prefixes.log b/tools/testing/kunit/test_data/test_multiple_prefixes.log
index bc48407dcc36c44665c7d2ac620e42e7caf98481..0ad78481a0b450bf463ca7aaab0ae739d4e43018 100644
GIT binary patch
delta 16
YcmZ3%ca(3!^~t;}vKwy%urYE005`P-oB#j-

delta 15
XcmX@gw}NlN^~vX$gf_D>+Oq)wG*bm+

diff --git a/tools/testing/kunit/test_data/test_pound_no_prefix.log b/tools/testing/kunit/test_data/test_pound_no_prefix.log
index 2ceb360be7d52cbee4b0a5a426456605ded7466e..dc4cf09a96d077bbc0b5fbcb312251742e390379 100644
GIT binary patch
delta 17
YcmZ3<xq)*+J&U29p7F+79Tr9|05Q}Ar~m)}

delta 10
RcmdnMxsr22{l-=;762DW1K$7u

diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
index 28ffa5ba03bfa81ea02ea9d38e7de7acf3dd9e5d..3f358e3a7ba0d118c1dc15e5f637fb8ffb5aa388 100644
GIT binary patch
delta 19
bcmeyt)5AMqJBy*7p7G>PCZ&xh*RuiuM}Y?y

delta 14
WcmeC-{lPO~`{cDuLL2X{X9WN;2?l!r


base-commit: 7cf726a59435301046250c42131554d9ccc566b8
-- 
2.29.0.rc1.297.gfa9743e501-goog

