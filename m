Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8AB41CCF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbhI2T4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345882AbhI2T4d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 15:56:33 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB072C06176A
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 12:54:50 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m1-20020a05620a290100b0045e5e0b11e6so10724199qkp.23
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cmJIpf0DwizpXlrk/HvWpomrFuR6W2E4zR+m6Uv+l5U=;
        b=MT9OV30DeaVmPZQ81HvXbzyPi4vSansk777G+fi0QTkGXydBM5FiCyPyk7TNhjUwkN
         j2j9tdDMyFiXc1etAueGqimaGOYRwwbd68plfIAiL5HuLskDZRFEdC3sSgvSlDSzNNpe
         MbZc8wXMVolQBaPuiyuc5zxO+WrizsKJ6yqgWDoYRudjUAPN3pyUyYKkX056/DLKM+1v
         egcOi9yRZS0XQt/a/eAK+FRItN3tpyxTAAfgfqjxM5CplupNNBy6HD+2KvytGKp7xYf3
         B+bazfnOoBbQB3e3NiC3GKwoCDiQJ/Ber/Fw8QGMhszpnvKm5cH7sBGZoNLLN6mIw2hu
         6fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cmJIpf0DwizpXlrk/HvWpomrFuR6W2E4zR+m6Uv+l5U=;
        b=R5TRB5QNGOGzJ1m+S2Uqe2FAU9EYXWwXegX+MfOm24sZ3Dg0c9k0tKjiMU1AQ2NjxK
         8kjbJcQFjrGIJRw4k/ZTM9/+XLCTX2FHozAEssUs2E5DMbxisFG3pFGpPtEI8FW73NTK
         opSMfDf20QoqRL1KxFRHBno5s68FjYbLlPlaG1An213tJKNdHAr1cpkqirvqtAq3HkR6
         Ba5AYHwGVrsAY5H6QNYCg5xkp+E5bAo3N8dKb+ZsMPNYivq8pc6cFgAELpFdPNpz2f0l
         bRTSR9VJiVDFJuD1spDtiNxe+B0np/J7L+Me4grDd2+l9SNaTX5QhYSvt6/W+1jFP4S5
         JMSw==
X-Gm-Message-State: AOAM531RXAZWY+yeVXjLYQ27srUrOtK62JABKi6G7RUOExC8X+veLwfW
        OFALBNxp56De/wnXLjNLC43nFrA75PfREg==
X-Google-Smtp-Source: ABdhPJxfeptZl2iUjrSyGrbe8zmkprqvzOOpOKXK7kDNqkmogEgEmmhaSKjTNdHiQbPquSGIZPk2N3KWNJhILw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e473:7cd7:9986:85b7])
 (user=dlatypov job=sendgmr) by 2002:a0c:cb10:: with SMTP id
 o16mr249962qvk.57.1632945290110; Wed, 29 Sep 2021 12:54:50 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:54:35 -0700
In-Reply-To: <20210929195436.1405996-1-dlatypov@google.com>
Message-Id: <20210929195436.1405996-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210929195436.1405996-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 3/4] kunit: tool: actually track how long it took to run tests
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a long standing bug in kunit tool.
Since these files were added, run_kernel() has always yielded lines.

That means, the call to run_kernel() returns before the kernel finishes
executing tests, potentially before a single line of output is even
produced.

So code like this
  time_start = time.time()
  result = linux.run_kernel(...)
  time_end = time.time()

would only measure the time taken for python to give back the generator
object.

From a caller's perspective, the only way to know the kernel has exited
is for us to consume all the output from the `result` generator object.
Alternatively, we could change run_kernel() to try and do its own book
keeping and return the total time, but that doesn't seem worth it.

This change makes us record `time_end` after we're doing parsing all the
output (which should mean we've consumed all of it, or errored out).
That means we're including in the parsing time as well, but that should
be quite small, and it's better than claiming it took 0s to run tests.

Let's use this as an example:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit example

Before:
Elapsed time: 7.684s total, 0.001s configuring, 4.692s building, 0.000s running

After:
Elapsed time: 6.283s total, 0.001s configuring, 3.202s building, 3.079s running

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 31eec9f6ecc3..5e717594df5b 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -101,12 +101,14 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
 		filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
 
+	result = parse_tests(parse_request, run_result)
+
+	# run_kernel() doesn't block on the kernel exiting.
+	# That only happens after we get the last line of output from `run_result`.
+	# So exec_time here actually contains parsing + execution time, which is fine.
 	test_end = time.time()
 	exec_time = test_end - test_start
 
-	# Named tuples are immutable, so we rebuild them here manually
-	result = parse_tests(parse_request, run_result)
-
 	return KunitResult(status=result.status, result=result.result, elapsed_time=exec_time)
 
 def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
-- 
2.33.0.685.g46640cef36-goog

