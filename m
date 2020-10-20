Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8515294575
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405819AbgJTXcr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403818AbgJTXcq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:32:46 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2FBC0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 16:32:46 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y77so139346qkb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 16:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=E9uxO3CjxUS2kC6NcJgLaAvLCBGXBzIc+1gLUHWGOek=;
        b=LB2sZ/NbYi//qqW3C37gTvqG+ngqGM3cMsQL7BgMqthFE+/XGYKIwm9VoEns+T6E4W
         XGddkM0BpRHry/DrBJpP7b/X9dx9M2VzQj/uKP5G1wN4Z85ffdRT8qQd1GBy8oBqKUog
         IOy38cWVyhi9AGd1IqgWwBe2RJUNbyrIwSPuRQN2shBN+lPlQnXQGr6zSka+9BtzLfec
         lROvUCuILrrCnXyf0naC8eozoMJdmir1bljgQMxOtCICZj/UGwJoP0dAWxGkyZgsjcc9
         udLNzpyGCuYkp1UTfnIpt+pThW5mT2DVzz5dEzUHrwOVZdGPm1TV5YScWKNSzoFw0UQz
         gGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=E9uxO3CjxUS2kC6NcJgLaAvLCBGXBzIc+1gLUHWGOek=;
        b=P5io1jxGiQptV3EstjphIoGKr6W5fOvIlmpTe9LZQbPnpz6zMgrC07j7eGedfI8mFa
         36rNViVYq9kp4UndfYrxCfX9Qyi9CXyCXoNXn07MPusuFthS5NMXrwJmdX+/SzIg/l7L
         /S7dA4skozT+XooN9SxbNAlBRgHN2Q6FQvPwK1zDQtSAobbwtPEFG6ulj798oTY1V/69
         usakudE8lDTYRIB7qXxSMgw9N9+PDi5pd70IrOPT7ZRoIR6xJKnJDFi2Ww9zhU4QTVKw
         3ptppL6+ghf8+sSTu/mzNBdWNUywuYpyJaiQ8H7A7qj8YYd/aJo1DbXI/gUsqX/YQ007
         vr0Q==
X-Gm-Message-State: AOAM531qgLQIDaUZ/unTTiUY2ClPeU8ToYKOx3+Uj0PDYYM+6zw4lARE
        TX+cbSQ+Rjw7vfj3U5Syjp7guAwPcTa2tA==
X-Google-Smtp-Source: ABdhPJws7EK3mtUONqq0sUL0LOCu+Y4SMSgouYWHDftgo5x/ed8PQNzB12o6a7vIUTNBQifWcHQJbcQfkDtOFw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:184c:: with SMTP id
 d12mr266418qvy.11.1603236765716; Tue, 20 Oct 2020 16:32:45 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:32:19 -0700
Message-Id: <20201020233219.4146059-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] kunit: tool: fix extra trailing \n in parsed test output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For simplcity, strip all trailing whitespace from parsed output.
I imagine no one is printing out meaningful trailing whitespace via
KUNIT_FAIL() or similar, and that if they are, they really shouldn't.

At some point, the lines from `isolate_kunit_output()` started having
trailing \n, which results in artifacty output like this:

$ ./tools/testing/kunit/kunit.py run
[16:16:46] [FAILED] example_simple_test
[16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29

[16:16:46]     Expected 1 + 1 == 3, but

[16:16:46]         1 + 1 == 2

[16:16:46]         3 == 3

[16:16:46]     not ok 1 - example_simple_test

[16:16:46]

After this change:
[16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
[16:16:46]     Expected 1 + 1 == 3, but
[16:16:46]         1 + 1 == 2
[16:16:46]         3 == 3
[16:16:46]     not ok 1 - example_simple_test
[16:16:46]

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8019e3dd4c32..e68b1c66a73f 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -342,7 +342,8 @@ def parse_run_tests(kernel_output) -> TestResult:
 	total_tests = 0
 	failed_tests = 0
 	crashed_tests = 0
-	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+	test_result = parse_test_result(list(
+            l.rstrip() for l in isolate_kunit_output(kernel_output)))
 	if test_result.status == TestStatus.NO_TESTS:
 		print(red('[ERROR] ') + yellow('no tests run!'))
 	elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:

base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
-- 
2.29.0.rc1.297.gfa9743e501-goog

