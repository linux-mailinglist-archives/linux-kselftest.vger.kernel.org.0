Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EA2526972
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 20:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378038AbiEMShU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 14:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353373AbiEMShQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 14:37:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78B3A735
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 11:37:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f902276272so78308827b3.21
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Yh02o9GYLH67/1J+arp7aJNm9pyvUfcX4BFMxpKB/6c=;
        b=BPHC+p80idgijUzxQ2VgogEPiKtlEMS/46dRxh2t9y5Y/UARSIl3q9actVsOvKFJ0J
         /WcX25xDa+31PPOC9Mf2p0iD5qY7Gu+zlcrhSh3GpfXQFigfgmL/6dA9Xykqb6Amvozz
         9sB+BlETpycuVV9XDxqRECrs/kJRIZ8mDmray0apCcOLybXwFia+fwpFh2/p65d0j1Ls
         NLJaqXoIQaWmHoRzy3sqcY5VN9sLUq4c0o9kaeRzgACju5q6qg1QzQyxV6HXvDsjSPVY
         tJFqFBf1WOya5+8R0MTm22eBRpb5lI9G9qfRtn/Xlb1PelJoF8jAibjz2p6JWlIDzCzY
         ISGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Yh02o9GYLH67/1J+arp7aJNm9pyvUfcX4BFMxpKB/6c=;
        b=kC+keDvgG3+bwq1TZ5msFigldYnyr8P4QO/E3Yh/9aI+b8FR92KoYKJs94+2WMCs4i
         U3mGJSjkTAwZW+IzwgeFYnPIYAts+fMHgCppy5JsUsxx2+6Y/kckju2eVHv7XrMqqOuA
         KTJGAQmhIdsKiJe44fJ/X/nKenFX1HZ+5yIjAiB6ouoqfZhH1YgI6zYs+w9l1Vc4uYoc
         zIRgoh6xfTv88HGAwkoENiSCqOJy/97VOoPzKDzv8kfB2TVnjugbCbMtZoUc/6XkdGBR
         zxEeCpMo+LphN2/NA8HWCFDUGRvR+8MP3C2uYumcuHRiquz42LIpKoK+U8pjjDiZeTCL
         j9dA==
X-Gm-Message-State: AOAM53170/jWmzcbHIhWtg5NQ924WJkEirMX8wquD1qq7Tz4obtRsjlF
        PqEt7aeA9Ce9IvGJYuky1e69YHjqvlqL9A==
X-Google-Smtp-Source: ABdhPJzj3OKj/mMfqU4Tu32K5Oey/kBX4W+CQMnnrMy9VhjWUWKoHrW2v5gOmfYJu1VAF5KdHf1a6mFy3Iizew==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:577a:4fdf:13a8:670])
 (user=dlatypov job=sendgmr) by 2002:a0d:d4d4:0:b0:2fe:bb8d:43a1 with SMTP id
 w203-20020a0dd4d4000000b002febb8d43a1mr3636186ywd.324.1652467033850; Fri, 13
 May 2022 11:37:13 -0700 (PDT)
Date:   Fri, 13 May 2022 11:37:07 -0700
Message-Id: <20220513183707.97290-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] kunit: fix executor OOM error handling logic on non-UML
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The existing logic happens to work fine on UML, but is not correct when
running on other arches.

1. We didn't initialize `int err`, and kunit_filter_suites() doesn't
   explicitly set it to 0 on success. So we had false "failures".
   Note: it doesn't happen on UML, causing this to get overlooked.
2. If we error out, we do not call kunit_handle_shutdown().
   This makes kunit.py timeout when using a non-UML arch, since the QEMU
   process doesn't ever exit.

Fixes: a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/executor.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 2f73a6a35a7e..96f96e42ce06 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -247,13 +247,13 @@ int kunit_run_all_tests(void)
 		.start = __kunit_suites_start,
 		.end = __kunit_suites_end,
 	};
-	int err;
+	int err = 0;
 
 	if (filter_glob_param) {
 		suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
 		if (err) {
 			pr_err("kunit executor: error filtering suites: %d\n", err);
-			return err;
+			goto out;
 		}
 	}
 
@@ -268,9 +268,10 @@ int kunit_run_all_tests(void)
 		kunit_free_suite_set(suite_set);
 	}
 
-	kunit_handle_shutdown();
 
-	return 0;
+out:
+	kunit_handle_shutdown();
+	return err;
 }
 
 #if IS_BUILTIN(CONFIG_KUNIT_TEST)

base-commit: 9660209d9418f2295d31fea0d32e313e9b2c1200
-- 
2.36.0.550.gb090851708-goog

