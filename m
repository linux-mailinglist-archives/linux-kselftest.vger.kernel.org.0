Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1339B38D3BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 May 2021 06:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhEVEoe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 May 2021 00:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhEVEod (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 May 2021 00:44:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C7C0613ED
        for <linux-kselftest@vger.kernel.org>; Fri, 21 May 2021 21:43:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b66-20020a25cb450000b02905076ea039f1so29258244ybg.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 May 2021 21:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FnOGMJtD7cbEyy2Hy6sns1JCmndfXO6yiUDfaAjqzB0=;
        b=ADkfaLwLMeQPABqX2ozJZ9PjZEXzbps2XxGnipqgoThErDT4mSQdF2Y7dK8ZGQKOOP
         UxGdojTeD+ApoU/qddgk1qp9sNlJ2Pf381yXrmS5xX8EjiGk3mLcLHVQFdp9YzqbnhdC
         zHJpBmo3t7QW4gaM4rlplznC4dL3d6gDFCcJ7Mm7qtoZt+TYZxSq8ofqxXA0TioAUH1Z
         dBCe/6N10nODNBeOeygM2WozT5ho9N2z11MmZ56g8wdJDXh+Nlc4A3AZE90M0YH216FD
         nPu/oNWJVieOUjg0xr9lG/diEfSohbrx5Cuv7CF69eHDoO3EwvI2XgtByoDXFCogx5Qg
         Lesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FnOGMJtD7cbEyy2Hy6sns1JCmndfXO6yiUDfaAjqzB0=;
        b=uQEBIwrYjIzYTkWPf22DGvWXR6jbkv6Fh5lC4WBMGBsocQx0QCy8P8G1xlJ26chn/7
         LjLgf+wgVi8ULCdPvTM9aO7Z/MhdtM5N8DG60RUuSPZzljt/cycmU6q9tb7N5KBcjpvn
         wKwUjarkQRy6JYnI0KBdu/YDTtbDScVJKNHRcxRFry03+0PdznyHf6wiMwXh99/QgqCQ
         Q2y2vC/IsnO+ssWh0yzQ8ekCDvQmetY/sAvHhWEHfUBbBBwnz+R+C7ewKCPZF1EPBF0h
         bGyXi+Ag3ZJJokSYzmqAYBHw06LN7GSx8beipBPEXn4fBZOKIQuFz8frJyhbJWzXgiw6
         C+PA==
X-Gm-Message-State: AOAM530ezS4AAMcS4cx8j7Y3ry53S76WDhk3J406orQPSJenK75clhsP
        QyoPt1BfyvurqOUoWHg0cJdAVKFxJmp8JA==
X-Google-Smtp-Source: ABdhPJzAkjOSmFaPqRL3IZnEfCtLjZzs3AQwT9S9n4+22xgVOSZ1s/nU9+bDyEuHewd2lUfMvZ/oNLN+g7GDcA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:74c:35f3:92d:b18a])
 (user=davidgow job=sendgmr) by 2002:a25:a345:: with SMTP id
 d63mr20237748ybi.169.1621658587180; Fri, 21 May 2021 21:43:07 -0700 (PDT)
Date:   Fri, 21 May 2021 21:42:41 -0700
In-Reply-To: <20210522044241.2763088-1-davidgow@google.com>
Message-Id: <20210522044241.2763088-3-davidgow@google.com>
Mime-Version: 1.0
References: <20210522044241.2763088-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 3/3] kunit: Remove the unused all_tests.config
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This isn't used anywhere. While it's possible that people were manually
referencing it, the new default config (in default.config in the same
path) provides equivalent functionality.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/configs/all_tests.config | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 tools/testing/kunit/configs/all_tests.config

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
deleted file mode 100644
index 9235b7d42d38..000000000000
--- a/tools/testing/kunit/configs/all_tests.config
+++ /dev/null
@@ -1,3 +0,0 @@
-CONFIG_KUNIT=y
-CONFIG_KUNIT_TEST=y
-CONFIG_KUNIT_EXAMPLE_TEST=y
-- 
2.31.1.818.g46aad6cb9e-goog

