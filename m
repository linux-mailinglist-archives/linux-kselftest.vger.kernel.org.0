Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40706BDB43
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 23:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCPWHK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 18:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCPWHI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 18:07:08 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321FC8889C
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:06:49 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m9-20020a17090a7f8900b0023769205928so3111510pjl.6
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679004408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyYEy94Hl6G702MitXTCkJDRHmSWmfCy0+kd4MGWn4Q=;
        b=EanqDwcW1c4tC1c4bY046vhovdnIJfuNEJ3wfJIbUWk8ma6m2+lqMH5uF9wsp9B6Wx
         yg8sw5+/ddXkgh3Nt/ps/jbQt93TX9eXTU0jLxyEtKcSpVbGh+BzbuEEN7CqHJVL3UQh
         LWP4FyeLmZ6GWVegiqCsRIRSzggUZ6esVvpQyqFLjqpmdmZMM98FUTB1ERXOVP4+GQHK
         zCaD8Ry6u9/DC352Xq65Zic2iwgqnBaWx3z+76no5G6Pvey+yK6MvFFVcTdjO4lIKxi4
         Snts9ss80NB7g4FY83XOcx4tVDjd8OBeTPrRsgZph26Q5RCc0zUzDbKsSRiW8UPM1QYM
         thzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679004408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyYEy94Hl6G702MitXTCkJDRHmSWmfCy0+kd4MGWn4Q=;
        b=35nOG41r900i7MFPXpZ8TjZNTgGzoEi8xMeN6xd6+sGQ7PMyW8y0zYLaCp9MXlKRaG
         5Gg0R6r1riJeJIghbttScmMyxRY9dQYJ4Z55scP/VZbdbk3OcM5sRdBoJ/rK22CYGDuN
         5gFPG2CLU47A6KFWImij46BKHzoMzrAQ+/8MGPrpfJoYtKHqh8DpGWQfp9RW9vrYsRNe
         /hLaF0LYrFg9BKHi0DoUu9gLqrqk8cHAs813bkDm3O4lUTxgHpgxdR0+xxGGXtKyQeNQ
         rx5NdbSwa5pQgqsRO7sz43Fal5W4QXe43BRGmC6Ow2j6Q7appyMH4a6U9Llkj0Nqa1VU
         jumw==
X-Gm-Message-State: AO0yUKXjr4DnN5Hso3sKU09VvZ/Y9Xfhoh/1Lewhk4ABStC7KWPZRS1D
        OjkLyshgoLVHea2cKVzYCRCS45kNpKds0A==
X-Google-Smtp-Source: AK7set/6YzqO8CcGXWHZsjNqsGjSSxw6NdeGYQkdWdtZOikKbW0tQiTckwOQnUMmF70Ib81Kk/qYmbqhllKLVg==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:cca:b0:626:23a1:7b8a with SMTP
 id b10-20020a056a000cca00b0062623a17b8amr27092pfv.3.1679004408680; Thu, 16
 Mar 2023 15:06:48 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:06:37 -0700
In-Reply-To: <20230316220638.983743-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20230316220638.983743-1-dlatypov@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316220638.983743-2-dlatypov@google.com>
Subject: [PATCH v2 2/3] kunit: tool: remove unused imports and variables
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, johannes@sipsolutions.net,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We don't run a linter regularly over kunit.py code (the default settings
on most don't like kernel style, e.g. tabs) so some of these imports
didn't get removed when they stopped being used.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
Note: this is unchanged, just added a 3rd patch to this series.
---
 tools/testing/kunit/kunit.py           | 2 +-
 tools/testing/kunit/kunit_config.py    | 2 +-
 tools/testing/kunit/kunit_kernel.py    | 1 -
 tools/testing/kunit/kunit_parser.py    | 1 -
 tools/testing/kunit/kunit_tool_test.py | 2 +-
 5 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 741f15420467..52853634ba23 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -123,7 +123,7 @@ def _suites_from_test_list(tests: List[str]) -> List[str]:
 		parts = t.split('.', maxsplit=2)
 		if len(parts) != 2:
 			raise ValueError(f'internal KUnit error, test name should be of the form "<suite>.<test>", got "{t}"')
-		suite, case = parts
+		suite, _ = parts
 		if not suites or suites[-1] != suite:
 			suites.append(suite)
 	return suites
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 48b5f34b2e5d..9f76d7b89617 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -8,7 +8,7 @@
 
 from dataclasses import dataclass
 import re
-from typing import Dict, Iterable, List, Set, Tuple
+from typing import Dict, Iterable, List, Tuple
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index e6fc8fcb071a..775842b912d8 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -18,7 +18,6 @@ import threading
 from typing import Iterator, List, Optional, Tuple
 
 import kunit_config
-from kunit_printer import stdout
 import qemu_config
 
 KCONFIG_PATH = '.config'
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index a225799f6b1b..fbc094f0567e 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,7 +12,6 @@
 from __future__ import annotations
 from dataclasses import dataclass
 import re
-import sys
 import textwrap
 
 from enum import Enum, auto
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0c2190514103..be35999bb84f 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -328,7 +328,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_parse_subtest_header(self):
 		ktap_log = test_data_path('test_parse_subtest_header.log')
 		with open(ktap_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			kunit_parser.parse_run_tests(file.readlines())
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
 
 	def test_show_test_output_on_failure(self):
-- 
2.40.0.rc1.284.g88254d51c5-goog

