Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BF7A100E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 23:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjINVvy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 17:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjINVvy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 17:51:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8A1BFA
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 14:51:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d817775453dso1675472276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694728308; x=1695333108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZlU0Kf/Gcn2G/sI4bkJCwhLYRSeXEzqS2NQ4Iszo2s=;
        b=zFFXD4nYP3g8vduEG2wQpmlZC0rGS3wvsdeGjYc0KUCGZ0KZeFIyry4osfRAjpGXRY
         d0cCLNQYe+bb4lE+2BUL7kRRVe7/fefh/IyWFJifQY82ysw66ViVl4MIl1qHK6XMrRdk
         FqYV1RTRKgvCBiUcgF1/liJcFJsHiAjWadGAMelyF6+mkFRFoWU0lAU+7M9ifeQbSxKx
         s4BlvVFp31wupGO5MADIRgHrB8j57cTydJolnHC9mP+lMEZFTKU7a+AxuQACw1YmCsih
         33zbY+MTMHEavXjMJI+zgF+U3LjYZr+Wui6eY/NkpR55E93TUIpTdHl6CjxrALdrz6OD
         z6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728308; x=1695333108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZlU0Kf/Gcn2G/sI4bkJCwhLYRSeXEzqS2NQ4Iszo2s=;
        b=dw43hsxyk+j22+WzHs5G4O9ujh0BCtpCT8FS+sGcLtixBzvSlCwCGTcZ3yK210axWM
         a4ci8G9ea70dLhwAF4W1vn3lKWZobgBwPTkoVoJe8wYU/E6AurKXZMmt6wQ5dnrwirJr
         zazmqI4oKyl2AKXgF3pzFTTEHVFERdgaHWeP0ZE4LdSEW+tymg5Kocc/5iBxd2ibrjMl
         06NXMFMgCD2b+26yTRg/l7woKxsDJZvcwJdtQlRK9WzEewqPCw5iSK3vlCxcrGEfLuHZ
         ZtazR1vCgX3sbELFScuVhwljgslZsGxcpIv2CslQGORX/T75EiYL3lMJPtYaClVu1jvg
         EuOg==
X-Gm-Message-State: AOJu0YwQN5yIjkn5WP4TFDqPsJ/6WPOERrwu4hGljh9XcQzSSFmPz0/i
        CeCg6GJohOjJD87YGppbkmqcMu8DQg==
X-Google-Smtp-Source: AGHT+IFs2QTkWETQW88X7lVAYojwqxgUvIgWK6HjjeZUUZaPFEtRPnJAVID9TsxJZMd+RrcvrrEDfAobkg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:40d:0:b0:d7a:6a4c:b657 with SMTP id
 13-20020a25040d000000b00d7a6a4cb657mr166298ybe.0.1694728308004; Thu, 14 Sep
 2023 14:51:48 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:51:41 +0000
In-Reply-To: <20230914215141.3399584-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230914215141.3399584-1-rmoar@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914215141.3399584-2-rmoar@google.com>
Subject: [PATCH 2/2] kunit: tool: add attributes output to kunit.py
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Output attributes in kunit.py results.

Example of format:

[21:33:23] =================== example (7 subtests) ===================
[21:33:23] module: kunit_example_test
[21:33:23] [PASSED] example_simple_test
...
[21:33:23] [PASSED] example_slow_test
[21:33:23] speed: slow
[21:33:23] =================== [PASSED] example =======================

The attributes are outputted directly below the associated test.

Note that the attributes lines are saved in the log and then the log is
parsed for attributes rather than saving attributes in their own field.

This is due to diagnostic lines being saved prior to the creation of the
associated test object.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_parser.py | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index ce34be15c929..ffa9cfdcf5d6 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -509,6 +509,34 @@ def print_test_header(test: Test) -> None:
 			message += f'({test.expected_count} subtests)'
 	stdout.print_with_timestamp(format_test_divider(message, len(message)))
 
+TEST_HEADER_ATTR = re.compile(r'^\s*# (.*): (.*)$')
+TEST_ATTR = re.compile(r'^\s*# (.*)\.(.*): (.*)$')
+
+def print_test_attr(test: Test) -> None:
+	"""
+	Attributes, if present, will be printed in a list separated by
+	commas.
+
+	Example:
+	'module: example_test, speed: slow'
+
+	Parameters:
+	test - Test object representing current test being printed
+	"""
+	attr_list = ["module", "speed"]
+	output = []
+
+	for line in test.log:
+		test_match = TEST_ATTR.match(line)
+		header_match = TEST_HEADER_ATTR.match(line)
+		if test_match and (test_match.group(1) == test.name
+					  and (test_match.group(2) in attr_list)):
+			output.append(test_match.group(2) + ": " + test_match.group(3))
+		elif header_match and (header_match.group(1) in attr_list):
+			output.append(header_match.group(1) + ": " + header_match.group(2))
+	if output:
+		stdout.print_with_timestamp(", ".join(output))
+
 def print_log(log: Iterable[str]) -> None:
 	"""Prints all strings in saved log for test in yellow."""
 	formatted = textwrap.dedent('\n'.join(log))
@@ -741,6 +769,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 			test.log.extend(parse_diagnostic(lines))
 			parse_test_plan(lines, test)
 			print_test_header(test)
+			print_test_attr(test)
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
@@ -763,6 +792,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 				test.counts.add_status(
 					TestStatus.TEST_CRASHED)
 				print_test_result(sub_test)
+				print_test_attr(sub_test)
 			else:
 				test.log.extend(sub_log)
 				break
@@ -796,6 +826,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		print_test_footer(test)
 	elif is_subtest:
 		print_test_result(test)
+		print_test_attr(test)
 	return test
 
 def parse_run_tests(kernel_output: Iterable[str]) -> Test:
-- 
2.42.0.459.ge4e396fd5e-goog

