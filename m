Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7243B21B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFWUTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWUTw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 16:19:52 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA33C061787
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:17:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u11-20020a05622a010bb029024ec154fa8bso3891150qtw.20
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RmgYkSUGYieZikK9NuAnejKxqcMfTNYVkon/vhNrDpA=;
        b=JDc9N5OvdSJNegz1nzRkoYK0b6NVD00mqB26yk0pqMqHKOp00LWfyTyEEUBl4ku1uV
         hgBRCFUt3ZyLRouebPleQ8jJrc9r2h8GYJtog9xIlJy2JD8gLHcGw7MyVHNaOU3m/Sbf
         69bSSaL557ur8AsMXE/mtzVOrSQ0fn3T0l3e06XefXhqCYTUiEiXv350sWc+bZytoopZ
         AmEyQ+grjM2DVxIg1nd4JSW8v7LpTBmNq1TiK9xU6GFFfUuFdfsvbybkqVFAUBdy0hKf
         erlF95CeLqNR3uFDwlcXwI5dOMHBp92z9eiT1+1r+lufRJE8o+hGLckpYG3BnCf64ncd
         dKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RmgYkSUGYieZikK9NuAnejKxqcMfTNYVkon/vhNrDpA=;
        b=CxLEK+uquma7M+vIqRCOHOklI+QFXLC9TsEg/UWKAi3fz/iYiGvEUMJEDD4fASVm8N
         2RJFWhakm6p6mN6jF0BkCpU05WvO/1jRRuGgoTHLauArC1l08YYsYK31Il03KIdy1Snr
         9JBmZ37vyrRnvN5w1DA8uZnf8Y1smHqGDcggNWbk4ZByFCP6l0oUMKcmoDdaM7P19S2p
         +yqVmDcUshMUXSi+5LHGLcmwj7NsLTuCXWkp2L5lRQXClv+Apfp/YPgKiEZWIkPSxmoo
         C/ZkOXhkGYQviRMx8fOMkjJC/vdBQ3e9Ef6YxyeyK6qxSePJU77qZqHzipN9TADHlKEZ
         OVbw==
X-Gm-Message-State: AOAM532nr0+FO9ONU8KDjGthDTGtslmlGOKV4WtrlQM0Vkww01cwC8z+
        U9jBtGSPcDyuIqGH6AI29VJjcK+FEsRrwA==
X-Google-Smtp-Source: ABdhPJxkdnsmg8E4YRob22/u01IZGDNfRjYtFDu8T2ptWaWU7+e6+mGGlpHOGlGrKT6edFUSqigag6AEn74Xww==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bb8a:281b:ed1:24b3])
 (user=dlatypov job=sendgmr) by 2002:a25:8092:: with SMTP id
 n18mr1671942ybk.318.1624479452407; Wed, 23 Jun 2021 13:17:32 -0700 (PDT)
Date:   Wed, 23 Jun 2021 13:17:21 -0700
Message-Id: <20210623201721.980348-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] Documentation: kunit: drop obsolete note about uml_abort for coverage
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit b6d5799b0b58 ("kunit: Add 'kunit_shutdown' option") changes KUnit
to call kernel_halt() by default when done testing.

This fixes the issue with not having .gcda files due to not calling
atexit() handlers, and therefore we can stop recommending people
manually tweak UML code.

The need to use older versions of GCC (<=6) remains however, due to
linktime issues, same as before. Note: There also might still be issues
with .gcda files as well in newer versions.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/running_tips.rst | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 7d99386cf94a..d1626d548fa5 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -86,19 +86,7 @@ Generating code coverage reports under UML
 .. note::
 	TODO(brendanhiggins@google.com): There are various issues with UML and
 	versions of gcc 7 and up. You're likely to run into missing ``.gcda``
-	files or compile errors. We know one `faulty GCC commit
-	<https://github.com/gcc-mirror/gcc/commit/8c9434c2f9358b8b8bad2c1990edf10a21645f9d>`_
-	but not how we'd go about getting this fixed. The compile errors still
-	need some investigation.
-
-.. note::
-	TODO(brendanhiggins@google.com): for recent versions of Linux
-	(5.10-5.12, maybe earlier), there's a bug with gcov counters not being
-	flushed in UML. This translates to very low (<1%) reported coverage. This is
-	related to the above issue and can be worked around by replacing the
-	one call to ``uml_abort()`` (it's in ``os_dump_core()``) with a plain
-	``exit()``.
-
+	files or compile errors.
 
 This is different from the "normal" way of getting coverage information that is
 documented in Documentation/dev-tools/gcov.rst.

base-commit: 87c9c16317882dd6dbbc07e349bc3223e14f3244
-- 
2.32.0.93.g670b81a890-goog

