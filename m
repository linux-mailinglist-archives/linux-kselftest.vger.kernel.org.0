Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3361728F6AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbgJOQ2W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 12:28:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:45399 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389940AbgJOQ2V (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 12:28:21 -0400
IronPort-SDR: SDHhKjpzwZl3Jc+bB8wxonG75z0BftsUUDXRdk6YvNCekmj+Ae7iY31yy204ya1QM6OaB7g+Ag
 9wqeL1zdX1ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="153324738"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="153324738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 09:28:21 -0700
IronPort-SDR: VUOitJIJBD49DssWx3rPbsgMkVTLe0fV4XIbIAoygSq+ym6er3F1OHbyLtrOAOV9H8tM4QnzhR
 xYhZnXAcWIrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="521898743"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2020 09:28:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95404FC; Thu, 15 Oct 2020 19:28:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] kunit: Don't fail test suites if one of them is empty
Date:   Thu, 15 Oct 2020 19:28:17 +0300
Message-Id: <20201015162817.86901-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Empty test suite is okay test suite.

Don't fail the rest of the test suites if one of them is empty.

Fixes: 6ebf5866f2e8 ("kunit: tool: add Python wrappers for running KUnit tests")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/testing/kunit/kunit_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8019e3dd4c32..12b9fc652ef6 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -242,7 +242,7 @@ def parse_test_suite(lines: List[str], expected_suite_index: int) -> TestSuite:
 		return None
 	test_suite.name = name
 	expected_test_case_num = parse_subtest_plan(lines)
-	if not expected_test_case_num:
+	if expected_test_case_num is None:
 		return None
 	while expected_test_case_num > 0:
 		test_case = parse_test_case(lines)
-- 
2.28.0

