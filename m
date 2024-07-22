Return-Path: <linux-kselftest+bounces-13982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44A9386D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 02:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BE92811C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 00:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B23923DE;
	Mon, 22 Jul 2024 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULW+VFW3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE08F49;
	Mon, 22 Jul 2024 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721607571; cv=none; b=mDZGY0x9vNPJLj5pJv25OScY9Fs2QyhGPLYYrGQzbSWkM3CVdTthL41dd5kBqD1j2cEapoYuKP2WcVfPi8sJ19cCZBrMj3/YDRhlwbU2xalmo616q1V8sG2Qva5B3zD9giF6NPe5mdGbRl1mDfQ57SWLNAWSfeOP4RtbMZ5olC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721607571; c=relaxed/simple;
	bh=DhhZlmk45lpBIvTUgpJfFuYD+6JHZiVTSXJqfpxg3RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzMWy3TgqmhM1UBkhBbuXlqR2GeIrMsxPsPnGeA2sZWLksCp9ySwHkmJ/vrRhVRRpfqznS1KzWsbCwRZW6/ZHWA3CxZV5Zci+hp8mJ7plBAV9LJ0q9e2IDRApN+5hOkySQRLa9/UsqQshsrGMd3Vbkw1J15ANAr/PDI45eNnNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULW+VFW3; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70448cae1e0so2013306a34.3;
        Sun, 21 Jul 2024 17:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721607568; x=1722212368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzG8Wq0O4a+6NM+2uoeGndfcv1oP5f2RRz7l1SqcHc0=;
        b=ULW+VFW3BIUFH4V3xQ3hiQj8Pvlf94Q+w1I2uLw+i9Drp3Lv80Nu7OMh1t2FMxVh3Q
         obaZPA735pB3FVSKm/gyja7ubXI+8jjM+8+gXqI0Tj3+zFJYHxEVPXyvUVYiDWgznvBG
         rc2rYWMHejuO7LNTa/cOMbFGGrhuCVzySrmVJzLjE0JbM4/7V3AzSBYeoNrhdUH50RjF
         nqMq6fsRz55kIAAY7UdXVg2innOnC+/PB/j1ne/WtYxACyTZ40T55Tmt/xzhwkKjVkCS
         xofOfeHimeQ5s9f/9JbvT+A5HMFylJvk6yZ5fv48dgaRKDkKo/hV/mcTrrLP05T6DGY2
         17ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721607568; x=1722212368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzG8Wq0O4a+6NM+2uoeGndfcv1oP5f2RRz7l1SqcHc0=;
        b=iCxsWRx9dXdJDE2dEC5U6cqBJaWD6GHRSlVenDYaoQ0ILN7VLXhAamDVYoEa8tlKUM
         qb/Qlvtniw0Jz2XIlJ90bM5q8fmIvBGxXCky2XQ5VKDX9J2X31BDKOxMvypwpd/KDtpb
         kMqT/YxMgUeQdveel+TarQW71yJWA31ABBiG6Zpz66qdzJVZMhPyTszuBghS59KSqPdC
         RKl9699rAT+grk17+YIRiY1J5UWcOpof4BMbjY+iLAo6XSyeR7857jo0/cNaueacYbyf
         UNuBQt7iDpNMJi0e83AZ8H86/9hQ1rwWAj6adl9hOqPc/pmKc8FCxYrk+uZX6hByNXHy
         DsNA==
X-Forwarded-Encrypted: i=1; AJvYcCUGKQ4GyuHjr4mgEqDC5RZCwSXmQGosRRezdwQCUhxj0Y7MGCMSiE5Ga2nj7Ew8ajt7XacjH/0qXspCt8LMtvFyrt3DiNTkVbcHzrlR4Xz5Kx5MueTJypAtgyUcoIzMCJ+wVazLoU8GJ3pc6EBN
X-Gm-Message-State: AOJu0YxNu3HmZfU1FMl6VVWavY+j5ilYAt9TG9wKDWu5VRMvZr0HDzZB
	fEa/JVyUwYKvT61MfLSVrB1EJUDuT/SJnRXJ4Rl4E3hY8Gg+zxKrBv2dxcmkMSk=
