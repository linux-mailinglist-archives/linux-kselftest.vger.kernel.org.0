Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58774645151
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 02:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLGBlG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 20:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLGBlE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 20:41:04 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECF27CDD
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 17:41:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3b0af5bcbd3so172700927b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 17:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2Av2mFA0WtwRQfRDDp1AcFtZ65WBT5TfOYBGjpZc8U=;
        b=ZSeF6gIU33eO2yCx/RBxl96g1hXO/NUYpPapQeVcTwE4Vg0/fBOlVSrYS97e5ecEHO
         XNPpGZncy+/Gh7h+b4LSvjIumlhokHRE09Pwo7LwQKIekr8yixl8QCQ0KIukFe02w2wT
         comOtXMfhFDFAUoy5ivekITX41zI6WVG8czk1z8lYcycv6IVhBJdmK46mlZx35jcXgGF
         52pVZ8bzYLziNsMyUyQuMCEgz7XPjBlw0nbxY2WuQhHIoAgQn08onIVu02uiAZ094hGO
         rj7k4ucJcfb9tH6AEsJFJuADrgzDJeFRHEC1Ct11VgyQJ5N4T7/YnDQOTYD7sdUrRawe
         sCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2Av2mFA0WtwRQfRDDp1AcFtZ65WBT5TfOYBGjpZc8U=;
        b=76SgUrHYuat+zdbMuwWWZpZG8/cUPdvh5FWPqygwtIS5JAfOBNGMdh56tZUGcd8dGP
         BGTLAX+WRu74298cmwyecYMaSRnguR7OUSgaZBoIAgTIavaTqwMvb7jVLAq02BaY6vWY
         oARZT29XL+jQGh4vgb2GdhTrjDYDQRIp5pL55DoXHIRARD5OnFPAENh4qXHYs/XexKs1
         U38JFEWdBjUiVj1+mP+JWVcy5zlDEwXNfKfJV7kbB9pY+ReviO85XQ6cAGEg2qtNGI7h
         G/P5vmiKZ/6XnrXryhv9t7AzR7AzVRMm5lY6qKaNbWqQMOeNUUU96rQOTkQ8EyDXvZWE
         4fCQ==
X-Gm-Message-State: ANoB5pkKeLtdmEYrq/tnryXGm0M2GhhbSUsoEAFeeKEPhTn+1yS71dIG
        iKDtRM5yaiUiYpuIxtCzbyGo9jXXrA==
X-Google-Smtp-Source: AA0mqf75lqEvLvU57b4+1woivfdGDV7Rrauznoz21g86JMzcwRQz2dnJ6LFhFHKTp7RgXkDvBHH/e74eaQ==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a81:a1ce:0:b0:3bc:16af:8ded with SMTP id
 y197-20020a81a1ce000000b003bc16af8dedmr50465406ywg.176.1670377263945; Tue, 06
 Dec 2022 17:41:03 -0800 (PST)
Date:   Wed,  7 Dec 2022 01:40:23 +0000
In-Reply-To: <20221207014024.340230-1-rmoar@google.com>
Mime-Version: 1.0
References: <20221207014024.340230-1-rmoar@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207014024.340230-2-rmoar@google.com>
Subject: [PATCH v3 1/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, john.johansen@canonical.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, apparmor@lists.ubuntu.com,
        Rae Moar <rmoar@google.com>
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
is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change to
the symbol definition.

EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is enabled. Must
use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING) in test file in order to
use symbols.

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes since v2:
 - No changes to this patch.

Changes since v1:
 - Separated the documentation comments for macros.
 - Changed copyright date and author for new header file.

 include/kunit/visibility.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 include/kunit/visibility.h

diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
new file mode 100644
index 000000000000..0dfe35feeec6
--- /dev/null
+++ b/include/kunit/visibility.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit API to allow symbols to be conditionally visible during KUnit
+ * testing
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: Rae Moar <rmoar@google.com>
+ */
+
+#ifndef _KUNIT_VISIBILITY_H
+#define _KUNIT_VISIBILITY_H
+
+#if IS_ENABLED(CONFIG_KUNIT)
+    /**
+     * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
+     * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
+     * there is no change to the symbol definition.
+     */
+    #define VISIBLE_IF_KUNIT
+    /**
+     * EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
+     * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
+     * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
+     * in test file in order to use symbols.
+     */
+    #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
+	    EXPORTED_FOR_KUNIT_TESTING)
+#else
+    #define VISIBLE_IF_KUNIT static
+    #define EXPORT_SYMBOL_IF_KUNIT(symbol)
+#endif
+
+#endif /* _KUNIT_VISIBILITY_H */
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

