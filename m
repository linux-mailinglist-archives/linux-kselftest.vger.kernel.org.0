Return-Path: <linux-kselftest+bounces-28423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62867A554DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 19:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D844F3B763A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95027425F;
	Thu,  6 Mar 2025 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvxewfJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333227183A
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285217; cv=none; b=ZoiH3H+VTQSNBOZ2zYLUW69aihCvY8SRddM8OwLc7ftBb6Eg34N9WySFJkTV6ztBpeEM/gH00+LvlmFVUdf06ptfybWEIKgUSXzSRP/bF72jvQqt78tfW4uqHC76sEt5MmXtQSbjEM6OWAEiGFqbKjXM3cczG1CBI31kY+Fn+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285217; c=relaxed/simple;
	bh=4VuzvYvLcN6dJPQ8n675nSqrtosRx5EBY2qJGYXH/ro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rfr8K5Ad+xw6k6mQJ5Az329bUhd9VFzNBiBHbo2hYkdjXck3wLQyYtkd1Y4lml1czVKwsRPUPcyDa0bGJUB9oDq2ByJLlXkmbrwiwvHcDxFfghp/YhD2/t88w0d5rEOKIJ9I46BA4C70qPozPZuGKXTX/JTHbk081vk8d321+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvxewfJZ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-474f079562dso31795501cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 10:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741285215; x=1741890015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kOXNDTF2vrh5uDiXj9TnU3A+yLNXaCYv0mbF7Mtjths=;
        b=dvxewfJZslxNOdhnlRUtPhvXrlJ0Oivq0SPYtWUmxRIUQdhJTKTdW14+sVEn1OoWB4
         s4BVjci44rGlIm31woq+MBsuh+7sTsGvSKI/myE608Gdkri6A4YU+OPUoRSynzsH637z
         8TTAR6ZwA/aYW4clpGJPtjjRECxTFKQgtJKwIBsuBdSifHauD1qjWo8VrlClRZM1RfU/
         +36D1GNu8ESsyun1rzjqqyqUTK2YBn7BczCzsR0MGboK72mg9LIXyExD7FFAsPmJRhRN
         V94+VHb82Z2zEod6KStLxOPeg3hS1kKct86gTb67YEeRYittW59h/akvA0L3jPgZWRYl
         KVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285215; x=1741890015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOXNDTF2vrh5uDiXj9TnU3A+yLNXaCYv0mbF7Mtjths=;
        b=jKjKUfH82RZn8Yc3Am91lRIIzrz8Yi5XJVRsRnhIE60fA4SjtHNkq2XhvIUSc5PN/G
         v/4IJz3rmNVyvRl7yESbAh+JmA12BhXNfuqPCwWxEM6+sUdZAvl0zSQXASu2otIg/9GG
         Y7NTRzSIhzQQhZsfKB4877Exb/hZrR+bTQ9NdokL9HwHeqXYihwYEE3ZSXeMpaXbOZdB
         LDD+7FEYsJbUhw+60JAEOFMUYFfWLLeakFnO9jde4C6YlxsI+Jgp799U99N7AfyPcdg/
         vkcewQ79a8CiFnBBvFdPEoKh2N4tr86gFBd0/EGRW/WDh0y2aZWNGIVrxuoa72al5kNJ
         Hl/Q==
X-Gm-Message-State: AOJu0YxEASmbbQ2yPiM7LGD9u3W3Uh6qE/ZTmx8vtnzHLpe5cpe6T736
	yGWnChTVek7sMD5Ku4EfGiVT+Flihk8kHzO2eRJ003hIyMaSZRaMyLZs+DroizYqQBft1KEKeA=
	=
X-Google-Smtp-Source: AGHT+IGgevzdqxTVQQgC72vwzEi5eRcrXB5iZhhzO5dAs3E7uSwYJSqTNfeHkjj5cciErEZHjXxSo/dUtA==
X-Received: from qtcw41.prod.google.com ([2002:a05:622a:1929:b0:475:580:4020])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:134a:b0:472:2021:b786
 with SMTP id d75a77b69052e-47611959d6emr657611cf.35.1741285214860; Thu, 06
 Mar 2025 10:20:14 -0800 (PST)
Date: Thu,  6 Mar 2025 18:20:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250306182009.2255241-1-rmoar@google.com>
Subject: [PATCH v2] kunit: tool: Fix bug in parsing test plan
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

Fix this bug to correctly parse test plan line.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v1:
- Remove error reported when test plan is missing.

 tools/testing/kunit/kunit_parser.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 29fc27e8949b..da53a709773a 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -759,7 +759,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# If parsing the main/top-level test, parse KTAP version line and
 		# test plan
 		test.name = "main"
-		ktap_line = parse_ktap_header(lines, test, printer)
+		parse_ktap_header(lines, test, printer)
 		test.log.extend(parse_diagnostic(lines))
 		parse_test_plan(lines, test)
 		parent_test = True
@@ -768,13 +768,12 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# the KTAP version line and/or subtest header line
 		ktap_line = parse_ktap_header(lines, test, printer)
 		subtest_line = parse_test_header(lines, test)
+		test.log.extend(parse_diagnostic(lines))
+		parse_test_plan(lines, test)
 		parent_test = (ktap_line or subtest_line)
 		if parent_test:
-			# If KTAP version line and/or subtest header is found, attempt
-			# to parse test plan and print test header
-			test.log.extend(parse_diagnostic(lines))
-			parse_test_plan(lines, test)
 			print_test_header(test, printer)
+
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1

base-commit: 0619a4868fc1b32b07fb9ed6c69adc5e5cf4e4b2
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


