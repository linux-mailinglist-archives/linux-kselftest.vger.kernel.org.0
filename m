Return-Path: <linux-kselftest+bounces-38533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C0B1E027
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 03:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE9D3BD274
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4954758;
	Fri,  8 Aug 2025 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2stP4a0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487048BEC
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754616186; cv=none; b=todBWOvtT3am73euKM0QZPWRDXeS/DND6Oxv5FECypoxvmA5Z2OHvZtmqMjzzIh/HWyhifGQHLHJXtdzbKtbx3wJd9gvDXpkp57OUeyZsZtB0CkK+zRF6HzBXnl6dtial/gCNAS8dLIPuGbAmu48oNXAIlMbH2z4GQtF/Eqqo1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754616186; c=relaxed/simple;
	bh=Uryd1J4b5v1UKVVA0DJq1CimX1JjdKWcP8BUkEbztV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEmlWFWGhqFeD3mHF2+N0DJONAtpGLiASAEiJIlRhP7ggPH7VvZ0lY7BlQwb3i6yrasQoyBUotoyrhmx4M47xbPi587JN7tphPBHX0nbhNhsBDH9otF9dCAshknI8X1xzuvsSy54hntH2WWbuahQGLG+LnszDFsijPmEduNYzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2stP4a0M; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61543b05b7cso5852a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754616183; x=1755220983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D00aj35qn0lgLEWR00CYBcQuTXDPk0GIrAj2AelFpM=;
        b=2stP4a0M6S2bcwx9x6kNdp5X4Z5XSlZb4qy3V7uIMxfAnps9MfRfa5SwnuSUdHT5JK
         KX062+W0H0kO7Vz+Ox4Y63q3pnXRrs0qm43vd5IWyL9v4y2Opr1U6dXRbTJ87Q4fTSbp
         3V6hqZWsURODwZrF/ZiK7/OxW2OmfoGpNyRu4Jye0KUmPO18qRHIgSM3BT9JvGcMxg7Y
         bUa5CCxJY36i/0071NHMwEHVzsjumWthj+vQ3ZX8qO3Bu/sr1qGZ/gXrp2mfIPwh8Eu2
         d0p4qeim85SZpkTTOJaaPbgkKVlNH/gzBWGuy57PgEcBu5H/na6vreM2tbnT1uq5ntuc
         S4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754616183; x=1755220983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2D00aj35qn0lgLEWR00CYBcQuTXDPk0GIrAj2AelFpM=;
        b=EKmR6aWkO9zkawISTy6BHcQaVclMxsrnSnwRjnrt5EySf0yls4eXDGdkq2rcK1qrb9
         UZCdyynuXCsjTlF+/uXEfB1HCC8SRHgodqNkgTpCL4We4xikXUrVDjG8NkbohsB7FjkM
         KSEtB5XFCquj4VMZ/Mnm7xghGJ9cLHmP57iNtBOh2aWQnvYSR+IPwekxG3QjWfMUU6+Q
         sOb2qN5vSLBVT7rlCEXvQFvPnrXFPiydcqA92HR48b0I7e++lAOB5K2/nk+V7ooEJ8q4
         oywHWj74CpPfILleXJRm3GSxugu72G19eWGoeNSPakT2+hdBHHqkTxs1FmmPv/DRpCOj
         TKoA==
X-Forwarded-Encrypted: i=1; AJvYcCXN/4GqNVn+4g7KoF13gLP8ryLauELO4fcdkqihWA13QLGVIWC1BFPi6arYp0bbrNVVWyeMbCNbpxjeMhz01J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU34HGaojslXqGWiJ68iswRcCj8gKcXRSkAftoUpti982f4VMQ
	ZhWT6NOOnCYRhT7i+X49qGgF7/mOM6X1TtbWXTzD7AYiHNpHq3zN/7KBy7YuVIQ8jdCXpI3Vu9w
	TOJZ+yRUBi5AKdaqNE6ozVvj2zxVzH5fRX6XVbppB
X-Gm-Gg: ASbGnctgXh29q5AHSBA8qOvmbpi+ZbzpcB4KtP41UnEfPjamrdAVVA0Gz/mPjSI2ckJ
	Jzxru0Fi1NAn64oCQpCWYa2F1O0qYAdOrWXhI7qVIRzP6bdg6DUfetiDL7wPFAbK2xC4NyxwC7i
	wC0SkqVAUZXB8WrMTU0Q2XaRa50Qe6vpJnYk0pcxEZ/EeonSQBpaQOG9SwPnxWCtjl70LG53N86
	VnyDQFv
