Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC98223C493
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 06:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHEE3w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 00:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgHEE3u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 00:29:50 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDEEC06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 21:29:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id k35so25546228qtk.9
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1s/fGj49wZAcV85LY6dM4ghB8ELbpKuQm5SC6WcoZ6s=;
        b=KH87wYJUH7h4lE7GNyS9Zkc0/3HRb/qCKsvepF+wF74pNbnprxanLXxWGZSvHNat2a
         KWa0kEHWNrd7PrwIvCVKfksv1mmUs8g8LsJsxRw8MqeCep8TI+d7HZWQeJasaU/JwQTW
         AKpMgngEZL/m8NQmYa4KC6mczZeb/RC8JGkMGn0iRU3KSk33CpJ016RNn/IZGuOGUJL2
         oV6vVsprw0GfpE7+M7sO/O9plsvSGD0AeS1E2y/MrYtytWkyzdyBOZguaFPwKeQ1WQqS
         DYh72SsnIMEPVXGCBfQKMj9RN29n+3XzA7q63+xuoi/uaVbvSqOkv2MSoghGEn2bQzLj
         N8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1s/fGj49wZAcV85LY6dM4ghB8ELbpKuQm5SC6WcoZ6s=;
        b=lVeGlVxLIb0u3dgvRwhhl3v79lujlzkm2gos/BXl51RK9r8tS0THNgvNHEM/hwNp1n
         Rc8BX3QcRHxQox2jcXlPzx4pPlTkBt3DZNYESyalCcNK8Dt9wlI6LlLR0zZj9dOU+YNO
         tFAAf5PN06+xxDzeyYBVCoKp37DO/rSS9MOp1ejR2NJU6HheD3xQi3qtQ/zIJf0b79Cr
         iMpQJHnxUu3oK7muyiXMtYzrpOFNieOyakiaCTfnd1E7j0AIjSyzsDf4el5ZmvQHvzOU
         6YDVvqde8nI/EK3rQg/8hNGIdi0jReOphm7SaxzDtPwINaXRc91JqEyKzCrUdHpMjKH0
         SJhg==
X-Gm-Message-State: AOAM533w6rIMXZvpuF/AyPyVmia41LHR4D0mjcbpWlA8k79OnNhsNMuF
        CiJACQvUuD2vrri0wSm6KVd8CXLOABcnRA==
X-Google-Smtp-Source: ABdhPJylrtvvJBJ9f9qdqVMEdPVylXivJYIOITqT9qZY1M+5gLFwdOVxzioKQUYCPH/JukP+OFQzFLRW8FIJlw==
X-Received: by 2002:a05:6214:1742:: with SMTP id dc2mr1836989qvb.90.1596601789643;
 Tue, 04 Aug 2020 21:29:49 -0700 (PDT)
Date:   Tue,  4 Aug 2020 21:29:33 -0700
In-Reply-To: <20200805042938.2961494-1-davidgow@google.com>
Message-Id: <20200805042938.2961494-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200805042938.2961494-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v11 1/6] Add KUnit Struct to Current Task
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, David Gow <davidgow@google.com>
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
index 27882a08163f..f3f990b82bde 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1196,6 +1196,10 @@ struct task_struct {
 	struct kcsan_ctx		kcsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.28.0.163.g6104cc2f0b6-goog

