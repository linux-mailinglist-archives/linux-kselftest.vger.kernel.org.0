Return-Path: <linux-kselftest+bounces-38302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7A6B1B755
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD1179496
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6827A10D;
	Tue,  5 Aug 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zwbg3FmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9AC2797A4
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407160; cv=none; b=iUYK+MewX5wr3UjTToedEvO9Oau283nxGOv6/lHzl7rRr4mmVjmrY1mUtZUttuI1Zv5FnXj0Qd0QhVQO1S4TWjzp8eED/xeshRQFf3zPczz783Q7/FnIwOCJBavJD1d7gcyTtwXTiwPURYJREDTysnW2US/xfIUEPTOnhOvTgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407160; c=relaxed/simple;
	bh=7p42Aru6XElSFr/5dxzrgDkqeyIrUcUFCoX5dC3Bils=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7kuWqmVwQgIdhSTLfZBVq2OC2MKCdHB7DAdCPlI8RXSoyR/BocgrcY+SMbqdbvuMrGgM4oqnkL9RHYB8xpvxUcHWZ+Ea3bd+bspPygxSVWXakMjn6dFeHwN9fvbvsCQxpORCV5evKRk8fH26vD8FgMF8zdoEZiyShzojeoohAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zwbg3FmW; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-704c5464aecso48629986d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754407157; x=1755011957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il9Pck9IsIM62v468p0OkwRij0VejED4nE+yuVLG5G4=;
        b=Zwbg3FmWsqUewkhR+oGOqsp7YZS25EQFj04I3WpHHtkN8iCCwUzzRx2jVInG9bn4aG
         2GRP9L6pe9w5VkZQKTaHUZdEpMsScFqzI4FKnRZNWZaOTFx5PulmI7qlHxzbnQ3Vm5L1
         ho/AYNLxyzTj3BGsy1ykDLyrk3ZIKCSYVmjlwNdHVXg3el6rgOcmGI/4S9ngeGIaAePL
         G1BqzwQLqkB3lP/5+Ge9ZvhgXWJJUVcxbnd9drVlV8GsmIVzv2QUK6stbR3AKd6xgX3M
         LVvpD5IO9BE1kTfAyd5MTwOnauslPrT9qeyC+Z2O+6MczUi9tCJ1EyFpZkLsMrMSvBml
         IW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407157; x=1755011957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il9Pck9IsIM62v468p0OkwRij0VejED4nE+yuVLG5G4=;
        b=cYSf8+aeCW/9fxydEZmqlsd/JrjU5C469UGYPqip+weFnWOZFGGteAj0SoybT46UKn
         CYLab0sB97HHPzFPUBw838plSeel8425nycan0dVi2Fjb07+Ev0YzWH2S3xm5ELf8Nxv
         KsGCa+vibt38qdTcatZxX4KyJBuWScaNI9JA1xwtp3j6+YcgCUPS+0OoWTBsAS1ruB1T
         YQaVBul9J1QoqoFFbOXsBNnF2Yo8ckvEi0W1j/ZrWcNyhxqZdBCYCb5ZZ3Z+MgmZbMLR
         OG0IQyVlYvppniAwhabssWuK1tQTivHsvhGEnd/DOc5Pcvqfmb/Dez25cw7yMlHwBl+n
         YO2A==
X-Forwarded-Encrypted: i=1; AJvYcCWGL7gQYdFJRf1YV7cmVeHqxuVYFrH3Bdnba+5FmJYdQmXZa7WECaQ/IfleCXei36elYmWP9mte8YaZsCJme6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBmmDtb2oKld50GOX/djTpt1nwqb4BJd76mpninxn13VG9ofC
	psJ7xSar8v+K8yMJf9GWWHWWH8278rzHMfNv5ZRvNypdoL9UXUM/lfB+yqdHJek1vNO87eVlXQH
	/UDKePrEUyN/o7eFjtZHl23B9HPbnueVs47Lrkp5e
X-Gm-Gg: ASbGncsXbuHvEN6MmnyWOBmuVgwDP4CvThgCU9dUfXWrG64BmyNOGxmOG05yrN9Ga+A
	kjLg/i9RHRWj+LTfBLREj/Ln0AJftZAjMxXOrrOyKriRILq+NqaYSoXI9v+CrfRTIJXgPGJgkmT
	GVe7nQOgIQcu+pVT8sQFXVZYxG3O6A2ETxp5tSV/XL6b3Za5bCA+ltV9Sgn0/PL5jXPKjpEfdhM
	cQxvmNyGh2M1PpK4si0ao+Uq4275352JsT3NCpzqg==
X-Google-Smtp-Source: AGHT+IHsPHBMzQ2/T8+siD5ic8hE3vwnW0tBzW28yvMlPYYQ19knnUB0dJX3KDeJvl8+vhnMuDUx4SWEm9004kjEUZI=
X-Received: by 2002:ad4:5b8f:0:b0:6fa:c81a:6231 with SMTP id
 6a1803df08f44-70935f3f099mr182696396d6.8.1754407156788; Tue, 05 Aug 2025
 08:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-8-marievic@google.com>
In-Reply-To: <20250729193647.3410634-8-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Aug 2025 11:19:05 -0400
X-Gm-Features: Ac12FXwIYISejq5E32R90mOlfU2aOU_svsUKJMC2HWJWPZDH6qlcqSczsSA0db4
Message-ID: <CA+GJov5gBEKDpB=fLwiP5VBjoMJLkDeEcPhfn=SEr+tLoYWHFA@mail.gmail.com>
Subject: Re: [PATCH 7/9] kunit: Add example parameterized test with shared
 resources and direct static parameter array setup
