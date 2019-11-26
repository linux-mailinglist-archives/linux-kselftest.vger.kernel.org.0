Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793AA10A10A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 16:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfKZPRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 10:17:23 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57200 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbfKZPRW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 10:17:22 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6550C2005D6;
        Tue, 26 Nov 2019 16:17:20 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 569B420011C;
        Tue, 26 Nov 2019 16:17:20 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B5AA520507;
        Tue, 26 Nov 2019 16:17:19 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v4 1/4] PM / QoS: Initial kunit test
Date:   Tue, 26 Nov 2019 17:17:10 +0200
Message-Id: <be196b656bb5fbf2c59a179e6453aa963b862109.1574781196.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574781196.git.leonard.crestez@nxp.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1574781196.git.leonard.crestez@nxp.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pm_qos family of APIs are used in relatively difficult to reproduce
scenarios such as thermal throttling so they benefit from unit testing.

Start by adding basic tests from the the freq_qos APIs. It includes
tests for issues that were brought up on mailing lists:

https://patchwork.kernel.org/patch/11252425/#23017005
https://patchwork.kernel.org/patch/11253421/

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/base/Kconfig          |   4 ++
 drivers/base/power/Makefile   |   1 +
 drivers/base/power/qos-test.c | 117 ++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 drivers/base/power/qos-test.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index e37d37684132..d4ae1c1adf69 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -155,10 +155,14 @@ config DEBUG_TEST_DRIVER_REMOVE
 
 	  This option is expected to find errors and may render your system
 	  unusable. You should say N here unless you are explicitly looking to
 	  test this functionality.
 
+config PM_QOS_KUNIT_TEST
+	bool "KUnit Test for PM QoS features"
+	depends on KUNIT
+
 config HMEM_REPORTING
 	bool
 	default n
 	depends on NUMA
 	help
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index ec5bb190b9d0..8fdd0073eeeb 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -2,7 +2,8 @@
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o wakeup_stats.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
+obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/power/qos-test.c b/drivers/base/power/qos-test.c
new file mode 100644
index 000000000000..3115db08d56b
--- /dev/null
+++ b/drivers/base/power/qos-test.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP
+ */
+#include <kunit/test.h>
+#include <linux/pm_qos.h>
+
+/* Basic test for aggregating two "min" requests */
+static void freq_qos_test_min(struct kunit *test)
+{
+	struct freq_constraints	qos;
+	struct freq_qos_request	req1, req2;
+	int ret;
+
+	freq_constraints_init(&qos);
+	memset(&req1, 0, sizeof(req1));
+	memset(&req2, 0, sizeof(req2));
+
+	ret = freq_qos_add_request(&qos, &req1, FREQ_QOS_MIN, 1000);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+	ret = freq_qos_add_request(&qos, &req2, FREQ_QOS_MIN, 2000);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 2000);
+
+	ret = freq_qos_remove_request(&req2);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);
+
+	ret = freq_qos_remove_request(&req1);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),
+			FREQ_QOS_MIN_DEFAULT_VALUE);
+}
+
+/* Test that requests for MAX_DEFAULT_VALUE have no effect */
+static void freq_qos_test_maxdef(struct kunit *test)
+{
+	struct freq_constraints	qos;
+	struct freq_qos_request	req1, req2;
+	int ret;
+
+	freq_constraints_init(&qos);
+	memset(&req1, 0, sizeof(req1));
+	memset(&req2, 0, sizeof(req2));
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX),
+			FREQ_QOS_MAX_DEFAULT_VALUE);
+
+	ret = freq_qos_add_request(&qos, &req1, FREQ_QOS_MAX,
+			FREQ_QOS_MAX_DEFAULT_VALUE);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	ret = freq_qos_add_request(&qos, &req2, FREQ_QOS_MAX,
+			FREQ_QOS_MAX_DEFAULT_VALUE);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* Add max 1000 */
+	ret = freq_qos_update_request(&req1, 1000);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 1000);
+
+	/* Add max 2000, no impact */
+	ret = freq_qos_update_request(&req2, 2000);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 1000);
+
+	/* Remove max 1000, new max 2000 */
+	ret = freq_qos_remove_request(&req1);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 2000);
+}
+
+/*
+ * Test that a freq_qos_request can be added again after removal
+ *
+ * This issue was solved by commit 05ff1ba412fd ("PM: QoS: Invalidate frequency
+ * QoS requests after removal")
+ */
+static void freq_qos_test_readd(struct kunit *test)
+{
+	struct freq_constraints	qos;
+	struct freq_qos_request	req;
+	int ret;
+
+	freq_constraints_init(&qos);
+	memset(&req, 0, sizeof(req));
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),
+			FREQ_QOS_MIN_DEFAULT_VALUE);
+
+	/* Add */
+	ret = freq_qos_add_request(&qos, &req, FREQ_QOS_MIN, 1000);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);
+
+	/* Remove */
+	ret = freq_qos_remove_request(&req);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),
+			FREQ_QOS_MIN_DEFAULT_VALUE);
+
+	/* Add again */
+	ret = freq_qos_add_request(&qos, &req, FREQ_QOS_MIN, 2000);
+	KUNIT_EXPECT_EQ(test, ret, 1);
+	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 2000);
+}
+
+static struct kunit_case pm_qos_test_cases[] = {
+	KUNIT_CASE(freq_qos_test_min),
+	KUNIT_CASE(freq_qos_test_maxdef),
+	KUNIT_CASE(freq_qos_test_readd),
+	{},
+};
+
+static struct kunit_suite pm_qos_test_module = {
+	.name = "qos-kunit-test",
+	.test_cases = pm_qos_test_cases,
+};
+kunit_test_suite(pm_qos_test_module);
-- 
2.17.1

