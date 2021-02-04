Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F23310061
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBDWzm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 17:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBDWzj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 17:55:39 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10B7C06178C
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 14:54:58 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id nm1so2902222pjb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 14:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=M0j63Y+dGrapku6v2TeatocmD7eQzHpeOBCsoHcCmr8=;
        b=ZTYXSsgggGJz5jGj8p6Ols2kXiqqWJ7Hf1B/onFHGGkZxzizQdPOQQv7QnZXz7i57R
         f59xM0Pb19jW1IkNItgm1FtQ1HzlPWrizu/VriIAAWZ+R4UW/MqRMKGmAGByCJKdCcMW
         YWY9i+HbzqrS1Mw3QwvE6eRFZHJqrMpiZJmNKtVbQDdbaI2ceY7dE6bSe5R9nO0Y/W90
         L6D2d/KnrPj/2Qj1NOmWZzUulbybc4a06iqPmnsvmpC7SMW21WE4UAePOGjjcdGknwsB
         T664uNXsY8Qje7+o/NfqkwBfK7cHq8heh2tep/KhoKV2aAjryzhG/GZZsRjeipovKgnq
         lYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M0j63Y+dGrapku6v2TeatocmD7eQzHpeOBCsoHcCmr8=;
        b=ZEIbLrZuRj6J7m4O+hGjE1yWgLpacKqKLJPLX84OSFADHPDI1e7Ep4d0V7EZzVv+py
         6LNbvI84J4wlcgebs4b620iybOa3SGU34DuQC7KBwRSbCMfC2CMfB2psLgdNZTNCvjgp
         tUFLB0L6/lnUUO3HLFak+x77qJHnYsz/gBREEPlWRWyarjzeTQ4bXH8mbUtMahYQC84Z
         uhdStQ/9dbOR1o1LikH4C+ICnvNl5nfIC/m68lf1ZO4r0S7Q/4V7Rs4q40W4q5ECRUGj
         2j0v644SRsnFYJFQnEAyife0lPuFZlMIlj7XPs49+KsMlVe1WPMuzns5wp1Xyg806hIC
         OAmw==
X-Gm-Message-State: AOAM531QeI1/w2Yg+f8cuATncoaDdsM/KlgErGbR8obLDtckfcuQgN3q
        JUbRBfBeBHeMhHcG0u+WC+YXh0+J024FiA==
X-Google-Smtp-Source: ABdhPJzGDJJb99I4uPs0OtacvEjb+GqAyjJeAQCifyLhXhsh82fYNZkotlFKA2eeDEt/b2U2ya+6tJl85WcLUA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:aa8a:: with SMTP id
 l10mr1274505pjq.86.1612479298500; Thu, 04 Feb 2021 14:54:58 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:54:47 -0800
In-Reply-To: <20210204225448.1393741-1-dlatypov@google.com>
Message-Id: <20210204225448.1393741-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210204225448.1393741-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 2/3] kunit: tool: add support for filtering suites by glob
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows running different subsets of tests, e.g.

$ ./tools/testing/kunit/kunit.py build
$ ./tools/testing/kunit/kunit.py exec 'list*'
$ ./tools/testing/kunit/kunit.py exec 'kunit*'

This passes the "kunit_filter.glob" commandline option to the UML
kernel, which currently only supports filtering by suite name.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 21 ++++++++++++++++-----
 tools/testing/kunit/kunit_kernel.py |  4 +++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e808a47c839b..a15ee33bb1f5 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -28,12 +28,12 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-			      ['timeout', 'build_dir', 'alltests'])
+			      ['timeout', 'build_dir', 'alltests', 'filter_glob'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'input_data', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'alltests', 'json',
-					   'make_options'])
+					   'build_dir', 'alltests', 'filter_glob',
+					   'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -93,6 +93,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,
 	test_start = time.time()
 	result = linux.run_kernel(
 		timeout=None if request.alltests else request.timeout,
+                filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
 
 	test_end = time.time()
@@ -149,7 +150,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 		return build_result
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
-					request.alltests)
+					request.alltests, request.filter_glob)
 	exec_result = exec_tests(linux, exec_request)
 	if exec_result.status != KunitStatus.SUCCESS:
 		return exec_result
@@ -197,6 +198,14 @@ def add_exec_opts(parser) -> None:
 			    type=int,
 			    default=300,
 			    metavar='timeout')
+	parser.add_argument('filter_glob',
+			    help='maximum number of seconds to allow for all tests '
+			    'to run. This does not include time taken to build the '
+			    'tests.',
+			    type=str,
+			    nargs='?',
+			    default='',
+			    metavar='filter_glob')
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='don\'t format output from kernel',
@@ -263,6 +272,7 @@ def main(argv, linux=None):
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.alltests,
+				       cli_args.filter_glob,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -304,7 +314,8 @@ def main(argv, linux=None):
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
-						cli_args.alltests)
+						cli_args.alltests,
+						cli_args.filter_glob)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  exec_result.result,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2076a5a2d060..71b1942f5ccd 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -199,8 +199,10 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', timeout=None) -> Iterator[str]:
+	def run_kernel(self, args=[], build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		args.extend(['mem=1G', 'console=tty'])
+		if filter_glob:
+			args.append('kunit.filter_glob='+filter_glob)
 		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
 		subprocess.call(['stty', 'sane'])
-- 
2.30.0.478.g8a0d178c01-goog

