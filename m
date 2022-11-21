Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A8632D75
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 20:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiKUTzq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiKUTzb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 14:55:31 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8565412766
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 11:55:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o23-20020a17090ac09700b00218afed23f4so1684715pjs.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W02RbsZsl++qiQdJK9RwY8tMReALtesu58tvw95Kdrw=;
        b=ojjOBWylYfZsKG0qH6zTB7tdNrjOPvXnoS8ljAUKXfLUd/ZMEK0KRbWVPHHYz6+sU/
         1CW84x9W0DB+oO6KH4pJOuHiD2wvj10vFgVM2ccmepE/Hr96b4xNT4jbUB4EWQM7Zj8y
         w1qpRsfBCRhmFE0NdZsiNiOpHVXSLZyE8d7PuNDf2z5BYY4tnvuJBaAiLCgqxpqxv5NW
         1awIF657EY0srq0JCIBRMzmoLk+ScM4eR1CQch8unvggPd+h/2e4jI6PMvMBzShellcI
         yDhaO5qxiUVlRQJSy54b604EKbXVI5nVA73bufPELrDIQbkNYO0QoG2KV+c5WiVQQDkc
         P3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W02RbsZsl++qiQdJK9RwY8tMReALtesu58tvw95Kdrw=;
        b=HGafSQiGS68xeySqSN+UIiTrCgmJL4+UPb1YBTdR90kY2FPVn6TYE8P4T6sjqT750q
         2U3vbAoMyvT/weLg1Sb0eUmn/NNxHrFBFRsKL0XkgsgCueK153XI8GFyPJncEmwMUYsx
         f3SIOoUais+Ruaww/vD7T7J8DVog3InidBFzVZMWlCcslcKqx/qEKfATOYt3WmedsCt5
         qWGgGshEP8k/DDSMbIsBTLGyi2ZTa9tOWkn90aGZ4RmjzMLomz+yXr3Qn4ubUyz4WWDM
         5ZIXvlt5ZUbIL+Pcd2pGiRMA4CvOcbTeMZlHAyBTQIZJOhvzhIa1TWZrE5uVDRJTziba
         wt2w==
X-Gm-Message-State: ANoB5pni+gNZEKbXMu3ubmE8z0rIlnaaF/lEktEs643VM37krV1aWWtb
        8t1GUXQE1EZxbZPGLXMtydcNyo7JK193qg==
X-Google-Smtp-Source: AA0mqf72Ofv54sxGUf8sRNUPFhJvThaSO3oUCy8wtr7UXy9f0eeiG2/6Tte5rilGQur8S6aX360S3Fy3BAJLnA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:c298:b0:218:a32f:9612 with SMTP
 id f24-20020a17090ac29800b00218a32f9612mr10158502pjt.155.1669060530049; Mon,
 21 Nov 2022 11:55:30 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:55:26 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121195526.425882-1-dlatypov@google.com>
Subject: [PATCH] kunit: tool: make --json do nothing if --raw_ouput is set
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When --raw_output is set (to any value), we don't actually parse the
test results. So asking to print the test results as json doesn't make
sense.

We internally create a fake test with one passing subtest, so --json
would actually print out something misleading.

This patch:
* Rewords the flag descriptions so hopefully this is more obvious.
* Also updates --raw_output's description to note the default behavior
  is to print out only "KUnit" results (actually any KTAP results)
* also renames and refactors some related logic for clarity (e.g.
  test_result => test, it's a kunit_parser.Test object).

Notably, this patch does not make it an error to specify --json and
--raw_output together. This is an edge case, but I know of at least one
wrapper around kunit.py that always sets --json. You'd never be able to
use --raw_output with that wrapper.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 4d4663fb578b..e7b6549712d6 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -192,12 +192,11 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
 	parse_start = time.time()
 
-	test_result = kunit_parser.Test()
-
 	if request.raw_output:
 		# Treat unparsed results as one passing test.
-		test_result.status = kunit_parser.TestStatus.SUCCESS
-		test_result.counts.passed = 1
+		fake_test = kunit_parser.Test()
+		fake_test.status = kunit_parser.TestStatus.SUCCESS
+		fake_test.counts.passed = 1
 
 		output: Iterable[str] = input_data
 		if request.raw_output == 'all':
@@ -206,14 +205,17 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 			output = kunit_parser.extract_tap_lines(output, lstrip=False)
 		for line in output:
 			print(line.rstrip())
+		parse_time = time.time() - parse_start
+		return KunitResult(KunitStatus.SUCCESS, parse_time), fake_test
 
-	else:
-		test_result = kunit_parser.parse_run_tests(input_data)
-	parse_end = time.time()
+
+	# Actually parse the test results.
+	test = kunit_parser.parse_run_tests(input_data)
+	parse_time = time.time() - parse_start
 
 	if request.json:
 		json_str = kunit_json.get_json_result(
-					test=test_result,
+					test=test,
 					metadata=metadata)
 		if request.json == 'stdout':
 			print(json_str)
@@ -223,10 +225,10 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 			stdout.print_with_timestamp("Test results stored in %s" %
 				os.path.abspath(request.json))
 
-	if test_result.status != kunit_parser.TestStatus.SUCCESS:
-		return KunitResult(KunitStatus.TEST_FAILURE, parse_end - parse_start), test_result
+	if test.status != kunit_parser.TestStatus.SUCCESS:
+		return KunitResult(KunitStatus.TEST_FAILURE, parse_time), test
 
-	return KunitResult(KunitStatus.SUCCESS, parse_end - parse_start), test_result
+	return KunitResult(KunitStatus.SUCCESS, parse_time), test
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
@@ -359,14 +361,14 @@ def add_exec_opts(parser) -> None:
 			    choices=['suite', 'test'])
 
 def add_parse_opts(parser) -> None:
-	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
-			    'If set to --raw_output=kunit, filters to just KUnit output.',
+	parser.add_argument('--raw_output', help='If set don\'t parse output from kernel. '
+			    'By default, filters to just KUnit output. Use '
+			    '--raw_output=all to show everything',
 			     type=str, nargs='?', const='all', default=None, choices=['all', 'kunit'])
 	parser.add_argument('--json',
 			    nargs='?',
-			    help='Stores test results in a JSON, and either '
-			    'prints to stdout or saves to file if a '
-			    'filename is specified',
+			    help='Prints parsed test results as JSON to stdout or a file if '
+			    'a filename is specified. Does nothing if --raw_output is set.',
 			    type=str, const='stdout', default=None, metavar='FILE')
 
 

base-commit: 870f63b7cd78d0055902d839a60408f7428b4e84
-- 
2.38.1.584.g0f3c55d4c2-goog

