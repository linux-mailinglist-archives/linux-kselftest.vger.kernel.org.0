Return-Path: <linux-kselftest+bounces-15375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF29527D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 04:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD04B2838B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091C5CB8;
	Thu, 15 Aug 2024 02:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVK8ms/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7D63B9
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723687638; cv=none; b=RLz6NuLzEuktfrSkktcH+fY6UrvtJbgYX0wMgt2Lvnb7eK8b6Rby2RHUMOIs5wqwylP+qXo0UsWS1KOXNVxo6bC5OlPZffDtQ+2HHvETb3KJ8FNiBDzRjU2BdR+PolgFzk4XCQXB2pM/7+DclFNj+X6qDR+jpDrl8Oow91rpSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723687638; c=relaxed/simple;
	bh=dIZzHXiKMw27T75+DwnZyDKbGiZ/QhDiyGNMnFwk7tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIt27gHxBvPs6SzIZxALfJNnSM/dh4S9rfnTO7qf0ygnZRFKWsPybIc9CXDGH8S4YjTZwnEZCreS9prABqmX9ZR5a36QMRZPzDDKzbQnbGwRXWR383lhHAHTfhVHF6KtuPBYzkQHdGxHFHDO3RaSkUZ0F6SI1awu9gaP2IItRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVK8ms/r; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-690404fd27eso5530047b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 19:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723687636; x=1724292436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2/ASuLUtGxDS0GSssOdh4ZdX64NP+jCqG7TJlf5fYQ=;
        b=jVK8ms/rwhN3efzOwGwNKGpjlyJkm0w+JAzsequPcp4cRYT6XE0oewyDHfyeKjs7SV
         REXMi0ORosFjjzvEYDnVhLLaofAObaK3UqdOVWIN2C3O3cAiPXPCMPuIvk4NfJbxRtvB
         JHViQPEzJAkkfMqUmk5/HQXL3XnxTGdUZVgMuTfn0SfZqbBn1jzUCQs6kDi2hyLZ9JB8
         kJpxrTg9qZcqN3f+uem24OKz3+NXhGVUgjmh3EZNwU8/3EvC9BaKZxyxmHmPfa8hG2Zh
         2xtsl4in3bG84LmsQqpexPhFF9ifJhEBUmd1PC0V+tVRVHsJJTQP2ZoacW3dbEbb4Ans
         R3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723687636; x=1724292436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2/ASuLUtGxDS0GSssOdh4ZdX64NP+jCqG7TJlf5fYQ=;
        b=iTKQdPe4pjWldotbjh3dCcgNcQtspnw3IBxl48LpRl9EnDGYo8Ss+GcZR4WfO4nRh1
         +b6Ev+rMUjButg01LYSR5LTwMe47Ylb6A/h2RJSFXQzeLry+RYUPJ+fZXRwmd7nHQATJ
         oUGIl/EPX8l3w8BNPTKIKzdPr4r1M3n5HUun6HjwnvDLr53opXliO8jNgd0nMyaN6u1/
         AM/iK8icJXiJgpe90clxJKIkKTNAwQ4D8bSfct7esMqC+pgQJlJNuLQBJH1NTkpnavI9
         28O86aXZqxHxI5tAo5UUFDQtNN6zCZu8+itxdpbMGI+cdK9RYaQYjj1QYRwhNpHIjzzS
         7yIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8/rcgRrTL9otGbmxVUv8UeNcU9TIniic1CYOPMtNgfNrUCkMjtP1SxlZhIUiXBISx1a902G5UOdLTpDzb4ujz7aF9a1A4cICBSup5ZVqO
X-Gm-Message-State: AOJu0YyId5bmeJ9EzQzzKV/XtpCh7aFBN442Dok3Y5V7C7pMMwvGTqhl
	vmjZQCySEhRtewIyi4fqfTvdnJIgiBq2FjtmWKqCLyOARwgWr1tW
X-Google-Smtp-Source: AGHT+IFc8pS8AFMDIoNr3RFZTXNr37gKkVG+aNLf25NfQwUsMxlcO+HSVbpsO7aNLmQnnGjIfAgIwA==
X-Received: by 2002:a05:690c:398:b0:63b:d711:e722 with SMTP id 00721157ae682-6ac954ac75bmr50353787b3.1.1723687635999;
        Wed, 14 Aug 2024 19:07:15 -0700 (PDT)
Received: from x13.lan (2603-9001-2ff0-a230-0000-0000-0000-1896.inf6.spectrum.com. [2603:9001:2ff0:a230::1896])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9d8273fesm1059417b3.116.2024.08.14.19.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 19:07:15 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] lib/math: Add int_pow test suite
Date: Wed, 14 Aug 2024 22:07:09 -0400
Message-ID: <20240815020711.110640-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds test suite for integer based power function.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
 lib/math/Makefile       |  1 +
 lib/math/test_int_pow.c | 70 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 lib/math/test_int_pow.c

diff --git a/lib/math/Makefile b/lib/math/Makefile
index 91fcdb0c9efe..ba564bf4fb00 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
+obj-$(CONFIG_TEST_INT_POW)	+= test_int_pow.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
diff --git a/lib/math/test_int_pow.c b/lib/math/test_int_pow.c
new file mode 100644
index 000000000000..ecabe71d01cc
--- /dev/null
+++ b/lib/math/test_int_pow.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+
+#include <linux/math.h>
+
+
+static void test_pow_0(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1, int_pow(64, 0));
+}
+
+static void test_pow_1(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 64, int_pow(64, 1));
+}
+
+static void test_base_0(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 0, int_pow(0, 5));
+}
+
+static void test_base_1(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1, int_pow(1, 100));
+	KUNIT_EXPECT_EQ(test, 1, int_pow(1, 0));
+}
+
+static void test_base_0_pow_0(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1, int_pow(0, 0));
+}
+
+static void test_base_2_pow_2(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 4, int_pow(2, 2));
+}
+
+static void test_max_base(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, U64_MAX, int_pow(U64_MAX, 1));
+}
+
+static void test_large_result(struct kunit *test)
+{
+	UNIT_EXPECT_EQ(test, 1152921504606846976, int_pow(2, 60));
+}
+
+static struct kunit_case math_int_pow_test_cases[] = {
+	KUNIT_CASE(test_pow_0),
+	KUNIT_CASE(test_pow_1),
+	KUNIT_CASE(test_base_0),
+	KUNIT_CASE(test_base_1),
+	KUNIT_CASE(test_base_0_pow_0),
+	KUNIT_CASE(test_base_2_pow_2),
+	KUNIT_CASE(test_max_base),
+	KUNIT_CASE(test_large_result),
+	{}
+};
+
+static struct kunit_suite int_pow_test_suite = {
+	.name = "lib-math-int_pow",
+	.test_cases = math_int_pow_test_cases,
+};
+
+kunit_test_suites(&int_pow_test_suite);
+
+MODULE_DESCRIPTION("math.int_pow KUnit test suite");
+MODULE_LICENSE("GPL v2");
-- 
2.46.0


