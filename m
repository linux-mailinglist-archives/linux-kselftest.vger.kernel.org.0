Return-Path: <linux-kselftest+bounces-38399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26EB1CB71
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 19:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059DE7A92C5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB4155A59;
	Wed,  6 Aug 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf3mgXL4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F013B58A
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502647; cv=none; b=Z5IdlER6sjqh6aNRDu8MnUkozU2/9SOMXnY2S08StxMLM/JSY6ZKoTY2ryVSaAW7MIdVjqq6ew95vw8wrgQIVtuiit/b9fsVJYr/StQ9oLPM54KFRjTDnJET3ncDGr1owRlagyGwkMinTuAPMT1s3eb6dQeTycxuj58m3/lgEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502647; c=relaxed/simple;
	bh=FcOXV+sYQfCKsVG5dl0oBKgrnzCX7QkMU+b/gJSwyuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4LnmDykz7ywaG4PwpjkgRTrB0M2UHLLDZ5S8o6DsE6FoD+AE0XnR/MxJOndz0WrQRaQxuSGR9UshqX5rE9KAizq3yNsopBzg1kHNDA2ARaSU16D0X++PodWWjgoQ+ZDy/mvG9NfJIjsQF5xpf5i54lwTVBRk92bR79SHApYf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nf3mgXL4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1118a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Aug 2025 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754502643; x=1755107443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6ZQ/5BaV6mQdffgVaaglAdkdHfzgWg/eTO8QxYBPeU=;
        b=nf3mgXL4BC3R+xIpTdxk7Q5RRGNZpAzNaKzAErQL5gFZtJLpXuUSa//Qqe3PK+0cU6
         TB/567x7Tt9izg2WCr04s74+/kiuaYEDgU+YItPCgI3yqAh+bZ7e05W++AMYIlxdUpYA
         pgIh52XmVp+XhjIlzX5p0HlWsKg5M3SmFpQ1EgHW2wMkrKO/f6MhQIfCB6Sr2JkfDKu7
         hiX1sw+gxoAI2hTZ0xYLmSZ4JtWSHv32eyb3U6dOvioOySjc8eWyX0obZQI5wkBGmNy0
         2eZYownhI7FP+ddrEvB4NHI8aIRU2voD9aRTHXREU5Z98xF6Wpodf4WHWkcET/1Yi+2q
         gR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754502643; x=1755107443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6ZQ/5BaV6mQdffgVaaglAdkdHfzgWg/eTO8QxYBPeU=;
        b=cERl/O/WtmJneHXBwhbcX0AHK3uEvZDZ3+VzV0FUC5rfqmk3/LJCUc0YlOp05PAfNK
         SK9ibyEvbvvWW/rD6nVUEGKVMli+1tTBbBo69tubUzTwuM1JvPN0URfhrndEn4s72b++
         82AIbRg8MjqN2LIIwmOeDc+kzEv0Q0Q8/lfrOQrMcLRPMSHXlGQoq941mHxPpxPM23VK
         e/Rfh9Esuzsh8weG0JUiE5XkHdsfTsrSCcBtZdTebKhCzNjNn7PumEVYZnlh9hxeJmQI
         olvSURX/GfarMjupNaoDUounYbyUI1h2LRVVmWSXBmXoazn0bid6WEF8umnmaWxMly5i
         YaQg==
X-Forwarded-Encrypted: i=1; AJvYcCXazgLsfZMbGevHwS7NeiyJtBkx0OBFADBTv/3vEOg2W3Wqr/+5n7lwgj4pMusOZAzD0MR16NlgCvO2jX8h+pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUk2o/AnZdwhkyAnry07TBbEm2sQgGxYptV9i3U6XVSEdTKzmL
	MlgnsOpnK58sjIGLrki6UvKexnEejaa3DLU2Dm4kRsAXY0Nk//5OwDO6UNMSP/3fe65SwMcHEwY
	l3SxTO8Ys+s4Oh65fpWU6N0jAaFVNeVkNUXPcJsPm
X-Gm-Gg: ASbGncsKFLJOcxqpWnchVcM06HwtNKDiNVwyRS/tscjnMCAJE7bN0WNs7f8a+7u+GOk
	luPNwV6eWzoXckjURvWqp/1uMY3csoWzXIY0Fr0x1+CakoGNqW87OYwnKumU/sIJoMBbc4qtiIA
	J9+1rp8mX/jx/9KnjpExi+u76qMWSYuq5Vnw3qK+byugKibC2njBVDv9MwMIJxMUfbMGvhvTIhq
	5EgyZ7NEOfgVuhzjlA=
