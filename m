Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FD75FC2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjGXQb1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjGXQbH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 12:31:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30D31737
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 09:30:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d064a458dd5so2177659276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216252; x=1690821052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sBUbFGOfkdg+y86JLV+b2jt4Ke/rKZsCCFE+qCNm2k=;
        b=6xd1vmR/+70epw4GOXC0q2IJen2E23Pe/K33kkUZ4Kgcdmx7E8BxZ2rJWPZjuh5R1s
         1hAMMQ0ON/dM2E5QfRfwRJJhl4W3iwbcmFpn9AJtppBM6z9bmD1RA9kNEmxTQMeqvZ83
         Ya+nCxljoREyNnvYskPglAvaqCtmEj+aK2EFEq10jIc+LJznANpmYg+Zg+VN+3wSTt8Q
         4faK8G71HAHQ48TkmbpTwoeqaUtZouBWcredbS87BpeTVJYzBAR+MJQqHGaQXXCQGsAU
         lFzu8TkL+/2yZo9OWZBlHlKEYiJzVayajsbnqT55leYZIKDGgzwxIale37TKHRUDTNkY
         KnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216252; x=1690821052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sBUbFGOfkdg+y86JLV+b2jt4Ke/rKZsCCFE+qCNm2k=;
        b=FZk3rijo3QgsQYv7Y7UupXfymEZgusfC6VKwLkmbOenKseE/KWd+2oil1o+vgVWLst
         oYE0YYkUW1/040Ov/CZNPc0Mp2hKb5F/Wn8N/3Nms8vv1IzT3YTtlGi10E5Vxlzum8Q1
         1vVqjg1/dASdCNUFI4UdG6pLG92pmCHXHmt02mJPAD6f4UJfs21IrhbzOJhkRhFd8glv
         DOI22Y3TJ3+ZuYud+7QqGBTvu/j0C1lQpz0uBNKToakAbKfMF4QXe/ojB7QaJudK1adW
         bI/bo3zEwzP5dx3xHvyiyg+3CrxV7wQVIFWwKqSffpZmPapwAvWwiRT6lFA/H4I0Qk/r
         z0Tg==
X-Gm-Message-State: ABy/qLazCbQ3KceYn9HqIF8l2gtYp6k/vZEBqndLuJEy173e8LK5kCbF
        rHSorOiqc91hNCXvwxeXVsZ+RX5CCg==
X-Google-Smtp-Source: APBJJlFM3YGjVPZ0AjGp/9h8RQw0ogZlMbM6uvGlB6myyeAR/Nw9B3nJEiGptn+vPN4e9vjsWNJnRHlSHg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:6990:0:b0:d0b:5e2e:8d02 with SMTP id
 e138-20020a256990000000b00d0b5e2e8d02mr32398ybc.1.1690216251907; Mon, 24 Jul
 2023 09:30:51 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:28:26 +0000
In-Reply-To: <20230724162834.1354164-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724162834.1354164-7-rmoar@google.com>
Subject: [PATCH v2 6/9] kunit: memcpy: Mark tests as slow using test attributes
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

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- No changes.
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

