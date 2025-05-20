Return-Path: <linux-kselftest+bounces-33374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE61ABD1DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B1A3A1BF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE9526658F;
	Tue, 20 May 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0qj9Gr9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1826656F;
	Tue, 20 May 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729524; cv=none; b=XZu9Fmdf/nTqZTPs5rqLwha9IQmrKJcBGR7nF/2uZyxfk4PZG5aRe4GiOo3u4ew40yo+82fZaBl6f+crrX7Y+g9buiRWM+fQvOByOPwEt7FLONElcXuerr0P0UAxckl/gEJgBAyvuUSrthVWIE/KWkracqbivIXNh4pPIVpUmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729524; c=relaxed/simple;
	bh=giFQ1SuT7sFCI5lClrg/bhLGk/DZw7docWUYgops1cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yjg9wmJE0HsPGqBrltJcABYUgx9bk3q+f/f74tQKEH32q1dspZ21RUENLfKN/NLNRBYGIx8UPvDc2kCxtXvPmd/eLRnTKFt7MzizvovJi5z8L+4nLvi0Sgu4p/G14MWq+mLMiZsJOnUn2/Q+yygx3FSJMomPNnbLdXgOh/NImW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0qj9Gr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24478C4CEE9;
	Tue, 20 May 2025 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729524;
	bh=giFQ1SuT7sFCI5lClrg/bhLGk/DZw7docWUYgops1cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0qj9Gr9sZ/7uGSzCdDba4+gG0o5K0isLIlIUNCIRKCgouR2MedDm2gej5UWqnmff
	 dfIjAEwsbGfqS/rkDP6o4BQ80DvF99guFax4RtDUZu2TUtCG9HOd9X46gCF/Q8pbBS
	 iVwRM7B/z1wYRD8/PA0WRlcWNyN+6Kbei8rUWJISdXyXgcu+rNDdcdmYUXWSWNkbiM
	 m2rtIbS7UcDc3GcXtl2gXY8eQszCo4IvPe0/J0ApeCG1ehruBAmEpogbFV3PjRdK1Y
	 OHz/LQTB5Gel/CnwfNbHX0o7Yh8MevoFCW4i2g1DivMdeM0GA54hlaEjtwG31cZrkK
	 c0tUEsvoCw0TA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	brendan.higgins@linux.dev,
	davidgow@google.com
Cc: tzungbi@kernel.org,
	rmoar@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] platform/chrome: kunit: cros_ec_spi: Add tests with ftrace stub
Date: Tue, 20 May 2025 08:24:31 +0000
Message-ID: <20250520082435.2255639-5-tzungbi@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
In-Reply-To: <20250520082435.2255639-1-tzungbi@kernel.org>
References: <20250520082435.2255639-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For running the tests:

$ ./tools/testing/kunit/kunit.py run \
	--arch=x86_64 \
	--kconfig_add CONFIG_FTRACE=y \
	--kconfig_add CONFIG_FUNCTION_TRACER=y \
	--kconfig_add CONFIG_MODULES=y \
	--kconfig_add CONFIG_DEBUG_KERNEL=y \
	--kconfig_add CONFIG_KALLSYMS_ALL=y \
	--kconfig_add CONFIG_LIVEPATCH=y \
	--kconfig_add CONFIG_KUNIT_FTRACE_STUBS=y \
	--kconfig_add CONFIG_CHROME_PLATFORMS=y \
	--kconfig_add CONFIG_CROS_EC=y \
	--kconfig_add CONFIG_SPI=y \
	--kconfig_add CONFIG_CROS_EC_SPI=y \
	--kconfig_add CONFIG_CROS_KUNIT_EC_SPI_TEST=y \
	cros_ec_spi*

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/Kconfig            |   9 +
 drivers/platform/chrome/Makefile           |   1 +
 drivers/platform/chrome/cros_ec_spi_test.c | 361 +++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_spi_test.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index bf10c0625be8..aa13e871a31f 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -335,4 +335,13 @@ config CROS_KUNIT_EC_I2C_TEST
 	help
 	  Kunit tests for ChromeOS EC over I2C.
 
