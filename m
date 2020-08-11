Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1362824160E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 07:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHKFjs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 01:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgHKFjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 01:39:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08701C06174A
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 22:39:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l67so15493796ybb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 22:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z+/W2Lb1k0h/CCYiwDe5JijUnwa2JcEcWzU8gpWcUfw=;
        b=tHAO4iJNAEzJVYvZQdBfl/Z0HJY38AuKODLE4Ch1wZBc8FPg/7KBHMPJyf8/uTGa2e
         E6klPsx4jU07UlBRuauki8fP8QiBAPYycbCl1RDqcjzChLjeDP4E2k1e1NnpULdZnzv1
         Pl8iQesn3UiLyjEZOnShWyZkTZA+n4xtyP8tzlxbdeudDI8XTUsWsGqywXNK1eIeCWBz
         3qjrz1HaOS6k9W/9yXae8zdCnwm1yQpe5q7lFbbL0i94z9RVr+3vhvKoInjL+Nblfb0t
         cJpkzK5h/Tri0RocDIDd2pIR/eUsEGMktj67qOjOYUxaBd3zxwrutEWKbzr0abxxWFdS
         +mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z+/W2Lb1k0h/CCYiwDe5JijUnwa2JcEcWzU8gpWcUfw=;
        b=jOPhp84sJmHshYHTdRhXHBSGfIiLz9bPDbUDHipGV3XqDpU3LWX/JpPLuxnY/2tlin
         j7aKuZs1C4jeo5wWRSjdjwMH6jmiJOFD+MFbzXpkbLCDHKuAt7ZrvA7zE4NHRjat0xAs
         pz2LN0SVGrl+oom7NbDQ297TrrY5la+I+XsQhnAevXbkfTSsX8GkQ6Nkt4Df+EmYagmw
         IySG1EHCfbiMCp0SzKUKFxt7xq3+0EWPKj7P4HMhuREkFOznR2mtDeDZRCdcnSoCmG83
         ACkqe0gDmL4JTIaFT9CkmwU7uS837e2/FMk/bJmHW+CNlGkzd1SgHC4JWat7ktmCoJO0
         YHEQ==
X-Gm-Message-State: AOAM5337yGHGveAlopX/MvSr+WXUbbzgsWn6CSBo5o8k2j98Wcs4IjgJ
        zdtb+jkU+GEXsSm1OnvUqugU+UF94pI0KA==
X-Google-Smtp-Source: ABdhPJx02k8uMoR6T3Ar7ZJVf6WCI2ZKosVhH/to+X0ddTMzwXgqLTS/eGRWzl6vu4PuJiIyGRtJ9xX8Em6y5A==
X-Received: by 2002:a5b:308:: with SMTP id j8mr41696962ybp.185.1597124386219;
 Mon, 10 Aug 2020 22:39:46 -0700 (PDT)
Date:   Mon, 10 Aug 2020 22:39:15 -0700
In-Reply-To: <20200811053914.652710-1-davidgow@google.com>
Message-Id: <20200811053914.652710-7-davidgow@google.com>
Mime-Version: 1.0
References: <20200811053914.652710-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v12 6/6] mm: kasan: Do not panic if both panic_on_warn and
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
2.28.0.236.gb10cc79966-goog

