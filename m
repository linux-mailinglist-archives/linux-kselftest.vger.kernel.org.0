Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC25D233E6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 06:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgGaEnN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 00:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgGaEnL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 00:43:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B129AC061575
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jul 2020 21:43:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u189so36255898ybg.17
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jul 2020 21:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=85loYESi4Z2DrhOdMAtj0xQZzuVg3GU4Cjv9w5JgQ2w=;
        b=nM1Ko5uZ5PaKCYqDU0NYwRa4XHN/6iUAMZ4+j+5QaGXLZRxZwQZf5LEc6+kAM2Psif
         aodCaQs23B9t2l+OM4rJPukl1RwNcw1W5Z63j+BtuCBi1z133KYzKXAIzaZxLahvPr3L
         yUM8scgAEetSOoLmpfNqgC84H5UNnXcbpyEDCXcn4m8Qm4ILVxIjN+UZ0g2dJ3tLYGLY
         qFxDMKpr1Ptj79QIrsIDfo3M+sPsG/MvaX5sKtmgq9/PKyCZ7tXezJVqPQKIv4JatMs+
         HEg2sgK/k5nGTU9KYSLCTZ21qWL94+72ZAsuoliRVTEiHEN2rWosgclnu6AHJK80/hkA
         5IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=85loYESi4Z2DrhOdMAtj0xQZzuVg3GU4Cjv9w5JgQ2w=;
        b=KwFtTM+GKrZq38WJH0eEgXISNfjDtI3H02fF05UJr8eaFbTBNP7p4PNf6whQOc66ah
         8BbmxBBF8gxfWGXsiGh7a5RuMQkGfCZqFiFZTDq75OIX4q8HXkcMy3anzEngvTQV7Mq0
         oxVCdHDvGPeDKunMTixxIwWXZAhgvUqwnqtwtPz1Je8X2OrbFJbXw4PpskmWMw4HdSwR
         Psr61VTm03ojNwqtgGPBCQGVgq+mrAgMcYEO9HI0R8TV+V6AZz7rBC7LQNOzW/xfNKZP
         MNOS2WtFbbbcjPNU12omoJ0lts6i+vFEjkVezR0nVz/rE9ChovD+QEYbGi/BlDmWDt4j
         pLdw==
X-Gm-Message-State: AOAM530GvvBtnrVWGNb7vBwem88h4t0SsDkdP3FZojxQEmbKMm3SaQ0P
        08H2mDOYnnnngaeQMr9X/hNjyFAUAYsYbQ==
X-Google-Smtp-Source: ABdhPJyP/mw67ayLNhKdDi8CnTcyvIx5quWF1/mZZvx61no3lP/ey5ookrMRZRyPQjQoDCQPjTLmvbv8g27ITw==
X-Received: by 2002:a25:e5c3:: with SMTP id c186mr3565894ybh.332.1596170589932;
 Thu, 30 Jul 2020 21:43:09 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:42:42 -0700
In-Reply-To: <20200731044242.1323143-1-davidgow@google.com>
Message-Id: <20200731044242.1323143-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200731044242.1323143-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v9 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com, shuah@kernel.org
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
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 90a1348c8b81..c83d6fde9ee4 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -95,7 +95,7 @@ static void end_report(unsigned long *flags)
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
-	if (panic_on_warn) {
+	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
 		/*
 		 * This thread may hit another WARN() in the panic path.
 		 * Resetting this prevents additional WARN() from panicking the
-- 
2.28.0.163.g6104cc2f0b6-goog

