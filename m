Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE7B6CFE0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjC3ITl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 04:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC3ITk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 04:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA65125
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680164332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t7eECtwVNg9V18DvuwK2iZYXBSAw49aJkmw0hqJ5qzY=;
        b=Gv5ac868GpQ8ovNnqG7G3lQhb/r6Lv/lkD8sel7PlSKUPsQdDNKG/6vxO+9PJiIM8lxIrI
        3aOV9uJk3MDoSynuUozJhsATJ6m0C7ty8qnhso+SFd39BkeYwJeUhxFcbu7ZgJBrfqvD5B
        4OppP12/+gMODTasZ5KohHU/+hXgejM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-LbyWXHpbO2ChiiNobo0EWg-1; Thu, 30 Mar 2023 04:18:50 -0400
X-MC-Unique: LbyWXHpbO2ChiiNobo0EWg-1
Received: by mail-wm1-f71.google.com with SMTP id u14-20020a05600c19ce00b003f0331154b1so1106712wmq.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 01:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7eECtwVNg9V18DvuwK2iZYXBSAw49aJkmw0hqJ5qzY=;
        b=rFdmLQt2bA0/X+kH/+uIs0EUD5//UbPuBsHyS5d/q9iN1SklnoaDi4O9vxfBAJKJLo
         s7fWlELZW9imVRvzqNf7pnigFKNHyG4JnqVoX82MMQY+8HBe0i0in612DXO/S/LoXTh7
         zXgF99geuQmUftyDoiBZSNa9Rdp49AaW/F8t0IuPmhIpYsJ5zrZ4XPBlYgwHF9iNlwMg
         4rkf6itWvCgubv+we3HWbbTm2uuwf2HK6Q0tMrjTO3wsxAMLlCM6+aMbo46O57UdccfD
         11emt0TE8q3cdvxirIoZSGaBcbYT+6T9n34JGiNLd30fyzE31kuRdCALgORB8P/9WXO+
         UCog==
X-Gm-Message-State: AAQBX9ele5GPv9ckwIfM+JSZDLsLBIwBAU6lRPv++4i4tZCs5ak8N5v1
        rTBTufKlvRVFIuiWeQBQbBWMOYmEe5IZKx2YT/zlTl1xm6fUuMX2frCDFTX3BYKnoJLDERbIRuB
        BlUghHQglSuf1klXVRcDxSBHpTflz
X-Received: by 2002:a5d:53c8:0:b0:2dd:2a04:b73f with SMTP id a8-20020a5d53c8000000b002dd2a04b73fmr14836577wrw.49.1680164329579;
        Thu, 30 Mar 2023 01:18:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350YHmCn199HtVyO5MEs1UEbLsArdPXVMMRghyJj0jOBpNRBnC3gHUBArUxmR5qR0AZzRBzXpAg==
X-Received: by 2002:a5d:53c8:0:b0:2dd:2a04:b73f with SMTP id a8-20020a5d53c8000000b002dd2a04b73fmr14836558wrw.49.1680164329215;
        Thu, 30 Mar 2023 01:18:49 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b9-20020adfde09000000b002daeb108304sm19070458wrm.33.2023.03.30.01.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:18:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Enric Balletbo i Serra <eballetbo@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH v2] Input: Add KUnit tests for some of the input core helper functions
Date:   Thu, 30 Mar 2023 10:18:31 +0200
Message-Id: <20230330081831.2291351-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The input subsystem doesn't currently have any unit tests, let's add a
CONFIG_INPUT_KUNIT_TEST option that builds a test suite to be executed
with the KUnit test infrastructure.

For now, only three tests were added for some of the input core helper
functions that are trivial to test:

  * input_test_polling: set/get poll interval and set-up a poll handler.

  * input_test_timestamp: set/get input event timestamps.

  * input_test_match_device_id: match a device by bus, vendor, product,
                                version and events capable of handling.

But having the minimal KUnit support allows to add more tests and suites
as follow-up changes. The tests can be run with the following command:

  $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/input/tests/

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>
---

Changes in v2:
- Add Enric's Tested-by tag.
- Drop the .kunitconfig from the example command (Daniel Latypov).
- Add .kunitconfig that wasn't added by mistake (Daniel Latypov).
- Remove ref to KUnit docs in the Kconfig help text (Daniel Latypov).
- Inline function calls in the KUNIT_ASSERT_*() calls (Daniel Latypov).
- Add some comments to explain why a fail or success is expected.

 drivers/input/Kconfig            |  10 +++
 drivers/input/Makefile           |   1 +
 drivers/input/tests/.kunitconfig |   3 +
 drivers/input/tests/Makefile     |   3 +
 drivers/input/tests/input_test.c | 150 +++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 drivers/input/tests/.kunitconfig
 create mode 100644 drivers/input/tests/Makefile
 create mode 100644 drivers/input/tests/input_test.c

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index e2752f7364bc..735f90b74ee5 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -166,6 +166,16 @@ config INPUT_EVBUG
 	  To compile this driver as a module, choose M here: the
 	  module will be called evbug.
 
+config INPUT_KUNIT_TEST
+	tristate "KUnit tests for Input" if !KUNIT_ALL_TESTS
+	depends on INPUT && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Say Y here if you want to build the KUnit tests for the input
+	  subsystem.
+
+	  If in doubt, say "N".
+
 config INPUT_APMPOWER
 	tristate "Input Power Event -> APM Bridge" if EXPERT
 	depends on INPUT && APM_EMULATION
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 2266c7d010ef..c78753274921 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_INPUT_JOYSTICK)	+= joystick/
 obj-$(CONFIG_INPUT_TABLET)	+= tablet/
 obj-$(CONFIG_INPUT_TOUCHSCREEN)	+= touchscreen/
 obj-$(CONFIG_INPUT_MISC)	+= misc/
