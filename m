Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1264D1E8868
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 22:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgE2UD5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2UD4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 16:03:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B558C08C5C8
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:03:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id i17so1656237pli.13
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCmY6exoQe8jgDlgtI8ix1LZA3heHUWvNPlFDsRApLI=;
        b=MnQqBwNwN160VVgSonbc44ILiWcznwE2zxAqmP5H45SuGW1zWMprJ3fkNzFbqE0ys9
         jWtfx3lJmUTiW94r+uRvJIC0eBO2AXKPXc8K1/UJJKLekiMh36Na0IUgi+08BhKmWXPz
         uGfZgj8TvMJQ7eDO/5LFBl8ZQw7s/TpCDauLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCmY6exoQe8jgDlgtI8ix1LZA3heHUWvNPlFDsRApLI=;
        b=G9uYKKPOdJRj6VGUireb/5CwPRk/rVk4AKZOusm5B4a1n5KscBE/jj9wJcMTna39z8
         StgZYBNoCFlwQXwtRaV085+NTx3I91h2V7HTDs0sxjEY0mb1au0zch4Z8RZnhKlF2uzC
         A6ZrN7vcvUGG1hfxN0DHE+kxo7GoEmJjPgnbxjkQEiDjDVW3qAqhfs8piWsPhPKuzROq
         AZ9cr8nPpgxmAL3YevcntWqssCxsvJs29FdIKo5kYsd7rQUNj9SyopTFCHMFh9F0aMA8
         JDL53eDP3JfPEKhRHJBt+8WWFRiS52gR++VVQ91MQ0I3dVKNNux5A/MaC4cSXJDh/J1R
         3Y3A==
X-Gm-Message-State: AOAM533qfdywZfpYJOHoFrZTUAi/JP4rUup6xEzSOirbgMg2jRC0vOWk
        Oh+SXqet4miZ2aWdQhu6fN4eew==
X-Google-Smtp-Source: ABdhPJxeHWBezDRrH1a1yIT6IN5Ko6WOSv1GdMCCm93pznbXED5bbwEvp8L9ykvWeAwn6Ot/xvSGxw==
X-Received: by 2002:a17:90a:6904:: with SMTP id r4mr11012848pjj.119.1590782635809;
        Fri, 29 May 2020 13:03:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q189sm8188645pfc.112.2020.05.29.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:03:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
Date:   Fri, 29 May 2020 13:03:46 -0700
Message-Id: <20200529200347.2464284-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529200347.2464284-1-keescook@chromium.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since we expect to see warnings every time for many tests, just reset
the WARN_ONCE flags each time the script runs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/run.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index ee64ff8df8f4..8383eb89d88a 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -8,6 +8,7 @@
 #
 set -e
 TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
+CLEAR_ONCE=/sys/kernel/debug/clear_warn_once
 KSELFTEST_SKIP_TEST=4
 
 # Verify we have LKDTM available in the kernel.
@@ -67,6 +68,11 @@ cleanup() {
 }
 trap cleanup EXIT
 
+# Reset WARN_ONCE counters so we trip it each time this runs.
+if [ -w $CLEAR_ONCE ] ; then
+	echo 1 > $CLEAR_ONCE
+fi
+
 # Save existing dmesg so we can detect new content below
 dmesg > "$DMESG"
 
-- 
2.25.1

