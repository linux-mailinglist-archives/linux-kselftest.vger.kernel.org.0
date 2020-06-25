Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5620A6DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 22:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407168AbgFYUhY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407167AbgFYUhJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 16:37:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A07C08C5C1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q90so3128238pjh.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zH4NCz4WUaJ18HzpAMLRB8JzZlzE4XmxaFkgad5236Q=;
        b=RBKdveDB6/6TryZmoNNALhVnkzSsz2R1ULWjvCpcvukqeMwo0hJIk9HrScRw9ugson
         xp2VUC3/+oZibhV2ktrPBevQZ01heoCGaHB/q3pX2tYDKAkzMDAnS509Kjmw6py7sBnO
         iDJiP31nLw90dXJS/kd9DdxoeZQKV42Tk6wmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH4NCz4WUaJ18HzpAMLRB8JzZlzE4XmxaFkgad5236Q=;
        b=QbU/xo/OTeZ1209gniTWtc7v5WXBv+GyPn/Q6pDK0EsrMrg8eAGJxyb6stOmFQc9dg
         VINk8DERA9MOIyh/9Qj46qhtz0mz7/IO93CKdWOy+NJxaIQqNlGyCrCFuRfckMGNq62p
         3DQ3cfRgFF+ABxEtDn0mMoyh/lNVqFnyHj2nExGRzkontzPsOqiD2a+DG9KfQKLVprTp
         JKaTMMgt4bGp9Lwap1QdiLJMR8TZ8KiS5W6IED9Ft7HKRpNwUJWkSXBEu++Sevw3dyAu
         PlWlAOM9HMm2RU0Xn6cI14Fxwmxf6a58w59BCsu35N1VnB337+3ZZ744BnLjMYLZ9HmA
         jZKg==
X-Gm-Message-State: AOAM5317VkPlTV2YjVJuNEu0yARPqqvOtwTi+RcaE2r8/cpa07uxpede
        A6rAKofqMXspA6atZIW0tJ4mYw==
X-Google-Smtp-Source: ABdhPJz2pFPgByh8wHP5gvDAbO6WFvVcu96QLX6WXAcgHZxo44RtCOOw8GvDsRRsJb/3q0x6ZUOY1w==
X-Received: by 2002:a17:902:dc86:: with SMTP id n6mr35678275pld.82.1593117429438;
        Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cm13sm9447469pjb.5.2020.06.25.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:37:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc v2 2/4] lkdtm/heap: Avoid edge and middle of slabs
Date:   Thu, 25 Jun 2020 13:37:02 -0700
Message-Id: <20200625203704.317097-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625203704.317097-1-keescook@chromium.org>
References: <20200625203704.317097-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Har har, after I moved the slab freelist pointer into the middle of the
slab, now it looks like the contents are getting poisoned. Adjust the
test to avoid the freelist pointer again.

Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/heap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 3c5cec85edce..1323bc16f113 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -58,11 +58,12 @@ void lkdtm_READ_AFTER_FREE(void)
 	int *base, *val, saw;
 	size_t len = 1024;
 	/*
-	 * The slub allocator uses the first word to store the free
-	 * pointer in some configurations. Use the middle of the
-	 * allocation to avoid running into the freelist
+	 * The slub allocator will use the either the first word or
+	 * the middle of the allocation to store the free pointer,
+	 * depending on configurations. Store in the second word to
+	 * avoid running into the freelist.
 	 */
-	size_t offset = (len / sizeof(*base)) / 2;
+	size_t offset = sizeof(*base);
 
 	base = kmalloc(len, GFP_KERNEL);
 	if (!base) {
-- 
2.25.1

