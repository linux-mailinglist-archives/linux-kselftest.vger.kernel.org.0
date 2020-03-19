Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EAC18BCE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Mar 2020 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgCSQmp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Mar 2020 12:42:45 -0400
Received: from mail-qv1-f74.google.com ([209.85.219.74]:45808 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgCSQmp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Mar 2020 12:42:45 -0400
Received: by mail-qv1-f74.google.com with SMTP id d7so3269287qvq.12
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Mar 2020 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/e3rkkmfd1b6sk0SVgpVxi2weXIopunVz1TGXPB1o2Q=;
        b=pAEEZ2fM6YsbHdnzBd/r6un+oIKRlxlvz3jic9B38l9/9IankeiOaoOJIXS9p0D2jV
         ow0SmBoXTSKrrRTwRcAO4tMBMAlurZUVf0uJrxkFF+knk+IJ068r0uXlT1HVEAj3eNW9
         uaCBdYWNvy6U/Q67m78UJaYkOtw8lYRXqJOpEyvXoINYqFniiK/7opnn84Ne18pmkW5h
         B0KdDc7uye/6o5EQbKiuVQ7OcVeKdMmjIFdOlDri/nbc4xmHHGd1rbHr4j953sC03Jn3
         EPosz5P6phBMu3ty+ycigOodD8CI0sTLjhIALQz96fDc0KKaVQ8LyLQP07s054PHlsAG
         bb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/e3rkkmfd1b6sk0SVgpVxi2weXIopunVz1TGXPB1o2Q=;
        b=LBWeMVI3WKrcY2B+eIKbSYaKGNFwTZuXhfea/alkRX75RrWQevtKAw+NDw9j014yNi
         a9fa6OFaBiLLT6NU6AmisPAiJTw3gvN/Ubnp3V9sK3prhy1dINYEKNo3VuQ52OT9sITv
         9kGZ8jO1V8PjvpryUAuQUIf55iWwIp6BTsVW7x9MNgYFH56yyK+HZLDtLCGbo0OT98IG
         8QCVrANX9QUFaV5Lo+0fLd0fGoGXTKdolHwJ1RxoEuZxF+GF9qukTu7YoXMgOa8wqVA2
         NJxhXqaN8DVtXLJ8dcGdtWgtWrE3ash18tOlOVz4QGl1tRyTnDoQmcWZABYvkqi8nh0+
         yABw==
X-Gm-Message-State: ANhLgQ1Brr5lEpnUo3t6l6d2iBXUUoNIj6WHxFk0OEprjccOk3EsHoyU
        m0zBvK9EsCOcIFesFxcPLgijC3uimRIN447xdNE=
X-Google-Smtp-Source: ADFU+vtdcXY065iMK3lYGT0t093yNfaC6nBS+XBMSZLjKKHl191H/3QSOnSZr4cojJzsteGn1+C2lU/+Rpuc1wcTgW8=
X-Received: by 2002:a0c:edcf:: with SMTP id i15mr3610736qvr.151.1584636164003;
 Thu, 19 Mar 2020 09:42:44 -0700 (PDT)
Date:   Thu, 19 Mar 2020 09:42:25 -0700
In-Reply-To: <20200319164227.87419-1-trishalfonso@google.com>
Message-Id: <20200319164227.87419-2-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
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
index 04278493bf15..1fbfa0634776 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1180,6 +1180,10 @@ struct task_struct {
 	unsigned int			kasan_depth;
 #endif
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.25.1.696.g5e7596f4ac-goog