X-Google-Smtp-Source: AGHT+IE+QDtUPARPU2wN4XerAfKdVLgsMbZ03V31aP2LxZYSJjBTKBDhaE0pgDwg/Hur4O5WYOACGm9GKfssEMe+4GQ=
X-Received: by 2002:a05:6402:4c1:b0:615:6167:4835 with SMTP id
 4fb4d7f45d1cf-61797ec0988mr91110a12.7.1754502642599; Wed, 06 Aug 2025
 10:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-8-marievic@google.com>
 <CABVgOSmBssmMz3qQi+TdEoaGQJNXaSVBrsO8RSW0MjLUUHPakg@mail.gmail.com>
In-Reply-To: <CABVgOSmBssmMz3qQi+TdEoaGQJNXaSVBrsO8RSW0MjLUUHPakg@mail.gmail.com>
From: Marie Zhussupova <marievic@google.com>
Date: Wed, 6 Aug 2025 13:50:31 -0400
X-Gm-Features: Ac12FXxZ0gzQXyQ3JCYs61KiK41rHInNvNCX1ufle-31wpGuIXR7lV23iXdDrBU
Message-ID: <CAAkQn5KnBZ7O6TkHL8UR0UaJ-v0P51TjtEwoRu7VWaPYd8oeSg@mail.gmail.com>
Subject: Re: [PATCH 7/9] kunit: Add example parameterized test with shared
 resources and direct static parameter array setup