To: Marie Zhussupova <marievic@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 3:37=E2=80=AFPM Marie Zhussupova <marievic@google.c=
om> wrote:
>
> Add `example_params_test_with_init` to illustrate how to manage
> shared resources across parameterized KUnit tests. This example
> showcases the use of the new `param_init` function and its registration
> to a test using the `KUNIT_CASE_PARAM_WITH_INIT` macro.
>
> Additionally, the test demonstrates:
> - How to directly assign a static parameter array to a test via
>   `kunit_register_params_array`.
> - Leveraging the Resource API for test resource management.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>

Hello!

I am always happy to see a new example test. I have a few tiny
nitpicky comments below. I would be happy for this to go in as-is or
just include the next test in the series as David suggested.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/kunit-example-test.c | 112 +++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index 3056d6bc705d..5bf559e243f6 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -277,6 +277,116 @@ static void example_slow_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, 1 + 1, 2);
>  }
>
> +/*
> + * This custom function allocates memory for the kunit_resource data fie=
ld.
> + * The function is passed to kunit_alloc_resource() and executed once
> + * by the internal helper __kunit_add_resource().
> + */

I don't think it is necessary to include that this function is
executed by an internal function: __kunit_add_resource(). Especially
since we have other example tests for the resource API.

> +static int example_resource_init(struct kunit_resource *res, void *conte=
xt)
> +{
> +       int *info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> +
> +       if (!info)
> +               return -ENOMEM;
> +       *info =3D *(int *)context;
> +       res->data =3D info;
> +       return 0;
> +}
> +
> +/*
> + * This function deallocates memory for the 'kunit_resource' data field.
> + * The function is passed to kunit_alloc_resource() and automatically
> + * executes within kunit_release_resource() when the resource's referenc=
e
> + * count, via kunit_put_resource(), drops to zero. KUnit uses reference
> + * counting to ensure that resources are not freed prematurely.
> + */

Similarly, I think this is a bit too much information since we have
other tests for the resource API. I would maybe shorten this by
removing the references to kunit_release_resource() and
kunit_put_resource().

> +static void example_resource_free(struct kunit_resource *res)
> +{
> +       kfree(res->data);
> +}
> +
> +/*
> + * This match function is invoked by kunit_find_resource() to locate
> + * a test resource based on defined criteria. The current example
> + * uniquely identifies the resource by its free function; however,
> + * alternative custom criteria can be implemented. Refer to
> + * lib/kunit/platform.c and lib/kunit/static_stub.c for further examples=
.
> + */

Again I would consider shortening this description.



> +static bool example_resource_alloc_match(struct kunit *test,
> +                                        struct kunit_resource *res,
> +                                        void *match_data)
> +{
> +       return res->data && res->free =3D=3D example_resource_free;
> +}
> +
> +/*
> + * This is an example of a function that provides a description for each=
 of the
> + * parameters.
> + */
> +static void example_param_array_get_desc(const void *p, char *desc)
> +{
> +       const struct example_param *param =3D p;
> +
> +       snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> +                "example check if %d is less than or equal to 3", param-=
>value);
> +}
> +
> +/*
> + * Initializes the parent kunit struct for parameterized KUnit tests.
> + * This function enables sharing resources across all parameterized
> + * tests by adding them to the `parent` kunit test struct. It also suppo=
rts
> + * registering either static or dynamic arrays of test parameters.
> + */
> +static int example_param_init(struct kunit *test)
> +{
> +       int ctx =3D 3; /* Data to be stored. */
> +       int arr_size =3D ARRAY_SIZE(example_params_array);
> +
> +       /*
> +        * This allocates a struct kunit_resource, sets its data field to
> +        * ctx, and adds it to the kunit struct's resources list. Note th=
at
> +        * this is test managed so we don't need to have a custom exit fu=
nction
> +        * to free it.
> +        */
> +       void *data =3D kunit_alloc_resource(test, example_resource_init, =
example_resource_free,
> +                                         GFP_KERNEL, &ctx);
> +
> +       if (!data)
> +               return -ENOMEM;
> +       /* Pass the static param array information to the parent struct k=
unit. */
> +       kunit_register_params_array(test, example_params_array, arr_size,
> +                                   example_param_array_get_desc);
> +       return 0;
> +}
> +
> +/*
> + * This is an example of a parameterized test that uses shared resources
> + * available from the struct kunit parent field of the kunit struct.
> + */
> +static void example_params_test_with_init(struct kunit *test)
> +{
> +       int threshold;
> +       struct kunit_resource *res;
> +       const struct example_param *param =3D test->param_value;
> +
> +       /* By design, param pointer will not be NULL. */
> +       KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +       /* Here we access the parent pointer of the test to find the shar=
ed resource. */
> +       res =3D kunit_find_resource(test->parent, example_resource_alloc_=
match, NULL);
> +
> +       KUNIT_ASSERT_NOT_NULL(test, res);
> +
> +       /* Since the data field in kunit_resource is a void pointer we ne=
ed to typecast it. */
> +       threshold =3D *((int *)res->data);
> +
> +       /* Assert that the parameter is less than or equal to a certain t=
hreshold. */
> +       KUNIT_ASSERT_LE(test, param->value, threshold);
> +
> +       /* This decreases the reference count after calling kunit_find_re=
source(). */
> +       kunit_put_resource(res);
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test =
suite
>   * below.
> @@ -296,6 +406,8 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
>         KUNIT_CASE(example_priv_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> +       KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, NULL,
> +                                  example_param_init, NULL),
>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.50.1.552.g942d659e1b-goog
>

