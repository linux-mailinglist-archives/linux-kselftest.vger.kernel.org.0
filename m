Return-Path: <linux-kselftest+bounces-18979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9086198F862
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EDBB21FD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B145D1B85D3;
	Thu,  3 Oct 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="mC/1XAlO";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="t6aeqy2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8C1ABEBD
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989284; cv=none; b=KqFzJanubbDBwX8CtyM1QKzCdHve9EvpipxunkxF9RD2WNU/tUy/A2mgPESPIZw/dzwaprdNLy+lPD6tWymO2x3Ys9xH1e9WOQ5RL42x3pSHPOfd7+RnD0KRFOrQKpS6PqCEee+AeEXSr5a/WSVQRzIpSk0Uk1FGoEyJqGtU7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989284; c=relaxed/simple;
	bh=T4TRMiQNqSrX3GFvcaWSV+l6s/NF6TPrnSmNVzd+xmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bGA0J9X3AILZlGl28viAuj6pk+ZYEb3b+5mbuqoZm1lQfxxeGPJ4eZT/T+P6MUF5SYK0ad/j53At0DE2eZj6ixiYChLhfgKe+KHRAP4Of9KNpJJDJiH6gXFHoUpr8bozAMOR3e4tQjUlA5eKnChDD5N00HdvpSH4Ew20ZgnQvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=mC/1XAlO; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=t6aeqy2B; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=mC/1XAlOTGhep/GnhwzomuIJRQ0uLWdT40kzQQpUEq+bIecsFdpV8chShaJAx0RTs5uNZTIaHO7GSIc0Y26HHuzlf2yoHds67YSErKQ8xz8L/U6aQvVyH1XVJbGpiagjuDWAdLBEfWbfFQlY3uY3a4AMZovTprYhdGCbCSmDYmaCLJ0V66rsSY8tmtWbCmPYllqqdnQkMnvDnuudj0gNEgf8YWtUqYyfaoyvxn7ZIc/2C7nIotUb4NJm7qG7+eliS8FChIuuK1R0xkl4u3OoAVqdxsb1BJq9tOSyFTUgGqPPAdfPUYVbJJd7R7n4pJpMt9wCS55RoIN8faGLNoJA1Q==; s=purelymail2; d=lkcamp.dev; v=1; bh=T4TRMiQNqSrX3GFvcaWSV+l6s/NF6TPrnSmNVzd+xmE=; h=Received:From:Date:Subject:To;
