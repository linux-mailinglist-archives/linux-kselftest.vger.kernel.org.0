Return-Path: <linux-kselftest+bounces-33372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCB5ABD1D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2972F8A13E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08993265609;
	Tue, 20 May 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrejAkOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC1264F9F;
	Tue, 20 May 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729519; cv=none; b=MxiTvNVxa1MatBTN317xBbxq9cggeh94yHqHxLRpm57AOTYBKucvGXkk/g1S02EKOajoDmhJLEcrFzYdLUXtOVxM/lgIVSUTGFOyoGQ0iXHSUPQqC2fLuKg4UJ3Ugsw6F9sMpyQu0DiZ9kw0oUm/2siccdeFUZfSdXf6NenjEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729519; c=relaxed/simple;
	bh=knILOCtQNGTaQcP/xzsYnjivS1CVRek5fFnGxHke0Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmcfdmY1ETTG7Mw08CxZ41uqYBIKVPX8nbzx+GLRJEjiX2pEoJlunjlSPhd4jDmgrzIxVtdaIRcOse5PEXowh19bTU6L81w70PcFsFvWdXdKW49YUBHZv77txNn6ujullUX+5XMkLZYrkU48b6uqUNrkJ9TivEyBVL7OHWzZyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrejAkOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D1EC4CEF2;
	Tue, 20 May 2025 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729519;
	bh=knILOCtQNGTaQcP/xzsYnjivS1CVRek5fFnGxHke0Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrejAkOfewqIy4AhB4I0JPfDy+t1hfnEMabu75VOwLXXaxy0asR9U9sA1GJ1h0Khp
	 1GzX8zG2P0pPSn56ppD5jwCeUykEGqMIF4r8FxSXBzQ8rYWU5Wq3EhGMrIUGcOtRaZ
	 niA3MjU/VLOHnz5m/Kd3lXvXJuEZH9e4/e2fyCEurCTFEufDJeia46nrUMp3hATops
	 MpE4B7XFRGLZpdFOyptQnV5T3Xzby5jVkZzF6jFoDhoeqJrchdTYUHHs3oXDqmUdjq
	 SwonEXGGOUaiUnq4FQ/kh4AbebmOnPTw1NsbL+nzJYu67FeZ7B+UA776f4C+7pqYm6
	 Bsib8KP3+4dDA==
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
Subject: [RFC PATCH 2/7] platform/chrome: kunit: cros_ec_i2c: Add tests with ftrace stub
Date: Tue, 20 May 2025 08:24:29 +0000
Message-ID: <20250520082435.2255639-3-tzungbi@kernel.org>
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
	--kconfig_add CONFIG_CHROME_PLATFORMS=y \
	--kconfig_add CONFIG_CROS_EC=y \
	--kconfig_add CONFIG_FTRACE=y \
	--kconfig_add CONFIG_FUNCTION_TRACER=y \
	--kconfig_add CONFIG_MODULES=y \
	--kconfig_add CONFIG_DEBUG_KERNEL=y \
	--kconfig_add CONFIG_KALLSYMS_ALL=y \
	--kconfig_add CONFIG_LIVEPATCH=y \
	--kconfig_add CONFIG_KUNIT_FTRACE_STUBS=y \
	--kconfig_add CONFIG_I2C=y \
	--kconfig_add CONFIG_CROS_EC_I2C=y \
	--kconfig_add CONFIG_CROS_KUNIT_EC_I2C_TEST=y \
	cros_ec_i2c*

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/Kconfig            |   9 +
 drivers/platform/chrome/Makefile           |   1 +
 drivers/platform/chrome/cros_ec_i2c_test.c | 479 +++++++++++++++++++++
 3 files changed, 489 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_i2c_test.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 10941ac37305..5e0b44fb7ca7 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -327,4 +327,13 @@ config CROS_KUNIT_EC_PROTO_TEST
 	help
 	  Kunit tests for ChromeOS EC protocol.
 
+config CROS_KUNIT_EC_I2C_TEST
+	tristate "Kunit tests for ChromeOS EC over I2C" if !KUNIT_ALL_TESTS
+	depends on KUNIT && CROS_EC
+	default KUNIT_ALL_TESTS
+	depends on KUNIT_FTRACE_STUBS
+	depends on CROS_EC_I2C
+	help
+	  Kunit tests for ChromeOS EC over I2C.
+
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index b981a1bb5bd8..9808f25aea38 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
 # Kunit test cases
 obj-$(CONFIG_CROS_KUNIT_EC_PROTO_TEST)	+= cros_kunit_proto_test.o
 cros_kunit_proto_test-objs		:= cros_ec_proto_test_util.o cros_ec_proto_test.o
