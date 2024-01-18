Return-Path: <linux-kselftest+bounces-3195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013968318BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 12:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260B01C21BF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792524200;
	Thu, 18 Jan 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jNB7agFo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D421A12
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578757; cv=none; b=cUkPZgmWohfIiseLx3VwZSvXrYbCHzjfxWUULwbNOdVIRFuV6HM7Oyn2pAKoaxZCtyHnh/AVQdxNQj9szv0gIVMep+khLQ1AJis2sBwyC43lO5IuEZtySG9gfOl3ocBFlpcGm1N+dwaNQqlHTU+DoTQrNhoBM9pPCejdWPF24wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578757; c=relaxed/simple;
	bh=Jc+AgFkDOJ2nln/Hh25Tk4HHGUIAlDv8VMLb9QLdsWE=;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing; b=orT7OTimT/bc6eY6YmEK66ZepdKybDAIxDRp1sSYtQsklPRVMAy+rKkuwzvxZHdMWvWn8/Moe3D0g1oV0GnOnza4HWtMdxv676RDP9Au+erR54nUzGpgXfbHvuEnY7Ohvul5uQRSnN592h0z1eBmYtzP/SUzt1it/qBGB9TrY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jNB7agFo; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TG11336d3zMs8Kp;
	Thu, 18 Jan 2024 11:36:39 +0000 (UTC)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TG1115qn1zSM;
	Thu, 18 Jan 2024 12:36:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1705577799;
	bh=Jc+AgFkDOJ2nln/Hh25Tk4HHGUIAlDv8VMLb9QLdsWE=;
	h=From:To:Cc:Subject:Date:From;
	b=jNB7agForkvhkU0+GplxJkKhxpqdCFnsU9JeGB5ScFRtw5Z0lghO8aP74XLHrmMvO
	 K/N8Ceb6J57d4/LfGmWkOyAJ+0OEFBV2AZt15rD41Wy5z24CYdWbpsXuL5ZJC7pKOX
	 kI8Fys2BAetr6aTG+of6paiHfjzbRoXtb8gRr+wQ=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	Jeff Xu <jeffxu@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1] landlock: Add support for KUnit tests
Date: Thu, 18 Jan 2024 12:36:32 +0100
Message-ID: <20240118113632.1948478-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add the SECURITY_LANDLOCK_KUNIT_TEST option to enable KUnit tests for
Landlock.  The minimal required configuration is listed in the
security/landlock/.kunitconfig file.

Add an initial landlock_fs KUnit test suite with 7 test cases for
filesystem helpers.  These are related to the LANDLOCK_ACCESS_FS_REFER
right.

There is one KUnit test case per:
* mutated state (e.g. test_scope_to_request_*) or,
* shared state between tests (e.g. test_is_eaccess_*).

Add macros to improve readability of tests (i.e. one per line).  Test
cases are collocated with the tested functions to help maintenance and
improve documentation.  This is why SECURITY_LANDLOCK_KUNIT_TEST cannot
be set as module.

This is a nice complement to Landlock's user space kselftests.  We
expect new Landlock features to come with KUnit tests as well.

Thanks to UML support, we can run all KUnit tests for Landlock with:
./tools/testing/kunit/kunit.py run --kunitconfig security/landlock

[00:00:00] ======================= landlock_fs  =======================
[00:00:00] [PASSED] test_no_more_access
[00:00:00] [PASSED] test_scope_to_request_with_exec_none
[00:00:00] [PASSED] test_scope_to_request_with_exec_some
[00:00:00] [PASSED] test_scope_to_request_without_access
[00:00:00] [PASSED] test_is_eacces_with_none
[00:00:00] [PASSED] test_is_eacces_with_refer
[00:00:00] [PASSED] test_is_eacces_with_write
[00:00:00] =================== [PASSED] landlock_fs ===================
[00:00:00] ============================================================
[00:00:00] Testing complete. Ran 7 tests: passed: 7

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/.kunitconfig               |   4 +
 security/landlock/Kconfig                    |  15 ++
 security/landlock/common.h                   |   2 +
 security/landlock/fs.c                       | 234 +++++++++++++++++++
 tools/testing/kunit/configs/all_tests.config |   1 +
 5 files changed, 256 insertions(+)
 create mode 100644 security/landlock/.kunitconfig