X-Google-Smtp-Source: AGHT+IGaR/h/J9/1J1DqeC39jxSWn0nyV0BCQ8iE+VjGFJZUiVPSq0jiBZsdGYmezeXImgpn13C2HiTTQedvJM4YdKE=
X-Received: by 2002:a50:8ac9:0:b0:615:6167:4835 with SMTP id
 4fb4d7f45d1cf-617e4938cc5mr22550a12.7.1754616182348; Thu, 07 Aug 2025
 18:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-7-marievic@google.com>
 <CA+GJov7AH5Qyiaua7LKZjVNRoUd==DiSXvd1UP7TcSzvn5JZtQ@mail.gmail.com>
In-Reply-To: <CA+GJov7AH5Qyiaua7LKZjVNRoUd==DiSXvd1UP7TcSzvn5JZtQ@mail.gmail.com>
From: Marie Zhussupova <marievic@google.com>
Date: Thu, 7 Aug 2025 21:22:50 -0400
X-Gm-Features: Ac12FXy83TfjpYK_0eq_uQ1ZcPI2DWSWUtOe3NX9vC6swmGOuFsU9to_-ct3_vs
Message-ID: <CAAkQn5LUA-gRj9nypcf0jE+gjRwN2axkJ4KO14Aj8AB3dhZHsw@mail.gmail.com>
Subject: Re: [PATCH 6/9] kunit: Enable direct registration of parameter arrays
 to a KUnit test
To: Rae Moar <rmoar@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 11:18=E2=80=AFAM Rae Moar <rmoar@google.com> wrote:
>
> On Tue, Jul 29, 2025 at 3:37=E2=80=AFPM Marie Zhussupova <marievic@google=
.com> wrote:
> >
> > KUnit parameterized tests currently support two
> > primary methods for getting parameters:
> > 1.  Defining custom logic within a `generate_params`
> >     function.
> > 2.  Using the KUNIT_ARRAY_PARAM and KUNIT_ARRAY_PARAM_DESC
> >     macros with pre-defined static arrays.
> >
> > These methods present limitations when dealing with
> > dynamically generated parameter arrays, or in scenarios
> > where populating parameters sequentially via
> > `generate_params` is inefficient or overly complex.
> >
> > This patch addresses these limitations by adding a new
> > `params_data` field to `struct kunit`, of the type
> > `kunit_params`. The struct `kunit_params` is designed to
> > store the parameter array itself, along with essential metadata
> > including the parameter count, parameter size, and a
> > `get_description` function for providing custom descriptions
> > for individual parameters.
> >
> > The `params_data` field can be populated by calling the new
> > `kunit_register_params_array` macro from within a
> > `param_init` function. By attaching the parameter array
> > directly to the parent kunit test instance, these parameters
> > can be iterated over in kunit_run_tests() behind the scenes.
> >
> > This modification provides greater flexibility to the
> > KUnit framework, allowing testers to easily register and
> > utilize both dynamic and static parameter arrays.
> >
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
>
> Hello!
>
> Very excited by the prospect of setting up an array dynamically
> instead of statically for parameterized tests. In general, I am happy
> to see this framework is becoming more flexible and therefore more
> tailored to our test author's needs.
>
> I already commented on the modpost error but I have a few more
> comments and ideas below. Let me know what you think.
>
> Thanks!
> -Rae
>

Hello Rae,

I have added replies to your comments below.

Thank you,
-Marie

> > ---
> >  include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++----
> >  lib/kunit/test.c     | 26 ++++++++++++++++++++-
> >  2 files changed, 75 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 4ba65dc35710..9143f0e22323 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -245,7 +245,8 @@ static inline char *kunit_status_to_ok_not_ok(enum =
kunit_status status)
> >   */
> >  #define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit) =
         \
