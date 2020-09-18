Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE874270419
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIRScM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgIRScK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 14:32:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE76C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u11so3851340pls.16
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qypWKHXedF8/KF4Xvr3+aRHP7U3dz5Tf83jt6mtBndg=;
        b=HE7e9clCmg0oUbqIj6monaOTb6MIK+LUI55ECVMtIlloc5B8VzAkzFnU0gyPsDHJgH
         iIIye2eWrKZnyoGgt2TEuNE9+qL/jWfafuKj6NGlsfpHAqfXcn1xcfoG+DvA31ITA7nu
         Li/yxBaMGDYA9V6rZOuB22hcPsst3Ff9CaVYyskZz5EuAvS7w3ElSQtEkpQ1woVf04nq
         ROK2YC2LzNGcgbwX9SF6lePqMy4bUbGphxrPnGyuHn1u2I+ihRE/boFfgY6lyiXP6WGf
         YEWbHJUTsCPfutKMDALCrCGKcGSKgQM6UMK+LhuKRzWoXPdV6fMve59gDerYVbpEx7CM
         l3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qypWKHXedF8/KF4Xvr3+aRHP7U3dz5Tf83jt6mtBndg=;
        b=fMvhOd051VAhIkEQPrqlSIM2H1FUeb+1KEqF7a5S3C49ItaQfTOPaERYrFGcxU+I3w
         Fx7Q8xlRsm5I64AW3w6kW1gHnDrZ0F3SBXlQzf4Z/0BqOWxAZc6oE74IYrtReYf8Gl4q
         Dvo6wJRb2lkVvEXkvATOLyMaPEP7r+naQrd48r+NYnqF+uEPZAiAJvpAaZWG4d1iY/fJ
         F89vET/yQqnH96S866t0Aw8rZW/GicitSH10sHXAbHqiOySrmyTv71FTDJrhiyJYmghD
         UDjixd/a97yiVW3ufZYGYDSHW7KQEIObwzCsqrQ09vugy5mV90QUfuwSagX4Dbi2Mblw
         RT6g==
X-Gm-Message-State: AOAM530Ag+jKWxAexhnc1TjSZVvngKqmv8cZWP1JhstJ0jG7OvWtiQA9
        +vGMIDGtFTApIszTIRjmv/OXOMcoe806NA==
X-Google-Smtp-Source: ABdhPJwE60WXp8KeBIxu4dUHV/wIrnmb9FtigordbJCGRWafmNbNCRY4un4uphCWJLcNigZuC037SafvKmapEQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a63:f34b:: with SMTP id
 t11mr28170252pgj.111.1600453929259; Fri, 18 Sep 2020 11:32:09 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:10 -0700
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
Message-Id: <20200918183114.2571146-9-dlatypov@google.com>
Mime-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 08/12] kunit: mock: add basic matchers and actions
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

Add basic matchers and actions needed for any kind of mocking to be
useful; these matchers and actions are how expectations for mocks are
described: what calls the mocks are expected to receive, and what the
mock should do under those circumstances.

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/mock.h     | 222 ++++++++++++++++++++++++++++++++
 lib/kunit/Makefile       |   1 +
 lib/kunit/common-mocks.c | 271 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 494 insertions(+)
 create mode 100644 lib/kunit/common-mocks.c

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index 299b423fdd51..13fdeb8730b5 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -123,4 +123,226 @@ struct mock_expectation *mock_add_matcher(struct mock *mock,
 					  struct mock_param_matcher *matchers[],
 					  int len);
 
