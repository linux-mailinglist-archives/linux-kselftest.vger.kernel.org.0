Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098F6492E29
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348255AbiARTJg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 14:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348626AbiARTJd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 14:09:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A18C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 11:09:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 22-20020a250216000000b006120a553e38so17822268ybc.16
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 11:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fmfn3We7VsrsY7wrkxlW3pR6M2dzD1H8QDdPZW64NZc=;
        b=f+21jvzpsJ3yL5GfZIkzW7/2AvnrtvGj3rlxRCr81yyiW38TLpyLkPfPt4EbUh8xlS
         NatkFdyZfC2w2iye2j9apDGvJ+JjccLnw5Hva3N+zUWyjD94JOh2Lr2eGMPSIEIcvoqq
         7hN4DYKwyFQVg2tlRK/gcoOlfBlPqIDEUSSeZO8FUpTE+C0QwKor9V8lvhmXb6Ukq3JZ
         +QTtvABrDPNjIe9mIQUtdsZJu5RVSUeS/wjNEu/uv5f8Un+ocQgQX2pv+06qwHTRev5l
         p99f4AqQtRMvJGGZOIV1N1yh6pK+Zb8JY4Kqk3Rp63yDc+WNDnV5WLR+X18e2pwMg7UJ
         Sgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fmfn3We7VsrsY7wrkxlW3pR6M2dzD1H8QDdPZW64NZc=;
        b=pBO0pnGcSj0Chau9Hvlg4Bvki7K78zZHKkJQzNjMWdKeoyJ48Z0eTWfczrU+tmvv0N
         D4Mp2iK4VHvPhV0WC7U7F44MC7I7tax6u3U/5VX8wgwbtZkxtquUmNdw9dHFda8eVWq4
         Cy5JXkT4TwYfbEtZp5JuMNSc16yu4ETnvDgJMw1laqvO+5edPwK4hxiEhGv5++l55a+g
         PUFm49ZVt57sB39f08x2ZRhEbmMr+FcWS19uR9j1z3BwlfgeNgGKPXFsQAaYLLygmNvX
         n5HSX3JzFc7N0IW8i5zsN42g2XvJig91pbFmxYl4EuUfaU+1svmn57s36CFVJidlhrxb
         4TeQ==
X-Gm-Message-State: AOAM532VYaQWliT00wp/HdpTxtcoSTmzGVbee2hUq29HxEbC3U4bRJXM
        sdsUpMZf/5bgaEzZBvVzENIcnzfkplnz4w==
X-Google-Smtp-Source: ABdhPJwSFxL26e6iffOomUtTAD4T5f3FLnPtQXUL9frbTS3UYPwdOS6hgRrdXYmGhP7HV4uif82OH1khaQgKrQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a25:7e46:: with SMTP id
 z67mr6316308ybc.595.1642532972177; Tue, 18 Jan 2022 11:09:32 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:09:19 -0800
In-Reply-To: <20220118190922.1557074-1-dlatypov@google.com>
Message-Id: <20220118190922.1557074-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 2/5] kunit: tool: make --json handling a bit clearer
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently kunit_json.get_json_result() will output the JSON-ified test
output to json_path, but iff it's not "stdout".

Instead, move the responsibility entirely over to the one caller.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           | 12 ++++++++----
 tools/testing/kunit/kunit_json.py      | 12 ++----------
 tools/testing/kunit/kunit_tool_test.py |  3 +--
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 9274c6355809..bd2f7f088c72 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -216,13 +216,17 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[
 	parse_end = time.time()
 
 	if request.json:
-		json_obj = kunit_json.get_json_result(
+		json_str = kunit_json.get_json_result(
 					test=test_result,
 					def_config='kunit_defconfig',
-					build_dir=request.build_dir,
-					json_path=request.json)
+					build_dir=request.build_dir)
 		if request.json == 'stdout':
-			print(json_obj)
+			print(json_str)
+		else:
+			with open(request.json, 'w') as f:
+				f.write(json_str)
+			kunit_parser.print_with_timestamp("Test results stored in %s" %
+				os.path.abspath(request.json))
 
 	if test_result.status != kunit_parser.TestStatus.SUCCESS:
 		return KunitResult(KunitStatus.TEST_FAILURE, parse_end - parse_start), test_result
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 6862671709bc..61091878f51e 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -51,15 +51,7 @@ def _get_group_json(test: Test, def_config: str,
 	return test_group
 
 def get_json_result(test: Test, def_config: str,
-		build_dir: Optional[str], json_path: str) -> str:
+		build_dir: Optional[str]) -> str:
 	test_group = _get_group_json(test, def_config, build_dir)
 	test_group["name"] = "KUnit Test Group"
-	json_obj = json.dumps(test_group, indent=4)
-	if json_path != 'stdout':
-		with open(json_path, 'w') as result_path:
-			result_path.write(json_obj)
-		root = __file__.split('tools/testing/kunit/')[0]
-		kunit_parser.print_with_timestamp(
-			"Test results stored in %s" %
-			os.path.join(root, result_path.name))
-	return json_obj
+	return json.dumps(test_group, indent=4)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 352369dffbd9..f7cbc248a405 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -469,8 +469,7 @@ class KUnitJsonTest(unittest.TestCase):
 			json_obj = kunit_json.get_json_result(
 				test=test_result,
 				def_config='kunit_defconfig',
-				build_dir=None,
-				json_path='stdout')
+				build_dir=None)
 		return json.loads(json_obj)
 
 	def test_failed_test_json(self):
-- 
2.34.1.703.g22d0c6ccf7-goog

