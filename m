Return-Path: <linux-kselftest+bounces-41432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CF1B559DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 01:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD327B3F7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 23:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30453286408;
	Fri, 12 Sep 2025 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dXJcsp0H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC22284663
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718598; cv=none; b=Sh85Q4FR1IXQUTkM/lScOSSZpKDXLqkqu/Q3hIr30AZzsz0VJe3+aXB2bNn99kXwmj9ohxaj31ZSeeLwQvA+xxhMiZogsksXlW3lDSe+YUFYoFIDE8/lJ+1CEhGVX35krEo4Kh3MyxgSW5n+lG+D2cbS2mewf5BmLkyDmBJ9WzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718598; c=relaxed/simple;
	bh=Lo3tg8ldYjfkigGNAQI4TicSETLTyzsBXIoJKJfX1qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d91gSH9/bA5PITVrvzBBavVqUPVFXoCC2wKSalZugNCWuPDn62Wm9sQ1/DXvHatD+OTHeZPhvz1WvVZZsMsenqw1Tc4CqO80x/vSbdrt1GYS9tvxMZxVVLCV+LK0oyCDS4CWON/n/cKtUK8+jTB3+AHy4JU/RctfijNv6HFB8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dXJcsp0H; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7761578340dso1478631b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718595; x=1758323395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfbdyh7LZJFSoGiMjoTbUql5vPlkYLJxEsX0Qs2RYRI=;
        b=dXJcsp0HhDMR23kBYaemQHXeDWH4iQgIyLD7rthJseylpgSAaYE2ZsnEDGEudbrN1r
         iOL9vSd1l1pZKGJ3PR/Jj1E1yv6ccsP8534pMCra9PEAtctuZN7pSb2Z9QtUczvp45kt
         Ru/GJyeT9Z33CGKZ0UWtpmEg77vAsDRN7kBQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718595; x=1758323395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfbdyh7LZJFSoGiMjoTbUql5vPlkYLJxEsX0Qs2RYRI=;
        b=SXq0VpRgYbbRjPkdTq7wpgWLmuG3ChMchvbGrl6SuIGZYx0SdT1svif8IZx86yqqNG
         o8eQDEUmlULFWoiFomDAsTIsJz6sfBDRpXNeXKaAGgxWtgEsyFgPRYYk62gVI7OrxKhK
         G4A3uE/N16Wz5qTrIVG4BUYueFDmHzFlk3xg3vFaC39ktB/QQ+2AWVN3sWTjrRtUckFv
         2Gj1omczcuyc4VMiy9oAksPSWzIDqvvAirEQ2C2jsgg37B7o0N0ZuI+EVSkHaP/itUb0
         Atfnp00McKIGc6qmXPU14hP1i7nTLhFtDjhOJs75jIHKsa3iKbA57quILvl9CYKGtDFb
         51hg==
X-Forwarded-Encrypted: i=1; AJvYcCXdTsMYth8HAEh84Iahe7wODCRBBJ5nXTjTWv+97njT3LL+swI4y2t6b8E+I6YGBgUpM/Ug+NBniHds9ARr2BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEifylOkA/AewraarBEUGR/Sop+YKA7whHyrvJCwIRrnR9MVnE
	OjFa3a9NwPn3G1mgsNa/vyss6l1jEkU1HmbwPynniiWTT+PS5fLQZtEbEV2Fzi1JIg==
X-Gm-Gg: ASbGncvtENYgIoThD+BHR6Erfg1RlApLahP5blGcQkEGywyneOp5mdG9Xkq4FoVJZOe
	lnzM10SUc5a23q3otj6yVdriDrlezeVx4HhWWRKXdwPR6UvTJU6DR6caE0CSRYkaLdPWScQBTLN
	Mp5j2206ryshFu82cUEX7LfyEdbURrJ72XVs7yKyA5S5wONdP6Q7eZL1J/XkPjiiWEZucJMVQeH
	IC7F3poWQc66kdFm49oIB0r/rmOeD/DVkDJO7q1b9E3ANFtcPc4JtCOrUnsn+mhHP5oyIn1kM1l
	v1eUkAiSi9Lfi7ppNsDznL/CrtU0T5B4LLzqJIVClt8kRgcTMuOUjbB/3J8M3fOx19mGTGYG/mr
	q9L4oZMp7q88s1LRO1CQGcck2po8Y+c/OkWgpmx5TviU4L0NHhRPq45TqCGoc7H9j1yCsgA==