+#define CONVERT_TO_ACTUAL_TYPE(type, ptr) (*((type *) ptr))
+
+/**
+ * DOC: Built In Matchers
+ *
+ * These are the matchers that can be used when matching arguments in
+ * :c:func:`KUNIT_EXPECT_CALL` (more can be defined manually).
+ *
+ * For example, there's a matcher that matches any arguments:
+ *
+ * .. code-block:: c
+ *
+ *    struct mock_param_matcher *any(struct kunit *test);
+ *
+ * There are matchers for integers based on the binary condition:
+ *
+ * * eq: equals to
+ * * ne: not equal to
+ * * lt: less than
+ * * le: less than or equal to
+ * * gt: greater than
+ * * ge: greater than or equal to
+ *
+ * .. code-block:: c
+ *
+ *    struct mock_param_matcher *kunit_int_eq(struct kunit *test, int expected);
+ *    struct mock_param_matcher *kunit_int_ne(struct kunit *test, int expected);
+ *    struct mock_param_matcher *kunit_int_lt(struct kunit *test, int expected);
+ *    struct mock_param_matcher *kunit_int_le(struct kunit *test, int expected);
+ *    struct mock_param_matcher *kunit_int_gt(struct kunit *test, int expected);
+ *    struct mock_param_matcher *kunit_int_ge(struct kunit *test, int expected);
+ *
+ * For a detailed list, please see
+ * ``include/linux/mock.h``.
+ */
+
+/* Matches any argument */
+struct mock_param_matcher *kunit_any(struct kunit *test);
+
+/*
+ * Matches different types of integers, the argument is compared to the
+ * `expected` field, based on the comparison defined.
+ */
+struct mock_param_matcher *kunit_u8_eq(struct kunit *test, u8 expected);
+struct mock_param_matcher *kunit_u8_ne(struct kunit *test, u8 expected);
+struct mock_param_matcher *kunit_u8_le(struct kunit *test, u8 expected);
+struct mock_param_matcher *kunit_u8_lt(struct kunit *test, u8 expected);
+struct mock_param_matcher *kunit_u8_ge(struct kunit *test, u8 expected);
+struct mock_param_matcher *kunit_u8_gt(struct kunit *test, u8 expected);
+
+struct mock_param_matcher *kunit_u16_eq(struct kunit *test, u16 expected);
+struct mock_param_matcher *kunit_u16_ne(struct kunit *test, u16 expected);
+struct mock_param_matcher *kunit_u16_le(struct kunit *test, u16 expected);
+struct mock_param_matcher *kunit_u16_lt(struct kunit *test, u16 expected);
+struct mock_param_matcher *kunit_u16_ge(struct kunit *test, u16 expected);
+struct mock_param_matcher *kunit_u16_gt(struct kunit *test, u16 expected);
+
+struct mock_param_matcher *kunit_u32_eq(struct kunit *test, u32 expected);
+struct mock_param_matcher *kunit_u32_ne(struct kunit *test, u32 expected);
+struct mock_param_matcher *kunit_u32_le(struct kunit *test, u32 expected);
+struct mock_param_matcher *kunit_u32_lt(struct kunit *test, u32 expected);
+struct mock_param_matcher *kunit_u32_ge(struct kunit *test, u32 expected);
+struct mock_param_matcher *kunit_u32_gt(struct kunit *test, u32 expected);
+
+struct mock_param_matcher *kunit_u64_eq(struct kunit *test, u64 expected);
+struct mock_param_matcher *kunit_u64_ne(struct kunit *test, u64 expected);
+struct mock_param_matcher *kunit_u64_le(struct kunit *test, u64 expected);
+struct mock_param_matcher *kunit_u64_lt(struct kunit *test, u64 expected);
+struct mock_param_matcher *kunit_u64_ge(struct kunit *test, u64 expected);
+struct mock_param_matcher *kunit_u64_gt(struct kunit *test, u64 expected);
+
+struct mock_param_matcher *kunit_char_eq(struct kunit *test, char expected);
+struct mock_param_matcher *kunit_char_ne(struct kunit *test, char expected);
+struct mock_param_matcher *kunit_char_le(struct kunit *test, char expected);
+struct mock_param_matcher *kunit_char_lt(struct kunit *test, char expected);
+struct mock_param_matcher *kunit_char_ge(struct kunit *test, char expected);
+struct mock_param_matcher *kunit_char_gt(struct kunit *test, char expected);
+
+struct mock_param_matcher *kunit_uchar_eq(struct kunit *test,
+					 unsigned char expected);
+struct mock_param_matcher *kunit_uchar_ne(struct kunit *test,
+					 unsigned char expected);
+struct mock_param_matcher *kunit_uchar_le(struct kunit *test,
+					 unsigned char expected);
+struct mock_param_matcher *kunit_uchar_lt(struct kunit *test,
+					 unsigned char expected);
+struct mock_param_matcher *kunit_uchar_ge(struct kunit *test,
+					 unsigned char expected);
+struct mock_param_matcher *kunit_uchar_gt(struct kunit *test,
+					 unsigned char expected);
+
+struct mock_param_matcher *kunit_schar_eq(struct kunit *test,
+					 signed char expected);
+struct mock_param_matcher *kunit_schar_ne(struct kunit *test,
+					 signed char expected);
+struct mock_param_matcher *kunit_schar_le(struct kunit *test,
+					 signed char expected);
+struct mock_param_matcher *kunit_schar_lt(struct kunit *test,
+					 signed char expected);
+struct mock_param_matcher *kunit_schar_ge(struct kunit *test,
+					 signed char expected);
+struct mock_param_matcher *kunit_schar_gt(struct kunit *test,
+					 signed char expected);
+
+struct mock_param_matcher *kunit_short_eq(struct kunit *test, short expected);
+struct mock_param_matcher *kunit_short_ne(struct kunit *test, short expected);
+struct mock_param_matcher *kunit_short_le(struct kunit *test, short expected);
+struct mock_param_matcher *kunit_short_lt(struct kunit *test, short expected);
+struct mock_param_matcher *kunit_short_ge(struct kunit *test, short expected);
+struct mock_param_matcher *kunit_short_gt(struct kunit *test, short expected);
+
+struct mock_param_matcher *kunit_ushort_eq(struct kunit *test,
+					  unsigned short expected);
+struct mock_param_matcher *kunit_ushort_ne(struct kunit *test,
+					  unsigned short expected);
+struct mock_param_matcher *kunit_ushort_le(struct kunit *test,
+					  unsigned short expected);
+struct mock_param_matcher *kunit_ushort_lt(struct kunit *test,
+					  unsigned short expected);
+struct mock_param_matcher *kunit_ushort_ge(struct kunit *test,
+					  unsigned short expected);
+struct mock_param_matcher *kunit_ushort_gt(struct kunit *test,
+					  unsigned short expected);
+
+struct mock_param_matcher *kunit_int_eq(struct kunit *test, int expected);
+struct mock_param_matcher *kunit_int_ne(struct kunit *test, int expected);
+struct mock_param_matcher *kunit_int_lt(struct kunit *test, int expected);
+struct mock_param_matcher *kunit_int_le(struct kunit *test, int expected);
+struct mock_param_matcher *kunit_int_gt(struct kunit *test, int expected);
+struct mock_param_matcher *kunit_int_ge(struct kunit *test, int expected);
+
+struct mock_param_matcher *kunit_uint_eq(struct kunit *test,
+					unsigned int expected);
+struct mock_param_matcher *kunit_uint_ne(struct kunit *test,
+					unsigned int expected);
+struct mock_param_matcher *kunit_uint_lt(struct kunit *test,
+					unsigned int expected);
+struct mock_param_matcher *kunit_uint_le(struct kunit *test,
+					unsigned int expected);
+struct mock_param_matcher *kunit_uint_gt(struct kunit *test,
+					unsigned int expected);
+struct mock_param_matcher *kunit_uint_ge(struct kunit *test,
+					unsigned int expected);
+
+struct mock_param_matcher *kunit_long_eq(struct kunit *test, long expected);
+struct mock_param_matcher *kunit_long_ne(struct kunit *test, long expected);
+struct mock_param_matcher *kunit_long_le(struct kunit *test, long expected);
+struct mock_param_matcher *kunit_long_lt(struct kunit *test, long expected);
+struct mock_param_matcher *kunit_long_ge(struct kunit *test, long expected);
+struct mock_param_matcher *kunit_long_gt(struct kunit *test, long expected);
+
+struct mock_param_matcher *kunit_ulong_eq(struct kunit *test,
+					 unsigned long expected);
+struct mock_param_matcher *kunit_ulong_ne(struct kunit *test,
+					 unsigned long expected);
+struct mock_param_matcher *kunit_ulong_le(struct kunit *test,
+					 unsigned long expected);
+struct mock_param_matcher *kunit_ulong_lt(struct kunit *test,
+					 unsigned long expected);
+struct mock_param_matcher *kunit_ulong_ge(struct kunit *test,
+					 unsigned long expected);
+struct mock_param_matcher *kunit_ulong_gt(struct kunit *test,
+					 unsigned long expected);
+
+struct mock_param_matcher *kunit_longlong_eq(struct kunit *test,
+					    long long expected);
+struct mock_param_matcher *kunit_longlong_ne(struct kunit *test,
+					    long long expected);
+struct mock_param_matcher *kunit_longlong_le(struct kunit *test,
+					    long long expected);
+struct mock_param_matcher *kunit_longlong_lt(struct kunit *test,
+					    long long expected);
+struct mock_param_matcher *kunit_longlong_ge(struct kunit *test,
+					    long long expected);
+struct mock_param_matcher *kunit_longlong_gt(struct kunit *test,
+					    long long expected);
+
+struct mock_param_matcher *kunit_ulonglong_eq(struct kunit *test,
+					     unsigned long long expected);
+struct mock_param_matcher *kunit_ulonglong_ne(struct kunit *test,
+					     unsigned long long expected);
+struct mock_param_matcher *kunit_ulonglong_le(struct kunit *test,
+					     unsigned long long expected);
+struct mock_param_matcher *kunit_ulonglong_lt(struct kunit *test,
+					     unsigned long long expected);
+struct mock_param_matcher *kunit_ulonglong_ge(struct kunit *test,
+					     unsigned long long expected);
+struct mock_param_matcher *kunit_ulonglong_gt(struct kunit *test,
+					     unsigned long long expected);
+
+/* Matches pointers. */
+struct mock_param_matcher *kunit_ptr_eq(struct kunit *test, void *expected);
+struct mock_param_matcher *kunit_ptr_ne(struct kunit *test, void *expected);
+struct mock_param_matcher *kunit_ptr_lt(struct kunit *test, void *expected);
+struct mock_param_matcher *kunit_ptr_le(struct kunit *test, void *expected);
+struct mock_param_matcher *kunit_ptr_gt(struct kunit *test, void *expected);
+struct mock_param_matcher *kunit_ptr_ge(struct kunit *test, void *expected);
+
+/* Matches memory sections and strings. */
+struct mock_param_matcher *kunit_memeq(struct kunit *test,
+				      const void *buf,
+				      size_t size);
+struct mock_param_matcher *kunit_streq(struct kunit *test, const char *str);
+
+struct mock_action *kunit_u8_return(struct kunit *test, u8 ret);
+struct mock_action *kunit_u16_return(struct kunit *test, u16 ret);
+struct mock_action *kunit_u32_return(struct kunit *test, u32 ret);
+struct mock_action *kunit_u64_return(struct kunit *test, u64 ret);
+struct mock_action *kunit_char_return(struct kunit *test, char ret);
+struct mock_action *kunit_uchar_return(struct kunit *test, unsigned char ret);
+struct mock_action *kunit_schar_return(struct kunit *test, signed char ret);
+struct mock_action *kunit_short_return(struct kunit *test, short ret);
+struct mock_action *kunit_ushort_return(struct kunit *test, unsigned short ret);
+struct mock_action *kunit_int_return(struct kunit *test, int ret);
+struct mock_action *kunit_uint_return(struct kunit *test, unsigned int ret);
+struct mock_action *kunit_long_return(struct kunit *test, long ret);
+struct mock_action *kunit_ulong_return(struct kunit *test, unsigned long ret);
+struct mock_action *kunit_longlong_return(struct kunit *test, long long ret);
+struct mock_action *kunit_ulonglong_return(struct kunit *test,
+					  unsigned long long ret);
+struct mock_action *kunit_ptr_return(struct kunit *test, void *ret);
+
 #endif /* _KUNIT_MOCK_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index a51157970502..a7a3c5e0a8bf 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
 					mock.o \
