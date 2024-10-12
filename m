Return-Path: <linux-kselftest+bounces-19591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A8399B1C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB581C2119A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A913E41A;
	Sat, 12 Oct 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="qTyeSzD/";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="iBH8OJxW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C413AA41
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719076; cv=none; b=vGMKEyFlk32cyrLtMOe2oISXeB3nTqryNb2x+RQqzy0dgCO4Vq1BNI2j+1pu6pL8atXLD/ep7LqU01gUXlaKws0XR/UuYa0P8HaOZo3PnwKfUp6MACDOwsmVeDt+VAl3TkAoC5y7c3qVD8a0HbpP3y4HdMNMk0Te6cBjmpnEp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719076; c=relaxed/simple;
	bh=e3ZqeMcbGg68tcxds0Il+s1IKnUsyAgfNhEnmq5+7eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CXikhGetoBxybdxG8DByxCmyGB3duIOqTNiVY+1UFQyjMnr+ZL3tAHe1hABRs9c3VI34kGvyvtR6S03Jy3xN4OKWggNk/Cj30p8tER5j4lqSxtq1GhGXwb9VI2g/nXh+wStUQL0AZIKKdCjmfa+C06IAWa2dl/JOY+UQRZ9l3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=qTyeSzD/; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=iBH8OJxW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=qTyeSzD/NcWdvP8JGReoQkCnF126XymZgEcowvW9wm+BZ2N3GiKX8O3XrreYYgIXpmMkghGTL61S0eKyVCHGoRSRQsXwAYVcL8sTncskVlIqTorF37/VuSk468c1Plq3bNfuKrp7h8CvfyZks6XkXxXXtNa92YIjSuyTHpqJ8ZINE5I5Pt6RC5UdqUUoQskPwHUAbn6Ij5xMkjbrJ8hnLyTrFuViXN2FyGjVXAx0cVI2Yh93QSPtWbvP48TJ7X/Nq8o0Xej4mLKfD7toxR9eGnQMZNsJ0MTwusuxeXTU+YxANZN7ioNcaSRF8U6M2ooZ7yyllep6M8jXetB2IZC5KA==; s=purelymail3; d=lkcamp.dev; v=1; bh=e3ZqeMcbGg68tcxds0Il+s1IKnUsyAgfNhEnmq5+7eE=; h=Received:From:Date:Subject:To;
DKIM-Signature: a=rsa-sha256; b=iBH8OJxWwuOqTAWzvZCpuE+BgoDf3XKMmyEbqsVxFoqptRTKm/vDf5xfU76fWHnFfCdF1a2KPKDda9nv1ZUkU0DiUdpbYdnCnrUQ/TiqpBrMn1rBXxwiaDWIOrz1O/EyBHyj7ZAZupWlE7ue4aCiU6ZpZhvqulcn/8qo2+1Wvg/adkE7OnaeQYsfrAOg0I6/ZLV37SkBUQMMUQACwLp5wHj6hA2c4+y/m6XhMnRjzJ7dplnv1RUKd+VwLuRJpaRdz3xwU4dun5WUynTDME+HyG6uCsnjwK0IeSnbPxVhIqSOE4Cuf+iOuNxL+oIXfRE5qJeT18Ko2Q7xYFrPBST7sA==; s=purelymail3; d=purelymail.com; v=1; bh=e3ZqeMcbGg68tcxds0Il+s1IKnUsyAgfNhEnmq5+7eE=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1160887674;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 12 Oct 2024 07:44:08 +0000 (UTC)
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Date: Sat, 12 Oct 2024 04:43:49 -0300
Subject: [PATCH v3] lib/crc16_kunit.c: add KUnit tests for crc16
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-crc16-kunit-v3-1-0ca75cb58ca9@lkcamp.dev>
X-B4-Tracking: v=1; b=H4sIALQoCmcC/23MQQ6CMBCF4auQWTumM6AkrryHYVHKIBMUSIuNh
 vTuVtYu/5e8b4MgXiXApdjAS9Sg85SjPBTgBjvdBbXLDWy4ImNKdN7RGcfXpCsS17bqHLc1O8i
 PxUuv7127NbkHDevsPzse+bf+dyIj4amXumqJSiG5PkZnn8uxkwhNSukLm5uuxKcAAAA=
