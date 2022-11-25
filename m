Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF963856C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 09:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKYInh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 03:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKYIn1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 03:43:27 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC721E2D
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:43:24 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id my9-20020a17090b4c8900b002130d29fd7cso5163639pjb.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkxFkrOpjQGLbrLmIP0+FclGqPGzevJvZOLievBv8dk=;
        b=kqgbzNKEz/EBdl30RURuDttaaXxDeC30LnNegyGkFZc9kDj5JRKrZbbcEP9pwVxxZN
         G9XRyB4jJukMFOoeTGeBeQ3CnM0EbzUy0iVy1MuX2Azm+2w3BQ9adRyL9kvkdnoRUBgI
         X6bKvh5wnfqjPenjD+9aZ4sKilQcc3HfOGFYHURPQ69pGtxzEdI0XKeB9kAYdbFzp7Bg
         iV3xmvTGIdnYEq9akRm0/9IGUCEtjMcs+FCtU+t6i2Mn7bMXvKRnkKAJSxnin4lI09Y7
         1pZbQEDt8j+6a4aF/rIVEb1uQE3DhbYONBvJrOsxEcU1VcYGwGBsoyKH/GlpFeZvG8ID
         eajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkxFkrOpjQGLbrLmIP0+FclGqPGzevJvZOLievBv8dk=;
        b=2abhKLDlLIKIc+DsqvKKwRcjJ39dISkN9spYu528BpEqhXPvkdV64azfDvYklZMwe+
         Ri6NVKucnTQWQQazajLEMbNhhtF8O5gYySrNd7zI1A7ttBy71mWIatBBEHtaKbKDw3j8
         RZqMm57kLrZTbiLXkyFg0E4kqjAj7nmrYW/cZfLjjSOykmbhUfuFiWh6zZb9pInacMff
         gO9kmS/fA7xIwxQUKFVcsJ3TwEnQUC651r9Kke0+Oa7GCJHHSOKCbm5qNhZKjBcFgVW4
         zH+xw2+bTbcplvsy9qZ9tIOpGP2PVuZkHbhSP0IEUuUakJCVAzpxVbKdF1vNtW2HyEMe
         bDdA==
X-Gm-Message-State: ANoB5pnYIC2lYgeRvYOE5l8zqeOctvwC99zjuDvXB+JXJp/h0Nwn+IUT
        XHKnGiHq57dH9MgAinfM1sEXkOBwOJKJaA==
X-Google-Smtp-Source: AA0mqf7RiYkevlcRuG6Fr8tnCwq1XAC9tTw8xXaio9yL/yIb9hcwf34Ri5nG0oPQNQBwzo8q3vRzqDIvG97ZmA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:3809:b0:20a:c64c:ae80 with SMTP
 id mq9-20020a17090b380900b0020ac64cae80mr28596107pjb.12.1669365803760; Fri,
 25 Nov 2022 00:43:23 -0800 (PST)
Date:   Fri, 25 Nov 2022 16:43:06 +0800
In-Reply-To: <20221125084306.1063074-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221125084306.1063074-1-davidgow@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221125084306.1063074-3-davidgow@google.com>
Subject: [PATCH v4 3/3] mm: slub: test: Use the kunit_get_current_test() function
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, Oliver Glitta <glittao@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the newly-added function kunit_get_current_test() instead of
accessing current->kunit_test directly. This function uses a static key
to return more quickly when KUnit is enabled, but no tests are actively
running. There should therefore be a negligible performance impact to
enabling the slub KUnit tests.

Other than the performance improvement, this should be a no-op.

Cc: Oliver Glitta <glittao@gmail.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

This is intended as an example use of the new function. Other users
(such as KASAN) will be updated separately, as there would otherwise be
conflicts.

We'll take this whole series via the kselftest/kunit tree.

Changes since v3:
https://lore.kernel.org/linux-kselftest/20221119081252.3864249-3-davidgow@google.com/
- Add Hyeonggon's Acked-by.

Changes since v2:
https://lore.kernel.org/all/20221025071907.1251820-3-davidgow@google.com/
- Get rid of a redundant 'likely' (Thanks Vlastimil Babka)
- Use current->kunit_test directly when we already know a test is
  running. (Thanks Vlastimil Babka)
- Add Vlastimil's Acked-by.

There was no v1 of this patch. v1 of the series can be found here:
https://lore.kernel.org/linux-kselftest/20221021072854.333010-1-davidgow@google.com/T/#u

Cheers,
-- David

---
 lib/slub_kunit.c | 1 +
 mm/slub.c        | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 7a0564d7cb7a..8fd19c8301ad 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/module.h>
diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..1887996cb703 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -39,6 +39,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/sort.h>
 
 #include <linux/debugfs.h>
@@ -603,7 +604,7 @@ static bool slab_add_kunit_errors(void)
 {
 	struct kunit_resource *resource;
 
-	if (likely(!current->kunit_test))
+	if (!kunit_get_current_test())
 		return false;
 
 	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
-- 
2.38.1.584.g0f3c55d4c2-goog

