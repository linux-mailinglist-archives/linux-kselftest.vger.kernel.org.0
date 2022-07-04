Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF856581C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiGDOAO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiGDN7m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 09:59:42 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD3101F0
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 06:59:35 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id 189so9109742vsh.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jul 2022 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0DiM2QAFWfRCxyX4K2DXOUSOAXhJvDrH/Deu05TYDY=;
        b=cMagWlDmtdm3o1f6Pp61sL3GddrPHHQmPJWDvSTOuRfLNvZ4cPGhTJfzZcNjMxrfjr
         sEbPLuO9RK2jvBXKZnS9xayzZJumnLdPqvIynQ9cWked5s3vnTxQdeo28d4/wfb8C+zL
         +VqvZGqgvnIkqw2lFDv9JbvIbcCYWy3hB/iNAJspkY9a7o4Q1VoIgfVn/623KrxQ6I8u
         eBXrG3RP91GB1gMw5zXSyVmi+899r4kspuuZqoR6lSx57tZplo1sbF5vEuTQ+y2qVoe1
         Uleb7KRX5XfIrNZYJg5CDMbrmtp+/rvl0vg6DLjHMniyMb0Rvs4lD12kZGILIPOpk4sW
         U/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0DiM2QAFWfRCxyX4K2DXOUSOAXhJvDrH/Deu05TYDY=;
        b=GcYevQbbYveNw4eygmA6Glw+p3B+YEs8F/iGSMpcDzbIiFTalzKRDXaIjEJEMUeFB/
         KtJDYT1aQSCmi4TMKhtz2rwFz7SUg1DUDU03DB6h49E7lkkJrY+D+NZFdOxH/39ckQQD
         HReqtUJv1PDnC4GVEAfU6sQ4gOW8Onxpz8SeJ0v/8uNzhdTsRl9m7CbnWG4jniLpOGu/
         mKTTpfQ3OtiGxZGf1Qv9uQFehyWRDXmDpw7RY08H938L+NBhdbZdGwDqm6YS7afGZZ/s
         n96DwDb6D8yuw3AE8EpMB7GEt4VWtVU3M45kyfshxiqpf3ST+wAKLBlIvXUxxcVJXHGe
         ZqDw==
X-Gm-Message-State: AJIora91BIrfu5Uij5Du48TGx7KAje55TZF7LwpHsvUQJ5IWAgvMcOwT
        S30d5RkOAGs5gqgXKbRORVpgOptAoR0ZZQ==
X-Google-Smtp-Source: AGRyM1sE6muSOvx2k+xe3UnPJZ2WVCBPj7qW4PpsjOJJKZzXCsbFp4uxqOIHZ9lHyDxUhrjpJWshnQ==
X-Received: by 2002:a67:eb0b:0:b0:354:5c77:775c with SMTP id a11-20020a67eb0b000000b003545c77775cmr17327338vso.46.1656943175020;
        Mon, 04 Jul 2022 06:59:35 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id x24-20020ab036f8000000b0038296f80d22sm724438uau.8.2022.07.04.06.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:59:34 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v9 7/9] x86/e820: Add unit tests for e820_range_* functions
Date:   Mon,  4 Jul 2022 10:58:31 -0300
Message-Id: <20220704135833.1496303-8-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add KUnit tests for the e820_range_* functions.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/Kconfig.debug      |  10 ++
 arch/x86/kernel/e820.c      |   5 +
 arch/x86/kernel/e820_test.c | 249 ++++++++++++++++++++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 arch/x86/kernel/e820_test.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d872a7522e55..b5040d345fb4 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -225,6 +225,16 @@ config PUNIT_ATOM_DEBUG
 	  The current power state can be read from
 	  /sys/kernel/debug/punit_atom/dev_power_state
 
+config E820_KUNIT_TEST
+	tristate "Tests for E820" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables unit tests for the e820.c code. It
+	  should be enabled only in development environments.
+
+         If unsure, say N.
+
 choice
 	prompt "Choose kernel unwinder"
 	default UNWINDER_ORC if X86_64
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index dade59758b9f..a6ced3e306dd 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1546,3 +1546,8 @@ void __init e820__memblock_setup(void)
 
 	memblock_dump_all();
 }
