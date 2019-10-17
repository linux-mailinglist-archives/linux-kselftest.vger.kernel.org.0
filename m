Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19469DB98D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441597AbfJQWMj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 18:12:39 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44934 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441586AbfJQWMj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 18:12:39 -0400
Received: by mail-qt1-f201.google.com with SMTP id h10so3788713qtq.11
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L+dU0G5f51fk+R1KokO5//3nTTbHElWO3XDD84WR/JE=;
        b=slLu6cXPRC3Cd/4ApuNlizqgLvqpM45Hvx/mD38QHphN06LrSitJ6GoHcjIna8f5vH
         Ml18viYLkDWfWGTIBSo4YIvRT6VDIrMLU/bMAWfx3ZPxTXIA8cTxwSPREMEgdwD90AD1
         XjvfgClhrjGFoAGjFkbNhVPCZ/Ju9QRYYzWLDMf5Jwy2I1ETI4Q4ynMSBby8HZUCM2QQ
         mfOGZukci4aG+Zvbh+m1nurk30q/Zf4k7XZgEjQsiwC2e95QmnKzl+eN3Q4jUfjvMNb6
         XGqUOPKSz3x75IT2aEZcl1vr+9jUjU/I0aYCnP5RObvwO8PWn/suZlYRQobkPA1bqTTd
         nOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L+dU0G5f51fk+R1KokO5//3nTTbHElWO3XDD84WR/JE=;
        b=ad/6i23ZEpuNemxiWFjZYFJNIZI+F1EKx7xZrFsxJSqlxUI3iUxxcI5nmUDRrpljlp
         CeXT67fuYZmovAXx3Lca2hFGp4kRR58CzEMmSmeqnSnUzeVD3BJca6UBmtN/MJWi7J2h
         ZqSRt/wH0Aco3J6baf14lD92ltROH7/VfrSFL6syRBk2KQ5wbjM0Z5MnAZU6ZAiESDOw
         UznSoF6JllhPW2GepaGsjYcqy4aP3g7JvroF5mqohebS3XOYld7xbORK6TCEFwEtqEp2
         +vJrnxB7ACqQPiH0gXbGrF6LJ64GaP55haMbqJx2wQgF/tO28INQ702GU6u4Qb8Dygas
         CEgA==
X-Gm-Message-State: APjAAAXq9AnB6NW8hgHUvivrwtUhP1TL44+zqkCvwLNYIJUnHh7EN7lB
        usaCt8fiJojg2xn63bySraAdaKIiy9OKuvpOVkqfZNAxxCbe6QZbgAGUN6zMXdLOiXvj3oEuhP8
        JZq/S+tzCqnUyUTY04drGWL4uopnRu2BjVgK2LVmJHXqmIxBauadt6UZWQwL6Oo1x+yA+TF5v84
        g=
X-Google-Smtp-Source: APXvYqx+9QJ/v4ggwrVbLqHjPPMo7/crlVEISoXODtdqSRG9lrIE0sGJECzTXU3n3U5uaxs782cr9TQuZd1a
X-Received: by 2002:a0c:e84f:: with SMTP id l15mr4709263qvo.200.1571350357854;
 Thu, 17 Oct 2019 15:12:37 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:12:33 -0700
Message-Id: <20191017221233.154848-1-yzaikin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH linux-kselftest/test v6] ext4: add kunit test for decoding
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

KUnit tests for decoding extended 64 bit timestamps that verify the
seconds part of [a/c/m] timestamps in ext4 inode structs are decoded
correctly.

Test data is derived from the table in the Inode Timestamps section of
Documentation/filesystems/ext4/inodes.rst.

KUnit tests run during boot and output the results to the debug log
in TAP format (http://testanything.org/). Only useful for kernel devs
running KUnit test harness and are not for inclusion into a production
build.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 fs/ext4/Kconfig      |  17 +++
 fs/ext4/Makefile     |   1 +
 fs/ext4/inode-test.c | 272 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
 create mode 100644 fs/ext4/inode-test.c

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index cbb5ca830e57..ef42ab040905 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -106,3 +106,20 @@ config EXT4_DEBUG
 	  If you select Y here, then you will be able to turn on debugging
 	  with a command such as:
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
+
+config EXT4_KUNIT_TESTS
+	bool "KUnit tests for ext4"
+	select EXT4_FS
+	depends on KUNIT
+	help
+	  This builds the ext4 KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a production
+	  build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index b17ddc229ac5..840b91d040f1 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -13,4 +13,5 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \

 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
+ext4-$(CONFIG_EXT4_KUNIT_TESTS)		+= inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
new file mode 100644
index 000000000000..92a9da1774aa
--- /dev/null
+++ b/fs/ext4/inode-test.c
@@ -0,0 +1,272 @@
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
+/*
+ * For constructing the nonnegative timestamp lower bound value.
+ * binary: 00000000 00000000 00000000 00000000
+ */
+#define LOWER_MSB_0 0L
+/*
+ * For constructing the nonnegative timestamp upper bound value.
+ * binary: 01111111 11111111 11111111 11111111
+ *
+ */
+#define UPPER_MSB_0 0x7fffffffL
+/*
+ * For constructing the negative timestamp lower bound value.
+ * binary: 10000000 00000000 00000000 00000000
+ */
+#define LOWER_MSB_1 (-0x80000000L)
+/*
+ * For constructing the negative timestamp upper bound value.
+ * binary: 11111111 11111111 11111111 11111111
+ */
+#define UPPER_MSB_1 (-1L)
+/*
+ * Upper bound for nanoseconds value supported by the encoding.
+ * binary: 00111111 11111111 11111111 11111111
+ */
+#define MAX_NANOSECONDS ((1L << 30) - 1)
+
+#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
+
+#define LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE\
+	"1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits"
+#define UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE\
+	"1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits"
+#define LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE\
+	"1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits"
+#define UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE\
+	"2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits"
+#define LOWER_BOUND_NEG_LO_1_CASE\
+	"2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on"
+#define UPPER_BOUND_NEG_LO_1_CASE\
+	"2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on"
+#define LOWER_BOUND_NONNEG_LO_1_CASE\
+	"2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on"
+#define UPPER_BOUND_NONNEG_LO_1_CASE\
+	"2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on"
+#define LOWER_BOUND_NEG_HI_1_CASE\
+	"2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on"
+#define UPPER_BOUND_NEG_HI_1_CASE\
+	"2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on"
+#define LOWER_BOUND_NONNEG_HI_1_CASE\
+	"2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on"
+#define UPPER_BOUND_NONNEG_HI_1_CASE\
+	"2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on"
+#define UPPER_BOUND_NONNEG_HI_1_NS_1_CASE\
+	"2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns"
+#define LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE\
+	"2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns"
+#define LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE\
+	"2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on"
+#define UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE\
+	"2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on"
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
+ *  Test data is derived from the table in the Inode Timestamps section of
+ *  Documentation/filesystems/ext4/inodes.rst.
+ */
+static void inode_test_xtimestamp_decoding(struct kunit *test)
+{
+	const struct timestamp_expectation test_data[] = {
+		{
+			.test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {0LL, 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits =  2,
+			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 6,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0xFFFFFFFF,
+			.expected = {.tv_sec = 0x300000000LL,
+				     .tv_nsec = MAX_NANOSECONDS},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 3,
+			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
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
2.23.0.866.gb869b98d4c-goog
