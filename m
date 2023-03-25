Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D76C89A1
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 01:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjCYA1t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 20:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjCYA1l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 20:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A01216317;
        Fri, 24 Mar 2023 17:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 679D062CF9;
        Sat, 25 Mar 2023 00:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB3EC4339B;
        Sat, 25 Mar 2023 00:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679704049;
        bh=wyNzs9+T4TyTUveC2AG8JrzhOfbyVA0mVx0XwJQWyR8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WIn1LBinv3V3T/MNmMcNGUKVyJmZhS9Kyg+lR3NNk3uS7hn3DoyUGeYA0Xvv0xlrF
         ZI6//tDvhHQScbJU4s8mg8OUlEeRXcQ6sJ8imYmAJ3nU4eWacHJtcvUiLk3Nn97Zrg
         PdsbYmUHsb7T47EYb1EIYczomrIhuVBkCspVwlcSCWjmZIskQPs5mzjjEpU1Py6bUv
         5e73+croBMf54a0VApkSTpPmR4dkf0aQCxZFHB34IFpVtlxdJwxNTFhDvoytLC1mjL
         VBVYbaDUKXZ+cX19AF7ZEzJKvYaLdMpINUAG8RFpX8tJBWm5eTws/i3VwpTeMitBBL
         U5cGa61RWOOig==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 25 Mar 2023 00:27:17 +0000
Subject: [PATCH 1/2] regmap: Add RAM backed register map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-regmap-kunit-v1-1-62ef9cfa9b89@kernel.org>
References: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org>
In-Reply-To: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=4600; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wyNzs9+T4TyTUveC2AG8JrzhOfbyVA0mVx0XwJQWyR8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHj/rlabPE/xfbKcOr64yF5y9tx55d09fMVQozH8m
 6S72S5yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZB4/6wAKCRAk1otyXVSH0Jt2B/
 4/sh9njhXJ8E7Kp5vUupdHqBkj5vZCP3gIm6He5dSWxc2lvW6guhtfTTlg1DBf4rFFe3asaWmcxAyw
 4BEaHEww9BXVMe7QYOZTpmO1X5Si3ljpD4QPrWPXWRv0kdyvcI4IF4vYyb6+yWZAKUHADkSOtrKNyg
 ZHcy+cz34nTg3OPq7cM1H6IyKoR1SFAHhH/10Hkt+lpvnVBvJcSBGBoJUptmlPrlcDLW5MmQZEprOU
 Cl5NvnWwPNNGiKuByVlpRPx/t5eoe7ovHGOlEzqDl9ymVUEW1iCkcuc2YYfxqgkNvqS72iTPSe4Ncn
 6WQbmMSzaajdjPprq7n3NPoh105JhP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a register map that is a simple array of memory, for use in
KUnit testing of the framework. This is not exposed in regmap.h
since I can't think of a non-test use case, it is purely for use
internally. To facilitate testing we track if registers have been
read or written to.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/Kconfig      |  3 ++
 drivers/base/regmap/Makefile     |  1 +
 drivers/base/regmap/internal.h   | 19 +++++++++
 drivers/base/regmap/regmap-ram.c | 85 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index cd4bb642b9de..65ce888d7c04 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -46,6 +46,9 @@ config REGMAP_MMIO
 config REGMAP_IRQ
 	bool
 
+config REGMAP_RAM
+	tristate
+
 config REGMAP_SOUNDWIRE
 	tristate
 	depends on SOUNDWIRE
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 6990de7ca9a9..5ef6f129497c 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_REGCACHE_COMPRESSED) += regcache-lzo.o
 obj-$(CONFIG_DEBUG_FS) += regmap-debugfs.o
 obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
 obj-$(CONFIG_REGMAP_I2C) += regmap-i2c.o
+obj-$(CONFIG_REGMAP_RAM) += regmap-ram.o
 obj-$(CONFIG_REGMAP_SLIMBUS) += regmap-slimbus.o
 obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index da8996e7a1f1..aa98a5284fb3 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -307,4 +307,23 @@ static inline unsigned int regcache_get_index_by_order(const struct regmap *map,
 	return reg >> map->reg_stride_order;
 }
 
+struct regmap_ram_data {
+	unsigned int *vals;  /* Allocatd by caller */
+	bool *read;
+	bool *written;
+};
+
+/*
+ * Create a test register map with data stored in RAM, not intended
+ * for practical use.
+ */
+struct regmap *__regmap_init_ram(const struct regmap_config *config,
+				 struct regmap_ram_data *data,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
+
+#define regmap_init_ram(config, data)					\
+	__regmap_lockdep_wrapper(__regmap_init_ram, #config, config, data)
+
+
 #endif
diff --git a/drivers/base/regmap/regmap-ram.c b/drivers/base/regmap/regmap-ram.c
new file mode 100644
index 000000000000..85f34a5dee04
--- /dev/null
+++ b/drivers/base/regmap/regmap-ram.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - Memory region
+//
+// This is intended for testing only
+//
+// Copyright (c) 2023, Arm Ltd
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/swab.h>
+
+#include "internal.h"
+
+static int regmap_ram_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct regmap_ram_data *data = context;
+
+	data->vals[reg] = val;
+	data->written[reg] = true;
+
+	return 0;
+}
+
+static int regmap_ram_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct regmap_ram_data *data = context;
+
+	*val = data->vals[reg];
+	data->read[reg] = true;
+
+	return 0;
+}
+
+static void regmap_ram_free_context(void *context)
+{
+	struct regmap_ram_data *data = context;
+
+	kfree(data->vals);
+	kfree(data->read);
+	kfree(data->written);
+	kfree(data);
+}
+
+static const struct regmap_bus regmap_ram = {
+	.fast_io = true,
+	.reg_write = regmap_ram_write,
+	.reg_read = regmap_ram_read,
+	.free_context = regmap_ram_free_context,
+};
+
+struct regmap *__regmap_init_ram(const struct regmap_config *config,
+				 struct regmap_ram_data *data,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name)
+{
+	struct regmap *map;
+
+	if (!config->max_register) {
+		pr_crit("No max_register specified for RAM regmap\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	data->read = kcalloc(sizeof(bool), config->max_register + 1,
+			     GFP_KERNEL);
+	if (!data->read)
+		return ERR_PTR(-ENOMEM);
+
+	data->written = kcalloc(sizeof(bool), config->max_register + 1,
+				GFP_KERNEL);
+	if (!data->written)
+		return ERR_PTR(-ENOMEM);
+
+	map = __regmap_init(NULL, &regmap_ram, data, config,
+			    lock_key, lock_name);
+
+	return map;
+}
+EXPORT_SYMBOL_GPL(__regmap_init_ram);
+
+MODULE_LICENSE("GPL v2");

-- 
2.34.1

