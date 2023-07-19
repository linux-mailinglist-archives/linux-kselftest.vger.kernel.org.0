Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3383675A1C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 00:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGSWYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGSWYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 18:24:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E292269E
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:24:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c4f27858e4eso116494276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805443; x=1692397443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIpA2pCI31/vstZBCLZcYLfoiRSlzDk26WYykbpKRs0=;
        b=aExkNcdCiwSKCRFZQRazAUw+POtV1ZY1oY9KqCPuUxyVDSTb4m7ZAUwBMuxPLeoQ+E
         DhWO8r0jkU27P0phJTEl3A8y68Whl8jlHqJ1E+Rx0jpAgawkmZAJ/x1Mx0BmYLFGdHVz
         eo20uVmy3pITzg5bS2045EFmAZwykYS14y1/Qg4NekGJRL7Bc7WwSYMfLr5at3TNAxJM
         jf6Y83WMI3JiuA/PuMczSd6rk8iLz2RLaiY09ZDjFbtGXVJphJ/lSohb7khozR5skgCP
         cceUTwiITld3gT+F4qjy1dNl1t39Ji0Z4QyZdZ1SCY3b7NeGFUJUE25UexBP6Sx+AbQb
         kBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805443; x=1692397443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIpA2pCI31/vstZBCLZcYLfoiRSlzDk26WYykbpKRs0=;
        b=Hl87ybakJIQZzc7ET+9ILFlUf5mZWgcct/KfYgVI1ylVvMg2MdqR4dmST2B+a+C0aJ
         PAG4/P+EIMUDPDwdaOccgwaPXqxtDmUIQhO+emJ0ByCdEa1jbuqbQOd28g8P1LRZ0ylT
         WM35ebd3pD+yBNx+rhK9Bd2/oU7LBeJkrJ4CazY7Lb5ZydN5ZPGc8+IqeT4Q2g/oB8pI
         bGhNK1uI+SaHAUyMJWrcciKsDGyy0FWZzfy49Zm1TWqolTQspT03XD9Z9lyzKXlLAnJa
         u+aaC1KkhniAYfjqbTizSJELlcum8hiAVKqOwjriFR9agfZinV0BYe/xyf2iJ8B7yeGy
         9zzA==
X-Gm-Message-State: ABy/qLau8h8syd9o0zoUkyl47RkMTAJIchqyh6EV6h8mwVORS06e+ADS
        OIojwIEaXcMvZecMmF28s7M0HHWP6g==
X-Google-Smtp-Source: APBJJlGeGls/YLAeNAIERgqeWPE5erbYuzQ303eiV8XxFbMU4b4hvDE8HhmtlZjiF7NRQ61XmgEJ53g1zA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:26cb:0:b0:c22:c2e0:93bf with SMTP id
 m194-20020a2526cb000000b00c22c2e093bfmr29785ybm.6.1689805443549; Wed, 19 Jul
 2023 15:24:03 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:23:33 +0000
In-Reply-To: <20230719222338.259684-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230719222338.259684-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719222338.259684-7-rmoar@google.com>
Subject: [PATCH v1 6/9] kunit: memcpy: Mark tests as slow using test attributes
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
2.41.0.255.g8b1d071c50-goog

