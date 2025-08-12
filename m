Return-Path: <linux-kselftest+bounces-38808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94228B23BE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 00:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB16E281D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF92D7387;
	Tue, 12 Aug 2025 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0W+JUtH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3342D541E
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037398; cv=none; b=FRGI74iyFx9yQmLblY9X7YbuXcBxyN4TwBM08n/O+5RsanDAIyv8fZzPF62DkuqnklaZp7pzuvzwpHUXRgOBXV/6ghYIAA3XKDd/rvlHbmylSoIajS6ADmSefsKVJlPxrftXxCojxmrr59EYESlIQPUwV8GcbV+F7ICX71g8w+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037398; c=relaxed/simple;
	bh=E8nmSlXvjf1u4+0E+nINqeMzAfLQ4pfh/B1w+od194Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUJxlMIBX7g5ugNTK3fxpGWCc0M+6ya2xgQq57mgfIM84NDoqJxJsqiQy68yGuvF3HKmB5+OYJWn9QhBXQNEfONzECaRuh1he4BovqjHpQzR/FqmPG2D4U1ZUmyH4VZxxlruns+AuoGUNB7c1JbyYE332tjuchav+HxcLVaf8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0W+JUtH; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70749eac23dso52176816d6.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755037395; x=1755642195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCjfCIARl7FEQlaEVHD1Q7u5jqwvzYtlI2DxlC6TvyE=;
        b=V0W+JUtHM5kGkvkWqV3jXyc/yHM5YFJ25oYZGZLVN6rjEvGUHcjRHY53cTT6QTDvZ3
         5/vE+5qXldxvNtIdsc5j9LbP/M6c5bDswKD/LcI21leKzFEVn7sQDSvofLixvyNDD1it
         vysnc/fuk2rBIjo53e4mE+lL4ONBkKRhkDSzxV6Hhoe2cFs3+lbGYknNwIkyhwQejdr+
         dC8rVSTSc/wreOns8Na21hS00wofvWmwtiyzpT1Hxp8xU6ScK8okFUII5g0UqCy2KM+8
         qMAPSt2bWzk9CinlLCz3UWoHyxoC3RBIQilh/h72HiUHEZ9Cxk1v4ZRRgJyKHoZIqXD7
         z1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037395; x=1755642195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCjfCIARl7FEQlaEVHD1Q7u5jqwvzYtlI2DxlC6TvyE=;
        b=ALMdofkpB0mR63y0pknMKs1bEps3MNRNkfeLvolmCxcADagfdjyhLzc5n6t/uEV3X+
         S53AAwL87etvEBoIDszSvUmIJCrL0wu2H5R2+2+fCsrB3z9e5TsNWhz9n6BDkppKgXOW
         iaeXDR2wwwI2KK2I6nSC8gX04O4vEjLSSnRoo77JXvl2mjCPs5gfhMMcXpOsHtrEc9w7
         aFAZ1YldCrtgWeMxdnQhqILUPjDRJOYrqUDlupErDw4pWbUI/gx5Ke3V6dJBYGeXc6gk
         GwH9exozKmpir1lNZ4ufGeYzNyn9RmpunH/AIZ5qj5jI/hiIXS/XBmOzBbx8vnq/AAXP
         7Kyg==
X-Forwarded-Encrypted: i=1; AJvYcCVuvJD7X59tUS++A32njhPBiTyKo97rWlzapYnj/NPwdRkHCqpvP/2PB1HkInw+GqtMcCL2+Jfp1JGxICq2oNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrx8I6193pAr99syAP8CNA7CY0MlxDJiJPw2sO/y72k0z4HKR
	IDkBNmoAZrjWPzTmDlppwtfc8iZrdGccaMQp/uxG12bG1n4pnbOdn9tFd/TYiQPvTTnJcIKKMoy
	NYJduMczkbjtEBS3t+hZnPQQ2LuNbWlprAmzl+C1u
X-Gm-Gg: ASbGnct2ZwihM6118EZKxiiEphVYb+AeZllMcVNTEtHDmz1q48y5EE1lciwJymbzAN5
	aZWiPy2DEo9c0ftHpYWWsQ0FoeD5UzdNGGKGSyWGIRVEQ4LTUbv9zYOoei+ZszIVEs2C09g8u4y
	TQYW2OK4Kh7VKg72TkjK0FxTNAoyTOyOYapGjlSohjjGsJK1yBxe4oyr3v4uj12zS4RMWVwf0wi
	8NkBPfjY5Fhzb60
