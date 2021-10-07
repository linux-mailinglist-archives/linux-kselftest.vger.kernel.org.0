Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74491424CDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 07:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhJGFqM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 01:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240158AbhJGFqL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 01:46:11 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85325C061755
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 22:44:18 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r13-20020ac86d2d000000b002a755d36425so4237781qtu.14
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 22:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mIj9Jk5MgblNz5q9sG/zsQIq+TdmIYSKr+8KbGGg5VE=;
        b=gX6kWtp+Nh3tQGqYQ1MPA9e4Ad0JzGcIBSHXfkqmZoxq2JdwiIwlVfYgj0DvVyd9EW
         H8OjRrcPU9SNcs0Yc1JQ3TDB1zM4Z0BOkuGVcfMsLzH/hbcPwOGcgvW7A0V4Jb1Cy1DE
         Ps2O3+AA/DJLYpr4AmxWBYrStgZmz8lRTrgT8wCQXau30kp8DR894ItWMo9k+ZVutguQ
         jXEqjdLXCQYgp8bLib57u7ZrFC63WKkh33JMn8GcZLLnKmQmA66kI7vWDXtHkVW2sSPd
         roWw9MINXGyXpNbGO+FzRt+8rnLywLnKY04Kc7NPPRvWnySgiJs08v1YZcnrlIXTbMe5
         3rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mIj9Jk5MgblNz5q9sG/zsQIq+TdmIYSKr+8KbGGg5VE=;
        b=saDLn+RQngzPFCvWV8/bg/wGjL+fj/vUVO7ZwdTchSscj+3KjmLZhq3pJw/8G9HZZJ
         6KmrHQfScAvQ40FMvJf5OWsTsr6k7HNVUJ+Km2IM5Vpj3Elx9+f8mqjEpa+MTPyLRpPX
         wRynNHfgARexBMAsbmTKVk3GCFxw2B6pzr9O99joSDS977UznjaJ7RkR1dXkC6qyiM3I
         V+LkRcn6MT7JzKYfUxZhgtTjwsXBDN3hy3fPImwi8Sz0+8IxATcu/est4cUHYboyFILi
         fl8ClEmHM7UfnwMUVzimIvPbsA83bY2nopCH1F9zQMEmO9Pifd/yFVDw28I+AUxeWVU9
         zoWg==
X-Gm-Message-State: AOAM53330R39b1EXpPV1E25e4UNMwTjR/CAJTHysvRQN9j4WlmTUZDf7
        PPttMZDQJ4dbAOdklZn+Tr6GY30uSq+z8g==
X-Google-Smtp-Source: ABdhPJxaY1Kcgps6yP1EX2w3aIMgCkcw1hNuPT2VdXBWMBaTmNqUIXtOR+JykXPwaG2BrpMzLEhFME23e7+ZnA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e436:7947:9f25:884c])
 (user=dlatypov job=sendgmr) by 2002:ac8:7cba:: with SMTP id
 z26mr2669082qtv.11.1633585457632; Wed, 06 Oct 2021 22:44:17 -0700 (PDT)
Date:   Wed,  6 Oct 2021 22:44:10 -0700
Message-Id: <20211007054410.290427-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] kunit: tool: print parsed test results fully incrementally
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the parser rework [1] and run_kernel() rework [2], this allows the
parser to print out test results incrementally.

Currently, that's held up by the fact that the LineStream eagerly
pre-fetches the next line when you call pop().
This blocks parse_test_result() from returning until the line *after*
the "ok 1 - test name" line is also printed.

One can see this with the following example:
$ (echo -e 'TAP version 14\n1..3\nok 1 - fake test'; sleep 2; echo -e 'ok 2 - fake test 2'; sleep 3; echo -e 'ok 3 - fake test 3') | ./tools/testing/kunit/kunit.py parse

Before this patch [1]: there's a pause before 'fake test' is printed.
After this patch: 'fake test' is printed out immediately.

This patch also adds
* a unit test to verify LineStream's behavior directly
* a test case to ensure that it's lazily calling the generator
* an explicit exception for when users go beyond EOF