X-Google-Smtp-Source: AGHT+IGftUvGS13nUHO5sPbO5aRdKW/iBhC0or62cpjUOnYlYwK3legDnb+L5xeL8qmZu3rVdhxD6Q==
X-Received: by 2002:a05:6a20:3ca8:b0:24c:48f3:3fd2 with SMTP id adf61e73a8af0-2602a792dccmr5869556637.24.1757718595630;
        Fri, 12 Sep 2025 16:09:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a35b7b53sm5716718a12.7.2025.09.12.16.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:55 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/4] PCI: Add KUnit tests for FIXUP quirks
Date: Fri, 12 Sep 2025 15:59:33 -0700
Message-ID: <20250912230208.967129-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI framework supports device quirks via a series of macros and
linker sections. This support previously did not work when used in
modules. Add a basic set of tests for matching/non-matching devices.

Example run:

  $ ./tools/testing/kunit/kunit.py run 'pci_fixup*'
  [...]
  [15:31:30] ============ pci_fixup_test_cases (2 subtests) =============
  [15:31:30] [PASSED] pci_fixup_match_test
  [15:31:30] [PASSED] pci_fixup_nomatch_test
  [15:31:30] ============== [PASSED] pci_fixup_test_cases ===============
  [15:31:30] ============================================================
  [15:31:30] Testing complete. Ran 2 tests: passed: 2
  [15:31:30] Elapsed time: 11.197s total, 0.001s configuring, 9.870s building, 1.299s running

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/Kconfig      |  11 +++
 drivers/pci/Makefile     |   1 +
 drivers/pci/fixup-test.c | 197 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/pci/fixup-test.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9a249c65aedc..a4fa9be797e7 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -68,6 +68,17 @@ config PCI_QUIRKS
 	  Disable this only if your target machine is unaffected by PCI
 	  quirks.
 
+config PCI_FIXUP_KUNIT_TEST
+	tristate "KUnit tests for PCI fixup code" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on PCI_DOMAINS_GENERIC
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for the PCI quirk/fixup framework. Recommended
+	  only for kernel developers.
+
+	  When in doubt, say N.
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on DEBUG_KERNEL
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..ade400250ceb 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -20,6 +20,7 @@ endif
 
 obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