+obj-$(CONFIG_CROS_KUNIT_EC_I2C_TEST)	+= cros_ec_i2c_test.o
diff --git a/drivers/platform/chrome/cros_ec_i2c_test.c b/drivers/platform/chrome/cros_ec_i2c_test.c
new file mode 100644
index 000000000000..3a7f1a17d82d
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_i2c_test.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit tests for ChromeOS Embedded Controller I2C interface.
+ */
+#include <kunit/test.h>
+#include <kunit/ftrace_stub.h>
+
+#include <linux/i2c.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/sched.h>
+
+#include "cros_ec.h"
+
+#define BUFSIZE 128
+#define I2C_ADDR 0x06
+
+struct cros_ec_i2c_test_priv {
+	struct i2c_adapter *fake_adap;
+	struct i2c_client *client;
+
+	int fake_cros_ec_register_called;
+	struct cros_ec_device *ec_dev;
+
+	int fake_cros_ec_unregister_called;
+
+	struct i2c_msg *i2c_msgs;
+	int i2c_msg_num;
+	int fake_i2c_xfer_res;
+	int fake_i2c_xfer_len;
+	u8 *fake_i2c_xfer_data;
+	u8 fake_i2c_xfer_sum;
+	int fake_i2c_xfer_ret;
+};
+
+static int fake_cros_ec_register(struct cros_ec_device *ec_dev)
+{
+	struct kunit *test = current->kunit_test;
+	struct cros_ec_i2c_test_priv *priv = test->priv;
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
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+
+	priv->fake_cros_ec_unregister_called += 1;
+}
+
+static int fake_cros_ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct kunit *test = current->kunit_test;
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	int i;
+
+	priv->i2c_msgs = kunit_kmalloc_array(test, sizeof(struct i2c_msg), num, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->i2c_msgs);
+
+	for (i = 0; i < num; ++i) {
+		memcpy(priv->i2c_msgs + i, msgs + i, sizeof(struct i2c_msg));
+
+		priv->i2c_msgs[i].buf = kunit_kmalloc(test, msgs[i].len, GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, priv->i2c_msgs[i].buf);
+		memcpy(priv->i2c_msgs[i].buf, msgs[i].buf, msgs[i].len);
+
+		if (msgs[i].flags == I2C_M_RD) {
+			msgs[i].buf[0] = priv->fake_i2c_xfer_res;
+			msgs[i].buf[1] = priv->fake_i2c_xfer_len;
+
+			if (priv->fake_i2c_xfer_data)
+				memcpy(&msgs[i].buf[2], priv->fake_i2c_xfer_data,
+				       priv->fake_i2c_xfer_len);
+
+			msgs[i].buf[priv->fake_i2c_xfer_len + 2] = priv->fake_i2c_xfer_sum;
+		}
+	}
+	priv->i2c_msg_num = num;
+
+	return priv->fake_i2c_xfer_ret;
+}
+
+static u32 fake_cros_ec_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm fake_cros_ec_i2c_algorithm = {
+	.master_xfer = fake_cros_ec_i2c_xfer,
+	.functionality = fake_cros_ec_i2c_functionality,
+};
+
+static int cros_ec_i2c_test_init(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv;
+	static const struct i2c_board_info board_info = {
+		I2C_BOARD_INFO("cros-ec-i2c", I2C_ADDR),
+	};
+
+	kunit_activate_ftrace_stub(test, cros_ec_register, fake_cros_ec_register);
+	kunit_activate_ftrace_stub(test, cros_ec_unregister, fake_cros_ec_unregister);
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+	test->priv = priv;
+
+	priv->fake_adap = kunit_kzalloc(test, sizeof(*priv->fake_adap), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->fake_adap);
+
+	priv->fake_adap->owner = THIS_MODULE;
+	strscpy(priv->fake_adap->name, "cros-ec-i2c-test");
+	priv->fake_adap->algo = &fake_cros_ec_i2c_algorithm;
+	priv->fake_adap->retries = 3;
+
+	KUNIT_ASSERT_EQ(test, i2c_add_adapter(priv->fake_adap), 0);
+
+	priv->client = i2c_new_client_device(priv->fake_adap, &board_info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->client);
+	KUNIT_EXPECT_EQ(test, priv->client->addr, I2C_ADDR);
+
+	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_register_called, 1);
+	KUNIT_ASSERT_NOT_NULL(test, priv->ec_dev);
+	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_unregister_called, 0);
+	return 0;
+}
+
+static void cros_ec_i2c_test_exit(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+
+	i2c_unregister_device(priv->client);
+	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_unregister_called, 1);
+
+	i2c_del_adapter(priv->fake_adap);
+
+	kunit_deactivate_ftrace_stub(test, cros_ec_register);
+	kunit_deactivate_ftrace_stub(test, cros_ec_unregister);
+}
+
+static int cros_ec_i2c_test_cmd_xfer_init(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv;
+
+	cros_ec_i2c_test_init(test);
+	priv = test->priv;
+	priv->ec_dev->proto_version = 2;
+	return 0;
+}
+
+static void cros_ec_i2c_test_cmd_xfer_normal(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command *msg;
+	int ret, i;
+	u8 sum;
+
+	msg = kunit_kmalloc(test, sizeof(*msg) + 2 /* max(outsize, insize) */, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, msg);
+	msg->version = 0x1000;
+	msg->command = 0x1001;
+	msg->outsize = 2;
+	msg->insize = 1;
+	msg->data[0] = 0xbe;
+	msg->data[1] = 0xef;
+
+	priv->fake_i2c_xfer_res = 0;
+	priv->fake_i2c_xfer_data = kunit_kmalloc(test, msg->insize, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->fake_i2c_xfer_data);
+	priv->fake_i2c_xfer_data[0] = 0xaa;
+	priv->fake_i2c_xfer_len = msg->insize;
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+	sum = priv->fake_i2c_xfer_res + priv->fake_i2c_xfer_len + priv->fake_i2c_xfer_data[0];
+	priv->fake_i2c_xfer_sum = sum;
+
+	ret = priv->ec_dev->cmd_xfer(priv->ec_dev, msg);
+	KUNIT_EXPECT_EQ(test, ret, 1 /* insize */);
+	KUNIT_EXPECT_EQ(test, msg->result, 0);
+	KUNIT_EXPECT_EQ(test, msg->data[0], 0xaa);
+
+	KUNIT_EXPECT_EQ(test, priv->i2c_msg_num, 2);
+	/*
+	 * Validate output message only which is supposed to be received by EC devices.
+	 */
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].addr, I2C_ADDR);
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].flags, 0);
+	/*
+	 * Total length of the message: EC_MSG_TX_HEADER_BYTES (version, command, length) +
+	 * outsize + EC_MSG_TX_TRAILER_BYTES (checksum).
+	 */
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].len, EC_MSG_TX_PROTO_BYTES + 2 /* outsize */);
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].buf[0], (u8)(EC_CMD_VERSION0 + 0x1000));
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].buf[1], (u8)0x1001);
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].buf[2], 2 /* outsize */);
+	for (sum = 0, i = 0; i < EC_MSG_TX_HEADER_BYTES + 2 /* outsize */; ++i)
+		sum += priv->i2c_msgs[0].buf[i];
+	KUNIT_EXPECT_EQ(test,
+			priv->i2c_msgs[0].buf[EC_MSG_TX_HEADER_BYTES + 2 /* outsize */], sum);
+}
+
+static void cros_ec_i2c_test_cmd_xfer_error(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	int ret;
+
+	priv->fake_i2c_xfer_ret = -EBUSY;
+	ret = priv->ec_dev->cmd_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+
+	priv->fake_i2c_xfer_ret = 1;
+	ret = priv->ec_dev->cmd_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+	priv->fake_i2c_xfer_res = EC_RES_IN_PROGRESS;
+	ret = priv->ec_dev->cmd_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
+}
+
+static void cros_ec_i2c_test_cmd_xfer_response_too_long(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	int ret;
+
+	priv->fake_i2c_xfer_res = 0;
+	priv->fake_i2c_xfer_data = kunit_kmalloc(test, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->fake_i2c_xfer_data);
+	priv->fake_i2c_xfer_len = msg.insize + 1; /* make it greater than msg.insize */
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+
+	ret = priv->ec_dev->cmd_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -ENOSPC);
+}
+
+static void cros_ec_i2c_test_cmd_xfer_response_bad_checksum(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	int ret;
+
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+	priv->fake_i2c_xfer_sum = (u8)0xbad;
+
+	ret = priv->ec_dev->cmd_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EBADMSG);
+}
+
+static struct kunit_case cros_ec_i2c_test_cmd_xfer_cases[] = {
+	KUNIT_CASE(cros_ec_i2c_test_cmd_xfer_normal),
+	KUNIT_CASE(cros_ec_i2c_test_cmd_xfer_error),
+	KUNIT_CASE(cros_ec_i2c_test_cmd_xfer_response_too_long),
+	KUNIT_CASE(cros_ec_i2c_test_cmd_xfer_response_bad_checksum),
+	{},
+};
+
+static struct kunit_suite cros_ec_i2c_test_cmd_xfer_suite = {
+	.name = "cros_ec_i2c_test_cmd_xfer_suite",
+	.init = cros_ec_i2c_test_cmd_xfer_init,
+	.exit = cros_ec_i2c_test_exit,
+	.test_cases = cros_ec_i2c_test_cmd_xfer_cases,
+};
+
+static int cros_ec_i2c_test_pkt_xfer_init(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv;
+
+	cros_ec_i2c_test_init(test);
+	priv = test->priv;
+	priv->ec_dev->proto_version = 3;
+	return 0;
+}
+
+static void cros_ec_i2c_test_pkt_xfer_normal(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command *msg;
+	struct ec_host_request *request;
+	struct ec_host_response *response;
+	int ret, i;
+	u8 sum;
+
+	msg = kunit_kmalloc(test, sizeof(*msg) + 2 /* max(outsize, insize) */, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, msg);
+	msg->version = 0x1000;
+	msg->command = 0x1001;
+	msg->outsize = 2;
+	msg->insize = 1;
+	msg->data[0] = 0xbe;
+	msg->data[1] = 0xef;
+
+	priv->fake_i2c_xfer_res = 0;
+	priv->fake_i2c_xfer_len = sizeof(*response) + msg->insize;
+	priv->fake_i2c_xfer_data = kunit_kzalloc(test, priv->fake_i2c_xfer_len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->fake_i2c_xfer_data);
+	response = (struct ec_host_response *)priv->fake_i2c_xfer_data;
+	response->struct_version = EC_HOST_RESPONSE_VERSION;
+	response->data_len = msg->insize;
+	priv->fake_i2c_xfer_data[sizeof(*response)] = 0xaa;
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+	for (sum = 0, i = 0; i < priv->fake_i2c_xfer_len; ++i)
+		sum += priv->fake_i2c_xfer_data[i];
+	response->checksum = -sum;
+
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, msg);
+	KUNIT_EXPECT_EQ(test, ret, 1 /* insize */);
+	KUNIT_EXPECT_EQ(test, msg->result, 0);
+	KUNIT_EXPECT_EQ(test, msg->data[0], 0xaa);
+
+	KUNIT_EXPECT_EQ(test, priv->i2c_msg_num, 2);
+	/*
+	 * Validate output message only which is supposed to be received by EC devices.
+	 */
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].addr, I2C_ADDR);
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].flags, 0);
+	/*
+	 * Total length of the message: sizeof(struct ec_host_request_i2c) + outsize.
+	 * The test can't access struct ec_host_request_i2c directly (in cros_ec_i2c.c).
+	 * However, it is a {u8 + struct ec_host_request} struct.
+	 */
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].len, 1 + sizeof(*request) + 2 /* outsize */);
+	/*
+	 * i2c_msgs[0].buf is a struct ec_host_request_i2c.  Again, the test can't access the
+	 * struct directly.  Access the u8 and struct ec_host_request separately.
+	 */
+	KUNIT_EXPECT_EQ(test, priv->i2c_msgs[0].buf[0], EC_COMMAND_PROTOCOL_3);
+	request = (struct ec_host_request *)&priv->i2c_msgs[0].buf[1];
+	KUNIT_EXPECT_EQ(test, request->struct_version, EC_HOST_REQUEST_VERSION);
+	KUNIT_EXPECT_EQ(test, request->command, 0x1001);
+	KUNIT_EXPECT_EQ(test, request->command_version, (u8)0x1000);
+	KUNIT_EXPECT_EQ(test, request->data_len, 2 /* outsize */);
+	for (sum = 0, i = 0; i < sizeof(*request); ++i)
+		sum += ((u8 *)request)[i];
+	sum += 0xbe + 0xef;
+	KUNIT_EXPECT_EQ(test, sum, 0);
+}
+
+static void cros_ec_i2c_test_pkt_xfer_msg_too_long(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {
+		.insize = 10,
+		.outsize = 10,
+	};
+	int ret;
+
+	priv->ec_dev->din_size = 0;
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	priv->ec_dev->din_size = BUFSIZE;
+	priv->ec_dev->dout_size = 0;
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static void cros_ec_i2c_test_pkt_xfer_error(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	int ret;
+
+	priv->fake_i2c_xfer_ret = -EBUSY;
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+
+	priv->fake_i2c_xfer_ret = 1;
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+}
+
+static void cros_ec_i2c_test_pkt_xfer_in_progress(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	int ret;
+
+	priv->fake_i2c_xfer_res = EC_RES_IN_PROGRESS;
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
+}
+
+static void cros_ec_i2c_test_pkt_xfer_to_v2_proto(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	int ret;
+
+	priv->fake_i2c_xfer_res = EC_RES_INVALID_COMMAND;
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EPROTONOSUPPORT);
+}
+
+static void cros_ec_i2c_test_pkt_xfer_response_too_short(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	int ret;
+
+	priv->fake_i2c_xfer_len = sizeof(struct ec_host_response) - 1; /* make it shorter */
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EBADMSG);
+}
+
+static void cros_ec_i2c_test_pkt_xfer_response_too_long(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	struct ec_host_response *response;
+	int ret;
+
+	priv->fake_i2c_xfer_len = sizeof(*response);
+	priv->fake_i2c_xfer_data = kunit_kzalloc(test, priv->fake_i2c_xfer_len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->fake_i2c_xfer_data);
+	response = (struct ec_host_response *)priv->fake_i2c_xfer_data;
+	response->struct_version = EC_HOST_RESPONSE_VERSION;
+	response->data_len = 100;
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
+}
+
+static void cros_ec_i2c_test_pkt_xfer_bad_checksum(struct kunit *test)
+{
+	struct cros_ec_i2c_test_priv *priv = test->priv;
+	struct cros_ec_command msg = {};
+	struct ec_host_response *response;
+	int ret;
+
+	priv->fake_i2c_xfer_len = sizeof(*response);
+	priv->fake_i2c_xfer_data = kunit_kzalloc(test, priv->fake_i2c_xfer_len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->fake_i2c_xfer_data);
+	response = (struct ec_host_response *)priv->fake_i2c_xfer_data;
+	response->struct_version = EC_HOST_RESPONSE_VERSION;
+	response->checksum = (u8)0xbad;
+	priv->fake_i2c_xfer_ret = 2 /* # of i2c_msg */;
+
+	ret = priv->ec_dev->pkt_xfer(priv->ec_dev, &msg);
+	KUNIT_EXPECT_EQ(test, ret, -EBADMSG);
+}
+
+static struct kunit_case cros_ec_i2c_test_pkt_xfer_cases[] = {
+	KUNIT_CASE(cros_ec_i2c_test_pkt_xfer_normal),
+	KUNIT_CASE(cros_ec_i2c_test_pkt_xfer_msg_too_long),
+	KUNIT_CASE(cros_ec_i2c_test_pkt_xfer_error),
+	KUNIT_CASE(cros_ec_i2c_test_pkt_xfer_in_progress),
+	KUNIT_CASE(cros_ec_i2c_test_pkt_xfer_to_v2_proto),
+	KUNIT_CASE(cros_ec_i2c_test_pkt_xfer_response_too_short),
+	KUNIT_CASE(cros_ec_i2c_test_pkt_xfer_response_too_long),
+	KUNIT_CASE(cros_ec_i2c_test_pkt_xfer_bad_checksum),
+	{},
+};
+
+static struct kunit_suite cros_ec_i2c_test_pkt_xfer_suite = {
+	.name = "cros_ec_i2c_test_pkt_xfer_suite",
+	.init = cros_ec_i2c_test_pkt_xfer_init,
+	.exit = cros_ec_i2c_test_exit,
+	.test_cases = cros_ec_i2c_test_pkt_xfer_cases,
+};
+
+kunit_test_suites(
+	&cros_ec_i2c_test_cmd_xfer_suite,
+	&cros_ec_i2c_test_pkt_xfer_suite,
+);
+
+MODULE_LICENSE("GPL");
-- 
2.49.0.1101.gccaa498523-goog


