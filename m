Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF45F41CCF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbhI2T4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345843AbhI2T4a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 15:56:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF32C061767
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 12:54:48 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so10647104qkp.16
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 12:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9sOOAbpo+CDeDN2zgZAi4uwZL9FbPXFHzEInK3wMaN8=;
        b=MjEUyYEAPg62Uua1oTEbR7gL326WtcE7HZiyPUyqsvxymoVlqFIqASJRtboj1BPbyg
         n9/TU6pcpp2bVgAswzJc6ESN8yGo1/1dWGt4am0SdaMZQToHyFQTa2zjupdjm3PXPLse
         zywmrq/UWjwZ8VJCD7o5iapFL17oroEiaAzc1fxWm+otUO4hE1R3ZQ17WqLdLstL7Jn8
         QYaAvm6w5tQrme3tvmGikGmt89/pqMGNTfk/16RqLgSefnRKtE0b7vG8JQl2sdX4lavC
         HzWvw2HEhZAwR7tN9Qpa00Ti0xXBUsAwR4Yxyhs1ua/7a9IhivOU1v6OwXEpXexA1yNP
         Ae3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9sOOAbpo+CDeDN2zgZAi4uwZL9FbPXFHzEInK3wMaN8=;
        b=kjhVTnDH8YyQAxnD/it/hscco2hKZs1Jd6s3BTuuIip8a4tJIiUlZ7KA4nJGn1rCPS
         /+QjnubSp/4yI7s7b5Xr6XPs7xHQs/RTSbNBN4bqj512+tsNgJ16xvXDEAsxET11y6Iq
         0yNO0oqBtt1SjaM+/pY0A2WOLVv7klD3/fczSjDGVsttLsLRDbV418HsTG9HYnnOld7L
         phBLIqQ8kDmc+k4rNA3Afjjkqdo1jB/l7YDuAzvOtfv0ieF1aDb8BlBRScpjrAzcYDAy
         eLN8Q3/6MWzH4i/oKzGAREXGrxbTKJ+shIcs0Fb1rjuiVQVRpGBSvtZT/QX+vrqeAblC
         iqrw==
X-Gm-Message-State: AOAM530NQh8LjL+HDK3YP5CXo0cYN6ZUj2amB8B/aTDXdYI9nyLQ7o+W
        PVfQjM9v69wipf2RIGNf7alsX+JRJkeWHQ==
X-Google-Smtp-Source: ABdhPJx6QuIgvNNe4a2Cw8n9tyR1htGGPtY2/CjwI4hQMAPvoGr8HaN4rjiWgODRe9Q0Sq5NLdItrzNKmX3JGQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e473:7cd7:9986:85b7])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:2d1:: with SMTP id
 g17mr242890qvu.63.1632945287995; Wed, 29 Sep 2021 12:54:47 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:54:34 -0700
In-Reply-To: <20210929195436.1405996-1-dlatypov@google.com>
Message-Id: <20210929195436.1405996-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210929195436.1405996-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 2/4] kunit: tool: factor exec + parse steps into a function
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
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py | 44 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 66f67af97971..31eec9f6ecc3 100755
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
@@ -381,15 +379,12 @@ def main(argv, linux=None):
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
@@ -399,10 +394,9 @@ def main(argv, linux=None):
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
2.33.0.685.g46640cef36-goog

