Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD84B57E52B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiGVRP5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jul 2022 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiGVRPy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jul 2022 13:15:54 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E31E3E6
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 10:15:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id bd7-20020a656e07000000b00412a946da8eso2625455pgb.20
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S5cNbvav8USkmIEO4JyFG7st/81vwwIaAFb/mwn7PBw=;
        b=ZijylNG/dIr7hWeGOThw0F1FX6gZqPIINac1RikPNL2Vu4wePiDr7jZuU6qIC5cuaG
         XNRKI0kBU7C3JPm7J/65+xrByvLzo8y3HdvpHHbqFBzAEfRJE7ZnXXTyRgtjt6cfLkY9
         2MsO7lMPJE3fjnRDwsl6JN0jwfY/JMVyASX8WBCPMS/OJlPJFckOgUmN6cJlGGjYrkei
         6laVWLPSFcnMjJHQR0Z8ciO2egpgl/YamGSq5ON1PWDG2UVKiYa+aRUx4KAEUdTeFMt8
         cGxNS2blvqFhWmOAwIYvNE1soe3QsVF6CH2lupiR2xU1Ap49O7N/Al4TmVzxVXOPpCVr
         mwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S5cNbvav8USkmIEO4JyFG7st/81vwwIaAFb/mwn7PBw=;
        b=oPcgjGGOpeGKonYAWRlIbeq2pxA0ufJpgrL88STa3t+d6WioN4JyDkOE+dpUMbKb6e
         A+B7h/pKxeoegLViQ9X2QpsLT6NOnNAg5Fcl7B/uLeDTnR7xGslBw+rbdD7zeUkGa9lk
         jh+e6c+9dke5QKRIm9DP7/gVJ/NvCeudiQ7iU8baumwc27YInySr6j99OjJL6JWqvli4
         soU8Ce7EgKq2c8aazsFB/44cV9sDpeNUPH0bdQTPFJnzW9ePOsm8TfDiQSIGxveXxIcT
         RIvJ2SBMykmllt7UEX/E/qzev/4DUzAh4eeFKm/kK9090ZLdwpr1SAcGCCdEO18clCQF
         7hFg==
X-Gm-Message-State: AJIora/FgldeLx+hi6zWtRomgdByPX8/yG1a3mYcW62fe0hx8Aa4rbDi
        wAJCc5IftzxF2TmeHu0FdEw3wlxXJKcuTg==
X-Google-Smtp-Source: AGRyM1t7wmAT+3kke9a3GR632MG8LKFNIvuSwnvOkrBbzMVDoTtceecqxaXTlOz1WmmOvfcM1J4KJniDJP7MEA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:aa7:888a:0:b0:52b:17e8:fd1 with SMTP id
 z10-20020aa7888a000000b0052b17e80fd1mr785288pfe.46.1658510153314; Fri, 22 Jul
 2022 10:15:53 -0700 (PDT)
Date:   Fri, 22 Jul 2022 17:15:34 +0000
In-Reply-To: <20220722171534.3576419-1-dlatypov@google.com>
Message-Id: <20220722171534.3576419-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 5/5] kunit: make kunit_kfree(NULL) a no-op to match kfree()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

The real kfree() function will silently return when given a NULL.
So a user might reasonably think they can write the following code:
  char *buffer = NULL;
  if (param->use_buffer) buffer = kunit_kzalloc(test, 10, GFP_KERNEL);
  ...
  kunit_kfree(test, buffer);

As-is, kunit_kfree() will mark the test as FAILED when buffer is NULL.
(And in earlier times, it would segfault).

Let's match the semantics of kfree().

Suggested-by: David Gow <davidgow@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
v1 -> v2: add this patch to the series.
---
 lib/kunit/test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c7ca87484968..879c8db36cb5 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -698,6 +698,9 @@ static inline bool kunit_kfree_match(struct kunit *test,
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
+	if (!ptr)
+		return;
+
 	if (kunit_destroy_resource(test, kunit_kfree_match, (void *)ptr))
 		KUNIT_FAIL(test, "kunit_kfree: %px already freed or not allocated by kunit", ptr);
 }
-- 
2.37.1.359.gd136c6c3e2-goog

