Return-Path: <linux-kselftest+bounces-1382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C98094B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 22:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63821C210BF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 21:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA25B56395;
	Thu,  7 Dec 2023 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7RL33fG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA13599
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 13:34:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db401df7735so1870915276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 13:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701984857; x=1702589657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVvef+BcVgEroNYpsUvlaSbQE1KPpVwrXco8mT3u6R8=;
        b=V7RL33fGpxz5liHmJfJ19Gv4HVRjyW7C5bIK8yhkT5aETZHjatGv6RZLmeyU17g/qd
         vUTREXJ9Xjm5AB00QlBhK7xhq9Hyxx0G6EyI+OOJxQj7vjRBVk1qfYYhcO68grMXz0M0
         HxGgbwQ9jJgdsPyMk55EzgVCwtYkihg/FzGe2CxZjoJO6JFqGMgwwCIgEo5gNRozsWpU
         b07gISkkQ87nGOJt120mzrQaI0R99yOZHufCBm4oekrJ3wow8eVhL9JFJ4oJzSlgMYUY
         P8I7hbY2pTFevjMnQhrROLNafdK9Yy169h+h74QyhJxtHtxmcly4Y1LBJDEe5OHptN5Z
         0ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984857; x=1702589657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVvef+BcVgEroNYpsUvlaSbQE1KPpVwrXco8mT3u6R8=;
        b=uSweBw6wOByl9glnozU40isPn7+KR0Rhvl5Zp+tUw0DXK64LU3Baw0ROZvcrL1lABE
         yZ8RI41hkN1bKLeoWwak47ur8Y6dPFiVWnevOsFOqahlljqLZ1ZrVTrXLwv5j7pbvMLQ
         VJeUngCOU9W1EWS7jlzZ3VIEBGYvhX9CXhwtXBOq1G5de+bacje1az4/P46b4w8Mkhn5
         VymJusdDvB3NGN9nt0NRN83o8uEf70LgFpZqrQPjyhsZV9zoVn5JkVAXXygYwVUQZzNV
         EvdCaQHmFtolcYPNk0ETOCaP3RKXOHrjFmJOKEXEtm52hUYejg4mL9MeRRRLHIQ4Aljz
         /djA==
X-Gm-Message-State: AOJu0YwLKM9yapGxvl71wTOO5QMYwYTdNPjYje7cFl8VMCDxYLc8FdSo
	tjPbAr+k8vNFh7jIN59xSEj6HMvMrg==
X-Google-Smtp-Source: AGHT+IFcnTmpIxE1whdzzseWwxE7PYCbkOE0lyizRjIw5inFfT6N6kmdP3S7jk7PUBfYbA1A3Fdf7qTeBA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:d7d1:0:b0:db5:4b1d:c63c with SMTP id
 o200-20020a25d7d1000000b00db54b1dc63cmr35989ybg.11.1701984857742; Thu, 07 Dec
 2023 13:34:17 -0800 (PST)
Date: Thu,  7 Dec 2023 21:34:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231207213410.417564-1-rmoar@google.com>
Subject: [PATCH v2 1/2] kunit: tool: fix parsing of test attributes
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add parsing of attributes as diagnostic data. Fixes issue with test plan
being parsed incorrectly as diagnostic data when located after
suite-level attributes.

Note that if there does not exist a test plan line, the diagnostic lines
between the suite header and the first result will be saved in the suite
log rather than the first test case log.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_parser.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 79d8832c862a..ce34be15c929 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -450,7 +450,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	Log of diagnostic lines
 	"""
 	log = []  # type: List[str]
-	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START]
+	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START, TEST_PLAN]
 	while lines and not any(re.match(lines.peek())
 			for re in non_diagnostic_lines):
 		log.append(lines.pop())
@@ -726,6 +726,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# test plan
 		test.name = "main"
 		ktap_line = parse_ktap_header(lines, test)
+		test.log.extend(parse_diagnostic(lines))
 		parse_test_plan(lines, test)
 		parent_test = True
 	else:
@@ -737,6 +738,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		if parent_test:
 			# If KTAP version line and/or subtest header is found, attempt
 			# to parse test plan and print test header
+			test.log.extend(parse_diagnostic(lines))
 			parse_test_plan(lines, test)
 			print_test_header(test)
 	expected_count = test.expected_count

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0.472.g3155946c3a-goog