diff --git a/security/landlock/.kunitconfig b/security/landlock/.kunitconfig
new file mode 100644
index 000000000000..03e119466604
--- /dev/null
+++ b/security/landlock/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_SECURITY=y
+CONFIG_SECURITY_LANDLOCK=y
+CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=y
diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
index c4bf0d5eff39..3f1493402052 100644
--- a/security/landlock/Kconfig
+++ b/security/landlock/Kconfig
@@ -20,3 +20,18 @@ config SECURITY_LANDLOCK
 	  If you are unsure how to answer this question, answer N.  Otherwise,
 	  you should also prepend "landlock," to the content of CONFIG_LSM to
 	  enable Landlock at boot time.
+
+config SECURITY_LANDLOCK_KUNIT_TEST
+	bool "KUnit tests for Landlock" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	depends on SECURITY_LANDLOCK
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests for Landlock.
+
+	  See the KUnit documentation in Documentation/dev-tools/kunit
+
+	  Run all KUnit tests for Landlock with:
+	  ./tools/testing/kunit/kunit.py run --kunitconfig security/landlock
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/landlock/common.h b/security/landlock/common.h
index 5dc0fe15707d..0eb1d34c2eae 100644
--- a/security/landlock/common.h
+++ b/security/landlock/common.h
@@ -17,4 +17,6 @@
 
 #define pr_fmt(fmt) LANDLOCK_NAME ": " fmt
 
+#define BIT_INDEX(bit) HWEIGHT(bit - 1)
+
 #endif /* _SECURITY_LANDLOCK_COMMON_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 9ba989ef46a5..a2fdbd560105 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -7,6 +7,7 @@
  * Copyright © 2021-2022 Microsoft Corporation
  */
 
+#include <kunit/test.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
@@ -311,6 +312,119 @@ static bool no_more_access(
 	return true;
 }
 