X-Change-ID: 20241003-crc16-kunit-127a4dc2b72c
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Vinicius Peixoto <vpeixoto@lkcamp.dev>, 
 Enzo Bertoloti <ebertoloti@lkcamp.dev>, 
 Fabricio Gasperin <fgasperin@lkcamp.dev>, 
 David Laight <David.Laight@ACULAB.COM>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7694; i=vpeixoto@lkcamp.dev;
 h=from:subject:message-id; bh=e3ZqeMcbGg68tcxds0Il+s1IKnUsyAgfNhEnmq5+7eE=;
 b=owEBbQKS/ZANAwAIARxog1gjPe4wAcsmYgBnCijHTndxZ3w9HBUvYVrkUfpvbJZQAzq1kaSwI
 4UHOKno21iJAjMEAAEIAB0WIQQhoIfFASXPhkPZWXMcaINYIz3uMAUCZwooxwAKCRAcaINYIz3u
 MPuOEACa54D9+8jmcrjrKBD7paWxpjsuZCPut2dUAfWQ90aq5JWMU984JtG90KXa+MZklQkfhH9
 dkWsRyIgYe+nNBxbByZ7S3s/HnzURAqMKZbJJRrRLtGgehpznp2lFXcWqn5IDlAAkUw3wrF+Njw
 CXQA27xh6RwWIdeS5fwgUE41ISkXjXNsyR+o62w4W1nVL7Ruwn1NMNBQJyCu52hvAnawt1KZLM3
 Ye9i8sS2IQeLbSRxpm8LcvmhmCacZKZLIgLHylb2fEfrexbVJGrkIuhiJpxVFbTusatrt2RKMLt
 nHHkNcoxunyi+7oKJPexCGMts7L+uiRAUUYzV89EsTddx7bi5Zh6HAkXENcxAVNif5olKCTyZE9
 4MIf8AVG/lXBaOiqAsC0VGLfLuFRuiZeE4IndYtpkvI9pj4yiPq9xCdVgiMhpIMxI5RWdaxPoK9
 nKA68G9jcyq9NE3dmxaS6lB6bkmXrDhAKNp8gY6d8r+BD7nQUvew/h2gVaaBTsFrisq6xJ9FKAX
 5/vFABQ9rp1xITPai2XZOx6SXod+G6WMb8i0rsZEV4uciia5a7wwToK30NFu/9aWDcJeUF3/qJy
 DZQjaPonDl30b8xUwSRMKMedmMsqcleOS6IN3GSht8ringBKRw2leuY2hYnVm7JRaz/WTzBZCHe
 VnWgWGbfjdl1Mcg==
X-Developer-Key: i=vpeixoto@lkcamp.dev; a=openpgp;
 fpr=0346D64B6E44D15FCEDF4B17DAA5186768156B42

Add Kunit tests for the kernel's implementation of the standard CRC-16
algorithm (<linux/crc16.h>). The test data consists of 100
randomly-generated test cases, validated against a naive CRC-16
implementation.

This test follows roughly the same logic as lib/crc32test.c, but
without the performance measurements.

Signed-off-by: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Co-developed-by: Enzo Bertoloti <ebertoloti@lkcamp.dev>
Signed-off-by: Enzo Bertoloti <ebertoloti@lkcamp.dev>
Co-developed-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
Signed-off-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
Suggested-by: David Laight <David.Laight@ACULAB.COM>
---
This patch was developed during a hackathon organized by LKCAMP [1],
with the objective of writing KUnit tests, both to introduce people to
the kernel development process and to learn about different subsystems
(with the positive side effect of improving the kernel test coverage, of
course).

