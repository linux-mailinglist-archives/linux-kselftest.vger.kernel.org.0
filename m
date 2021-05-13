Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A566F37FE42
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhEMThk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 15:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhEMThc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 15:37:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E73CC0613ED
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so33401542ybo.11
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uesRCr8313wG+vCOWF3u1DHopuCyxne+XAdqmPkGhP8=;
        b=ZxyXdXF+ZnTVHwxKaCvnkw3FUcmy9NXlcK0ZegM4sCUniXCSoIvlO8w1qQa6KQRJkt
         YcQFIRNM6bmww0hgPIsjcIzAPjJwhKYkD38IIgNudvGW5fI5osGUurDlSWpIK/z0QJ1B
         7fBBf3TtzbOnsBM17Wro1Xj0hsrWj12Ln0mKdIs2ZYTaoyCpy1blKnE3URdNDUMSXO9R
         9DApNOLaoPoauwXsuTNt0Vfgxh0ZM+HBU4fMk+kYs5D89FGmM9OW2+p9sVrvwmByRv42
         6aWrENvJPbG1qXg9n4E4pKADUA+qmAtbA4+FqQUPu8dkuwp99FPf+G08l1fSj4YLedhn
         Cz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uesRCr8313wG+vCOWF3u1DHopuCyxne+XAdqmPkGhP8=;
        b=gdMr0xtqdfViCy5QnY4SD1jTkS8FxF6Mj5NDyxmsL3BWmITIH+8DsxONLauX2U6ITC
         YbhksqTrFC4wI7nQBMGgELQ+y6RwIw9dq9kvkkA1ysdUXAhp9OWLYbubuG5H2p/SgnMF
         AYWkLDC54snnPrLQZ08QBtwqw3zSMU5RzX6jdGziWrqFTzRXfPefkXcw2mfJmiycOxzT
         JV5Xvtus+Nwl+iUvJ4UqDQvu3yST/H01RpEJT5H2ihPO7tl3cZ0JsTfcAebqz/n+ULl2
         8Y9cxCo1TdoJX3k3qt2P5EFUiLctlEF1FuoDwXjgS6Y5O0+FxIIaspfXOvAeXLrtym15
         b8Jg==
X-Gm-Message-State: AOAM530iFtyYUh1WHBZ4lLniuIC+ooHVJBXZDa5XjruYmzmGrdxBQH2o
        chriA8+cRUd8P4WaAUWj2ZkLv7XyTnA2Wg==
X-Google-Smtp-Source: ABdhPJzzHjOb3+w4JZh0UgJjKO4WsLvHmrG/k66xGE9wDTpIjhZp/GOSfxOWoreR8MaxT8n/4cP0ePamJMV1vg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a25:aa72:: with SMTP id
 s105mr62972439ybi.95.1620934580631; Thu, 13 May 2021 12:36:20 -0700 (PDT)
Date:   Thu, 13 May 2021 12:32:04 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-10-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 10/10] lib/cmdline_kunit: Remove a cast which are no-longer required
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With some of the stricter type checking in KUnit's EXPECT macros
removed, a cast in cmdline_kunit is no longer required.

Remove the unnecessary cast, using NULL instead of (int *) to make it
clearer.

Signed-off-by: David Gow <davidgow@google.com>
---
This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 lib/cmdline_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index 018bfc8113c4..a72a2c16066e 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -124,7 +124,7 @@ static void cmdline_do_one_range_test(struct kunit *test, const char *in,
 			    n, e[0], r[0]);
 
 	p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
-	KUNIT_EXPECT_PTR_EQ_MSG(test, p, (int *)0, "in test %u at %u out of bound", n, p - r);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %u out of bound", n, p - r);
 }
 
 static void cmdline_test_range(struct kunit *test)
-- 
2.31.1.751.gd2f1c929bd-goog

