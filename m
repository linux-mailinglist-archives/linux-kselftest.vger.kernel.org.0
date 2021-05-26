Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25BA3921F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhEZVZw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhEZVZv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 17:25:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D15C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 14:24:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so3219589ybo.11
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+MABw3mk6SDmog98V7M1cVD+iqYLPOe0caTHFqlTqzM=;
        b=JRzF0HJaNEuDYUyhRH3agZv2u0Ntn1Qr3prXMKDAHhx9lHyYto06ZBcggqFfUy8C38
         uozr2YzjAUAdGNIhawuv6J3pCLTXiobX/yrUqeR3KWfl/bd7A3/5dY2GUPpKc9qNHDPG
         V+GfOpk6dr/73/Y8uJFfw9/BllJrEqaNzIKHUYiGoSTiVWKEwN2NwWTrgHmw0mEXzXrM
         sRQziDFTTRuo7jJlmB10NUGQjJhXmmx6bHI2i3K6mryZMG33wBGA1OVcMaKKJEqEECWZ
         TLkw9mqmTPgqaszFEB6twbmgMKdh+7rXfG+nLF55vHAk6zqMF8LGzrEq+23kC/p32Mcw
         v0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+MABw3mk6SDmog98V7M1cVD+iqYLPOe0caTHFqlTqzM=;
        b=SnUmkRdFoEhmA6B7yuxf9nKWUBpdSv9DdnD+g4o9je4Vb1vPm3401iR93p0kYBTQZy
         Gc1ayamyxksUEyRQNvHkx+UWH6Q52RhJGuNqaCSb0KRL7bORYJFGBu7A+fCgXw0FLbIB
         3J/DJ1O1lBGGFj6zxrimq2ovp2iBCOeY0Ay2Uwmae9Pnxm10JnK4agEqNi2bKRNsxHVt
         5U/XeR8qw+HMPNnyVwThV43QTrc5wb8hlgZBJjwzlSGMGQQm+dqikPCCbxzbUVrJam4w
         wrCoLzC7e2SL+T+tsaDm4qwU73DVQuZQd2/oSPtNYYZfocDLxbNhKT0coitRWbJksTOZ
         YgLQ==
X-Gm-Message-State: AOAM533dgcObzn/UGartuh6C7UHjQs/y6KafYlF/yNFvXcQTozH+QqkM
        kBX5aL7C/Uli9fPlsmnwN+Gd6lf+tgPRHT6V/BDhlw==
X-Google-Smtp-Source: ABdhPJzOZTeIlOrb0MDScNCCSZQ2m5YAyXW4/oOh83LwqnfngvwDw1k3N/oz+WNIQYVb5so32/+A1M63dcRUUZLLIM0+jA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:2a22:5aa3:3643:4ddb])
 (user=brendanhiggins job=sendgmr) by 2002:a25:6ec1:: with SMTP id
 j184mr77386ybc.126.1622064257601; Wed, 26 May 2021 14:24:17 -0700 (PDT)
Date:   Wed, 26 May 2021 14:24:05 -0700
In-Reply-To: <20210526212407.2753879-1-brendanhiggins@google.com>
Message-Id: <20210526212407.2753879-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210526212407.2753879-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 2/4] Documentation: Add kunit_shutdown to kernel-parameters.txt
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, sboyd@kernel.org, keescook@chromium.org,
        frowand.list@gmail.com, dlatypov@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc463..78c22bd55b92e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2256,6 +2256,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown=[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running built-in tests. Tests configured as modules will
+			not be run.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.31.1.818.g46aad6cb9e-goog

