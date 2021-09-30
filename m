Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5741E3C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 00:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbhI3WWl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 18:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbhI3WWk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 18:22:40 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED91AC06176A
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:20:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i16-20020a05620a249000b004558dcb5663so14899855qkn.9
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z6dVUuB/preBAw36L3iIbKM/7YhV1FOdhtHcIIfrVic=;
        b=ULi4LhqTk8zMBfs13R14ymGCfISY4HCN8+7jauN/grgOxCjlJkXf9mhboF8zEufzGI
         lZadeKsHjAqxwlcdZUh7Bho6EvktousLU/nxqjsCC+XtCx7KGU4nr3Ru2MOz47/nXVbj
         abjvQ8yEF9TiS4weUFLanEKRxJPnWWniQgdWMlO3/TTZul5gShF7gd+7L2NjQyVdzXv9
         FAgfCkIIEGJ7hmN0XnkH/xHg1Rlu3h5lMMbE+FKwhP640FF3VGpeY0YyoJuxrVBnXL77
         s9uvyij4sgcjlX0+CDvQgNakZr198jHnW+WnrrMqW2R7mFCBNOFcLvk5TBErcJ2V3i0H
         nnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z6dVUuB/preBAw36L3iIbKM/7YhV1FOdhtHcIIfrVic=;
        b=0YaBZgX66bhbxQhFEJWm7ik+TcfpL4LO2xl4Ogtk6xrdR8BUjVKp9raZ2wGMXTeG42
         OhBKU7MQUgL4ScI2SXB0UhVfx63+xkQ4MGfLeY3JZQs8icN1wwnTl5oUmdbdMWDRI75S
         MUHqSErLkUMNp1+b8LhvsBCoCozZTnoGSJ0hIXZ1rdfo8mwPSgwhpgo/a4Odqbly1kx9
         U0i+yUGnzjwkIwrvtUOvFc3QiSeQLh8NYBjKg4qjXKa7uGUJnwKBTBzbRlp9+7vi9zKL
         T3fZqhnslbeOTUphTaCPKgKgMRt3+kBwcXjdJeSA9et5TO0UAjHyRjuym49F4cgT0nb2
         jsZw==
X-Gm-Message-State: AOAM531yeOC5gpOCNQpFQWA3y3h4D1GGThL+nWNftqEkHLjKYL9fMPTi
        AbQo3tINz6uJMGLHcNiee11PjZlMCqrteg==
X-Google-Smtp-Source: ABdhPJy6zY9uLdr9/RnVJSpYxSgY0fyfYbNRel8JWj8su/esWhnAwm5ny7U8RYI+5wbtLcsMpyuZIryAivYdGg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:39fa:d88:fb3b:880e])
 (user=dlatypov job=sendgmr) by 2002:ad4:5aa4:: with SMTP id
 u4mr6334829qvg.62.1633040456209; Thu, 30 Sep 2021 15:20:56 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:20:46 -0700
In-Reply-To: <20210930222048.1692635-1-dlatypov@google.com>
Message-Id: <20210930222048.1692635-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 2/4] kunit: tool: factor exec + parse steps into a function
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
2.33.0.800.g4c38ced690-goog