DKIM-Signature: a=rsa-sha256; b=t6aeqy2BBbkgfUkZXmDW3y8+o9fDzzI8NLqsybbuBaDvinaN5QM28h3tlyLBXLQMYzGwj592N9sJBxaKLXG29UzBoL0sybF2qC1Q3t6BG/d8I/cOMeHlMqs1WluKAmros6Z6uUZQFI6FaXg97rOGOp6RkWwAOUkfwvWmISoWLO+2Szow6YhxRn4BllWo1qzLq2DvqywDzwcsK4i1q+C0Bf6tuIDqiQn2QUUwb8IYuGFuvWTTG86AKj9UStCX5HwqM4gpt5FmShRnL6wm4wvjJCLQ/+jbbvQBLOKjYL+ubc3OtAMDyHB2gJ8h1G7JrfxrrpXTM45xS1josK6YFxd9rQ==; s=purelymail2; d=purelymail.com; v=1; bh=T4TRMiQNqSrX3GFvcaWSV+l6s/NF6TPrnSmNVzd+xmE=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1450761843;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 03 Oct 2024 21:01:00 +0000 (UTC)
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Date: Thu, 03 Oct 2024 18:00:51 -0300
Subject: [PATCH v2] lib/crc16_kunit.c: add KUnit tests for crc16
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-crc16-kunit-v2-1-5fe74b113e1e@lkcamp.dev>
X-B4-Tracking: v=1; b=H4sIAAIG/2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNj3eSiZEMz3ezSvMwSXUMj80STlGSjJHOjZCWgjoKi1LTMCrBp0bG
 1tQBGsVwXXQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7728; i=vpeixoto@lkcamp.dev;
 h=from:subject:message-id; bh=T4TRMiQNqSrX3GFvcaWSV+l6s/NF6TPrnSmNVzd+xmE=;
 b=owEBbQKS/ZANAwAIARxog1gjPe4wAcsmYgBm/wYL4Ck9TTj8XDbPnF/LOLsqdfx3DXPbBcPmL
 O05BDTdhAKJAjMEAAEIAB0WIQQhoIfFASXPhkPZWXMcaINYIz3uMAUCZv8GCwAKCRAcaINYIz3u
 MKsUEADZZFMtlrB0N6xGVDiyBbCHm+1ggjAwj/8y2lXbWkgyDWchNyCtmFrFS6n/GQukP3VwyGp
 cp8DrhL1AYtgFEW0qivgctxiiZ6AmdGtwtfn/4AaTae/x7UfLD5WY/f5Bxz7gNtLUgAznmkMZ3J
 lfp0+ZsmhkeqeGa1R++U/UtQshhmeOhdAaN658TjLmxJLPFum0+bmFXAEm1GTrKPevbxE5KxJWX
 yVk5aUizCmP90FR6Iib5OhIQFX0vwnbnr7rzDRoHIK1XNVChj7E2n9UXLo54eWVDYuHuwq1FUhc
 Bs27J6HZ78lprKZn1q9+6fUqwKnalB8cLH6ICy9gjeRHyPBRuNqS8wUE2fC59yYr0vt8IjibhDV
 xNL/CXMHcxRQIEkMVsOOMAw9I3DBH9lDrHumvufkWJbeUgymK7G0L/bDrz7RxC1g0fTDUiklpn+
 IliFOGchxqKzSnX0Z/ar3b9t3Ql9r/RKDJtgyYAjojmBHpLw4ZXJEfQW8knkk/7g9yo7VJ1KWV+
 v3RVPymBYlFJ8+je8lfF9QNMSMdE1v5o+h1bqFNq25tWYNvaQF5tMlfMHfk96kOIdZi/3o3J65i
 3x6/iV7462hvRiMJzcpzhKOkYYybq13PpWtPNwxPa8BxgapTmDYGxEnN/Yjc+WCflkeA8V2FhNQ
 Wup/kpRvk7qmUwA==
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
Hi all,

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

Link to v1: https://lore.kernel.org/linux-kselftest/20240922232643.535329-1-vpeixoto@lkcamp.dev/

Changes in v2 (suggested by David Laight):
  - Use the PRNG from include/linux/prandom.h to generate pseudorandom
    data/test cases instead of having them hardcoded as large static
    arrays
  - Add a naive CRC16 implementation used to validate the kernel's
    implementation (instead of having the test case results be hard-coded)

[1] https://lkcamp.dev/about
---
 lib/Kconfig.debug |   9 +++
 lib/Makefile      |   1 +
 lib/crc16_kunit.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)

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
index 0000000000000000000000000000000000000000..7a79989815c451a21210d463729436fcc620d6b3
--- /dev/null
+++ b/lib/crc16_kunit.c
@@ -0,0 +1,165 @@
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
+ * @crc16: Expected CRC16 value for the test
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
+/**
+ * crc16_test_empty - Test crc16 with empty data
+ *
+ * Test crc16 with empty data, the result should be the same as the initial crc
+ */
+static void crc16_test_empty(struct kunit *test)
+{
+	u16 crc;
+
+	crc = crc16(0x00, data, 0);
+	KUNIT_EXPECT_EQ(test, crc, 0);
+	crc = crc16(0xFF, data, 0);
+	KUNIT_EXPECT_EQ(test, crc, 0xFF);
+}
+
+/**
+ * crc16_test_correctness - Test crc16
+ *
+ * Test crc16 against a naive implementation
+ */
+static void crc16_test_correctness(struct kunit *test)
+{
+	size_t i;
+	u16 crc, crc_naive;
+
+	for (i = 0; i < CRC16_KUNIT_TEST_SIZE; i++) {
+		crc = crc16(tests[i].crc, data + tests[i].start,
+			    tests[i].length);
+		crc_naive = _crc16_naive(tests[i].crc, data + tests[i].start,
+					 tests[i].length);
+		KUNIT_EXPECT_EQ(test, crc, crc_naive);
+	}
+}
+
+
+/**
+ * crc16_test_combine - Test split crc16 calculations
+ *
+ * Test crc16 with data split in two parts, the result should be the same as
+ * crc16 with the data combined
+ */
+static void crc16_test_combine(struct kunit *test)
+{
+	size_t i, j;
+	u16 crc, crc_naive;
+
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


