Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0A638565
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKYIna (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 03:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKYInQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 03:43:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173421242
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:43:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so3295866ybj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dehjIhc0oB2x/7qa8tpHLfPv+8ip2PCtDc/VgLdDFS0=;
        b=U3tR0OVoZ0hHgA1k6gQVY26XcT3oNgQIup/uX30yKzUfLfrSKpvRJsmcSBuhiAXpTS
         rTzQMGzMJNRsRtthJ4BxyoK+TidlhhFCJmjhxBf/o1FEDj74nyLKCXv3UoCsEVkyMOeU
         364amPEiG2TPV7cF3TGX+tLLAPX4almhYT7NCNw9CXxbjzI0V/mb8zoOMitrJVRJA7dj
         so3SRxWDXfqlFI3Uw6FkxsZS8mgE7neClxz6IKN1K/gUkQhbn5yotHy8A0DKQmNZGmod
         UisNijbujJ0UGmHkgWBKaLdxRuxz2CsxSAWjZikzhuh6GNn9njbaHLDcXdeN0Mt/hTxE
         23bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dehjIhc0oB2x/7qa8tpHLfPv+8ip2PCtDc/VgLdDFS0=;
        b=r+RsexCxj18IMd0dL87FEtBueFq3lmpTVWINVldAAHdE5Xo55vQxfte44mBC9vUQrs
         Kh/CdA7/RGKNDnrXLNYHqsifBDZSaHQBxlpiFpsckxH/A/WfWY6ckoQPPuA3Zir0r8jH
         3ZNldwB+TizG6pyWYcoDXngln5lAcKH0lYqnaRUeQ/G6mGW5UW2cajw40QO2YuIpSCwl
         AlShxlOHhGVRQsYEA9zBeI+hgb3iuIMqB2o+bCaMJMjDnUY5yWvO3y9NYmw0xz4ItRmS
         fC5r9zfz1lHFmVrrSnAYoCeAj4b3rQCym5zB2h+lAWtJtklhGdyrJDfu9ZJGPCYsoj+T
         s8pA==
X-Gm-Message-State: ANoB5pny6q5SnZ1fCuxw38u1o1os0lSULYIEQSjWt0jtQmJNyjBKGIw3
        SneVWrS8EgkSYq1kLKTyWDwIfG8xp+0Dkw==
X-Google-Smtp-Source: AA0mqf6SIG2nM06vCqr04rh+5zvembhI1If1NZodMNsjqU25om3zZ8oQIazCspuzdvbnHIuLg9UcLSc+CucUsg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:114b:b0:6e1:ce17:6c40 with SMTP
 id p11-20020a056902114b00b006e1ce176c40mr9ybu.5.1669365793417; Fri, 25 Nov
 2022 00:43:13 -0800 (PST)
Date:   Fri, 25 Nov 2022 16:43:04 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221125084306.1063074-1-davidgow@google.com>
Subject: [PATCH v4 1/3] kunit: Provide a static key to check if KUnit is
 actively running tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit does a few expensive things when enabled. This hasn't been a
problem because KUnit was only enabled on test kernels, but with a few
people enabling (but not _using_) KUnit on production systems, we need a
runtime way of handling this.

Provide a 'kunit_running' static key (defaulting to false), which allows
us to hide any KUnit code behind a static branch. This should reduce the
performance impact (on other code) of having KUnit enabled to a single
NOP when no tests are running.

Note that, while it looks unintuitive, tests always run entirely within
__kunit_test_suites_init(), so it's safe to decrement the static key at
the end of this function, rather than in __kunit_test_suites_exit(),
which is only there to clean up results in debugfs.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---
This should be a no-op (other than a possible performance improvement)
functionality-wise, and lays the groundwork for a more optimised static
stub implementation.

The remaining patches in the series add a kunit_get_current_test()
function which is a more friendly and performant wrapper around
current->kunit_test, and use this in the slub test. They also improve
the documentation a bit.

If there are no objections, we'll take the whole series via the KUnit
tree.

Changes since v3:
https://lore.kernel.org/linux-kselftest/20221119081252.3864249-1-davidgow@google.com/
- Use DECLARE_STATIC_KEY_FALSE() -- thanks Daniel!

No changes since v2:
https://lore.kernel.org/all/20221025071907.1251820-1-davidgow@google.com/

Changes since v1:
https://lore.kernel.org/linux-kselftest/20221021072854.333010-1-davidgow@google.com/
- No changes in this patch.
- Patch 2/3 is reworked, patch 3/3 is new.

---
 include/kunit/test.h | 4 ++++
 lib/kunit/test.c     | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 4666a4d199ea..87ea90576b50 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -16,6 +16,7 @@
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/jump_label.h>
 #include <linux/kconfig.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -27,6 +28,9 @@
 
 #include <asm/rwonce.h>
 
+/* Static key: true if any KUnit tests are currently running */
+DECLARE_STATIC_KEY_FALSE(kunit_running);
+
 struct kunit;
 
 /* Size of log associated with test. */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 1c9d8d962d67..87a5d795843b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -20,6 +20,8 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+DEFINE_STATIC_KEY_FALSE(kunit_running);
+
 #if IS_BUILTIN(CONFIG_KUNIT)
 /*
  * Fail the current test and print an error message to the log.
@@ -615,10 +617,14 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	static_branch_inc(&kunit_running);
+
 	for (i = 0; i < num_suites; i++) {
 		kunit_init_suite(suites[i]);
 		kunit_run_tests(suites[i]);
 	}
+
+	static_branch_dec(&kunit_running);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
-- 
2.38.1.584.g0f3c55d4c2-goog