+
+#ifdef CONFIG_E820_KUNIT_TEST
+/* Let e820_test have access the static functions in this file */
+#include "e820_test.c"
+#endif
diff --git a/arch/x86/kernel/e820_test.c b/arch/x86/kernel/e820_test.c
new file mode 100644
index 000000000000..6b28ea131380
--- /dev/null
+++ b/arch/x86/kernel/e820_test.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+
+#include <asm/e820/api.h>
+#include <asm/setup.h>
+
+#define KUNIT_EXPECT_E820_ENTRY_EQ(_test, _entry, _addr, _size, _type,         \
+				   _crypto_capable)                            \
+	do {                                                                   \
+		KUNIT_EXPECT_EQ((_test), (_entry).addr, (_addr));              \
+		KUNIT_EXPECT_EQ((_test), (_entry).size, (_size));              \
+		KUNIT_EXPECT_EQ((_test), (_entry).type, (_type));              \
+		KUNIT_EXPECT_EQ((_test), (_entry).crypto_capable,              \
+				(_crypto_capable));                            \
+	} while (0)
+
+struct e820_table test_table __initdata;
+
+static void __init test_e820_range_add(struct kunit *test)
+{
+	u32 full = ARRAY_SIZE(test_table.entries);
+	/* Add last entry. */
+	test_table.nr_entries = full - 1;
+	__e820__range_add(&test_table, 0, 15, 0, 0);
+	KUNIT_EXPECT_EQ(test, test_table.nr_entries, full);
+	/* Skip new entry when full. */
+	__e820__range_add(&test_table, 0, 15, 0, 0);
+	KUNIT_EXPECT_EQ(test, test_table.nr_entries, full);
+}
+
+static void __init test_e820_range_update(struct kunit *test)
+{
+	u64 entry_size = 15;
+	u64 updated_size = 0;
+	/* Initialize table */
+	test_table.nr_entries = 0;
+	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
+			  E820_NOT_CRYPTO_CAPABLE);
+	__e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
+			  E820_NOT_CRYPTO_CAPABLE);
+	__e820__range_add(&test_table, entry_size * 2, entry_size,
+			  E820_TYPE_ACPI, E820_NOT_CRYPTO_CAPABLE);
+
+	updated_size = __e820__range_update(&test_table, 0, entry_size * 2,
+					    E820_TYPE_RAM, E820_TYPE_RESERVED);
+
+	/* The first 2 regions were updated */
+	KUNIT_EXPECT_EQ(test, updated_size, entry_size * 2);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
+				   E820_TYPE_RESERVED, E820_NOT_CRYPTO_CAPABLE);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
+				   entry_size, E820_TYPE_RESERVED,
+				   E820_NOT_CRYPTO_CAPABLE);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
+				   entry_size, E820_TYPE_ACPI,
+				   E820_NOT_CRYPTO_CAPABLE);
+
+	updated_size = __e820__range_update(&test_table, 0, entry_size * 3,
+					    E820_TYPE_RESERVED, E820_TYPE_RAM);
+
+	/*
+	 * Only the first 2 regions were updated,
+	 * since E820_TYPE_ACPI > E820_TYPE_RESERVED
+	 */
+	KUNIT_EXPECT_EQ(test, updated_size, entry_size * 2);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
+				   E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
+				   entry_size, E820_TYPE_RAM,
+				   E820_NOT_CRYPTO_CAPABLE);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
+				   entry_size, E820_TYPE_ACPI,
+				   E820_NOT_CRYPTO_CAPABLE);
+}
+
+static void __init test_e820_range_remove(struct kunit *test)
+{
+	u64 entry_size = 15;
+	u64 removed_size = 0;
+
+	struct e820_entry_updater updater = { .should_update =
+						      remover__should_update,
+					      .update = remover__update,
+					      .new = NULL };
+
+	struct e820_remover_data data = { .check_type = true,
+					  .old_type = E820_TYPE_RAM };
+
+	/* Initialize table */
+	test_table.nr_entries = 0;
+	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
+			  E820_NOT_CRYPTO_CAPABLE);
+	__e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
+			  E820_NOT_CRYPTO_CAPABLE);
+	__e820__range_add(&test_table, entry_size * 2, entry_size,
+			  E820_TYPE_ACPI, E820_NOT_CRYPTO_CAPABLE);
+
+	/*
+	 * Need to use __e820__handle_range_update because
+	 * e820__range_remove doesn't ask for the table
+	 */
+	removed_size = __e820__handle_range_update(&test_table,
+						   0, entry_size * 2,
+						   &updater, &data);
+
+	/* The first two regions were removed */
+	KUNIT_EXPECT_EQ(test, removed_size, entry_size * 2);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 0, 0, 0);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 0, 0, 0);
+
+	removed_size = __e820__handle_range_update(&test_table,
+						   0, entry_size * 3,
+						   &updater, &data);
+
+	/* Nothing was removed, since nothing matched the target type */
+	KUNIT_EXPECT_EQ(test, removed_size, 0);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 0, 0, 0);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 0, 0, 0);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
+				   entry_size, E820_TYPE_ACPI,
+				   E820_NOT_CRYPTO_CAPABLE);
+}
+
+static void __init test_e820_range_crypto_update(struct kunit *test)
+{
+	u64 entry_size = 15;
+	u64 updated_size = 0;
+	/* Initialize table */
+	test_table.nr_entries = 0;
+	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
+			  E820_CRYPTO_CAPABLE);
+	__e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
+			  E820_NOT_CRYPTO_CAPABLE);
+	__e820__range_add(&test_table, entry_size * 2, entry_size,
+			  E820_TYPE_RAM, E820_CRYPTO_CAPABLE);
+
+	updated_size = __e820__range_update_crypto(&test_table,
+						   0, entry_size * 3,
+						   E820_CRYPTO_CAPABLE);
+
+	/* Only the region in the middle was updated */
+	KUNIT_EXPECT_EQ(test, updated_size, entry_size);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
+				   E820_TYPE_RAM, E820_CRYPTO_CAPABLE);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
+				   entry_size, E820_TYPE_RAM,
+				   E820_CRYPTO_CAPABLE);
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
+				   entry_size, E820_TYPE_RAM,
+				   E820_CRYPTO_CAPABLE);
+}
+
+static void __init test_e820_handle_range_update_intersection(struct kunit *test)
+{
+	struct e820_entry_updater updater = {
+		.should_update = type_updater__should_update,
+		.update = type_updater__update,
+		.new = type_updater__new
+	};
+
+	struct e820_type_updater_data data = { .old_type = E820_TYPE_RAM,
+					       .new_type = E820_TYPE_RESERVED };
+
+	u64 entry_size = 15;
+	u64 intersection_size = 2;
+	u64 updated_size = 0;
+	/* Initialize table */
+	test_table.nr_entries = 0;
+	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
+			  E820_NOT_CRYPTO_CAPABLE);
+
+	updated_size =
+		__e820__handle_range_update(&test_table, 0,
+					    entry_size - intersection_size,
+					    &updater, &data);
+
+	KUNIT_EXPECT_EQ(test, updated_size, entry_size - intersection_size);
+
+	/* There is a new entry */
+	KUNIT_EXPECT_EQ(test, test_table.nr_entries, intersection_size);
+
+	/* The original entry now is moved */
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0],
+				   entry_size - intersection_size,
+				   intersection_size, E820_TYPE_RAM,
+				   E820_NOT_CRYPTO_CAPABLE);
+
+	/* The new entry has the correct values */
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0,
+				   entry_size - intersection_size,
+				   E820_TYPE_RESERVED, E820_NOT_CRYPTO_CAPABLE);
+}
+
+static void __init test_e820_handle_range_update_inside(struct kunit *test)
+{
+	struct e820_entry_updater updater = {
+		.should_update = type_updater__should_update,
+		.update = type_updater__update,
+		.new = type_updater__new
+	};
+
+	struct e820_type_updater_data data = { .old_type = E820_TYPE_RAM,
+					       .new_type = E820_TYPE_RESERVED };
+
+	u64 entry_size = 15;
+	u64 updated_size = 0;
+	/* Initialize table */
+	test_table.nr_entries = 0;
+	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
+			  E820_NOT_CRYPTO_CAPABLE);
+
+	updated_size = __e820__handle_range_update(&test_table, 5,
+						   entry_size - 10,
+						   &updater, &data);
+
+	KUNIT_EXPECT_EQ(test, updated_size, entry_size - 10);
+
+	/* There are two new entrie */
+	KUNIT_EXPECT_EQ(test, test_table.nr_entries, 3);
+
+	/* The original entry now shrunk */
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 5,
+				   E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);
+
+	/* The new entries have the correct values */
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 5,
+				   entry_size - 10, E820_TYPE_RESERVED,
+				   E820_NOT_CRYPTO_CAPABLE);
+	/* Left over of the original region */
+	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size - 5,
+				   5, E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);
+}
+
+static struct kunit_case e820_test_cases[] __initdata = {
+	KUNIT_CASE(test_e820_range_add),
+	KUNIT_CASE(test_e820_range_update),
+	KUNIT_CASE(test_e820_range_remove),
+	KUNIT_CASE(test_e820_range_crypto_update),
+	KUNIT_CASE(test_e820_handle_range_update_intersection),
+	KUNIT_CASE(test_e820_handle_range_update_inside),
+	{}
+};
+
+static struct kunit_suite e820_test_suite __initdata = {
+	.name = "e820",
+	.test_cases = e820_test_cases,
+};
+
+kunit_test_init_section_suite(e820_test_suite);
-- 
2.30.2

