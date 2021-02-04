Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE230F9D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 18:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbhBDRez (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 12:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbhBDRcu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 12:32:50 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8004C061222
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 09:31:00 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id v130so3262830qkb.14
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 09:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uAmCYhAQV4UKau9nAZmt7fCkOD0B6TnSTE34tccNud4=;
        b=QJEswYnd7k0toB/opLES3Mv4vKb54wLk5YUbLCj/O3BV5QUC/dN1OMWUvnhJ1zp8g0
         2AdAhG758G7mB94t3M/joe5g0tJe8LjCeu4dPGJVULgT8LkGYcOanHTaJt4ZFO8gFPzT
         K5nDcgeQhxn8+MzIRN+xZMU7P+i/yEflxiwYRqRRCTG21UFsQTotaeRKev3XIl+hnWd1
         DW3KFSW6UbLBii26fRdtcQ5o99U/7gA6Ch4JC6S5DPj1xJQOJgZDg0irUaD+IwZ5BqRX
         vwKqiMqp8aVIPrfQEGCKyb9aGGGwS0rkzYI8zyb57gbDFEbADfesqRAsLzN1GXffBi/n
         DIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uAmCYhAQV4UKau9nAZmt7fCkOD0B6TnSTE34tccNud4=;
        b=Q3Iopju85KNtQMPtZlDLQAP6slU4zaeh/g+6G4Nb+dDAcndywQ+wUHAo8FbHYcO5Ev
         Q3/3K1v+vM5hkR+sJqgood9pCS5PEM+cJhwUKqG//P2V/1OUEV4b+03LPQnYHNSahy+M
         wfsQctU4M7rkMA2iO1eChmCqqllkClgwqpJ2YVgSO+38diopap4AxU4Bf8r8pxla+QVg
         /m/c/VVcXZQX6hLhc7RTSUaCYF0HCL9CMVGG6YVg2bCIrDZtBDZ+Z3M1Erb8vYEVZn4o
         WVEihXhZNP776NYBrT3g6vtLiH/katJmMOZQpHbL+GZGUyjJnn/5b9MISsQRciqrbDXO
         gDlA==
X-Gm-Message-State: AOAM530P/iPd2xPW5JS+Dn6Jg09CZIIPW2McuQ5Zw6twL8+YjZohrUcP
        UQT2FkmTykv34ZXWUwJ6k6slRqsl7hOsKw==
X-Google-Smtp-Source: ABdhPJx3GPlLW1cdm0/nPbgAAqmd0IukKPpxRFkbKEDI5vkAjIpEML35GGxVDteQIJtc1Wo5QTqNADgtIsuf7g==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:ad4:5981:: with SMTP id
 ek1mr287773qvb.48.1612459859841; Thu, 04 Feb 2021 09:30:59 -0800 (PST)
Date:   Thu,  4 Feb 2021 09:30:44 -0800
In-Reply-To: <20210204173045.1138504-1-dlatypov@google.com>
Message-Id: <20210204173045.1138504-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210204173045.1138504-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 2/3] kunit: tool: add support for filtering suites by glob
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
2.30.0.365.g02bc693789-goog