+obj-$(CONFIG_PCI_FIXUP_KUNIT_TEST) += fixup-test.o
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
diff --git a/drivers/pci/fixup-test.c b/drivers/pci/fixup-test.c
new file mode 100644
index 000000000000..54b895fc8f3e
--- /dev/null
+++ b/drivers/pci/fixup-test.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google, Inc.
+ */
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <linux/cleanup.h>
+#include <linux/pci.h>
+
+#define DEVICE_NAME		"pci_fixup_test_device"
+#define TEST_VENDOR_ID		0xdead
+#define TEST_DEVICE_ID		0xbeef
+
+#define TEST_CONF_SIZE		4096
+static u8 *test_conf_space;
+
+#define test_readb(addr)	(*(u8 *)(addr))
+#define test_readw(addr)	le16_to_cpu(*((__force __le16 *)(addr)))
+#define test_readl(addr)	le32_to_cpu(*((__force __le32 *)(addr)))
+#define test_writeb(addr, v)	(*(u8 *)(addr) = (v))
+#define test_writew(addr, v)	(*((__force __le16 *)(addr)) = cpu_to_le16(v))
+#define test_writel(addr, v)	(*((__force __le32 *)(addr)) = cpu_to_le32(v))
+
+static int test_config_read(struct pci_bus *bus, unsigned int devfn, int where,
+			    int size, u32 *val)
+{
+	if (PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (where + size > TEST_CONF_SIZE)
+		return PCIBIOS_BUFFER_TOO_SMALL;
+
+	if (size == 1)
+		*val = test_readb(test_conf_space + where);
+	else if (size == 2)
+		*val = test_readw(test_conf_space + where);
+	else if (size == 4)
+		*val = test_readl(test_conf_space + where);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int test_config_write(struct pci_bus *bus, unsigned int devfn, int where,
+			     int size, u32 val)
+{
+	if (PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (where + size > TEST_CONF_SIZE)
+		return PCIBIOS_BUFFER_TOO_SMALL;
+
+	if (size == 1)
+		test_writeb(test_conf_space + where, val);
+	else if (size == 2)
+		test_writew(test_conf_space + where, val);
+	else if (size == 4)
+		test_writel(test_conf_space + where, val);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops test_ops = {
+	.read = test_config_read,
+	.write = test_config_write,
+};
+
+static struct pci_dev *hook_device_early;
+static struct pci_dev *hook_device_header;
+static struct pci_dev *hook_device_final;
+static struct pci_dev *hook_device_enable;
+
+static void pci_fixup_early_hook(struct pci_dev *pdev)
+{
+	hook_device_early = pdev;
+}
+DECLARE_PCI_FIXUP_EARLY(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_early_hook);
+
+static void pci_fixup_header_hook(struct pci_dev *pdev)
+{
+	hook_device_header = pdev;
+}
+DECLARE_PCI_FIXUP_HEADER(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_header_hook);
+
+static void pci_fixup_final_hook(struct pci_dev *pdev)
+{
+	hook_device_final = pdev;
+}
+DECLARE_PCI_FIXUP_FINAL(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_final_hook);
+
+static void pci_fixup_enable_hook(struct pci_dev *pdev)
+{
+	hook_device_enable = pdev;
+}
+DECLARE_PCI_FIXUP_ENABLE(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_enable_hook);
+
+static int pci_fixup_test_init(struct kunit *test)
+{
+	hook_device_early = NULL;
+	hook_device_header = NULL;
+	hook_device_final = NULL;
+	hook_device_enable = NULL;
+
+	return 0;
+}
+
+static void pci_fixup_match_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);
+
+	/* Minimal configuration space: a stub vendor and device ID */
+	test_writew(test_conf_space + PCI_VENDOR_ID, TEST_VENDOR_ID);
+	test_writew(test_conf_space + PCI_DEVICE_ID, TEST_DEVICE_ID);
+
+	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
+	bridge->ops = &test_ops;
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+
+	KUNIT_EXPECT_EQ(test, 0, pci_host_probe(bridge));
+
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
+	KUNIT_ASSERT_PTR_NE(test, NULL, pdev);
+
+	KUNIT_EXPECT_PTR_EQ(test, pdev, hook_device_early);
+	KUNIT_EXPECT_PTR_EQ(test, pdev, hook_device_header);
+	KUNIT_EXPECT_PTR_EQ(test, pdev, hook_device_final);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+
+	KUNIT_EXPECT_EQ(test, 0, pci_enable_device(pdev));
+	KUNIT_EXPECT_PTR_EQ(test, pdev, hook_device_enable);
+}
+
+static void pci_fixup_nomatch_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);
+
+	/* Minimal configuration space: a stub vendor and device ID */
+	test_writew(test_conf_space + PCI_VENDOR_ID, TEST_VENDOR_ID + 1);
+	test_writew(test_conf_space + PCI_DEVICE_ID, TEST_DEVICE_ID);
+
+	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
+	bridge->ops = &test_ops;
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+
+	KUNIT_EXPECT_EQ(test, 0, pci_host_probe(bridge));
+
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
+	KUNIT_ASSERT_PTR_NE(test, NULL, pdev);
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+
+	KUNIT_EXPECT_EQ(test, 0, pci_enable_device(pdev));
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+}
+
+static struct kunit_case pci_fixup_test_cases[] = {
+	KUNIT_CASE(pci_fixup_match_test),
+	KUNIT_CASE(pci_fixup_nomatch_test),
+	{}
+};
+
+static struct kunit_suite pci_fixup_test_suite = {
+	.name = "pci_fixup_test_cases",
+	.test_cases = pci_fixup_test_cases,
+	.init = pci_fixup_test_init,
+};
+
+kunit_test_suite(pci_fixup_test_suite);
+MODULE_DESCRIPTION("PCI fixups unit test suite");
+MODULE_LICENSE("GPL");
-- 
2.51.0.384.g4c02a37b29-goog


