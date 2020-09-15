Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21299269CC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 05:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgIOD65 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 23:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgIOD6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 23:58:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA48C061351
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Sep 2020 20:58:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r9so2050102ybd.20
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Sep 2020 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jND5K7nrTIUr/jnKohKbWFO0ev/Az4T5zj9+dc82ED0=;
        b=Qg6CHZ5gHjhda+KwUOhclR4Q3kDy3biP0i2FZHBxpfArWudV4ORqkavGZ804ogOMUy
         8AUNGmNkzsDG73STZid0h0HXNjcgdhU4z3oj6pqyPjdc1v1BMSCNOBh546+lDwWinBM4
         cSlB1yrVcuwV2HUQQYnA6r4/PxntWOm1hhTkIerea3b0w8zu6c5UEDEtj+WcoE3hx7R1
         YA1AxmrHGF7aGsI8eMd0/1MjlansTNSSQzyABO6LIF06D7toFkjbaSfU/b9S5nvjHrim
         VBUPtn9VDxBpNA7C2qX9ZnMsLj+kasG45T7Fsvm4BO4z47Kg6OcXsgjtIINYa94fy2AP
         jaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jND5K7nrTIUr/jnKohKbWFO0ev/Az4T5zj9+dc82ED0=;
        b=HPeSB0fZHuPo95KLwaG7uyHNcqChF4QO1V8yzt8Su0inem17AthzUj4k0hnytraZOl
         TqkZWZV80iysGn6claOWQ0KueMQeA01JkNwgRUuO5LXJZzCLfGL/5lB7hMKsAmZoa13h
         6S1x38fKvNzTDb3WAJfjttLkI9wpEnU0aBDwkrco0baV3z/oEMT22LpzkbrrJJkZV9AP
         HwUYxMbrakAeHUKp5GVicsU1NqRegBQwchRaW8rtal3tNmx1X2dp5DbtN9UHuWwNyDMb
         Ye7Zw40BPOlW7bKE9ZbHqYppNqaa09URqSzaVONyNhKsuqFd8iN2p0QsuJlEYYjQoGaG
         lalA==
X-Gm-Message-State: AOAM533hmcNXLgBkQmsVjRXHjeATsCAoOpZVsz8X4Wo8dZkoi0fSr2OY
        r10DGlYJtw0W6cBUQX7jnKvRN1niK5UQcQ==
X-Google-Smtp-Source: ABdhPJwNy5/SF/gC/zNSc6jUHjF6RdEpH1yc/KAlxvozMks7rfzxf+Z68GE5eK2NaQQX5jQCMnFNIydwDzj4gw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:10c1:: with SMTP id
 184mr23945299ybq.407.1600142327208; Mon, 14 Sep 2020 20:58:47 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:58:28 -0700
In-Reply-To: <20200915035828.570483-1-davidgow@google.com>
Message-Id: <20200915035828.570483-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200915035828.570483-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v14 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
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
Tested-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e2c14b10bc81..00a53f1355ae 100644
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
2.28.0.618.gf4bc123cb7-goog

