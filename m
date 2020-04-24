Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8111B6DE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 08:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDXGOK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 02:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726585AbgDXGOJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 02:14:09 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32FDC09B046
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:14:07 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v71so6959604pjb.6
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ktlf9QISDdPRX1uK01ka9sL/IDfKnusqL4DRjBWXu7E=;
        b=ChzEHTsGqPRuCDwBSqzePHzbU3gd0vJ/obMVlNCqmZP6Bx9+LTIISm27bGINFK3ST6
         U6egrTXZiDrcvjehCTkYlvCU6d9nsry4pNfwODvaALAVcnhYTx5axmEwIuK/GPq9Cfz8
         UGfCyjVxVimTBu17eikwQb58W7KS5lsJoXPexDu9e8s4Peg0P3t/ZQHkcwab7oi7yoTM
         GLC50li+VxxNldpiZ2gmUfvc0iPOMQFq5Mp4IFhOcF+8qx+5jUNTDO2ek2PqzLQnG6bg
         7HreaMnVbHJmtsy4iqk8Nnut8zz6Smp6nnpdPPhjNz3hvUT561nE2fr4u5OMGoXJ/3kc
         XalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ktlf9QISDdPRX1uK01ka9sL/IDfKnusqL4DRjBWXu7E=;
        b=DXFKfhhsp/0YnnVbgfgxBHx9my7twMnw0XtnJPC7Ui2w7hNuppZV3S+McC46ri8yah
         7UldNhO59wn9V2EUWIhTyiydWSRF31cKiZ8b4W2qqhf7VwjkESpccttesKSO4MNnYdYS
         oZoxkTjZNW/gk/aOffMMqhGzurl3cLmHVvW3CLTK3QqQesjNCGPA4ju80RC3mLhG5/fC
         GJ1WG1Zar2jO+P35LOT+yKnqnOLBFsjGvJ/mdcumkgSAmo7OrN1HLYevjTub2mYfIxs4
         7RhIrmgQnx+/pJJHXcp945ZKJyYM6St5Gin9fqs33ZwJmnefpIoemVC7Pf10G0MbccwD
         tFvw==
X-Gm-Message-State: AGi0PuZB+FGeU9YuL5zMJoQHlYNgR8+QKJqsMhDwTUx7AgSqXB3d19jC
        NJnXZJn+W9P8nbsfRurgaIcmac9BvBpXBA==
X-Google-Smtp-Source: APiQypKOtuNJXwpmMrdTnwPQuAL+4H1Nq1T3AV8w+3m+0jNCAItOLBXkSV8iB3V7g9qIPYAGCP41cMK+FN/X1w==
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr4757997pjr.182.1587708847422;
 Thu, 23 Apr 2020 23:14:07 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:13:42 -0700
In-Reply-To: <20200424061342.212535-1-davidgow@google.com>
Message-Id: <20200424061342.212535-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v7 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 45f3c23f54cb..dc9fc5c09ea3 100644
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
2.26.2.303.gf8c07b1a785-goog

