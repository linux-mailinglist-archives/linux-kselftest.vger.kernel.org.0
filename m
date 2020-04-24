Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCD41B6DD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 08:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgDXGNz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 02:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726337AbgDXGNz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 02:13:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5425BC09B046
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:13:55 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p1so6859146plq.6
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j69Gvq4vK6TM54rY0b5SnTVA9UkpfVZ6E3MyvEyHlqI=;
        b=BfemyIP0zYRMDJCjezWr7m8AQL61Z/72boZMliqIwghZTJIVADjHd5bmtErPIRGjYm
         EN9ZQlvgSQnqe7mZEihpt6+GuiQzLm3V+5XqujDK3DG8qdww/f/5ii+vKhgXic9HprEO
         0pw37j1OFeQ9CLDyiDvYNUht9sxOPlQp4A8NFYaFKJ9URZQvZ0P6Xrj21DFZXhNI5O3r
         UumJLrf1jjN+hOeM/EhRVKfk0fBogTqRQe+GcXBNt1Y10fzHCEKQ7hONQyYf7X29KWMV
         M/aroWJZseiFi4bv4TrgcUz0wGkm44PBM9GgN7ymIMrI4o/OdPS2w8M/V2xFAiiOGIVg
         jK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j69Gvq4vK6TM54rY0b5SnTVA9UkpfVZ6E3MyvEyHlqI=;
        b=APS+ruZ93UxJPCTwTIMiNjCWEuHSL5Fym1GrwAJX1vS/BEhwqZmV7GEz2f5fLlD175
         0xjZBvU1QcZZsN2NBrsJxgbIdSdKYhhFGrD/iqhb3SarLnB/IYWnPzjOvAcMTXZxT0bG
         Gec79me2T2iSrMZ93Wb1nZfeUF27Z/IyEanBGgxVwvnXRTeA9Kd7NRWhN9kRuMmceeGY
         PGc8L4zmPvpIv6GagXS9Xt61BK4eUN29dlEj3slv8oPyLoY8QtyuyaHxSLaNiZv7ynmR
         +dNU33wUQWEhTI+QAtinTgJ5wrG+FShe/f0qzT7OOPV+iKFa1cJeHsZtCfT50kGUj1EC
         xAfQ==
X-Gm-Message-State: AGi0PuZ65iig2n+nB4bBBOa6Wzg1wjJUj3Smbbh4rrUYxDav5MSTaQVO
        NHOHoQUjMhoeTA8phSnmEHn1bPQ2L5nAzg==
X-Google-Smtp-Source: APiQypL2zlL31A5jpzBKC3FbBvFwsLF1gfS/AMJI9xfZ+QHa7TkZ0qqxmOMOvLXeH9ENCuU0namh/ku7DsxfGQ==
X-Received: by 2002:a65:58c4:: with SMTP id e4mr7831219pgu.61.1587708834690;
 Thu, 23 Apr 2020 23:13:54 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:13:38 -0700
In-Reply-To: <20200424061342.212535-1-davidgow@google.com>
Message-Id: <20200424061342.212535-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v7 1/5] Add KUnit Struct to Current Task
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
2.26.2.303.gf8c07b1a785-goog

