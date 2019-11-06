Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2485EF0B2E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2019 01:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfKFAnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 19:43:46 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45145 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfKFAnq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 19:43:46 -0500
Received: by mail-pl1-f202.google.com with SMTP id f7so3505676plj.12
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Nov 2019 16:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UDu9jlFHlajkrqynrhutN3CH34pFrPpqv3GnW/eB+ZI=;
        b=ahRP6eUR1295bbm4ogukUDiRxzASo7uPxxyVXhVRFS6jPdJ/w9ANIPFHZoGPPoE0q3
         xl9l9urDpInO12yNYZ2y+mMu1VZygvBjFVsyE5e2PKSAsD+I63gN2GDPR9O5Qkhzzf9A
         KZhMmV1RSybKwwkVzJF7JduIUthvegEgs0n0ZOwHRC1qXYNLIK6twLR1sIn1XAEgcpLm
         JQjN9SUgqhkeWJBIEKIq2fVpZA5bjZtptxT2TXyVBG34XZ56sFLAVeugsEqzig5ynu59
         ijAdFk5mb85OSJY8HfnAG0fknRLdr6SJohgQnVrYLQhJETOoQnfYhNvu1ARFnE0jwt/7
         tKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UDu9jlFHlajkrqynrhutN3CH34pFrPpqv3GnW/eB+ZI=;
        b=Kv7MvdW9gmNvYZ8VZ80MhzKwFTLhOQvDd6MdUzNsZEsTyLF1+U8emXpRBIPbmhhXG+
         EEepI6f9RuO/E6HPe4GyeF/dvnMHCscD/HECVX4Aqhvz8VtgZR76N4f+FI6bayMxWQwe
         vyMbS6KVjP6lsdwFwpU76z6HH+96w2PLJInhVYoWFNlCV5J1Cu2xTWRz5kGtIBFjhKkh
         MxWVqO7lHmRabZ7HON6fiYpVaoEoFOzwr32smhF40koMuCyvXlFj8EAKwkf9TuWp/7O/
         Rui9jeSuk53eYLbkuSqUdkAAuZbb4GEWKgrYQyoCaOxtIWjr+OPKetHue+GI/PhVpZh2
         VaLQ==
X-Gm-Message-State: APjAAAXoDVpik2wfxmCzGFnh55u522+UZ1nnNeiMd8I8tnZ9qdo2+bjw
        UX8lPOiaBfTgI/o2XnVjTarYA9G/2ngywVnweq2/pg==
X-Google-Smtp-Source: APXvYqy7TbBTiDa81/Z7/WT5dZtxugCNlgTHW4BOGcf6jx6r/UGGlKbmH3tEQ/Z0SNXkY16X5Kb1JWcPjvBy8+hCzUbqtA==
X-Received: by 2002:a65:6418:: with SMTP id a24mr2958143pgv.260.1573001025153;
 Tue, 05 Nov 2019 16:43:45 -0800 (PST)
Date:   Tue,  5 Nov 2019 16:43:29 -0800
Message-Id: <20191106004329.16991-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH linux-kselftest/test v2] apparmor: add AppArmor KUnit tests
 for policy unpack
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, john.johansen@canonical.com, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, mcgrof@kernel.org,
        tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mike Salvatore <mike.salvatore@canonical.com>

Add KUnit tests to test AppArmor unpacking of userspace policies.
AppArmor uses a serialized binary format for loading policies. To find
policy format documentation see
Documentation/admin-guide/LSM/apparmor.rst.

In order to write the tests against the policy unpacking code, some
static functions needed to be exposed for testing purposes. One of the
goals of this patch is to establish a pattern for which testing these
kinds of functions should be done in the future.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
---
 security/apparmor/Kconfig              |  16 +
 security/apparmor/policy_unpack.c      |   4 +
 security/apparmor/policy_unpack_test.c | 607 +++++++++++++++++++++++++
 3 files changed, 627 insertions(+)
 create mode 100644 security/apparmor/policy_unpack_test.c

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index d8b1a360a6368..78a33ccac2574 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -66,3 +66,19 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
 	  Set the default value of the apparmor.debug kernel parameter.
 	  When enabled, various debug messages will be logged to
 	  the kernel message buffer.
