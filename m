Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF4211C337
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfLLC1e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:27:34 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36267 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfLLC1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:27:31 -0500
Received: by mail-pj1-f49.google.com with SMTP id n96so365760pjc.3;
        Wed, 11 Dec 2019 18:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q9POWu9QQdjXlCxWsG8nhRyoRqIP2kXxcG0Qf/wCB4g=;
        b=FJEuZsdm7LU6Kc4mRJBTldlXcUWbi0J3FW0GL9IJjqw+Wnq/8dEun0vCvWz4vl3iab
         Fqq/sT9sQ37rX9j/JAClwVomNhzsmdL18W2jAgd+Rg6WWxpdAdw6UowLajZw37yYINwa
         tRGvDS6pvwvTU32QKheCTmuEowhOTLrU/PM5BnJP/FEEZ4lvHnOOgUyAhWS5NO9rzjqE
         ngkpugKR6Fygg0bMM7IKY4m6f2tSB1oAJ1MxffpkJUvZM/6X8ccNrDkXqQDsiwAqX4Ez
         6Fa3zQIKWYUj4cdi+flr5uFZ+1ywX3u5nGBb/+9pyfM4bg5lsM+Q52vIomQlrUuxKi6F
         RavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q9POWu9QQdjXlCxWsG8nhRyoRqIP2kXxcG0Qf/wCB4g=;
        b=fGRws0n7g0BFZr7zHiEKQUriyLzkBbkFt66FQIc/WJCXkoEsdpulNOtNuVLYZhdsBz
         imxJM4zK15u1sQmNAME5J87aikjI4xmbC2Nv9RtCar0RGrkpI9ZQx2I0e4Yur4VGu9xx
         ZgQs8M463eEeDzQD3HkTm1TptEQDzHikhGInbjFqHPPnuwHfZsgCmc9xvthEoCb9gqfA
         QMInf/jbmaFokGoehfnKXwpvks4Fr4RZq9RW/GNe6sSaR4GYsgSmEzXjSTN4nSNrYkW0
         +UZsBfPq5cZjfKhGpvybrM8UsdP4lkTKKNn/bkv13Ye6wka9Y6MkmHJWnXQTqtMuHgEk
         UNlg==
X-Gm-Message-State: APjAAAU9Bslon9fm2Uc4+gFSVyULCgHjPod51JsG11gNQOaopAUkjCrt
        8Vf1Mq4MAE9WOfVuwDEEqRQ=
X-Google-Smtp-Source: APXvYqxFh2T30aiJVZrwFJ4fg7UgrXfuNRbuhdW/gGfmdLi9B8wfIypK0Lxnv4bPvyGHXFEGZPL/Rw==
X-Received: by 2002:a17:902:848a:: with SMTP id c10mr6348557plo.209.1576117650497;
        Wed, 11 Dec 2019 18:27:30 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id d22sm4245173pgg.52.2019.12.11.18.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 18:27:29 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sj38.park@gmail.com,
        sjpark@amazon.de
Subject: [PATCH v6 6/6] kunit/kunit_tool_test: Test '--build_dir' option run
Date:   Thu, 12 Dec 2019 02:27:11 +0000
Message-Id: <20191212022711.10062-7-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212022711.10062-1-sjpark@amazon.de>
References: <20191212022711.10062-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit adds kunit tool test for the '--build_dir' option.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 22f16e66b3c1..cba97756ac4a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -174,6 +174,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_fail(self):
@@ -202,5 +203,12 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_run_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['run', '--build_dir', build_dir], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
 if __name__ == '__main__':
 	unittest.main()
-- 
2.17.1

