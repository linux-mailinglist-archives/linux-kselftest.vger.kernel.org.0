Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82DD4C26
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2019 04:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfJLCiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 22:38:06 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54083 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfJLCiG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 22:38:06 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so8879851pfr.20
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2019 19:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mb3SO7Lwp3uzZ+OZZ7iRLR5xu7JFDigQnq90WxW/01U=;
        b=Fx9voS4A4qmfOmD6it6eWj/j4qxgPyk936owEOzdbPXDazjGc1kxfTMvnGpu7UAQDR
         d8WxZ1s73KBaJqQZCBWZZ5HPv3Pbwi05kl85O0mOQyW5kgZXYBEj/afDnVkunph7gV5D
         wpfV6tmUrGU5V4zmQemLNrF86fq27alSOAwR9C01bYR67lBv3cEfS7rprq5Glx4LIXNy
         gxn5J0oHXEjSfykH6boInQo8Mb0qPmd91ItMKsrRxgDTacL8NkYXiiyow6vuHhx9naYh
         SKiYYC8/BUhHpORj7f8ZkAR/YsM7pkTm68TaKjrRfLf2fykEhhMsWp76DCX1XE2aLkH8
         5ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mb3SO7Lwp3uzZ+OZZ7iRLR5xu7JFDigQnq90WxW/01U=;
        b=MQOMIW2S5f0ogP3e3wppvEPvvuNaURrxxVhjOCc6gHHlmF/cjElcMpDomFqRmyLJh7
         rovFJsDqtoN1coMRWRidzIsSKB1w/5XmZaXaKvxCKk2LleOe2x+OqbPzt+0DQyzAHrWs
         dGKcYc2d44u9ZtVCINWP8wW8i+z8Vi3adUv6DaZ2P620GwTdnnBHGDyTsWOrld8Ekqzj
         8N04wR0F6jSLrN1U3j3WxcgXppcwHwCbv0Nz9p2EhLXbENkUhGcSkmSnymfjBQ//cQXX
         6mfUxGtmT+OeB4LsQ+mqPNULRoG28BHJVX3cttx/S1sOORKF8YUpyVJygT6T5fQdpGu2
         bVXA==
X-Gm-Message-State: APjAAAUvlem+4TM4FyzBGAsSpdqo1bkJaA7TqxDF1Alvg1Kb/v+ktVI2
        b+uOcWZQ/npNBeIzIyO+8TNO3cMoJVAv8Qz+Dgd/iZr1yJMibmeU4Uk2xIKJ9HAC4QjHLRe1tuH
        RJH8GLMjp1DpTpSlx3snZLun4gNddDsX1oe5+CmeUCUgR5BAR8P4sEq+vrKnLQ+1Q8G0NWYiZJY
        U=
X-Google-Smtp-Source: APXvYqyP0oXBtF6RnlLU8NmJq/JyfEdfbAkm4tJx5tDj9pxfxmKU93XMgPUXVTs6UxTfYpxTq0CMwVxxA8RB
X-Received: by 2002:a63:cf46:: with SMTP id b6mr20239436pgj.90.1570847885429;
 Fri, 11 Oct 2019 19:38:05 -0700 (PDT)
Date:   Fri, 11 Oct 2019 19:37:57 -0700
Message-Id: <20191012023757.172770-1-yzaikin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH linux-kselftest/test v4] ext4: add kunit test for decoding
 extended timestamps
From:   Iurii Zaikin <yzaikin@google.com>
To:     linux-kselftest@vger.kernel.org, linux-ext4@vger.kernel.org,
        skhan@linuxfoundation.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Tim.Bird@sony.com