+obj-$(CONFIG_INPUT_KUNIT_TEST)	+= tests/
 
 obj-$(CONFIG_INPUT_APMPOWER)	+= apm-power.o
 
diff --git a/drivers/input/tests/.kunitconfig b/drivers/input/tests/.kunitconfig
new file mode 100644
index 000000000000..2f5bedf8028e
--- /dev/null
+++ b/drivers/input/tests/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_INPUT=y
+CONFIG_INPUT_KUNIT_TEST=y
diff --git a/drivers/input/tests/Makefile b/drivers/input/tests/Makefile
new file mode 100644
index 000000000000..90cf954181bc
--- /dev/null
+++ b/drivers/input/tests/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_INPUT_KUNIT_TEST) += input_test.o
diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
new file mode 100644
index 000000000000..e5a6c1ad2167
--- /dev/null
+++ b/drivers/input/tests/input_test.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the input core.
+ *
+ * Copyright (c) 2023 Red Hat Inc
+ */
+
+#include <linux/delay.h>
+#include <linux/input.h>
+
+#include <kunit/test.h>
+
+#define POLL_INTERVAL 100
+
+static int input_test_init(struct kunit *test)
+{
+	struct input_dev *input_dev;
+	int ret;
+
+	input_dev = input_allocate_device();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, input_dev);
+
+	input_dev->name = "Test input device";
+	input_dev->id.bustype = BUS_VIRTUAL;
+	input_dev->id.vendor = 1;
+	input_dev->id.product = 1;
+	input_dev->id.version = 1;
+	input_set_capability(input_dev, EV_KEY, BTN_LEFT);
+	input_set_capability(input_dev, EV_KEY, BTN_RIGHT);
+
+	ret = input_register_device(input_dev);
+	if (ret) {
+		input_free_device(input_dev);
+		KUNIT_ASSERT_FAILURE(test, "Register device failed: %d", ret);
+	}
+
+	test->priv = input_dev;
+
+	return 0;
+}
+
+static void input_test_exit(struct kunit *test)
+{
+	struct input_dev *input_dev = test->priv;
+
+	input_unregister_device(input_dev);
+	input_free_device(input_dev);
+}
+
+static void input_test_poll(struct input_dev *input) { }
+
+static void input_test_polling(struct kunit *test)
+{
+	struct input_dev *input_dev = test->priv;
+
+	/* Must fail because a poll handler has not been set-up yet */
+	KUNIT_ASSERT_EQ(test, input_get_poll_interval(input_dev), -EINVAL);
+
+	KUNIT_ASSERT_EQ(test, input_setup_polling(input_dev, input_test_poll), 0);
+
+	input_set_poll_interval(input_dev, POLL_INTERVAL);
+
+	/* Must succeed because poll handler was set-up and poll interval set */
+	KUNIT_ASSERT_EQ(test, input_get_poll_interval(input_dev), POLL_INTERVAL);
+}
+
+static void input_test_timestamp(struct kunit *test)
+{
+	const ktime_t invalid_timestamp = ktime_set(0, 0);
+	struct input_dev *input_dev = test->priv;
+	ktime_t *timestamp, time;
+
+	timestamp = input_get_timestamp(input_dev);
+	time = timestamp[INPUT_CLK_MONO];
+
+	/* The returned timestamp must always be valid */
+	KUNIT_ASSERT_EQ(test, ktime_compare(time, invalid_timestamp), 1);
+
+	time = ktime_get();
+	input_set_timestamp(input_dev, time);
+
+	timestamp = input_get_timestamp(input_dev);
+	/* The timestamp must be the same than set before */
+	KUNIT_ASSERT_EQ(test, ktime_compare(timestamp[INPUT_CLK_MONO], time), 0);
+}
+
+static void input_test_match_device_id(struct kunit *test)
+{
+	struct input_dev *input_dev = test->priv;
+	struct input_device_id id;
+
+	/*
+	 * Must match when the input device bus, vendor, product, version
+	 * and events capable of handling are the same and fail to match
+	 * otherwise.
+	 */
+	id.flags = INPUT_DEVICE_ID_MATCH_BUS;
+	id.bustype = BUS_VIRTUAL;
+	KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
+
+	id.bustype = BUS_I2C;
+	KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
+
+	id.flags = INPUT_DEVICE_ID_MATCH_VENDOR;
+	id.vendor = 1;
+	KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
+
+	id.vendor = 2;
+	KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
+
+	id.flags = INPUT_DEVICE_ID_MATCH_PRODUCT;
+	id.product = 1;
+	KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
+
+	id.product = 2;
+	KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
+
+	id.flags = INPUT_DEVICE_ID_MATCH_VERSION;
+	id.version = 1;
+	KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
+
+	id.version = 2;
+	KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
+
+	id.flags = INPUT_DEVICE_ID_MATCH_EVBIT;
+	__set_bit(EV_KEY, id.evbit);
+	KUNIT_ASSERT_TRUE(test, input_match_device_id(input_dev, &id));
+
+	__set_bit(EV_ABS, id.evbit);
+	KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
+}
+
+static struct kunit_case input_tests[] = {
+	KUNIT_CASE(input_test_polling),
+	KUNIT_CASE(input_test_timestamp),
+	KUNIT_CASE(input_test_match_device_id),
+	{ /* sentinel */ }
+};
+
+static struct kunit_suite input_test_suite = {
+	.name = "input_core",
+	.init = input_test_init,
+	.exit = input_test_exit,
+	.test_cases = input_tests,
+};
+
+kunit_test_suite(input_test_suite);
+
+MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
+MODULE_LICENSE("GPL");

base-commit: 3a93e40326c8f470e71d20b4c42d36767450f38f
-- 
2.40.0

