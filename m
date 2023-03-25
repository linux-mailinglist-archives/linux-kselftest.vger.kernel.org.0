Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AB96C89A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 01:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjCYA15 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 20:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjCYA1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 20:27:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6EC1CF60;
        Fri, 24 Mar 2023 17:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 209C1B82666;
        Sat, 25 Mar 2023 00:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458AFC433D2;
        Sat, 25 Mar 2023 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679704051;
        bh=T6cf5XyWoPcJpUilixagzzUODTnbuLbKC4Chfoxm99U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mLbmhBCtifY79ELWaFx1f3kYhvaJ99H+vvp1iXfZE3Fv3XTHW3GWba+VIsxbx1U81
         rnSBE2Y2nI1B1HYOQe2TgeL9uwMcD/c2zr/F8psMwFkIIEbG2NvNdY5FW0AJYMOZee
         mVJBosKjTKGqwill49CXQ5xsW8d0LIuT+yuo3RiBYqPdJ/4Q26vgCfokELMu/E4iDU
         jrB+PsQAMbmdNqQZaZWjHvO/vk2k8R4HCbf6XM36SWkDHjCXuY3+cAtSepND2S7sQt
         4ol9Z74D9S+iKPN5qEZlgzyvi3+fjeeEsD2LuG9KEm+/YYefwRYjQCqoV0s9odgf4Q
         hX0ajT1dWg/Gg==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 25 Mar 2023 00:27:18 +0000
Subject: [PATCH 2/2] regmap: Add some basic kunit tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-regmap-kunit-v1-2-62ef9cfa9b89@kernel.org>
References: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org>
In-Reply-To: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=20808; i=broonie@kernel.org;
 h=from:subject:message-id; bh=T6cf5XyWoPcJpUilixagzzUODTnbuLbKC4Chfoxm99U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHj/snB/0qL4t8ePoQDZx7k/nr2gO9noaEEE4M7T7
 tAQo1kiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZB4/7AAKCRAk1otyXVSH0OOQB/
 kB3T2NSYTiQVinX/RL45Q8hp2Tc+U9zn3Q0Q55MhYkLvl+nZ4vhk911pjx5ticIOZCIQPBBya8pV7g
 MXgVvTcO0W5OsGQVHMhHH3qsQ5RlvgraWk6NqclBypgXHHGRW4GbLUN4nFT9pUvqB4bHRWV9ahN5Cp
 WOi6DE7EsPN8qmoljy6ZiAdRe/75sMEkiOyDdvAzRBLpcgTngBj3jDwBH+3C8IkkuVNWfk7Q8E+cbN
 w9WFIwPafPd/T+qVY2WE2ECbEZVWYMtS124zRQb5eoPPxvTAyhmf9t+UZ5bJak5vv5+Ov47J8zx9j5
 mnUMJ0cmg9cbvmEtFmFp/N2KZpe3ac
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On the theory that it's better to make a start let's add some KUnit tests
for regmap. Currently this is a bit of a mess but it passes and hopefully
will at some point help catch problems. We provide very basic cover for
most of the core functionality that operates at the register level,
repeating each test for each cache type in order to exercise the caches.
There is no coverage of anything to do with the bulk operations at the bus
level or formatting for byte stream buses yet.

Each test creates it's own regmap since the cache structures are built
incrementally, meaning we gain coverage from the different access
patterns, and some of the tests cover different init scenarios.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/Kconfig        |   7 +
 drivers/base/regmap/Makefile       |   1 +
 drivers/base/regmap/regmap-kunit.c | 631 +++++++++++++++++++++++++++++++++++++
 3 files changed, 639 insertions(+)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 65ce888d7c04..6e77bf96569c 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -14,6 +14,13 @@ config REGCACHE_COMPRESSED
 	select LZO_DECOMPRESS
 	bool
 
+config REGMAP_KUNIT
+	tristate "KUnit tests for regmap"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select REGMAP
+	select REGMAP_RAM
+
 config REGMAP_AC97
 	tristate
 
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 5ef6f129497c..fe2775fc76c6 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_REGMAP) += regmap.o regcache.o
 obj-$(CONFIG_REGMAP) += regcache-rbtree.o regcache-flat.o
 obj-$(CONFIG_REGCACHE_COMPRESSED) += regcache-lzo.o
 obj-$(CONFIG_DEBUG_FS) += regmap-debugfs.o
