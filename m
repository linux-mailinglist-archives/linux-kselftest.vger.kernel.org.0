Return-Path: <linux-kselftest+bounces-38839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E917DB2452D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B901817ACF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE92F1FE2;
	Wed, 13 Aug 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5/0VhXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119032F0C7F
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076693; cv=none; b=DXBT4iwSpD9byjTsZwfxIG+xWdzYU7AmdaLj5FzyxlF1i0vdhuGHsutEzF0EEF5RJS22oaN3w/W3yvRar3mZ/N8/YysuwZwAFMPpf6+HgsBmku/wwrel7zdoPSe3C3ENx4dBzoAlV5G6C59p27hFsP2gDMEuNDF6OHOua++AK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076693; c=relaxed/simple;
	bh=6i36KmyjCdyVFKpP3Cflz4cFSkNi13bRmJiwTIvH7yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1h1lpS/BhwSvncHp5T6WsKIPXSTTu9cEROzsSwE1ADMQ6fDcvysTOn8jl2Ey9DI54G+q30pDRyDQh2r3nOAlZzJkSgOjCcWVGOb4dyMNwGEGU7pYqx2l5SueHdDqbPBYf8R2XfnxtpnRm/eE8Yhuz0jypgmkXu3IKmS5Y6HiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5/0VhXr; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70740598a9dso57495936d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755076690; x=1755681490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZEzq5m75AIOSkVbVy08sA4k4xV+8JCoOXCqVenAzuM=;
        b=l5/0VhXrUwZ/PejmPNe11n2l6+pRGEq4T1jdCsL9VY3uuMEI/a8lVmEi72bjVfYrXb
         bN20haNvRin0Y+TMPMQh2qMjb4xeEDqC/RbC9oCa6ZDbv65mjcK8iM4jQODZGmzkI0sY
         wFfQALKeAhVRTPeRp35ySfv+cMxcKwVksEC7zFX/QW/sGEGs4mYRyPzclSYMtwgLqMYm
         KQKFCyxq9QlFAeNwiUkFXAjqmyy4FmxnMAtNe5xjhCZl1qqeSBmWMEqq8JP1YiRHusIL
         5Q3jfjYCKVdCLGxdDBUcsak1x8hwZB1Kwxf45gja8XkaswmN8eex9a8hCNeFd/xNU4W3
         N4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755076690; x=1755681490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZEzq5m75AIOSkVbVy08sA4k4xV+8JCoOXCqVenAzuM=;
        b=IAjAYwWhuyjTlpBR/VbQkHIxV3j2fBlgFHTRhzPRgLv6dP4QIJZqwQbA7w+UwD0lli
         U76bYPrASg7gxjO6mJ6YIgVjKr8DMDVZbYRJFiq79RK2rCBjWO6IjILuDr6YbEkaCadg
         KwThlMLfPdNWsrDw5dr/+yUdWW5jO92znRKzJCG2CUwNm6sQwnd7ePsUlP+3WBAotdBg
         sO5P1pZos6FV+ccnTnLY3bL9cWsSSfIYg2hX/8q8yOosWVYMcZ+ipOOexQfTHcx9Zxvh
         sNdABZDPx19mDCqqJhxtUrEUR3d5ULMvt6T2hRlSKDGfLWd4NvLj3PpMgYnssDPxinRR
         4mzg==
X-Forwarded-Encrypted: i=1; AJvYcCV8QX7Zc9wZqUUfu/nl1PGHczHCmO4PTRyzw6Vy1r+I0B9lBRrBzV5ssyb6hpgn53/yZOIrVqS+l+62Nvtew7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3R1c9mXuobShhGGcb39MKRFtLTfyk/b+dOvnWXpbEO9ezVoc
	wTVu5UughX3mwql5KgUKFVy3ou6Rhf9KHja7hGuOA2UMIjpEJE8cMlHBnaoEOGGXC7200fUYVm/
	3VxOVnkcvjUM2U/M7/i6piNRznK9gZrLiCps3Mcrb
X-Gm-Gg: ASbGncsBUivz/sIyJornJDIAHGGo4ksrGV52eNr59+BvUdVOEahFjpFp/qthqxZpaLX
	+Aiozb6wsqimTDXBflxklO9Jnv0O31nFI7rcRpPYxxCJrQnIVeVunTdEb/et6zQ5ljBwGzgZ8OO
	aNxlMRB+gzDJQetTjg3KHMHsD8Zz1ySZiwAiDaMmPx5EVpCSIwCFcyJSQm0AlKfSpzuKmcK9IHL
	X0s81ey
