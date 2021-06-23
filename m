Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932D63B21E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 22:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFWUmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhFWUmF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF77C061766
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g4so2207671pjk.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/NHLnzJB2ygZFZV6tY0zJmtOu+fbM3j2iEZapLwC/A=;
        b=I/banPaTpbTehL6OdlALe/IibBFT5OlgTdWS6XNKoIoXm+GiZtXArwzsPg+rtwRkgg
         NmrSVIMu+8EuZ9CYJ01zzWl4kbE+LLteCDRjIKB9SxVkzoI6SWm+GokpeXxJUhilXbxr
         V3BTbXTDX4uqb6Jl4nP19anmnYosCw2t8IZxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/NHLnzJB2ygZFZV6tY0zJmtOu+fbM3j2iEZapLwC/A=;
        b=JGkvJlFX4rAmHMjegt0xGRwMorDVV1zQW1naZfx3H3aV3hWeLmonQbgQZw6dMkq3Qs
         W+WnX/ytXA8Y86Er3CgYkebMN4/VhtroOHJ/uwyANG0Fe7CqGGcJj7Ul1z7MOFsaRJiG
         KNgAFuccx/Fx88a4GWq8G02nFPOt3P6/IzA+JF7Cid39m5Qw9fy4Q9oflgGphy27tlmj
         bFGXp1QwdHDCk6mTn9w3QcIjSTIp0Dups5l3ic0Ydr6sxhux6yzoNEujXGR5vRJvMBQl
         l7pTNidMshZs3HsD2NQaU18vHHehGiL4DDy2vZ9jTrpyec0jtRKMMh7P1ZoEp2FImB6v
         3S0g==
X-Gm-Message-State: AOAM5321KkiCe1vEXZ9godYNCwj0IGgME+Dg4DZtEx68K/UOszyyyMDu
        01/VNbJmcUUosw1vinLLsRmWvg==
X-Google-Smtp-Source: ABdhPJyIVBrXhKOZzCBKXG3oK3wjH6BAd9s13vXvBJ+PpxlX5LInY9Q6iJqJZX6Jh5pq81lEvn0kug==
X-Received: by 2002:a17:90a:5a08:: with SMTP id b8mr11356642pjd.228.1624480786915;
        Wed, 23 Jun 2021 13:39:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u23sm9942pgk.38.2021.06.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/9] selftests/lkdtm: Avoid needing explicit sub-shell
Date:   Wed, 23 Jun 2021 13:39:28 -0700
Message-Id: <20210623203936.3151093-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; h=from:subject; bh=AmOgu4HWdRZorYqBFRSjQNwNv37L2JYo/PWnXeJW7vY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wFY5oavND7smh3PFgLH+LKjB2fUh5OHY6bWTIk eYMshS6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBQAKCRCJcvTf3G3AJvtJD/ 9G+j8CKarzbS3nY6L6aaVmdftLkiLrU13NYZGNHPstjHi6Lx9CpHpJ+QwK8wc78agXMWUB/r+L8qLk s5gPPethiYZV3QumjnWFZ+gj2T/Xoz+EbjLOWntVMv9mjstH5+5/e/VcX9vi3N56IBFqOT/OAyrw6V piyzsjxVP6elfNaUtfASxPcXo5H7zZVums4Lnz/S7qok5qi+zmFuE9cxdfPi1g5YHAdw8uxX76SDgD hoV+UheZw8Vf76IBrTdkW9Jp46PrE+jfJrWT6bx2II9gX/ukVqaMFNd4OMh/CyptWTqAdlnB165u2o dy3BZ1goom8Vqgcw5HC4Xyvj6RHMejdsHAwvZi1eykN7tOV2Ad3VciAb5zpVW0aw6N6KFim54cJhF+ 6ZEq4G2peIhgqpOiJQeN3nNjM19grUPTa4eG/YYfxZxPmhW9BgnimjjelWxx2V2bEUMsU5WvOOOhKl 3av97w61teJaEc5UTni4zXrsFfROtUVxxWtGT6W++WLxeHaIFjxiNKPOUNqIF8xNIDbfy5mnHt7dp6 qzq+WOtPvEmqbCZQ/qsVUVxIbAaVUSoNjmrIU5nCypQyLphJMqKBzn/qDVtewgDbXOT8Np07K7fFns ceDGvDFjboNdC3WG7S0yN+Pj+kveweqXC8AKB5TUR06NIKYA8nA74XD1efAg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some environments do not set $SHELL when running tests. There's no
need to use $SHELL here anyway, since "cat" can be used to receive any
delivered signals from the kernel. Additionally avoid using bash-isms
in the command, and record stderr for posterity.

Suggested-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/run.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index bb7a1775307b..e95e79bd3126 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -76,10 +76,14 @@ fi
 # Save existing dmesg so we can detect new content below
 dmesg > "$DMESG"
 
-# Most shells yell about signals and we're expecting the "cat" process
-# to usually be killed by the kernel. So we have to run it in a sub-shell
-# and silence errors.
-($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
+# Since the kernel is likely killing the process writing to the trigger
+# file, it must not be the script's shell itself. i.e. we cannot do:
+#     echo "$test" >"$TRIGGER"
+# Instead, use "cat" to take the signal. Since the shell will yell about
+# the signal that killed the subprocess, we must ignore the failure and
+# continue. However we don't silence stderr since there might be other
+# useful details reported there in the case of other unexpected conditions.
+echo "$test" | cat >"$TRIGGER" || true
 
 # Record and dump the results
 dmesg | comm --nocheck-order -13 "$DMESG" - > "$LOG" || true
-- 
2.30.2

