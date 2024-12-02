Return-Path: <linux-kselftest+bounces-22661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BCA9DFB80
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 08:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9093281D9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088D1FA142;
	Mon,  2 Dec 2024 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMm62Uhx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC4B1F9F67
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126173; cv=none; b=EZZnyAPX76r44v2umA56t+ReQUgalv4KZ7TmEc2OVJWm5Xo237v6V7vBx4E+KmVk4DWt3kBpFOil4VtW11BSGmcCbQrFc2oWfBCCuWx+o4NizYW+zfjba1LICkU17z8uSxN0MLZJCivlPyBMqJRWOoR8xcLDN495H26Ciyb2cIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126173; c=relaxed/simple;
	bh=Jt+d7n57NGebk0I59uq9yI2X6UgA6r9S6uq4IT9yFLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m2vC7/nYrMKlp+s7dyLFMyBumjnUK1SbTcZgqtwT5Rwa+fAcegueUtjlWtEU65WATiW/r5BExESWh8hBY5ngsiK4WPaRDyksq4ORQbfXOt+ub6cSvKZiYqz2+QSts75YajS+Ao+rRdzhyyTNP/mBavdUqJeOhjKsoRlRryRYhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VMm62Uhx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2154e57189cso22094405ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 23:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733126171; x=1733730971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDhlosYfyrccC/tr5/HdB27e44y22hAH/rYm7JsJWfI=;
        b=VMm62Uhxcq+IpFwQ7wJ52dumUkj+/+eiFcIDi2+MRKv7mkAWcpt+VwgwgFCqf6FUhh
         liLVuEHvCzJ9fkYKlprIZzsqdLOysyRkx5rvMYUvi5t388cL1J1ZoQly1wxmKNhnpcPj
         mta6HQlteQgBsVpi7qhycpiJMvmB5v2CCwOTmZpo8HWJwD3Tf6F1+HoFzibQThG4uXHB
         jBMl/FNMUe8W4kp2PTn0CHRdYpW+4h8WNiFoTQEeeJF2raGyrjRLRJu+xaGtgVS3kVD+
         vDLMygthgngOr5POXNcBc6B/y+92u1Bpz5uLJtXXSMCtaQEGm0q7I6GjKI1cOWXNGid8
         RUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126171; x=1733730971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDhlosYfyrccC/tr5/HdB27e44y22hAH/rYm7JsJWfI=;
        b=uFsNsCilVpMDIHDjVT0mruZX8hCTLnhFsoOwCfkx8+/FVK7Qh5DYGHTWuuMjNFFUQe
         OsR6MMFiRyrhfywkQhn/eFY8Gr6vO16+fULVYFKQuH4gO66wKBrCrUXTZ/XNDHZ3SHN0
         BWe+bZJbVl1TQPpE880emwKope4dgXyvi8b57QKygMo5njErG6+FFONYBmgE+7ql12cv
         UHGqORmBkUpNVxd3DYk30F4CrN7eeHg+Idco/GvKXlprLO4ZIY7x1jIsXAj0euLJPi+1
         PU7c/StjTdIw7VYFO+2fS/j+azdUl/V6FVlWr9YlWN6RzvEDziYZXbgLlEGC4Wi0gPtY
         toFg==
X-Forwarded-Encrypted: i=1; AJvYcCVGjZ3Tdv8YOU4od3Sij+SiWfh7rmyqIzGx2ZiLbwp0AIgg4crNcvjUf7twuRGfNKJeUUY57wmtKXeVheuNHYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEqx50dC16W2vShnWQSL6QXszwV6wUFLv4+EgYcpPCL7FXG2SP
	iYHYCF/rksnQUws30njgsmCRAfMqsizgwF9qdCGY0rv2rSYB1QlJQpRcnHzWzKKO8tGbbrvdrg9
	AXn1cjU1Z6Q==
X-Google-Smtp-Source: AGHT+IHCrrtVK1G8Su8f/4p14UuYSnP45OLsJguyMHeQ4fuwQtsxSnbtnu3grfxkzKL1r/cnjFv9nejxcE0tMg==
X-Received: from plge12.prod.google.com ([2002:a17:902:cf4c:b0:215:44af:311e])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e801:b0:20c:9936:f0ab with SMTP id d9443c01a7336-21501d57906mr314833595ad.47.1733126171412;
 Sun, 01 Dec 2024 23:56:11 -0800 (PST)
Date: Mon,  2 Dec 2024 15:55:41 +0800
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202075545.3648096-5-davidgow@google.com>
Subject: [PATCH v2 4/6] lib/tests/kfifo_kunit.c: add tests for the kfifo structure
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Diego Vieira <diego.daniel.professional@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Diego Vieira <diego.daniel.professional@gmail.com>

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
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/Kconfig.debug       |  14 +++
 lib/tests/Makefile      |   1 +
 lib/tests/kfifo_kunit.c | 224 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 lib/tests/kfifo_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8cc8bca6386d..960c4534dab7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2681,6 +2681,20 @@ config SYSCTL_KUNIT_TEST
 
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
index 03bf5a884984..3cda13c77551 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
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
2.47.0.338.g60cca15819-goog


