Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452F31A7194
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 05:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404491AbgDNDRf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 23:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404490AbgDNDRe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 23:17:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86197C0A3BE2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 20:17:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o13so11814700pjb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qmS4Dws1dS9Cf9mpNh1dkBLiz6hqHz5k1HrVTs3BHIU=;
        b=tniFeokiM0fcdzRPHG1ZbY9ozBysDVZ/aYvbq902VEONvODDGN/4/AT7Q/QD43RaKG
         A1SPyDQUACNvXr8ytYrkcN7tkAvv28uU02BFBJryzTx876TVzWaft4V6l9RXExPBRjIm
         aSi9pMgHwnv6rIPIdSj1ZKpYdqljYl1+o2o2GWV/+Wr2bkpxuDI4hGJQbXdq6od6c8Om
         9xdLlOxCICXwcuG6aB1tSJdAKkOcXcZgJrfOajKOOf5mGJp+d5gjj/XiZCWCQ5l8fKJ6
         ydKrqljfMn/rMylk4TKt+nHAEX9YlDL8ye+X4LaBoYCZO3cJMz1/NuKNlMGbuGnPAoO9
         RyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qmS4Dws1dS9Cf9mpNh1dkBLiz6hqHz5k1HrVTs3BHIU=;
        b=Xq3iTyOEZpCIuFVOEAwA1IV9R8hxt3LR1QgjKbux1iZ1Esz/1n4pc/HQvYHUmdq827
         aBag0z1L1kfgIxcZ6oAriK/FnrqRSaMnwAPDxYquFjhCwt+HSM4cTvLIhRfWIYhT0v9f
         C/crunFcDemocXgYVqOoTlSqcgRAGH1Dhs8b/WIhtN51S1NCogECqJffvJgmUOv0Eq6z
         ucryWVzr3g/cSBM1WwEfZEAv3l28txaTfCwBE8W6Qw5t+aB1Kmr6YmQsOQ8VnNfckfQ/
         9Qofksx3ZiNuFurbSs+Sz4PH2Xh7qTJvGOHwiOrdLEqpPYCrg23UqQT7vXd/aoNEa/K/
         HBdQ==
X-Gm-Message-State: AGi0Pubpnsv3s5dinTJfaad8AkLstQHAfh6mdMosN9NPKHqSIoUwTcJI
        J9swkAL6G/qTjeqFvzW/huYrXce+k15arA==
X-Google-Smtp-Source: APiQypKW5TDCpyIvzemzn/s78Ld1CH+htFCh8fWOvNw2ECN6IMlElhfG7YP8qxjm0N6Glpf+/LH8+Hhn27QBOQ==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr5197470pjy.143.1586834254059;
 Mon, 13 Apr 2020 20:17:34 -0700 (PDT)
Date:   Mon, 13 Apr 2020 20:16:45 -0700
In-Reply-To: <20200414031647.124664-1-davidgow@google.com>
Message-Id: <20200414031647.124664-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200414031647.124664-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v5 1/4] Add KUnit Struct to Current Task
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

In order to integrate debugging tools like KASAN into the KUnit
framework, add KUnit struct to the current task to keep track of the
current KUnit test.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04278493bf15..7ca3e5068316 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1180,6 +1180,10 @@ struct task_struct {
 	unsigned int			kasan_depth;
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.26.0.110.g2183baf09c-goog

