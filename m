Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233234F8B31
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 02:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiDGWc0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiDGWcZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 18:32:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB07B2AD6
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 15:30:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i5-20020a258b05000000b006347131d40bso5225123ybl.17
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cStI4M2iFbz1bpv2djlEn4K9jvZmqzWFBgSYSWYF+x8=;
        b=bKVsI5vcdZPGsqrru63SQly3CBZ31oVZnBbHYZ87d93RhGVfNL5XB37zyrUDPJT3dS
         aeqYwWoY4XkBQmdEbTxkcrR7+rk4Pqbg7T9Bn5CSlkmNyGERSCXiypCCtxHmk+o54X3P
         hftJNXyK///uDkU7hQmRlcJPuikUW4/bzsZtcGVu/X1VWbqWL0Ju9L30N6FQrSoTFJaG
         niS/nqfCCPKyL1zx2kiBljKQiob7iMFVqr/AyDwbq5CY1/sk71wq+IQc7rPe0YSrVhwu
         IKngsMf5uNvgBv4E+fXDhWq0cLU58oxZWPCvNn0w7ypxKQqg9IVl37C6F9wVHQ4Wx4jp
         yGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cStI4M2iFbz1bpv2djlEn4K9jvZmqzWFBgSYSWYF+x8=;
        b=trfk6ctteETwQFpsQPLWuSMT+JSwoKYcmMl/OXMLuJOc2DpWlSXA7qK7B0Hco7KCUZ
         E6Hx/494tf6qJ7QFagu5Po2XaIhBE8hUJdJ3Rx4w2SL4bLWKDrI/C+FBQO+pM5kBJpGo
         8+q/Xar/aYgWYqoBy9aEVK+TLBSyhZVTsK8LfZL2RUVu326D74UURPS55BHaqfxZ+ZHG
         Z8B3/7UY9sQmhyzGMWtW7AgrO7CEMdBFrU7ceBv4tM2QiTbf2UM41YwU5iYfVYfdTNM9
         W1nNPaSoKLCgnlTnk3d+cm1iOzKcjDUUsIwApv4Hc0fmDD9OYfypgQNiKfeudBTwNva4
         IetQ==
X-Gm-Message-State: AOAM530Q0V5pwGzBTjlw5QuVN7Hr1zuNezVlMvWH+rM+hI2TL1dZ5mll
        JThZBCSVPM1ezfmG8PJnp3AtfDfus6Jl3Q==
X-Google-Smtp-Source: ABdhPJz/OADY3enFbHtaaMV3WePYz5NmZ0NdIGrSWIhyWxCQcOBcH1W2Eu7hC5d9P9RZVv7HfnyHYxnhFM7/Ig==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5da8:b87d:4887:c585])
 (user=dlatypov job=sendgmr) by 2002:a25:2d5f:0:b0:63d:b7ea:b14f with SMTP id
 s31-20020a252d5f000000b0063db7eab14fmr12271542ybe.625.1649370623103; Thu, 07
 Apr 2022 15:30:23 -0700 (PDT)
Date:   Thu,  7 Apr 2022 15:30:19 -0700
Message-Id: <20220407223019.2066361-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] kunit: tool: don't print out test statuses w/ 0s in summary
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

Before:
> Testing complete. Passed: 137, Failed: 0, Crashed: 0, Skipped: 36, Errors: 0

After:
> Testing complete. Passed: 137, Skipped: 36

Even with our current set of statuses, the output is a bit verbose.
It could get worse in the future if we add more (e.g. timeout, kasan).
Let's only print the relevant ones.

I had previously been sympathetic to the argument that always
printing out all the statuses would make it easier to parse results.
But now we have commit acd8e8407b8f ("kunit: Print test statistics on
failure"), there are test counts printed out in the raw output.
We don't currently print out an overall total across all suites, but it
would be easy to add, if we see a need for that.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 807ed2bd6832..957907105429 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -94,11 +94,10 @@ class TestCounts:
 	def __str__(self) -> str:
 		"""Returns the string representation of a TestCounts object.
 		"""
-		return ('Passed: ' + str(self.passed) +
-			', Failed: ' + str(self.failed) +
-			', Crashed: ' + str(self.crashed) +
-			', Skipped: ' + str(self.skipped) +
-			', Errors: ' + str(self.errors))
+		statuses = [('Passed', self.passed), ('Failed', self.failed),
+			('Crashed', self.crashed), ('Skipped', self.skipped),
+			('Errors', self.errors)]
+		return ', '.join('{}: {}'.format(s, n) for s, n in statuses if n > 0)
 
 	def total(self) -> int:
 		"""Returns the total number of test cases within a test

base-commit: b04d1a8dc7e7ff7ca91a20bef053bcc04265d83a
-- 
2.35.1.1178.g4f1659d476-goog

