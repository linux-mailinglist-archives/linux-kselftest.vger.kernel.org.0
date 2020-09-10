Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CED263DFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 09:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgIJHGG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 03:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgIJHDw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 03:03:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F3EC06179F
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 00:03:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k3so4633674ybp.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yVT9yLW7JYWhoMqFcNSvIQqOD/OC9Y5kGyMXj6mDfzA=;
        b=SWzaAF3z61UdDBRXy/OCKHiF8fjMlKLNvdTmk6/Dbh+Kq1lqavqta7ibeGJDMVVjK9
         9axKITn1wFqjz5tlBRpOkLHHQYFcxzoWXqmY1Wr+HNvMkBdSC5mKf3xMXU+ryg27V0jn
         Th4btmcNJXuVRUgMFzA+P1ccT7ZakwLeIba9vmrMXLytgcsHgtPq/ujpT4Fvy8CJSLCl
         Qe3OIPeflNh4YVVch2brsFc0DsYZFIzzMQKNykwBbU9Kf3BE4FGLV7RgkC7+kUlkcYlm
         vQCACO2h7BOQiACwrP48GTHlEEljHMJN9F8kLZF8t731qo/RgTIaPzL/vO9bN/p+0HRJ
         8pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yVT9yLW7JYWhoMqFcNSvIQqOD/OC9Y5kGyMXj6mDfzA=;
        b=YSkNne0CV03wmL1PMunjYIsF8sSQA+sP+CUIbJQYpzlEcWhy2Z/as52Mxl8Tu+dtS8
         vmsNGamUm5EJ+IxJThaMbg8A6DKdwbX7M/g6Oyo3J51vCF4i4RvTkhmv881B+1KglwLE
         icZvuiNrxdodY+eWhS33yRxk0RmPJe4Q+AgRY7vvFmuJuAHNZWhYyfYzK6byorvgQUqg
         lOTb0oTCPzaZbYuUez6OXinszd8eQOHU/0a37Q+B2zK6TU/GBjkkM7WOZtfbcilG5Pp8
         xQjzQxjXFTDT1j1+59AMzmRgyP8f+s0upl8/SbwyKEdOVcOld1eQs/fPcaeQY5TJrlBm
         gWFA==
X-Gm-Message-State: AOAM533+1POS0vBE6sJbx0Aj2wLfIE4AlUV1WaE2fINI9yKxwlHTHL62
        mB54sflayv/28OQW/tuFZLp6VdxS+UuNLA==
X-Google-Smtp-Source: ABdhPJx6wYqq0LRezDVx5FLW+SCF9/8HZEb3hTyx5Wg3k/fevn1boLeFIzGzqQKYhcL1qVh2j1dn8STpGk5QXw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:ef03:: with SMTP id
 g3mr9920500ybd.364.1599721430919; Thu, 10 Sep 2020 00:03:50 -0700 (PDT)
Date:   Thu, 10 Sep 2020 00:03:30 -0700
In-Reply-To: <20200910070331.3358048-1-davidgow@google.com>
Message-Id: <20200910070331.3358048-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200910070331.3358048-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v13 5/5] mm: kasan: Do not panic if both panic_on_warn and
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
2.28.0.526.ge36021eeef-goog