To: David Gow <davidgow@google.com>
Cc: rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 5:45=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Wed, 30 Jul 2025 at 03:37, Marie Zhussupova <marievic@google.com> wrot=
e:
> >
> > Add `example_params_test_with_init` to illustrate how to manage
> > shared resources across parameterized KUnit tests. This example
> > showcases the use of the new `param_init` function and its registration
> > to a test using the `KUNIT_CASE_PARAM_WITH_INIT` macro.
> >
> > Additionally, the test demonstrates:
> > - How to directly assign a static parameter array to a test via
> >   `kunit_register_params_array`.
> > - Leveraging the Resource API for test resource management.
> >
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
> > ---
>
> Thanks for writing some examples! This is great, and makes the rest of
> the series much easier to understand.
>
> (It also reminds me how much I hate the verbose parts of the resource
> API, but it's definitely out of scope to refactor that here. :-))
>
> It does seem like this is a lot of effort to go through for one shared
> integer, though. In the real world, I'd suggest using
> kunit->parent->priv here. As an example, though, it's fine (though
> maybe using a named resource or even kunit_kzalloc() or similar would
> give a better example of how convenient this could be.
>
> It's also not entirely clear why we're using
> kunit_register_params_array() for a static array, when
> KUNIT_ARRAY_PARAM() exists. (This is clearly because the latter
> doesn't support init functions; and I see why we don't necessarily
> want to make the number of macros explode through adding
> KUNIT_ARRAY_PARAM_WITH_INIT() et al, but maybe we should note that in
> the commit description, either here or before.)
>
> Actual test looks fine, though:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>

Hello David,

I agree that using the Resource API for a single integer is a bit extra.
My idea behind this test was to demonstrate that the Resource API
could be used for managing shared resources and to have the
style of the existing example tests that do simple things with integers.

Using kunit_kzalloc() would be a great simplification. As for a named
resource, we don't have a function to allocate named resources yet
as would be needed here, but that sounds like a great future patch.

We can actually use the KUNIT_ARRAY_PARAM() macro with
KUNIT_CASE_PARAM_WITH_INIT(). We would just pass that created
`*_gen_params` function to KUNIT_CASE_PARAM_WITH_INIT()
instead of NULL. The reason I used kunit_register_params_array() with
the static array was to show that test users can pass a static array
this way, as well, and also to avoid making the test too long with the
dynamic array
creation. But I do like the consistency of using KUNIT_ARRAY_PARAM()
for static arrays and kunit_register_params_array() only for
dynamic ones.

Thank you,
-Marie

>
> >  lib/kunit/kunit-example-test.c | 112 +++++++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >
> > diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-t=
est.c
> > index 3056d6bc705d..5bf559e243f6 100644
> > --- a/lib/kunit/kunit-example-test.c
> > +++ b/lib/kunit/kunit-example-test.c
> > @@ -277,6 +277,116 @@ static void example_slow_test(struct kunit *test)
> >         KUNIT_EXPECT_EQ(test, 1 + 1, 2);
> >  }
> >
> > +/*
> > + * This custom function allocates memory for the kunit_resource data f=
ield.
> > + * The function is passed to kunit_alloc_resource() and executed once
> > + * by the internal helper __kunit_add_resource().
> > + */
> > +static int example_resource_init(struct kunit_resource *res, void *con=
text)
> > +{
> > +       int *info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> > +
> > +       if (!info)
> > +               return -ENOMEM;
> > +       *info =3D *(int *)context;
> > +       res->data =3D info;
> > +       return 0;
> > +}
> > +
> > +/*
> > + * This function deallocates memory for the 'kunit_resource' data fiel=
d.
> > + * The function is passed to kunit_alloc_resource() and automatically
> > + * executes within kunit_release_resource() when the resource's refere=
nce
> > + * count, via kunit_put_resource(), drops to zero. KUnit uses referenc=
e
> > + * counting to ensure that resources are not freed prematurely.
> > + */
> > +static void example_resource_free(struct kunit_resource *res)
> > +{
> > +       kfree(res->data);
> > +}
> > +
> > +/*
> > + * This match function is invoked by kunit_find_resource() to locate
> > + * a test resource based on defined criteria. The current example
> > + * uniquely identifies the resource by its free function; however,
> > + * alternative custom criteria can be implemented. Refer to
> > + * lib/kunit/platform.c and lib/kunit/static_stub.c for further exampl=
es.
> > + */
> > +static bool example_resource_alloc_match(struct kunit *test,
> > +                                        struct kunit_resource *res,
> > +                                        void *match_data)
> > +{
> > +       return res->data && res->free =3D=3D example_resource_free;
> > +}
> > +
> > +/*
> > + * This is an example of a function that provides a description for ea=
ch of the
> > + * parameters.
> > + */
> > +static void example_param_array_get_desc(const void *p, char *desc)
> > +{
> > +       const struct example_param *param =3D p;
> > +
> > +       snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> > +                "example check if %d is less than or equal to 3", para=
m->value);
> > +}
> > +
> > +/*
> > + * Initializes the parent kunit struct for parameterized KUnit tests.
> > + * This function enables sharing resources across all parameterized
> > + * tests by adding them to the `parent` kunit test struct. It also sup=
ports
> > + * registering either static or dynamic arrays of test parameters.
> > + */
> > +static int example_param_init(struct kunit *test)
> > +{
> > +       int ctx =3D 3; /* Data to be stored. */
> > +       int arr_size =3D ARRAY_SIZE(example_params_array);
> > +
> > +       /*
> > +        * This allocates a struct kunit_resource, sets its data field =
to
> > +        * ctx, and adds it to the kunit struct's resources list. Note =
that
> > +        * this is test managed so we don't need to have a custom exit =
function
> > +        * to free it.
> > +        */
> > +       void *data =3D kunit_alloc_resource(test, example_resource_init=
, example_resource_free,
> > +                                         GFP_KERNEL, &ctx);
> > +
> > +       if (!data)
> > +               return -ENOMEM;
> > +       /* Pass the static param array information to the parent struct=
 kunit. */
> > +       kunit_register_params_array(test, example_params_array, arr_siz=
e,
> > +                                   example_param_array_get_desc);
> > +       return 0;
> > +}
> > +
> > +/*
> > + * This is an example of a parameterized test that uses shared resourc=
es
> > + * available from the struct kunit parent field of the kunit struct.
> > + */
> > +static void example_params_test_with_init(struct kunit *test)
> > +{
> > +       int threshold;
> > +       struct kunit_resource *res;
> > +       const struct example_param *param =3D test->param_value;
> > +
> > +       /* By design, param pointer will not be NULL. */
> > +       KUNIT_ASSERT_NOT_NULL(test, param);
> > +
> > +       /* Here we access the parent pointer of the test to find the sh=
ared resource. */
> > +       res =3D kunit_find_resource(test->parent, example_resource_allo=
c_match, NULL);
> > +
> > +       KUNIT_ASSERT_NOT_NULL(test, res);
> > +
> > +       /* Since the data field in kunit_resource is a void pointer we =
need to typecast it. */
> > +       threshold =3D *((int *)res->data);
> > +
> > +       /* Assert that the parameter is less than or equal to a certain=
 threshold. */
> > +       KUNIT_ASSERT_LE(test, param->value, threshold);
> > +
> > +       /* This decreases the reference count after calling kunit_find_=
resource(). */
> > +       kunit_put_resource(res);
> > +}
> > +
> >  /*
> >   * Here we make a list of all the test cases we want to add to the tes=
t suite
> >   * below.
> > @@ -296,6 +406,8 @@ static struct kunit_case example_test_cases[] =3D {
> >         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
> >         KUNIT_CASE(example_priv_test),
> >         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> > +       KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, NULL,
> > +                                  example_param_init, NULL),
> >         KUNIT_CASE_SLOW(example_slow_test),
> >         {}
> >  };
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

