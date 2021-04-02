Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17D53530AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhDBVVq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 17:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDBVVo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 17:21:44 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48CFC061793
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 14:21:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q2so5588010pga.5
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UePj996uKa4lehiTow3eZigOHzjo+KgWqwcYD1BR4Xg=;
        b=Y2BXC+V0hte2wealulibEqC6ISSDAkt6HxgwCE2RY/9/WcHg+JyAIv0J59F7K7wzti
         jT3KdIWNeJypuM5604GIYxGvW1bJGE/mkrT66JHUxWJrvhfkwQAiE0FFKsNKafbARQVH
         Y6oB7fY24l8P3LKBFxLBAQZNx9mrnnZQxepajPluNjyrIJAe3eNG7Yn2+1qXAQ1187qI
         4M8iSe0OWH7uQo/oHpz5kHR8B3LRMV4/QDu8IWXnSGMe1bD1rlnohyZ9US4BBbZeG2Za
         EJW2y5Qas9EytPOXm/vJfM/R88T3Nk9HOWelo2MyGmO35i4fOqFpkIE2do/pk2Cvhh1h
         WI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UePj996uKa4lehiTow3eZigOHzjo+KgWqwcYD1BR4Xg=;
        b=GwMwOcCFgA87INuePjZVqBgCO6H2TS9KF1bg8mFqaXtqCGhR8j8ogKD2SqQOLNwlbc
         Zp5LRHa3byuy77OOpzYaE0p2GgOcIsGk++Dkr7ludt0ggGcimfFfOHfpOsGSSXhCDMWH
         Q7l7SKo9U2J7EBH6Vj8IyvrFnt5ohtF1eza4iVpq0eKa3PATFFKOYSbplZWBaRZLupmu
         AI1QItVa1A2VHFoAkaanUHmHp75DReYgRcPZWRnq0n6ybxC95eUWgQEl2SJjQZgUHb2x
         n/U7BuwfI1ZHYv80WmSDARsDIXEc7Lp4oedB1Ara0Z926gk/FTDY/PFim/5Qg+4/pVmq
         yqqQ==
X-Gm-Message-State: AOAM533NDxh9kj7rvkKQTgWfYZTMmvpMIjmMetNSS6W/ZjGmywRtzt8R
        flKCQW0CnEUeQF3W3mN9SP7DJ4RtItFUkA==
X-Google-Smtp-Source: ABdhPJzRtcHkdUGKrnn+iO8bt2LHVQXJq4NUWncxSR3vHCZQZj07EyFLjkW/yuuPLVh68HcUYD5CbOXtKo0Qsg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:51c4:ce05:b8c5:b26b])
 (user=dlatypov job=sendgmr) by 2002:a17:902:7589:b029:e8:c011:1f28 with SMTP
 id j9-20020a1709027589b02900e8c0111f28mr4283459pll.35.1617398502159; Fri, 02
 Apr 2021 14:21:42 -0700 (PDT)
Date:   Fri,  2 Apr 2021 14:21:31 -0700
In-Reply-To: <20210402212131.835276-1-dlatypov@google.com>
Message-Id: <20210402212131.835276-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210402212131.835276-1-dlatypov@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 2/2] kunit: ubsan integration
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, alan.maguire@oracle.com,
        Uriel Guajardo <urielguajardo@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
whenever it reports undefined behavior.

When CONFIG_KUNIT=n, nothing is printed or even formatted, so this has
no behavioral impact outside of tests.

kunit_fail_current_test() effectively does a pr_err() as well, so
there's some slight duplication, but it also ensures an error is
recorded in the debugfs entry for the running KUnit test.

Print a shorter version of the message to make it less spammy.

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/ubsan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 26229973049d..bdc380ff5d5c 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <kunit/test-bug.h>
 
 #include "ubsan.h"
 
@@ -141,6 +142,8 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
 		"========================================\n");
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
 		loc->line & LINE_MASK, loc->column & COLUMN_MASK);
+
+	kunit_fail_current_test("%s in %s", reason, loc->file_name);
 }
 
 static void ubsan_epilogue(void)
-- 
2.31.0.208.g409f899ff0-goog

