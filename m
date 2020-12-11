Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA3D2D82A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Dec 2020 00:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407112AbgLKXQk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 18:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407106AbgLKXQS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 18:16:18 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F3C061794
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Dec 2020 15:15:38 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id g7so2917707pji.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Dec 2020 15:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7RMa+XpTrdaOo6hcubARisrgZhZH4+hqcPEO5nMuS64=;
        b=Fubqybu4uTAPoAwaU2QIHcZOlw3DCHKAG7C9OJUMD6xTX/1dZaqQDro8a5Mq8KrOV0
         SqAVbEGTniMITbL4yyzyGFgkNv9rHMrvbKOUN5npZuIGtuo3uBu2z4HwJc26/EkyGVml
         E3QpzVR1ga9iVkRgQda9H1r9mxXo6DlNwVxjRNoH5RmBOcx/45IrNJvlubWwoVEhMpi6
         LbTUOWYZUCUA9VhzYvol9qn3Gsga20i+7ZMnsuyD+6viITQAxJm54Lb5UIp7vCweuwnx
         ADNQungzo4RXugKKZssmxO4i32pdCO+GlRDyChfHjK7Oi1YxYWnBLkbcFhRFidMMO223
         10kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7RMa+XpTrdaOo6hcubARisrgZhZH4+hqcPEO5nMuS64=;
        b=uPCUhfdJiVmsqaXrhIWQpJPsmyaO+3/KHDgLnCaavsmRfbwWeeSBWIau1pbJu/wDBQ
         xJ9USsR1zjMU3YH8lluyPbW3Oyymp4t//8T8y1FwT+7W/Kxma62jzvxlmyuZ58cfn4+G
         6gpldf8luwZiusEYd9FoaSLppFyJKxYDctS4IvhZc9ypWnvLRM3z0wNtpSok/DTrgGoe
         YoFRSiiSQWaKCAZBTC0HuflSDvSwOVex+Ctkwmz06yHYKMqIYGlw7hr22aw+V1CiFE2M
         K4ak5eqHPT90Bdar85HoLpn4vgwlV8dpSqTmqjxThODVfc3PhXYp5Hsk6TkuLbVG8TBo
         utYA==
X-Gm-Message-State: AOAM530+AjS+3SgK87oh0hbKtivvgCl+WOOcNSfkzKdOeepXDDL9vUjD
        UCmE+18rbPrEVTFfmv52ix0+4NrN2MDerw==
X-Google-Smtp-Source: ABdhPJzB3iEpBL1DsVEYiGwT2G9mrHzV8dAjv5XBjHDGZwkj4yRQnJL2SFwf2c+NuVPThckwNkgurfssOqPtvw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:fd5:: with SMTP id
 gd21mr5228649pjb.139.1607728537607; Fri, 11 Dec 2020 15:15:37 -0800 (PST)
Date:   Fri, 11 Dec 2020 15:15:19 -0800
In-Reply-To: <20201211231520.1654036-1-dlatypov@google.com>
Message-Id: <20201211231520.1654036-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20201211231520.1654036-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2 2/3] kunit: tool: fix minor typing issue with None status
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The code to handle aggregating statuses didn't check that the status
actually got set to some non-None value.
Default the value to SUCCESS instead of adding a bunch of `is None`
checks.

This sorta follows the precedent in commit 3fc48259d525 ("kunit: Don't
fail test suites if one of them is empty").

Also slightly simplify the code and add type annotations.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 24954bbc9baf..97e070506c31 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,13 +12,13 @@ from collections import namedtuple
 from datetime import datetime
 from enum import Enum, auto
 from functools import reduce
-from typing import Iterator, List, Optional, Tuple
+from typing import Iterable, Iterator, List, Optional, Tuple
 
 TestResult = namedtuple('TestResult', ['status','suites','log'])
 
 class TestSuite(object):
 	def __init__(self) -> None:
-		self.status = None  # type: Optional[TestStatus]
+		self.status = TestStatus.SUCCESS
 		self.name = ''
 		self.cases = []  # type: List[TestCase]
 
@@ -30,7 +30,7 @@ class TestSuite(object):
 
 class TestCase(object):
 	def __init__(self) -> None:
-		self.status = None  # type: Optional[TestStatus]
+		self.status = TestStatus.SUCCESS
 		self.name = ''
 		self.log = []  # type: List[str]
 
@@ -223,12 +223,11 @@ def parse_ok_not_ok_test_suite(lines: List[str],
 	else:
 		return False
 
-def bubble_up_errors(to_status, status_container_list) -> TestStatus:
-	status_list = map(to_status, status_container_list)
-	return reduce(max_status, status_list, TestStatus.SUCCESS)
+def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
+	return reduce(max_status, statuses, TestStatus.SUCCESS)
 
 def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
-	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
+	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
 def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
@@ -281,8 +280,8 @@ def parse_test_plan(lines: List[str]) -> Optional[int]:
 	else:
 		return None
 
-def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
-	return bubble_up_errors(lambda x: x.status, test_suite_list)
+def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
+	return bubble_up_errors(x.status for x in test_suites)
 
 def parse_test_result(lines: List[str]) -> TestResult:
 	consume_non_diagnositic(lines)
-- 
2.29.2.684.gfbc64c5ab5-goog