> >                 { .run_case =3D test_name, .name =3D #test_name,       =
             \
> > -                 .generate_params =3D gen_params,                     =
           \
> > +                 .generate_params =3D (gen_params)                    =
           \
> > +                  ?: kunit_get_next_param_and_desc,                   =
         \
> >                   .param_init =3D init, .param_exit =3D exit,          =
             \
> >                   .module_name =3D KBUILD_MODNAME}
> >
> > @@ -294,6 +295,21 @@ struct kunit_suite_set {
> >         struct kunit_suite * const *end;
> >  };
> >
> > +/* Stores the pointer to the parameter array and its metadata. */
> > +struct kunit_params {
> > +       /*
> > +        * Reference to the parameter array for the parameterized tests=
. This
> > +        * is NULL if a parameter array wasn't directly passed to the
> > +        * parent kunit struct via the kunit_register_params_array macr=
o.
> > +        */
> > +       const void *params;
> > +       /* Reference to a function that gets the description of a param=
eter. */
> > +       void (*get_description)(const void *param, char *desc);
> > +
> > +       int num_params;
>
> Since in some cases we know the number of params within a series/suite
> of the parameterized tests, is it possible for us to print a test plan
> line in KTAP when this number is known? This would be helpful for
> reading test results but also the parser could verify the number of
> subtests is the number expected.

This sounds like a great idea. My initial worry was that the availability
of the test plan would be inconsistent since there would be no parameter
count information when the parameters are generated using a custom
generate_params function unless a test user provides them.
However, it is good to provide any information that we have.

>
> > +       size_t elem_size;
> > +};
> > +
> >  /**
> >   * struct kunit - represents a running instance of a test.
> >   *
> > @@ -302,12 +318,14 @@ struct kunit_suite_set {
> >   * @parent: for user to store data that they want to shared across
> >   *         parameterized tests. Typically, the data is provided in
> >   *         the param_init function (see &struct kunit_case).
> > + * @params_data: for users to directly store the parameter array.
> >   *
> >   * Used to store information about the current context under which the=
 test
> >   * is running. Most of this data is private and should only be accesse=
d
> > - * indirectly via public functions; the two exceptions are @priv and @=
parent
> > - * which can be used by the test writer to store arbitrary data or dat=
a that is
> > - * available to all parameter test executions, respectively.
> > + * indirectly via public functions. There are three exceptions to this=
: @priv,
> > + * @parent, and @params_data. These members can be used by the test wr=
iter to
> > + * store arbitrary data, data available to all parameter test executio=
ns, and
> > + * the parameter array, respectively.
> >   */
> >  struct kunit {
> >         void *priv;
> > @@ -316,6 +334,8 @@ struct kunit {
> >          * during parameterized testing.
> >          */
> >         struct kunit *parent;
> > +       /* Stores the params array and all data related to it. */
> > +       struct kunit_params params_data;
>
> I might slightly prefer the term params_array rather than params_data.
> Up to what you prefer.

I like params_array because it's a naming convention similar
to what object-oriented programming (OOP) languages like
Java use. For instance, an ArrayList object encapsulates
both an array and its size. I will make this change in v2.

>
> >
> >         /* private: internal use only. */
> >         const char *name; /* Read only after initialization! */
> > @@ -386,6 +406,8 @@ void kunit_exec_list_tests(struct kunit_suite_set *=
suite_set, bool include_attr)
> >  struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set i=
nit_suite_set,
> >                 struct kunit_suite_set suite_set);
> >
> > +const void *kunit_get_next_param_and_desc(struct kunit *test, const vo=
id *prev, char *desc);
> > +
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >  int kunit_run_all_tests(void);
> >  #else
> > @@ -1735,6 +1757,30 @@ do {                                            =
                                \
> >                 return NULL;                                           =
                         \
> >         }
> >
> > +/**
> > + * kunit_register_params_array() - Register parameters for a KUnit tes=
t.
> > + * @test: The KUnit test structure to which parameters will be added.
> > + * @params_arr: An array of test parameters.
> > + * @param_cnt: Number of parameters.
> > + * @get_desc: A pointer to a function that generates a string descript=
ion for
> > + * a given parameter element.
> > + *
> > + * This macro initializes the @test's parameter array data, storing in=
formation
> > + * including the parameter array, its count, the element size, and the=
 parameter
> > + * description function within `test->params_data`. KUnit's built-in
> > + * `kunit_get_next_param_and_desc` function will automatically read th=
is
> > + * data when a custom `generate_params` function isn't provided.
> > + */
> > +#define kunit_register_params_array(test, params_arr, param_cnt, get_d=
esc)                     \
>
> I also might slightly prefer params_array and param_count here instead
> of params_arr and param_cnt. Again this is definitely a nitpick so up
> to you.

I will do params_arr and param_cnt in v2, it definitely looks better.

