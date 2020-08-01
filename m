Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B832350F4
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Aug 2020 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgHAHKQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Aug 2020 03:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgHAHKN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Aug 2020 03:10:13 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B83C061756
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Aug 2020 00:10:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 1so22436585qkm.19
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Aug 2020 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y00REmw7cW2Ho0KOM1NABcGJpQIr8u0gXHD6A1O7ZXc=;
        b=p06i0vZEiFlxr5WQl/1QLqnRoDyO1YbD+Mg/9g4eGrZU6RzoiI9EBqN6Ry00dpU1eQ
         otL3mmtIVomSnP8AcineuZKwvWwP4WxlcRcxnev4l0jIFgWC3fcAlTd/6wgnliHAFdgP
         sbfrcu8stiyGlhOL7m7HVYtkNB0Xh062PfrgihcUb2C6uM3Xv4RATJcNYdIOvNhy+Y5b
         453Uy+j0yNSBZshh5hyJ8P07jF16Rn5lFGZ+og4uA5CnOfgyev8i251ygD4lCrRM9xWd
         E/RjqZ5gNN8vVEgltxW2b78N25513y0JIMIsZTT+vIwLnFFc+JAgyyopGmP6E/392zrd
         M8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y00REmw7cW2Ho0KOM1NABcGJpQIr8u0gXHD6A1O7ZXc=;
        b=a2zuHz4Hlcaue7nB08VkfNhXOfp9raWpA3oIzRKyC1GFOivcpTGQH2mGxYnw1cQdMc
         ybU7NeFcxYX5fPg4AhYmCT3YpkZHsdMHPpeUHZAcpS2FvuSsAZv7vDwSLPKHN4HC1AaU
         AkfNwAE5n/oSFWQ7s6l/b45T0j9MoQSGv7rl5Nhz0rTi3XggU7jUM4HjFjcbj3LG0Q2X
         pPqZyiCWFF8S4gAJRp8JRi1mpJ7W+Rcmw1DmwFl+PULKxEq2IoB1AiMYfynJ/Q5777ei
         w8Oh53dZ2wsWpZ4EMHNXKuvT1FZP628XjPliE8HQQkoXiMiLEiwWX+XRARuPjzoCS5WJ
         Afzw==
X-Gm-Message-State: AOAM530iZMY7b5nVvdfeafnP66DSFAViaj6GaNZHxG0rx/MCtYe8QRoZ
        0BKhB5PwenX4qOUC717imyHgDg0j5r9ZBQ==
X-Google-Smtp-Source: ABdhPJyAFHaNDP9BQJEEjF9elaKgN1Zd0u0F3MLrDDeUgBuFx2mV6ToMV2z9T84Z4JcIYnQiiOUECmq01lQjZw==
X-Received: by 2002:ad4:4089:: with SMTP id l9mr7569682qvp.175.1596265812531;
 Sat, 01 Aug 2020 00:10:12 -0700 (PDT)
Date:   Sat,  1 Aug 2020 00:09:24 -0700
In-Reply-To: <20200801070924.1786166-1-davidgow@google.com>
Message-Id: <20200801070924.1786166-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200801070924.1786166-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v10 5/5] mm: kasan: Do not panic if both panic_on_warn and
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
2.28.0.163.g6104cc2f0b6-goog