X-Google-Smtp-Source: AGHT+IFYuZfMAqZvdfkwjYgBcuWkdo1f6IpOsFoud7QQoa2DfFWe72eMnDzRHG8MU7CZELWH4llgQw==
X-Received: by 2002:a05:6870:b91:b0:260:ffaf:811b with SMTP id 586e51a60fabf-2638dfafe3fmr4713541fac.11.1721607568485;
        Sun, 21 Jul 2024 17:19:28 -0700 (PDT)
Received: from localhost.localdomain (201-13-77-175.dsl.telesp.net.br. [201.13.77.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1370c6adsm2377736b3a.56.2024.07.21.17.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 17:19:28 -0700 (PDT)
From: Diego Vieira <diego.daniel.professional@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: n@nfraprado.net,
	andrealmeid@riseup.net,
	vinicius@nukelet.com,
	diego.daniel.professional@gmail.com
Subject: [PATCH 1/1] lib/kfifo-test.c: add tests for the kfifo structure
Date: Mon, 22 Jul 2024 00:18:04 +0000
Message-Id: <20240722001804.8120-2-diego.daniel.professional@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722001804.8120-1-diego.daniel.professional@gmail.com>
References: <20240722001804.8120-1-diego.daniel.professional@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KUnit tests for the kfifo data structure.
They test the vast majority of macros defined in the kfifo
header (include/linux/kfifo.h).

These are inspired by the existing tests for the 'list' doubly
linked in lib/list-test.c [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c

Signed-off-by: Diego Vieira <diego.daniel.professional@gmail.com>
---
 lib/Kconfig.debug |  14 +++
 lib/Makefile      |   1 +
 lib/kfifo-test.c  | 222 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 lib/kfifo-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8..d7a4b996d731 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2646,6 +2646,20 @@ config SYSCTL_KUNIT_TEST
 
 	  If unsure, say N.
 
+config KFIFO_KUNIT_TEST
+	tristate "KUnit Test for the generic kernel FIFO implementation" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the generic FIFO implementation KUnit test suite.
+	  It tests that the API and basic functionality of the kfifo type
+	  and associated macros.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config LIST_KUNIT_TEST
 	tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 3b1769045651..db8dc4cb1b47 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -370,6 +370,7 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
+obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo-test.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
diff --git a/lib/kfifo-test.c b/lib/kfifo-test.c
new file mode 100644
index 000000000000..5ea41d22b6b5
--- /dev/null
+++ b/lib/kfifo-test.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the generic kernel FIFO implementation.
+ *
+ * Copyright (C) 2024 Diego Vieira <diego.daniel.professional@gmail.com>
+ */
+#include <kunit/test.h>
+
+#include <linux/kfifo.h>
+
+#define KFIFO_SIZE 32
+#define N_ELEMENTS 5
+
+static void kfifo_test_reset_should_clear_the_fifo(struct kunit *test)
+{
+	DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
+
+	kfifo_put(&my_fifo, 1);
+	kfifo_put(&my_fifo, 2);
+	kfifo_put(&my_fifo, 3);
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
+
+	kfifo_reset(&my_fifo);
+
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
+	KUNIT_EXPECT_TRUE(test, kfifo_is_empty(&my_fifo));
+}
+
+static void kfifo_test_define_should_define_an_empty_fifo(struct kunit *test)
+{
+	DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
+
+	KUNIT_EXPECT_TRUE(test, kfifo_initialized(&my_fifo));
+	KUNIT_EXPECT_TRUE(test, kfifo_is_empty(&my_fifo));
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
+}
+
+static void kfifo_test_len_should_ret_n_of_stored_elements(struct kunit *test)
+{
+	u8 buffer1[N_ELEMENTS];
+
+	for (int i = 0; i < N_ELEMENTS; i++)
+		buffer1[i] = i + 1;
+
+	DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
+
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
+
+	kfifo_in(&my_fifo, buffer1, N_ELEMENTS);
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), N_ELEMENTS);
+
+	kfifo_in(&my_fifo, buffer1, N_ELEMENTS);
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), N_ELEMENTS * 2);
+
+	kfifo_reset(&my_fifo);
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 0);
+}
+
+static void kfifo_test_put_should_insert_and_get_should_pop(struct kunit *test)
+{
+	u8 out_data = 0;
+	int processed_elements;
+	u8 elements[] = { 3, 5, 11 };
+
+	DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
+
+	// If the fifo is empty, get returns 0
+	processed_elements = kfifo_get(&my_fifo, &out_data);
+	KUNIT_EXPECT_EQ(test, processed_elements, 0);
+	KUNIT_EXPECT_EQ(test, out_data, 0);
+
+	for (int i = 0; i < 3; i++)
+		kfifo_put(&my_fifo, elements[i]);
+
+	for (int i = 0; i < 3; i++) {
+		processed_elements = kfifo_get(&my_fifo, &out_data);
+		KUNIT_EXPECT_EQ(test, processed_elements, 1);
+		KUNIT_EXPECT_EQ(test, out_data, elements[i]);
+	}
+}
+
+static void kfifo_test_in_should_insert_multiple_elements(struct kunit *test)
+{
+	u8 in_buffer[] = { 11, 25, 65 };
+	u8 out_data;
+	int processed_elements;
+
+	DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
+
+	kfifo_in(&my_fifo, in_buffer, 3);
+
+	for (int i = 0; i < 3; i++) {
+		processed_elements = kfifo_get(&my_fifo, &out_data);
+		KUNIT_EXPECT_EQ(test, processed_elements, 1);
+		KUNIT_EXPECT_EQ(test, out_data, in_buffer[i]);
+	}
+}
+
+static void kfifo_test_out_should_pop_multiple_elements(struct kunit *test)
+{
+	u8 in_buffer[] = { 11, 25, 65 };
+	u8 out_buffer[3];
+	int copied_elements;
+
+	DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
+
+	for (int i = 0; i < 3; i++)
+		kfifo_put(&my_fifo, in_buffer[i]);
+
+	copied_elements = kfifo_out(&my_fifo, out_buffer, 3);
+	KUNIT_EXPECT_EQ(test, copied_elements, 3);
+
+	for (int i = 0; i < 3; i++)
+		KUNIT_EXPECT_EQ(test, out_buffer[i], in_buffer[i]);
+	KUNIT_EXPECT_TRUE(test, kfifo_is_empty(&my_fifo));
+}
+
+static void kfifo_test_dec_init_should_define_an_empty_fifo(struct kunit *test)
+{
+	DECLARE_KFIFO(my_fifo, u8, KFIFO_SIZE);
+
+	INIT_KFIFO(my_fifo);
+
+	// my_fifo is a struct with an inplace buffer
+	KUNIT_EXPECT_FALSE(test, __is_kfifo_ptr(&my_fifo));
+
+	KUNIT_EXPECT_TRUE(test, kfifo_initialized(&my_fifo));
+}
+
+static void kfifo_test_define_should_equal_declare_init(struct kunit *test)
+{
+	// declare a variable my_fifo of type struct kfifo of u8
+	DECLARE_KFIFO(my_fifo1, u8, KFIFO_SIZE);
+	// initialize the my_fifo variable
+	INIT_KFIFO(my_fifo1);
+
+	// DEFINE_KFIFO declares the variable with the initial value
+	// essentially the same as calling DECLARE_KFIFO and INIT_KFIFO
+	DEFINE_KFIFO(my_fifo2, u8, KFIFO_SIZE);
+
+	// my_fifo1 and my_fifo2 have the same size
+	KUNIT_EXPECT_EQ(test, sizeof(my_fifo1), sizeof(my_fifo2));
+	KUNIT_EXPECT_EQ(test, kfifo_initialized(&my_fifo1),
+			kfifo_initialized(&my_fifo2));
+	KUNIT_EXPECT_EQ(test, kfifo_is_empty(&my_fifo1),
+			kfifo_is_empty(&my_fifo2));
+}
+
+static void kfifo_test_alloc_should_initiliaze_a_ptr_fifo(struct kunit *test)
+{
+	int ret;
+	DECLARE_KFIFO_PTR(my_fifo, u8);
+
+	INIT_KFIFO(my_fifo);
+
+	// kfifo_initialized returns false signaling the buffer pointer is NULL
+	KUNIT_EXPECT_FALSE(test, kfifo_initialized(&my_fifo));
+
+	// kfifo_alloc allocates the buffer
+	ret = kfifo_alloc(&my_fifo, KFIFO_SIZE, GFP_KERNEL);
+	KUNIT_EXPECT_EQ_MSG(test, ret, 0, "Memory allocation should succeed");
+	KUNIT_EXPECT_TRUE(test, kfifo_initialized(&my_fifo));
+
+	// kfifo_free frees the buffer
+	kfifo_free(&my_fifo);
+}
+
+static void kfifo_test_peek_should_not_remove_elements(struct kunit *test)
+{
+	u8 out_data;
+	int processed_elements;
+
+	DEFINE_KFIFO(my_fifo, u8, KFIFO_SIZE);
+
+	// If the fifo is empty, peek returns 0
+	processed_elements = kfifo_peek(&my_fifo, &out_data);
+	KUNIT_EXPECT_EQ(test, processed_elements, 0);
+
+	kfifo_put(&my_fifo, 3);
+	kfifo_put(&my_fifo, 5);
+	kfifo_put(&my_fifo, 11);
+
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
+
+	processed_elements = kfifo_peek(&my_fifo, &out_data);
+	KUNIT_EXPECT_EQ(test, processed_elements, 1);
+	KUNIT_EXPECT_EQ(test, out_data, 3);
+
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
+
+	// Using peek doesn't remove the element
+	// so the read element and the fifo length
+	// remains the same
+	processed_elements = kfifo_peek(&my_fifo, &out_data);
+	KUNIT_EXPECT_EQ(test, processed_elements, 1);
+	KUNIT_EXPECT_EQ(test, out_data, 3);
+
+	KUNIT_EXPECT_EQ(test, kfifo_len(&my_fifo), 3);
+}
+
+static struct kunit_case kfifo_test_cases[] = {
+	KUNIT_CASE(kfifo_test_reset_should_clear_the_fifo),
+	KUNIT_CASE(kfifo_test_define_should_define_an_empty_fifo),
+	KUNIT_CASE(kfifo_test_len_should_ret_n_of_stored_elements),
+	KUNIT_CASE(kfifo_test_put_should_insert_and_get_should_pop),
+	KUNIT_CASE(kfifo_test_in_should_insert_multiple_elements),
+	KUNIT_CASE(kfifo_test_out_should_pop_multiple_elements),
+	KUNIT_CASE(kfifo_test_dec_init_should_define_an_empty_fifo),
+	KUNIT_CASE(kfifo_test_define_should_equal_declare_init),
+	KUNIT_CASE(kfifo_test_alloc_should_initiliaze_a_ptr_fifo),
+	KUNIT_CASE(kfifo_test_peek_should_not_remove_elements),
+	{},
+};
+
+static struct kunit_suite kfifo_test_module = {
+	.name = "kfifo",
+	.test_cases = kfifo_test_cases,
+};
+
+kunit_test_suites(&kfifo_test_module);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1


