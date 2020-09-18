Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B40270423
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgIRScf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIRScD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 14:32:03 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448ECC0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:03 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q5so4229627pfl.16
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OvE24RBaTPGyK9apnYCTW1kmoNgGJiKtgntIzpTwFdc=;
        b=tdtIV0xzs1v8i9x+wHdPwLcwB/DA/u+4mxYnQqAbtGbK+5WdfmhDCQiUn5gI6hYv3k
         fwLeMg/l59CUFri+NQ+mqnTxPannHZbq9X5oCUHqhrzm80yt19HU0Jd8Xd0g9vwlHXTp
         5GyR/YEdYS5chtV9LVXRPoOwVEs4oxfC0tMgMos2+cwNW0ZpN9VYB3zltIZr/Upbou8G
         59XYz4o9nMsRx71PcBMx8+UvjtrjhJJMzPfCxhqt5wx/9EXAEzDJqLI6gr58idiNxqNB
         U1HOEDtQT05ElSeIRJUvTuQNRIfsQnyOHz34nukIYtHllNj/u2zsmCqc8/wM0RynJ9Pf
         leAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OvE24RBaTPGyK9apnYCTW1kmoNgGJiKtgntIzpTwFdc=;
        b=ihWYut/FLB/LE2hQUqDN6Dyb8Rk7g2N205pQszCElkfopBId3WaSwC4X+t5xTOL50k
         T2kEiNxzd6lWQfVG4ko0fspq8WlAv0APsHjd+hGsXnZ3sKpduz5Fsyn9LeCRxFgob/FM
         PRJZJ60xGRm4cs4KyMSYplmFICujM0Y8SWP3Ssju1khVmcPnMh9VhfW0J+iLoGH3R03D
         XrJZtlNjxokdaUL8rVbDmX1DLiH/odB2sVZN2ncq1YHCXFLDQt4q25l+Gz8ato1UbXeN
         uJsM4f+ME/Wff9YDkqtGOsmQfqGyxovtCNjr6KaAllbu0PP5P2RHjNFhftpX0ZH5ezZv
         2bsw==
X-Gm-Message-State: AOAM532q8mowl9COtdgI/SXx3jUQJhHuWaEtVOfDmipci1yG75XAcrWn
        zu6TAGejXyV+UE8ezCOEbcMhcJsCuFrwpw==
X-Google-Smtp-Source: ABdhPJz2AmYlTZojZyPlN7lFjs29ihgs582F4haH0Ki7vq3VdwOvUDcQdsHRwM3mr9xIEvfFnM0pmL6Te9E4XQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:902:8210:b029:d2:344:4e28 with SMTP
 id x16-20020a1709028210b02900d203444e28mr6531020pln.4.1600453922662; Fri, 18
 Sep 2020 11:32:02 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:07 -0700
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
Message-Id: <20200918183114.2571146-6-dlatypov@google.com>
Mime-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 05/12] kunit: mock: add parameter list manipulation macros
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

Add macros for parsing and manipulating parameter lists needed for
generating mocks.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/params.h      | 305 ++++++++++++++++++++++++++++++++++++
 lib/kunit/Makefile          |   3 +-
 lib/kunit/mock-macro-test.c | 150 ++++++++++++++++++
 3 files changed, 457 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/params.h
 create mode 100644 lib/kunit/mock-macro-test.c

