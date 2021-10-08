Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F2F427426
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Oct 2021 01:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbhJHX0Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 19:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhJHX0Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 19:26:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C62FC061755
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Oct 2021 16:24:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q193-20020a252aca000000b005ba63482993so6078470ybq.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Oct 2021 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6R3nZNSzpk+caEZyXv3b16izwtA5CCBL4BbEmS/EszI=;
        b=SCTcPq0XXQwfY2ZRR2HhNNEvr4Rj77o66Gr0YOZ7cigPM21i52ffLDz+yyORwDXwFz
         whZroerQv6tq9hdPF6g9JW5aN1M1QtX+U7JPcge4syQAIN9kHx/AS9JdKhVQ56MPZkvd
         4hojpOEAgSgZjwgDKeriC6phw8hWz1yznvbRfj9hm8/4ri9LlhheF3xhc4Jsa0PfjhxF
         yZaj8yy85gCmOQs0KGqWEmw0X9UJJY/KFBW9eQAT0p8OLV+/Y6xLxXg4vaMpvyHuTA01
         tbPw9KvLHIHNb6hdbaPY6fqOirlQWtwqVPsRuSHsiLq6bYfE7CV6XLz5c5UTa3e3PqRB
         Os+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6R3nZNSzpk+caEZyXv3b16izwtA5CCBL4BbEmS/EszI=;
        b=H+A1rVxkfEZsSOuwQ7qj3GVRahDXCrL/hszLM+uINWY5xQZAZYGUPvAlg7gQyWjFbr
         IhbJMGaP8nFxBkiZ0Y3pev8lBo65gJeQqMNdUlbhgEs2TuwzqNWTL9IQZpGly0+fQhNA
         KEeXYr4SA6PAd4BmVzvo/cmxvWdzSLVH4PbJCb8LPlN4YyMywUM5+rAJt8/siQOrU2d3
         hzF3Awgks9yiU/NxKCiZzgzhrvsSmhEKgMIGRsTpn6TEkJP9zSjyKkVzf2smfNL4vTaC
         enjXEFYKIW4xIZwRKi8xKkg554iCpVeMioxnxYfO/MgMIuGbcAW8vXtSmAh76OlxvGFE
         9a8A==
X-Gm-Message-State: AOAM530NruM/MjHbTQ+0DFQUVEnYtW5svRPP4tlKUGGlqZWkef+KAuL3
        6019UILny/X+WrXzoYRQNhbYrGOBqE2YDw==
X-Google-Smtp-Source: ABdhPJx558ftpmVpgs7LrNHJQStAlHS2y/Ayjhyy19ovy7sM65gJptOQivKYtiSYhLOwP16uYEwtgdCuCUFWCg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:fc52:cec:3819:b41f])
 (user=dlatypov job=sendgmr) by 2002:a25:6705:: with SMTP id
 b5mr6502054ybc.116.1633735467458; Fri, 08 Oct 2021 16:24:27 -0700 (PDT)
Date:   Fri,  8 Oct 2021 16:24:21 -0700
Message-Id: <20211008232421.1264857-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] kunit: tool: fix --json output for skipped tests
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, KUnit will report SKIPPED tests as having failed if one uses
--json.

Add the missing if statement to set the appropriate status ("SKIP").
See https://api.kernelci.org/schema-test-case.html:
  "status": {
      "type": "string",
      "description": "The status of the execution of this test case",
      "enum": ["PASS", "FAIL", "SKIP", "ERROR"],
      "default": "PASS"
  },
with this, we now can properly produce all four of the statuses.

Fixes: 5acaf6031f53 ("kunit: tool: Support skipped tests in kunit_tool")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_json.py      | 2 ++
 tools/testing/kunit/kunit_tool_test.py | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 746bec72b9ac..b6e66c5d64d1 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -30,6 +30,8 @@ def _get_group_json(test: Test, def_config: str,
 			test_case = {"name": subtest.name, "status": "FAIL"}
 			if subtest.status == TestStatus.SUCCESS:
 				test_case["status"] = "PASS"
+			elif subtest.status == TestStatus.SKIPPED:
+				test_case["status"] = "SKIP"
 			elif subtest.status == TestStatus.TEST_CRASHED:
 				test_case["status"] = "ERROR"
 			test_cases.append(test_case)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 77e61b0a40e8..b3cc0227843c 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -426,6 +426,12 @@ class KUnitJsonTest(unittest.TestCase):
 			{'name': 'example_simple_test', 'status': 'ERROR'},
 			result["sub_groups"][1]["test_cases"][0])
 
+	def test_skipped_test_json(self):
+		result = self._json_for('test_skip_tests.log')
+		self.assertEqual(
+			{'name': 'example_skip_test', 'status': 'SKIP'},
+			result["sub_groups"][1]["test_cases"][1])
+
 	def test_no_tests_json(self):
 		result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
 		self.assertEqual(0, len(result['sub_groups']))

base-commit: 4a86e2973c31902a2a72f4f25f99b2367188ec5d
-- 
2.33.0.882.g93a45727a2-goog

