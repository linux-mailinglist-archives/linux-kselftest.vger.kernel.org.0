Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E396CD64C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjC2JYf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC2JYd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 05:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E41FF3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680081825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mYk5Vd+Cw2j906cJQiXMpCJj7sRVVRcz7eKjR8ZmdUk=;
        b=fzNArQizBXnBqvEYCXTSHvjZmrYsBlOKOi+2e4edG18VRA2XvrKj4q5u0r18A9WFdsUXPp
        sEAR4bU5aTqXC1WtLCs9C92/vI5y2RcjDNG02DzY2EV+caIUbYIM8ruOF4Kar23K+9to5I
        5ZFJzbmDAXh8jBtOQBhg3wnF/4rLNW8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-9C0r7afJNdmeRETBLcV2fg-1; Wed, 29 Mar 2023 05:23:43 -0400
X-MC-Unique: 9C0r7afJNdmeRETBLcV2fg-1
Received: by mail-wm1-f71.google.com with SMTP id bh19-20020a05600c3d1300b003ee93fac4a9so8185325wmb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 02:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680081823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYk5Vd+Cw2j906cJQiXMpCJj7sRVVRcz7eKjR8ZmdUk=;
        b=kldtkt41N8/MwUtr2X6s3ClyqdKKeJBZzhyr+jpiyLOdTeGm1azYkPOk7mJ3wLS2gp
         TjKZti6IW2f2XiB4jl8MJBkEzT1MOh19XsSYZwvqzrQn4dpuq6OIAhImaBTIhX8AHihq
         ZBw8gakIlnN5P0reJUlhV5lCse2nR2ghhDC9JuR08SULHiqdk/yY2uZawYSUHuULVshB
         zF9sGke3dc9EIqXVoDFDmicNhEdzCnxZfXj9Vly5iS/8t5JC2VoU4C+DH/k1i8doLh9u
         /NYoTzDeWWLkq8d4e5Iakgx/EZXTgYaNoZyOhnHRrTWDG+lx9DUD8xnWvehIG5FW2KcX
         EfpA==
X-Gm-Message-State: AAQBX9fH8wrvwYRb3aDBrZOBcQ/zdSiTiZnQ903aWGOcBxiHmG4b3C/f
        uZHZ1Vmb4PhcbV/NSSusozkp72okwFjh9X/nNUGcHYLx8SzZSlDBuikkX7dewwhJwJIFq90zD3y
        pnKp75Ep2VPHF7mnk+YciS6u9mnrS
X-Received: by 2002:a1c:4c11:0:b0:3ef:6ea4:a675 with SMTP id z17-20020a1c4c11000000b003ef6ea4a675mr8271709wmf.36.1680081822762;
        Wed, 29 Mar 2023 02:23:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350YTIyv31nTZptEcX2RsNGbTwhTNTBAHponC3oHY6a+YXFKPgSWGFARGvtpGsKg6qg5oGHwhXw==
X-Received: by 2002:a1c:4c11:0:b0:3ef:6ea4:a675 with SMTP id z17-20020a1c4c11000000b003ef6ea4a675mr8271689wmf.36.1680081822369;
        Wed, 29 Mar 2023 02:23:42 -0700 (PDT)
Received: from minerva.redhat.com (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003ef5deb4188sm1672219wmq.17.2023.03.29.02.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:23:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kselftest@vger.kernel.org,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: Add KUnit tests for some of the input core helper functions
Date:   Wed, 29 Mar 2023 11:23:31 +0200
Message-Id: <20230329092332.2143623-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
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

  * input_test_match_device_id: match a device by bus, vendor, product
                                and events that is capable of handling.

But having the minimal KUnit support allows to add more tests and suites
as follow-up changes. The tests can be run with the following command:

  $ ./tools/testing/kunit/kunit.py run \
    --kunitconfig=drivers/input/tests/.kunitconfig

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/input/Kconfig            |  12 +++
 drivers/input/Makefile           |   1 +
 drivers/input/tests/Makefile     |   3 +
 drivers/input/tests/input_test.c | 144 +++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+)
 create mode 100644 drivers/input/tests/Makefile
 create mode 100644 drivers/input/tests/input_test.c

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index e2752f7364bc..e094e5bbaa0c 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -166,6 +166,18 @@ config INPUT_EVBUG
 	  To compile this driver as a module, choose M here: the
 	  module will be called evbug.
 
+config INPUT_KUNIT_TEST
+	tristate "KUnit tests for Input" if !KUNIT_ALL_TESTS
+	depends on INPUT && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Say Y here if you want to build the KUnit tests for the input
+	  subsystem. For more information about KUnit and unit tests in
+	  general, please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
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
index 000000000000..25bbf51b5c87
--- /dev/null
+++ b/drivers/input/tests/input_test.c
@@ -0,0 +1,144 @@
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
+	KUNIT_ASSERT_EQ(test, ret, 0);
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
+}
+
+static void input_test_poll(struct input_dev *input) { }
+
+static void input_test_polling(struct kunit *test)
+{
+	struct input_dev *input_dev = test->priv;
+	int ret;
+
+	ret = input_get_poll_interval(input_dev);
+	KUNIT_ASSERT_EQ(test, ret, -EINVAL);
+
+	ret = input_setup_polling(input_dev, input_test_poll);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	input_set_poll_interval(input_dev, POLL_INTERVAL);
+
+	ret = input_get_poll_interval(input_dev);
+	KUNIT_ASSERT_EQ(test, ret, POLL_INTERVAL);
+}
+
+static void input_test_timestamp(struct kunit *test)
+{
+	const ktime_t invalid_timestamp = ktime_set(0, 0);
+	struct input_dev *input_dev = test->priv;
+	ktime_t *timestamp, time;
+	int ret;
+
+	timestamp = input_get_timestamp(input_dev);
+	time = timestamp[INPUT_CLK_MONO];
+
+	ret = ktime_compare(time, invalid_timestamp);
+	KUNIT_ASSERT_EQ(test, ret, 1);
+
+	time = ktime_get();
+	input_set_timestamp(input_dev, time);
+
+	timestamp = input_get_timestamp(input_dev);
+	KUNIT_ASSERT_EQ(test, ktime_compare(timestamp[INPUT_CLK_MONO],
+					    time), 0);
+}
+
+static void input_test_match_device_id(struct kunit *test)
+{
+	struct input_dev *input_dev = test->priv;
+	struct input_device_id id;
+
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