X-Google-Smtp-Source: AGHT+IGnoy69atcXwXPPIj9GFl8UpcYTqhwTguB0w1vUUoD9USRblUpDXommEo5/9iwaQm7/irPZGPrgYrbWivTJ5QI=
X-Received: by 2002:a05:6214:b65:b0:707:2a42:b9b3 with SMTP id
 6a1803df08f44-709e87fc8eemr13324846d6.10.1755037394932; Tue, 12 Aug 2025
 15:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-5-marievic@google.com>
In-Reply-To: <20250811221739.2694336-5-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 12 Aug 2025 18:23:03 -0400
X-Gm-Features: Ac12FXz_Z-KSxKbEjvzCLajE68vHYuAwVU6cW7c0HNZTIqwbxoPdgclX4rSmmA4
Message-ID: <CA+GJov6bvx5FTKvDE9Bng1m4iDynwruDnFf5orpzc+yMc2-yzw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] kunit: Enable direct registration of parameter
 arrays to a KUnit test
To: Marie Zhussupova <marievic@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:17=E2=80=AFPM Marie Zhussupova <marievic@google.c=
om> wrote:
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

Hello!

Thanks for all your effort in updating this patch series. It is
looking really good. I think I am happy with this patch as is but I do
have a comment below.

Thanks!
-Rae

> ---
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
> @@ -234,9 +234,13 @@ static inline char *kunit_status_to_ok_not_ok(enum k=
unit_status status)
>   * Provides the option to register param_init() and param_exit() functio=
ns.
>   * param_init/exit will be passed the parameterized test context and run=
 once
>   * before and once after the parameterized test. The init function can b=
e used
> - * to add resources to share between parameter runs, and any other setup=
 logic.
> - * The exit function can be used to clean up resources that were not man=
aged by
> - * the parameterized test, and any other teardown logic.
> + * to add resources to share between parameter runs, pass parameter arra=
ys,
> + * and any other setup logic. The exit function can be used to clean up =
resources
> + * that were not managed by the parameterized test, and any other teardo=
wn logic.
> + *
> + * Note: If you are registering a parameter array in param_init() with
> + * kunit_register_param_array() then you need to pass kunit_array_gen_pa=
rams()
> + * to this as the generator function.
>   */
>  #define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit)   =
       \
