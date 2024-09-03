Return-Path: <linux-kselftest+bounces-17069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E50096AA51
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 23:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC8DB25E86
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5C1A3AB4;
	Tue,  3 Sep 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHqjuQSk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC39192B68;
	Tue,  3 Sep 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399481; cv=none; b=Tox46oIXFg4KqrgoJNaFEAQeu+44arkXZnlJcB4ElYVkYzZ/E5AbaP/9jZWqR+8FGDUh2lHGm4rt/5TLLoQg4OlZBluwV2zH2O2mUr6RXWLAtaYJv/kp7wZZCyXVykqbHdhoyABA8gHFa6R/AFqeJHjsqoSNetTO93i7KK9eQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399481; c=relaxed/simple;
	bh=Xvz44EUCoOavYejlPgJFUJ5K2WYUy/qZ8Qsb8/PY9P4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKmTnor3Wmp/880BjqVuLKdt1kpjqmBgZTeK6rrS5PP/Eh0hXP3h94eDm5xACobqx8ZLUDglnwBKrBLxmSLqeFdHaj2IPEEf4w9h4I7MwQwOLiwIrK6t1DrOEHQSOmEKBim8kyN3/HeF/fs4auLbU8Rh2p4DsYNNUnskELiz7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHqjuQSk; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso1130715a12.1;
        Tue, 03 Sep 2024 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725399479; x=1726004279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN2Yxuy5Q5p7m0B8mREA9r3K15lNko1bi4ozXPM7Fcg=;
        b=lHqjuQSkSy9BubN4uLrQM6T5Kxcn2r6j6HXnBbxPFT6C5A6aSaf1nav73Cjxavob5P
         wO1hk4u6TqFuoTG38ykGDo8yUl+QCyKT8Llkn9HmnvtprBrJBU/7x0gI459fp5zdjGLO
         +MAA5vYoy9mzBgTree/Zwqmzq/okkkifEWpn0z/Kxeo9IDMtYM0KiDPJ4G+UfjWmNwQ0
         ytinJNCmoqJAU3AKWqGJ6xbCjhAhMkjVHTYQBNumP1YRQgwbNZeXApIclDPVX8z30foc
         76cWUDBiB0G9hGw0ZyfHbd3xyLGFz1Ww7B1RCjmt1RO2nvAgixoXKNh/lIpleUqByEMX
         adYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399479; x=1726004279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN2Yxuy5Q5p7m0B8mREA9r3K15lNko1bi4ozXPM7Fcg=;
        b=u6a8zBrXX1LMztzEVt0O5HyB0pvsngt/LyIM96ufZP9FPynZ6kIHlvwdXKx6R8QxoF
         xMmR5zLfL1ptEvn07/ouJvglXYvXd41TPiGHXusONspJzAEH0AAZSka3qn/zz31e4uwZ
         TZU0Qp+l4Dr8S9XHvS7dVL1rZ0Ijia6jnYiv4ScioJ2fpGi1vdnfPskwRZ8tcNhoXs21
         YPoJkTjTCvo64KOHTF9hqgdTpqJA4d98y8KMsY0wwDzppn77EAuF0MdjZnMPYtGScoPg
         LJAnWprzo4kGr/lY7KACvZO4xJYVposuI93aMKWWhW8B/Tn5IWA21k2qZcye8r9rlxhn
         wpsA==
X-Forwarded-Encrypted: i=1; AJvYcCWaeOtzGgcmoCcsCh1Pv1RH535uNEiiNCfyHNbtDYXU//FZqYYs8T7KXaIzdtM+b+6NCfw0fFbQkhYk4ugY0FhZ@vger.kernel.org, AJvYcCXbvI82MqL9E/YFKMARVrY4rNdoMVo61S3VjqXXf2OwLRPKzFejZkmVLOShe4wSnsoYvzkymBS6/30JzYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2jc38b+ddIab83ipWj69MW3kv9JXXJ+QPskuJpMl+IX+FMzm
	n4gG+CNdBNwI5Bnjve7KIiFSl57yon3vqDzprcN7c/SLKZd3ep2j
X-Google-Smtp-Source: AGHT+IFNkAxQp/kgns4Xu4ro95avq0x64BInlqL5i+8GvNPrmzqYfSgeiu5HRP9PHgazlJaCAH8yKQ==
X-Received: by 2002:a17:90a:e2c9:b0:2d8:9253:dffc with SMTP id 98e67ed59e1d1-2d8972c0003mr10190599a91.19.1725399478375;
        Tue, 03 Sep 2024 14:37:58 -0700 (PDT)
Received: from localhost.localdomain ([191.254.217.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8f7e2119asm3811215a91.54.2024.09.03.14.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 14:37:58 -0700 (PDT)
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
Subject: [PATCH v2 1/1] lib/tests/kfifo_kunit.c: add tests for the kfifo structure
Date: Tue,  3 Sep 2024 21:36:49 +0000
Message-Id: <20240903213649.21467-2-diego.daniel.professional@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903213649.21467-1-diego.daniel.professional@gmail.com>
References: <20240903213649.21467-1-diego.daniel.professional@gmail.com>
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

These are inspired by the existing tests for the doubly
linked list in lib/tests/list-test.c (previously at lib/list-test.c) [1].

Note that this patch depends on the patch that moves the KUnit tests on 
lib/ into lib/tests/ [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c?h=v6.11-rc6
[2] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/

Signed-off-by: Diego Vieira <diego.daniel.professional@gmail.com>
---
 lib/Kconfig.debug       |  14 +++
 lib/tests/Makefile      |   1 +
 lib/tests/kfifo_kunit.c | 224 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 lib/tests/kfifo_kunit.c

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
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index c6a14cc8663e..42699c7ee638 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
 obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
diff --git a/lib/tests/kfifo_kunit.c b/lib/tests/kfifo_kunit.c
new file mode 100644
index 000000000000..a85eedc3195a
--- /dev/null
+++ b/lib/tests/kfifo_kunit.c
@@ -0,0 +1,224 @@
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
+MODULE_AUTHOR("Diego Vieira <diego.daniel.professional@gmail.com>");
+MODULE_DESCRIPTION("KUnit test for the kernel FIFO");
-- 
2.34.1


