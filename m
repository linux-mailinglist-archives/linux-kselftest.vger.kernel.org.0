Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC7393E51
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 May 2021 10:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhE1ICz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 May 2021 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbhE1ICq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 May 2021 04:02:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E5AC06138B
        for <linux-kselftest@vger.kernel.org>; Fri, 28 May 2021 00:59:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e203-20020a2569d40000b029052f27a0b9b3so3512436ybc.13
        for <linux-kselftest@vger.kernel.org>; Fri, 28 May 2021 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nv+J3ke0GgapMp0UwGNPvITZFCUM1uizFSit9ptyMQc=;
        b=A9wEfeV2t5zjcVvkmopt+OUo5Y7cIiuq7m1TuoNpJzQrlg9gsm8EUl72tZ0ez0V9Kb
         kl6mhDIxUZjaOT6zQ5ZFVycdhRRrOVSotS48Qn39ZT3JFxT352uVJNif0nErp1cXsPn7
         IKsmQHZo2Cv1qFL9knyaREXUzsSfEb57mSBFkpJn9rZp2IHs5CncHIBfk7H8XQzSJx4t
         nEEdpBsj9352d55+nXXMelUzktOVJ6eXBb4WbseKtnb4I7uo75ewLfYgpUzkqenEZWHY
         U6NxtjsAqmKdBLh5GsIH4XDm7oZIZwa0O+ZTiR+Ml5qWAcL8JZjthCTc5c5YunbDWO3b
         T+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nv+J3ke0GgapMp0UwGNPvITZFCUM1uizFSit9ptyMQc=;
        b=UefxRr/K2Aj3AuWTA2z1OHPs+VSqztP1Ia3hv60GjgblvZdquA+oL2bNTIFONUZQ0W
         eoEOcL1G8AvDJJuE5j0Kff/r3o6KIoin/hQ2AON2Wgjp/kANw+Io9ZGux6cgxuxZGlF4
         +FMpEhAur4RfW9w5mQI+7op7Y1kAWlE74rV5yX3UaDx0y/86jIdHm2qBvZCC2kyJ2k7j
         C2zEaJX9FQtwJgayeh2RhGURgcjcwqNxUNY+j7c9raXraRRkazrCTUMNnuj0NCo7/ncf
         ji8xrVki5xPe0mXiFlklXpMc1bmvjmfPyWjMbPlfWwWLYDj56wCTEm77ZIFpCumTIvHJ
         ZcwQ==
X-Gm-Message-State: AOAM531RFpzlXEudsDqx5lTm+dochs+3oZRaf+qFxWa8G6qBtUh8T4aN
        PigM8nWE4VDOWzgfu61ywCBszuL5/WDDqw==
X-Google-Smtp-Source: ABdhPJxNNkb2l9aDeHKTGKTTzls8rE4nlnET5wh8WCWcLieRI70ZHvNzD4OkfPNXZIniPZB50+3I2ZGjOnfq5A==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:621b:e8e2:f86a:41f])
 (user=davidgow job=sendgmr) by 2002:a25:d341:: with SMTP id
 e62mr10161864ybf.197.1622188784739; Fri, 28 May 2021 00:59:44 -0700 (PDT)
Date:   Fri, 28 May 2021 00:59:32 -0700
In-Reply-To: <20210528075932.347154-1-davidgow@google.com>
Message-Id: <20210528075932.347154-4-davidgow@google.com>
Mime-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 4/4] kasan: test: make use of kunit_skip()
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Marco Elver <elver@google.com>

Make use of the recently added kunit_skip() to skip tests, as it permits
TAP parsers to recognize if a test was deliberately skipped.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/test_kasan.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index cacbbbdef768..0a2029d14c91 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -111,17 +111,13 @@ static void kasan_test_exit(struct kunit *test)
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
-	if (!IS_ENABLED(config)) {					\
-		kunit_info((test), "skipping, " #config " required");	\
-		return;							\
-	}								\
+	if (!IS_ENABLED(config))					\
+		kunit_skip((test), "Test requires " #config "=y");	\
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {			\
-	if (IS_ENABLED(config)) {					\
-		kunit_info((test), "skipping, " #config " enabled");	\
-		return;							\
-	}								\
+	if (IS_ENABLED(config))						\
+		kunit_skip((test), "Test requires " #config "=n");	\
 } while (0)
 
 static void kmalloc_oob_right(struct kunit *test)
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

