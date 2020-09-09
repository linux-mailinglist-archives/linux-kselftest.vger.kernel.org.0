Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB7263854
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 23:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIVRL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 17:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIIVRJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 17:17:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A3C061573
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Sep 2020 14:17:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so3287607pfd.5
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Sep 2020 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCe3ziH+ElemTVm2NqfWzU9PRtLXI604MAgAcQj1O7c=;
        b=hdEHm7z6jg8LsyV0hWWKIoyb509W1HSRjJPTgb0RNsN9MIU/VeTM4XVD4fCgOlssvS
         9aRXKuJu2OhmqVeFGdA/adLLrvq2aDyuOaON0YYTtPw8pgi5E4Rg7mqm4qmSHbGaXLR+
         GrsPXAmMOKCjthtoQDoYmyNycqKI6tTEUmsI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCe3ziH+ElemTVm2NqfWzU9PRtLXI604MAgAcQj1O7c=;
        b=olmhqawux7yeqMXZmC5K+BXbcTOXg1jjmBDa2ewFnQQ2InvUQxDbHnIZdJx5MFowBB
         EXiztU3GrMSgAy7VsCKHpleb4qdLGV61LRMnIpFMRq53Bk9uN9vEVf9Q6DyjoI8zB+X7
         8YnSa4rjW7gI+Q6v1Il6AtFaCO9iMTojluaFjskttdA4zsPqQTM3lDeYmc3nYrBhiACM
         x141LeUx6dvD3F2w5AtoLBBsk6uSCcSHMM8IEUOHNqurt3/wPUTuHKeRBUAPclmuP9CX
         VE85fzSQKLD/9tsL1j8TgC0mzeeDq4RLenvW2G+a8VK0m0Zf/JffgKK3fh9RtWglv9xV
         uunQ==
X-Gm-Message-State: AOAM532TIqUEMMX7RwMS6SUFki1atl8ebH4kN7rQkE/ub+PUNhuhDJgG
        YWEkwBHQYxR/hz1vFq1s91Zc4A==
X-Google-Smtp-Source: ABdhPJy8UUmcbw02VQE4xwOZuH25tjtT7DN/IXk9ewpMdTyFfoUhn/F4CyZLiVVtN/bQK7eC+MFIjQ==
X-Received: by 2002:a17:902:c149:: with SMTP id 9mr1381263plj.10.1599686228449;
        Wed, 09 Sep 2020 14:17:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j19sm3601421pfi.51.2020.09.09.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 14:17:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Date:   Wed,  9 Sep 2020 14:17:00 -0700
Message-Id: <20200909211700.2399399-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of full GNU diff (which smaller boot environments may not have),
use "comm" which is more available.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: add --nocheck-order, thanks to Joe Lawrence
v1: https://lore.kernel.org/lkml/202006261358.3E8AA623A9@keescook/
---
 tools/testing/selftests/lkdtm/run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index 8383eb89d88a..bb7a1775307b 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -82,7 +82,7 @@ dmesg > "$DMESG"
 ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
 
 # Record and dump the results
-dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
+dmesg | comm --nocheck-order -13 "$DMESG" - > "$LOG" || true
 
 cat "$LOG"
 # Check for expected output
-- 
2.25.1

