Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF7F4763BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhLOUu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 15:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhLOUu2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 15:50:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12AC06173E
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Dec 2021 12:50:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso45455610ybs.14
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Dec 2021 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NAo1ycJu3XyEPZpDshhuC6pxi2PdRLOf6LhiLqg4ifA=;
        b=j6bkHpGQGZ5RU9UhhE+tOXjOCW8gXXPdd4zJfDHPqrHlkJYdNftVyqvh8yy5Mfn7/y
         TwsY6JIXwSvILwWwqQSvyTC9E14rmI4ZwcxqXEMFHjCtljAb7ETqh5QKWb1UV3HtmyQx
         fqCXLSduU6VSG/8PsVuFQLZcAdInI7mWbhijA6ANKu1RN9N7S+jAfodTySis75aQT9pR
         s3AjensJkNnrk7ZCZ4PV44hqRHRgss9XRMb0GeBqLJIiumX1jtnPzwFpM41qvM6qBm88
         FogRE2cv8e9dX4WKwP5FTGLvJRkDREZDiWMPJSCGy2g0i4gJ+3hDUZOeFmLxZ/c2pKJx
         4UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NAo1ycJu3XyEPZpDshhuC6pxi2PdRLOf6LhiLqg4ifA=;
        b=Dd8HA4YTTjiyN4QOr+nAMe/JdteGEWDlRFo7KSN+tE9lT76/EazD9lwdFW3ZZTHpiA
         lFHq8Uyb/ZJal9gsQ0raUxICko4CYApIkeB4mHhsedJYPd4nEF4D0sfITbXrDAEyb4dZ
         sc70ihk4nM08Jq6jxdsyeIm2m/LilalP3WXBqV0nJNlouH2YlwbUVNLtXoen5G0Z5oYV
         hODNyBMekl06HG94/bUbyedZ0g/31stScEAaxkYfqkxwuqNUXdCJE5oWHFNzhIMVeaaB
         gcJGOcmMN/4PVBwcslx4dXZuoR/O7XKYOpyGttjo9zoDqL/e+167N7noCwKNyRnvHDW9
         Qy4w==
X-Gm-Message-State: AOAM5311PmI1oV4xOeZEnmsGpY0dIPqqkQ04AzhMhPfzU+HmYnjSSiSz
        uEbK8lC69JjBOMMhyAJQB5amCFI3op6ubA==
X-Google-Smtp-Source: ABdhPJwMD6YsHXO4Rfc7WCDeo9/IZDWQB0EKqpKkQZkujkDq/NBsT+yi4a/+zjw+o066HwyXbiZ3NFwMrRgeXw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1bef:2d92:9c3e:f258])
 (user=dlatypov job=sendgmr) by 2002:a25:d4ce:: with SMTP id
 m197mr9126045ybf.194.1639601427048; Wed, 15 Dec 2021 12:50:27 -0800 (PST)
Date:   Wed, 15 Dec 2021 12:50:14 -0800
Message-Id: <20211215205014.398984-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3] kunit: tool: Default --jobs to number of CPUs
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: David Gow <davidgow@google.com>

The --jobs parameter for kunit_tool currently defaults to 8 CPUs,
regardless of the number available. For systems with significantly more
(or less), this is not as efficient. Instead, default --jobs to the
number of CPUs available to the process: while there are as many
superstitions as to exactly what the ideal jobs:CPU ratio is, this seems
sufficiently sensible to me.

A new helper function to get the default number of jobs is added:
get_default_jobs() -- this is used in kunit_tool_test instead of a
hardcoded value, or an explicit call to len(os.sched_getaffinity()), so
should be more flexible if this needs to change in the future.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
Changes since v2:
- Rebased by Daniel Latypov onto linxu-kselftest kunit branch.
  There was a trivial conflict in kunit_tool_test.py.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20211211084928.410669-1-davidgow@google.com/
- Use len(os.sched_getaffinity()) instead of os.cpu_count(), which gives
  the number of available processors (to this process), rather than the
  total.
- Fix kunit_tool_test.py, which had 8 jobs hardcoded in a couple of
  places.
- Thanks to Daniel Latypov for these suggestions.
---
 tools/testing/kunit/kunit.py           | 5 ++++-
 tools/testing/kunit/kunit_tool_test.py | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f1be71811369..7a706f96f68d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -282,6 +282,9 @@ def massage_argv(argv: Sequence[str]) -> Sequence[str]:
 		return  f'{arg}={pseudo_bool_flag_defaults[arg]}'
 	return list(map(massage_arg, argv))
 
+def get_default_jobs() -> int:
+	return len(os.sched_getaffinity(0))
+
 def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
@@ -332,7 +335,7 @@ def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
-			    type=int, default=8, metavar='jobs')
+			    type=int, default=get_default_jobs(), metavar='jobs')
 
 def add_exec_opts(parser) -> None:
 	parser.add_argument('--timeout',
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b80e333a20cb..352369dffbd9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -527,7 +527,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
-		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
+		self.linux_source_mock.build_kernel.assert_called_once_with(False, kunit.get_default_jobs(), '.kunit', None)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
@@ -633,8 +633,9 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_build_builddir(self):
 		build_dir = '.kunit'
+		jobs = kunit.get_default_jobs()
 		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
-		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, build_dir, None)
+		self.linux_source_mock.build_kernel.assert_called_once_with(False, jobs, build_dir, None)
 
 	def test_exec_builddir(self):
 		build_dir = '.kunit'

base-commit: 1ee2ba89bea86d6389509e426583b49ac19b86f2
-- 
2.34.1.173.g76aa8bc2d0-goog