We noticed there were tests for CRC32 in lib/crc32test.c and thought it
would be nice to have something similar for CRC16, since it seems to be
widely used in network drivers (as well as in some ext4 code).

We would really appreciate any feedback/suggestions on how to improve
this. Thanks! :-)

Changes in v2 (suggested by David Laight):
  - Use the PRNG from include/linux/prandom.h to generate pseudorandom
    data/test cases instead of having them hardcoded as large static
    arrays
  - Add a naive CRC16 implementation used to validate the kernel's
    implementation (instead of having the test case results be hard-coded)
  - Link to v1: https://lore.kernel.org/linux-kselftest/20240922232643.535329-1-vpeixoto@lkcamp.dev/

Changes in v3:
  - Fix compilation warnings about function documentation
  - Link to v2: https://lore.kernel.org/r/20241003-crc16-kunit-v2-1-5fe74b113e1e@lkcamp.dev

[1] https://lkcamp.dev/about
---
 lib/Kconfig.debug |   9 ++++
 lib/Makefile      |   1 +
 lib/crc16_kunit.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817ae1021f1e4b3dd27b424f49e3f761..f9617e3054948ce43090f524dc67650e9549cee8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2850,6 +2850,15 @@ config USERCOPY_KUNIT_TEST
 	  on the copy_to/from_user infrastructure, making sure basic
 	  user/kernel boundary testing is working.
 
