Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B486BD715
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 18:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCPRaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCPR3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 13:29:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514795BDAB
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:29:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5446a91c40cso22197047b3.18
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678987756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=87tojeD1hl3r+GUx070hYtMF9ILSs5cMERcPTVCxRuM=;
        b=aHMVxJZD2DW3iFMk6TmL8oBPJAFeqAikJ4nTGDGRFnxxnqtQ2GJIdXs09G+X/4WzVH
         EolIwi5v7QX2Y2F9FeJ972W7TwgchD6Xj4y3HGumhDSsCXdiTvLSAHiorOvEJjtiAa/U
         7jPrnf1uCOQCsBELMESaTVnDcmQMKrql2XeIm2aj6w2vX/Ntg+SZu+STY9W67b9pdnP/
         AqtBEKNtp+ind7FoI0zwmkeGyrme8GZVsWqjDfHM2ZNog29h01pP44BNCJuKjao5Ex5l
         JLiBy7IJw694s7thTru85RTcdkWn1Ms2+WaTBffoQXZPOfKM6HGfsdxVm9u3t8EfRrrh
         QH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87tojeD1hl3r+GUx070hYtMF9ILSs5cMERcPTVCxRuM=;
        b=EIcn/B5K82HKLO8YboDOM7Sl7nqI5yoCV/Z5rwmILEHTrAQiQBO+44c0dKCgTofawO
         X6eDbYlMEY6JIkc9YyzmNUcyM0+agtK2SY9O77emRk4nSnNi7UO6BlukHgSDGwzLWgwv
         8J9Z0p1y9m7tS1G7mzX4Ok7STrVGJOgkafcBBmMoG2j9wx83opfTizexf9ob5kGhGrb0
         PHkJeHvNImGu2gBfmgLYbXbKA10lTg095MdV92wBgAG0n5mOACLQX/1syPZOgn1IkTet
         hMWgAFESv0HhRRA4TcxwttfHNAOdFx+e89WkBG9YlAynCMLUJZAJiiBmFKdCWXdwTCwN
         V/HA==
X-Gm-Message-State: AO0yUKVeX+SRVtq/q7QuPM/nLH3lM38AmBH2VNoQsVLmN3gRPowjhr+m
        FHpV3CbBev/pGJ/6CYwjR9gtlGHgTYu9gw==
X-Google-Smtp-Source: AK7set8Fj9mkWCG4obWtev4yFMPVNmVcf1IXzAsy6fBiJYqOBrZpcX2U+wCqguEL4DDVoeejTe+9+XQy2zKQAQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a81:ae22:0:b0:541:69f4:f927 with SMTP id
 m34-20020a81ae22000000b0054169f4f927mr2725264ywh.8.1678987756364; Thu, 16 Mar
 2023 10:29:16 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:29:00 -0700
In-Reply-To: <20230316172900.755430-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20230316172900.755430-1-dlatypov@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316172900.755430-2-dlatypov@google.com>
Subject: [PATCH 2/2] kunit: tool: remove unused imports and variables
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
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

