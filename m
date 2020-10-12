Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36728C4AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 00:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbgJLWVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 18:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbgJLWVi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA35C0613D5
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:36 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y7so13587681pff.20
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KffvDXhEQlg+xfMX19WD6tWJJFOKWMb6Lrz+5Uzyol4=;
        b=BuFfT35z9H4qdomlMLMhZvb1sjna4IRPRXT+qFeaWCXAzZmtePZ/Fh9Vxv5NQVZx67
         KIG2Rktqlc7u8sahaemTFP/Eyk0a1/KcgUhBPzvTV1QxvqIoEDKF6cZw/KN1HIXZx3BH
         uN5ChhSXgLomD1ucuyaF8+oIwtodtjW1DyKB2M+EyDJoB/AElxVkaBA09fkBhfB6aj77
         q+hl42C9hsBcrTcbrqHh42FPrKZHfML1/4t1bSGidmWtXWcccOamOr6XUjO5FEkqKV0r
         DMOWnnmCEG7ZXg/YGK1NAJr8At+NzLsLiu/UDBvuyZErDStWWbHgSp3AP4iB4gbPdFEq
         f4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KffvDXhEQlg+xfMX19WD6tWJJFOKWMb6Lrz+5Uzyol4=;
        b=k4hiQX7kolesAA0BLtNwvQKajsTZ7CEb7A6wLGg1C+e1gENTjDsaCYPxJjA1atYfvW
         v996BqcMzhdXi2pmly+XVR+tuJEPp33am8w+vRaFZFbgBIPbj7djiYgaiJHvQaGtpy6x
         bJrA3pylT8dVXPLfQNqR6iaqVqf1tlQqZj2PQ/sfvFuKWmBDgmveQqHLp5CNGO0KNLZd
         Xfa2+W24PCn/lF4MTVR9/krw1wCeXZB63q0f/5EFXURAZpQq1X9jETb9SiVij15JCJE+
         ve9zxiPMxhp8kjb3aHG/c4K1bzrX4T7PZwFN/CaQxzeWUaxVMMXtvsRLAzJcpoaBtTcr
         Fxcw==
X-Gm-Message-State: AOAM531C86lq/DrV+fgWjjXLMq0su2sEFNG8UiIutFc6xCtcY3w+KBc9
        nedEk+F3obQLFx8MaTQ2rK9CPBLwGJ+mvA==
X-Google-Smtp-Source: ABdhPJxqSEGlAC7GH81RuXLpynypIvywGZvOMgZpn0PWKicZlBwAJ9MadCsnQY+sTx3OPXBCTVfpXKAcfT/gPQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:902:7d8d:b029:d3:95b9:68ed with SMTP
 id a13-20020a1709027d8db02900d395b968edmr25412255plm.28.1602541295836; Mon,
 12 Oct 2020 15:21:35 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:48 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-11-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 10/12] kunit: mock: add class mocking support
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

Introduce basic class mocking, the ability to automatically generate a
Linux C-style class implementation whose behavior is controlled by test
cases, which can also set expectations on when and how mocks are called.

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/mock.h           | 433 +++++++++++++++++++++++++++++++++
 lib/kunit/Makefile             |   5 +-
 lib/kunit/kunit-example-test.c |  98 ++++++++
 lib/kunit/mock-macro-test.c    |  91 +++++++
 lib/kunit/mock-test.c          | 320 ++++++++++++++++++++++++
 5 files changed, 945 insertions(+), 2 deletions(-)
 create mode 100644 lib/kunit/mock-test.c

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index 13fdeb8730b5..9252a0abd295 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -123,6 +123,439 @@ struct mock_expectation *mock_add_matcher(struct mock *mock,
 					  struct mock_param_matcher *matchers[],
 					  int len);
 