Cc:     kunit-dev@googlegroups.com, brendanhiggins@google.com,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit tests for decoding extended 64 bit timestamps
that verify the seconds part of [a/c/m]
timestamps in ext4 inode structs are decoded correctly.
KUnit tests, which run on boot and output
the results to the debug log in TAP format (http://testanything.org/).
are only useful for kernel devs running KUnit test harness. Not for
inclusion into a production build.
Test data is derive from the table under
Documentation/filesystems/ext4/inodes.rst Inode Timestamps.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 fs/ext4/Kconfig      |  14 +++
 fs/ext4/Makefile     |   1 +
 fs/ext4/inode-test.c | 239 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 fs/ext4/inode-test.c

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index cbb5ca830e57..f13dde8ed92b 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -106,3 +106,17 @@ config EXT4_DEBUG
 	  If you select Y here, then you will be able to turn on debugging
 	  with a command such as:
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
+
+config EXT4_KUNIT_TESTS
+	bool "KUnit tests for ext4"
+	select EXT4_FS
+	depends on KUNIT
+	help
+	  This builds the ext4 KUnit tests, which run on boot and output
+	  the results to the debug log in TAP format (http://testanything.org/).
+	  Only useful for kernel devs running KUnit test harness. Not for
+	  inclusion into a production build.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index b17ddc229ac5..a0588fd2eea6 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -13,4 +13,5 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \

 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
+ext4-$(CONFIG_EXT4_KUNIT_TESTS)	+= inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
new file mode 100644
index 000000000000..3b3a453ff382
--- /dev/null
+++ b/fs/ext4/inode-test.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
+ * timestamps in ext4 inode structs are decoded correctly.
+ */
+
+#include <kunit/test.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+
+#include "ext4.h"
+
+/* binary: 00000000 00000000 00000000 00000000 */
+#define LOWER_MSB_0 0L
+/* binary: 01111111 11111111 11111111 11111111 */
+#define UPPER_MSB_0 0x7fffffffL
+/* binary: 10000000 00000000 00000000 00000000 */
+#define LOWER_MSB_1 (-0x80000000L)
+/* binary: 11111111 11111111 11111111 11111111 */
+#define UPPER_MSB_1 (-1L)
+/* binary: 00111111 11111111 11111111 11111111 */
+#define MAX_NANOSECONDS ((1L << 30) - 1)
+
+#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
+
+struct timestamp_expectation {
+	const char *test_case_name;
+	struct timespec64 expected;
+	u32 extra_bits;
+	bool msb_set;
+	bool lower_bound;
+};
+
+static time64_t get_32bit_time(const struct timestamp_expectation * const test)
+{
+	if (test->msb_set) {
+		if (test->lower_bound)
+			return LOWER_MSB_1;
+
+		return UPPER_MSB_1;
+	}
+
+	if (test->lower_bound)
+		return LOWER_MSB_0;
+	return UPPER_MSB_0;
+}
+
+
+/*
+ * These tests are derived from the table under
+ * Documentation/filesystems/ext4/inodes.rst Inode Timestamps
+ */
+static void inode_test_xtimestamp_decoding(struct kunit *test)
+{
+	const struct timestamp_expectation test_data[] = {
+		{
+			.test_case_name =
+		"1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits.",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+		"1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits.",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+		"1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {0LL, 0L},
+		},
+
+		{
+			.test_case_name =
+		"2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on.",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on.",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on.",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits =  2,
+			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on.",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+"2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns bit 1.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 6,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
+		},
+
+		{
+			.test_case_name =
+"2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. ns bits 1.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0xFFFFFFFF,
+			.expected = {.tv_sec = 0x300000000LL,
+				     .tv_nsec = MAX_NANOSECONDS},
+		},
+
+		{
+			.test_case_name =
+	 "2378-04-22 Lower bound of 32bit >= timestamp. All extra sec bits on.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 3,
+			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2446-05-10 Upper bound of 32bit >= timestamp. All extra sec bits on.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 3,
+			.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
+		}
+	};
+
+	struct timespec64 timestamp;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
+		timestamp.tv_sec = get_32bit_time(&test_data[i]);
+		ext4_decode_extra_time(&timestamp,
+				       cpu_to_le32(test_data[i].extra_bits));
+
+		KUNIT_EXPECT_EQ_MSG(test,
+				    test_data[i].expected.tv_sec,
+				    timestamp.tv_sec,
+				    CASE_NAME_FORMAT,
+				    test_data[i].test_case_name,
+				    test_data[i].msb_set,
+				    test_data[i].lower_bound,
+				    test_data[i].extra_bits);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    test_data[i].expected.tv_nsec,
+				    timestamp.tv_nsec,
+				    CASE_NAME_FORMAT,
+				    test_data[i].test_case_name,
+				    test_data[i].msb_set,
+				    test_data[i].lower_bound,
+				    test_data[i].extra_bits);
+	}
+}
+
+static struct kunit_case ext4_inode_test_cases[] = {
+	KUNIT_CASE(inode_test_xtimestamp_decoding),
+	{}
+};
+
+static struct kunit_suite ext4_inode_test_suite = {
+	.name = "ext4_inode_test",
+	.test_cases = ext4_inode_test_cases,
+};
+
+kunit_test_suite(ext4_inode_test_suite);
--
2.23.0.700.g56cf767bdb-goog
