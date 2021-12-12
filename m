Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E42471805
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Dec 2021 04:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhLLDcl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Dec 2021 22:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLLDck (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Dec 2021 22:32:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58028C061714
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Dec 2021 19:32:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so24244042ybe.8
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Dec 2021 19:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dZXz4L70xn3lGuV5frFMNTxVjlcyPDah4Fe8iWASoU0=;
        b=ODrEmf+TvM3S31nOwniA9E7e2YSVuUd0Ow0kybNHJhTVYDFsk20j6mE0HE20VPcjbB
         ioQsD76gcn90TooKKhlALlkcM4Mjp1ypliTkQvrgmY9rNnDwVrDeCUrAFL7DcWHp5moz
         XsuZyJM25llg6xz8bm94/u/17PXql9zmF+oZC1k+2OgrZrxVlV7LMAjY8x2tg4dD1lG+
         RPHInHH8LZYRRR5autOkRHC9ZJExESXts1xcgX5S2HiM5jkuJwRIkTF69UFWgqWxEEy7
         GWdfYPSGePLYr8qluxCzLFxPqmhEu+AmVnZL7uv/9J7l9oX1oIKopXo/QF9OgHnwxLrc
         kQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dZXz4L70xn3lGuV5frFMNTxVjlcyPDah4Fe8iWASoU0=;
        b=Qx1/kshw36p9wOGiJ2cVeEiqqTUhI+K7T1Jh36Xicay2Ayn1sbNvuTF0NczMVwGfSj
         LKVjXby0uOgYs8m5plcVOgDYEnwA7kCXLDhL4rPXZ7jNH6o+x9IDWOJHlVrVF4G7dQfP
         1x0JeYkCelC4Qq1zFI5HpAQHMB7oPXR4BmqvwO9CTyETceTLuPcPlB9zl5H5YXAfyI0u
         Srw0Emzrk3B5my+37TfNsngqDniGp35gUP2DrJJULLcYn/oZHniQ+WQHOcRkodDkCXX1
         bT9V40C2D6thl4FAZAdlmvcN4dZf8cJ/98zuSCSZLQgCmnPPRlzjpvtBKbLM8mT6na0O
         gMKA==
X-Gm-Message-State: AOAM531mqEZGudbrGctYphoHTHV4Qgzn0ha65W46ThAgFsaSkyfrrdJ5
        8rhpArc7g3UaO/vjy/2J4u6ZfmDC9nXWwQ==
X-Google-Smtp-Source: ABdhPJxhjs+gPvF0lVNaW8OuZQN/SGmvvq6ktiwYxHZUR+1Sc0QW2sntANY7vGVdd14wQi8NPzuuoHQOuSHZaA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:1344:: with SMTP id
 65mr24017421ybt.468.1639279959504; Sat, 11 Dec 2021 19:32:39 -0800 (PST)
Date:   Sun, 12 Dec 2021 11:32:29 +0800
Message-Id: <20211212033229.527955-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2] kunit: tool: Default --jobs to number of CPUs
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
---

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
index 68e6f461c758..6b0ddd6d0115 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -264,6 +264,9 @@ def massage_argv(argv: Sequence[str]) -> Sequence[str]:
 		return  f'{arg}={pseudo_bool_flag_defaults[arg]}'
 	return list(map(massage_arg, argv))
 
+def get_default_jobs() -> int:
+	return len(os.sched_getaffinity(0))
+
 def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
@@ -310,7 +313,7 @@ def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
-			    type=int, default=8, metavar='jobs')
+			    type=int, default=get_default_jobs(), metavar='jobs')
 
 def add_exec_opts(parser) -> None:
 	parser.add_argument('--timeout',
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 9c4126731457..512936241a56 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -419,7 +419,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
-		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
+		self.linux_source_mock.build_kernel.assert_called_once_with(False, kunit.get_default_jobs(), '.kunit', None)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
@@ -525,8 +525,9 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_build_builddir(self):
 		build_dir = '.kunit'
+		jobs = kunit.get_default_jobs()
 		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
-		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, build_dir, None)
+		self.linux_source_mock.build_kernel.assert_called_once_with(False, jobs, build_dir, None)
 
 	def test_exec_builddir(self):
 		build_dir = '.kunit'
-- 
2.34.1.173.g76aa8bc2d0-goog