+#define MOCK(name) name##_mock
+
+/**
+ * KUNIT_EXPECT_CALL() - Declares a *call expectation* on a mock function.
+ * @expectation_call: a mocked method or function with parameters replaced with
+ *                    matchers.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	// Class to mock.
+ *	struct example {
+ *		int (*foo)(struct example *, int);
+ *	};
+ *
+ *	// Define the mock.
+ *	DECLARE_STRUCT_CLASS_MOCK_PREREQS(example);
+ *
+ *	DEFINE_STRUCT_CLASS_MOCK(METHOD(foo), CLASS(example),
+ *				 RETURNS(int),
+ *				 PARAMS(struct example *, int));
+ *
+ *	static int example_init(struct MOCK(example) *mock_example)
+ *	{
+ *		struct example *example = mock_get_trgt(mock_example);
+ *
+ *		example->foo = foo;
+ *		return 0;
+ *	}
+ *
+ *	DEFINE_STRUCT_CLASS_MOCK_INIT(example, example_init);
+ *
+ *	static void foo_example_test_success(struct kunit *test)
+ *	{
+ *		struct MOCK(example) *mock_example;
+ *		struct example *example = mock_get_trgt(mock_example);
+ *		struct mock_expectation *handle;
+ *
+ *		mock_example = CONSTRUCT_MOCK(example, test);
+ *
+ *		handle = KUNIT_EXPECT_CALL(foo(mock_get_ctrl(mock_example),
+ *					       kunit_int_eq(test, 5)));
+ *		handle->action = int_return(test, 2);
+ *
+ *		KUNIT_EXPECT_EQ(test, 2, example_bar(example, 5));
+ *	}
+ *
+ * Return:
+ * A &struct mock_expectation representing the call expectation.
+ * allowing additional conditions and actions to be specified.
+ */
+#define KUNIT_EXPECT_CALL(expectation_call) mock_master_##expectation_call
+
+#define mock_get_ctrl_internal(mock_object) (&(mock_object)->ctrl)
+#define mock_get_ctrl(mock_object) mock_get_ctrl_internal(mock_object)
+
+#define mock_get_trgt_internal(mock_object) (&(mock_object)->trgt)
+#define mock_get_trgt(mock_object) mock_get_trgt_internal(mock_object)
+
+#define mock_get_test(mock_object) (mock_get_ctrl(mock_object)->test)
+
+#define CLASS(struct_name) struct_name
+#define HANDLE_INDEX(index) index
+#define METHOD(method_name) method_name
+#define RETURNS(return_type) return_type
+/* #define PARAMS(...) __VA_ARGS__ included by linux/tracepoint.h */
+
+#define MOCK_INIT_ID(struct_name) struct_name##mock_init
+#define REAL_ID(func_name) __real__##func_name
+#define INVOKE_ID(func_name) __invoke__##func_name
+
+#define DECLARE_MOCK_CLIENT(name, return_type, param_types...) \
+		return_type name(PARAM_LIST_FROM_TYPES(param_types))
+
+#define DECLARE_MOCK_MASTER(name, ctrl_index, param_types...)		       \
+		struct mock_expectation *mock_master_##name(		       \
+				MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index,      \
+							      param_types))
+
+#define DECLARE_MOCK_COMMON(name, handle_index, return_type, param_types...)   \
+		DECLARE_MOCK_CLIENT(name, return_type, param_types);	       \
+		DECLARE_MOCK_MASTER(name, handle_index, param_types)
+
+#define DECLARE_STRUCT_CLASS_MOCK_STRUCT(struct_name)			       \
+		struct MOCK(struct_name) {				       \
+			struct mock		ctrl;			       \
+			struct struct_name	trgt;			       \
+		}
+
+#define DECLARE_STRUCT_CLASS_MOCK_CONVERTER(struct_name)		       \
+		static inline struct mock *from_##struct_name##_to_mock(       \
+				const struct struct_name *trgt)		       \
+		{							       \
+			return mock_get_ctrl(				       \
+					container_of(trgt,		       \
+						     struct MOCK(struct_name), \
+						     trgt));		       \
+		}
+
+/**
+ * DECLARE_STRUCT_CLASS_MOCK_PREREQS() - Create a mock child class
+ * @struct_name: name of the class/struct to be mocked
+ *
+ * Creates a mock child class of ``struct_name`` named
+ * ``struct MOCK(struct_name)`` along with supporting internally used methods.
+ *
+ * See KUNIT_EXPECT_CALL() for example usages.
+ */
+#define DECLARE_STRUCT_CLASS_MOCK_PREREQS(struct_name)			       \
+		DECLARE_STRUCT_CLASS_MOCK_STRUCT(struct_name);		       \
+		DECLARE_STRUCT_CLASS_MOCK_CONVERTER(struct_name)
+
+#define DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,		       \
+							struct_name,	       \
+							handle_index,	       \
+							return_type,	       \
+							param_types...)	       \
+		DECLARE_MOCK_COMMON(name,				       \
+				    handle_index,			       \
+				    return_type,			       \
+				    param_types)
+
+#define DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,			       \
+					       struct_name,		       \
+					       handle_index,		       \
+					       return_type,		       \
+					       param_types...)		       \
+		DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,	       \
+								struct_name,   \
+								handle_index,  \
+								return_type,   \
+								param_types)
+
+/**
+ * DECLARE_STRUCT_CLASS_MOCK()
+ * @name: method name
+ * @struct_name: name of the class/struct
+ * @return_type: return type of the method
+ * @param_types: parameters of the method
+ *
+ * Same as DEFINE_STRUCT_CLASS_MOCK(), but only makes header compatible
+ * declarations.
+ */
+#define DECLARE_STRUCT_CLASS_MOCK(name,					       \
+				  struct_name,				       \
+				  return_type,				       \
+				  param_types...)			       \
+		DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,		       \
+						       struct_name,	       \
+						       0,		       \
+						       return_type,	       \
+						       param_types)
+
+/**
+ * DECLARE_STRUCT_CLASS_MOCK_VOID_RETURN()
+ * @name: method name
+ * @struct_name: name of the class/struct
+ * @param_types: parameters of the method
+ *
+ * Same as DEFINE_STRUCT_CLASS_MOCK_VOID_RETURN(), but only makes header
+ * compatible declarations.
+ */
+#define DECLARE_STRUCT_CLASS_MOCK_VOID_RETURN(name,			       \
+					      struct_name,		       \
+					      param_types...)		       \
+		DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,		       \
+						       struct_name,	       \
+						       0,		       \
+						       void,		       \
+						       param_types)
+
+/**
+ * DECLARE_STRUCT_CLASS_MOCK_INIT()
+ * @struct_name: name of the class/struct
+ *
+ * Same as DEFINE_STRUCT_CLASS_MOCK_INIT(), but only makes header compatible
+ * declarations.
+ */
+#define DECLARE_STRUCT_CLASS_MOCK_INIT(struct_name)			       \
+		struct MOCK(struct_name) *MOCK_INIT_ID(struct_name)(	       \
+				struct kunit *test)
+
+/**
+ * CONSTRUCT_MOCK()
+ * @struct_name: name of the class
+ * @test: associated test
+ *
+ * Constructs and allocates a test managed ``struct MOCK(struct_name)`` given
+ * the name of the class for which the mock is defined and a test object.
+ *
+ * See KUNIT_EXPECT_CALL() for example usage.
+ */
+#define CONSTRUCT_MOCK(struct_name, test) MOCK_INIT_ID(struct_name)(test)
+
+#define DEFINE_MOCK_CLIENT_COMMON(name,					       \
+				  handle_index,				       \
+				  MOCK_SOURCE,				       \
+				  mock_source_ctx,			       \
+				  return_type,				       \
+				  RETURN,				       \
+				  param_types...)			       \
+		return_type name(PARAM_LIST_FROM_TYPES(param_types))	       \
+		{							       \
+			struct mock *mock = MOCK_SOURCE(mock_source_ctx,       \
+							handle_index);	       \
+			static const char * const param_type_names[] = {       \
+				TYPE_NAMES_FROM_TYPES(handle_index,	       \
+						      param_types)	       \
+			};						       \
+			const void *params[] = {			       \
+				PTR_TO_ARG_FROM_TYPES(handle_index,	       \
+						      param_types)	       \
+			};						       \
+			const void *retval;				       \
+									       \
+			retval = mock->do_expect(mock,			       \
+						 #name,			       \
+						 name,			       \
+						 param_type_names,	       \
+						 params,		       \
+						 ARRAY_SIZE(params));	       \
+			KUNIT_ASSERT_NOT_ERR_OR_NULL(mock->test, retval);      \
+			if (!retval) {					       \
+				kunit_info(mock->test,			       \
+					   "no action installed for "#name"\n");\
+				BUG();					       \
+			}						       \
+			RETURN(return_type, retval);			       \
+		}
+
+#define CLASS_MOCK_CLIENT_SOURCE(ctx, handle_index) ctx(arg##handle_index)
+#define DEFINE_MOCK_METHOD_CLIENT_COMMON(name,				       \
+					 handle_index,			       \
+					 mock_converter,		       \
+					 return_type,			       \
+					 RETURN,			       \
+					 param_types...)		       \
+		DEFINE_MOCK_CLIENT_COMMON(name,				       \
+					  handle_index,			       \
+					  CLASS_MOCK_CLIENT_SOURCE,	       \
+					  mock_converter,		       \
+					  return_type,			       \
+					  RETURN,			       \
+					  param_types)
+
+#define CAST_AND_RETURN(return_type, retval) return *((return_type *) retval)
+#define NO_RETURN(return_type, retval)
+
+#define DEFINE_MOCK_METHOD_CLIENT(name,					       \
+				  handle_index,				       \
+				  mock_converter,			       \
+				  return_type,				       \
+				  param_types...)			       \
+		DEFINE_MOCK_METHOD_CLIENT_COMMON(name,			       \
+						 handle_index,		       \
+						 mock_converter,	       \
+						 return_type,		       \
+						 CAST_AND_RETURN,	       \
+						 param_types)
+
+#define DEFINE_MOCK_METHOD_CLIENT_VOID_RETURN(name,			       \
+					      handle_index,		       \
+					      mock_converter,		       \
+					      param_types...)		       \
+		DEFINE_MOCK_METHOD_CLIENT_COMMON(name,			       \
+						 handle_index,		       \
+						 mock_converter,	       \
+						 void,			       \
+						 NO_RETURN,		       \
+						 param_types)
+
+#define DEFINE_MOCK_MASTER_COMMON_INTERNAL(name,			       \
+					   ctrl_index,			       \
+					   MOCK_SOURCE,			       \
+					   param_types...)		       \
+		struct mock_expectation *mock_master_##name(		       \
+				MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index,      \
+							      param_types))    \
+		{ \
+			struct mock_param_matcher *matchers[] = {	       \
+				ARG_NAMES_FROM_TYPES(ctrl_index, param_types)  \
+			};						       \
+									       \
+			return mock_add_matcher(MOCK_SOURCE(ctrl_index),       \
+						#name,			       \
+						(const void *) name,	       \
+						matchers,		       \
+						ARRAY_SIZE(matchers));	       \
+		}
+#define DEFINE_MOCK_MASTER_COMMON(name,					       \
+				  ctrl_index,				       \
+				  MOCK_SOURCE,				       \
+				  param_types...)			       \
+		DEFINE_MOCK_MASTER_COMMON_INTERNAL(name,		       \
+						   ctrl_index,		       \
+						   MOCK_SOURCE,		       \
+						   param_types)
+
+#define CLASS_MOCK_MASTER_SOURCE(ctrl_index) arg##ctrl_index
+#define DEFINE_MOCK_METHOD_MASTER(name, ctrl_index, param_types...)	       \
+		DEFINE_MOCK_MASTER_COMMON(name,				       \
+					  ctrl_index,			       \
+					  CLASS_MOCK_MASTER_SOURCE,	       \
+					  param_types)
+
+#define DEFINE_MOCK_COMMON(name,					       \
+			   handle_index,				       \
+			   mock_converter,				       \
+			   return_type,					       \
+			   param_types...)				       \
+		DEFINE_MOCK_METHOD_CLIENT(name,				       \
+					  handle_index,			       \
+					  mock_converter,		       \
+					  return_type,			       \
+					  param_types);			       \
+		DEFINE_MOCK_METHOD_MASTER(name, handle_index, param_types)
+
+#define DEFINE_MOCK_COMMON_VOID_RETURN(name,				       \
+				       handle_index,			       \
+				       mock_converter,			       \
+				       param_types...)			       \
+		DEFINE_MOCK_METHOD_CLIENT_VOID_RETURN(name,		       \
+						      handle_index,	       \
+						      mock_converter,	       \
+						      param_types);	       \
+		DEFINE_MOCK_METHOD_MASTER(name, handle_index, param_types)
+
+#define DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,		       \
+						       struct_name,	       \
+						       handle_index,	       \
+						       return_type,	       \
+						       param_types...)	       \
+		DEFINE_MOCK_COMMON(name,				       \
+				   handle_index,			       \
+				   from_##struct_name##_to_mock,	       \
+				   return_type, param_types)
+#define DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,			       \
+					      struct_name,		       \
+					      handle_index,		       \
+					      return_type,		       \
+					      param_types...)		       \
+		DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_INTERNAL(name,	       \
+							       struct_name,    \
+							       handle_index,   \
+							       return_type,    \
+							       param_types)
+
+#define DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_VOID_RETURN_INTERNAL(	       \
+		name,							       \
+		struct_name,						       \
+		handle_index,						       \
+		param_types...)						       \
+		DEFINE_MOCK_COMMON_VOID_RETURN(name,			       \
+					       handle_index,		       \
+					       from_##struct_name##_to_mock,   \
+					       param_types)
+#define DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_VOID_RETURN(name,		       \
+							  struct_name,	       \
+							  handle_index,	       \
+							  param_types...)      \
+		DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_VOID_RETURN_INTERNAL(    \
+				name,					       \
+				struct_name,				       \
+				handle_index,				       \
+				param_types)
+
+/**
+ * DEFINE_STRUCT_CLASS_MOCK()
+ * @name: name of the method
+ * @struct_name: name of the class of which the method belongs
+ * @return_type: return type of the method to be created. **Must not be void.**
+ * @param_types: parameters to method to be created.
+ *
+ * See KUNIT_EXPECT_CALL() for example usage.
+ */
+#define DEFINE_STRUCT_CLASS_MOCK(name,					       \
+				 struct_name,				       \
+				 return_type,				       \
+				 param_types...)			       \
+		DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX(name,		       \
+						      struct_name,	       \
+						      0,		       \
+						      return_type,	       \
+						      param_types)
+
+/**
+ * DEFINE_STRUCT_CLASS_MOCK_VOID_RETURN()
+ * @name: name of the method
+ * @struct_name: name of the class of which the method belongs
+ * @param_types: parameters to method to be created.
+ *
+ * Same as DEFINE_STRUCT_CLASS_MOCK() except the method has a ``void`` return
+ * type.
+ */
+#define DEFINE_STRUCT_CLASS_MOCK_VOID_RETURN(name, struct_name, param_types...)\
+		DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX_VOID_RETURN(name,	       \
+								  struct_name, \
+								  0,	       \
+								  param_types)
+
+/**
+ * DEFINE_STRUCT_CLASS_MOCK_INIT()
+ * @struct_name: name of the class
+ * @init_func: a function of type ``int (*)(struct kunit *, struct MOCK(struct_name) *)``.
+ *             The function is passed a pointer to an allocated, *but not
+ *             initialized*, ``struct MOCK(struct_name)``. The job of this user
+ *             provided function is to perform remaining initialization. Usually
+ *             this entails assigning mock methods to the function pointers in
+ *             the parent struct.
+ *
+ * See KUNIT_EXPECT_CALL() for example usage.
+ */
+#define DEFINE_STRUCT_CLASS_MOCK_INIT(struct_name, init_func)		       \
+		struct MOCK(struct_name) *MOCK_INIT_ID(struct_name)(	       \
+				struct kunit *test)			       \
+		{							       \
+			struct MOCK(struct_name) *mock_obj;		       \
+									       \
+			mock_obj = kunit_kzalloc(test,			       \
+						sizeof(*mock_obj),	       \
+						GFP_KERNEL);		       \
+			if (!mock_obj)					       \
+				return NULL;				       \
+									       \
+			mock_init_ctrl(test, mock_get_ctrl(mock_obj));	       \
+									       \
+			if (init_func(test, mock_obj))			       \
+				return NULL;				       \
+									       \
+			return mock_obj;				       \
+		}
+
 #define CONVERT_TO_ACTUAL_TYPE(type, ptr) (*((type *) ptr))
 
 /**
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index a7a3c5e0a8bf..649e1c1f0d00 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -13,11 +13,12 @@ kunit-objs +=				debugfs.o
 endif
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o \
-					mock-macro-test.o
+					mock-macro-test.o \
+					mock-test.o
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
 obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
 endif
 
-obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST)	+= kunit-example-test.o
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index be1164ecc476..d6fff5a961ce 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/mock.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -29,6 +30,92 @@ static void example_simple_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+struct example_ops;
+
+struct example {
+  struct example_ops *ops;
+};
+
+/*
+ * A lot of times, we embed "ops structs", which acts an abstraction over
+ * hardware, a file system implementation, or some other subsystem that you
+ * want to reason about in a generic way.
+ */
+struct example_ops {
+	int (*foo)(struct example *example, int num);
+};
+
+static int example_bar(struct example *example, int num)
+{
+	return example->ops->foo(example, num);
+}
+
+/*
+ * KUnit allows such a class to be "mocked out" with the following:
+ */
+
+/*
+ * This macro creates a mock subclass of the specified class.
+ */
+DECLARE_STRUCT_CLASS_MOCK_PREREQS(example);
+
+/*
+ * This macro creates a mock implementation of the specified method of the
+ * specified class.
+ */
+DEFINE_STRUCT_CLASS_MOCK(METHOD(foo), CLASS(example),
+			 RETURNS(int),
+			 PARAMS(struct example *, int));
+
+/*
+ * This tells KUnit how to initialize the parts of the mock that come from the
+ * parent. In this example, all we have to do is populate the member functions
+ * of the parent class with the mock versions we defined.
+ */
+static int example_init(struct kunit *test, struct MOCK(example) *mock_example)
+{
+	/* This is how you get a pointer to the parent class of a mock. */
+	struct example *example = mock_get_trgt(mock_example);
+
+	/*
+	 * Here we create an ops struct containing our mock method instead.
+	 */
+	example->ops = kunit_kzalloc(test, sizeof(*example->ops), GFP_KERNEL);
+	example->ops->foo = foo;
+
+	return 0;
+}
+
+/*
+ * This registers our parent init function above, allowing KUnit to create a
+ * constructor for the mock.
+ */
+DEFINE_STRUCT_CLASS_MOCK_INIT(example, example_init);
+
+/*
+ * This is a test case where we use our mock.
+ */
+static void example_mock_test(struct kunit *test)
+{
+	struct MOCK(example) *mock_example = test->priv;
+	struct example *example = mock_get_trgt(mock_example);
+	struct mock_expectation *handle;
+
+	/*
+	 * Here we make an expectation that our mock method will be called with
+	 * a parameter equal to 5 passed in.
+	 */
+	handle = KUNIT_EXPECT_CALL(foo(mock_get_ctrl(mock_example),
+				       kunit_int_eq(test, 5)));
+	/*
+	 * We specify that when our mock is called in this way, we want it to
+	 * return 2.
+	 */
+	handle->action = kunit_int_return(test, 2);
+
+	KUNIT_EXPECT_EQ(test, 2, example_bar(example, 5));
+}
+
 /*
  * This is run once before each test case, see the comment on
  * example_test_suite for more information.
@@ -37,6 +124,16 @@ static int example_test_init(struct kunit *test)
 {
 	kunit_info(test, "initializing\n");
 
+	/*
+	 * Here we construct the mock and store it in test's `priv` field; this
+	 * field is for KUnit users. You can put whatever you want here, but
+	 * most often it is a place that the init function can put stuff to be
+	 * used by test cases.
+	 */
+	test->priv = CONSTRUCT_MOCK(example, test);
+	if (!test->priv)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -52,6 +149,7 @@ static struct kunit_case example_test_cases[] = {
 	 * test suite.
 	 */
 	KUNIT_CASE(example_simple_test),
+	KUNIT_CASE(example_mock_test),
 	{}
 };
 
