Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2DB4EB56A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 23:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiC2Vop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 17:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiC2Von (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 17:44:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DB38BDE
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 14:43:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc7bdd666fso154630487b3.7
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MPuCjGFRCgC2i5OJuvXhL/tDoctAierRSaLs34LAj+8=;
        b=Ckg8PgV4Y5J+WH6h8bc2lXH7ZAQEOvLdyTpGeaNlrns1vLITdVrGSmez1YsZlH03n0
         WWU0gIWuWiAVcvegJDqBLIOOVDpmt+zbH4LKG88u6XPH/H1SAWnfnVPNX7l+hbeWRJyo
         Hq88vSNuKVU2MexMDV4OeV0Dh1DP7rQDePvbMZRuGl7MdAsRjW3w/6+J0wsI5QcRxobg
         REJMBOid2aEIjcw2NylrRbWQ9NkBP/2OAfQuEet4ZrxkGsN+urNIaJG2JUrAWAN8Vbxy
         mQOYkQMss5W2eG/VMYVOD7sL1Jc2/HRMIZLeJaz0XwEmkXCdmEVG1HEzMnQddwujebXu
         JlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MPuCjGFRCgC2i5OJuvXhL/tDoctAierRSaLs34LAj+8=;
        b=3NdP/8dGDQ33dNtAewKZvQ6GCE9SgpQmjcD6RmlMjXNrepOfO980b6TbF8p3+YuVo0
         Uw0qyPjxV9TEFVqOOlgBE+Yb5Y4lF3VBc6UcMLyLvUo3efbh/RC7KYHqAML/wkJ5uyjt
         K5SNkL98v+unYQ7yycwRpr+twA9gMS8tq8uW9hRo5Fno9YRjHHBke+rR+p5WWANh7EGX
         zmDafrhEk//nXrxmd+7Rl9RwmL/GUXlH0gMNNsIjgRVQiAo+iP6tFfAtLRS0xzvtOj6I
         B3S/wPHVi8W0LZnwWzK7Kwzb3jDHwol60Vy7adaa4TRCOb+pjvQ6bvsyX31CU/MEWk6M
         +V0w==
X-Gm-Message-State: AOAM53266uuxDl6xjP/fgobxRxrIf8kv0fKIcUfADMr0jBxWLdIgFmd4
        yZiEtH1y+9QxBEsVmSNdDv5HlnImpTQWWA==
X-Google-Smtp-Source: ABdhPJxgwS59m++wv0AAc8cTwrw4lPFrVjuIFqtg/grH47+/aNAcU6p9KVXhnM1BzsC2BbyrBVCMiLBX9l23pA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d547:f5e2:5493:d519])
 (user=dlatypov job=sendgmr) by 2002:a25:bf88:0:b0:633:93e9:b2fc with SMTP id
 l8-20020a25bf88000000b0063393e9b2fcmr29718813ybk.202.1648590179382; Tue, 29
 Mar 2022 14:42:59 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:42:48 -0700
Message-Id: <20220329214248.1330868-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] kunit: tool: print clearer error message when there's no TAP output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before:
$ ./tools/testing/kunit/kunit.py parse /dev/null
...
[ERROR] Test : invalid KTAP input!

After:
$ ./tools/testing/kunit/kunit.py parse /dev/null
...
[ERROR] Test <missing>: could not find any KTAP output!

This error message gets printed out when extract_tap_output() yielded no
lines. So while it could be because of malformed KTAP output from KUnit,
it could also be due to to not having any KTAP output at all.

Try and make the error message here more clear.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 3 ++-
 tools/testing/kunit/kunit_tool_test.py | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 05ff334761dd..103d95a66a7e 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -817,7 +817,8 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	lines = extract_tap_lines(kernel_output)
 	test = Test()
 	if not lines:
-		test.add_error('invalid KTAP input!')
+		test.name = '<missing>'
+		test.add_error('could not find any KTAP output!')
 		test.status = TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
 		test = parse_test(lines, 0, [])
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 352369dffbd9..f14934853ea1 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -226,7 +226,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		print_mock.assert_any_call(StrContains('invalid KTAP input!'))
+		print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
 		print_mock.stop()
 		self.assertEqual(0, len(result.subtests))
 
@@ -559,7 +559,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(e.exception.code, 1)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
-		self.print_mock.assert_any_call(StrContains('invalid KTAP input!'))
+		self.print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
 
 	def test_exec_no_tests(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])

base-commit: 13776ebb9964b2ea66ffb8c824c0762eed6da784
-- 
2.35.1.1021.g381101b075-goog

