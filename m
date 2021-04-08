Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B53580E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhDHKhw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhDHKhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:19 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89745C0613DC
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Apr 2021 03:37:08 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h30so793694wrh.10
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Apr 2021 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dgjyTod8e5NlTRHP8hFBk5cuF/ijHRvQheYc8gyMq9I=;
        b=M6Xf/Rbyog2V+/5ipdnjPYrvegs+4AWEqnh3Vf6YEwJrOzPT5+oLOkJUu2hHiD83MA
         4qfBHJ6MdBZbAdQMJGejNEDmj9C3lMOkQGhx0VS7wnZChbVqWHdRWSU4XJiWl//yMcj2
         jDJCnu9e2Bf/nrjIR82iVMhDUxpTuLCFC8Y+yZkq8yxrXiw744/nGrTbzAFBfVHk2CUv
         d7qYVlTOleBFId5W2ysq4S1R5TX+Au2xxroBKUaIjD9LAKjoSnOFTj/bClemXw+xyWPu
         YJKFkpBw5FLQbLtUSs9UHvKcBZVIugh6V9tg17TZ6r527tdA8L5BGURSYPhysRXmx594
         kzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dgjyTod8e5NlTRHP8hFBk5cuF/ijHRvQheYc8gyMq9I=;
        b=erO6zL+5NfGb3zfytYpc8FLjSoZyNkupmWQYvnbC8PsVUX/qNTWvDs9J6+PqvYvDY+
         M3NF7bYwUF0JscSHXAzvb1zWkps9OiuDScCeWfatBJYMPKrkntTOMi/WGtpntFwd2rOu
         n9VZ5VIx2YwDS1JwQ3ZBi67kmBkQNXCQ4q40UYl9nfWlhpuNp+8uWHPaE9OKhi69cHWk
         XoPwASaEq3FSoj6s47ZKRWVtOwClDQKg7N5a9NylaCj52dFXlJzVLEVxA0+7C+n+7BbT
         i6A8whDHmdUtyzXDHDY+m/FPDOniZ4dk5rLEmbPdJ81FuC5uqtmocDnUq/rjLxGbeUKQ
         q3Hw==
X-Gm-Message-State: AOAM533aK361PW/L/qMCZHrBq1lqV02QTmAcZYUGd/qDt7qO6NH5wQZO
        PzVC4mhzEFIRMvlRLhXcwtPlsclkbg==
X-Google-Smtp-Source: ABdhPJzAWnsJC1oRb973FYhaVOrRtocL5JizZhaZlBcUlGA1ypP0d6JnLwzlEk7COuhgNIg7gmQvQytuGQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9038:bbd3:4a12:abda])
 (user=elver job=sendgmr) by 2002:a05:600c:284:: with SMTP id
 4mr7768831wmk.24.1617878227289; Thu, 08 Apr 2021 03:37:07 -0700 (PDT)
Date:   Thu,  8 Apr 2021 12:36:04 +0200
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
Message-Id: <20210408103605.1676875-10-elver@google.com>
Mime-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4 09/10] tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
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

Sync tool's uapi to pick up the changes adding inherit_thread,
remove_on_exec, and sigtrap fields to perf_event_attr.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Update for new perf_event_attr::sig_data.

v3:
* Added to series.
---
 tools/include/uapi/linux/perf_event.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ad15e40d7f5d..31b00e3b69c9 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -311,6 +311,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
+#define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -389,7 +390,10 @@ struct perf_event_attr {
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
 				build_id       :  1, /* use build id in mmap2 events */
-				__reserved_1   : 29;
+				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
+				remove_on_exec :  1, /* event is removed from task on exec */
+				sigtrap        :  1, /* send synchronous SIGTRAP on event */
+				__reserved_1   : 26;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -441,6 +445,12 @@ struct perf_event_attr {
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
 	__u32	__reserved_3;
+
+	/*
+	 * User provided data if sigtrap=1, passed back to user via
+	 * siginfo_t::si_perf, e.g. to permit user to identify the event.
+	 */
+	__u64	sig_data;
 };
 
 /*
-- 
2.31.0.208.g409f899ff0-goog

