Return-Path: <linux-kselftest+bounces-1449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C1A80ACBC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 20:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6051F2126A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1F1481CD;
	Fri,  8 Dec 2023 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLlkJo3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BC10D
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Dec 2023 11:12:31 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d942a656b7so30502847b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Dec 2023 11:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702062750; x=1702667550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4FGZcnm1uluLFPaSEUNrvTfpJlOw0WcvKHKK9pE/vY=;
        b=rLlkJo3m3jGjf4q0m3BDBDAuxYMa2f0ouPf3UlWAfJxjDvmafE8Hr3+z5hrvR4YXLB
         f6q/y4xmbA0+AaF0DiGQSeNlhmFV6Q48S58sg0pvOIK1AlyT/n1Hthf905KMqjR4PkJh
         4XRgezhWv2PVzxPvIWB5gf+2c3mNjn1pC2ujTFwg3ey8ACvQkB5K+bYNOU+qK9a6Cdm9
         LPs36/hM7Ps2Jks5mcXzN+aUGrX1lL3SxC14Y0H72LVq18HhBY9OiuCbobSxt4gjGfOt
         iJDHvH3KMSLoYTzWIevbjnzkJNxC5ZGBD1P4Y6VkKxfOIhzktlklk++1X/0Njiin09Yi
         bpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062750; x=1702667550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4FGZcnm1uluLFPaSEUNrvTfpJlOw0WcvKHKK9pE/vY=;
        b=gi7H8SI86dF0XyyiPsc4AD6fR4kcz0YPO3GRR+BFeA2bEQbi/WNPnqAkspxvH2/l17
         HJ37PGfRvGEdTgW47gos40nrSgClhh2oOe+iccQ7uyRIr8QGE6s+xV/4nn1WgFIlF3u+
         4pj9MxFrYy5YfD4xzehGvwpCrdimJjcW+mAxDcAlOinSEYWrB1esIZkbB8qytdkbXXSq
         EeqQHP/DcExqWqaYDySKKdMNG7ApPIHTvKq4eaNYRArAML2oVVOOs3wyQOirHzCbwM5h
         G753DB67WhHZwhKrj/FUGicopzVTqPUmH36wq51/83xHvtpdj57qqlG5hCI/VDLZFp4t
         kIyA==
X-Gm-Message-State: AOJu0YzklbT09sVpPbTH8bOGT8s0ZRoxsnCUsphUH39fblOjVHjbHWtY
	Rq0cGifqrSrq9J635st4l/u3HucSBg==
X-Google-Smtp-Source: AGHT+IFz9RNgqFFJNGwhiJxIZm6Fz0EpoDETu6m3K4Q6CZzE7fMeSwt4lm+teSXQXGq7RC8mPelDicLLRA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:c1c:b0:5d8:8d39:f67e with SMTP id
 cl28-20020a05690c0c1c00b005d88d39f67emr5720ywb.7.1702062750743; Fri, 08 Dec
 2023 11:12:30 -0800 (PST)
Date: Fri,  8 Dec 2023 19:12:22 +0000
In-Reply-To: <20231208191222.630119-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208191222.630119-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208191222.630119-2-rmoar@google.com>
Subject: [PATCH v3 2/2] kunit: tool: add test for parsing attributes
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add test for parsing attributes to kunit_tool_test.py. Test checks
attributes are parsed and saved in the test logs.

This test also checks that the attributes have not interfered with the
parsing of other test information, specifically the suite header as
the test plan was being incorrectely parsed.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_tool_test.py           | 16 ++++++++++++++++
 .../kunit/test_data/test_parse_attributes.log    |  9 +++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tools/testing/kunit/test_data/test_parse_attributes.log

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b28c1510be2e..2beb7327e53f 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -331,6 +331,22 @@ class KUnitParserTest(unittest.TestCase):
 			kunit_parser.parse_run_tests(file.readlines())
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
 
+	def test_parse_attributes(self):
+		ktap_log = test_data_path('test_parse_attributes.log')
+		with open(ktap_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+
+		# Test should pass with no errors
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=0))
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+
+		# Ensure suite header is parsed correctly
+		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
+
+		# Ensure attributes in correct test log
+		self.assertContains('# module: example', result.subtests[0].log)
+		self.assertContains('# test.speed: slow', result.subtests[0].subtests[0].log)
+
 	def test_show_test_output_on_failure(self):
 		output = """
 		KTAP version 1
diff --git a/tools/testing/kunit/test_data/test_parse_attributes.log b/tools/testing/kunit/test_data/test_parse_attributes.log
new file mode 100644
index 000000000000..74df125d0863
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_parse_attributes.log
@@ -0,0 +1,9 @@
+KTAP version 1
+1..1
+  KTAP version 1
+  # Subtest: suite
+  # module: example
+  1..1
+  # test.speed: slow
+  ok 1 test
+ok 1 suite
-- 
2.43.0.472.g3155946c3a-goog


