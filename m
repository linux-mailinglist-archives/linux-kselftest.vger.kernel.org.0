Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15A23C49E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 06:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgHEEaG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 00:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHEEaB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 00:30:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C759C06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 21:30:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u206so17757621ybb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 21:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y00REmw7cW2Ho0KOM1NABcGJpQIr8u0gXHD6A1O7ZXc=;
        b=OtjJ7ZSOy+P1/e1/ee1YUJbWdg+u0tTRw6B9Yl1dD1X+EXBfL8hI28LcD2xNuRVxv7
         UO+Tg7Ldk8N4W4MYp/ciEcY6LKafeRPJJKXgMRdXWWFT4TdS0cSN9PTQKTnT6iF05IdD
         cJBozNbmRDQdqlZgNG1KZb5uAi2w1kr8VJLa8QZTXVPR5OY3q9AvRTTEbBt3Hw78zlAn
         rW8JVHoIrl2OUuJ7SCP3lFRx7Py2mmWxNGTuKU6KTYMQYYwPHmZGUtoCgTTr9WJJZQvZ
         Zdh8zAzKkkws2u8fNMAzBsh4WCWBRjA4QIwuFdiesJu8oFhsAg368qSQumimvA/t52sh
         mhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y00REmw7cW2Ho0KOM1NABcGJpQIr8u0gXHD6A1O7ZXc=;
        b=XSqaWpjy/pnI5LiI9sAYczJKXR3CqNo9P8/ybjxSASg5Qm4sstltlkRhOuCCS4dSqH
         3zjeZuARiPLn461ehtZyPZpJykLKWCSHC7XY8WvkXQNsQZEjddAwcfrIbjT4hmD5zVjO
         2ulh6g26ACJ7th2ONkXvnIyuRI8sAj6qr2fpG5Rcwxbzn4DSbUuyCiHEuwfdTPBFD486
         N2FxCSy4BAe4X+IDhWvumUjxNI4K/KXds0ltbA7AEhfc2BT2n4SG/8ovlr7QvsQZ3raN
         EtWSCMbjaqfaKKN2eUSfC2ipmUTxBwkXDpm6dtVJll5na7fswwzk5/UPw+GDgYu21A4V
         6s/Q==
X-Gm-Message-State: AOAM531QYc7jrtInDUI5CT359bf1MAxcRImypvt1faF0hgBCrQwthxku
        RvIwjUlVZAOrxOyLevnjv2WOwuwe/cjiew==
X-Google-Smtp-Source: ABdhPJxXjGFwD40kee1mNnaPkbYMTsK0NB+Nl4pE7YyjsA4sfahOk4MpuFQvMN8FFzVOGOoGSQTphyt0akERlg==
X-Received: by 2002:a25:8411:: with SMTP id u17mr658207ybk.95.1596601799856;
 Tue, 04 Aug 2020 21:29:59 -0700 (PDT)
Date:   Tue,  4 Aug 2020 21:29:38 -0700
In-Reply-To: <20200805042938.2961494-1-davidgow@google.com>
Message-Id: <20200805042938.2961494-7-davidgow@google.com>
Mime-Version: 1.0
References: <20200805042938.2961494-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v11 6/6] mm: kasan: Do not panic if both panic_on_warn and
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

