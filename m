Return-Path: <linux-kselftest+bounces-1383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F658094BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 22:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBDDB20A1B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19462563B9;
	Thu,  7 Dec 2023 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzZ30J4s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3774784
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 13:34:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d67fc68a82so16338167b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701984865; x=1702589665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHU5YaTcNBQsG81gTEGmTL6T2FG7lJRntfdwIVI0JxE=;
        b=HzZ30J4sxVPo/p8CNdxpezWdqNjSqnjl9rCLm0XyFiDERXJvGlQQB//JvHlDNaftxF
         6XwslLMyzJCYdaIc48hKaYeHmLbP/XUW8+z83ay95bj1h9PsXgtVKndT+8zKIMTlI3sp
         bx3VSCPY+lgGxp7c+zV69q13OiBvJUQ/o7Z/FbjXK5xPfoyGnNloiHH5TAalUaeCNdn5
         1VISW6agL5Tyv7wc5qFgbxiHfR6D29maCXuup4+gpx+VRgrMCICJmpoCexywMKDCVtNE
         bDd+rNQSVka/4HRQz4lBDc/knHyEstKrK9xDLxxz6Xusym+6RQxOrnhbzkjrYcWV+iaw
         gcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984865; x=1702589665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHU5YaTcNBQsG81gTEGmTL6T2FG7lJRntfdwIVI0JxE=;
        b=YcZKJfmTzLlO6Ho3/FKsY2cOctb7zcY1Yvkm7+CcfYMoD+zSAtPqfiWnNY5vSr+KR0
         1SigQI7+KvQcTzSPmNCx5gE1+goQaQsrq2RES4AoglKlJ6a7HEboSAGCrhUxZG9Hp1CC
         E7jmCAonI6oUrboinVuGjQrqsK1fJ3xMa4b/kMhlmL7YQL3Xmv6NZRc2PT+500/DK7br
         8aphFhEyGNg0MeG0/Elt8FP+YMlJntrmNf8MwuR6KFJhzK2F7o3P69qPGX5tqjTTXpfb
         pShk09sOgDc1MPHiViAmXW1caz3CtzUq0+7ekrWJ5xxYss4kMGCluWHZ942WcoXcUsdz
         F7ag==
X-Gm-Message-State: AOJu0YwqVRW8vie/X1avJRkcloj5fE4YUzPlXuhXis66yVprvi034ZFg
	CHOm0mjG3KrLYnlX73RXpatysAA+0w==
X-Google-Smtp-Source: AGHT+IEZKCrsH1xkOF2RQlJeghzypFLltAvtQadwuDk7oRPwDM5B3HQNivo6VPZzxQJSpsr6jXtRX+1MSg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:4687:b0:5d7:7d30:595c with SMTP id
 gx7-20020a05690c468700b005d77d30595cmr41357ywb.9.1701984865678; Thu, 07 Dec
 2023 13:34:25 -0800 (PST)
Date: Thu,  7 Dec 2023 21:34:10 +0000
In-Reply-To: <20231207213410.417564-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207213410.417564-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231207213410.417564-2-rmoar@google.com>
Subject: [PATCH v2 2/2] kunit: tool: add test for parsing attributes
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
index 000000000000..1a13c371fe9d
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
\ No newline at end of file
-- 
2.43.0.472.g3155946c3a-goog


