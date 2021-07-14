Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0436B3C9446
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jul 2021 01:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbhGNXSI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jul 2021 19:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhGNXSI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jul 2021 19:18:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D0C061760
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jul 2021 16:15:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a0569021025b029055b9b68cd3eso4951127ybt.8
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jul 2021 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DqMZpra5Z3HRb0F6ypU+rLLPpHVX8T6pVPn9AM2au8E=;
        b=ofaJESsl8XfjG0V8ICG0P2YoedRTAkO26xasRPXkDyVVOt7Dw1IxYMkY32FsVtu1iu
         XzTV3h8H1rSzW8FOJKuYVjyGyyzvKa5kBX2vwMlhGcneIVOSpIBLldJ1udHVWTVh8FpH
         snmFEJqDfRJ7/wT8OhdRhbV/eUZkVlhLXbcNlWCRy4/apFPpB5O3q+LVHUHRSEH7AkjE
         MaAn1XGaqgCgF9VXQg2xF8V5jVCkcb4Yyptj3YiLKhxdqVo7/BGc4Qn6PRa6No1aaTPI
         CvgGbDr2Jd2CNdY4flP1utFxoRtfK/T39+60I3v9Idy9H5QtPo2Rlm5tXAQT75f1i9w/
         W0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DqMZpra5Z3HRb0F6ypU+rLLPpHVX8T6pVPn9AM2au8E=;
        b=nU+OqDQ8Zao0uVgD0Ma4EhoIHwq/mlAPpQGdIziYMAsd4DIzR+/JL0DhAqDeo0SaL2
         fB6+CzWTWfaB+R9uOtCOk7NgBsFzRg0E064l9cZuMcSr0dOmz6woLMKdpCfBbTL3miIO
         PEMacM9hrNax+mkEDsAqK/bxrzhsXgXWD+IlXV8KzXgCAF2pJu073YrJCXab2eHMOJh7
         n5ncOrPlCId9xI9zU/FVkbaR8u4uMh3hl5XZC+ITzGxY2/ScmpAoDfBeQXatP20c5x/e
         l1BdY100bDyUXEE+b8xz6kcXipk1wQcE9U6cAYJGSyDC2Ar9UF9F9pB5Hj2DdL/oLG8N
         K9aQ==
X-Gm-Message-State: AOAM533ZOpMOQpmM/KrpB5/jEzaSuApqSAu1inf19D8hokGq5EDjnsPk
        YCHneyKwLeaFTBN0kVU6ZIDANGEK7V9R4A==
X-Google-Smtp-Source: ABdhPJybk3UBrBC4rqlu/dHMP0SAAnOatz0g3pgP+dArk5BZpKumON9gUEfZhyQh+y2i8wrYJhFSV2UqkgpSxA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1109:2a1e:ff11:1796])
 (user=dlatypov job=sendgmr) by 2002:a25:68ce:: with SMTP id
 d197mr500955ybc.317.1626304513677; Wed, 14 Jul 2021 16:15:13 -0700 (PDT)
Date:   Wed, 14 Jul 2021 16:15:06 -0700
Message-Id: <20210714231506.886386-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] kunit: tool: add --kernel_args to allow setting module params
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit.py currently does not make it possible for users to specify module
parameters (/kernel arguments more generally) unless one directly tweaks
the kunit.py code itself.

This hasn't mattered much so far, but this would make it easier to port
existing tests that expose module parameters over to KUnit and/or let
current KUnit tests take advantage of them.

Tested using an kunit internal parameter:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit \
    --kernel_args=kunit.filter_glob=kunit_status
...
Testing complete. 2 tests run. 0 failed. 0 crashed. 0 skipped.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
v1 -> v2:
s/kernel_arg/kernel_args in documentation
---
 Documentation/dev-tools/kunit/running_tips.rst | 10 ++++++++++
 tools/testing/kunit/kunit.py                   | 16 ++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 7d99386cf94a..ebaaa2764207 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -80,6 +80,16 @@ file ``.kunitconfig``, you can just pass in the dir, e.g.
 	automagically, but tests could theoretically depend on incompatible
 	options, so handling that would be tricky.
 
+Setting kernel commandline parameters
+-------------------------------------
+
+You can use ``--kernel_args`` to pass arbitrary kernel arguments, e.g.
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kernel_args=param=42 --kernel_args=param2=false
+
+
 Generating code coverage reports under UML
 ------------------------------------------
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index be8d8d4a4e08..03f3bc406955 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -28,12 +28,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-			      ['timeout', 'build_dir', 'alltests', 'filter_glob'])
+                              ['timeout', 'build_dir', 'alltests',
+                               'filter_glob', 'kernel_args'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'input_data', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'alltests', 'filter_glob',
-					   'json', 'make_options'])
+					   'kernel_args', 'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -92,6 +93,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
 	test_start = time.time()
 	result = linux.run_kernel(
+		args=request.kernel_args,
 		timeout=None if request.alltests else request.timeout,
                 filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
@@ -150,7 +152,8 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 		return build_result
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
-					request.alltests, request.filter_glob)
+				 request.alltests, request.filter_glob,
+				 request.kernel_args)
 	exec_result = exec_tests(linux, exec_request)
 	if exec_result.status != KunitStatus.SUCCESS:
 		return exec_result
@@ -236,6 +239,9 @@ def add_exec_opts(parser) -> None:
 			    nargs='?',
 			    default='',
 			    metavar='filter_glob')
+	parser.add_argument('--kernel_args',
+			    help='Kernel command-line parameters. Maybe be repeated',
+			     action='append')
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='don\'t format output from kernel',
@@ -307,6 +313,7 @@ def main(argv, linux=None):
 				       cli_args.build_dir,
 				       cli_args.alltests,
 				       cli_args.filter_glob,
+				       cli_args.kernel_args,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -361,7 +368,8 @@ def main(argv, linux=None):
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
 						cli_args.alltests,
-						cli_args.filter_glob)
+						cli_args.filter_glob,
+						cli_args.kernel_args)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  exec_result.result,

base-commit: 8096acd7442e613fad0354fc8dfdb2003cceea0b
-- 
2.32.0.93.g670b81a890-goog