+					common-mocks.o \
 					string-stream.o \
 					assert.o \
 					kunit-stream.o \
diff --git a/lib/kunit/common-mocks.c b/lib/kunit/common-mocks.c
new file mode 100644
index 000000000000..b3a410fda63a
--- /dev/null
+++ b/lib/kunit/common-mocks.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common KUnit mock call arg matchers and formatters.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/kernel.h>
+#include <kunit/mock.h>
+
+static bool match_any(struct mock_param_matcher *pmatcher,
+		      struct kunit_stream *stream,
+		      const void *actual)
+{
+	kunit_stream_add(stream, "don't care");
+	return true;
+}
+
+static struct mock_param_matcher any_matcher = {
+	.match = match_any,
+};
+
+struct mock_param_matcher *kunit_any(struct kunit *test)
+{
+	return &any_matcher;
+}
+
+#define DEFINE_MATCHER_STRUCT(type_name, type)				       \
+		struct mock_##type_name##_matcher {			       \
+			struct mock_param_matcher matcher;		       \
+			type expected;					       \
+		}
+
+#define DEFINE_TO_MATCHER_STRUCT(type_name)				       \
+		struct mock_##type_name##_matcher *			       \
+		to_mock_##type_name##_matcher(				       \
+				struct mock_param_matcher *matcher)	       \
+		{							       \
+			return container_of(matcher,			       \
+					    struct mock_##type_name##_matcher, \
+					    matcher);			       \
+		}
+
+#define DEFINE_MATCH_FUNC(type_name, type, op_name, op)			       \
+		bool match_##type_name##_##op_name(			       \
+				struct mock_param_matcher *pmatcher,	       \
+				struct kunit_stream *stream,		       \
+				const void *pactual)			       \
+		{							       \
+			struct mock_##type_name##_matcher *matcher =	       \
+				to_mock_##type_name##_matcher(pmatcher);       \
+			type actual = *((type *) pactual);		       \
+			bool matches = actual op matcher->expected;	       \
+									       \
+			if (matches)					       \
+				kunit_stream_add(stream,		       \
+						 "%d "#op" %d",		       \
+						 actual,		       \
+						 matcher->expected);	       \
+			else						       \
+				kunit_stream_add(stream,		       \
+						 "%d not "#op" %d",	       \
+						 actual,		       \
+						 matcher->expected);	       \
+									       \
+			return matches;					       \
+		}
+
+#define DEFINE_MATCH_FACTORY(type_name, type, op_name)			       \
+		struct mock_param_matcher *kunit_##type_name##_##op_name(      \
+				struct kunit *test, type expected)	       \
+		{							       \
+			struct mock_##type_name##_matcher *matcher;	       \
+									       \
+			matcher = kunit_kmalloc(test,			       \
+					       sizeof(*matcher),	       \
+					       GFP_KERNEL);		       \
+			if (!matcher)					       \
+				return NULL;				       \
+									       \
+			matcher->matcher.match = match_##type_name##_##op_name;\
+			matcher->expected = expected;			       \
+			return &matcher->matcher;			       \
+		}
+
+#define DEFINE_MATCHER_WITH_TYPENAME(type_name, type)			       \
+		DEFINE_MATCHER_STRUCT(type_name, type);			       \
+		DEFINE_TO_MATCHER_STRUCT(type_name)			       \
+		DEFINE_MATCH_FUNC(type_name, type, eq, ==)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, eq)		       \
+		DEFINE_MATCH_FUNC(type_name, type, ne, !=)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, ne)		       \
+		DEFINE_MATCH_FUNC(type_name, type, le, <=)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, le)		       \
+		DEFINE_MATCH_FUNC(type_name, type, lt, <)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, lt)		       \
+		DEFINE_MATCH_FUNC(type_name, type, ge, >=)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, ge)		       \
+		DEFINE_MATCH_FUNC(type_name, type, gt, >)		       \
+		DEFINE_MATCH_FACTORY(type_name, type, gt)
+
+#define DEFINE_MATCHER(type) DEFINE_MATCHER_WITH_TYPENAME(type, type)
+
+DEFINE_MATCHER(u8);
+DEFINE_MATCHER(u16);
+DEFINE_MATCHER(u32);
+DEFINE_MATCHER(u64);
+DEFINE_MATCHER(char);
+DEFINE_MATCHER_WITH_TYPENAME(uchar, unsigned char);
+DEFINE_MATCHER_WITH_TYPENAME(schar, signed char);
+DEFINE_MATCHER(short);
+DEFINE_MATCHER_WITH_TYPENAME(ushort, unsigned short);
+DEFINE_MATCHER(int);
+DEFINE_MATCHER_WITH_TYPENAME(uint, unsigned int);
+DEFINE_MATCHER(long);
+DEFINE_MATCHER_WITH_TYPENAME(ulong, unsigned long);
+DEFINE_MATCHER_WITH_TYPENAME(longlong, long long);
+DEFINE_MATCHER_WITH_TYPENAME(ulonglong, unsigned long long);
+
+DEFINE_MATCHER_WITH_TYPENAME(ptr, void *);
+
+struct mock_memeq_matcher {
+	struct mock_param_matcher matcher;
+	const void *expected;
+	size_t size;
+};
+
+static bool match_memeq(struct mock_param_matcher *pmatcher,
+			struct kunit_stream *stream,
+			const void *pactual)
+{
+	struct mock_memeq_matcher *matcher =
+			container_of(pmatcher,
+				     struct mock_memeq_matcher,
+				     matcher);
+	const void *actual = CONVERT_TO_ACTUAL_TYPE(const void *, pactual);
+	bool matches = !memcmp(actual, matcher->expected, matcher->size);
+	int i;
+
+	for (i = 0; i < matcher->size; i++)
+		kunit_stream_add(stream, "%02x, ", ((const char *) actual)[i]);
+	if (matches)
+		kunit_stream_add(stream, "== ");
+	else
+		kunit_stream_add(stream, "!= ");
+	for (i = 0; i < matcher->size; i++)
+		kunit_stream_add(stream,
+			    "%02x, ",
+			    ((const char *) matcher->expected)[i]);
+
+	return matches;
+}
+
+struct mock_param_matcher *kunit_memeq(struct kunit *test,
+				      const void *buf,
+				      size_t size)
+{
+	struct mock_memeq_matcher *matcher;
+
+	matcher = kunit_kzalloc(test, sizeof(*matcher), GFP_KERNEL);
+	if (!matcher)
+		return NULL;
+
+	matcher->matcher.match = match_memeq;
+	matcher->expected = buf;
+	matcher->size = size;
+
+	return &matcher->matcher;
+}
+
+struct mock_streq_matcher {
+	struct mock_param_matcher matcher;
+	const char *expected;
+};
+
+static bool match_streq(struct mock_param_matcher *pmatcher,
+			struct kunit_stream *stream,
+			const void *pactual)
+{
+	struct mock_streq_matcher *matcher =
+			container_of(pmatcher,
+				     struct mock_streq_matcher,
+				     matcher);
+	const char *actual = CONVERT_TO_ACTUAL_TYPE(const char *, pactual);
+	bool matches = !strcmp(actual, matcher->expected);
+
+	if (matches)
+		kunit_stream_add(stream, "%s == %s", actual, matcher->expected);
+	else
+		kunit_stream_add(stream, "%s != %s", actual, matcher->expected);
+
+	return matches;
+}
+
+struct mock_param_matcher *kunit_streq(struct kunit *test, const char *str)
+{
+	struct mock_streq_matcher *matcher;
+
+	matcher = kunit_kzalloc(test, sizeof(*matcher), GFP_KERNEL);
+	if (!matcher)
+		return NULL;
+
+	matcher->matcher.match = match_streq;
+	matcher->expected = str;
+
+	return &matcher->matcher;
+}
+
+#define DEFINE_RETURN_ACTION_STRUCT(type_name, type)			       \
+		struct mock_##type_name##_action {			       \
+			struct mock_action action;			       \
+			type ret;					       \
+		}
+
+#define DEFINE_RETURN_ACTION_FUNC(type_name, type)			       \
+		void *do_##type_name##_return(struct mock_action *paction,     \
+					      const void **params,	       \
+					      int len)			       \
+		{							       \
+			struct mock_##type_name##_action *action =	       \
+					container_of(paction,		       \
+						     struct mock_##type_name##_action,\
+						     action);		       \
+									       \
+			return (void *) &action->ret;			       \
+		}
+
+#define DEFINE_RETURN_ACTION_FACTORY(type_name, type)			       \
+		struct mock_action *kunit_##type_name##_return(		       \
+				struct kunit *test,			       \
+				type ret)				       \
+		{							       \
+			struct mock_##type_name##_action *action;	       \
+									       \
+			action = kunit_kmalloc(test,			       \
+					      sizeof(*action),		       \
+					      GFP_KERNEL);		       \
+			if (!action)					       \
+				return NULL;				       \
+									       \
+			action->action.do_action = do_##type_name##_return;    \
+			action->ret = ret;				       \
+									       \
+			return &action->action;				       \
+		}
+
+#define DEFINE_RETURN_ACTION_WITH_TYPENAME(type_name, type)		       \
+		DEFINE_RETURN_ACTION_STRUCT(type_name, type);		       \
+		DEFINE_RETURN_ACTION_FUNC(type_name, type);		       \
+		DEFINE_RETURN_ACTION_FACTORY(type_name, type)
+
+#define DEFINE_RETURN_ACTION(type) \
+		DEFINE_RETURN_ACTION_WITH_TYPENAME(type, type)
+
+DEFINE_RETURN_ACTION(u8);
+DEFINE_RETURN_ACTION(u16);
+DEFINE_RETURN_ACTION(u32);
+DEFINE_RETURN_ACTION(u64);
+DEFINE_RETURN_ACTION(char);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(uchar, unsigned char);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(schar, signed char);
+DEFINE_RETURN_ACTION(short);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(ushort, unsigned short);
+DEFINE_RETURN_ACTION(int);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(uint, unsigned int);
+DEFINE_RETURN_ACTION(long);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(ulong, unsigned long);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(longlong, long long);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(ulonglong, unsigned long long);
+DEFINE_RETURN_ACTION_WITH_TYPENAME(ptr, void *);
-- 
2.28.0.681.g6f77f65b4e-goog

