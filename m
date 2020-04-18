Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305C91AE98D
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 05:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgDRDSw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 23:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgDRDSv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 23:18:51 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31BC061A10
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Apr 2020 20:18:49 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x25so3931966pfq.18
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Apr 2020 20:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CRqxf8T5bRxo/T712v0WU2H9pMxqHzrv9yCZKsRJO1k=;
        b=ajelyZbAItvKpqcy6Z2JVr/HmXS32yXhFk3WhOlmBUApRGbSGPKDdd2b/0xaWhNzeg
         pbJ6CTgi/hrcR2GA9/9r4zzbzDUI8b9GbneSnyVNJsgPEZfGAivLmf/9i0MBwhfatKWc
         1u972kzMOZ0UKUVZpav0YX5kVnr1nnFj41yoPco0bV0SwhdtPHq679t5GbtNaSuT1JWx
         enZBxFS6znX8KEndztit3HG8GDotznpgTEO+flJfyML1bpO8NCuM5CAMyvzKkG0f4w15
         naNaLqxsnNdBKT4G30UKEdsMDFublaTtLiWZqZZCjoxCDmfQDRgTbBkjd09Ui9VF86By
         lVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CRqxf8T5bRxo/T712v0WU2H9pMxqHzrv9yCZKsRJO1k=;
        b=TVzrbOhy8g5nR2Pn3X4IbYdCfsHlhlQvTJ0uRt/Mlyl5RP1y3fFS0vyd+99WzJ8Qh3
         8Q6qNwEmWh/2YOccd5KqWuWUyVru/2RwzHxySKcopeCEA9gBHYAGWM5TDgRdbYUPsmnd
         0oQnlpZG4LBQng3aQeo1mm41AnD4fmR1LoNWbuh2SySHToKGsJky7D1hbDZH+yJHtII9
         4JQ9S+k6YTdXtqy9+7XtyNa949QFqW0dTtylS1X0dmwOzEy8kaU6eqefdXY/dqP7zm9j
         Bo9d/OzGYJCk/faXWr00Nx/b+PpEd9S3oCSUWMS7coIL5FGKzEwxGomm9idSuULyVkZ5
         r1qg==
X-Gm-Message-State: AGi0PuajrwMgZbN7kI4ZMzWPsvr9ac6vjNalawjNLC7BtMVqX50lZIv+
        gVu80Axi701m7o1Ic+DpxgjEX6y7L8hr6Q==
X-Google-Smtp-Source: APiQypK/uUmV70QTUjiQ+OqVVKgYnSy1KwkLpSezPBiabfyjmu2R3Y16ceb+4+Jkm6cFvmP6mJicQAYSfJARqQ==
X-Received: by 2002:a17:90a:30a5:: with SMTP id h34mr7674332pjb.171.1587179929037;
 Fri, 17 Apr 2020 20:18:49 -0700 (PDT)
Date:   Fri, 17 Apr 2020 20:18:29 -0700
In-Reply-To: <20200418031833.234942-1-davidgow@google.com>
Message-Id: <20200418031833.234942-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v6 1/5] Add KUnit Struct to Current Task
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
index 4418f5cb8324..e50c568a8dc7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1188,6 +1188,10 @@ struct task_struct {
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
2.26.1.301.g55bc3eb7cb9-goog

