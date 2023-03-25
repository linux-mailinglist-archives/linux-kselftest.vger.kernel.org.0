Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07C26C8ADE
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 05:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCYEbm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 00:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCYEbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 00:31:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715F1ABD7
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 21:31:24 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nm11-20020a17090b19cb00b0023d0c90d851so1019038pjb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 21:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679718684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GFTGuce/jasIOoxgBhcBDFvlf80kZtNsVdpwus1c0o=;
        b=jPiK9bzw/LfWhk/EqotDJX72pjO1JKd1BwuwlbjMi9aYrXP1DPcn8Nt4cOwDHXs9jh
         ij4e2UNXRWtJoZtf2Z94vobgXgG4FvRXLAmxm91yhbdBFPkqrIsk0c2QmZjI9UWAQCSg
         f4cKmyY38G7Q9bQw598jxVJkV0K3c/r2Vi+GxwcNR241OJLr0VBRpsyYJ15SmiZj4UAF
         D3Nx5ZoSqHRxu60/MVPookyisHGGOXNKKMYjYZ9kM5A2jAaNIpmlMY1fD7eRgXTi8KSB
         NEeXv3z1mPoeQVEWMgiyr4eDInIdZECHHG4Dmo/ttWv/PoymoNUwLRgzIq9uGIbcfl+A
         oK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GFTGuce/jasIOoxgBhcBDFvlf80kZtNsVdpwus1c0o=;
        b=7LL/6jvjOor3eHyRagWScYw3+oStY5slzHRWmmk/z6F6GSA8uRcl/Jz9M24mbL5LO7
         qddvOcppTdZATG3pUF47UZS/c5hbO9ZUnboNdeDtpVS/0zf2RJvb9YWN6iZgjxLra/q2
         5SPSnqBoMw5R4lBWBnUbGjGhaznaiwh+Sg1rltFzjN38IQNkUDsRPZhLO31bVYQBx9Uy
         xD/qR6xzy/PKxPmx0XRXUEmlYWTFCFbpN5/AcQrkXnLYIiMsKDNjfseJKkezqPwYCAz4
         trsZAjZB09hQA7KFD6ZvWlNY0CGwLSjsgd/zn0UTnGFV31MysvksiNa8ArtynSC4TGHN
         jDlw==
X-Gm-Message-State: AO0yUKXx1LjSIiZ3wrgCEQo7bLwB20MKMGQT35iDsKNvlyyL0fkymNc8
        gxs/whE/yHwOxabRrXQDQhbamwqbZWTlQg==
X-Google-Smtp-Source: AK7set/eA25yEQztgVWNsBWE4ael/iyts9um9spxPVS5KzosXah9xcxZqDHvH6pHUe+DNTg6pSiQEEMUh6sQRg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:4510:b0:626:1710:9b7d with SMTP
 id cw16-20020a056a00451000b0062617109b7dmr5135789pfb.0.1679718684393; Fri, 24
 Mar 2023 21:31:24 -0700 (PDT)
Date:   Sat, 25 Mar 2023 12:31:04 +0800
In-Reply-To: <20230325043104.3761770-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230325043104.3761770-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230325043104.3761770-3-davidgow@google.com>
Subject: [RFC PATCH 2/2] kunit: Add APIs for managing devices
From:   David Gow <davidgow@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests for drivers often require a struct device to pass to other
functions. While it's possible to create these with
root_device_register(), or to use something like a platform device, this
is both a misuse of those APIs, and can be difficult to clean up after,
for example, a failed assertion.

Add two KUnit-specific functions for registering and unregistering a
struct device:
- kunit_device_register()
- kunit_device_unregister()

These behave similarly to root_device_register() and
root_device_unregister() except:
- They take a struct kunit pointer with a test context.
- They do not create a root device directory in sysfs.
- The device will automatically be unregistered when the test exits
  (unless it has already been unregistered using
  kunit_device_unregister())
- The device name is set to <test-name>.<device-name>.

This API can be extended in the future to, for example, add these
devices to a KUnit bus as tests begin to require that functionality.

Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/device.h | 25 ++++++++++++++++
 lib/kunit/Makefile     |  1 +
 lib/kunit/device.c     | 68 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 include/kunit/device.h
 create mode 100644 lib/kunit/device.c

diff --git a/include/kunit/device.h b/include/kunit/device.h
new file mode 100644
index 000000000000..19a35b5e4e59
--- /dev/null
+++ b/include/kunit/device.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit basic device implementation
+ *
+ * Implementation of struct kunit_device helpers.
+ *
+ * Copyright (C) 2023, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#ifndef _KUNIT_DEVICE_H
+#define _KUNIT_DEVICE_H
+
+#if IS_ENABLED(CONFIG_KUNIT)
+
+#include <kunit/test.h>
+
+struct kunit_device;
+
+struct device *kunit_device_register(struct kunit *test, const char *name);
+void kunit_device_unregister(struct kunit *test, struct device *dev);
+
+#endif
+
+#endif
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index cb417f504996..b9bd059269ed 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -6,6 +6,7 @@ kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o \
+					device.o \
 					executor.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
diff --git a/lib/kunit/device.c b/lib/kunit/device.c
new file mode 100644
index 000000000000..ce87b7c40d9b
--- /dev/null
+++ b/lib/kunit/device.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit basic device implementation
+ *
+ * Implementation of struct kunit_device helpers.
+ *
+ * Copyright (C) 2023, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#include <linux/device.h>
+
+#include <kunit/test.h>
+#include <kunit/resource.h>
+
+/* A device owned by a KUnit test. */
+struct kunit_device {
+	struct device dev;
+	struct kunit *owner;
+};
+
+static inline struct kunit_device *to_kunit_device(struct device *d)
+{
+	return container_of(d, struct kunit_device, dev);
+}
+
+static void kunit_device_release(struct device *d)
+{
+	kfree(to_kunit_device(d));
+}
+
+struct device *kunit_device_register(struct kunit *test, const char *name)
+{
+	struct kunit_device *kunit_dev;
+	int err = -ENOMEM;
+
+	kunit_dev = kzalloc(sizeof(struct kunit_device), GFP_KERNEL);
+	if (!kunit_dev)
+		return ERR_PTR(err);
+
+	kunit_dev->owner = test;
+
+	err = dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
+	if (err) {
+		kfree(kunit_dev);
+		return ERR_PTR(err);
+	}
+
+	kunit_dev->dev.release = kunit_device_release;
+
+	err = device_register(&kunit_dev->dev);
+	if (err) {
+		put_device(&kunit_dev->dev);
+		return ERR_PTR(err);
+	}
+
+	kunit_defer(test, (kunit_defer_function_t)device_unregister, &kunit_dev->dev, GFP_KERNEL);
+
+	return &kunit_dev->dev;
+}
+EXPORT_SYMBOL_GPL(kunit_device_register);
+
+void kunit_device_unregister(struct kunit *test, struct device *dev)
+{
+	kunit_defer_trigger(test, (kunit_defer_function_t)device_unregister, dev);
+}
+EXPORT_SYMBOL_GPL(kunit_device_unregister);
+
-- 
2.40.0.348.gf938b09366-goog

