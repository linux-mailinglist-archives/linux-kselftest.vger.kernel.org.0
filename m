Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED3616B66
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 19:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKBSCs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 14:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKBSCl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 14:02:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343421278
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 11:02:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so16853724ybr.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAYN6r+yTQvu28IFOFbzBkKteLNKvCbZnYXbZl6k2DY=;
        b=FrgvbWPhRA4VD87zdgqKKiY5UHCDYtYfe7CjaP2xgmEOG1Y05NjZSf3gzQWW8T0Uct
         kwK/a9hcGw0YEYKVOJVFR5P9iNYw89sCx6ZHsJggC73BExIAmjho5Pbue4CgNBI3QOgO
         FoPe42kXbj+qL8yjM5/fdOTg+3rYiSOtiXyjG+vM72l5OUaB8j+A2cgCkgbbQKnrcMOV
         vjVP5OOJMItX52jvTtAXnPZObQ6EUQSPLAa0t1h0Rw23k0Jw4oAggVMoBX89jk82PyRN
         zVVthy9iTThict8/JGXYxe/C830qJ3olt0/g7iLirWIKcLukRfjGALBtlSWm2uBgHMk7
         3wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAYN6r+yTQvu28IFOFbzBkKteLNKvCbZnYXbZl6k2DY=;
        b=q9gc6GPz36ytAXYKt3DecKsxby8L3hTtBN0uv/sZ5eDE6+ayCaThQ32ZLpAihWjwME
         z3uYunEXc4batZHlBYKA64Mvgxsbm0HjNpdHqIo/1WcG0KVPKPsjONWbld5vo7jTTiaW
         wEfrV8XDQg2dQr+MMjkkAz9uHytvnbGvHN7YthsSwBoq+npFJWHDeDENUAufvej5/z2D
         5IcgHo8re8vKaTUoJ8RpBLMitnXx3gWAtm5ylI3jFQYImQGfu5Wy7HPuHzC/LQtWKwWp
         Un4Eg/9Vde8p17xpm/g77OJpKpqv17dUSUC44xKjgjsvwrldEiIVhw3aWh/WbEp/b1Fl
         jGnw==
X-Gm-Message-State: ACrzQf01Z/d8WBs2Fx0Oq22IIMD2yljZXtaWztI3BwA2TyAHEEeJmPha
        K6Woz/DWenD4sZUOEM0uXFM1VHzmmQ==
X-Google-Smtp-Source: AMsMyM64HlkRFhAbArKDmM55aNm5YRW0BBSHLMBYENZZs5lf+VgK/ijoO38lHLz2MMzG8f46iR30Y68UQQ==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a05:6902:1247:b0:6ca:88e8:6f43 with SMTP id
 t7-20020a056902124700b006ca88e86f43mr24295801ybu.289.1667412159822; Wed, 02
 Nov 2022 11:02:39 -0700 (PDT)
Date:   Wed,  2 Nov 2022 17:59:58 +0000
In-Reply-To: <20221102175959.2921063-1-rmoar@google.com>
Mime-Version: 1.0
References: <20221102175959.2921063-1-rmoar@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102175959.2921063-2-rmoar@google.com>
Subject: [PATCH v1 1/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        john.johansen@canonical.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create two macros:

VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change
to the symbol definition.

EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is enabled. Must
use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING) in test file in order to
use symbols.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/kunit/visibility.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/kunit/visibility.h

diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
new file mode 100644
index 000000000000..eb22c9e6b4eb
--- /dev/null
+++ b/include/kunit/visibility.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit API to allow symbols to be conditionally visible during KUnit
+ * testing
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_VISIBILITY_H
+#define _KUNIT_VISIBILITY_H
+
+/**
+ * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
+ * is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change
+ * to the symbol definition.
+ *
+ * EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
+ * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
+ * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
+ * in test file in order to use symbols.
+ */
+#if IS_ENABLED(CONFIG_KUNIT)
+    #define VISIBLE_IF_KUNIT
+    #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
+	    EXPORTED_FOR_KUNIT_TESTING)
+#else
+    #define VISIBLE_IF_KUNIT static
+    #define EXPORT_SYMBOL_IF_KUNIT(symbol)
+#endif
+
+#endif /* _KUNIT_VISIBILITY_H */
-- 
2.38.1.273.g43a17bfeac-goog