+obj-$(CONFIG_REGMAP_KUNIT) += regmap-kunit.o
 obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
 obj-$(CONFIG_REGMAP_I2C) += regmap-i2c.o
 obj-$(CONFIG_REGMAP_RAM) += regmap-ram.o
diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
new file mode 100644
index 000000000000..137681f12bc3
--- /dev/null
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -0,0 +1,631 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// regmap KUnit tests
+//
+// Copyright 2023 Arm Ltd
+
+#include <kunit/test.h>
+#include "internal.h"
+
+#define BLOCK_TEST_SIZE 12
+
+static const struct regmap_config test_regmap_config = {
+	.max_register = BLOCK_TEST_SIZE,
+	.reg_stride = 1,
+	.val_bits = sizeof(unsigned int) * 8,
+};
+
+struct regcache_types {
+	enum regcache_type type;
+	const char *name;
+};
+
+static void case_to_desc(const struct regcache_types *t, char *desc)
+{
+	strcpy(desc, t->name);
+}
+
+static const struct regcache_types regcache_types_list[] = {
+	{ REGCACHE_NONE, "none" },
+	{ REGCACHE_FLAT, "flat" },
+	{ REGCACHE_RBTREE, "rbtree" },
+};
+
+KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, case_to_desc);
+
+static const struct regcache_types real_cache_types_list[] = {
+	{ REGCACHE_FLAT, "flat" },
+	{ REGCACHE_RBTREE, "rbtree" },
+};
+
+KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, case_to_desc);
+
+static struct regmap *gen_regmap(struct regmap_config *config,
+				 struct regmap_ram_data **data)
+{
+	unsigned int *buf;
+	struct regmap *ret;
+	size_t size = (config->max_register + 1) * sizeof(unsigned int);
+	int i;
+	struct reg_default *defaults;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	get_random_bytes(buf, size);
+
+	*data = kzalloc(sizeof(**data), GFP_KERNEL);
+	if (!(*data))
+		return ERR_PTR(-ENOMEM);
+	(*data)->vals = buf;
+
+	if (config->num_reg_defaults) {
+		defaults = kcalloc(config->num_reg_defaults,
+				   sizeof(struct reg_default),
+				   GFP_KERNEL);
+		if (!defaults)
+			return ERR_PTR(-ENOMEM);
+		config->reg_defaults = defaults;
+
+		for (i = 0; i < config->num_reg_defaults; i++) {
+			defaults[i].reg = i * config->reg_stride;
+			defaults[i].def = buf[i * config->reg_stride];
+		}
+	}
+
+	ret = regmap_init_ram(config, *data);
+	if (IS_ERR(ret)) {
+		kfree(buf);
+		kfree(*data);
+	}
+
+	return ret;
+}
+
+static void basic_read_write(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val, rval;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* If we write a value to a register we can read it back */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, val));
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
+	KUNIT_EXPECT_EQ(test, val, rval);
+
+	/* If using a cache the cache satisfied the read */
+	KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[0]);
+
+	regmap_exit(map);
+}
+
+static void bulk_write(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val[BLOCK_TEST_SIZE], rval[BLOCK_TEST_SIZE];
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/*
+	 * Data written via the bulk API can be read back with single
+	 * reads.
+	 */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, 0, val,
+						   BLOCK_TEST_SIZE));
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval[i]));
+
+	KUNIT_EXPECT_MEMEQ(test, val, rval, sizeof(val));
+
+	/* If using a cache the cache satisfied the read */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+
+	regmap_exit(map);
+}
+
+static void bulk_read(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val[BLOCK_TEST_SIZE], rval[BLOCK_TEST_SIZE];
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Data written as single writes can be read via the bulk API */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, i, val[i]));
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, 0, rval,
+						  BLOCK_TEST_SIZE));
+	KUNIT_EXPECT_MEMEQ(test, val, rval, sizeof(val));
+
+	/* If using a cache the cache satisfied the read */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+
+	regmap_exit(map);
+}
+
+static void reg_defaults(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int rval[BLOCK_TEST_SIZE];
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.num_reg_defaults = BLOCK_TEST_SIZE;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Read back the expected default data */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, 0, rval,
+						  BLOCK_TEST_SIZE));
+	KUNIT_EXPECT_MEMEQ(test, data->vals, rval, sizeof(rval));
+
+	/* The data should have been read from cache if there was one */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+}
+
+static void reg_defaults_read_dev(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int rval[BLOCK_TEST_SIZE];
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.num_reg_defaults_raw = BLOCK_TEST_SIZE;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* We should have read the cache defaults back from the map */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
+		KUNIT_EXPECT_EQ(test, t->type != REGCACHE_NONE, data->read[i]);
+		data->read[i] = false;
+	}
+
+	/* Read back the expected default data */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, 0, rval,
+						  BLOCK_TEST_SIZE));
+	KUNIT_EXPECT_MEMEQ(test, data->vals, rval, sizeof(rval));
+
+	/* The data should have been read from cache if there was one */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+}
+
+static void register_patch(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	struct reg_sequence patch[2];
+	unsigned int rval[BLOCK_TEST_SIZE];
+	int i;
+
+	/* We need defaults so readback works */
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.num_reg_defaults = BLOCK_TEST_SIZE;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Stash the original values */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, 0, rval,
+						  BLOCK_TEST_SIZE));
+
+	/* Patch a couple of values */
+	patch[0].reg = 2;
+	patch[0].def = rval[2] + 1;
+	patch[0].delay_us = 0;
+	patch[1].reg = 5;
+	patch[1].def = rval[5] + 1;
+	patch[1].delay_us = 0;
+	KUNIT_EXPECT_EQ(test, 0, regmap_register_patch(map, patch,
+						       ARRAY_SIZE(patch)));
+
+	/* Only the patched registers are written */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
+		switch (i) {
+		case 2:
+		case 5:
+			KUNIT_EXPECT_TRUE(test, data->written[i]);
+			KUNIT_EXPECT_EQ(test, data->vals[i], rval[i] + 1);
+			break;
+		default:
+			KUNIT_EXPECT_FALSE(test, data->written[i]);
+			KUNIT_EXPECT_EQ(test, data->vals[i], rval[i]);
+			break;
+		}
+	}
+
+	regmap_exit(map);
+}
+
+static void stride(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int rval;
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.reg_stride = 2;
+	config.num_reg_defaults = BLOCK_TEST_SIZE / 2;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Only even registers can be accessed, try both read and write */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
+		data->read[i] = false;
+		data->written[i] = false;
+
+		if (i % 2) {
+			KUNIT_EXPECT_NE(test, 0, regmap_read(map, i, &rval));
+			KUNIT_EXPECT_NE(test, 0, regmap_write(map, i, rval));
+			KUNIT_EXPECT_FALSE(test, data->read[i]);
+			KUNIT_EXPECT_FALSE(test, data->written[i]);
+		} else {
+			KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval));
+			KUNIT_EXPECT_EQ(test, data->vals[i], rval);
+			KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE,
+					data->read[i]);
+
+			KUNIT_EXPECT_EQ(test, 0, regmap_write(map, i, rval));
+			KUNIT_EXPECT_TRUE(test, data->written[i]);
+		}
+	}
+
+	regmap_exit(map);
+}
+
+static struct regmap_range_cfg test_range = {
+	.selector_reg = 1,
+	.selector_mask = 0xff,
+
+	.window_start = 4,
+	.window_len = 10,
+
+	.range_min = 20,
+	.range_max = 40,
+};
+
+static bool test_range_volatile(struct device *dev, unsigned int reg)
+{
+	if (reg >= test_range.window_start &&
+	    reg <= test_range.selector_reg + test_range.window_len)
+		return true;
+
+	if (reg >= test_range.range_min && reg <= test_range.range_max)
+		return true;
+
+	return false;
+}
+
+static void basic_ranges(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val;
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.volatile_reg = test_range_volatile;
+	config.ranges = &test_range;
+	config.num_ranges = 1;
+	config.max_register = test_range.range_max;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	for (i = test_range.range_min; i < test_range.range_max; i++) {
+		data->read[i] = false;
+		data->written[i] = false;
+	}
+
+	/* Reset the page to a non-zero value to trigger a change */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, test_range.selector_reg,
+					      test_range.range_max));
+
+	/* Check we set the page and use the window for writes */
+	data->written[test_range.selector_reg] = false;
+	data->written[test_range.window_start] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, test_range.range_min, 0));
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.selector_reg]);
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.window_start]);
+
+	data->written[test_range.selector_reg] = false;
+	data->written[test_range.window_start] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map,
+					      test_range.range_min +
+					      test_range.window_len,
+					      0));
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.selector_reg]);
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.window_start]);
+
+	/* Same for reads */
+	data->written[test_range.selector_reg] = false;
+	data->read[test_range.window_start] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, test_range.range_min, &val));
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.selector_reg]);
+	KUNIT_EXPECT_TRUE(test, data->read[test_range.window_start]);
+
+	data->written[test_range.selector_reg] = false;
+	data->read[test_range.window_start] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map,
+					     test_range.range_min +
+					     test_range.window_len,
+					     &val));
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.selector_reg]);
+	KUNIT_EXPECT_TRUE(test, data->read[test_range.window_start]);
+
+	/* No physical access triggered in the virtual range */
+	for (i = test_range.range_min; i < test_range.range_max; i++) {
+		KUNIT_EXPECT_FALSE(test, data->read[i]);
+		KUNIT_EXPECT_FALSE(test, data->written[i]);
+	}
+
+	regmap_exit(map);
+}
+
+static void cache_bypass(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val, rval;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Ensure the cache has a value in it */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, val));
+
+	/* Bypass then write a different value */
+	regcache_cache_bypass(map, true);
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, val + 1));
+
+	/* Read the bypassed value */
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
+	KUNIT_EXPECT_EQ(test, val + 1, rval);
+	KUNIT_EXPECT_EQ(test, data->vals[0], rval);
+
+	/* Disable bypass, the cache should still return the original value */
+	regcache_cache_bypass(map, false);
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
+	KUNIT_EXPECT_EQ(test, val, rval);
+
+	regmap_exit(map);
+}
+
+static void cache_sync(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val[BLOCK_TEST_SIZE];
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Put some data into the cache */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, 0, val,
+						   BLOCK_TEST_SIZE));
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[i] = false;
+
+	/* Trash the data on the device itself then resync */
+	regcache_mark_dirty(map);
+	memset(data->vals, 0, sizeof(val));
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+
+	/* Did we just write the correct data out? */
+	KUNIT_EXPECT_MEMEQ(test, data->vals, val, sizeof(val));
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, true, data->written[i]);
+
+	regmap_exit(map);
+}
+
+static void cache_sync_defaults(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val;
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.num_reg_defaults = BLOCK_TEST_SIZE;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Change the value of one register */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 2, val));
+
+	/* Resync */
+	regcache_mark_dirty(map);
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[i] = false;
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+
+	/* Did we just sync the one register we touched? */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, i == 2, data->written[i]);
+
+	regmap_exit(map);
+}
+
+static void cache_sync_patch(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	struct reg_sequence patch[2];
+	unsigned int rval[BLOCK_TEST_SIZE], val;
+	int i;
+
+	/* We need defaults so readback works */
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.num_reg_defaults = BLOCK_TEST_SIZE;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Stash the original values */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, 0, rval,
+						  BLOCK_TEST_SIZE));
+
+	/* Patch a couple of values */
+	patch[0].reg = 2;
+	patch[0].def = rval[2] + 1;
+	patch[0].delay_us = 0;
+	patch[1].reg = 5;
+	patch[1].def = rval[5] + 1;
+	patch[1].delay_us = 0;
+	KUNIT_EXPECT_EQ(test, 0, regmap_register_patch(map, patch,
+						       ARRAY_SIZE(patch)));
+
+	/* Sync the cache */
+	regcache_mark_dirty(map);
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[i] = false;
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+
+	/* The patch should be on the device but not in the cache */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &val));
+		KUNIT_EXPECT_EQ(test, val, rval[i]);
+
+		switch (i) {
+		case 2:
+		case 5:
+			KUNIT_EXPECT_EQ(test, true, data->written[i]);
+			KUNIT_EXPECT_EQ(test, data->vals[i], rval[i] + 1);
+			break;
+		default:
+			KUNIT_EXPECT_EQ(test, false, data->written[i]);
+			KUNIT_EXPECT_EQ(test, data->vals[i], rval[i]);
+			break;
+		}
+	}
+
+	regmap_exit(map);
+}
+
+static struct kunit_case regmap_test_cases[] = {
+	KUNIT_CASE_PARAM(basic_read_write, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(bulk_read, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(reg_defaults, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(reg_defaults_read_dev, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(register_patch, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(stride, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(basic_ranges, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_bypass, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_sync, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_sync_defaults, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_sync_patch, real_cache_types_gen_params),
+	{}
+};
+
+static struct kunit_suite regmap_test_suite = {
+	.name = "regmap",
+	.test_cases = regmap_test_cases,
+};
+kunit_test_suite(regmap_test_suite);
+
+MODULE_LICENSE("GPL v2");

-- 
2.34.1