+config CROS_KUNIT_EC_SPI_TEST
+	tristate "Kunit tests for ChromeOS EC over SPI" if !KUNIT_ALL_TESTS
+	depends on KUNIT && CROS_EC
+	default KUNIT_ALL_TESTS
+	depends on KUNIT_FTRACE_STUBS
+	depends on CROS_EC_SPI
+	help
+	  Kunit tests for ChromeOS EC over SPI.
+
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 9808f25aea38..74649b8f21b3 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
 obj-$(CONFIG_CROS_KUNIT_EC_PROTO_TEST)	+= cros_kunit_proto_test.o
 cros_kunit_proto_test-objs		:= cros_ec_proto_test_util.o cros_ec_proto_test.o
 obj-$(CONFIG_CROS_KUNIT_EC_I2C_TEST)	+= cros_ec_i2c_test.o
+obj-$(CONFIG_CROS_KUNIT_EC_SPI_TEST)	+= cros_ec_spi_test.o
diff --git a/drivers/platform/chrome/cros_ec_spi_test.c b/drivers/platform/chrome/cros_ec_spi_test.c
new file mode 100644
index 000000000000..2a021569a726
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_spi_test.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit tests for ChromeOS Embedded Controller SPI interface.
+ */
+#include <kunit/test.h>
+#include <kunit/ftrace_stub.h>
+
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/sched.h>
+#include <linux/spi/spi.h>
+
+#include "cros_ec.h"
+
+#define BUFSIZE 128
+#define SPI_BUS_NUM 0x6
+
+struct fake_xt {
+	u8 *buf;
+	size_t len;
+
+	struct list_head list;
+};
+
+struct cros_ec_spi_test_priv {
+	struct class *fake_class;
+	struct device dev;
+	struct spi_controller *fake_ctlr;
+	struct spi_device *fake_spi_device;
+
+	int fake_cros_ec_register_called;
+	struct cros_ec_device *ec_dev;
+
+	int fake_cros_ec_unregister_called;
+
+	struct list_head tx_head;
+	struct list_head rx_head;
+};
+
+static struct fake_xt *queue_fake_xt(struct kunit *test, struct list_head *head, size_t len)
+{
+	struct fake_xt *xt = kunit_kmalloc(test, sizeof(*xt), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, xt);
+
+	xt->buf = kunit_kzalloc(test, len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, xt->buf);
+	xt->len = len;
+	list_add_tail(&xt->list, head);
+	return xt;
+}
+
+static struct fake_xt *dequeue_fake_xt(struct list_head *head)
+{
+	struct fake_xt *xt = list_first_entry(head, struct fake_xt, list);
+	list_del(&xt->list);
+	return xt;
+}
+
+static int fake_cros_ec_register(struct cros_ec_device *ec_dev)
+{
+	struct kunit *test = current->kunit_test;
+	struct cros_ec_spi_test_priv *priv = test->priv;
+
+	priv->fake_cros_ec_register_called += 1;
+
+	priv->ec_dev = ec_dev;
+	priv->ec_dev->din_size = BUFSIZE;
+	priv->ec_dev->din = kunit_kmalloc(test, priv->ec_dev->din_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->ec_dev->din);
+	priv->ec_dev->dout_size = BUFSIZE;
+	priv->ec_dev->dout = kunit_kmalloc(test, priv->ec_dev->dout_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->ec_dev->dout);
+	return 0;
+}
+
+static void fake_cros_ec_unregister(struct cros_ec_device *ec_dev)
+{
+	struct kunit *test = current->kunit_test;
+	struct cros_ec_spi_test_priv *priv = test->priv;
+
+	priv->fake_cros_ec_unregister_called += 1;
+}
+
+static int fake_spi_transfer_one_message(struct spi_controller *ctlr, struct spi_message *msg)
+{
+	/* Note: the function's context is another kernel thread. */
+	struct kunit *test = spi_controller_get_devdata(ctlr);
+	struct cros_ec_spi_test_priv *priv = test->priv;
+	struct spi_transfer *t;
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->tx_buf) {
+			struct fake_xt *tx = queue_fake_xt(test, &priv->tx_head, t->len);
+			memcpy(tx->buf, t->tx_buf, t->len);
+		}
+
+		if (t->rx_buf && !list_empty(&priv->rx_head)) {
+			struct fake_xt *rx = dequeue_fake_xt(&priv->rx_head);
+			memcpy(t->rx_buf, rx->buf, min(t->len, rx->len));
+		}
+	}
+
+	msg->status = 0;
+	spi_finalize_current_message(ctlr);
+	return 0;
+}
+
+static int find_target_driver(struct device_driver *drv, void *data)
+{
+	struct device_driver **pdrv = data;
+
+	if (strcmp(drv->name, "cros-ec-spi") == 0)
+		*pdrv = drv;
+	return 0;
+}
+
+static int cros_ec_spi_test_init(struct kunit *test)
+{
+	struct cros_ec_spi_test_priv *priv;
+	struct spi_board_info board_info = {};
+	int ret;
+	struct device_driver *drv;
+	enum probe_type orig;
+
+	kunit_activate_ftrace_stub(test, cros_ec_register, fake_cros_ec_register);
+	kunit_activate_ftrace_stub(test, cros_ec_unregister, fake_cros_ec_unregister);
+
+	sized_strscpy(board_info.modalias, "cros-ec-spi", SPI_NAME_SIZE);
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+	test->priv = priv;
+
+	priv->fake_class = class_create("fake-class");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->fake_class);
+
+	priv->dev.class = priv->fake_class;
+	priv->dev.parent = NULL;
+	dev_set_name(&priv->dev, "cros-ec-spi-test-dev");
+	ret = device_register(&priv->dev);
+	if (ret)
+		put_device(&priv->dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	priv->fake_ctlr = spi_alloc_host(&priv->dev, 0);
+	KUNIT_ASSERT_NOT_NULL(test, priv->fake_ctlr);
+	spi_controller_set_devdata(priv->fake_ctlr, test);
+
+	priv->fake_ctlr->transfer_one_message = fake_spi_transfer_one_message;
+	priv->fake_ctlr->bus_num = SPI_BUS_NUM;
+	ret = spi_register_controller(priv->fake_ctlr);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/*
+	 * Force to use synchronous probe so that the upcoming SPI device gets
+	 * probed correctly and synchronously.
+	 */
+	ret = bus_for_each_drv(&spi_bus_type, NULL, &drv, find_target_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, drv);
+	orig = drv->probe_type;
+	drv->probe_type = PROBE_FORCE_SYNCHRONOUS;
+
+	priv->fake_spi_device = spi_new_device(priv->fake_ctlr, &board_info);
+	/* Restore to original probe type. */
+	drv->probe_type = orig;
+	KUNIT_ASSERT_NOT_NULL(test, priv->fake_spi_device);
+
+	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_register_called, 1);
+	KUNIT_ASSERT_NOT_NULL(test, priv->ec_dev);
+	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_unregister_called, 0);
+
+	INIT_LIST_HEAD(&priv->tx_head);
+	INIT_LIST_HEAD(&priv->rx_head);
+
+	return 0;
+}
+
+static void cros_ec_spi_test_exit(struct kunit *test)
+{
+	struct cros_ec_spi_test_priv *priv = test->priv;
+
+	spi_unregister_device(priv->fake_spi_device);
+	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_unregister_called, 1);
+
+	spi_unregister_controller(priv->fake_ctlr);
+	device_del(&priv->dev);
+	class_destroy(priv->fake_class);
+
+	kunit_deactivate_ftrace_stub(test, cros_ec_register);
+	kunit_deactivate_ftrace_stub(test, cros_ec_unregister);
+}
+
+static int cros_ec_spi_test_cmd_xfer_init(struct kunit *test)
+{
+	struct cros_ec_spi_test_priv *priv;
+
+	cros_ec_spi_test_init(test);
+	priv = test->priv;
+	priv->ec_dev->proto_version = 2;
+	return 0;
+}
+
+static void cros_ec_spi_test_cmd_xfer_normal(struct kunit *test)
+{
+	struct cros_ec_spi_test_priv *priv = test->priv;
+	struct cros_ec_command *msg;
+	struct fake_xt *xt;
+	int ret, i, len;
+	u8 sum;
+
+	msg = kunit_kzalloc(test, sizeof(*msg) + 2 /* max(outsize, insize) */, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, msg);
+	msg->version = 0x1000;
+	msg->command = 0x1001;
+	msg->outsize = 2;
+	msg->insize = 1;
+	msg->data[0] = 0xbe;
+	msg->data[1] = 0xef;
+
+	/*
+	 * cros_ec_spi sends out the msg and tries to read further EC_MSG_TX_PROTO_BYTES +
+	 * msg->outsize bytes to verify if the EC can proceed the command by looking for
+	 * EC_SPI_PAST_END, EC_SPI_RX_BAD_DATA, or EC_SPI_NOT_READY.  It's fine even if we
+	 * prepare 0 length data.
+	 */
+	queue_fake_xt(test, &priv->rx_head, 0);
+
+	len = 1 /* for EC_SPI_FRAME_START */ + EC_MSG_RX_PROTO_BYTES + msg->insize;
+	xt = queue_fake_xt(test, &priv->rx_head, len);
+	xt->buf[0] = EC_SPI_FRAME_START;
+	xt->buf[1] = 0 /* result */;
+	xt->buf[2] = msg->insize;
+	xt->buf[3] = 0xaa;
+	for (sum = 0, i = 1; i < len - 1; ++i)
+		sum += xt->buf[i];
+	xt->buf[len - 1] = sum;
+
+	ret = priv->ec_dev->cmd_xfer(priv->ec_dev, msg);
+	KUNIT_EXPECT_EQ(test, ret, 1 /* insize */);
+	KUNIT_EXPECT_EQ(test, msg->result, 0);
+	KUNIT_EXPECT_EQ(test, msg->data[0], 0xaa);
+
+	KUNIT_EXPECT_FALSE(test, list_empty(&priv->tx_head));
+	xt = dequeue_fake_xt(&priv->tx_head);
+	KUNIT_EXPECT_TRUE(test, list_empty(&priv->tx_head));
+	KUNIT_EXPECT_NOT_NULL(test, xt);
+	KUNIT_EXPECT_NOT_NULL(test, xt->buf);
+	KUNIT_EXPECT_EQ(test, xt->len, EC_MSG_TX_PROTO_BYTES + 2 /* outsize */);
+	KUNIT_EXPECT_EQ(test, xt->buf[0], (u8)(EC_CMD_VERSION0 + 0x1000));
+	KUNIT_EXPECT_EQ(test, xt->buf[1], (u8)0x1001);
+	KUNIT_EXPECT_EQ(test, xt->buf[2], 2 /* outsize */);
+	KUNIT_EXPECT_EQ(test, xt->buf[3], 0xbe);
+	KUNIT_EXPECT_EQ(test, xt->buf[4], 0xef);
+	for (sum = 0, i = 0; i < EC_MSG_TX_HEADER_BYTES + 2 /* outsize */; ++i)
+		sum += xt->buf[i];
+	KUNIT_EXPECT_EQ(test, xt->buf[EC_MSG_TX_HEADER_BYTES + 2 /* outsize */], sum);
+}
+
+static struct kunit_case cros_ec_spi_test_cmd_xfer_cases[] = {
+	KUNIT_CASE(cros_ec_spi_test_cmd_xfer_normal),
+	{}
+};
+
+static struct kunit_suite cros_ec_spi_test_cmd_xfer_suite = {
+	.name = "cros_ec_spi_test_cmd_xfer_suite",
+	.init = cros_ec_spi_test_cmd_xfer_init,
+	.exit = cros_ec_spi_test_exit,
+	.test_cases = cros_ec_spi_test_cmd_xfer_cases,
+};
+
+static int cros_ec_spi_test_pkt_xfer_init(struct kunit *test)
+{
+	struct cros_ec_spi_test_priv *priv;
+
+	cros_ec_spi_test_init(test);
+	priv = test->priv;
+	priv->ec_dev->proto_version = 3;
+	return 0;
+}
+
+static void cros_ec_spi_test_pkt_xfer_normal(struct kunit *test)
+{
+	struct cros_ec_spi_test_priv *priv = test->priv;
+	struct cros_ec_command *msg;
+	struct fake_xt *xt;
+	struct ec_host_request *request;
+	struct ec_host_response *response;
+	int ret, i, len;
+	u8 sum;
+
+	msg = kunit_kzalloc(test, sizeof(*msg) + 2 /* max(outsize, insize) */, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, msg);
+	msg->version = 0x1000;
+	msg->command = 0x1001;
+	msg->outsize = 2;
+	msg->insize = 1;
+	msg->data[0] = 0xbe;
+	msg->data[1] = 0xef;
+
+	/*
+	 * cros_ec_spi sends out the msg and tries to read further EC_MSG_TX_PROTO_BYTES +
+	 * msg->outsize bytes to verify if the EC can proceed the command by looking for
+	 * EC_SPI_PAST_END, EC_SPI_RX_BAD_DATA, or EC_SPI_NOT_READY.  It's fine even if we
+	 * prepare 0 length data.
+	 */
+	queue_fake_xt(test, &priv->rx_head, 0);
+
+	len = 1 /* for EC_SPI_FRAME_START */ + sizeof(*response) + msg->insize;
+	xt = queue_fake_xt(test, &priv->rx_head, len);
+	xt->buf[0] = EC_SPI_FRAME_START;
+	response = (struct ec_host_response *)&xt->buf[1];
+	response->struct_version = EC_HOST_RESPONSE_VERSION;
+	response->result = 0;
+	response->data_len = msg->insize;
+	xt->buf[sizeof(*response) + msg->insize] = 0xaa;
+	for (sum = 0, i = 1; i < len; ++i)
+		sum += xt->buf[i];
+	response->checksum = -sum;
+
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, msg);
+	KUNIT_EXPECT_EQ(test, ret, 1 /* insize */);
+	KUNIT_EXPECT_EQ(test, msg->result, 0);
+	KUNIT_EXPECT_EQ(test, msg->data[0], 0xaa);
+
+	KUNIT_EXPECT_FALSE(test, list_empty(&priv->tx_head));
+	xt = dequeue_fake_xt(&priv->tx_head);
+	KUNIT_EXPECT_TRUE(test, list_empty(&priv->tx_head));
+	KUNIT_EXPECT_NOT_NULL(test, xt);
+	KUNIT_EXPECT_NOT_NULL(test, xt->buf);
+	KUNIT_EXPECT_EQ(test, xt->len, sizeof(*request) + 2 /* outsize */);
+	request = (struct ec_host_request *)xt->buf;
+	KUNIT_EXPECT_EQ(test, request->struct_version, EC_HOST_REQUEST_VERSION);
+	KUNIT_EXPECT_EQ(test, request->command_version, (u8)0x1000);
+	KUNIT_EXPECT_EQ(test, request->command, 0x1001);
+	KUNIT_EXPECT_EQ(test, request->data_len, 2 /* outsize */);
+	KUNIT_EXPECT_EQ(test, xt->buf[sizeof(*request)], 0xbe);
+	KUNIT_EXPECT_EQ(test, xt->buf[sizeof(*request) + 1], 0xef);
+	for (sum = 0, i = 0; i < sizeof(*request) + 2 /* outsize */; ++i)
+		sum += xt->buf[i];
+	KUNIT_EXPECT_EQ(test, sum, 0);
+}
+
+static struct kunit_case cros_ec_spi_test_pkt_xfer_cases[] = {
+	KUNIT_CASE(cros_ec_spi_test_pkt_xfer_normal),
+	{}
+};
+
+static struct kunit_suite cros_ec_spi_test_pkt_xfer_suite = {
+	.name = "cros_ec_spi_test_pkt_xfer_suite",
+	.init = cros_ec_spi_test_pkt_xfer_init,
+	.exit = cros_ec_spi_test_exit,
+	.test_cases = cros_ec_spi_test_pkt_xfer_cases,
+};
+
+kunit_test_suites(
+	&cros_ec_spi_test_cmd_xfer_suite,
+	&cros_ec_spi_test_pkt_xfer_suite,
+);
+
+MODULE_LICENSE("GPL");
-- 
2.49.0.1101.gccaa498523-goog


