Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77204F4CFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354939AbiDEXhG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573407AbiDETIX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 15:08:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA66DFFAA
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Apr 2022 12:06:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e4-20020a056902034400b00633691534d5so48025ybs.7
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Apr 2022 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tybtDUXPQXhYvxy9gX9DtZoGahyOTlz+nyL3O6sS+eo=;
        b=h55LQ5UM26LmuR62itH0V3ChlAvpYZ42TMOG+f3rw/mp6yjZnbWVTBqCVC/cYwSpbJ
         0slhnsMw8p5HDGyheffeBMt9zi/aVwh5t8Gf7LrBGxT0cPJmANCdN7zFwWMilsAMUZa6
         TzzBiH0fBhF0mSBYx1fyC0NSJlwUVBxpPtE5Ca/Mxtbz6VpeTZv/xwCB7nrQJzv/SJAT
         ZJuw8JE3e9gE0Z2uRNM9YJ9BYy0WKQ+QJ2f04nE2hqdD8T4vfJg8iP4/CSwBE6xw9t9C
         DVfEUEfehQdRIJRmTihSNwrCHnUIVOonp5jTmy6cY1aNVMPQQzOdZfVnn0fiJC3lJrLi
         VunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tybtDUXPQXhYvxy9gX9DtZoGahyOTlz+nyL3O6sS+eo=;
        b=3U+BwRC93EdiIJYwrr69HDWAvMqFm3yN03i8Qn/YyucPqxQ7YiAwN6/L3+TSma9mG4
         1hrJjt6anZvMhYpT1L0NyavUDY6PR8afKpT1bid8QJDJBHclg5j9KpwxLzSOxOsq2e+s
         cSrXtwHNmCbWLdtG6NlsPr6xFjzQ4wKbdc6PM+Jbaagurlo3q68V1RhLLjb00A2fDY9c
         At1C+Vk7xRITCNPAfFftWJyydyOvH4XvfXBMmVN5a8jgYO5l/sP40vGs9yfc6WtdreZl
         0R0otWR09kWQhO27AP96BOtNZXkWagAkvSS/fkQlnXsrruFbKCAbbLhozehW0uVmq5TJ
         rpFA==
X-Gm-Message-State: AOAM533GW8u08zNpP8eJmE6wnGwxQgJOZlE8AR82cotzaksh/3fRtcRC
        TG3qhiGnIlskgT51OIrxhVx4Ghn6dKfpYQ==
X-Google-Smtp-Source: ABdhPJyS4HtUjq4SgKDYWs2pqZ3jGC7+tr0ONFznLmh0DXJtM1MTD9FYY9//H3zpss6UMjYo3owbHd6QA24s0Q==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:83dd:c30c:6cd0:4323])
 (user=dlatypov job=sendgmr) by 2002:a25:5d0d:0:b0:633:25c8:380 with SMTP id
 r13-20020a255d0d000000b0063325c80380mr3608330ybb.167.1649185583488; Tue, 05
 Apr 2022 12:06:23 -0700 (PDT)
Date:   Tue,  5 Apr 2022 12:06:19 -0700
Message-Id: <20220405190619.540177-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is in line with Documentation/dev-tools/kunit/style.rst.
Some of these tests predate that so they don't follow this convention.

With this and commit b0841b51cac9 ("kunit: arch/um/configs: Enable
KUNIT_ALL_TESTS by default"), kunit.py will now run these tests by
default. This hopefully makes it easier to run and maintain the tests.
If any of these were to start failing, people would notice much quicker.

Note: this commit doesn't update LINEAR_RANGES_TEST since that would
select its dependency (LINEAR_RANGES). We don't want KUNIT_ALL_TESTS
to enable anything other than test kconfigs.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/Kconfig.debug | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 075cd25363ac..36865b37b33b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2140,10 +2140,11 @@ config TEST_DIV64
 	  If unsure, say N.
 
 config KPROBES_SANITY_TEST
-	tristate "Kprobes sanity tests"
+	tristate "Kprobes sanity tests" if !KUNIT_ALL_TESTS
 	depends on DEBUG_KERNEL
 	depends on KPROBES
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This option provides for testing basic kprobes functionality on
 	  boot. Samples of kprobe and kretprobe are inserted and
@@ -2417,8 +2418,9 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config BITFIELD_KUNIT
-	tristate "KUnit test bitfield functions at runtime"
+	tristate "KUnit test bitfield functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable this option to test the bitfield functions at boot.
 
@@ -2452,8 +2454,9 @@ config HASH_KUNIT_TEST
 	  optimized versions. If unsure, say N.
 
 config RESOURCE_KUNIT_TEST
-	tristate "KUnit test for resource API"
+	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the resource API unit test.
 	  Tests the logic of API provided by resource.c and ioport.h.
@@ -2506,8 +2509,9 @@ config LINEAR_RANGES_TEST
 	  If unsure, say N.
 
 config CMDLINE_KUNIT_TEST
-	tristate "KUnit test for cmdline API"
+	tristate "KUnit test for cmdline API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the cmdline API unit test.
 	  Tests the logic of API provided by cmdline.c.
@@ -2517,8 +2521,9 @@ config CMDLINE_KUNIT_TEST
 	  If unsure, say N.
 
 config BITS_TEST
-	tristate "KUnit test for bits.h"
+	tristate "KUnit test for bits.h" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the bits unit test.
 	  Tests the logic of macros defined in bits.h.

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1.1094.g7c7d902a7c-goog