diff --git a/lib/kunit/mock-macro-test.c b/lib/kunit/mock-macro-test.c
index 6c3dc2193edb..d196dbee2407 100644
--- a/lib/kunit/mock-macro-test.c
+++ b/lib/kunit/mock-macro-test.c
@@ -8,6 +8,55 @@
 
 #include <kunit/test.h>
 #include <kunit/params.h>
+#include <kunit/mock.h>
+
+struct mock_macro_dummy_struct {
+	int (*one_param)(struct mock_macro_dummy_struct *test_struct);
+	int (*two_param)(struct mock_macro_dummy_struct *test_struct, int num);
+	int (*non_first_slot_param)(
+			int num,
+			struct mock_macro_dummy_struct *test_struct);
+	void *(*void_ptr_return)(struct mock_macro_dummy_struct *test_struct);
+};
+
+DECLARE_STRUCT_CLASS_MOCK_PREREQS(mock_macro_dummy_struct);
+
+DEFINE_STRUCT_CLASS_MOCK(METHOD(one_param), CLASS(mock_macro_dummy_struct),
+			 RETURNS(int),
+			 PARAMS(struct mock_macro_dummy_struct *));
+
+DEFINE_STRUCT_CLASS_MOCK(METHOD(two_param), CLASS(mock_macro_dummy_struct),
+			 RETURNS(int),
+			 PARAMS(struct mock_macro_dummy_struct *, int));
+
+DEFINE_STRUCT_CLASS_MOCK_HANDLE_INDEX(METHOD(non_first_slot_param),
+			 CLASS(mock_macro_dummy_struct), HANDLE_INDEX(1),
+			 RETURNS(int),
+			 PARAMS(int, struct mock_macro_dummy_struct *));
+
+DEFINE_STRUCT_CLASS_MOCK(METHOD(void_ptr_return),
+			 CLASS(mock_macro_dummy_struct),
+			 RETURNS(void *),
+			 PARAMS(struct mock_macro_dummy_struct *));
+
+static int mock_macro_dummy_struct_init(
+		struct MOCK(mock_macro_dummy_struct) *mock_test_struct)
+{
+	struct mock_macro_dummy_struct *test_struct =
+			mock_get_trgt(mock_test_struct);
+
+	test_struct->one_param = one_param;
+	test_struct->two_param = two_param;
+	test_struct->non_first_slot_param = non_first_slot_param;
+	return 0;
+}
+
+DEFINE_STRUCT_CLASS_MOCK_INIT(mock_macro_dummy_struct,
+			      mock_macro_dummy_struct_init);
+
+struct mock_macro_context {
+	struct MOCK(mock_macro_dummy_struct) *mock_test_struct;
+};
 
 #define TO_STR_INTERNAL(...) #__VA_ARGS__
 #define TO_STR(...) TO_STR_INTERNAL(__VA_ARGS__)
