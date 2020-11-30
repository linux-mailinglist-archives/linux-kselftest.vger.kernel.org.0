Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C902C92A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 00:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbgK3Xdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 18:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388751AbgK3Xdd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 18:33:33 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47F6C0613D2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:32:52 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 1so52885plb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=J6KrjM+An9hxizaoTxQW8Sd5zzmQDHenzE5Ig4WuWJQ=;
        b=S1YjxK8oKlewM/lUI+njMNTuyBmMucV+Vj8D1b+2+Xw4Yb7F1hmct0v7WU95ZO8RLa
         JiChMFdNvlvPjLSF+Rfbjvnh1kPiyn7Leoal7DaCm5qu51M+1bEMXZOzp9zWIVfmIXwZ
         vvk9d91NX94gZm3U/OLiCGToWfBGYHhO+Ss6VxZvMPegFrGbznF/3tEt8Kep6jybmNbi
         FeyAhOSyF11y0AeXQ/VngVX1wMTDwAGQTmja01rnn++JlHyA2Itq381XnRKJUEDbjBtV
         xLkdee3Lwy65TcFupgHvESgnu7fIGMD0QiB5i4VmR7FckGimJrXlQcVhVkswcATdvBgY
         kUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=J6KrjM+An9hxizaoTxQW8Sd5zzmQDHenzE5Ig4WuWJQ=;
        b=C6bQ6OtF/FAOb/NJQpjur++Y5pkJFEvHaR5AhKwyubRtzXLf1yiXGtSDo9SF7RMz/1
         1z661wvVAtGvxWHqwjefTZ3BsoM00Ia/yIWZzqtLkdFaoHL4lb4IXXfer4ZgD7K4wFqP
         wAq3pgxeEWJlyZT0RPXHCMtrbegG4C6t6QF7GuE6hz42sNec02s5TpHOpDebbA0UNKXv
         ylPP/wZ0RBQBwhGVH8g1QSgQryhZwK2qiUnzjRCNLC8RvSL1LpLUOh0PpHHMSBFRavPJ
         EPXeZ+uaR1S52bDDfwQCrtDgveoJ0j/5t/In7zuAZcVHA9LqQnMnEdY2p37oUm8CYtKD
         hjYQ==
X-Gm-Message-State: AOAM530y5M1+VzDZPxlJW9YnPiJI0vqvBDw3zwlurxdlm/1ZP5dHW6Ha
        6nBGkCXjkCDakJf+CeIOHxeqXoZMypQhuQ==
X-Google-Smtp-Source: ABdhPJzm6Yd2jI0ouR92z9SmEx6p4jkMQkjRIJ50NuCaDaW2g7fUwx00kTfYceOKeaepwla7b7paiiE4oE3W3Q==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:902:ab83:b029:d8:d979:f083 with SMTP
 id f3-20020a170902ab83b02900d8d979f083mr198344plr.84.1606779172246; Mon, 30
 Nov 2020 15:32:52 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:32:38 -0800
Message-Id: <20201130233242.78413-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 1/5] kunit: tool: fix unit test cleanup handling
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Stop leaking file objects.
* Use self.addCleanup() to ensure we call cleanup functions even if
setUp() fails.
* use mock.patch.stopall instead of more error-prone manual approach

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 497ab51bc170..3fbe1acd531a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -288,19 +288,17 @@ class StrContains(str):
 class KUnitMainTest(unittest.TestCase):
 	def setUp(self):
 		path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
-		file = open(path)
-		all_passed_log = file.readlines()
-		self.print_patch = mock.patch('builtins.print')
-		self.print_mock = self.print_patch.start()
+		with open(path) as file:
+			all_passed_log = file.readlines()
+
+		self.print_mock = mock.patch('builtins.print').start()
+		self.addCleanup(mock.patch.stopall)
+
 		self.linux_source_mock = mock.Mock()
 		self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
 		self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
 
-	def tearDown(self):
-		self.print_patch.stop()
-		pass
-
 	def test_config_passes_args_pass(self):
 		kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1

base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
2.29.2.454.gaff20da3a2-goog

