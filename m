Return-Path: <linux-kselftest+bounces-29465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7DA69C18
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 23:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE137A3128
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 22:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE4216E01;
	Wed, 19 Mar 2025 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klPZ2fpW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492451DD889
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423638; cv=none; b=PKuGUdVL4UvM+xTx/twfzvOuguC1cn2e59ee3oIQMCsXas3TTs3PwYL+RrrTHfrw7Ysxh+bmCgaE4p/uAhhudJOZ5ibtSNrsNhBdpkGozUlFq1c0CZICeMqxnxlmxOVE1IjLlwjuGJNevMXeOmIvg5MtkkECiCrVoYa86EJs5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423638; c=relaxed/simple;
	bh=mAw0ZqLyiCoZH8VesbHgz3Uo62i3I75t/54lqWtHLbI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JROIIXe2Czyhc9bd/OW17ESorEAtyfwaNw/h5/byqF0K8M2jACOXkkYfxmuJjs1nzGaBnY7bLlp4efgGA9Tmuh/O/2Qf+GnKs8dnVZfHkhG8piAdUBeVQpusVVHrXKb3BHFOXas6/ikRejphTyubS4OhdXZP9RMltXFcl5vBiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klPZ2fpW; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c54e9f6e00so230529785a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742423636; x=1743028436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4C+KM7i+5msFmhxzSya6NuHf1KqUp3SPPWG0X4qbCm4=;
        b=klPZ2fpWIThmuIg6fPnpK3HBw2Bde2ventAr1ty3vctNpCkZ+vzDD2BwZ3lDyIppBf
         M7i8bgLWFq1q2VHwhKbdvatSefewcNuwSCU+dPIgSXIrHTI3T/duhl6YF3FYVJAR9Dzc
         vpgWB2wicQQ7Ay22bdjHJ17qLZK7kZ3NTGohwqEBghQfQ36eoPTX8Z2zuTNRmWuFOvCQ
         xEC6EMVCYNG5zCR42E8uYejeUgv1Mjrxltm7uAkC5vx3C0oyzB41mgXb30GfpSmuZvq3
         EfNrd/fL1IPFUIadM7Z6evx9nSBYs/nsIBxcjj5pHcz6nBKcQ3P0j80nHWzF2WQvOfKS
         W8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423636; x=1743028436;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4C+KM7i+5msFmhxzSya6NuHf1KqUp3SPPWG0X4qbCm4=;
        b=Mdehvx6YDAWjHpd/QcZc4zDmnAtYZT5LS++UH7pRRPQ3nPuZbPOev2flHqXea8N7pq
         jLgiv8IVxf700pjSnuPuOLQOTUX7+8UkfqPZF7n1BQzv/wLiUirs3e3jrD57NK9HjB4T
         sWUQryEbU8FohbGMqnurXvE0b8sGR3jWhQxQHF08hLCldZLO08aBIyceWaU/qPYDlmbK
         OODTT8Cvg5v1mL6u19XhFpZni6syiOMD92nu8ZzYMVPeOLmDg4uGHS/DNtPhnOwSF8Zv
         nLXiDqY+pQGREfE+KiD10GUFjQ0qZ09Qpd02XV4DUC651ca4gGre9kmxEfz56YGtY0gc
         +lcg==
X-Forwarded-Encrypted: i=1; AJvYcCWDxkpmj4sGhwKTw9Cb8pXNnpzCcNxfYj72yyJ/pZ9DY2FRkAz9L7qtiiSyrHUSnpDjUTxvngpjraYlPk3v7B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgGcNgVeTyE60OdZMIfNrM0X5y3patEOFyCEMqZ8f5MCLFgmy
	efbCvIOgNSw03Ok0Svpbx70l/i1HDLP+dT5Wlsc4DlWCyOIrYyq68IPyMqm+v8nHqAV0df5Psw=
	=
X-Google-Smtp-Source: AGHT+IGgY6Pywck8gcnGUljLZeNyCEzuS5WpPE6KmbgsB+SQUpG+8SqJTA5d2qQJratKJKjIajld0MC0dw==
X-Received: from qknrv15.prod.google.com ([2002:a05:620a:688f:b0:7c5:496d:d669])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:318b:b0:7c5:a20f:a091
 with SMTP id af79cd13be357-7c5b04e1f5fmr202494385a.2.1742423636221; Wed, 19
 Mar 2025 15:33:56 -0700 (PDT)
Date: Wed, 19 Mar 2025 22:33:51 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250319223351.1517262-1-rmoar@google.com>
Subject: [PATCH] kunit: tool: fix count of tests if late test plan
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com
Cc: jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix test count with late test plan.

For example,
  TAP version 13
  ok 1 test1
  1..4

Returns a count of 1 passed, 1 crashed (because it expects tests after
the test plan): returning the total count of 2 tests

Change this to be 1 passed, 1 error: total count of 1 test

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 4 ++++
 tools/testing/kunit/kunit_tool_test.py | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index da53a709773a..c176487356e6 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -809,6 +809,10 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		test.log.extend(parse_diagnostic(lines))
 		if test.name != "" and not peek_test_name_match(lines, test):
 			test.add_error(printer, 'missing subtest result line!')
+		elif not lines:
+			print_log(test.log, printer)
+			test.status = TestStatus.NO_TESTS
+			test.add_error(printer, 'No more test results!')
 		else:
 			parse_test_result(lines, test, expected_num, printer)
 
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 5ff4f6ffd873..bbba921e0eac 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -371,8 +371,8 @@ class KUnitParserTest(unittest.TestCase):
 		"""
 		result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
 		# Missing test results after test plan should alert a suspected test crash.
-		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
-		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, crashed=1, errors=1))
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=2))
 
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))

base-commit: 2e0cf2b32f72b20b0db5cc665cd8465d0f257278
-- 
2.49.0.395.g12beb8f557-goog


