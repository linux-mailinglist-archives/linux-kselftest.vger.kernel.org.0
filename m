Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888651F0497
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jun 2020 06:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgFFEEI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Jun 2020 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgFFEEG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Jun 2020 00:04:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4080C08C5C2
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Jun 2020 21:04:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f16so14381046ybp.5
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 21:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bno6lpmXJK51n5a5Nx8tNY64fz3MIJ1lkOtErirSr6A=;
        b=YHJ+OxXkKPDeM+7ELMewnwd+Ffd3T7tSXxbbkvE9Wj7weFnG3Q8LKA8LUT6tXC6f/p
         sIbOnONsYBskP1Y3SPq2vQzpvPJEUP7+B1ZmGjvQSssiGqqjj5HDdRcFvZ2ybIK9yWf/
         j6j+GMKsYKIw3LH4dk2PCMfZxUdt8GXgai1P/MTj0v2UoF/gav8ycpZBleH2wMzxIfyc
         Y0V54/Ag7MMP61uxDwq4z3o6dkh9u5457FPbAcgHRve6KHb0x3bDwJjxvxYNIyQxV+wK
         fCUxURx9kmWQWcwPOAjcLTShq1EL1uQoIYCXlGem4xyMNw85p0u6XL/OzfNBBbBQsg0c
         I2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bno6lpmXJK51n5a5Nx8tNY64fz3MIJ1lkOtErirSr6A=;
        b=g8EYJCXXpPC1mOBfvaxgzADjbHsaM61UeMRNH3fmUxv+GgCZSV3G9vy0LEwa/cO8Az
         YaiedMBONVKO+RepcKcuUi1G5kMpKVrrY1L5aODzYQiqyQ1beG9hJ6/dbiGD9pTJcoWH
         MLjrM4HYPnaUIVIDZg81iC+uTW+Q2wBuOCnlPWWMliTzC97KpRd52ZGs5PEKDB01YCLK
         SG6vUiMqFwC7iSnmopNwTioJJH/9qMoWSVCDeNdHdEz3CCnQW09L+DyRI/B5F2IxubX+
         s17EPJ/10WVjymXUjev7FQk4gCrNcZtQ3a+Jd8fuZBmuEBQmCSTJmYd99CU8MUgRK2Os
         z0/g==
X-Gm-Message-State: AOAM533VM0DFnjgyIIXVAwObX/nITb7i4spJaEbKB6l9aikEffjzlgIf
        9bO8ybgd2xqA4ZbK3uDx7HWnCXhXid85OA==
X-Google-Smtp-Source: ABdhPJxlU491uKsxwRao6XvYxlOdKzykd3Y4Y+nbo1iQnitptU5xhr1Ml21x6KURK0uGhshDvIETBl7GDDZr/A==
X-Received: by 2002:a5b:785:: with SMTP id b5mr20722587ybq.96.1591416244078;
 Fri, 05 Jun 2020 21:04:04 -0700 (PDT)
Date:   Fri,  5 Jun 2020 21:03:49 -0700
In-Reply-To: <20200606040349.246780-1-davidgow@google.com>
Message-Id: <20200606040349.246780-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v8 5/5] mm: kasan: Do not panic if both panic_on_warn and
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
2.27.0.278.ge193c7cf3a9-goog

