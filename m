Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC58441E3C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 00:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348468AbhI3WWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 18:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348503AbhI3WWm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 18:22:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B794C06176D
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:20:59 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e5-20020ac84905000000b002a69dc43859so13111073qtq.10
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZWOGiAg/qbE1DMbUltGKFl+kd+3yzrZtbswNYmTN0Nw=;
        b=JA1wjF/eWT7CmE0a0OIWWBxASbq7N8xp0S4DPIFLF9PYDmApZ2F2mdWMioiCdit3Px
         uBwDISb+JMb/odfZQ8p/0LA7kLjlhbSl3zjZbVzzxSFjEqA1/RYNPIshbvxMxLcmerLT
         8JpLNwO+vWnBW8SaWPIvBAis6iNvV9QRoP43ISe//q8UGnLmbk7hn9b4dWKG4nCSr7u9
         Ip6WMEuHV9j7KEklRbq3dSYJG2696/dFF81jSdYWJCLVgCaXfyzYwNuSRON+aMhEuOL1
         54s3JfxVuWwDjCts9wsJA1JPuHcu6zNZpS6kDdDulu6akDIL1ZbB1BkMgzP3oH/D+wdA
         KCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZWOGiAg/qbE1DMbUltGKFl+kd+3yzrZtbswNYmTN0Nw=;
        b=Qxw3nPc83XuyGARfVtLPuo8HFfrtZ5pcroYQZdlsgwor+bc3IY+qpZPxEhoWrYv0JK
         H2RfpUU/wNsrLT/fvjuyVJnMjbqhEHDFgfpz+ldr0M5qEzvh+Cc/riDgOcPo8MzMgRzt
         /Tfkgds/zTSRTIRR7cGXJjqXoF+ifM7aGh9649x6SN0qS7sVomgu9n8uR8ItgH8fFCqj
         K+19FNL9tg4/CLqNFS9FOhhZ74L4/+MGbYNq+OXst4+y+zINgmuM0lwYegDHKb3TngLL
         yeDw9z8VLyFo3rLbDLfWlblWLvxGSoqdvzB2pr2GOX+Em43onRn3QbF+xazy+qq5y5/f
         GGng==
X-Gm-Message-State: AOAM530okX4f/ZxJv9LAZZLBBWi8z22BiiJk42UU3L40mDBqB39FEA/y
        Z6pjpWg2N5Px2U1LwnbFlNl2BaouZJzLoA==
X-Google-Smtp-Source: ABdhPJzCFMpymrlXlK+2UISUmsXAl92IYZVh24P5/61JzSVs99JDDUxgA8owqscTMiekwepyo+F0b4nM6euQJw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:39fa:d88:fb3b:880e])
 (user=dlatypov job=sendgmr) by 2002:a0c:aa99:: with SMTP id
 f25mr7773849qvb.12.1633040458354; Thu, 30 Sep 2021 15:20:58 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:20:47 -0700
In-Reply-To: <20210930222048.1692635-1-dlatypov@google.com>
Message-Id: <20210930222048.1692635-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 3/4] kunit: tool: actually track how long it took to run tests
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

This change makes us record `time_end` after we're done parsing all the
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
Reviewed-by: David Gow <davidgow@google.com>
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
2.33.0.800.g4c38ced690-goog

