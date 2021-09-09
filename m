Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E75404219
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 02:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348307AbhIIAMV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Sep 2021 20:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348277AbhIIAMV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Sep 2021 20:12:21 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0ECC061575
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Sep 2021 17:11:12 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bp12-20020a05621407ec00b003773f981838so1048811qvb.22
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Sep 2021 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EOeek9YqCE1WEuNfo23pe4dEHJdLY52SFh/RSmUKBng=;
        b=g6ksaohA3UCJXkzsI+7UM5IOL8c9GGz+Ma3ngTc5JLHVP7AelpozHm7Gu18F/2C26W
         0DYbYO9YmxfOhu/dtV38jsInWRwzLkVJ2W6MLXZB5+/xqdhuZ23hhHol1IzBLmdVd9ZM
         m6QwEbG6c+AzS61dkHQNaCEN9u9E5IZMzxFICAmS+MVhskEMROHYP/ALM4qqeav6+gQ3
         aWbHDigQ1Qr4WvytJfB3qL4JFb2ypdLM2hRJcUuA3z5y77KLepWbuHIY84OifoGY9Wxe
         X0rHOtfAJvNrpghCNXZ+1HVMcmxI+/5eqM7bkhk0Hs8qkkshpcks0IzdZbRW4feUm+5K
         rGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EOeek9YqCE1WEuNfo23pe4dEHJdLY52SFh/RSmUKBng=;
        b=PrUqX9V2m2fYVqZj3uwyd/65mea8jlVxpJ8pAVbMnhS1ku03UyUjQEggfUZajaAYVL
         RZy/k4JgzbmPQdeO6yKgjBAZv1Q+EP2uyoJ89TUL5ZboHvhaCl9SQdy44ao4YcjCqMWu
         Ng45iuKo4AwBx55u0wiVb22ZouXvfJMRIY3V4rCiuIVWsjRTlFaeFX2xxLOTHKlyacox
         mGliWQZf67f6coS7nMx4mES3x1E7n6sQLT0Iugewxy4Y614gJ02p2g7WYrh5XweJpeWj
         xdZ1A60mOXWoAxcc8czyJIYxN6LqEICoZgeN6QqP5mtBbzMZrrncJvTveje/J1u7EQ+K
         M3Sw==
X-Gm-Message-State: AOAM530hZZWLbrgnnk85jqCYk7X6MWGC9JnlYCp5BFnUpweLT/XyHbew
        mYrC2pttD8//02Fk23OamQ2tzd9YTWd+MQ==
X-Google-Smtp-Source: ABdhPJxqjsJ7Y7+RMTPBvhwl7RjMzMsy/tTTixbuFrz4dfsigmrLEpOES/2Fdcu1UC5aCVzl4peSbTnr5BsT1g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:68b6:f792:6cb6:9052])
 (user=dlatypov job=sendgmr) by 2002:a0c:9c48:: with SMTP id
 w8mr1007484qve.65.1631146271816; Wed, 08 Sep 2021 17:11:11 -0700 (PDT)
Date:   Wed,  8 Sep 2021 17:10:36 -0700
In-Reply-To: <20210909001037.2842954-1-dlatypov@google.com>
Message-Id: <20210909001037.2842954-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210909001037.2842954-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 2/3] kunit: tool: factor exec + parse steps into a function
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently this code is copy-pasted between the normal "run" subcommand
and the "exec" subcommand.

Given we don't have any interest in just executing the tests without
giving the user any indication what happened (i.e. parsing the output),
make a function that does both this things and can be reused.

This will be useful when we allow more complicated ways of running
tests, e.g. invoking the kernel multiple times instead of just once,
etc.

We remove input_data from the ParseRequest so the callers don't have to
pass in a dummy value for this field. Named tuples are also immutable,
so if they did pass in a dummy, exec_tests() would need to make a copy
to call parse_tests().