+#define NMA_TRUE(...) KUNIT_EXPECT_TRUE(test, no_more_access(__VA_ARGS__))
+#define NMA_FALSE(...) KUNIT_EXPECT_FALSE(test, no_more_access(__VA_ARGS__))
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_no_more_access(struct kunit *const test)
+{
+	const layer_mask_t rx0[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = BIT_ULL(0),
+	};
+	const layer_mask_t mx0[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] = BIT_ULL(0),
+	};
+	const layer_mask_t x0[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
+	};
+	const layer_mask_t x1[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(1),
+	};
+	const layer_mask_t x01[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0) |
+							  BIT_ULL(1),
+	};
+	const layer_mask_t allows_all[LANDLOCK_NUM_ACCESS_FS] = {};
+
+	/* Checks without restriction. */
+	NMA_TRUE(&x0, &allows_all, false, &allows_all, NULL, false);
+	NMA_TRUE(&allows_all, &x0, false, &allows_all, NULL, false);
+	NMA_FALSE(&x0, &x0, false, &allows_all, NULL, false);
+
+	/*
+	 * Checks that we can only refer a file if no more access could be
+	 * inherited.
+	 */
+	NMA_TRUE(&x0, &x0, false, &rx0, NULL, false);
+	NMA_TRUE(&rx0, &rx0, false, &rx0, NULL, false);
+	NMA_FALSE(&rx0, &rx0, false, &x0, NULL, false);
+	NMA_FALSE(&rx0, &rx0, false, &x1, NULL, false);
+
+	/* Checks allowed referring with different nested domains. */
+	NMA_TRUE(&x0, &x1, false, &x0, NULL, false);
+	NMA_TRUE(&x1, &x0, false, &x0, NULL, false);
+	NMA_TRUE(&x0, &x01, false, &x0, NULL, false);
+	NMA_TRUE(&x0, &x01, false, &rx0, NULL, false);
+	NMA_TRUE(&x01, &x0, false, &x0, NULL, false);
+	NMA_TRUE(&x01, &x0, false, &rx0, NULL, false);
+	NMA_FALSE(&x01, &x01, false, &x0, NULL, false);
+
+	/* Checks that file access rights are also enforced for a directory. */
+	NMA_FALSE(&rx0, &rx0, true, &x0, NULL, false);
+
+	/* Checks that directory access rights don't impact file referring... */
+	NMA_TRUE(&mx0, &mx0, false, &x0, NULL, false);
+	/* ...but only directory referring. */
+	NMA_FALSE(&mx0, &mx0, true, &x0, NULL, false);
+
+	/* Checks directory exchange. */
+	NMA_TRUE(&mx0, &mx0, true, &mx0, &mx0, true);
+	NMA_TRUE(&mx0, &mx0, true, &mx0, &x0, true);
+	NMA_FALSE(&mx0, &mx0, true, &x0, &mx0, true);
+	NMA_FALSE(&mx0, &mx0, true, &x0, &x0, true);
+	NMA_FALSE(&mx0, &mx0, true, &x1, &x1, true);
+
+	/* Checks file exchange with directory access rights... */
+	NMA_TRUE(&mx0, &mx0, false, &mx0, &mx0, false);
+	NMA_TRUE(&mx0, &mx0, false, &mx0, &x0, false);
+	NMA_TRUE(&mx0, &mx0, false, &x0, &mx0, false);
+	NMA_TRUE(&mx0, &mx0, false, &x0, &x0, false);
+	/* ...and with file access rights. */
+	NMA_TRUE(&rx0, &rx0, false, &rx0, &rx0, false);
+	NMA_TRUE(&rx0, &rx0, false, &rx0, &x0, false);
+	NMA_FALSE(&rx0, &rx0, false, &x0, &rx0, false);
+	NMA_FALSE(&rx0, &rx0, false, &x0, &x0, false);
+	NMA_FALSE(&rx0, &rx0, false, &x1, &x1, false);
+
+	/*
+	 * Allowing the following requests should not be a security risk
+	 * because domain 0 denies execute access, and domain 1 is always
+	 * nested with domain 0.  However, adding an exception for this case
+	 * would mean to check all nested domains to make sure none can get
+	 * more privileges (e.g. processes only sandboxed by domain 0).
+	 * Moreover, this behavior (i.e. composition of N domains) could then
+	 * be inconsistent compared to domain 1's ruleset alone (e.g. it might
+	 * be denied to link/rename with domain 1's ruleset, whereas it would
+	 * be allowed if nested on top of domain 0).  Another drawback would be
+	 * to create a cover channel that could enable sandboxed processes to
+	 * infer most of the filesystem restrictions from their domain.  To
+	 * make it simple, efficient, safe, and more consistent, this case is
+	 * always denied.
+	 */
+	NMA_FALSE(&x1, &x1, false, &x0, NULL, false);
+	NMA_FALSE(&x1, &x1, false, &rx0, NULL, false);
+	NMA_FALSE(&x1, &x1, true, &x0, NULL, false);
+	NMA_FALSE(&x1, &x1, true, &rx0, NULL, false);
+
+	/* Checks the same case of exclusive domains with a file... */
+	NMA_TRUE(&x1, &x1, false, &x01, NULL, false);
+	NMA_FALSE(&x1, &x1, false, &x01, &x0, false);
+	NMA_FALSE(&x1, &x1, false, &x01, &x01, false);
+	NMA_FALSE(&x1, &x1, false, &x0, &x0, false);
+	/* ...and with a directory. */
+	NMA_FALSE(&x1, &x1, false, &x0, &x0, true);
+	NMA_FALSE(&x1, &x1, true, &x0, &x0, false);
+	NMA_FALSE(&x1, &x1, true, &x0, &x0, true);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+#undef NMA_TRUE
+#undef NMA_FALSE
+
 /*
  * Removes @layer_masks accesses that are not requested.
  *
@@ -331,6 +445,57 @@ scope_to_request(const access_mask_t access_request,
 	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
 }
 
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_scope_to_request_with_exec_none(struct kunit *const test)
+{
+	/* Allows everything. */
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+
+	/* Checks and scopes with execute. */
+	KUNIT_EXPECT_TRUE(test, scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE,
+						 &layer_masks));
+	KUNIT_EXPECT_EQ(test, 0,
+			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
+	KUNIT_EXPECT_EQ(test, 0,
+			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
+}
+
+static void test_scope_to_request_with_exec_some(struct kunit *const test)
+{
+	/* Denies execute and write. */
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = BIT_ULL(1),
+	};
+
+	/* Checks and scopes with execute. */
+	KUNIT_EXPECT_FALSE(test, scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE,
+						  &layer_masks));
+	KUNIT_EXPECT_EQ(test, BIT_ULL(0),
+			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
+	KUNIT_EXPECT_EQ(test, 0,
+			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
+}
+
+static void test_scope_to_request_without_access(struct kunit *const test)
+{
+	/* Denies execute and write. */
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = BIT_ULL(1),
+	};
+
+	/* Checks and scopes without access request. */
+	KUNIT_EXPECT_TRUE(test, scope_to_request(0, &layer_masks));
+	KUNIT_EXPECT_EQ(test, 0,
+			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
+	KUNIT_EXPECT_EQ(test, 0,
+			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
 /*
  * Returns true if there is at least one access right different than
  * LANDLOCK_ACCESS_FS_REFER.
@@ -354,6 +519,51 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
 	return false;
 }
 
+#define IE_TRUE(...) KUNIT_EXPECT_TRUE(test, is_eacces(__VA_ARGS__))
+#define IE_FALSE(...) KUNIT_EXPECT_FALSE(test, is_eacces(__VA_ARGS__))
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_is_eacces_with_none(struct kunit *const test)
+{
+	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+
+	IE_FALSE(&layer_masks, 0);
+	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
+	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
+	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
+}
+
+static void test_is_eacces_with_refer(struct kunit *const test)
+{
+	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = BIT_ULL(0),
+	};
+
+	IE_FALSE(&layer_masks, 0);
+	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
+	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
+	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
+}
+
+static void test_is_eacces_with_write(struct kunit *const test)
+{
+	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = BIT_ULL(0),
+	};
+
+	IE_FALSE(&layer_masks, 0);
+	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
+	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
+
+	IE_TRUE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+#undef IE_TRUE
+#undef IE_FALSE
+
 /**
  * is_access_to_paths_allowed - Check accesses for requests with a common path
  *
@@ -1225,3 +1435,27 @@ __init void landlock_add_fs_hooks(void)
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
 			   LANDLOCK_NAME);
 }
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+/* clang-format off */
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(test_no_more_access),
+	KUNIT_CASE(test_scope_to_request_with_exec_none),
+	KUNIT_CASE(test_scope_to_request_with_exec_some),
+	KUNIT_CASE(test_scope_to_request_without_access),
+	KUNIT_CASE(test_is_eacces_with_none),
+	KUNIT_CASE(test_is_eacces_with_refer),
+	KUNIT_CASE(test_is_eacces_with_write),
+	{}
+};
+/* clang-format on */
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_fs",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 3bf506d4a63c..1b8f1abfedf0 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -37,6 +37,7 @@ CONFIG_REGMAP_BUILD=y
 
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y
+CONFIG_SECURITY_LANDLOCK=y
 
 CONFIG_SOUND=y
 CONFIG_SND=y

base-commit: 0daaa610c8e033cdfb420db728c2b40eb3a75134
-- 
2.43.0


