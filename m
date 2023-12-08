Return-Path: <linux-kselftest+bounces-1448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C5680ACBA
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 20:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D74281764
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FF481C1;
	Fri,  8 Dec 2023 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtOpdMwp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4148610F8
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Dec 2023 11:12:29 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id 6a1803df08f44-67ab4382912so43928506d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Dec 2023 11:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702062748; x=1702667548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVvef+BcVgEroNYpsUvlaSbQE1KPpVwrXco8mT3u6R8=;
        b=TtOpdMwpk3HmyGxPMn0lXTJ1YACZLpsGKVjALtvXPgYgZcY36t9V9cUvKebcqvVtLv
         rHzmU5w01VqPobGCR9NkYT/l+IzVWoLeh2hExeW2HZGo/kXu7oZ/KaqdW8qCO+AsT+yH
         rlObRSjtVUEdJG6ZycKmb+i0RZQOqhj+/StTJKaltqK56ZepK/fyzwWC7IlFA8Y2vX8U
         /aVX/poyzT/swMPh+JUF/qC7N4EvnO0Tbui9mDqtqJyZVTgVN+bPQT/ffOAccpXFWuLx
         6NE+ekEuL8Vx3+qoo9kQp+w8QpwZSIMOhtJW8+GxOuecEzCqpy0eKfoBOpEN0bGFxnGy
         Oo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062748; x=1702667548;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVvef+BcVgEroNYpsUvlaSbQE1KPpVwrXco8mT3u6R8=;
        b=gCl+9S6hfxNkNSWof0f7nWl4EYAS+ZC5EDhisfI3D8pxxBgJalgYIahf/pKAYJcS5O
         7X4A/PawmberrtXRpNli5VdorOHArhVPJU+0jOu5hYAn0C/OlvSiFEMpL1hu9enL+xfI
         gQ99cYzVyTpLBHMspfr2L86nU0Tl8C1TkmImVnjQhX6T7sSPDNPTOC7Zi7+XErvNRB4O
         T4VlUPLuGQ/3/0tH1GNdzWcReARn7iafYgileNIznPfZ2bPb9Yq6k8XwaMEUsYT4jJcv
         UvTXxSklDojy7lDCJI8EnUnkslgTxLQt2bPctOXih04lJBa6Aq54AKyHPuw5MC3BhO3F
         K9Tg==
X-Gm-Message-State: AOJu0Yz+6PC26nEvCMpzZ6dwcwKGZlPWqXZDSWPj2XAmuPUTCUGySO6b
	FW0e3Eps2efLhw85XGGNLgo8Fm5ALQ==
X-Google-Smtp-Source: AGHT+IGuOdD3gIEzMskxj65xx+SL0VrhBoEpExw0ALUkNEYuZ/zPOt9y7oxmzmGADGUzBYXekOw1J3gmSA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a0c:f7d1:0:b0:67a:dbad:8ebd with SMTP id
 f17-20020a0cf7d1000000b0067adbad8ebdmr11575qvo.5.1702062748417; Fri, 08 Dec
 2023 11:12:28 -0800 (PST)
Date: Fri,  8 Dec 2023 19:12:21 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208191222.630119-1-rmoar@google.com>
Subject: [PATCH v3 1/2] kunit: tool: fix parsing of test attributes
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