>
> > +       do {                                                           =
                         \
> > +               struct kunit *_test =3D (test);                        =
                   \
> > +               const typeof((params_arr)[0]) * _params_ptr =3D &(param=
s_arr)[0];                 \
> > +               _test->params_data.params =3D _params_ptr;             =
                           \
> > +               _test->params_data.num_params =3D (param_cnt);         =
                           \
> > +               _test->params_data.elem_size =3D sizeof(*_params_ptr); =
                           \
> > +               _test->params_data.get_description =3D (get_desc);     =
                           \
> > +       } while (0)
> > +
> >  // TODO(dlatypov@google.com): consider eventually migrating users to e=
xplicitly
> >  // include resource.h themselves if they need it.
> >  #include <kunit/resource.h>
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index f50ef82179c4..2f4b7087db3f 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -337,6 +337,13 @@ void __kunit_do_failed_assertion(struct kunit *tes=
t,
> >  }
> >  EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
> >
> > +static void __kunit_init_params(struct kunit *test)
> > +{
> > +       test->params_data.params =3D NULL;
> > +       test->params_data.num_params =3D 0;
> > +       test->params_data.elem_size =3D 0;
> > +}
> > +
> >  void kunit_init_test(struct kunit *test, const char *name, struct stri=
ng_stream *log)
> >  {
> >         spin_lock_init(&test->lock);
> > @@ -347,6 +354,7 @@ void kunit_init_test(struct kunit *test, const char=
 *name, struct string_stream
> >                 string_stream_clear(log);
> >         test->status =3D KUNIT_SUCCESS;
> >         test->status_comment[0] =3D '\0';
> > +       __kunit_init_params(test);
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_init_test);
> >
> > @@ -641,6 +649,22 @@ static void kunit_accumulate_stats(struct kunit_re=
sult_stats *total,
> >         total->total +=3D add.total;
> >  }
> >
> > +const void *kunit_get_next_param_and_desc(struct kunit *test, const vo=
id *prev, char *desc)
> > +{
> > +       struct kunit_params *params_arr =3D &test->params_data;
> > +       const void *param;
> > +
> > +       if (test->param_index < params_arr->num_params) {
> > +               param =3D (char *)params_arr->params
> > +                       + test->param_index * params_arr->elem_size;
> > +
> > +               if (params_arr->get_description)
> > +                       params_arr->get_description(param, desc);
> > +               return param;
> > +       }
> > +       return NULL;
> > +}
>
> I also agree with David that it should definitely be considered: 1 -
> whether to utilize struct kunit_params for the case of using
> KUNIT_ARRAY_PARAM and 2 - whether the user should actively input this
> function instead of setting generate_params to NULL.
>
> Another idea that just popped into my head is if we have access to
> struct kunit* test now in all of the generate_params functions,
> instead of setting a "desc" could we just set the test->name field?
>

Utilizing struct kunit_params in KUNIT_ARRAY_PARAM is a great idea
as that would mean greater test plan availability as well as the consistenc=
y
of storing parameter array information in struct kunit_params.

To the second point, I think the user being asked to explicitly input
kunit_get_next_param_and_desc if they are registering a parameter
array in param_init is a good solution. It would make the code easier
as there would be no extra logic happening behind the scenes.
Moreover, we would always know that if it's a parameterized
test then the generate_params function is not NULL. The only thing
is that we would have to document it really well.

Another potential solution could be to assign the
kunit_get_next_param_and_desc function to generate_params
in the  __kunit_init_parent_test function that runs param_init, if we
keep its run before we determine that a test
is parameterized (I know you commented on this here:
https://lore.kernel.org/all/CA+GJov5R2GnBfxXR=3D28vS3F4b1E-=3DWLDXpgdJo0SpK=
AXb1dpsw@mail.gmail.com/).

__kunit_init_parent_test could set generate_params to
kunit_get_next_param_and_desc if generate_params is NULL
and kunit_params is non NULL, after the param_init call.
What are your thoughts?

Finally, utilizing test->name could be something to do in a future patch.
First, we wouldn't need to pass char *desc as an argument to
generate_params and second, the variable naming would be better
as we are using the test name for KTAP output for regular tests.
The downside would be having to change existing implementations
that use char *desc and to explicitly specify to use test->name to users.

> > +
> >  static void __kunit_init_parent_test(struct kunit_case *test_case, str=
uct kunit *test)
> >  {
> >         if (test_case->param_init) {
> > @@ -687,7 +711,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                         /* Test marked as skip */
> >                         test.status =3D KUNIT_SKIPPED;
> >                         kunit_update_stats(&param_stats, test.status);
> > -               } else if (!test_case->generate_params) {
> > +               } else if (!test_case->generate_params && !test.params_=
data.params) {
>
> I agree with David that it is helpful to have one check for whether a
> test is a parameterized test rather than two. My instinct is that if
> test_case->generate_params is NULL it should be safe to assume the
> test isn't a parameterized test.

Agreed.

>
> However, as an alternative or even as a helpful addition, I like the
> idea of a simple kunit_test_is_param function that can pass in the
> test and it will return a bool whether the test is parameterized or
> not.
>
That could be a good idea. At the same time, if it remains true
that generate_params being NULL implies that it's not a
parameterized test, I think a simple check would be enough.

>
>
>
> >                         /* Non-parameterised test. */
> >                         test_case->status =3D KUNIT_SKIPPED;
> >                         kunit_run_case_catch_errors(suite, test_case, &=
test);
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

