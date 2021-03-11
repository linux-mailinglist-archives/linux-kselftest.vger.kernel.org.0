Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73C233770D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 16:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhCKPXr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Mar 2021 10:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhCKPXZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Mar 2021 10:23:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9FC061760
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Mar 2021 07:23:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d8so26052562ybs.11
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Mar 2021 07:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L8a6v/RpOX6g+ehik5lO30YcIfvFidygA9WSxm1D+Yc=;
        b=rjQJB/nSV8vMfPN6EV3mW4Sd9rlhVDO+UMZeva8LPjp1RkVyS87whQEEx1r8YgVldq
         iehwWrrsqtdbDWaXbi9V9ExkIdVvMthznM9+Ho5SMGoCQiMNoa1ZggUjX9t/Uccl6lgo
         GZ3xzy4SnQArHKwgwKQ4lAD9FV6QARIWq+6gLUkCZA9A74uR2BoMJ7PUcOy4C/A8eXRT
         OIBfOvRbQOGTXl0yUy56n+RxpPqvM9gmLcdEm+NcOBrcPGuFPsf71YUB/DqTJBk3BL0z
         XsblTltDpLQrJ6osoLa0hqc7G5zK+eFB5+LFyvwL9cdxTabJywM47Z1fsg5xvVU4FNl0
         N9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L8a6v/RpOX6g+ehik5lO30YcIfvFidygA9WSxm1D+Yc=;
        b=O92KHB4uLyq35OjvfvBkdP/Lyo/hKPGOYT/z4stUyVv53cN84GdF96/srEKr2l6c9K
         k7OWyGT7b0XJ15sZaMDzk683eOphNfGAQziZpeCU98aZ4wMVM5gx/lXK+dLnGSDDjS1k
         CoPRRquDR12gfsYvndANryctImtcs2wSA7FssMDt8cyrKGuJ2KylwADVKgsV5GjRTZ4t
         6Pt1cPrKNlVRdMcTVqAlURU3pEMKTdMRt7SuFzlJSMjYYSCDHXp2kyLZjCteR65HDWGL
         EH6QllxhgTGnucL7khSDBZbdR/QlO5oTUynR5Kf5CBD5C7/ND861ibtX3rR1p0VifpDV
         uJDw==
X-Gm-Message-State: AOAM530RfdVgru6rU5rtJ6TqPY5ygzWRzAIUNBcIzfuXv0kMi9SQ2lBA
        /sn7cpQCq5uxUtkS5R52bZ/3u2PLBUWZCA==
X-Google-Smtp-Source: ABdhPJz5XPbO6QvMxe+MoyS6OSsJiqu6t+BxS1+Z9XneXHEffoKuiHsRsCJ2UGA3OapzbfJ5IFewPVGOxa7U5g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d84c:1a92:8f6c:2d41])
 (user=dlatypov job=sendgmr) by 2002:a25:bfc1:: with SMTP id
 q1mr11335225ybm.89.1615476204498; Thu, 11 Mar 2021 07:23:24 -0800 (PST)
Date:   Thu, 11 Mar 2021 07:23:14 -0800
In-Reply-To: <20210311152314.3814916-1-dlatypov@google.com>
Message-Id: <20210311152314.3814916-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210311152314.3814916-1-dlatypov@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v4 2/2] kunit: ubsan integration
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, alan.maguire@oracle.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
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
2.31.0.rc2.261.g7f71774620-goog

