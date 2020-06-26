Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF0C20BAD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 22:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgFZU7q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 16:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZU7q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 16:59:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004E9C03E97A
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 13:59:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so4646665pgg.10
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vzE/LHOrs411ALZFAPX5s4XQ3VOyYMCpxKznqqbDvQ4=;
        b=TI8Zc7pt4AdbPofHKO372L5Kta8OeeO3t3PXk/6qhNeAO+yCbS0Doy0WS9y2bVqgZ/
         tI4T3y1zUN+TnjuQXTcXv8tWquNbcXAoocAEuAFcTaqkXpiPwLgebf3YagDWZMlxOhlz
         4G0CXBgXdsf2kQOWXSTX3CW+pV7onm4JkG2bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vzE/LHOrs411ALZFAPX5s4XQ3VOyYMCpxKznqqbDvQ4=;
        b=ar8TePiuHflGKh/2tyR8IaQcO8OV3RPZ6mXHxNwJPK4dJwPHtqC2iJ5o3mHZykoTEh
         6maeU+a6s4ICGvFVA76nRwEIYY+r7owMeW8nr965dbjEhOwDBEnUA2BwZkLhmsXua2fp
         YiA0V0XVHcgHgcdjWNmF7Jg17p1t3a/M6x8r1UURgii3zbr4gCHN5MefWd9a/jNbsCCI
         6AasfU4Vvl3K3J3dIN1ngpUKbYkY7baFKgmjG+IrPh3CcxsNyI8lkYbZg54PDlv+BhHI
         cd84GOGJzhSfpP5nA1zMn4zML+rgv8Gvcgt1I/1kJetJXCB1a7HmsbvGQ/HxLJl/Vjzi
         kEJw==
X-Gm-Message-State: AOAM530BxhPxgbntxWXt4tkwWI9cn7/GUS9Ic/NCXcwHkcvhWTKUSFgu
        n+S9uUQLCmWDJftHV/MuLsTx8A==
X-Google-Smtp-Source: ABdhPJy9ZcI5XAF6R6FENmskB+t4X3sgpFeAprNtq3GGr6iredh9lEzDpleAFN9acuLpA/roa4lVGA==
X-Received: by 2002:a63:c44b:: with SMTP id m11mr522600pgg.404.1593205185366;
        Fri, 26 Jun 2020 13:59:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm5673856pfr.149.2020.06.26.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:59:44 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:59:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Message-ID: <202006261358.3E8AA623A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of full GNU diff (which smaller boot environments may not have),
use "comm" which is more available.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index 8383eb89d88a..5fe23009ae13 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -82,7 +82,7 @@ dmesg > "$DMESG"
 ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
 
 # Record and dump the results
-dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
+dmesg | comm -13 "$DMESG" - > "$LOG" || true
 
 cat "$LOG"
 # Check for expected output
-- 
2.25.1


-- 
Kees Cook
