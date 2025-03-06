Return-Path: <linux-kselftest+bounces-28362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205AA53F20
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 01:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D4918868A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AD17BA9;
	Thu,  6 Mar 2025 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmTNL66w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF142B652
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220988; cv=none; b=CKPH9Mx3bmlgfHa6DfDsaaUDaNPLF0WIccfLbnNp7RGF8akpTLIGyuXY0kQrJCe2miG4qZbNgHNinnnoS7/tedldcMj3kUo+Zstv7AKsDh5BjX8IXojkuY6uIQ3QPWNcwancgvX8B816mgr9h9APG2lNMsSMB1iHwPRFLYNknTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220988; c=relaxed/simple;
	bh=ziq0xBIus4AsP0MAEhRZlaF5Q0/wNBHEHmE1QRquNaw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lQYS+Du8HY0rGMoV6nNRUN7Z8YbLb1bp1QBU+1cgiye+82Ou4EqNawOXvsYaPdJeXIiWtOrcK5ShO/sfRdvS7vUjB5gUV20rIY5KoPsOLgrr9oOt+lVu7+DTjiKdj/pqpNFRzhN4cpYuacDnlRA2p/raXjvMmKY+vH8L6YAgmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmTNL66w; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-47506816e5aso1277021cf.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 16:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741220985; x=1741825785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6xhsSPxuSohpJxu6VEhaDPeanwnvjNd7JZQ1spnJKlE=;
        b=CmTNL66wtXj5HThDh7rK8ybjeIYSmUq7Qc9KMpFuThDIDqP0gKuP4ZW8AAL7doWByk
         KwHejYM0oZfqkC0oFLvNjTbM2L2FFk/i4yhayzMx0sysWVekaiX5I3vT84q1d6ddSPuY
         f12XkFV8y/mABR1F6lFAPUTlWQaIlHn188MingNAALk8K14T/01/iyufDw8Wp0lma4yd
         L6iFl5/24GwttvEX5T1ElCX/q629JEHRiHm/BcFYoU8AArPOjck01IGTtUDULluoiEKt
         X9qtce45krY0JYubP6qh4XoFQkqNsX0On4pvt5b0fH1QlOZ5uIxccUnGLJj3+9yCEIUt
         AmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220985; x=1741825785;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xhsSPxuSohpJxu6VEhaDPeanwnvjNd7JZQ1spnJKlE=;
        b=EpRVjnWFtyIOOuDBwqBfONlE4y7BnTrAzmmat8uIbhERsziBRFOwKpT4n1sucWq41a
         OhWM/h1F/n7HRhlGjdPS5ekhXUM0MvdaCpGUf4EnGLlX1HnPk0M/Dg3xSTqPJ/LU1qzk
         +0NoP0oA/OQ9SNOT2rGHZ2tFUYHuArCsGvYyn4JqGU/IRw6ZM2Qws6n4SPpN6mttRL32
         kFCO8fOOdhQ04BCTAmBn7Gk6cWTS+bH0i8zLkm/ue/Odau/yrkRLt+r7hYOmBr/hU6PC
         S7JmECuuiPhaEcAcRPX9LTSQ9Un+XYd2F3QMKecOKWl6hWeQq4HdcVAnEbsGZfNeAET6
         vr0w==
X-Gm-Message-State: AOJu0YyF4hpjE62JKvNsMBq8h+mBXfED+RmtDu1Os8t38JCcQcDp044/
	hGI0RJ/OHFeMev7XgDz+nASYTROCpK9zrWOf+1TCtJaiW9fBy+anYaDysAAFThSXvWVNKLIw1A=
	=
X-Google-Smtp-Source: AGHT+IGQjNo4lN1P5zRh1fyBQsEtXPbc2Ycfqs8s5lHQF6PgzcuYgO0wVNg9KhbJjX9tsH4zw+AK64EGJA==
X-Received: from qtbfx7.prod.google.com ([2002:a05:622a:4ac7:b0:474:e6e7:bab8])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:394:b0:475:74c:c874
 with SMTP id d75a77b69052e-4750b43d325mr81781871cf.21.1741220985719; Wed, 05
 Mar 2025 16:29:45 -0800 (PST)
Date: Thu,  6 Mar 2025 00:29:33 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306002933.1893355-1-rmoar@google.com>
Subject: [PATCH] kunit: tool: Fix bug in parsing test plan
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, jackmanb@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

A bug was identified where the KTAP below caused an infinite loop:

 TAP version 13
 ok 4 test_case
 1..4

The infinite loop was caused by the parser not parsing a test plan
if following a test result line.

Fix bug to correctly parse test plan and add error if test plan is
missing.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 12 +++++++-----
 tools/testing/kunit/kunit_tool_test.py |  5 ++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 29fc27e8949b..5dcbc670e1dc 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -761,20 +761,22 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		test.name = "main"
 		ktap_line = parse_ktap_header(lines, test, printer)
 		test.log.extend(parse_diagnostic(lines))
-		parse_test_plan(lines, test)
+		plan_line = parse_test_plan(lines, test)
 		parent_test = True
 	else:
 		# If not the main test, attempt to parse a test header containing
 		# the KTAP version line and/or subtest header line
 		ktap_line = parse_ktap_header(lines, test, printer)
 		subtest_line = parse_test_header(lines, test)
+		test.log.extend(parse_diagnostic(lines))
+		plan_line = parse_test_plan(lines, test)
 		parent_test = (ktap_line or subtest_line)
 		if parent_test:
-			# If KTAP version line and/or subtest header is found, attempt
-			# to parse test plan and print test header
-			test.log.extend(parse_diagnostic(lines))
-			parse_test_plan(lines, test)
 			print_test_header(test, printer)
+
+	if parent_test and not plan_line:
+			test.add_error(printer, 'missing test plan!')
+
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0bcb0cc002f8..e1e142c1a850 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -181,8 +181,7 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(
 				file.readlines()), stdout)
-		# A missing test plan is not an error.
-		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=2))
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 
 	def test_no_tests(self):
@@ -203,7 +202,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.subtests[0].subtests[0].status)
-		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=1))
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=2))
 
 
 	def test_no_kunit_output(self):

base-commit: 0619a4868fc1b32b07fb9ed6c69adc5e5cf4e4b2
-- 
2.48.1.711.g2feabab25a-goog