+
+config SECURITY_APPARMOR_KUNIT_TEST
+	bool "Build KUnit tests for policy_unpack.c"
+	depends on KUNIT && SECURITY_APPARMOR
+	help
+	  This builds the AppArmor KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 8cfc9493eefc7..37c1dd3178fc0 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1120,3 +1120,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 
 	return error;
 }
+
+#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
+#include "policy_unpack_test.c"
+#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
new file mode 100644
index 0000000000000..533137f45361c
--- /dev/null
+++ b/security/apparmor/policy_unpack_test.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for AppArmor's policy unpack.
+ */
+
+#include <kunit/test.h>
+
+#include "include/policy.h"
+#include "include/policy_unpack.h"
+
+#define TEST_STRING_NAME "TEST_STRING"
+#define TEST_STRING_DATA "testing"
+#define TEST_STRING_BUF_OFFSET \
+	(3 + strlen(TEST_STRING_NAME) + 1)
+
+#define TEST_U32_NAME "U32_TEST"
+#define TEST_U32_DATA ((u32)0x01020304)
+#define TEST_NAMED_U32_BUF_OFFSET \
+	(TEST_STRING_BUF_OFFSET + 3 + strlen(TEST_STRING_DATA) + 1)
+#define TEST_U32_BUF_OFFSET \
+	(TEST_NAMED_U32_BUF_OFFSET + 3 + strlen(TEST_U32_NAME) + 1)
+
+#define TEST_U16_OFFSET (TEST_U32_BUF_OFFSET + 3)
+#define TEST_U16_DATA ((u16)(TEST_U32_DATA >> 16))
+
+#define TEST_U64_NAME "U64_TEST"
+#define TEST_U64_DATA ((u64)0x0102030405060708)
+#define TEST_NAMED_U64_BUF_OFFSET (TEST_U32_BUF_OFFSET + sizeof(u32) + 1)
+#define TEST_U64_BUF_OFFSET \
+	(TEST_NAMED_U64_BUF_OFFSET + 3 + strlen(TEST_U64_NAME) + 1)
+
+#define TEST_BLOB_NAME "BLOB_TEST"
+#define TEST_BLOB_DATA "\xde\xad\x00\xbe\xef"
+#define TEST_BLOB_DATA_SIZE (ARRAY_SIZE(TEST_BLOB_DATA))
+#define TEST_NAMED_BLOB_BUF_OFFSET (TEST_U64_BUF_OFFSET + sizeof(u64) + 1)
+#define TEST_BLOB_BUF_OFFSET \
+	(TEST_NAMED_BLOB_BUF_OFFSET + 3 + strlen(TEST_BLOB_NAME) + 1)
+
+#define TEST_ARRAY_NAME "ARRAY_TEST"
+#define TEST_ARRAY_SIZE 16
+#define TEST_NAMED_ARRAY_BUF_OFFSET \
+	(TEST_BLOB_BUF_OFFSET + 5 + TEST_BLOB_DATA_SIZE)
+#define TEST_ARRAY_BUF_OFFSET \
+	(TEST_NAMED_ARRAY_BUF_OFFSET + 3 + strlen(TEST_ARRAY_NAME) + 1)
+
+struct policy_unpack_fixture {
+	struct aa_ext *e;
+	size_t e_size;
+};
+
+struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
+				   struct kunit *test, size_t buf_size)
+{
+	char *buf;
+	struct aa_ext *e;
+
+	buf = kunit_kzalloc(test, buf_size, GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, buf);
+
+	e = kunit_kmalloc(test, sizeof(*e), GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, e);
+
+	e->start = buf;
+	e->end = e->start + buf_size;
+	e->pos = e->start;
+
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_STRING_NAME) + 1;
+	strcpy(buf + 3, TEST_STRING_NAME);
+
+	buf = e->start + TEST_STRING_BUF_OFFSET;
+	*buf = AA_STRING;
+	*(buf + 1) = strlen(TEST_STRING_DATA) + 1;
+	strcpy(buf + 3, TEST_STRING_DATA);
+
+	buf = e->start + TEST_NAMED_U32_BUF_OFFSET;
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
+	strcpy(buf + 3, TEST_U32_NAME);
+	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
+	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
+
+	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
+	strcpy(buf + 3, TEST_U64_NAME);
+	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
+	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
+
+	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_BLOB_NAME) + 1;
+	strcpy(buf + 3, TEST_BLOB_NAME);
+	*(buf + 3 + strlen(TEST_BLOB_NAME) + 1) = AA_BLOB;
+	*(buf + 3 + strlen(TEST_BLOB_NAME) + 2) = TEST_BLOB_DATA_SIZE;
+	memcpy(buf + 3 + strlen(TEST_BLOB_NAME) + 6,
+		TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE);
+
+	buf = e->start + TEST_NAMED_ARRAY_BUF_OFFSET;
+	*buf = AA_NAME;
+	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
+	strcpy(buf + 3, TEST_ARRAY_NAME);
+	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
+	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
+
+	return e;
+}
+
+static int policy_unpack_test_init(struct kunit *test)
+{
+	size_t e_size = TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1;
+	struct policy_unpack_fixture *puf;
+
+	puf = kunit_kmalloc(test, sizeof(*puf), GFP_USER);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, puf);
+
+	puf->e_size = e_size;
+	puf->e = build_aa_ext_struct(puf, test, e_size);
+
+	test->priv = puf;
+	return 0;
+}
+
+static void policy_unpack_test_inbounds_when_inbounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+
+	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, 0));
+	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, puf->e_size / 2));
+	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, puf->e_size));
+}
+
+static void policy_unpack_test_inbounds_when_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+
+	KUNIT_EXPECT_FALSE(test, inbounds(puf->e, puf->e_size + 1));
+}
+
+static void policy_unpack_test_unpack_array_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	u16 array_size;
+
+	puf->e->pos += TEST_ARRAY_BUF_OFFSET;
+
+	array_size = unpack_array(puf->e, NULL);
+
+	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
+}
+
+static void policy_unpack_test_unpack_array_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_ARRAY_NAME;
+	u16 array_size;
+
+	puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
+
+	array_size = unpack_array(puf->e, name);
+
+	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
+}
+
+static void policy_unpack_test_unpack_array_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_ARRAY_NAME;
+	u16 array_size;
+
+	puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
+	puf->e->end = puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16);
+
+	array_size = unpack_array(puf->e, name);
+
+	KUNIT_EXPECT_EQ(test, array_size, (u16)0);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_blob_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *blob = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_BLOB_BUF_OFFSET;
+	size = unpack_blob(puf->e, &blob, NULL);
+
+	KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);
+	KUNIT_EXPECT_TRUE(test,
+		memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
+}
+
+static void policy_unpack_test_unpack_blob_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *blob = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_NAMED_BLOB_BUF_OFFSET;
+	size = unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
+
+	KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);
+	KUNIT_EXPECT_TRUE(test,
+		memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
+}
+
+static void policy_unpack_test_unpack_blob_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *blob = NULL;
+	void *start;
+	int size;
+
+	puf->e->pos += TEST_NAMED_BLOB_BUF_OFFSET;
+	start = puf->e->pos;
+	puf->e->end = puf->e->start + TEST_BLOB_BUF_OFFSET
+		+ TEST_BLOB_DATA_SIZE - 1;
+
+	size = unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
+}
+
+static void policy_unpack_test_unpack_str_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char *string = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_STRING_BUF_OFFSET;
+	size = unpack_str(puf->e, &string, NULL);
+
+	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
+	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+}
+
+static void policy_unpack_test_unpack_str_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char *string = NULL;
+	size_t size;
+
+	size = unpack_str(puf->e, &string, TEST_STRING_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
+	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+}
+
+static void policy_unpack_test_unpack_str_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char *string = NULL;
+	void *start = puf->e->pos;
+	int size;
+
+	puf->e->end = puf->e->pos + TEST_STRING_BUF_OFFSET
+		+ strlen(TEST_STRING_DATA) - 1;
+
+	size = unpack_str(puf->e, &string, TEST_STRING_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
+}
+
+static void policy_unpack_test_unpack_strdup_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *string = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_STRING_BUF_OFFSET;
+	size = unpack_strdup(puf->e, &string, NULL);
+
+	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
+	KUNIT_EXPECT_FALSE(test,
+			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
+			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
+	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+}
+
+static void policy_unpack_test_unpack_strdup_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *string = NULL;
+	size_t size;
+
+	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
+	KUNIT_EXPECT_FALSE(test,
+			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
+			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
+	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+}
+
+static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	void *start = puf->e->pos;
+	char *string = NULL;
+	int size;
+
+	puf->e->end = puf->e->pos + TEST_STRING_BUF_OFFSET
+		+ strlen(TEST_STRING_DATA) - 1;
+
+	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
+
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_PTR_EQ(test, string, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
+}
+
+static void policy_unpack_test_unpack_nameX_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+
+	puf->e->pos += TEST_U32_BUF_OFFSET;
+
+	success = unpack_nameX(puf->e, AA_U32, NULL);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			    puf->e->start + TEST_U32_BUF_OFFSET + 1);
+}
+
+static void policy_unpack_test_unpack_nameX_with_wrong_code(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+
+	puf->e->pos += TEST_U32_BUF_OFFSET;
+
+	success = unpack_nameX(puf->e, AA_BLOB, NULL);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			    puf->e->start + TEST_U32_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_nameX_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U32_NAME;
+	bool success;
+
+	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
+
+	success = unpack_nameX(puf->e, AA_U32, name);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			    puf->e->start + TEST_U32_BUF_OFFSET + 1);
+}
+
+static void policy_unpack_test_unpack_nameX_with_wrong_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	static const char name[] = "12345678";
+	bool success;
+
+	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
+
+	success = unpack_nameX(puf->e, AA_U32, name);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			    puf->e->start + TEST_NAMED_U32_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_u16_chunk_basic(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *chunk = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_U16_OFFSET;
+	/*
+	 * WARNING: For unit testing purposes, we're pushing puf->e->end past
+	 * the end of the allocated memory. Doing anything other than comparing
+	 * memory addresses is dangerous.
+	 */
+	puf->e->end += TEST_U16_DATA;
+
+	size = unpack_u16_chunk(puf->e, &chunk);
+
+	KUNIT_EXPECT_PTR_EQ(test, (void *)chunk,
+			    puf->e->start + TEST_U16_OFFSET + 2);
+	KUNIT_EXPECT_EQ(test, size, (size_t)TEST_U16_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (void *)(chunk + TEST_U16_DATA));
+}
+
+static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
+		struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *chunk = NULL;
+	size_t size;
+
+	puf->e->pos = puf->e->end - 1;
+
+	size = unpack_u16_chunk(puf->e, &chunk);
+
+	KUNIT_EXPECT_EQ(test, size, (size_t)0);
+	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
+}
+
+static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
+		struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	char *chunk = NULL;
+	size_t size;
+
+	puf->e->pos += TEST_U16_OFFSET;
+	/*
+	 * WARNING: For unit testing purposes, we're pushing puf->e->end past
+	 * the end of the allocated memory. Doing anything other than comparing
+	 * memory addresses is dangerous.
+	 */
+	puf->e->end = puf->e->pos + TEST_U16_DATA - 1;
+
+	size = unpack_u16_chunk(puf->e, &chunk);
+
+	KUNIT_EXPECT_EQ(test, size, (size_t)0);
+	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
+}
+
+static void policy_unpack_test_unpack_u32_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+	u32 data;
+
+	puf->e->pos += TEST_U32_BUF_OFFSET;
+
+	success = unpack_u32(puf->e, &data, NULL);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_EQ(test, data, TEST_U32_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32) + 1);
+}
+
+static void policy_unpack_test_unpack_u32_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U32_NAME;
+	bool success;
+	u32 data;
+
+	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
+
+	success = unpack_u32(puf->e, &data, name);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_EQ(test, data, TEST_U32_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32) + 1);
+}
+
+static void policy_unpack_test_unpack_u32_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U32_NAME;
+	bool success;
+	u32 data;
+
+	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
+	puf->e->end = puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32);
+
+	success = unpack_u32(puf->e, &data, name);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_NAMED_U32_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_u64_with_null_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+	u64 data;
+
+	puf->e->pos += TEST_U64_BUF_OFFSET;
+
+	success = unpack_u64(puf->e, &data, NULL);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_EQ(test, data, TEST_U64_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64) + 1);
+}
+
+static void policy_unpack_test_unpack_u64_with_name(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U64_NAME;
+	bool success;
+	u64 data;
+
+	puf->e->pos += TEST_NAMED_U64_BUF_OFFSET;
+
+	success = unpack_u64(puf->e, &data, name);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_EQ(test, data, TEST_U64_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64) + 1);
+}
+
+static void policy_unpack_test_unpack_u64_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	const char name[] = TEST_U64_NAME;
+	bool success;
+	u64 data;
+
+	puf->e->pos += TEST_NAMED_U64_BUF_OFFSET;
+	puf->e->end = puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64);
+
+	success = unpack_u64(puf->e, &data, name);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
+			puf->e->start + TEST_NAMED_U64_BUF_OFFSET);
+}
+
+static void policy_unpack_test_unpack_X_code_match(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success = unpack_X(puf->e, AA_NAME);
+
+	KUNIT_EXPECT_TRUE(test, success);
+	KUNIT_EXPECT_TRUE(test, puf->e->pos == puf->e->start + 1);
+}
+
+static void policy_unpack_test_unpack_X_code_mismatch(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success = unpack_X(puf->e, AA_STRING);
+
+	KUNIT_EXPECT_FALSE(test, success);
+	KUNIT_EXPECT_TRUE(test, puf->e->pos == puf->e->start);
+}
+
+static void policy_unpack_test_unpack_X_out_of_bounds(struct kunit *test)
+{
+	struct policy_unpack_fixture *puf = test->priv;
+	bool success;
+
+	puf->e->pos = puf->e->end;
+	success = unpack_X(puf->e, AA_NAME);
+
+	KUNIT_EXPECT_FALSE(test, success);
+}
+
+static struct kunit_case apparmor_policy_unpack_test_cases[] = {
+	KUNIT_CASE(policy_unpack_test_inbounds_when_inbounds),
+	KUNIT_CASE(policy_unpack_test_inbounds_when_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_array_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_array_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_array_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_blob_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_blob_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_blob_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_wrong_code),
+	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_wrong_name),
+	KUNIT_CASE(policy_unpack_test_unpack_str_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_str_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_str_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_strdup_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_strdup_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_strdup_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_basic),
+	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_out_of_bounds_1),
+	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_out_of_bounds_2),
+	KUNIT_CASE(policy_unpack_test_unpack_u32_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_u32_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_u32_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_u64_with_null_name),
+	KUNIT_CASE(policy_unpack_test_unpack_u64_with_name),
+	KUNIT_CASE(policy_unpack_test_unpack_u64_out_of_bounds),
+	KUNIT_CASE(policy_unpack_test_unpack_X_code_match),
+	KUNIT_CASE(policy_unpack_test_unpack_X_code_mismatch),
+	KUNIT_CASE(policy_unpack_test_unpack_X_out_of_bounds),
+	{},
+};
+
+static struct kunit_suite apparmor_policy_unpack_test_module = {
+	.name = "apparmor_policy_unpack",
+	.init = policy_unpack_test_init,
+	.test_cases = apparmor_policy_unpack_test_cases,
+};
+
+kunit_test_suite(apparmor_policy_unpack_test_module);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