Removing it also makes KunitParseRequest match the other *Request types,
as they only contain user arguments/flags, not data.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py | 44 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5a931456e718..55c25f7a715c 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -34,7 +34,7 @@ KunitExecRequest = namedtuple('KunitExecRequest',
                               ['timeout', 'build_dir', 'alltests',
                                'filter_glob', 'kernel_args'])
 KunitParseRequest = namedtuple('KunitParseRequest',
-			       ['raw_output', 'input_data', 'build_dir', 'json'])
+			       ['raw_output', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'alltests', 'filter_glob',
 					   'kernel_args', 'json', 'make_options'])
@@ -91,23 +91,25 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 			   'built kernel successfully',
 			   build_end - build_start)
 
-def exec_tests(linux: kunit_kernel.LinuxSourceTree,
-	       request: KunitExecRequest) -> KunitResult:
+def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
+	       parse_request: KunitParseRequest) -> KunitResult:
 	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
 	test_start = time.time()
-	result = linux.run_kernel(
+	run_result = linux.run_kernel(
 		args=request.kernel_args,
 		timeout=None if request.alltests else request.timeout,
-                filter_glob=request.filter_glob,
+		filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
 
 	test_end = time.time()
+	exec_time = test_end - test_start
 
-	return KunitResult(KunitStatus.SUCCESS,
-			   result,
-			   test_end - test_start)
+	# Named tuples are immutable, so we rebuild them here manually
+	result = parse_tests(parse_request, run_result)
+
+	return KunitResult(status=result.status, result=result.result, elapsed_time=exec_time)
 
-def parse_tests(request: KunitParseRequest) -> KunitResult:
+def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
 	parse_start = time.time()
 
 	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
@@ -115,7 +117,7 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 					      'Tests not Parsed.')
 
 	if request.raw_output:
-		output: Iterable[str] = request.input_data
+		output: Iterable[str] = input_data
 		if request.raw_output == 'all':
 			pass
 		elif request.raw_output == 'kunit':
@@ -126,7 +128,7 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 			print(line.rstrip())
 
 	else:
-		test_result = kunit_parser.parse_run_tests(request.input_data)
+		test_result = kunit_parser.parse_run_tests(input_data)
 	parse_end = time.time()
 
 	if request.json:
@@ -165,15 +167,11 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
 				 request.alltests, request.filter_glob,
 				 request.kernel_args)
-	exec_result = exec_tests(linux, exec_request)
-	if exec_result.status != KunitStatus.SUCCESS:
-		return exec_result
-
 	parse_request = KunitParseRequest(request.raw_output,
-					  exec_result.result,
 					  request.build_dir,
 					  request.json)
-	parse_result = parse_tests(parse_request)
+
+	exec_result = exec_tests(linux, exec_request, parse_request)
 
 	run_end = time.time()
 
@@ -184,7 +182,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 				config_result.elapsed_time,
 				build_result.elapsed_time,
 				exec_result.elapsed_time))
-	return parse_result
+	return exec_result
 
 def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
@@ -382,15 +380,12 @@ def main(argv, linux=None):
 						cli_args.alltests,
 						cli_args.filter_glob,
 						cli_args.kernel_args)
-		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
-						  exec_result.result,
 						  cli_args.build_dir,
 						  cli_args.json)
-		result = parse_tests(parse_request)
+		result = exec_tests(linux, exec_request, parse_request)
 		kunit_parser.print_with_timestamp((
-			'Elapsed time: %.3fs\n') % (
-				exec_result.elapsed_time))
+			'Elapsed time: %.3fs\n') % (result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'parse':
@@ -400,10 +395,9 @@ def main(argv, linux=None):
 			with open(cli_args.file, 'r') as f:
 				kunit_output = f.read().splitlines()
 		request = KunitParseRequest(cli_args.raw_output,
-					    kunit_output,
 					    None,
 					    cli_args.json)
-		result = parse_tests(request)
+		result = parse_tests(request, kunit_output)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	else:
-- 
2.33.0.309.g3052b89438-goog

