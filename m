Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03577762456
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGYVZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGYVZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:25:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90BD212B
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059f90cc5so75164937b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320339; x=1690925139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLoNex9VSKfv9hVd+vj0W4QLZlbUb5hbp+0GMsSnSiM=;
        b=iII52Yr2AsFMrW2gl7h9826rnSe3VHq289Q/djrjkXcmtKmfWF+M66UBMsnBuklFAD
         wNmPfxtVh7FwJSADK8EyZQgbwddlCJ23V9UeneBOn5FSMDMwb4QssEUyPAPtpUw0n41R
         T5OLyofFO0sw4l+4lpStYNVyjCHWbekTJnqMx53GPpeWJJj7Yd7jEx41AYF99IsGKUp7
         7nhxc4H1v8BKg6AXFNzn09i9R5DyqmUzCG+Pv+kFKLoVs8fZlRNs7YAfM6iB3gXrBfcl
         F1UMW10GmBFckL8ba6elSeP6wQY/jWgbvfg6FCtVnpi9IJr4uwM+/c3/ir/gzLXP9PhL
         MB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320339; x=1690925139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLoNex9VSKfv9hVd+vj0W4QLZlbUb5hbp+0GMsSnSiM=;
        b=ImhO21HCo4b0+NA2gP1ixS4hXNmB/mBCFsjgB9v6MeZdYps+GSZW/K5hR97ZXWlmUf
         aD5n6Xbmkqe91FxJAfMzQw9Da0Czy8S4dARMTE0YqOJ73jkMTrxTSK0hLyXqvt/QjAfy
         8/p0KtFfwy0Ygx0u1mUA2bfiNhCJrduII8AqincApEqHr6dLXft7AYlXk/K9NluX72jP
         Iiq7mZUUFhF4fuGOk0eSqKXJglbGCjvMHjXBCjsKAiLZqQ0kAJBvrYLxgos/kMd7rkll
         6cmjNqPoHEh1wvJ8yjjuFRRcKamtrQnHr+Cw0Cl2aBVBiVHQ4WShNKJ13YHGrjjbf/qR
         h8bg==
X-Gm-Message-State: ABy/qLZrMl7nNyNV7sLN8IXVAh4tUzXcxCw5hGtaRcoueTcNgUXP568y
        7OFlJ3h35o0Z50qqJqwa7q6RA6oBWA==
X-Google-Smtp-Source: APBJJlEaVliELKsxjmo7lnBoOldTOEI2gKcgYQIQ7UJ+26Ggo2aC7VjiMcxfQqh9n8hSO6gMLo8oE/BfvQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:b60b:0:b0:576:af04:3495 with SMTP id
 u11-20020a81b60b000000b00576af043495mr3609ywh.9.1690320339157; Tue, 25 Jul
 2023 14:25:39 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:25:17 +0000
In-Reply-To: <20230725212522.1622716-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230725212522.1622716-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725212522.1622716-7-rmoar@google.com>
Subject: [PATCH v3 6/9] kunit: memcpy: Mark tests as slow using test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
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

Mark slow memcpy KUnit tests using test attributes.

Tests marked as slow are as follows: memcpy_large_test, memmove_test,
memmove_large_test, and memmove_overlap_test. These tests were the slowest
of the memcpy tests and relatively slower to most other KUnit tests. Most
of these tests are already skipped when CONFIG_MEMCPY_SLOW_KUNIT_TEST is
not enabled.

These tests can now be filtered using the KUnit test attribute filtering
feature. Example: --filter "speed>slow". This will run only the tests that
have speeds faster than slow. The slow attribute will also be outputted in
KTAP.

Note: This patch is intended to replace the use of
CONFIG_MEMCPY_SLOW_KUNIT_TEST and to potentially deprecate this feature.
This patch does not remove the config option but does add a note to the
config definition commenting on this future shift.

Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v2:
- No changes.
Changes since v1:
- No major changes
Changes since RFC v2:
- No changes.
Changes since RFC v1:
- Added note under CONFIG_MEMCPY_SLOW_KUNIT_TEST.

 lib/Kconfig.debug  | 3 +++
 lib/memcpy_kunit.c | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 550cb967b668..1b3894e861f2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2701,6 +2701,9 @@ config MEMCPY_SLOW_KUNIT_TEST
 	  and bit ranges. These can be very slow, so they are split out
 	  as a separate config, in case they need to be disabled.
 
+	  Note this config option will be replaced by the use of KUnit test
+	  attributes.
+
 config IS_SIGNED_TYPE_KUNIT_TEST
 	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 887926f04731..440aee705ccc 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -551,10 +551,10 @@ static void strtomem_test(struct kunit *test)
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
-	KUNIT_CASE(memcpy_large_test),
-	KUNIT_CASE(memmove_test),
-	KUNIT_CASE(memmove_large_test),
-	KUNIT_CASE(memmove_overlap_test),
+	KUNIT_CASE_SLOW(memcpy_large_test),
+	KUNIT_CASE_SLOW(memmove_test),
+	KUNIT_CASE_SLOW(memmove_large_test),
+	KUNIT_CASE_SLOW(memmove_overlap_test),
 	KUNIT_CASE(strtomem_test),
 	{}
 };
-- 
2.41.0.487.g6d72f3e995-goog

