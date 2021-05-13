Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC7A37FE35
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 21:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhEMTh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhEMThW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 15:37:22 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D00C06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:12 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id y18-20020a0cd9920000b02901c32e3e18f7so22117563qvj.15
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2O58jXnETdEbs4jVdtA0T0Vt+DD9mkqY3jDs31OqI1U=;
        b=L5x5B79nG2yasENXeTN12F+UXiA4asq5ViYFWln7Wgad3Qkt8PMuW0BkX6fQT1iubG
         m9RbbydDyHxnzAJAJfxhxTv/Wv37BxU2F027eoJ/Otf2yzK1UlCglgzuHY/R/caTg7QO
         MkaiEaxFUk+D3r1/29ZVFB9ZL3LmyMHVew6pygLP8K/tlw4F7sWUWFAEaoE6c6GwgWj3
         ZAUVPawjvZsNk8frXZM0ti9Atnsvl1T1wcWQ1huhkVKmoXNCFnSZ8/rWjT1MNx0Y+EtH
         f1qN97pMU0vdzxIJ3eWXRTYCC+lodWI8DLV6bs5VWTHLxvGIyuM6jkuH7FFk/5DStlUT
         S7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2O58jXnETdEbs4jVdtA0T0Vt+DD9mkqY3jDs31OqI1U=;
        b=tyNoPU00mrnvbj9sR1z5lqGLaUTM4QXZBluGywi6bDS051S6ok+vxsQP/Uex48NJm5
         nzssbdunabuLDEVgt9nmt3HEx5zZ8Mxk0PXx9kDapJY8buLTjDM2N+k/Ff4JtFL/5cuu
         oNNqaHFrogn7ifYyGaoa+428YTR421W/Uz27WvSg+g8VOe7X3CYl4KpXHgVdzeDMWxeB
         JhpWNjSRudo6EraVHWe2WgSPxaKjYjfVxf9N1m1M3Fi4dhhTf8fUMORFmmbTJ7NtBOw4
         BUc+qTEOM6fkXQCC0yz/JhBV6SVWx0G5gLQ09AbXGByzWCep6ZZji1vEPbpUHSQyXmR/
         E04A==
X-Gm-Message-State: AOAM531GoRfbsZUcEugJGG5kGkWxzEHE/0ay1tVI3OdS4mrzLNf5gicu
        4ZzLAQRz6Wv2ktUXuqcV/olIFBg3He95vg==
X-Google-Smtp-Source: ABdhPJxNmOIByMOB6nwOsj8kvWrsLHtfRYpnAZL03VNkudsSypOoG1v/BHcAY8WJYP4Ng/S5PKoPTpK8/01asA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a05:6214:951:: with SMTP id
 dn17mr42776333qvb.27.1620934571219; Thu, 13 May 2021 12:36:11 -0700 (PDT)
Date:   Thu, 13 May 2021 12:31:59 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-5-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 05/10] iio: Remove a cast in iio-test-format which is no
 longer required
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit's EXPECT macros no longer typecheck as stringently, so casting the
result of strcmp() is now unnecessary.

Signed-off-by: David Gow <davidgow@google.com>
---
This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 drivers/iio/test/iio-test-format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index 55a0cfe9181d..f1e951eddb43 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -8,7 +8,7 @@
 #include <linux/iio/iio.h>
 
 #define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do { \
-		KUNIT_EXPECT_EQ(_test, (int)strlen(_buf), _ret); \
+		KUNIT_EXPECT_EQ(_test, strlen(_buf), _ret); \
 		KUNIT_EXPECT_STREQ(_test, (_buf), (_val)); \
 	} while (0)
 
-- 
2.31.1.751.gd2f1c929bd-goog