+config CRC16_KUNIT_TEST
+	tristate "KUnit tests for CRC16"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select CRC16
+	help
+	  Enable this option to run unit tests for the kernel's CRC16
+	  implementation (<linux/crc16.h>).
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41665b2419202e5427e0513c6becae..1faed6414a85fd366b4966a00e8ba231d7546e14 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -389,6 +389,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
+obj-$(CONFIG_CRC16_KUNIT_TEST) += crc16_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/crc16_kunit.c b/lib/crc16_kunit.c
new file mode 100644
index 0000000000000000000000000000000000000000..0918c98a96d26f4e795e3eb92923db7c549ac01f
--- /dev/null
+++ b/lib/crc16_kunit.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnits tests for CRC16.
+ *
+ * Copyright (C) 2024, LKCAMP
+ * Author: Vinicius Peixoto <vpeixoto@lkcamp.dev>
+ * Author: Fabricio Gasperin <fgasperin@lkcamp.dev>
+ * Author: Enzo Bertoloti <ebertoloti@lkcamp.dev>
+ */
+#include <kunit/test.h>
+#include <linux/crc16.h>
+#include <linux/prandom.h>
+
+#define CRC16_KUNIT_DATA_SIZE 4096
+#define CRC16_KUNIT_TEST_SIZE 100
+#define CRC16_KUNIT_SEED 0x12345678
+
+/**
+ * struct crc16_test - CRC16 test data
+ * @crc: initial input value to CRC16
+ * @start: Start index within the data buffer
+ * @length: Length of the data
+ */
+static struct crc16_test {
+	u16 crc;
+	u16 start;
+	u16 length;
+} tests[CRC16_KUNIT_TEST_SIZE];
+
+u8 data[CRC16_KUNIT_DATA_SIZE];
+
+
+/* Naive implementation of CRC16 for validation purposes */
+static inline u16 _crc16_naive_byte(u16 crc, u8 data)
+{
+	u8 i = 0;
+
+	crc ^= (u16) data;
+	for (i = 0; i < 8; i++) {
+		if (crc & 0x01)
+			crc = (crc >> 1) ^ 0xa001;
+		else
+			crc = crc >> 1;
+	}
+
+	return crc;
+}
+
+
+static inline u16 _crc16_naive(u16 crc, u8 *buffer, size_t len)
+{
+	while (len--)
+		crc = _crc16_naive_byte(crc, *buffer++);
+	return crc;
+}
+
+
+/* Small helper for generating pseudorandom 16-bit data */
+static inline u16 _rand16(void)
+{
+	static u32 rand = CRC16_KUNIT_SEED;
+
+	rand = next_pseudo_random32(rand);
+	return rand & 0xFFFF;
+}
+
+
+static int crc16_init_test_data(struct kunit_suite *suite)
+{
+	size_t i;
+
+	/* Fill the data buffer with random bytes */
+	for (i = 0; i < CRC16_KUNIT_DATA_SIZE; i++)
+		data[i] = _rand16() & 0xFF;
+
+	/* Generate random test data while ensuring the random
+	 * start + length values won't overflow the 4096-byte
+	 * buffer (0x7FF * 2 = 0xFFE < 0x1000)
+	 */
+	for (size_t i = 0; i < CRC16_KUNIT_TEST_SIZE; i++) {
+		tests[i].crc = _rand16();
+		tests[i].start = _rand16() & 0x7FF;
+		tests[i].length = _rand16() & 0x7FF;
+	}
+
+	return 0;
+}
+
+static void crc16_test_empty(struct kunit *test)
+{
+	u16 crc;
+
+	/* The result for empty data should be the same as the
+	 * initial crc
+	 */
+	crc = crc16(0x00, data, 0);
+	KUNIT_EXPECT_EQ(test, crc, 0);
+	crc = crc16(0xFF, data, 0);
+	KUNIT_EXPECT_EQ(test, crc, 0xFF);
+}
+
+static void crc16_test_correctness(struct kunit *test)
+{
+	size_t i;
+	u16 crc, crc_naive;
+
+	for (i = 0; i < CRC16_KUNIT_TEST_SIZE; i++) {
+		/* Compare results with the naive crc16 implementation */
+		crc = crc16(tests[i].crc, data + tests[i].start,
+			    tests[i].length);
+		crc_naive = _crc16_naive(tests[i].crc, data + tests[i].start,
+					 tests[i].length);
+		KUNIT_EXPECT_EQ(test, crc, crc_naive);
+	}
+}
+
+
+static void crc16_test_combine(struct kunit *test)
+{
+	size_t i, j;
+	u16 crc, crc_naive;
+
+	/* Make sure that combining two consecutive crc16 calculations
+	 * yields the same result as calculating the crc16 for the whole thing
+	 */
+	for (i = 0; i < CRC16_KUNIT_TEST_SIZE; i++) {
+		crc_naive = crc16(tests[i].crc, data + tests[i].start, tests[i].length);
+		for (j = 0; j < tests[i].length; j++) {
+			crc = crc16(tests[i].crc, data + tests[i].start, j);
+			crc = crc16(crc, data + tests[i].start + j, tests[i].length - j);
+			KUNIT_EXPECT_EQ(test, crc, crc_naive);
+		}
+	}
+}
+
+
+static struct kunit_case crc16_test_cases[] = {
+	KUNIT_CASE(crc16_test_empty),
+	KUNIT_CASE(crc16_test_combine),
+	KUNIT_CASE(crc16_test_correctness),
+	{},
+};
+
+static struct kunit_suite crc16_test_suite = {
+	.name = "crc16",
+	.test_cases = crc16_test_cases,
+	.suite_init = crc16_init_test_data,
+};
+kunit_test_suite(crc16_test_suite);
+
+MODULE_AUTHOR("Fabricio Gasperin <fgasperin@lkcamp.dev>");
+MODULE_AUTHOR("Vinicius Peixoto <vpeixoto@lkcamp.dev>");
+MODULE_AUTHOR("Enzo Bertoloti <ebertoloti@lkcamp.dev>");
+MODULE_DESCRIPTION("Unit tests for crc16");
+MODULE_LICENSE("GPL");

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241003-crc16-kunit-127a4dc2b72c

Best regards,
-- 
Vinicius Peixoto <vpeixoto@lkcamp.dev>


