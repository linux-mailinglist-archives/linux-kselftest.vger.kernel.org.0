Return-Path: <linux-kselftest+bounces-28983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FBFA60125
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 20:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4770819C2605
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 19:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA64E1F1931;
	Thu, 13 Mar 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GyEKrDub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452081F2BA9
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894044; cv=none; b=BkJWuScXONszewUNXmVGlf+yRT5TdYjOdya4G7hS85NVHLeplpRh5oaDeuVStmOYq5gB+ZkeKSNB7I7S75yc6g3ipmknSZAPH85rQVq9olQeTa2oQ7t+E1cAlnnzLZlag8zXB7mnUs+/kxvCUJAkPLDpkfX/tSeXbzj8zx4mU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894044; c=relaxed/simple;
	bh=ILIt1I4K0yqsx2yeqHM01aYQOroUH63iR+NR+X1/jzw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C6BAyx88hHTRZhbLUq20zYcQur/MnzBCEzOcnRqdt8O9ShwJnJUIQbfFap3vbtDjzyIGABG7i7a6uDc3wUg7GhIMdPk/AF0G9uUVAv9++InhtDMlJIaaJoshfqR4st1SuifEWudmii2opUdFe/SfFsUizfZzZQvaD1YlRBl6YuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GyEKrDub; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c0a71aaf9fso322995985a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741894042; x=1742498842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Flzo3lVXN6Qb29UsmAIPXEQO4WxyqMDpwWQQUOakg/A=;
        b=GyEKrDubZNrDsnddwJG8wfLf7QgcpHD9SL1LfAkhYSSJG9DIPEfMpilre2G2u5k8gD
         aWEjT2+PAYdTQKHgqRqk6NHcOQT2PvcvmibLeI6xItGVIuflcrLakzGpjrBDryvAV+8H
         ytA8pTqM2vpPpMQ/rI+qsHdvcjlzvqSV0ATKn6MYsdDZiTtyPuy9GCf2u5Dz1/vcJACZ
         GwT5T16v/sIzSA1IziEXE4vhAOrFOnJdAkjmSw1xKBafoQp2M98piq/bs40GlhxAl0Cv
         fzVcFBJX9B2HQjVw9YtqGnmcbXeUNeTUufMmA6QxxnaaUy2wsjDGisurFucAwaYXIFf/
         0tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741894042; x=1742498842;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Flzo3lVXN6Qb29UsmAIPXEQO4WxyqMDpwWQQUOakg/A=;
        b=Vf31FuE9GJsAnFTOXW2Cl+4Jw0R9pdXluJ32a14Cw56hY01aHtnssa4MHjyaA7XEzB
         OeWbM2X6qIUG9rJxVIE3a1ztvNZNG8ecaq15LyZaZtqjbSOoj1vmLnuZ4QsF5sE+83T+
         cYwv4BNTURo9bUn0P0NY6CrXJ6Qv6g96WRZuLvYXjX0pbJN2xo4daC7MOVxHZ7jv9V0F
         Ws8jHrO3sp+CeWoFOL2Yblh7IKOokGPNugvnDrali+sZpGuFIz50xbh/jkG9CqEiKloy
         keTU/MylG0VGRLDi/cVOEIrl3yDz1HA+qXllcpoWduHLIuKbOTjh/nKtOFHkbQR0Rybo
         rkSw==
X-Forwarded-Encrypted: i=1; AJvYcCUCO+y+SpVnHGWd7tYr/E3cPboCWwCFxMN/uCZXZxIVC9nX7/9pGbuXhLUsCbZ8cZWRxanybJiD1NqaxAFqugM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkxN5+27O4LH2f/OEmx6d8D3sEEUzbVH5Lm7t8d4qYEqvD01f
	A53RyQ9af4nSU3bTh5JaD156OomnkC6B13pc9umj+MpJ2s+ic5I5xOJhtTJDtbYlLThVtTDsmg=
	=
X-Google-Smtp-Source: AGHT+IEhCEWKmQjlaJ2Hf9ADlQ1vji3WEjuildMcB96v9vZqW2qrPWk46XWEkANhfAWxGwXSXAbZlKWs4Q==
X-Received: from qkd1.prod.google.com ([2002:a05:620a:a001:b0:7c3:cc0d:22fb])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2713:b0:7c5:67ac:a826
 with SMTP id af79cd13be357-7c579fafb41mr102376685a.50.1741894042243; Thu, 13
 Mar 2025 12:27:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:27:13 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313192714.1380005-1-rmoar@google.com>
Subject: [PATCH v3 1/2] kunit: tool: Fix bug in parsing test plan
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com
Cc: jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

A bug was identified where the KTAP below caused an infinite loop:

 TAP version 13
 ok 4 test_case
 1..4

The infinite loop was caused by the parser not parsing a test plan
if following a test result line.

Fix this bug by parsing test plan line to avoid the infinite loop.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v2:
- None, adds test in second patch

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
2.49.0.rc1.451.g8f38331e32-goog