X-Google-Smtp-Source: AGHT+IGoIANZsSZJ4KdWFM6zrai9BGFQ630WW54+dMsbhy2MQR6jrbauHpwaiSoWEp5WQnwJMmcOIkyp58dUDJTiqtA=
X-Received: by 2002:a05:6214:4d04:b0:709:ee6f:4988 with SMTP id
 6a1803df08f44-709ee6f4a1dmr11251396d6.1.1755076689562; Wed, 13 Aug 2025
 02:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-5-marievic@google.com>
In-Reply-To: <20250811221739.2694336-5-marievic@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 13 Aug 2025 17:17:56 +0800
X-Gm-Features: Ac12FXyaZBPXd1qWSSbQjfntOQ8fFwW2qaUKygT1ieSUwA4IVOaf_-MIVSOltEQ
Message-ID: <CABVgOS=X25Y9Q9cYU3K6-5YyzvjC1bWWLzXDgYwjOPgrX4+PTQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] kunit: Enable direct registration of parameter
 arrays to a KUnit test
To: Marie Zhussupova <marievic@google.com>
Cc: rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000af279d063c3ba25c"

--000000000000af279d063c3ba25c
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 06:18, 'Marie Zhussupova' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> KUnit parameterized tests currently support two
> primary methods for getting parameters:
> 1.  Defining custom logic within a generate_params()
>     function.
> 2.  Using the KUNIT_ARRAY_PARAM() and KUNIT_ARRAY_PARAM_DESC()
>     macros with a pre-defined static array and passing
>     the created *_gen_params() to KUNIT_CASE_PARAM().
>
> These methods present limitations when dealing with
> dynamically generated parameter arrays, or in scenarios
> where populating parameters sequentially via
> generate_params() is inefficient or overly complex.
>
> This patch addresses these limitations by adding a new
> `params_array` field to `struct kunit`, of the type
> `kunit_params`. The `struct kunit_params` is designed to
> store the parameter array itself, along with essential metadata
> including the parameter count, parameter size, and a
> get_description() function for providing custom descriptions
> for individual parameters.
>
> The `params_array` field can be populated by calling the new
> kunit_register_params_array() macro from within a
> param_init() function. This will register the array as part of the
> parameterized test context. The user will then need to pass
> kunit_array_gen_params() to the KUNIT_CASE_PARAM_WITH_INIT()
> macro as the generator function, if not providing their own.
> kunit_array_gen_params() is a KUnit helper that will use
> the registered array to generate parameters.
>
> The arrays passed to KUNIT_ARRAY_PARAM(,DESC) will also
> be registered to the parameterized test context for consistency
> as well as for higher availability of the parameter count that
> will be used for outputting a KTAP test plan for
> a parameterized test.
>
> This modification provides greater flexibility to the
> KUnit framework, allowing testers to easily register and
> utilize both dynamic and static parameter arrays.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---

