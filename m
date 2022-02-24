Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B654C35BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 20:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiBXTVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 14:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiBXTVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 14:21:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B61F03AD
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 11:20:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x1-20020a25a001000000b0061c64ee0196so756967ybh.9
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vE/X1GbuMiKSRX0usgoudNG0PjnPYCjAGGaX0qNgdQ8=;
        b=FyIQHr8etZ6mQPzxRUPRdn7PmSB8K6WWQcG0zuVMBr9gpJ/alDA89zNcWsJ4HuE6CC
         SgTlSwM7IDbbLSAKUZP59OTJEtIB8IZFMGa5PVl+3S1BqdxMEvz1zd3WqUp6DmoXfLVw
         MDyNu2RMhZiAhfdoTZWxAG0mtU4YSLTE6urpO5x6G1xxSryZmnQKbD4Rpw6pvIxCEbt2
         yn5c6PvJOKsMbtUqTwnYRgRJ2HbSxZJlIm56fARhp+LJfl65uZME7oNNb/Ef5JzWKOGz
         vE5iyL3XqhvmivHQYhP2reoPfdSessoG5yU+JV8uarMTW9k9CcJPvGdWgx5CPISAh5si
         c1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vE/X1GbuMiKSRX0usgoudNG0PjnPYCjAGGaX0qNgdQ8=;
        b=mIp3Ui9xKiV0u+REfM1kM+usGuRaR+S4B2sDvjM4xxN4wPJKiPLXUBmawRCCNUN1kF
         EaIwiaMrWLPQ4gYxMxBXOUWq9HgIwgMhYJwon8nNzNUQhTPMjZjujBcl9Geil2kjnfl9
         Nih0z8rzlZZV6BTy45E+a9Cpynok+yt+l/bgzCaA2CEPGz3STTgVDG0vXtg8rrZwoKWF
         U2e0SxHyGjC/CAhGChSWPUOYBKh6f/7JAOcSi6ye4lNRRe3Nw+CihM/htCofOIAZoq0E
         9/jzHeEAP3GEkT8Ne8/tAqpYAPjuibSaAP1jKNQWsL64AvxVPwc5DB6fCWsW8qwjBhkf
         qNhQ==
X-Gm-Message-State: AOAM531kX+UwlfL3xJeji9xAwEFPRjtxTM5dHy1di9GHOkaMgjRGC5I3
        Zem9yjuxjzQnAqANV7VqbFWKPH4OAudBeA==
X-Google-Smtp-Source: ABdhPJx3bs6AIpTEF94dmhDZdm3O1wxL83posi8M5rPdjILtbKKCumct8m3TAQP07sYhvg4456vXi9CepZb2uA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:96e5:fbf5:15ed:8b6f])
 (user=dlatypov job=sendgmr) by 2002:a25:aa4a:0:b0:624:6220:e4f8 with SMTP id
 s68-20020a25aa4a000000b006246220e4f8mr3869090ybi.531.1645730452359; Thu, 24
 Feb 2022 11:20:52 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:20:34 -0800
Message-Id: <20220224192036.2388302-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 1/3] kunit: tool: readability tweaks in KernelCI json
 generation logic
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use a more idiomatic check that a list is non-empty (`if mylist:`) and
simplify the function body by dedenting and using a dict to map between
the kunit TestStatus enum => KernelCI json status string.

The dict hopefully makes it less likely to have bugs like commit
9a6bb30a8830 ("kunit: tool: fix --json output for skipped tests").

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_json.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 24d103049bca..14a480d3308a 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -16,24 +16,24 @@ from typing import Any, Dict
 
 JsonObj = Dict[str, Any]
 
+_status_map: Dict[TestStatus, str] = {
+	TestStatus.SUCCESS: "PASS",
+	TestStatus.SKIPPED: "SKIP",
+	TestStatus.TEST_CRASHED: "ERROR",
+}
+
 def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
 	sub_groups = []  # List[JsonObj]
 	test_cases = []  # List[JsonObj]
 
 	for subtest in test.subtests:
-		if len(subtest.subtests):
+		if subtest.subtests:
 			sub_group = _get_group_json(subtest, def_config,
 				build_dir)
 			sub_groups.append(sub_group)
-		else:
-			test_case = {"name": subtest.name, "status": "FAIL"}
-			if subtest.status == TestStatus.SUCCESS:
-				test_case["status"] = "PASS"
-			elif subtest.status == TestStatus.SKIPPED:
-				test_case["status"] = "SKIP"
-			elif subtest.status == TestStatus.TEST_CRASHED:
-				test_case["status"] = "ERROR"
-			test_cases.append(test_case)
+			continue
+		status = _status_map.get(subtest.status, "FAIL")
+		test_cases.append({"name": subtest.name, "status": status})
 
 	test_group = {
 		"name": test.name,
-- 
2.35.1.574.g5d30c73bfb-goog

