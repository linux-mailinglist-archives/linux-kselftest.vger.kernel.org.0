Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201F8611C11
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiJ1VDN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 17:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1VDM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 17:03:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562FF244C72
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 14:03:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36f8318e4d0so53583307b3.20
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XV7iaO5xhJsUUi6v6TQz064kMq8CSbatm+UbozZNDY0=;
        b=WdEBUnTbhxJLMg0NrpL18rCOOI7uGGfwy1OMESfUixvQGK+UZ2TPM+1YJGLk5ibNVw
         EXecXCN/Yv+UYJ3wSew4oqQF8QxgF+5fAR00RCwkwOFkXt+WCmCpoHN0C/FeKzXJ0tnl
         xaFJhvqw4/JXMeuzBaHnIzmq9RlxXf2co0A9Pv4sJ3TsTi7lVx+PJGcEuODK1lCQCf/p
         Zmsgax6qqXV8Jul+miO9w7bK8zvDTkwcVMPJuqVb8kQ01h+0wuwgHnEc0768xPh3kegr
         V2KCT4zllQc+IT8uUA5H/xPVoPZLUdGM/ngcaySaSQsppTHAnkL2vwK8qJEXmNl3EWPW
         9Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XV7iaO5xhJsUUi6v6TQz064kMq8CSbatm+UbozZNDY0=;
        b=BEyDs8l/Uv2fSvYkZLOZZ0jCSnK3rgKIJtdgY4YS6ZK0mK0lIjDuFZwnIM5VkG/OwA
         JJ7zOkm88nswFdolOCkjclhwTZptLTzlTFZbdf1Q/QHdx5gvEe3Q5lqCYGurWVaGjhri
         05Ma1daA47GZZdmsdy8WCNhU9sr3Dvd/6/hA9o+66is0fMCjUh8u8guEVd3dyElg8DHv
         Y7QaLZOByzRa4AyapB5R5rdtvIi5bol/4zFUcqFt5Gh+8c0ENOaz6X4McpJVloaIAB9O
         FyACY2Z2kxZHqBlwEsXgEx7EIUQMNbyaicPLq2+jxmUY8LC4Hs21DNhqqPWmdTKi/HEI
         BLQw==
X-Gm-Message-State: ACrzQf2BTTG0c6fY/AThRQwTSqdOQ7B9iFrtuozLIs8zKNn2VZVu1wjz
        BBXpLrsMoCB0EC2qIkeblyx/ZjkerBEV4A==
X-Google-Smtp-Source: AMsMyM4AvC82rppEEtotIujJ/wn7nd4xefQiz4dHWAaR8yNHEHnlzkjZgyE3Ry+FKiZ2BEs3WiTG0J1BNhn3Tg==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a81:bc5:0:b0:36f:fd68:b56a with SMTP id
 188-20020a810bc5000000b0036ffd68b56amr1ywl.41.1666990986198; Fri, 28 Oct 2022
 14:03:06 -0700 (PDT)
Date:   Fri, 28 Oct 2022 14:02:55 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221028210256.3776835-1-dlatypov@google.com>
Subject: [PATCH 1/2] kunit: tool: make unit test not print parsed testdata to stdout
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

Currently, if you run
$ ./tools/testing/kunit/kunit_tool_test.py
you'll see a lot of output from the parser as we feed it testdata.

This makes the output hard to read and fairly confusing, esp. since our
testdata includes example failures, which get printed out in red.

Silence that output so real failures are easier to see.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index e2cd2cc2e98f..a6e53945656e 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -80,6 +80,9 @@ class KconfigTest(unittest.TestCase):
 		self.assertEqual(actual_kconfig, expected_kconfig)
 
 class KUnitParserTest(unittest.TestCase):
+	def setUp(self):
+		self.print_mock = mock.patch('kunit_printer.Printer.print').start()
+		self.addCleanup(mock.patch.stopall)
 
 	def assertContains(self, needle: str, haystack: kunit_parser.LineStream):
 		# Clone the iterator so we can print the contents on failure.
@@ -485,6 +488,9 @@ class LinuxSourceTreeTest(unittest.TestCase):
 
 
 class KUnitJsonTest(unittest.TestCase):
+	def setUp(self):
+		self.print_mock = mock.patch('kunit_printer.Printer.print').start()
+		self.addCleanup(mock.patch.stopall)
 
 	def _json_for(self, log_file):
 		with open(test_data_path(log_file)) as file:

base-commit: 8f8b51f7d5c8bd3a89e7ea87aed2cdaa52ca5ba4
-- 
2.38.1.273.g43a17bfeac-goog

