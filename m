Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37D3580C5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhDHKhI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhDHKhC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:02 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A5BC0613D7
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Apr 2021 03:36:51 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a7so812141qvx.10
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Apr 2021 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RsfSzYLxgdWoAhPhCR1Dg9aZ0g82F67d3GS+eLHn15c=;
        b=VXjEJZGnfFIzj+Z61j6eazjiurKR3WzLAWdzvDMd9s5cxNbEnbQfHubqcoM5kahDK8
         5HgPjJRcByuwjYsjpH/mQVy3xK366ThuXZoXbH6nGkZ0NtN3M39UmCIyW4KiYQyVMeDf
         QAox6AH5YM0igwlb/v4kJCf81/ncZ0ZA2jROS0ryotfvAJTT5GQnqFyC3jEKG6IG29tg
         EJQVyqb/wrY9m35Jenyq3BHDA2UyJIDHCzE3ed/P35P80Z1NpmpibD8YMNm8WBB8mtj0
         NfjAhM7YBcIyzhFUkDtTbYW+ulVypp1yQk0RkejySWO62tkEYJh1M0G2wbuN3rqwhfFP
         hDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RsfSzYLxgdWoAhPhCR1Dg9aZ0g82F67d3GS+eLHn15c=;
        b=oIcQEplWBacS73VtKqJEF+1AA5izOli56QcB8uAanKVbeBNvocVpDSZzNstmjH1KUw
         g1lX1SPT6X89vKm8arENYyaxukrVVtDYOqIuA5JsaeZF4sIrv6GX1f6jH1XhJHrsgryc
         Ocm2rzt3V029af7POSKRdirCcB9g6TJk/5g49XYI1jssZ/zEAi1/DO+lLJKP877O5F5u
         SogjahoilFNh31+VHh/wsAvWiU+hCWQUMnEnvbNicUNTPw1WH5Zfxx15UmyRyJZblUG9
         Wyl/t2vGSPS1qzLJfOkYHX4JfYOUMqtZ9CXn8ZJ3xh0TSlYcJ4hQl2U4nVxS24In52uD
         1JZg==
X-Gm-Message-State: AOAM531Uwfyc53FOxCR+oZyfOevxLo8YlKpnDu12gOJEPY01w7gD/xfu
        XKt6V3O9PeC4wtIgooWQGTlqpQ7K+g==
X-Google-Smtp-Source: ABdhPJwys+d6NWoxGNSoL11DV7JTAu2M0ZLfJ4lsz1FxgNsEVIcYPwtZd3NnEH4SYQ8M7gMllgDVanznfA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9038:bbd3:4a12:abda])
 (user=elver job=sendgmr) by 2002:ad4:4f28:: with SMTP id fc8mr8186684qvb.10.1617878210503;
 Thu, 08 Apr 2021 03:36:50 -0700 (PDT)
Date:   Thu,  8 Apr 2021 12:35:57 +0200
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
Message-Id: <20210408103605.1676875-3-elver@google.com>
Mime-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4 02/10] perf: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, oleg@redhat.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As with other ioctls (such as PERF_EVENT_IOC_{ENABLE,DISABLE}), fix up
handling of PERF_EVENT_IOC_MODIFY_ATTRIBUTES to also apply to children.

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e77294c7e654..a9a0a46909af 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3199,16 +3199,36 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 static int perf_event_modify_attr(struct perf_event *event,
 				  struct perf_event_attr *attr)
 {
+	int (*func)(struct perf_event *, struct perf_event_attr *);
+	struct perf_event *child;
+	int err;
+
 	if (event->attr.type != attr->type)
 		return -EINVAL;
 
 	switch (event->attr.type) {
 	case PERF_TYPE_BREAKPOINT:
-		return perf_event_modify_breakpoint(event, attr);
+		func = perf_event_modify_breakpoint;
+		break;
 	default:
 		/* Place holder for future additions. */
 		return -EOPNOTSUPP;
 	}
+
+	WARN_ON_ONCE(event->ctx->parent_ctx);
+
+	mutex_lock(&event->child_mutex);
+	err = func(event, attr);
+	if (err)
+		goto out;
+	list_for_each_entry(child, &event->child_list, child_list) {
+		err = func(child, attr);
+		if (err)
+			goto out;
+	}
+out:
+	mutex_unlock(&event->child_mutex);
+	return err;
 }
 
 static void ctx_sched_out(struct perf_event_context *ctx,
-- 
2.31.0.208.g409f899ff0-goog

