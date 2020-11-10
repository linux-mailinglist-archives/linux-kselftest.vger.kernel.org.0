Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06202AD07E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 08:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgKJH3o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 02:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJH3m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 02:29:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E5C0613CF
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Nov 2020 23:29:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a126so13878026ybb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Nov 2020 23:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RZgsjIDnKB7xNbDoCh6k0wt84803ONPo3Yw+qTs38F8=;
        b=QgFUkXA2SAS1RT3zLRUZQIxgkv6sINiHkdp0k26B9TEPGFujos3tfIMuq162pDwcHb
         25WYHtRA6LVX/3I13vzASjNpOFPYbI/P8NjqJqs1fF/sjHlI0hi7Y0CHLHGQOiuVBHhI
         7eBRhQyZJMHUxZO7OP5cTQ82Ls4RWxR43TyD1BiF8ItQNd5skmmnV7As/j/r5OBO4RZv
         0tBYbHHHiI3zrd9kycipvmoZff6JqikpfixK7kxkbyoMIVWR6tDqB63EcB8EOJQL3hom
         dMusd4FjQw3D3BSTA8wMJV4I4FUn17tRgJQn0xD9JfUYSeJUDl+RENDI04VrkyeX0jT3
         SJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RZgsjIDnKB7xNbDoCh6k0wt84803ONPo3Yw+qTs38F8=;
        b=slfcyQ7k4AOM9s03Hkxk7m8a7G/ibvBz8aIzLS1Qch3dxbiSIwZ/aMx5G2Zr/ArmaI
         0QA2QeTsGK/h4CHeuxofeShj9QTnBS38ElYX4stw+bff1t5u5aRLNPGO388O0S+FzJKq
         lotqoenyu1mkyOjY+IPxYfHR6WoOMJpgeG1tfwDuL86ezBMYVKr5TB6R/7aNMkmNQWDZ
         q7XjXK1pkQrpP6+Os8iimbeeeYI7P16joXJiNVyXqgWcKPHb+f88fd2mRlciLeENOo/6
         PIkNiL0hTpzFMeNILf0sq9DReBYF0FYPpNVVNyVQmE3qerl5qFNHO6bFd7iG5rLxuaAB
         XaOg==
X-Gm-Message-State: AOAM532BnFArdUpjIu19DZGa6r5diEzE0zmN2gveOpeHZUCZ+caXhBcW
        DGkbVJsz8NMHfIxr1WASACMVXcSqTlIhow==
X-Google-Smtp-Source: ABdhPJxKQOR4nA/qXmKTAe5ixBzOeDD/8asYGVAer2CGp+BDwg1r9TEkwAhaQlwUIGcXoZMDnAjGgDEz2EXEtA==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:42c6:: with SMTP id
 p189mr11273929yba.255.1604993380137; Mon, 09 Nov 2020 23:29:40 -0800 (PST)
Date:   Mon,  9 Nov 2020 23:29:36 -0800
Message-Id: <20201110072936.1380718-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] kunit: kunit_tool: Correctly parse diagnostic messages
From:   David Gow <davidgow@google.com>
To:     brendanhiggins@google.com, Shuah Khan <skhan@linuxfoundation.org>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Marco Elver <elver@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, kunit_tool expects all diagnostic lines in test results to
contain ": " somewhere, as both the subtest header and the crash report
do. Fix this to accept any line starting with (minus indent) "# " as
being a valid diagnostic line.

This matches what the TAP spec[1] and the draft KTAP spec[2] are
expecting.

[1]: http://testanything.org/tap-specification.html
[2]: https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 84a1af2581f5..dab4cfa05b74 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -134,8 +134,8 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# .*?: (.*)$')
-DIAGNOSTIC_CRASH_MESSAGE = 'kunit test case crashed!'
+SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
+DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
 
 def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	save_non_diagnositic(lines, test_case)
@@ -145,7 +145,8 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	match = SUBTEST_DIAGNOSTIC.match(line)
 	if match:
 		test_case.log.append(lines.pop(0))
-		if match.group(1) == DIAGNOSTIC_CRASH_MESSAGE:
+		crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
+		if crash_match:
 			test_case.status = TestStatus.TEST_CRASHED
 		return True
 	else:
-- 
2.29.2.222.g5d2a92d10f8-goog