[1] https://lore.kernel.org/linux-kselftest/20211006170049.106852-1-dlatypov@google.com/
[2] https://lore.kernel.org/linux-kselftest/20211005011340.2826268-1-dlatypov@google.com/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 22 ++++++++++----
 tools/testing/kunit/kunit_tool_test.py | 42 +++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index f01fd565f978..82900a5f9ad6 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -172,42 +172,51 @@ class TestCounts:
 class LineStream:
 	"""
 	A class to represent the lines of kernel output.
-	Provides a peek()/pop() interface over an iterator of
+	Provides a lazy peek()/pop() interface over an iterator of
 	(line#, text).
 	"""
 	_lines: Iterator[Tuple[int, str]]
 	_next: Tuple[int, str]
+	_need_next: bool
 	_done: bool
 
 	def __init__(self, lines: Iterator[Tuple[int, str]]):
 		"""Creates a new LineStream that wraps the given iterator."""
 		self._lines = lines
 		self._done = False
+		self._need_next = True
 		self._next = (0, '')
-		self._get_next()
 
 	def _get_next(self) -> None:
-		"""Advances the LineSteam to the next line."""
+		"""Advances the LineSteam to the next line, if necessary."""
+		if not self._need_next:
+			return
 		try:
 			self._next = next(self._lines)
 		except StopIteration:
 			self._done = True
+		finally:
+			self._need_next = False
 
 	def peek(self) -> str:
 		"""Returns the current line, without advancing the LineStream.
 		"""
+		self._get_next()
 		return self._next[1]
 
 	def pop(self) -> str:
 		"""Returns the current line and advances the LineStream to
 		the next line.
 		"""
-		n = self._next
-		self._get_next()
-		return n[1]
+		s = self.peek()
+		if self._done:
+			raise ValueError(f'LineStream: going past EOF, last line was {s}')
+		self._need_next = True
+		return s
 
 	def __bool__(self) -> bool:
 		"""Returns True if stream has more lines."""
+		self._get_next()
 		return not self._done
 
 	# Only used by kunit_tool_test.py.
@@ -220,6 +229,7 @@ class LineStream:
 
 	def line_number(self) -> int:
 		"""Returns the line number of the current line."""
+		self._get_next()
 		return self._next[0]
 
 # Parsing helper methods:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index c309ed76aef5..3cb02827c941 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -13,8 +13,9 @@ import tempfile, shutil # Handling test_tmpdir
 
 import itertools
 import json
-import signal
 import os
+import signal
+from typing import Iterable
 
 import kunit_config
 import kunit_parser
@@ -320,6 +321,45 @@ class KUnitParserTest(unittest.TestCase):
 				result.status)
 			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
+def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
+	return kunit_parser.LineStream(enumerate(strs, start=1))
+
+class LineStreamTest(unittest.TestCase):
+
+	def test_basic(self):
+		stream = line_stream_from_strs(['hello', 'world'])
+
+		self.assertTrue(stream, msg='Should be more input')
+		self.assertEqual(stream.line_number(), 1)
+		self.assertEqual(stream.peek(), 'hello')
+		self.assertEqual(stream.pop(), 'hello')
+
+		self.assertTrue(stream, msg='Should be more input')
+		self.assertEqual(stream.line_number(), 2)
+		self.assertEqual(stream.peek(), 'world')
+		self.assertEqual(stream.pop(), 'world')
+
+		self.assertFalse(stream, msg='Should be no more input')
+		with self.assertRaisesRegex(ValueError, 'LineStream: going past EOF'):
+			stream.pop()
+
+	def test_is_lazy(self):
+		called_times = 0
+		def generator():
+			nonlocal called_times
+			for i in range(1,5):
+				called_times += 1
+				yield called_times, str(called_times)
+
+		stream = kunit_parser.LineStream(generator())
+		self.assertEqual(called_times, 0)
+
+		self.assertEqual(stream.pop(), '1')
+		self.assertEqual(called_times, 1)
+
+		self.assertEqual(stream.pop(), '2')
+		self.assertEqual(called_times, 2)
+
 class LinuxSourceTreeTest(unittest.TestCase):
 
 	def setUp(self):

base-commit: 9b409050eaf2da929408fa60fbf535745d828e67
-- 
2.33.0.882.g93a45727a2-goog