Big fan of the changes here, especially the support for KTAP test
plans and the use of struct kunit_params for the static array
versions.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>
> Changes in v2:
>
> - If the parameter count is available for a parameterized
>   test, the kunit_run_tests() function will now output
>   the KTAP test plan for it.
> - The name of the struct kunit_params field in struct
>   kunit was changed from params_data to params_array.
>   This name change better reflects its purpose, which
>   is to encapsulate both the parameter array and its
>   associated metadata.
> - The name of `kunit_get_next_param_and_desc` was changed
>   to `kunit_array_gen_params` to make it simpler and to
>   better fit its purpose of being KUnit's built-in generator
>   function that uses arrays to generate parameters.
> - The signature of get_description() in `struct params_array`
>   was changed to accept the parameterized test context,
>   as well. This way test users can potentially use information
>   available in the parameterized test context, such as
>   the parameterized test name for setting the parameter
>   descriptions.
> - The type of `num_params` in `struct params_array` was
>   changed from int to size_t for better handling of the
>   array size.
> - The name of __kunit_init_params() was changed to be
>   kunit_init_params(). Logic that sets the get_description()
>   function pointer to NULL was also added in there.
> - `kunit_array_gen_params` is now exported to make
>   it available to use with modules.
> - Instead of allowing NULL to be passed in as the
>   parameter generator function in the KUNIT_CASE_PARAM_WITH_INIT
>   macro, users will now be asked to provide
>   `kunit_array_gen_params` as the generator function.
>   This will ensure that a parameterized test remains
>   defined by the existence of a parameter generation
>   function.
> - KUNIT_ARRAY_PARAM(,DESC) will now additionally
>   register the passed in array in struct kunit_params.
>   This will make things more consistent i.e. if a
>   parameter array is available then the struct kunit_params
>   field in parent struct kunit is populated. Additionally,
>   this will increase the availability of the KTAP test plan.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.
>
> ---
>  include/kunit/test.h | 65 ++++++++++++++++++++++++++++++++++++++++----
>  lib/kunit/test.c     | 30 ++++++++++++++++++++
>  2 files changed, 89 insertions(+), 6 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b527189d2d1c..8cc9614a88d5 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -234,9 +234,13 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   * Provides the option to register param_init() and param_exit() functions.
>   * param_init/exit will be passed the parameterized test context and run once
>   * before and once after the parameterized test. The init function can be used
> - * to add resources to share between parameter runs, and any other setup logic.
> - * The exit function can be used to clean up resources that were not managed by
> - * the parameterized test, and any other teardown logic.
> + * to add resources to share between parameter runs, pass parameter arrays,
> + * and any other setup logic. The exit function can be used to clean up resources
> + * that were not managed by the parameterized test, and any other teardown logic.
> + *
> + * Note: If you are registering a parameter array in param_init() with
> + * kunit_register_param_array() then you need to pass kunit_array_gen_params()
> + * to this as the generator function.
>   */
>  #define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit)          \
>                 { .run_case = test_name, .name = #test_name,                    \
> @@ -289,6 +293,20 @@ struct kunit_suite_set {
>         struct kunit_suite * const *end;
>  };
>
> +/* Stores the pointer to the parameter array and its metadata. */
> +struct kunit_params {
> +       /*
> +        * Reference to the parameter array for a parameterized test. This
> +        * is NULL if a parameter array wasn't directly passed to the
> +        * parameterized test context struct kunit via kunit_register_params_array().
> +        */
> +       const void *params;
> +       /* Reference to a function that gets the description of a parameter. */
> +       void (*get_description)(struct kunit *test, const void *param, char *desc);
> +       size_t num_params;
> +       size_t elem_size;
> +};
> +
>  /**
>   * struct kunit - represents a running instance of a test.
>   *
> @@ -296,16 +314,18 @@ struct kunit_suite_set {
>   *       created in the init function (see &struct kunit_suite).
>   * @parent: reference to the parent context of type struct kunit that can
>   *         be used for storing shared resources.
> + * @params_array: for storing the parameter array.
>   *
>   * Used to store information about the current context under which the test
>   * is running. Most of this data is private and should only be accessed
> - * indirectly via public functions; the two exceptions are @priv and @parent
> - * which can be used by the test writer to store arbitrary data and access the
> - * parent context, respectively.
> + * indirectly via public functions; the exceptions are @priv, @parent and
> + * @params_array which can be used by the test writer to store arbitrary data,
> + * access the parent context, and to store the parameter array, respectively.
>   */
>  struct kunit {
>         void *priv;
>         struct kunit *parent;
> +       struct kunit_params params_array;
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> @@ -376,6 +396,8 @@ void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
>  struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_set,
>                 struct kunit_suite_set suite_set);
>
> +const void *kunit_array_gen_params(struct kunit *test, const void *prev, char *desc);
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  int kunit_run_all_tests(void);
>  #else
> @@ -1696,6 +1718,8 @@ do {                                                                             \
>                                              const void *prev, char *desc)                      \
>         {                                                                                       \
>                 typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
> +               if (!prev)                                                                      \
> +                       kunit_register_params_array(test, array, ARRAY_SIZE(array), NULL);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {                                   \
>                         void (*__get_desc)(typeof(__next), char *) = get_desc;                  \
>                         if (__get_desc)                                                         \
> @@ -1718,6 +1742,8 @@ do {                                                                             \
>                                              const void *prev, char *desc)                      \
>         {                                                                                       \
>                 typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
> +               if (!prev)                                                                      \
> +                       kunit_register_params_array(test, array, ARRAY_SIZE(array), NULL);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {                                   \
>                         strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);              \
>                         return __next;                                                          \
> @@ -1725,6 +1751,33 @@ do {                                                                            \
>                 return NULL;                                                                    \
>         }
>
> +/**
> + * kunit_register_params_array() - Register parameter array for a KUnit test.
> + * @test: The KUnit test structure to which parameters will be added.
> + * @array: An array of test parameters.
> + * @param_count: Number of parameters.
> + * @get_desc: Function that generates a string description for a given parameter
> + * element.
> + *
> + * This macro initializes the @test's parameter array data, storing information
> + * including the parameter array, its count, the element size, and the parameter
> + * description function within `test->params_array`.
> + *
> + * Note: If using this macro in param_init(), kunit_array_gen_params()
> + * will then need to be manually provided as the parameter generator function to
> + * KUNIT_CASE_PARAM_WITH_INIT(). kunit_array_gen_params() is a KUnit
> + * function that uses the registered array to generate parameters
> + */
> +#define kunit_register_params_array(test, array, param_count, get_desc)                                \
> +       do {                                                                                    \
> +               struct kunit *_test = (test);                                                   \
> +               const typeof((array)[0]) * _params_ptr = &(array)[0];                           \
> +               _test->params_array.params = _params_ptr;                                       \
> +               _test->params_array.num_params = (param_count);                                 \
> +               _test->params_array.elem_size = sizeof(*_params_ptr);                           \
> +               _test->params_array.get_description = (get_desc);                               \
> +       } while (0)
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 01b20702a5a2..cbde238ff334 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -337,6 +337,14 @@ void __kunit_do_failed_assertion(struct kunit *test,
>  }
>  EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
>
> +static void kunit_init_params(struct kunit *test)
> +{
> +       test->params_array.params = NULL;
> +       test->params_array.get_description = NULL;
> +       test->params_array.num_params = 0;
> +       test->params_array.elem_size = 0;
> +}
> +
>  void kunit_init_test(struct kunit *test, const char *name, struct string_stream *log)
>  {
>         spin_lock_init(&test->lock);
> @@ -347,6 +355,7 @@ void kunit_init_test(struct kunit *test, const char *name, struct string_stream
>                 string_stream_clear(log);
>         test->status = KUNIT_SUCCESS;
>         test->status_comment[0] = '\0';
> +       kunit_init_params(test);
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> @@ -641,6 +650,23 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
>         total->total += add.total;
>  }
>
> +const void *kunit_array_gen_params(struct kunit *test, const void *prev, char *desc)
> +{
> +       struct kunit_params *params_arr = &test->params_array;
> +       const void *param;
> +
> +       if (test->param_index < params_arr->num_params) {
> +               param = (char *)params_arr->params
> +                       + test->param_index * params_arr->elem_size;
> +
> +               if (params_arr->get_description)
> +                       params_arr->get_description(test, param, desc);
> +               return param;
> +       }
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(kunit_array_gen_params);
> +
>  static void kunit_init_parent_param_test(struct kunit_case *test_case, struct kunit *test)
>  {
>         if (test_case->param_init) {
> @@ -701,6 +727,10 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                   "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
>                                   "# Subtest: %s", test_case->name);
> +                       if (test.params_array.params)
> +                               kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT
> +                                         KUNIT_SUBTEST_INDENT "1..%zd\n",
> +                                         test.params_array.num_params);
>
>                         while (curr_param) {
>                                 struct kunit param_test = {
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250811221739.2694336-5-marievic%40google.com.

--000000000000af279d063c3ba25c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgNOA0pgA4JVyLlGrT6avX3/AJ4U1y
3w9Vk1IpXWx15ZQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODEzMDkxODEwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAm7LopTIa72R82vZuWDP63r6oeIqPY0rCTYPik1xYIeARkRge1/v8MolHbiTy356T
bPiirGRUfneZEVX/5aonHLLA/1L7xWFTDpo72TdYKEUa15MnTowHCPp45MM/YsXbJaGY3JGywy5V
izlShCt0QlE6/FFeOUBJhpxoh7Cd7YcaT0cNItA9WZMq+5UHUIXaKkN161lWbxslZGkgZ6n4YATm
QwfqJWW5RyTTDBXDn0SCO91ezWe1XSzo8330SVBTUioJrfNitqgjeyG/sJnVwMGa+5rLHzEa7RCe
BQTMP11ZSRmHI1yDDGJpBZeRtCBKUtg/wRxwWTaIYRAYa3fDOA==
--000000000000af279d063c3ba25c--