diff --git a/include/kunit/params.h b/include/kunit/params.h
new file mode 100644
index 000000000000..06efcb58c2c0
--- /dev/null
+++ b/include/kunit/params.h
@@ -0,0 +1,305 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros for parsing and manipulating parameter lists needed for generating
+ * mocks.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_PARAMS_H
+#define _KUNIT_PARAMS_H
+
+#define NUM_VA_ARGS_IMPL(__dummy,					       \
+			 __1,						       \
+			 __2,						       \
+			 __3,						       \
+			 __4,						       \
+			 __5,						       \
+			 __6,						       \
+			 __7,						       \
+			 __8,						       \
+			 __9,						       \
+			 __10,						       \
+			 __11,						       \
+			 __12,						       \
+			 __13,						       \
+			 __14,						       \
+			 __15,						       \
+			 __16,						       \
+			 __nargs, args...) __nargs
+
+#define NUM_VA_ARGS(args...) NUM_VA_ARGS_IMPL(__dummy, ##args,		       \
+					  16,				       \
+					  15,				       \
+					  14,				       \
+					  13,				       \
+					  12,				       \
+					  11,				       \
+					  10,				       \
+					  9,				       \
+					  8,				       \
+					  7,				       \
+					  6,				       \
+					  5,				       \
+					  4,				       \
+					  3,				       \
+					  2,				       \
+					  1,				       \
+					  0)
+
+#define CONCAT_INTERNAL(left, right) left##right
+#define CONCAT(left, right) CONCAT_INTERNAL(left, right)
+
+#define EMPTY()
+
+/*
+ * Takes the name of a function style macro such as FOO() and prevents it from
+ * being evaluated on the current pass.
+ *
+ * This is useful when you need to write a "recursive" macro since a macro name
+ * becomes painted after it is pasted. If a different macro is pasted, this
+ * different macro won't be pasted; if we then defer the evaluation of the this
+ * "indirection macro", we can prevent the original definition from getting
+ * painted.
+ *
+ * Example:
+ *   #define EXAMPLE EXPAND(FOO()) // FOO() is evaluated on 1st pass.
+ *   #define EXAMPLE EXPAND(DEFER(FOO)()) // FOO() is evaluated on the second
+ *					  // pass.
+ */
+#define DEFER(macro_id) macro_id EMPTY()
+
+/*
+ * Takes the name of a function style macro such as FOO() and prevents it from
+ * being evaluated on the current or following pass.
+ *
+ * This is useful when you need to DEFER inside an operation which causes an
+ * extra pass, like IF.
+ *
+ * Example:
+ *   #define EXAMPLE EXPAND(FOO()) // FOO() is evaluated on 1st pass.
+ *   #define EXAMPLE EXPAND(DEFER(FOO)()) // FOO() is evaluated on the second
+ *					  // pass.
+ *   #define EXAMPLE EXPAND(OBSTRUCT(FOO)()) // FOO() is evaluated on the third
+ *					     // pass.
+ */
+#define OBSTRUCT(macro_id) macro_id DEFER(EMPTY)()
+
+#define EXPAND_1(args...) args
+#define EXPAND_2(args...) EXPAND_1(EXPAND_1(args))
+#define EXPAND_4(args...) EXPAND_2(EXPAND_2(args))
+#define EXPAND_8(args...) EXPAND_4(EXPAND_4(args))
+#define EXPAND_16(args...) EXPAND_8(EXPAND_8(args))
+
+/*
+ * Causes multiple evaluation passes of a macro.
+ *
+ * CPP is implemented as a push down automaton. It consumes a stream of tokens
+ * and as it comes across macros, it either evaluates them and pastes the
+ * result, or if the macro is a function macro, it pushes the macro to a stack,
+ * it evaluates the input to the function macro, pops the state from the stack
+ * and continues.
+ *
+ * This macro serves the function of making the cursor return to the beginging
+ * of a macro that requires mulitple passes to evaluate. It is most useful when
+ * used with DEFER(...) and OBSTRUCT(...).
+ */
+#define EXPAND(args...) EXPAND_16(args)
+
+#define INC(id) INC_##id
+#define INC_0  1
+#define INC_1  2
+#define INC_2  3
+#define INC_3  4
+#define INC_4  5
+#define INC_5  6
+#define INC_6  7
+#define INC_7  8
+#define INC_8  9
+#define INC_9  10
+#define INC_10 11
+#define INC_11 12
+#define INC_12 13
+#define INC_13 14
+#define INC_14 15
+#define INC_15 16
+#define INC_16 17
+
+#define DEC(id) DEC_##id
+#define DEC_1  0
+#define DEC_2  1
+#define DEC_3  2
+#define DEC_4  3
+#define DEC_5  4
+#define DEC_6  5
+#define DEC_7  6
+#define DEC_8  7
+#define DEC_9  8
+#define DEC_10 9
+#define DEC_11 10
+#define DEC_12 11
+#define DEC_13 12
+#define DEC_14 13
+#define DEC_15 14
+#define DEC_16 15
+
+#define DROP_FIRST_ARG_INTERNAL(dropped, x, args...) x
+#define DROP_FIRST_ARG(args...) DROP_FIRST_ARG_INTERNAL(args)
+
+#define EQUAL(left, right) EQUAL_##left##_##right
+#define EQUAL_0_0 dropped, 1
+#define EQUAL_1_1 dropped, 1
+#define EQUAL_2_2 dropped, 1
+#define EQUAL_3_3 dropped, 1
+#define EQUAL_4_4 dropped, 1
+#define EQUAL_5_5 dropped, 1
+#define EQUAL_6_6 dropped, 1
+#define EQUAL_7_7 dropped, 1
+#define EQUAL_8_8 dropped, 1
+#define EQUAL_9_9 dropped, 1
+#define EQUAL_10_10 dropped, 1
+#define EQUAL_11_11 dropped, 1
+#define EQUAL_12_12 dropped, 1
+#define EQUAL_13_13 dropped, 1
+#define EQUAL_14_14 dropped, 1
+#define EQUAL_15_15 dropped, 1
+#define EQUAL_16_16 dropped, 1
+
+#define IS_EQUAL(left, right) DROP_FIRST_ARG(EQUAL(left, right), 0)
+
+#define NOT_INTERNAL(condition) NOT_##condition
+#define NOT(condition) NOT_INTERNAL(condition)
+#define NOT_0 1
+#define NOT_1 0
+
+#define IS_NOT_EQUAL(left, right) NOT(IS_EQUAL(left, right))
+
+#define EMPTY_IMPL(tokens) CONCAT(EMPTY_, tokens)
+#define IS_EMPTY(tokens)
+
+#define OR_INTERNAL(left, right) OR_##left##_##right
+#define OR(left, right) OR_INTERNAL(left, right)
+#define OR_0_0 0
+#define OR_0_1 1
+#define OR_1_0 1
+#define OR_1_1 1
+
+#define IF(condition) CONCAT(IF_, condition)
+#define IF_0(body)
+#define IF_1(body) body
+
+#define COMMA() ,
+
+#define APPLY_TOKENS_INTERNAL(tokens, yield_token, seen_token) \
+		IF(yield_token)(IF(seen_token)(COMMA()) tokens)
+#define APPLY_TOKENS(tokens, yield_token, seen_token) \
+		APPLY_TOKENS_INTERNAL(tokens, yield_token, seen_token)
+
+/*
+ * Provides the indirection to keep the PARAM_LIST_RECURSE_INTERNAL from getting
+ * pasted, only useful if used with DEFER(...) or OBSTRUCT(...).
+ */
+#define PARAM_LIST_RECURSE_INDIRECT() PARAM_LIST_RECURSE_INTERNAL
+
+/*
+ * Given a starting index, a number of args, a MACRO to apply, and a list of
+ * types (with at least one element) this will call MACRO with the first type in
+ * the list and index; it will then call itself again on all remaining types, if
+ * any, while incrementing index, and decrementing nargs.
+ *
+ * Assumes nargs is the number of types in the list.
+ */
+#define PARAM_LIST_RECURSE_INTERNAL(index,				       \
+				    nargs,				       \
+				    MACRO,				       \
+				    FILTER,				       \
+				    context,				       \
+				    seen_token,				       \
+				    type,				       \
+				    args...)				       \
+		APPLY_TOKENS(MACRO(context, type, index),		       \
+			     FILTER(context, type, index),		       \
+			     seen_token)				       \
+		IF(IS_NOT_EQUAL(nargs, 1))				       \
+			(OBSTRUCT(PARAM_LIST_RECURSE_INDIRECT)()	       \
+			 (INC(index), DEC(nargs),			       \
+			  MACRO, FILTER, context,			       \
+			  OR(seen_token, FILTER(context, type, index)),	       \
+			  args))
+
+#define PARAM_LIST_RECURSE(index, nargs, MACRO, FILTER, context, args...)      \
+		IF(IS_NOT_EQUAL(nargs, 0))				       \
+			(OBSTRUCT(PARAM_LIST_RECURSE_INTERNAL)(index,	       \
+							       nargs,	       \
+							       MACRO,	       \
+							       FILTER,	       \
+							       context,	       \
+							       0,	       \
+							       args))
+
+#define FILTER_NONE(context, type, index) 1
+
+#define FILTER_INDEX_INTERNAL(index_to_drop, type, index) \
+		IS_NOT_EQUAL(index, index_to_drop)
+#define FILTER_INDEX(index_to_drop, type, index) \
+		FILTER_INDEX_INTERNAL(index_to_drop, type, index)
+
+/*
+ * Applies a MACRO which takes a type and the index of the type and outputs a
+ * sequence of tokens to a list of types.
+ */
+#define FOR_EACH_PARAM(MACRO, FILTER, context, args...) \
+		EXPAND(PARAM_LIST_RECURSE(0,\
+					  NUM_VA_ARGS(args),\
+					  MACRO,\
+					  FILTER,\
+					  context,\
+					  args))
+
+#define PRODUCE_TYPE_AND_ARG(context, type, index) type arg##index
+#define PARAM_LIST_FROM_TYPES(args...)					       \
+		FOR_EACH_PARAM(PRODUCE_TYPE_AND_ARG,			       \
+			       FILTER_NONE,				       \
+			       not_used,				       \
+			       args)
+
+#define PRODUCE_TYPE_NAME(context, type, index) #type
+#define TYPE_NAMES_FROM_TYPES(handle_index, args...)			       \
+		FOR_EACH_PARAM(PRODUCE_TYPE_NAME,			       \
+			       FILTER_INDEX,				       \
+			       handle_index,				       \
+			       args)
+
+#define PRODUCE_PTR_TO_ARG(context, type, index) &arg##index
+#define PTR_TO_ARG_FROM_TYPES(handle_index, args...)			       \
+		FOR_EACH_PARAM(PRODUCE_PTR_TO_ARG,			       \
+			       FILTER_INDEX,				       \
+			       handle_index,				       \
+			       args)
+
+#define PRODUCE_MATCHER_AND_ARG(ctrl_index, type, index)		       \
+		IF(IS_EQUAL(index, ctrl_index))(struct mock *arg##ctrl_index)  \
+		IF(IS_NOT_EQUAL(index, ctrl_index))(			       \
+				struct mock_param_matcher *arg##index)
+#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)		       \
+		FOR_EACH_PARAM(PRODUCE_MATCHER_AND_ARG,			       \
+			       FILTER_NONE,				       \
+			       ctrl_index,				       \
+			       args)
+
+#define PRODUCE_ARG(context, type, index) arg##index
+#define ARG_NAMES_FROM_TYPES(ctrl_index, args...)			       \
+		FOR_EACH_PARAM(PRODUCE_ARG,				       \
+			       FILTER_INDEX,				       \
+			       ctrl_index,				       \
+			       args)
+
+#define PRODUCE_ARRAY_ACCESSOR(context, type, index) *((type *) params[index])
+#define ARRAY_ACCESSORS_FROM_TYPES(args...)				       \
+		FOR_EACH_PARAM(PRODUCE_ARRAY_ACCESSOR,			       \
+			       FILTER_NONE,				       \
+			       not_used,				       \
+			       args)
+
+#endif /* _KUNIT_PARAMS_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 523a7b0f9783..1707660c8b1c 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -10,7 +10,8 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
 
-obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o \
+					mock-macro-test.o
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/mock-macro-test.c b/lib/kunit/mock-macro-test.c
new file mode 100644
index 000000000000..6c3dc2193edb
--- /dev/null
+++ b/lib/kunit/mock-macro-test.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for parameter list parsing macros.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/params.h>
+
+#define TO_STR_INTERNAL(...) #__VA_ARGS__
+#define TO_STR(...) TO_STR_INTERNAL(__VA_ARGS__)
+
+static void mock_macro_is_equal(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, "dropped, 1", TO_STR(EQUAL(1, 1)));
+	KUNIT_EXPECT_EQ(test, 1, DROP_FIRST_ARG(dropped, 1, 0));
+	KUNIT_EXPECT_EQ(test, 0, DROP_FIRST_ARG(1, 0));
+	KUNIT_EXPECT_EQ(test, 0, DROP_FIRST_ARG(EQUAL(1, 0), 0));
+	KUNIT_EXPECT_EQ(test, 1, IS_EQUAL(1, 1));
+	KUNIT_EXPECT_EQ(test, 0, IS_EQUAL(1, 0));
+}
+
+static void mock_macro_if(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, "body", ""IF(1)("body"));
+	KUNIT_EXPECT_STREQ(test, "", ""IF(0)("body"));
+	KUNIT_EXPECT_STREQ(test, "body", ""IF(IS_EQUAL(1, 1))("body"));
+	KUNIT_EXPECT_STREQ(test, "", ""IF(IS_EQUAL(0, 1))("body"));
+}
+
+static void mock_macro_apply_tokens(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, "type", TO_STR(APPLY_TOKENS(type, 1, 0)));
+	KUNIT_EXPECT_STREQ(test, ", type", TO_STR(APPLY_TOKENS(type, 1, 1)));
+	KUNIT_EXPECT_STREQ(test, "", TO_STR(APPLY_TOKENS(type, 0, 1)));
+}
+
+#define IDENTITY(context, type, index) type
+
+static void mock_macro_param_list_recurse(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, "", TO_STR(PARAM_LIST_RECURSE(0,
+							      0,
+							      IDENTITY,
+							      FILTER_NONE,
+							      not_used)));
+	KUNIT_EXPECT_STREQ(test,
+			  "type",
+			  TO_STR(EXPAND(PARAM_LIST_RECURSE(0,
+							   1,
+							   IDENTITY,
+							   FILTER_NONE,
+							   not_used,
+							   type))));
+	KUNIT_EXPECT_STREQ(test,
+			  "type0 , type1 , type2 , type3 , type4 , type5 , "
+			  "type6 , type7 , type8 , type9 , type10 , type11 , "
+			  "type12 , type13 , type14 , type15",
+			  TO_STR(EXPAND(PARAM_LIST_RECURSE(0, 16,
+							   IDENTITY,
+							   FILTER_NONE,
+							   not_used,
+							   type0, type1, type2,
+							   type3, type4, type5,
+							   type6, type7, type8,
+							   type9, type10,
+							   type11, type12,
+							   type13, type14,
+							   type15))));
+}
+
+static void mock_macro_for_each_param(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test,
+			  "type0 , type1",
+			  TO_STR(FOR_EACH_PARAM(IDENTITY,
+						FILTER_NONE,
+						not_used,
+						type0,
+						type1)));
+	KUNIT_EXPECT_STREQ(test,
+			  "type1",
+			  TO_STR(FOR_EACH_PARAM(IDENTITY,
+						FILTER_INDEX,
+						0,
+						type0,
+						type1)));
+}
+
+static void mock_macro_param_list_from_types_basic(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, "", TO_STR(PARAM_LIST_FROM_TYPES()));
+	KUNIT_EXPECT_STREQ(test, "int arg0",
+			   TO_STR(PARAM_LIST_FROM_TYPES(int)));
+	KUNIT_EXPECT_STREQ(test, "struct kunit_struct * arg0 , int arg1",
+			  TO_STR(PARAM_LIST_FROM_TYPES(struct kunit_struct *,
+						       int)));
+	KUNIT_EXPECT_STREQ(test,
+			  "type0 arg0 , type1 arg1 , type2 arg2 , type3 arg3 , "
+			  "type4 arg4 , type5 arg5 , type6 arg6 , type7 arg7 , "
+			  "type8 arg8 , type9 arg9 , type10 arg10 , "
+			  "type11 arg11 , type12 arg12 , type13 arg13 , "
+			  "type14 arg14 , type15 arg15",
+			  TO_STR(PARAM_LIST_FROM_TYPES(type0, type1, type2,
+						       type3, type4, type5,
+						       type6, type7, type8,
+						       type9, type10, type11,
+						       type12, type13, type14,
+						       type15)));
+}
+
+static void mock_macro_arg_names_from_types(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, "", TO_STR(ARG_NAMES_FROM_TYPES(0)));
+	KUNIT_EXPECT_STREQ(test, "", TO_STR(ARG_NAMES_FROM_TYPES(0, int)));
+	KUNIT_EXPECT_STREQ(test,
+			  "arg1",
+			  TO_STR(ARG_NAMES_FROM_TYPES(0,
+						      struct kunit_struct *,
+						      int)));
+	KUNIT_EXPECT_STREQ(test,
+			  "arg0 , arg1 , arg3 , arg4 , arg5 , arg6 , arg7 , "
+			  "arg8 , arg9 , arg10 , arg11 , arg12 , arg13 , "
+			  "arg14 , arg15",
+			  TO_STR(ARG_NAMES_FROM_TYPES(2, type0, type1, type2,
+						      type3, type4, type5,
+						      type6, type7, type8,
+						      type9, type10, type11,
+						      type12, type13, type14,
+						      type15)));
+}
+
+static struct kunit_case mock_macro_test_cases[] = {
+	KUNIT_CASE(mock_macro_is_equal),
+	KUNIT_CASE(mock_macro_if),
+	KUNIT_CASE(mock_macro_apply_tokens),
+	KUNIT_CASE(mock_macro_param_list_recurse),
+	KUNIT_CASE(mock_macro_for_each_param),
+	KUNIT_CASE(mock_macro_param_list_from_types_basic),
+	KUNIT_CASE(mock_macro_arg_names_from_types),
+	{}
+};
+
+static struct kunit_suite mock_macro_test_suite = {
+	.name = "mock-macro-test",
+	.test_cases = mock_macro_test_cases,
+};
+kunit_test_suite(mock_macro_test_suite);
-- 
2.28.0.681.g6f77f65b4e-goog

