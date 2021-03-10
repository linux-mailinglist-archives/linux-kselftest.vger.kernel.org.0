Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF76333A4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 11:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhCJKmX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 05:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhCJKly (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 05:41:54 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AD5C061760
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 02:41:54 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id z6so7772585wrh.11
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 02:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JNI5Tf6KKGhkGniIZ5cU47CifTg2LZA5JMDRp5Vdgq4=;
        b=U/F3Fdi9Xrysxyu01Jy30XoAyPRhEX+3vDUdNMjOm7dIVG2DHhU72lAaBvBhkE9yrZ
         VOzKe1ZEpDfNb0hR2ksuCFVTja5hCLZwcroB+PK+N9hpkimZmjslooPo8ld4Vy+LeA2/
         MG5/roSaELFmoquzWZ6cncBEyZB1umoe3wZFz/ICpoU64POFS8ItvjAbsdz2BhkX+wJh
         2bYkH25XVcT4JN0n+OCchUTgbtTWRGYcpOq6MhQsetfP96kLkFgBOGcLHDCU5OqrHUIa
         uLA0gRr/TvN8q/75dy+Tkx0sVvG+663GP/UZvoIU6NWI7p3sWN3RDIjwyspDDvAm05QI
         AuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JNI5Tf6KKGhkGniIZ5cU47CifTg2LZA5JMDRp5Vdgq4=;
        b=TpnS0R+SDJbUmCGwPunBadcWlPTpv0PrN2mE8ahFGs9qPnXPPx6WmLL+lJKEPWS3Hi
         z9ROpHGU2Ku5CbLW26G4Z387ObHltZAC7+F69lQls5gaKC5NBwW3r68S/JZ2NaLYTfjf
         zOhAOlUsZSqIlYA2pmp+GbZ4E0B5YS+9b99J8MCDChRuSyYSvy65mQXZfG6/TO+722gi
         eM/QMz01/06HxTr2Ux9e6aCYECwf8GH6yEhuKtAAmNfSOkmVBjkq6RZXNkx3RhIt+gj0
         YPeFHPzvYbiT/rM2O7Ofpkqjo/qfkfe+piTFElr0GU9PY4Jh8x9Jj/Xt6D6UIVynmf0v
         F8ag==
X-Gm-Message-State: AOAM5323cuMmsXrXaK5++UfnpJ7t2GTUrYGwyoebfvQ/cNSxawCCDzXW
        +VSnqTCKQUerIF5XNFk6wdKNBAbx5g==
X-Google-Smtp-Source: ABdhPJxh8boYmWup7xVABan/lqZvFVU3ZuX3Cf8erA2PUSW5aM45Fv/PW2DBnvnPpCf+kQnMcOhuRT0joA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e995:ac0b:b57c:49a4])
 (user=elver job=sendgmr) by 2002:a05:600c:608:: with SMTP id
 o8mr2806133wmm.42.1615372913037; Wed, 10 Mar 2021 02:41:53 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:41:32 +0100
In-Reply-To: <20210310104139.679618-1-elver@google.com>
Message-Id: <20210310104139.679618-2-elver@google.com>
Mime-Version: 1.0
References: <20210310104139.679618-1-elver@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH RFC v2 1/8] perf/core: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES
 to children
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As with other ioctls (such as PERF_EVENT_IOC_{ENABLE,DISABLE}), fix up
handling of PERF_EVENT_IOC_MODIFY_ATTRIBUTES to also apply to children.

Link: https://lkml.kernel.org/r/YBqVaY8aTMYtoUnX@hirez.programming.kicks-ass.net
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0aeca5f3c0ac..bff498766065 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3179,16 +3179,36 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
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
2.30.1.766.gb4fecdf3b7-goog

