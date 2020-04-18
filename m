Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540CF1AE997
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 05:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDRDTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 23:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726099AbgDRDS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 23:18:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C00C061A0F
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Apr 2020 20:18:59 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w16so3514924plq.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Apr 2020 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3docRvuzttJC+Wkb9Bk065FrkPZtq4zMQ8pW4rPpfW0=;
        b=tsvxfJmTMqQagdYMcGxWaiaBVUv/Xj9MJWLW8Dkj2Rh+QyEZNG2meafwJo1YjCR9XR
         5kx/fQJl2afogVcJn5Fxz2Yyqo1pSLded1b4yj6BSbRR1X95xnMUj3NqcfpA+oTcmuck
         tSepuqs2CyUuCHzyjGJkqpQsPa9q+FIQrEEcEiqjfrxZw0D2zASxS1frtHURyy5tmApZ
         jhOTxK+GmZ1vc4ixnC/CjwFtdbHrQZQu2edc8kcXC+9dYUYgxU7QpnWG5zWylmT1HWaz
         I43ZoSfAC+4PqweU7MfKrkmONOwe8xum+hRW/iXwKhmNMNScqfk044TyaoabJvSyyda5
         Qf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3docRvuzttJC+Wkb9Bk065FrkPZtq4zMQ8pW4rPpfW0=;
        b=Z+j1hJ304JHQyXnteWBHYLMbqgRMXU7nPtC3E2u1nSsoAQEA0uivbvykJI+PJ/Am+m
         2tljQ8FyngS5+AzfZnpgE3MpQvYUregePuDhXTu2TpDPb0o6Jx2yN+WuBLq/xA6tYDub
         xppKA+LnWrNYVyEkY+cShpTEQhZieO661NCoOWgaLAqRmGZ/9CwRmofN7bgZ4WMrzcf5
         onfZKcAMjNA1xstEqKmYZ6pVcwX4Z3LYSjWAGy2G4ZkouO13KVEcHQYTanOLY4e6TxRa
         1Z8NWNxrUNFA4xpdg/XZasPaSp1hWM6MH5NA3avt5jL4DDTCvPjlrO8Y4HzVbuZLiJrL
         +64w==
X-Gm-Message-State: AGi0PuZCPQGLwmY038CFZ29IAHuekYPB4lpF7N1wxNmg7JeoEOIUN5m0
        MShw4cNvqYYAUjn/LQv/zfMcNe4ZrvKGqA==
X-Google-Smtp-Source: APiQypJ0AKcRxyISi/BREL+Gq9cGtfXhBaacb3y/m8Wu+YUwFvaWrTgT/CZZ/6bzqf8Z0LckGONfr57QZCTIUw==
X-Received: by 2002:a63:f64d:: with SMTP id u13mr6075605pgj.151.1587179938644;
 Fri, 17 Apr 2020 20:18:58 -0700 (PDT)
Date:   Fri, 17 Apr 2020 20:18:33 -0700
In-Reply-To: <20200418031833.234942-1-davidgow@google.com>
Message-Id: <20200418031833.234942-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v6 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KASAN errors will currently trigger a panic when panic_on_warn is set.
This renders kasan_multishot useless, as further KASAN errors won't be
reported if the kernel has already paniced. By making kasan_multishot
disable this behaviour for KASAN errors, we can still have the benefits
of panic_on_warn for non-KASAN warnings, yet be able to use
kasan_multishot.

This is particularly important when running KASAN tests, which need to
trigger multiple KASAN errors: previously these would panic the system
if panic_on_warn was set, now they can run (and will panic the system
should non-KASAN warnings show up).

Signed-off-by: David Gow <davidgow@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 0c206bbf9cb3..79fe23bd4f60 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -94,7 +94,7 @@ static void end_report(unsigned long *flags)
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
-	if (panic_on_warn) {
+	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
 		/*
 		 * This thread may hit another WARN() in the panic path.
 		 * Resetting this prevents additional WARN() from panicking the
-- 
2.26.1.301.g55bc3eb7cb9-goog

