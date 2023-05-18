Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA83707C3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjERIjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 04:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjERIjS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 04:39:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0332724
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 01:39:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561120ed06fso36482287b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684399148; x=1686991148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktXlgtWlyfQZQ1d8uj3tU7I14o2usUDk+fQoHXPWmDU=;
        b=VgXvSLQJQOhsSG6UOczEvxUlPM2ur85ri/n2c3BM88UVbcvRwtybZUbqHQhPphTTJS
         qEWKuFqmBczy64nT6g8RK9M0ViMel6Cy7xisxqBJxPUigBtu6vz6jkTH0+jiaz9nm4b4
         6TFHJYWdYV+NZpu4BoGQPTt3tN5hUpqsm7tVYb7IeAIRVtgwF04QFOM5GjQiJHVbW8Tc
         eTclL8ikuZG/7d29UbQkFQ12xoBavLfUfepLs9eBVPOhRNUoXKAs20vs//yM+L4MgSkl
         zdkQaUk8jDtbrHgUZ5Fa3ZQFkZ/vy76GsD+pudEZUIKjppI9j5mPWYRwKR0AwhyXPU7q
         UYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399148; x=1686991148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktXlgtWlyfQZQ1d8uj3tU7I14o2usUDk+fQoHXPWmDU=;
        b=CtmSU5u3MzWEdxUoEMdtbLwtrdJVnlPq8JV4mF/hfemn8NtpiCEMlyk0KmCo+TlFgc
         o104ZSsEFeYOJh3u9qTd5OCI8DVup5vOnj6BAFG1xDXZ+V/MDHxu3ghOEOcDAKWjy3Be
         8o3l3tWPFKNx1VJAcplqtVrgiDUEqd4hcyFWLC566rTZlDKnu/WKZSroQSEbkpKYoZeQ
         fYGBqJqRIw8dvfhK7D8JyVZ28YCxZxzNKeMFlAN/tRKhSdGW3lXXzn2DgnFoH9C2hSAL
         owzSeCVDofkj3AvgAQ4PSeYnADFQEHh2SVHwzh6alGfJTQvfe/pwloZO4vMA5vWDzK4F
         wuEg==
X-Gm-Message-State: AC+VfDzRNnTfBOU0W37EhH0BfUQ26jVKsNT01rCmS/LSdc+EbqFRWD69
        L4JgnEWlY5cSIccGGo+SVvp5XDGzUrtehg==
X-Google-Smtp-Source: ACHHUZ5TNL2ioTXmSVjdrQW2VXr9zuA4V2DXy3f+kB+1M1kySUgKk0QxYiuWYb3QGhvUwV6G0+6YBhZ51bgw/A==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:c808:0:b0:54f:bb71:c7b3 with SMTP id
 n8-20020a81c808000000b0054fbb71c7b3mr589835ywi.9.1684399148266; Thu, 18 May
 2023 01:39:08 -0700 (PDT)
Date:   Thu, 18 May 2023 16:38:46 +0800
In-Reply-To: <20230518083849.2631178-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230518083849.2631178-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230518083849.2631178-4-davidgow@google.com>
Subject: [PATCH v2 4/4] Documentation: kunit: Add usage notes for kunit_add_action()
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Add some basic documentation for kunit_add_action() and related
deferred action functions.

Signed-off-by: David Gow <davidgow@google.com>
---

This patch is new in v2.

---
 Documentation/dev-tools/kunit/usage.rst | 51 +++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 46957d1cbcbb..c2f0ed648385 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -615,6 +615,57 @@ For example:
 		KUNIT_ASSERT_STREQ(test, buffer, "");
 	}
 
+Registering Cleanup Actions
+---------------------------
+
+If you need to perform some cleanup beyond simple use of ``kunit_kzalloc``,
+you can register a cusom "deferred action", which is a cleanup function
+run when the test exits (whether cleanly, or via a failed assertion).
+
+Actions are simple functions with no return value, and a single ``void*``
+context argument, and forfil the same role as "cleanup" functions in Python
+and Go tests, "defer" statements in languages which support them, and
+(in some cases) destructors in RAII languages.
+
+These are very useful for unregistering things from global lists, closing
+files or other resources, or freeing resources.
+
+For example:
+
+.. code-block:: C
+
+	static void cleanup_device(void *ctx)
+	{
+		struct device *dev = (struct device *)ctx;
+
+		device_unregister(dev);
+	}
+
+	void example_device_test(struct kunit *test)
+	{
+		struct my_device dev;
+
+		device_register(&dev);
+
+		kunit_add_action(test, &cleanup_device, &dev);
+	}
+
+Note that, for functions like device_unregister which only accept a single
+pointer-sized argument, it's possible to directly cast that function to
+a ``kunit_action_t`` rather than writing a wrapper function, for example:
+
+.. code-block:: C
+
+	kunit_add_action(test, (kunit_action_t *)&device_unregister, &dev);
+
+``kunit_add_action`` can fail if, for example, the system is out of memory.
+You can use ``kunit_add_action_or_reset`` instead which runs the action
+immediately if it cannot be deferred.
+
+If you need more control over when the cleanup function is called, you
+can trigger it early using ``kunit_release_action``, or cancel it entirely
+with ``kunit_remove_action``.
+
 
 Testing Static Functions
 ------------------------
-- 
2.40.1.698.g37aff9b760-goog

