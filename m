Return-Path: <linux-kselftest+bounces-19523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E8999DF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 09:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC791C217A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1611820ADE0;
	Fri, 11 Oct 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsnATIqX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5B1F9411
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631877; cv=none; b=TnL23SUwja2S2+ZacUcGeAt8klbZQBS6sQfUvRGFMt84b9VUov5X33NcjhU6M02UUL4bu+S21EBUMIvgcNxvVSJmNltUgg25dPi2Bc6HgEvdAyfWH8damdsfRDvQfoeYMG4o0h2oQ65T9qXRVZAeSTSWFROWQcN3h9uuKFVvy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631877; c=relaxed/simple;
	bh=AMKPesFIZMPLoBoJ2Y9rfxvp8CFrXBUwHZyl9514h2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqdwTICx0kRw55rVTQ4BUgZwTpKYvNFkJ3SiHoMkwwHRWvAV/Ecp2kokUg7xrZqtULcOuH1j8/pv8AVkvU+MdnjLLFUSiAzCzDUcgb/PH8aypu1Hj7ryPXejsi0tUXQwL/5LJKxuoMb62QGBeg6lHNpE+j+IEtR6L0QWyRGXlU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsnATIqX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e278b2a5c4so30221767b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728631874; x=1729236674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvbTps7fc2dpRlFJse2FWm6+mRA3DQF4bPdus0fKmQU=;
        b=QsnATIqXhrMxY1awV+ChHAHXwIiBzIesNUkMu9tQCNLBzVVmEbBR27af6bCCjEX5pr
         DoUgIsKXGgGetRyRqLzw+t0tVzc55p0LS9EsmTVvEScG53euM/8qa7nzoDufZ+pLH0rZ
         lILyrtDe8nPRMSpAy09lYCsjMWxeOYnX+MI3g4Qvgj2sugRpDbqTzs/S7tmBQh762d3p
         mSNEdtGDndJGHjkJFy2HzCYj831qCH94DCZcS3WKcruvqYOhQxOGJ5InPuWzs+ynLTtb
         BVDSLy8NvuWLCvgPZYoo1OXtVl5AsMxRFNfBT9vPkYMyGnQL4vgvKb/JLolvkF8IIado
         vwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631874; x=1729236674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvbTps7fc2dpRlFJse2FWm6+mRA3DQF4bPdus0fKmQU=;
        b=bYq1irhAPagHZE8oNJcosIgt85dUhVs0dWGmMvGXiDbwV8ytFrfzXMV5GlBopw/fLV
         0Tz7FyajLNr/ygoJPIcovG63QhHZonIbG2UyvUDJOztnPo9JJNtSug2tVZc0ytEcX8j6
         WeMSRJ2zWNCpcuQtExJXNZi8FyBQfG0BN+F9e8xN/kBODDXTqd8FuG9vQd+qaGC737/2
         OjRmVK/cuIu8DqFJMUidNaHmbxOuuOrtMRhP2ihXcxUIXRMSR5au7rg7b4JipHcGrtCn
         i7mDG9UtJ/cHBGHx/zQmOfPFQ/47st/WIeU34nVTSD5OaVcIo8ooQir/JZz7vJ/ZFQU3
         jJig==
X-Gm-Message-State: AOJu0YzuhfAejwTaYxDMv+BMYrm12g1rqMPvHx9z1c+5mPQ7NUoYPMDD
	kl9nRjp34hK9lf+NHYfSJC75lH+cIOVJNJJOBzxnTPl6op7fsoWXJsgHsEYxMByBF6JtrUtAr+K
	+YRL494+CyQ==
X-Google-Smtp-Source: AGHT+IEXk/1kjI7Z2ejSaYEgxJDFzQUqoGeA/WOYww6aXEhdrGdjP6eIkIiYr6/dpFky7gRGsWAdeqvl5ZW4MQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a05:690c:4505:b0:6db:d257:b98 with SMTP
 id 00721157ae682-6e347b30d7dmr269647b3.3.1728631874169; Fri, 11 Oct 2024
 00:31:14 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:25:08 +0800
In-Reply-To: <20241011072509.3068328-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011072509.3068328-6-davidgow@google.com>
Subject: [PATCH 4/6] lib/tests/kfifo_kunit.c: add tests for the kfifo structure
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Diego Vieira <diego.daniel.professional@gmail.com>, n@nfraprado.net, 
	andrealmeid@riseup.net, vinicius@nukelet.com, David Gow <davidgow@google.com>
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
index 6571243ac232..134d077562a9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2673,6 +2673,20 @@ config SYSCTL_KUNIT_TEST
 
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
index 41689f0b7c97..380f95b003fc 100644
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
2.47.0.rc1.288.g06298d1525-goog


