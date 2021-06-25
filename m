Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3043B4AC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jun 2021 00:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFYWvd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFYWvc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 18:51:32 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C3C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 15:49:10 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d194-20020a3768cb0000b02903ad9d001bb6so11155754qkc.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=RjNwWinwfj6k9bMCNF+JWBOzX6tUUNQTK3VaObOvyqk=;
        b=SbJIzXsL2Qae8gaThEVjEtdgE0819Afotcf5+vnoLkybic8Wa4QU0HCMWGlsEVXvRI
         im4B3pzb0BSzx21vFl/BpKvYWdkyD5sLx9Bulm+WsFsNX2eN3TwWn/PyWD8R4NwjkG28
         WTnHRI1im20vKgo8DnsuE9GhjzaVkSdt30TRvUOgXCEoMrF5q58fAFF0KTFl6168J5gF
         ML82QAFrjD1D3qiS7pyYTLL5NkY/kQWP645iWMxaS4HHWFyH2zMRps2gLaEDmq/oN9k4
         H8cDXYzc+3InkWxHsLrhtrZtpycu7EyFuUZJdPucfPHp6jCz+la923nWX1JMMQt+ceSn
         LrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=RjNwWinwfj6k9bMCNF+JWBOzX6tUUNQTK3VaObOvyqk=;
        b=KS/UvYyLJYcnZMtlxq8oXtRvRetP/Vbgo4DSVvNGJ1noYbGsyra3wZkp1qEBZd4VRL
         BVhpNNENsd2nSQP+R0XJ58elMYYA861umeOPAT86GZjNADNA7bC/7taMs7FHzhAQTiLM
         a7PsrdK4g32pUVGxJACNobuGrsn90i1kcL+5qh80gFH/BCl0IPFmdpHr2BwDh70ZHJ63
         Fz/eL/nFu9TKHp7QbHao7+hMogLy6r5XKgGQxEeyR4rvuBIiLlI05fI+vLdb8oFLJzms
         qUf6lT6uDzzp+uR65F6hzmIgD6iZ/2+ONeix3m1n37+nvrJXC72rM/psNvGMMwLkZD1A
         kPrg==
X-Gm-Message-State: AOAM5326UlrDvG4RyVwyH7Padnzx0HOo82z1cFbONmqDZehQXMJMIVPz
        vVeWa6QxHgJtIPOJtSXVsRSc5itJ
X-Google-Smtp-Source: ABdhPJwAZTZRu3ktdb3CHDeo4mcCBVKC3Rle6+fa1N14X7pvnl6KsXm10oehKcMx4psUujyzgPpmaMCT
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:a103:5a93:dc7c:f704])
 (user=posk job=sendgmr) by 2002:ad4:54ec:: with SMTP id k12mr13541313qvx.44.1624661350081;
 Fri, 25 Jun 2021 15:49:10 -0700 (PDT)
Date:   Fri, 25 Jun 2021 15:49:02 -0700
Message-Id: <20210625224902.1222942-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] kselftest/kselftest_harness.h: do not redefine ARRAY_SIZE
From:   Peter Oskolkov <posk@google.com>
To:     Peter Oskolkov <posk@google.com>, Peter Oskolkov <posk@posk.io>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Macro ARRAY_SIZE is defined in tools/include/linux/kernel.h, so
if both headers are included there is a warning.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ae0f0f33b2a6..75164e23f036 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -671,7 +671,9 @@
 #define EXPECT_STRNE(expected, seen) \
 	__EXPECT_STR(expected, seen, !=, 0)
 
+#ifndef ARRAY_SIZE
 #define ARRAY_SIZE(a)	(sizeof(a) / sizeof(a[0]))
+#endif
 
 /* Support an optional handler after and ASSERT_* or EXPECT_*.  The approach is
  * not thread-safe, but it should be fine in most sane test scenarios.
-- 
2.32.0.93.g670b81a890-goog

