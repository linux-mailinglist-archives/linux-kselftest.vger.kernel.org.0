Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1B19B528
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Apr 2020 20:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbgDASJU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Apr 2020 14:09:20 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53190 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732285AbgDASJT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Apr 2020 14:09:19 -0400
Received: by mail-pg1-f201.google.com with SMTP id j20so614798pgm.19
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Apr 2020 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7tqR6IbLJuZB8xQehAvx+fGtdnXfyS7jowzmd4c+P/U=;
        b=qnw5UGnLyUK+GZp+VrpZN1Bln3HAT0coO285eDLUYwU7g/QYkogK1DRML0u/t4HRC9
         ri1hhKcMf8hX1DgMHV1aekFh3n1t1833Bp4RyL2vPTKAWoYYf9xvjOKwLZGiFKCEYiQ8
         m2AxZlqAoNPEcVlxTfLPjZ2pNl0qG/X6WZoY8TgJgcTEtWmswlrQ002zWyVbH0s7Md//
         zoMSQRe5ptY0Rh3fBX0jcHbKJzMfO20yHSD2nsa5rZ50r4i0jziDqmwAb5fp5LG0ykyp
         nnvaDeUHc0H6JBXtrZXcIgMjN3i1FkjT/8cZrrZ2aTDOOvkxjTXpbnmknApOZgYZkkkG
         MRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7tqR6IbLJuZB8xQehAvx+fGtdnXfyS7jowzmd4c+P/U=;
        b=YAt7/wDfdvQFWexMDTD+WQuWRxyQtV8SnNfcQZXMV/J4dIYwHWMGYQDicUf6eCoj1b
         vSsGiWxfbN1Ih+a50EuVhoVffqetRpQo9DeL6Dt9iNFFbynMVix/E1N9H4BqLwDSFxa+
         xN7rqKdwt/SreuylIHCocKJXIMoSWWRmC5dW8q9Cm3kpy1fuT3G++dbjl2FUYgDNjlDK
         GUOHBjzWRvkdU0sCIqqUszSgegFPN3lG3tD70pSaimMwpJ7/bcORzTU8vrqd7dcNaWiC
         iUXVW6mU/OrdbLVRgYUA3B5vzQ37CeG3qCJxt1GPMig+w9TA8JAlP4fLwGZQEYnTSPBR
         qqxw==
X-Gm-Message-State: AGi0PuaZ3Yd/cAqVF/P+UZ4Vw9LLrp3b/X1b1yCgIy8NrmdbeqCKvxux
        RZ8LvgzVDBTdQKCkuIVaOQL9vfEj8qKTyb7PoLI=
X-Google-Smtp-Source: APiQypLl3dAK0yKLDhBAlH1tPEWkzMGGngQ6Vd1d2wIRSXg9xLwU6R7r5iID12CVWShsM8HsT9c8IxOGCnIRuJDjnCc=
X-Received: by 2002:a17:90a:272d:: with SMTP id o42mr6327393pje.194.1585764558291;
 Wed, 01 Apr 2020 11:09:18 -0700 (PDT)
Date:   Wed,  1 Apr 2020 11:09:06 -0700
In-Reply-To: <20200401180907.202604-1-trishalfonso@google.com>
Message-Id: <20200401180907.202604-4-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 1/4] Add KUnit Struct to Current Task
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to integrate debugging tools like KASAN into the KUnit
framework, add KUnit struct to the current task to keep track of the
current KUnit test.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
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
2.26.0.rc2.310.g2932bb562d-goog

