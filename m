Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78D6643763
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 22:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiLEVwv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 16:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiLEVw0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 16:52:26 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311C913F96
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 13:51:12 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-348608c1cd3so136244797b3.10
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 13:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHaN/rxrdTlLNmHkIlcPiYJ+TDwo4KCFt7QuQtzqTRE=;
        b=ezbkPVk+gANDmDB3slX0LIDT+GXoGI4xG2jnCJZjxEIny0W/0FWw78vciEzyI7Ukj7
         RgSvvofXwpCVf2yARjRAT0576DboGtRN++XwON3MSO3eJyh2UCMFvEa++LYG7ErrzqO2
         C7f/wQsM5J3hXxmTTmc6B59reRG4wQqsC5bIuhPjgSs8h6zUZLTGtGQbZ/Xj/CmMm9Zh
         MYlG6+TnpqZknQxmbPLInZ/T1iDqcgFbIDGSl24zuHvhlIaw+D5OIy3lavnzA2+9ydFE
         QnJSImLeC199vLikRq0kVXpiNB+yoZuPobJ7kvcXcuBSIpZ1UnuoOZdNoIYf3Eg+ZSDa
         mdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHaN/rxrdTlLNmHkIlcPiYJ+TDwo4KCFt7QuQtzqTRE=;
        b=AgNv80eWw04AYI1F0p5reM6+oBgw0bS9v/8NHgL8Uxyz7xR9E4qGQqG4B2mCqeM23u
         /fVBAU9H44oMMQwAwXCket63VC816+52yaquTKogJrsvXDtuYGt+Wmx43TdtZKNkF7AS
         PN2UNrVNPYmSVsVtJwlO1LVEtcobhP5NdDMm2+SgF+6iJIzytIwE1vJX6bCIcHhqXlW4
         Ff3loE15gLf8N+vSoO4pzgFXZV8gFBG86oxHmK3HaoktjUERyl+dtREprNDLis3fN5E6
         knpWf7mfRySfjvVOtFULREz9aaRZNzuxeyrBBFUY5MCyeiqh32gwY/pdysb0jxqKCAkC
         ZF2w==
X-Gm-Message-State: ANoB5pn+1AYir5MPGuFYvJa5gMLavJBv6sCvwSARdAuRHbIdfY4G6uvV
        U6DF+ksMKop7BIbpSggKmwJdOco9UQ==
X-Google-Smtp-Source: AA0mqf6lvqWkEuvZgqLHmk5rJjpI3nI+CfBPBXL+rv479JHG6NqzXP82xrmhXOZP4uwHFTAxRMlOZaGtmQ==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a81:598b:0:b0:3b7:78c8:a205 with SMTP id
 n133-20020a81598b000000b003b778c8a205mr49937654ywb.188.1670277071514; Mon, 05
 Dec 2022 13:51:11 -0800 (PST)
Date:   Mon,  5 Dec 2022 21:50:57 +0000
In-Reply-To: <20221205215058.143688-1-rmoar@google.com>
Mime-Version: 1.0
References: <20221205215058.143688-1-rmoar@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205215058.143688-2-rmoar@google.com>
Subject: [PATCH v2 1/2] kunit: add macro to allow conditionally exposing
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

