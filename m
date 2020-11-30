Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A42C92A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 00:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388821AbgK3Xdm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 18:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbgK3Xdl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 18:33:41 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF8C0613D4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:33:01 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m45so8670251qvg.16
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ttzonDLnom22r4qWzcAdluPaM3s1nhK2YWokAGE/W2k=;
        b=TBzTKlaZ7ruNj9YZ1Oy3DGayakTXEQTyYoiGXpWwSFdqa2DqJ/lPf6CdsZthVriGwT
         40gs1L85PW4GrAAPQvrm7lZCPadp3H+ciMKOhRxlHNBhNEQY8xrhCvx+6WEnz+T5hsGt
         ukAHkNHYrD/jgJsaP9K5sQUbm4wCpUQGkZ3E/n+FUx/1tMRVRT3A9wzMfWpGdYsVQryt
         dhkK0f3Bzu4Kzk2o/AAsC4u6ATbw40/62tkOHYUUYEDZjNGRXaV1qQrcphjZ8x61nz1Z
         orvjwDMPKSIZ3wxuMq4nS7qFcdsQqnb7wHUZv1dK2u5Z6qLr3ZpCjDZnDl/D5Tn4+hCJ
         4e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ttzonDLnom22r4qWzcAdluPaM3s1nhK2YWokAGE/W2k=;
        b=lDx+ZCFBS3TqFX3H4pWMbLRg3efBP3iLw7D0RPuaSYGBXItvvRUk9hgeowEAEQCjgn
         5oWlZWPxz+oLO7pWsmsPc0svOIfRTVu7MLWVYuJ5hEwbvev2/NWN2cn1UG31cyQK1z12
         dQg9g2qa2hicjJMhPyBW37Nz2crzwLJRBomxuoW/x7D4reETPhy7vAR1aw5L+4e2oFwT
         wd/q4pJK05fvLsw/N6AnlRn27gWtRS3VNjnbe9P/HP6QVwgOwowmoy90LZsLuHON6/5w
         VEb/Kpy1b7BJYB6zXj7zt8zHYlNQIT23haJl58/8a18jK3AC5Ejtgdb/uha/BZN16FC3
         bzyw==
X-Gm-Message-State: AOAM530VQI3fQwDheacv3qIlTjWxOeCl7mcnetTqRQpcSnscsVMpNR+u
        mvLM9aLNdFFPqMPt2hvLqL+9XFBbPW+JjQ==
X-Google-Smtp-Source: ABdhPJz5DodkIUPJS5kDtvOayVAmmvGCcLeuIYRCWQJrTWOxcfbdcM84ul9oat5GwGIxmoq+uyafBCnyCWiVGg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a0c:da0d:: with SMTP id
 x13mr258426qvj.20.1606779179248; Mon, 30 Nov 2020 15:32:59 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:32:39 -0800
In-Reply-To: <20201130233242.78413-1-dlatypov@google.com>
Message-Id: <20201130233242.78413-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 2/5] kunit: tool: fix unit test so it can run from non-root dir
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

get_absolute_path() makes an attempt to allow for this.
But that doesn't work as soon as os.chdir() gets called.

So make it so that os.chdir() does nothing to avoid this.

Note: mock.patch.object() doesn't seem to work in setUpModule(), hence
the introduction of a new base class instead.

Fixes: 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside kernel tree")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 3fbe1acd531a..9f1f1e1b772a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -32,7 +32,13 @@ def tearDownModule():
 def get_absolute_path(path):
 	return os.path.join(os.path.dirname(__file__), path)
 
-class KconfigTest(unittest.TestCase):
+class KUnitTest(unittest.TestCase):
+	"""Contains common setup, like stopping main() from calling chdir."""
+	def setUp(self):
+		mock.patch.object(os, 'chdir').start()
+		self.addCleanup(mock.patch.stopall)
+
+class KconfigTest(KUnitTest):
 
 	def test_is_subset_of(self):
 		kconfig0 = kunit_config.Kconfig()
@@ -88,7 +94,7 @@ class KconfigTest(unittest.TestCase):
 		self.assertEqual(actual_kconfig.entries(),
 				 expected_kconfig.entries())
 
-class KUnitParserTest(unittest.TestCase):
+class KUnitParserTest(KUnitTest):
 
 	def assertContains(self, needle, haystack):
 		for line in haystack:
@@ -250,7 +256,7 @@ class KUnitParserTest(unittest.TestCase):
 				result.status)
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
-class KUnitJsonTest(unittest.TestCase):
+class KUnitJsonTest(KUnitTest):
 
 	def _json_for(self, log_file):
 		with(open(get_absolute_path(log_file))) as file:
@@ -285,8 +291,9 @@ class StrContains(str):
 	def __eq__(self, other):
 		return self in other
 
-class KUnitMainTest(unittest.TestCase):
+class KUnitMainTest(KUnitTest):
 	def setUp(self):
+		super().setUp()
 		path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
 		with open(path) as file:
 			all_passed_log = file.readlines()
-- 
2.29.2.454.gaff20da3a2-goog