>                 { .run_case =3D test_name, .name =3D #test_name,         =
           \
> @@ -289,6 +293,20 @@ struct kunit_suite_set {
>         struct kunit_suite * const *end;
>  };
>
> +/* Stores the pointer to the parameter array and its metadata. */
> +struct kunit_params {
> +       /*
> +        * Reference to the parameter array for a parameterized test. Thi=
s
> +        * is NULL if a parameter array wasn't directly passed to the
> +        * parameterized test context struct kunit via kunit_register_par=
ams_array().
> +        */
> +       const void *params;
> +       /* Reference to a function that gets the description of a paramet=
er. */
> +       void (*get_description)(struct kunit *test, const void *param, ch=
ar *desc);

I'm a little bit uncertain whether I like this change to
get_description. I don't like that the function signature for a
get_description function is different now between
kunit_register_params_array and the KUNIT_ARRAY_PARAM_DESC. I think I
would prefer it as it was before.

However, I do still like the idea of users being able to set struct
kunit test->name for each param run as the test name but that would
require some reworking because the struct kunit test that is passed
into generate_params and get_description is the parent test I believe
rather than each individual param run. So I think I might prefer it as
it was.


> +       size_t num_params;
> +       size_t elem_size;
> +};
> +
>  /**
>   * struct kunit - represents a running instance of a test.
>   *
> @@ -296,16 +314,18 @@ struct kunit_suite_set {
>   *       created in the init function (see &struct kunit_suite).
>   * @parent: reference to the parent context of type struct kunit that ca=
n
>   *         be used for storing shared resources.
> + * @params_array: for storing the parameter array.
>   *
>   * Used to store information about the current context under which the t=
est
>   * is running. Most of this data is private and should only be accessed
> - * indirectly via public functions; the two exceptions are @priv and @pa=
rent
> - * which can be used by the test writer to store arbitrary data and acce=
ss the
> - * parent context, respectively.
> + * indirectly via public functions; the exceptions are @priv, @parent an=
d
> + * @params_array which can be used by the test writer to store arbitrary=
 data,
> + * access the parent context, and to store the parameter array, respecti=
vely.
>   */
>  struct kunit {
>         void *priv;
>         struct kunit *parent;
> +       struct kunit_params params_array;
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> @@ -376,6 +396,8 @@ void kunit_exec_list_tests(struct kunit_suite_set *su=
ite_set, bool include_attr)
>  struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set ini=
t_suite_set,
>                 struct kunit_suite_set suite_set);
>
> +const void *kunit_array_gen_params(struct kunit *test, const void *prev,=
 char *desc);
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  int kunit_run_all_tests(void);
>  #else
> @@ -1696,6 +1718,8 @@ do {                                               =
                              \
>                                              const void *prev, char *desc=
)                      \
>         {                                                                =
                       \
>                 typeof((array)[0]) *__next =3D prev ? ((typeof(__next)) p=
rev) + 1 : (array);      \
> +               if (!prev)                                               =
                       \
> +                       kunit_register_params_array(test, array, ARRAY_SI=
ZE(array), NULL);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {            =
                       \
>                         void (*__get_desc)(typeof(__next), char *) =3D ge=
t_desc;                  \
>                         if (__get_desc)                                  =
                       \
> @@ -1718,6 +1742,8 @@ do {                                               =
                              \
>                                              const void *prev, char *desc=
)                      \
>         {                                                                =
                       \
>                 typeof((array)[0]) *__next =3D prev ? ((typeof(__next)) p=
rev) + 1 : (array);      \
> +               if (!prev)                                               =
                       \
> +                       kunit_register_params_array(test, array, ARRAY_SI=
ZE(array), NULL);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {            =
                       \
>                         strscpy(desc, __next->desc_member, KUNIT_PARAM_DE=
SC_SIZE);              \
>                         return __next;                                   =
                       \
> @@ -1725,6 +1751,33 @@ do {                                              =
                              \
>                 return NULL;                                             =
                       \
>         }
>
> +/**
> + * kunit_register_params_array() - Register parameter array for a KUnit =
test.
> + * @test: The KUnit test structure to which parameters will be added.
> + * @array: An array of test parameters.
> + * @param_count: Number of parameters.
> + * @get_desc: Function that generates a string description for a given p=
arameter
> + * element.
> + *
> + * This macro initializes the @test's parameter array data, storing info=
rmation
> + * including the parameter array, its count, the element size, and the p=
arameter
> + * description function within `test->params_array`.
> + *
> + * Note: If using this macro in param_init(), kunit_array_gen_params()
> + * will then need to be manually provided as the parameter generator fun=
ction to
> + * KUNIT_CASE_PARAM_WITH_INIT(). kunit_array_gen_params() is a KUnit
> + * function that uses the registered array to generate parameters
> + */
> +#define kunit_register_params_array(test, array, param_count, get_desc) =
                               \
> +       do {                                                             =
                       \
> +               struct kunit *_test =3D (test);                          =
                         \
> +               const typeof((array)[0]) * _params_ptr =3D &(array)[0];  =
                         \
> +               _test->params_array.params =3D _params_ptr;              =
                         \
> +               _test->params_array.num_params =3D (param_count);        =
                         \
> +               _test->params_array.elem_size =3D sizeof(*_params_ptr);  =
                         \
> +               _test->params_array.get_description =3D (get_desc);      =
                         \
> +       } while (0)
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to exp=
licitly
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
> +       test->params_array.params =3D NULL;
> +       test->params_array.get_description =3D NULL;
> +       test->params_array.num_params =3D 0;
> +       test->params_array.elem_size =3D 0;
> +}
> +
>  void kunit_init_test(struct kunit *test, const char *name, struct string=
_stream *log)
>  {
>         spin_lock_init(&test->lock);
> @@ -347,6 +355,7 @@ void kunit_init_test(struct kunit *test, const char *=
name, struct string_stream
>                 string_stream_clear(log);
>         test->status =3D KUNIT_SUCCESS;
>         test->status_comment[0] =3D '\0';
> +       kunit_init_params(test);
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> @@ -641,6 +650,23 @@ static void kunit_accumulate_stats(struct kunit_resu=
lt_stats *total,
>         total->total +=3D add.total;
>  }
>
> +const void *kunit_array_gen_params(struct kunit *test, const void *prev,=
 char *desc)
> +{
> +       struct kunit_params *params_arr =3D &test->params_array;
> +       const void *param;
> +
> +       if (test->param_index < params_arr->num_params) {
> +               param =3D (char *)params_arr->params
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
>  static void kunit_init_parent_param_test(struct kunit_case *test_case, s=
truct kunit *test)
>  {
>         if (test_case->param_init) {
> @@ -701,6 +727,10 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                   "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "# Subtest: %s", test_case->name);
> +                       if (test.params_array.params)
> +                               kunit_log(KERN_INFO, &test, KUNIT_SUBTEST=
_INDENT
> +                                         KUNIT_SUBTEST_INDENT "1..%zd\n"=
,
> +                                         test.params_array.num_params);
>
>                         while (curr_param) {
>                                 struct kunit param_test =3D {
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

