Return-Path: <linux-kselftest+bounces-1214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CC805F95
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 21:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5566E1F21685
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 20:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28442692AA;
	Tue,  5 Dec 2023 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9xutZFF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FA4181
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 12:39:10 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-4239047911bso736691cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701808749; x=1702413549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yd7GThBDMFg3IYSnPer/AdnP24vZnl3M/lgBnBxitXE=;
        b=r9xutZFF5fAQE8GZbP00Aa2g/hGs8YDy8RDC+0MP/GTJhNkm71qzYoBeeYuFKwYkU7
         126P+1KeWKfCCB7RHj1Jbt1EZb6USNBV11bGzMGWuGxTIrf7WKABbqhoFuIp2U8mJvx8
         x24HADTXHxgKvqst/tjVcdiXD7Dl5rHoPhT5ozSENxdjChhK6Gw+yNfB4wykobQpZK4w
         rb7LrTfSEKoBCeml5/uAmAD7o6bKAcDi2BBYnS4ajB8u+KPoBi7jvi7AANyVAw/MglpA
         imstNrGyRN4SFL4LTLcXPQqw/FVp3qk+JUbgOjPfVZ0pPfIQMMOsJdNb6Cq7RRXO2EZT
         f6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701808749; x=1702413549;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yd7GThBDMFg3IYSnPer/AdnP24vZnl3M/lgBnBxitXE=;
        b=Eqkb+n9l44u1rIj2KI3KPsLKv4h3JWY6wdxRF+oL92yZjVIhFBbVFZQH6EWcVnQ1Nz
         9afAgXw1qaVPw5uCBP0OdU6KcVpUFvML21Re6nW5AvaLdf4rWwPwBvarAOwkzPk1h4+F
         jcEh0Ik47c6yKY/oJUu1MK7s79FKUGBUq5I5+UgF/reTLnp3RuagEPzrOZyKMEKLXhN1
         F9LwvYdYvp5hHUYlF8GiZ2v+bBtdjiWirU3J5T8jRWxkTVKfLYvT9C2Ee71O/zJxFI0p
         aTk1MZW9b+SSuyCtv74fLf7OfjEWLElwtQ8yONZFpVDKOecWZkN64MB703UaqvwFX577
         vYhw==
X-Gm-Message-State: AOJu0YxfXmWtzoE9eXwV1Lqg3jRHEA5kzPNgDLdDhheT7ZkNkFBQfUvT
	/wI3bdGJTEvHuoWfKagCA7bMdTMB8A==
X-Google-Smtp-Source: AGHT+IH0cd2HLFsC8CxaZuQ7ewPF5xTgOB6kCd9NRSSMtX79MgZW4qJ/dust0PqxwCuD94P1XVpaYtIuBw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:622a:4413:b0:423:6f2b:5a04 with SMTP id
 ka19-20020a05622a441300b004236f2b5a04mr26155qtb.10.1701808749501; Tue, 05 Dec
 2023 12:39:09 -0800 (PST)
Date: Tue,  5 Dec 2023 20:38:52 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231205203852.1700497-1-rmoar@google.com>
Subject: [PATCH] kunit: tool: fix parsing of test attributes
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

Note this patch is a resend but I removed the second patch in the series
so now it is a standalone patch.

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
2.43.0.rc2.451.g8631bc7472-goog


