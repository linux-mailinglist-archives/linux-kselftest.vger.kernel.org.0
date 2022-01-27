Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3322E49EDFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 23:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiA0WRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 17:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiA0WRT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 17:17:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B84C06173B
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 14:17:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y4-20020a5b0f44000000b00611862e546dso8682533ybr.7
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 14:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ng6cTnLsuAPZewV+DZLtymIbJ2l6/2ZMklzgx9Cf0/E=;
        b=aK/uxtVw3OVb2dfiyvGRFtaOYM/RkdPdMTza1qGmRpTkHkeNBvFnSi1NqZ7CJB3hlx
         reiYlNPTlH7W+O4I3DUE5P4t4Y7MPVK0GBODfqdNRdrNTwgTlKDgcpQ57IzwQGNKIIFh
         HkIXxsBkFeWBza5Pg4eqZgxHmDJ5sZQXSjo9i5W5fIlD32ALqRHzqzRFaqIcR2sC65Gu
         C9JTjOchtXDWBG3EGrqC6OwY2BdgDe+3u5ZzZgCD9IAmmIfQ+CY0zVFqNoUQU6DMc27g
         IbvGnFgT2sU7ylJShQhwQZiE1ogIiZsnJdZqpuGTxKgCbg0RyDRTgrGCpr6tOm8UjMLt
         4+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ng6cTnLsuAPZewV+DZLtymIbJ2l6/2ZMklzgx9Cf0/E=;
        b=BOFZLMvxlmLdT6p5EIJkd/KzQndREP1R6/B+7gGdpKV1KiJi1dKVcfMkIbsQMlpCc0
         w5LMcQOvHczsgEsyaDVutPD96XIHmz4vHdyNGzm2xYe6XqNn7d5q3jiw35GT/kqVtfl+
         QyHBf7Tt0rkoM0inEnmCjQKg+00Ht6ULU6t5Bu0hlJkMri6Q1r2D/k17zhZ6l3p/tImq
         yKNPOQvOrV0TcoZsMXpSTJrHMmUdYw3BxIq3istI03EblRb3teRgR/A5J2k+hy8VAlif
         kLaB6LZjXcBdVPb/0ljb7DYRBsoXE4uB/ewA4HZ5Hau5+hjSawdoi1FNbbln51CPhIU3
         wKPw==
X-Gm-Message-State: AOAM531z2eDzfnUvQSF4bX9cf8RMvoy9H4ylNT05cQDf3LTxaS9mILpQ
        8R+OZvTPa9Tevg3v3FeZObx1C+KAu5zulQ==
X-Google-Smtp-Source: ABdhPJx3O5plmb71BP71pNiAZH1OVetV56XjM5wtIeRSySbzFeJk2kmTSjN+rzssphFCL5a7G96JJ/WrjZjobg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5484:2aa:f5f4:a1e0])
 (user=dlatypov job=sendgmr) by 2002:a25:cf01:: with SMTP id
 f1mr8060763ybg.389.1643321838253; Thu, 27 Jan 2022 14:17:18 -0800 (PST)
Date:   Thu, 27 Jan 2022 14:17:10 -0800
Message-Id: <20220127221710.165733-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] kunit: fix missing f in f-string in run_checks.py
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We're missing the `f` prefix to have python do string interpolation, so
we'd never end up printing what the actual "unexpected" error is.

Fixes: ee92ed38364e ("kunit: add run_checks.py script to validate kunit changes")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/run_checks.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 4f32133ed77c..13d854afca9d 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -61,7 +61,7 @@ def main(argv: Sequence[str]) -> None:
 		elif isinstance(ex, subprocess.CalledProcessError):
 			print(f'{name}: FAILED')
 		else:
-			print('{name}: unexpected exception: {ex}')
+			print(f'{name}: unexpected exception: {ex}')
 			continue
 
 		output = ex.output

base-commit: 6125a5c70acddd9fc1fb7329047a254c74d0173c
-- 
2.35.0.rc2.247.g8bbb082509-goog

