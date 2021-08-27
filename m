Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CEA3FA1A6
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 00:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhH0W7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 18:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhH0W7S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 18:59:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B60C0617AD
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 15:58:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q13-20020a25820d000000b0059a84a55d89so8090066ybk.23
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1vVn3tT4i3E1FmbURQDOaSj4WaBWIdDZC/BLf0YptVo=;
        b=amWWbC4Vd2VlctVqbhne1QKiw4B3hrhIb4FhT4FizxwTOMAgV7eULVijyk+3PVUZl3
         geP+wc1VfDExeq9hMedHt+dEh8yCqxDeOaW+DXQZrfa2fD8iAA5ShrKgwVHVfiphOFb+
         EVX35GpTlIEEXY1HpFuFxtjIu1U8RKscpyj/neSEFUl6c6hk1Y09chRFSMFTMfZA33n1
         Skvd0ELdhLLh3HdLm1LIPVcowumewcyvU+a0IwiifnBmwV8ZVLpMh2w52HxVrXmdihuv
         GFaZm9dRvZJLcYOK24g/OXezZs1BUTjAzokqRGTgfZiAQdg7l/dDR1iLW4liR30WRvc+
         sqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1vVn3tT4i3E1FmbURQDOaSj4WaBWIdDZC/BLf0YptVo=;
        b=XEgfH70k12ixsWwKbGyOF5fF//QjFNU7iNp9jgYT2j2icI6gEFDjxP3gnuF2//lQqw
         JNCaO8dvM8XdKIJHyIJG8EnXca8FszeMmXLvAEio0mak7FVNHlAku4WwfQ+FtrbVRi/H
         F1RIe0T3kstRpuoa3e51ujj6IPk5dXMhz1WE7wgxPd6NNTBuy9hS7VSdpUerMs8QRqJN
         8Ik2Xfpdf0tSUDhlt6Lf54HwTrALSgu5tg9ZPwkRyOxJ7KcGqn9KBB0+zE31cIlfE75c
         uhTllqH0p6gAOnJhb/vt+Izr8/4/SY++3QkZ7ZJDBy6vHa2eS9x68QGT18p/188RlasM
         POng==
X-Gm-Message-State: AOAM531DVwYFa8DlE0VKN+bdBDG/QIKFfcSw6h1gzMvNVYIYwsKTXbcT
        HTjLm//d74xmflvi/UyFJIE6O7TDNw==
X-Google-Smtp-Source: ABdhPJxYJKi9TruSA6ySOacyal37q2p6g1uxh23QfUPvKU++OzDjQwdfE9PbLpLJFBQ5IRxHcLJ5qGpmJA==
X-Received: from sunrae.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2814])
 (user=rmoar job=sendgmr) by 2002:a25:b810:: with SMTP id v16mr8723586ybj.357.1630105108003;
 Fri, 27 Aug 2021 15:58:28 -0700 (PDT)
Date:   Fri, 27 Aug 2021 22:58:12 +0000
In-Reply-To: <20210827225812.3247919-1-rmoar@google.com>
Message-Id: <20210827225812.3247919-3-rmoar@google.com>
Mime-Version: 1.0
References: <20210827225812.3247919-1-rmoar@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 2/2] Revert "selftests: Remove KSFT_TAP_LEVEL"
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, keescook@chromium.org, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit f41c322f17ec4aa809222dc352439d80862c175b:
https://lore.kernel.org/linux-kselftest/20190424231236.aWGsEs-_2b6p3DpN3b_4U1xGERmHSv45uBzgjf6RIRk@z/

This patch removes nested TAP headers in kselftets TAP results and is part
of a series to alter the format of kselftest TAP results to improve
compatibility with proposed KTAP specification
(https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).

Signed-off-by: Rae Moar <rmoar@google.com>
Change-Id: I24e74cacfc49a90a068eb30ee1448c097de5297d
---
 tools/testing/selftests/Makefile            | 6 ++++++
 tools/testing/selftests/kselftest/runner.sh | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index fb010a35d61a..3bbfb83e2252 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -122,6 +122,12 @@ else
 	endif
 endif
 
+# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
+# printing from tests. Applicable to run_tests case where run_tests adds
+# TAP header prior running tests and when a test program invokes another
+# with system() call. Export it here to cover override RUN_TESTS defines.
+export KSFT_TAP_LEVEL=`echo 1`
+
 # Prepare for headers install
 top_srcdir ?= ../../..
 include $(top_srcdir)/scripts/subarch.include
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 9b04aeb26d3a..40ce901cb38d 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Runs a set of tests in a given subdirectory.
+export KSFT_TAP_LEVEL=1
 export skip_rc=4
 export timeout_rc=124
 export logfile=/dev/stdout
-- 
2.33.0.259.gc128427fd7-goog

