Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DDB203EEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgFVSQ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbgFVSQ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 14:16:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E69C061796
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:16:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so225433pjv.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2RF8RVlRnCLma1Xfs0ItaeBI3BCVxTttYSsNpc+cjI=;
        b=m90MFVwm5Ao23/OHfI7WfuAUZDbHXtdJwtZGo0WLtQJfdogDyPPXxPsRg0N+7mK5ME
         O8qr/EjbVMV1s76/2RDV3e/+v2U8ejTXkeufdsF7MlriaTq+1JdCPZpSkodW3t8GIU/f
         G/9qnTywIMu2bjuBdFS1cUoqdDxAFKgAKXw6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2RF8RVlRnCLma1Xfs0ItaeBI3BCVxTttYSsNpc+cjI=;
        b=CkhwDk5GB02i9So7c5b048yFItTWRrAyuzCG2T/35qq74BbFVs5eb3Vpv5RVA0vp6Q
         3BVBN+lZBGWu/uoiYY5stp3W5rOfom6qeIt0n6fGhCjXzspNk6vScodYodIryv2t8N0j
         UrfL1oey7dhN7ok7wo2t9LDANiNI0l8FW0/GsovUB0+K8sDT5jqSC7mpdAa5tgdgY3XQ
         qbZ/TNuJNDWNuurY79TjoEyl2LeDl2iDUMgOazuYJ7Fg5pzaAy8edyXkmdhgk7pxQ57h
         XQcJkIYzaomucT+kL3YVIl7A1bNGNC2wM8pSA/Fmjxs8GtTEp9v/y4lXfeJjFOALhRTH
         Rrkg==
X-Gm-Message-State: AOAM533BC1nzgNxSFGc/Tew4JUptst6zzgqrsDLxNoSV8EzvzK+OqLFm
        yc4BSOBSQ4t+3vfWP6bmZheUAQ==
X-Google-Smtp-Source: ABdhPJy/4sdb/Y+o7bNq2dNOksQYYqfwSchKM4ufwozQ3ghVuQPFgOvV2TREIx2BWMxxtCQYSnCdUQ==
X-Received: by 2002:a17:90a:e387:: with SMTP id b7mr20338705pjz.176.1592849816322;
        Mon, 22 Jun 2020 11:16:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v8sm14145912pfn.217.2020.06.22.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] selftests: Remove unneeded selftest API headers
Date:   Mon, 22 Jun 2020 11:16:45 -0700
Message-Id: <20200622181651.2795217-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove unused includes of the kselftest.h header.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/pid_namespace/regression_enomem.c | 1 -
 tools/testing/selftests/pidfd/pidfd_getfd_test.c          | 1 -
 tools/testing/selftests/pidfd/pidfd_setns_test.c          | 1 -
 tools/testing/selftests/uevent/uevent_filtering.c         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 73d532556d17..7d84097ad45c 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -11,7 +11,6 @@
 #include <syscall.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 #include "../pidfd/pidfd.h"
 
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 401a7c1d0312..eecbf18510fd 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -18,7 +18,6 @@
 #include <linux/kcmp.h>
 
 #include "pidfd.h"
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 /*
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 133ec5b6cda8..f66861cf9c4d 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -20,7 +20,6 @@
 
 #include "pidfd.h"
 #include "../clone3/clone3_selftests.h"
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 enum {
diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index f83391aa42cf..5cebfb356345 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -19,7 +19,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 #define __DEV_FULL "/sys/devices/virtual/mem/full/uevent"
-- 
2.25.1