@@ -132,6 +181,46 @@ static void mock_macro_arg_names_from_types(struct kunit *test)
 						      type15)));
 }
 
+static void mock_macro_test_generated_method_code_works(struct kunit *test)
+{
+	struct mock_macro_context *ctx = test->priv;
+	struct MOCK(mock_macro_dummy_struct) *mock_test_struct =
+			ctx->mock_test_struct;
+	struct mock_macro_dummy_struct *test_struct =
+			mock_get_trgt(mock_test_struct);
+	struct mock_expectation *handle;
+
+	handle = KUNIT_EXPECT_CALL(one_param(mock_get_ctrl(mock_test_struct)));
+	handle->action = kunit_int_return(test, 0);
+	handle = KUNIT_EXPECT_CALL(two_param(mock_get_ctrl(mock_test_struct),
+					     kunit_int_eq(test, 5)));
+	handle->action = kunit_int_return(test, 1);
+	handle = KUNIT_EXPECT_CALL(non_first_slot_param(
+			kunit_int_eq(test, 5),
+			mock_get_ctrl(mock_test_struct)));
+	handle->action = kunit_int_return(test, 1);
+
+	test_struct->one_param(test_struct);
+	test_struct->two_param(test_struct, 5);
+	test_struct->non_first_slot_param(5, test_struct);
+}
+
+static int mock_macro_test_init(struct kunit *test)
+{
+	struct mock_macro_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ctx->mock_test_struct = CONSTRUCT_MOCK(mock_macro_dummy_struct, test);
+	if (!ctx->mock_test_struct)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct kunit_case mock_macro_test_cases[] = {
 	KUNIT_CASE(mock_macro_is_equal),
 	KUNIT_CASE(mock_macro_if),
@@ -140,11 +229,13 @@ static struct kunit_case mock_macro_test_cases[] = {
 	KUNIT_CASE(mock_macro_for_each_param),
 	KUNIT_CASE(mock_macro_param_list_from_types_basic),
 	KUNIT_CASE(mock_macro_arg_names_from_types),
+	KUNIT_CASE(mock_macro_test_generated_method_code_works),
 	{}
 };
 
 static struct kunit_suite mock_macro_test_suite = {
 	.name = "mock-macro-test",
+	.init = mock_macro_test_init,
 	.test_cases = mock_macro_test_cases,
 };
 kunit_test_suite(mock_macro_test_suite);
diff --git a/lib/kunit/mock-test.c b/lib/kunit/mock-test.c
new file mode 100644
index 000000000000..8a0fa33d087c
--- /dev/null
+++ b/lib/kunit/mock-test.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for mock.h.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/mock.h>
+
+// A simple class for unit-testing/example purposes.
+struct adder {
+	int (*add)(struct adder *adder, int x, int y);
+};
+
+static int real_add(struct adder *adder, int x, int y)
+{
+	return x + y;
+}
+
+static void adder_real_init(struct adder *adder)
+{
+	  adder->add = real_add;
+}
+
+DECLARE_STRUCT_CLASS_MOCK_PREREQS(adder);
+DEFINE_STRUCT_CLASS_MOCK(METHOD(mock_add), CLASS(adder), RETURNS(int),
+				     PARAMS(struct adder*, int, int));
+DECLARE_STRUCT_CLASS_MOCK_INIT(adder);
+
+// This would normally live in the .c file.
+static int adder_mock_init(struct MOCK(adder) *mock_adder)
+{
+	struct adder *real = mock_get_trgt(mock_adder);
+
+	adder_real_init(real);
+
+	real->add = mock_add;
+	mock_set_default_action(mock_get_ctrl(mock_adder),
+				"mock_add",
+				mock_add,
+				kunit_int_return(mock_get_test(mock_adder), 0));
+	return 0;
+}
+DEFINE_STRUCT_CLASS_MOCK_INIT(adder, adder_mock_init);
+
+
+/*
+ * Note: we create a new `failing_test` so we can validate that failed mock
+ * expectations mark tests as failed.
+ * Marking the real `test` as failed is obviously problematic.
+ *
+ * See mock_test_failed_expect_call_fails_test for an example.
+ */
+struct mock_test_context {
+	struct kunit *failing_test;
+	struct mock  *mock;
+};
+
+static void mock_test_do_expect_basic(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct mock *mock = ctx->mock;
+	int param0 = 5, param1 = -4;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *matchers_any_two[] = {
+		kunit_any(test), kunit_any(test)
+	};
+	struct mock_expectation *expectation;
+	const void *ret;
+
+	expectation = mock_add_matcher(mock,
+				       "",
+				       NULL,
+				       matchers_any_two,
+				       ARRAY_SIZE(matchers_any_two));
+	expectation->action = kunit_int_return(test, 5);
+	KUNIT_EXPECT_EQ(test, 0, expectation->times_called);
+
+	ret = mock->do_expect(mock,
+			      "",
+			      NULL,
+			      two_param_types,
+			      two_params,
+			      ARRAY_SIZE(two_params));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_EQ(test, 5, *((int *) ret));
+	KUNIT_EXPECT_EQ(test, 1, expectation->times_called);
+}
+
+static void mock_test_ptr_eq(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+	void *param0 = ctx, *param1 = failing_test;
+	static const char * const two_param_types[] = {"void *", "void *"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *matchers_two_ptrs[] = {
+		kunit_ptr_eq(test, param0), kunit_ptr_eq(test, param1)
+	};
+	struct mock_expectation *expectation;
+	const void *ret;
+
+	expectation = mock_add_matcher(mock,
+				       "",
+				       NULL,
+				       matchers_two_ptrs,
+				       ARRAY_SIZE(matchers_two_ptrs));
+	expectation->action = kunit_int_return(test, 0);
+	KUNIT_EXPECT_EQ(test, 0, expectation->times_called);
+
+	ret = mock->do_expect(mock,
+			      "",
+			      NULL,
+			      two_param_types,
+			      two_params,
+			      ARRAY_SIZE(two_params));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_EQ(test, 1, expectation->times_called);
+}
+
+static void mock_test_ptr_eq_not_equal(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+
+	/* Pick some two pointers, but pass in different values. */
+	void *param0 = test, *param1 = failing_test;
+	static const char * const two_param_types[] = {"void *", "void *"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *matchers_two_ptrs[] = {
+		kunit_ptr_eq(failing_test, param0),
+		kunit_ptr_eq(failing_test, param1 - 1)
+	};
+	struct mock_expectation *expectation;
+	const void *ret;
+
+	expectation = mock_add_matcher(mock,
+				       "",
+				       NULL,
+				       matchers_two_ptrs,
+				       ARRAY_SIZE(matchers_two_ptrs));
+	expectation->action = kunit_int_return(failing_test, 0);
+	KUNIT_EXPECT_EQ(test, 0, expectation->times_called);
+
+	ret = mock->do_expect(mock,
+			      "",
+			      NULL,
+			      two_param_types,
+			      two_params,
+			      ARRAY_SIZE(two_params));
+	KUNIT_EXPECT_FALSE(test, ret);
+	KUNIT_EXPECT_EQ(test, 0, expectation->times_called);
+
+	KUNIT_EXPECT_FALSE(test, failing_test->success);
+}
+
+/*
+ * In order for us to be able to rely on KUNIT_EXPECT_CALL to validate other
+ * behavior, we need to test that unsatisfied KUNIT_EXPECT_CALL causes a test
+ * failure.
+ *
+ * In order to understand what this test is testing we must first understand how
+ * KUNIT_EXPECT_CALL() works conceptually. In theory, a test specifies that it
+ * expects some function to be called some number of times (can be zero), with
+ * some particular arguments. Hence, KUNIT_EXPECT_CALL() must do two things:
+ *
+ * 1) Determine whether a function call matches the expectation.
+ *
+ * 2) Fail if there are too many or too few matches.
+ */
+static void mock_test_failed_expect_call_fails_test(struct kunit *test)
+{
+       /*
+	* We do not want to fail the real `test` object used to run this test.
+	* So we use a separate `failing_test` for KUNIT_EXPECT_CALL().
+	*/
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+
+	/*
+	 * Put an expectation on mock, which we won't satisify.
+	 *
+	 * NOTE: it does not actually matter what function we expect here.
+	 * `mock` does not represent an actual mock on anything; we just need to
+	 * create some expectation, that we won't satisfy.
+	 */
+	KUNIT_EXPECT_CALL(mock_add(mock,
+			       kunit_any(failing_test),
+			       kunit_any(failing_test)));
+
+	/*
+	 * Validate the unsatisfied expectation that we just created. This
+	 * should cause `failing_test` to fail.
+	 */
+	mock_validate_expectations(mock);
+
+	/* Verify that `failing_test` has actually failed. */
+	KUNIT_EXPECT_FALSE(test, failing_test->success);
+}
+
+static void mock_test_do_expect_default_return(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct mock *mock = ctx->mock;
+	int param0 = 5, param1 = -5;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *matchers[] = {
+		kunit_int_eq(test, 5),
+		kunit_int_eq(test, -4)
+	};
+	struct mock_expectation *expectation;
+	const void *ret;
+
+	expectation = mock_add_matcher(mock,
+				       "add",
+				       mock_add,
+				       matchers,
+				       ARRAY_SIZE(matchers));
+	expectation->action = kunit_int_return(test, 5);
+	KUNIT_EXPECT_EQ(test, 0, expectation->times_called);
+
+	KUNIT_EXPECT_FALSE(test,
+			   mock_set_default_action(mock,
+						   "add",
+						   mock_add,
+						   kunit_int_return(test, -4)));
+
+	ret = mock->do_expect(mock,
+			      "add",
+			      mock_add,
+			      two_param_types,
+			      two_params,
+			      ARRAY_SIZE(two_params));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_EQ(test, -4, *((int *) ret));
+	KUNIT_EXPECT_EQ(test, 0, expectation->times_called);
+}
+
+static void mock_test_mock_validate_expectations(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+
+	struct mock_param_matcher *matchers[] = {
+		kunit_int_eq(failing_test, 5),
+		kunit_int_eq(failing_test, -4)
+	};
+	struct mock_expectation *expectation;
+
+
+	expectation = mock_add_matcher(mock,
+				       "add",
+				       mock_add,
+				       matchers,
+				       ARRAY_SIZE(matchers));
+	expectation->times_called = 0;
+	expectation->min_calls_expected = 1;
+	expectation->max_calls_expected = 1;
+
+	mock_validate_expectations(mock);
+
+	KUNIT_EXPECT_FALSE(test, failing_test->success);
+}
+
+static int mock_test_init(struct kunit *test)
+{
+	struct mock_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ctx->failing_test = kunit_kzalloc(test, sizeof(*ctx->failing_test),
+					  GFP_KERNEL);
+	if (!ctx->failing_test)
+		return -EINVAL;
+	kunit_init_test(ctx->failing_test, NULL, NULL);
+
+	ctx->mock = kunit_kzalloc(test, sizeof(*ctx->mock), GFP_KERNEL);
+	if (!ctx->mock)
+		return -ENOMEM;
+	mock_init_ctrl(ctx->failing_test, ctx->mock);
+
+	return 0;
+}
+
+static void mock_test_exit(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+
+	kunit_cleanup(ctx->failing_test);
+}
+
+static struct kunit_case mock_test_cases[] = {
+	KUNIT_CASE(mock_test_do_expect_basic),
+	KUNIT_CASE(mock_test_ptr_eq),
+	KUNIT_CASE(mock_test_ptr_eq_not_equal),
+	KUNIT_CASE(mock_test_failed_expect_call_fails_test),
+	KUNIT_CASE(mock_test_do_expect_default_return),
+	KUNIT_CASE(mock_test_mock_validate_expectations),
+	{}
+};
+
+static struct kunit_suite mock_test_suite = {
+	.name = "mock-test",
+	.init = mock_test_init,
+	.exit = mock_test_exit,
+	.test_cases = mock_test_cases,
+};
+
+kunit_test_suite(mock_test_suite);
-- 
2.28.0.1011.ga647a8990f-goog

