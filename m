Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26C376BD0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 23:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEGVcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhEGVcj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 17:32:39 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E8C061343
        for <linux-kselftest@vger.kernel.org>; Fri,  7 May 2021 14:31:38 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v1-20020a05620a1221b02902ea88445e01so4041671qkj.9
        for <linux-kselftest@vger.kernel.org>; Fri, 07 May 2021 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OULdAB7SkAEJ6rQEHGBEyfNQUuilr1kpehp6Rww8NCA=;
        b=me5mS3gfsyZF7xaGkikl8wftRuuZ2OGeAKpzgUbMG/qsFra0W0N8S1KODa6Y6brGSh
         WNnA7TmrDbCabXXI8LZ5E41NAN5pNRNwDSUZcEdq9LoeDSlPWHxFqM8DDjmyngwqFJeb
         Qd/LsL1B+87lenOTJVGd3dIFeR0hJAb6m7yKHz6Ff7KNudGql7/B2VGuog25apXTCqnk
         701ebfMb4CuF1CVSuYBrBOpouUpboiIkW/Fa+1bvRVzIg/Yjla8YBFB+UgXkVowK+lcK
         uST+GIeh4l9btt3gkyCzCyIkikPepD0zoahHPGO1sj2aTXavSt3B/+TB7zhSWhIRlPsO
         +bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OULdAB7SkAEJ6rQEHGBEyfNQUuilr1kpehp6Rww8NCA=;
        b=OwrMabYTuExGXdWYxZ3oU0gDpFm4K5J8oD1F/fpNG/JssUqckA0n/mJEWmqXtS7Er9
         zwTEzhh6CysBBpwLNo4D70Tqthq8Jz3RG9rUJmIgw6E/pJZpexoG1YDplFDFotZSu5OT
         PKHwyVuRRXiARpswZOk54QcCzdSld3LPHYREgDjvmDzaCGIXeA6c7C5wOF+AJYSZ6qFe
         X2ysx4ztcXMTQFZ1bUfPHo2KjrK0sIut1UD246Dae481Z8WMsTSDtsn6xDNk+PdtkptT
         URKVENyG4fzQtrpLEDB5WXPWSQJ99/khjkmQk7HAYxkaj8U/VKX1zCw4qaPigOhc9xlv
         yk1w==
X-Gm-Message-State: AOAM530Ni2a8Oh8ZwIBPTA4nszbZF1OeDzMMy14hUWMF5LYo4Re5AGxN
        xvNYPvyTCkRojiAiYgH8dlPTMj5XR2gyvBzBvqozZA==
X-Google-Smtp-Source: ABdhPJwd63PkgSe6ku7lXnqxyN58PmTRRyHarAj8aC3AIuHh7xaK+l2IwwFYYBvTOCikWgPsZmwm0YSUR1eyHN7JtT9K1Q==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:8b7:10d:a11b:ba0c])
 (user=brendanhiggins job=sendgmr) by 2002:a0c:e54c:: with SMTP id
 n12mr11957692qvm.25.1620423097425; Fri, 07 May 2021 14:31:37 -0700 (PDT)
Date:   Fri,  7 May 2021 14:31:10 -0700
In-Reply-To: <20210507213110.155492-1-brendanhiggins@google.com>
Message-Id: <20210507213110.155492-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v1 4/4] Documentation: kunit: document support for QEMU in kunit_tool
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

Document QEMU support, what it does, and how to use it in kunit_tool.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 37 +++++++++++++++++++++----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 650f99590df57..b74bd7c87cc20 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -612,14 +612,39 @@ only things to be aware of when doing so.
 The biggest impediment will likely be that certain KUnit features and
 infrastructure may not support your target environment. For example, at this
 time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
-of UML. Unfortunately, there is no way around this. Using UML (or even just a
-particular architecture) allows us to make a lot of assumptions that make it
-possible to do things which might otherwise be impossible.
+of UML and QEMU. Unfortunately, there is no way around this. Using UML and QEMU
+(or even just a particular architecture) allows us to make a lot of assumptions
+that make it possible to do things which might otherwise be impossible.
 
 Nevertheless, all core KUnit framework features are fully supported on all
-architectures, and using them is straightforward: all you need to do is to take
-your kunitconfig, your Kconfig options for the tests you would like to run, and
-merge them into whatever config your are using for your platform. That's it!
+architectures, and using them is straightforward: Most popular architectures
+are supported directly in the KUnit Wrapper via QEMU.  Currently, supported
+architectures on QEMU include:
+
+*   i386
+*   x86_64
+*   arm
+*   arm64
+*   alpha
+*   powerpc
+*   riscv
+*   s390
+*   sparc
+
+In order to run KUnit tests on one of these architectures via QEMU with the
+KUnit wrapper, all you need to do is specify the flags ``--arch`` and
+``--cross_compile`` when invoking the KUnit Wrapper. For example, we could run
+the default KUnit tests on ARM in the following manner (assuming we have an ARM
+toolchain installed):
+
+.. code-block:: bash
+
+	tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --arch=arm --cross_compile=arm-linux-gnueabihf-
+
+Alternatively, if you want to run your tests on real hardware or in some other
+emulation environment, all you need to do is to take your kunitconfig, your
+Kconfig options for the tests you would like to run, and merge them into
+whatever config your are using for your platform. That's it!
 
 For example, let's say you have the following kunitconfig:
 
-- 
2.31.1.607.g51e8a6a459-goog

