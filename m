Return-Path: <linux-kselftest+bounces-38557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C82B1E8DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FFA3A815E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A32231826;
	Fri,  8 Aug 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/I3JwP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD7278E53
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658148; cv=none; b=esUu4DvvWSM3w+jGRAF549FHk/T6uJRZapmIc8cRnk3TUcSm6dqcDZFeVpZKto3OKw1DXiJ+Glnzx70kvSWbUQoH81Hq1M3qOtakOYC8w9fNRkdq8y3RNyuQzwaA7CIZ0ussOb5zrf6y2sDBQO0YyRIrWAlg5mMdr/FQVvxrbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658148; c=relaxed/simple;
	bh=8DDcGkoGPrBzraneT5UBenPl9oO+CNVgVvA827ZfbXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0rS4PM2IVVjuwCkwy9aaQV4pwmyPYqV59OliMK8drvLtEcyaWLpc3tMdr4Dy7qkdXp3ixj/nxRsS1U6Y9ku2e15rp55SmsgOqCA1nwbxMyvTogAEThGTQ5hoXvNpwaTw0i8PZsaZIQN+gatKFjf2kYCWLmH5VcBUpSheNhR9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/I3JwP2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61543b05b7cso11116a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Aug 2025 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754658144; x=1755262944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAJ6FGqkbh717pDwmHpln0U4/PfoZkwnb7I/ttxK6oI=;
        b=u/I3JwP2A+GK5zuxenBzKyQMCcvUd4EXeSoy8Sx097Q0qQqyVQyaex7duG8NMB0Yxo
         VrCOrNE8GJ0O2yRP/DZKeEJwnTUMckyBvoXgU3tDdRTrZX9VwcZ10SKOeh9QfpJ3njsT
         GMTYMy1J4TmUoSItz+8dMH0G0FTErywWfZMfpyb+Ue5fLIxZ/f77HdVKZ1juG48yNSqG
         /sYJw1Xi6rpkrg/Xi1Pp2SZSlzQcSrIBXmChC5vcavBDIeXDMaEMwrk6RHI2o7UsoVpq
         HWId5DKibSSOKdFTbQM9XxIssCFI0ZTIv2sXCfC6z+hfmC+Era1bWWVeWfBI7h7noC7d
         SLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754658144; x=1755262944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAJ6FGqkbh717pDwmHpln0U4/PfoZkwnb7I/ttxK6oI=;
        b=B8dJ0AN+sKpUCNeyrZ4RomojVAFNVAn8wb9dQfSuHEPAfK4bxxdougd5UYO8pZuOrM
         AzVnMI10GnxalviktAmE8d/B8m7ywBUhOtKlgDcU0amD97JpKpQ3ZXN1VbTvxAee4s5X
         VeYbmcLUv3t9Nr8Se9kVocrCS5jLIV7PDfCJorL2691SvDHwjC5ZDUD4/l/CrzF3PQC+
         vvFE9TOidbzSVdGGLMmVS03JjRiomPMbK8c5XRsrmKacpP5/lB0kl8LAT/WqvWIMegZm
         t8cycM6HcKmsFcy8it7q52wkr9J9dlrK+jbeajQuvp8vI9WlFgwKARGrJNCeu+Qgwwit
         ZiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvQ1qUUiyyvZEbc6h9v3bgp8mlCsKK37BDUM8vqbfo0mrtCuy49eAXsQcpghGmXssye5GuIAXSYxY+Jv/0/F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKXQ1z8lF0UJ6+Gwppa6u7woVXK5Gw4vl1Q/SWUWOxBx1Ijl8
	8tsI9MTCWU29o8PcNj9rmbx641sL9iG6ZlcBhKSM9TejplzHk+Sq+9/q5it3CKku/W+UFCWSgE1
	eD4FevnPs/KdqcEXcX/8QMs7gAdzudom7F5jMq/AO
X-Gm-Gg: ASbGncswZ3AFIfwQLAzV5uGBaMc2kVvOmehDoV6HUcvj8FtMVYQ2IxLvyjFjJyeSgxY
	LsTBWWtbVY8o8kHo7egy5EIUDipIaoLi5LmxFeyaIFCbEwMi8q+A+7fq4Z6QMGKfevUWtPvDLb2
	8WxmIwG1GN/YrAroli2Mg+o4gvNPqyAwmCLw65bAnWz0lhNEHzlKs4s/my3eSA9IF7lHKEkuOKU
	EGP13Xr
X-Google-Smtp-Source: AGHT+IEZZ9bSdNQYUF48wJ7cTr+Cqhvr1Umls+vnMWstmvYQgL7eeX2CKS06elQmW7cRVjFhgDgbZvEijt7OPx0SlUc=
X-Received: by 2002:aa7:cccd:0:b0:615:4bd4:5798 with SMTP id
 4fb4d7f45d1cf-617f230879amr19448a12.6.1754658143141; Fri, 08 Aug 2025
 06:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-10-marievic@google.com>
 <CABVgOSnWF=xnfSJjCJ4KYAPhnY7OyeU7w1e2MXi5U25nwaT+MQ@mail.gmail.com>
In-Reply-To: <CABVgOSnWF=xnfSJjCJ4KYAPhnY7OyeU7w1e2MXi5U25nwaT+MQ@mail.gmail.com>
From: Marie Zhussupova <marievic@google.com>
Date: Fri, 8 Aug 2025 09:02:09 -0400
X-Gm-Features: Ac12FXw6AWC0LnlsOC2ttnJifRxiBAp52bTOP9hWwsV4WLPHuDfkPnVssu6-H-I
Message-ID: <CAAkQn5LCgSdYdp4X0Ucum+TVyf5U+X-j3gdD_qYXtzf6XDBGMA@mail.gmail.com>
Subject: Re: [PATCH 9/9] Documentation: kunit: Document new parameterized test features
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
> > -Update the KUnit documentation to explain the concept
> > of a parent parameterized test.
> > -Add examples demonstrating different ways of passing
> > parameters to parameterized tests and how to manage
> > shared resources between them.
> >
>
> Nit: We don't need the dot points ('-') here. Just make them paragraphs.

Will do!

>
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
> > ---
>
> Thanks very, very much for including such detailed documentation.
>
> I do think some of the examples could be trimmed / left in the
> kunit-example-test.c file and referenced, as they're long enough that
> it's difficult to focus on the essentials. But otherwise, this looks
> great.
>
> A few small notes below, but otherwise:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  Documentation/dev-tools/kunit/usage.rst | 455 +++++++++++++++++++++++-
> >  1 file changed, 449 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/de=
v-tools/kunit/usage.rst
> > index 066ecda1dd98..be1d656053cf 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -542,11 +542,21 @@ There is more boilerplate code involved, but it c=
an:
> >  Parameterized Testing
> >  ~~~~~~~~~~~~~~~~~~~~~
> >
> > -The table-driven testing pattern is common enough that KUnit has speci=
al
> > -support for it.
> > -
> > -By reusing the same ``cases`` array from above, we can write the test =
as a
> > -"parameterized test" with the following.
> > +To efficiently and elegantly validate a test case against a variety of=
 inputs,
> > +KUnit also provides a parameterized testing framework. This feature fo=
rmalizes
> > +and extends the concept of table-driven tests discussed previously, of=
fering
> > +a more integrated and flexible way to handle multiple test scenarios w=
ith
> > +minimal code duplication.
>
> Nit: maybe we can tone down the adjectives slightly here. I do like
> parameterised testing a lot, but it probably doesn't need to be
> "efficient", "elegant", "integrated", and "flexible".

Will do that in v2.

>
> > +
> > +Passing Parameters to the Test Cases
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +There are three main ways to provide the parameters to a test case:
> > +
> > +Array Parameter Macros (``KUNIT_ARRAY_PARAM`` or ``KUNIT_ARRAY_PARAM_D=
ESC``):
> > +   KUnit provides special support for the common table-driven testing =
pattern.
> > +   By applying either ``KUNIT_ARRAY_PARAM`` or ``KUNIT_ARRAY_PARAM_DES=
C`` to the
> > +   ``cases`` array from the previous section, we can create a paramete=
rized test
> > +   as shown below:
> >
> >  .. code-block:: c
> >
> > @@ -555,7 +565,7 @@ By reusing the same ``cases`` array from above, we =
can write the test as a
> >                 const char *str;
> >                 const char *sha1;
> >         };
> > -       const struct sha1_test_case cases[] =3D {
> > +       static const struct sha1_test_case cases[] =3D {
> >                 {
> >                         .str =3D "hello world",
> >                         .sha1 =3D "2aae6c35c94fcfb415dbe95f408b9ce91ee8=
46ed",
> > @@ -590,6 +600,439 @@ By reusing the same ``cases`` array from above, w=
e can write the test as a
> >                 {}
> >         };
> >
> > +Custom Parameter Generator (``generate_params``):
> > +   You can pass your own ``generate_params`` function to the ``KUNIT_C=
ASE_PARAM``
> > +   or ``KUNIT_CASE_PARAM_WITH_INIT`` macros. This function is responsi=
ble for
> > +   generating parameters one by one. It receives the previously genera=
ted parameter
> > +   as the ``prev`` argument (which is ``NULL`` on the first call) and =
can also
> > +   access any context available from the parent ``struct kunit`` passe=
d as the
> > +   ``test`` argument. KUnit calls this function repeatedly until it re=
turns
> > +   ``NULL``. Below is an example of how it works:
> > +
> > +.. code-block:: c
> > +
> > +       #define MAX_TEST_BUFFER_SIZE 8
> > +
> > +       // Example generator function. It produces a sequence of buffer=
 sizes that
> > +       // are powers of two, starting at 1 (e.g., 1, 2, 4, 8).
> > +       static const void *buffer_size_gen_params(struct kunit *test, c=
onst void *prev, char *desc)
> > +       {
> > +               long prev_buffer_size =3D (long)prev;
> > +               long next_buffer_size =3D 1; // Start with an initial s=
ize of 1.
> > +
> > +               // Stop generating parameters if the limit is reached o=
r exceeded.
> > +               if (prev_buffer_size >=3D MAX_TEST_BUFFER_SIZE)
> > +                       return NULL;
> > +
> > +               // For subsequent calls, calculate the next size by dou=
bling the previous one.
> > +               if (prev)
> > +                       next_buffer_size =3D prev_buffer_size << 1;
> > +
> > +               return (void *)next_buffer_size;
> > +       }
> > +
> > +       // Simple test to validate that kunit_kzalloc provides zeroed m=
emory.
> > +       static void buffer_zero_test(struct kunit *test)
> > +       {
> > +               long buffer_size =3D (long)test->param_value;
> > +               // Use kunit_kzalloc to allocate a zero-initialized buf=
fer. This makes the
> > +               // memory "parameter managed," meaning it's automatical=
ly cleaned up at
> > +               // the end of each parameter execution.
> > +               int *buf =3D kunit_kzalloc(test, buffer_size * sizeof(i=
nt), GFP_KERNEL);
> > +
> > +               // Ensure the allocation was successful.
> > +               KUNIT_ASSERT_NOT_NULL(test, buf);
> > +
> > +               // Loop through the buffer and confirm every element is=
 zero.
> > +               for (int i =3D 0; i < buffer_size; i++)
> > +                       KUNIT_EXPECT_EQ(test, buf[i], 0);
> > +       }
> > +
> > +       static struct kunit_case buffer_test_cases[] =3D {
> > +               KUNIT_CASE_PARAM(buffer_zero_test, buffer_size_gen_para=
ms),
> > +               {}
> > +       };
> > +
> > +Direct Registration in Parameter Init Function (using ``kunit_register=
_params_array``):
>
> Maybe we should highlight this as being array-based more explicitly.
> "Runtime Array Registration in the Init function" or similar?

That would make it clearer, will make this edit in v2.

>
> > +   For more complex scenarios, you can directly register a parameter a=
rray with
> > +   a test case instead of using a ``generate_params`` function. This i=
s done by
> > +   passing the array to the ``kunit_register_params_array`` macro with=
in an
> > +   initialization function for the parameterized test series
> > +   (i.e., a function named ``param_init``). To better understand this =
mechanism
> > +   please refer to the "Adding Shared Resources" section below.
> > +
> > +   This method supports both dynamically built and static arrays.
> > +
> > +   As the following code shows, the ``example_param_init_dynamic_arr``=
 function
> > +   utilizes ``make_fibonacci_params`` to create a dynamic array, which=
 is then
> > +   registered using ``kunit_register_params_array``. The corresponding=
 exit
> > +   function, ``example_param_exit``, is responsible for freeing this d=
ynamically
> > +   allocated params array after the parameterized test series ends.
> > +
> > +.. code-block:: c
> > +
> > +       /*
> > +        * Helper function to create a parameter array of Fibonacci num=
bers. This example
> > +        * highlights a parameter generation scenario that is:
> > +        * 1. Not feasible to fully pre-generate at compile time.
> > +        * 2. Challenging to implement with a standard 'generate_params=
' function,
> > +        * as it typically only provides the immediately 'prev' paramet=
er, while
> > +        * Fibonacci requires access to two preceding values for calcul=
ation.
> > +        */
> > +       static void *make_fibonacci_params(int seq_size)
> > +       {
> > +               int *seq;
> > +
> > +               if (seq_size <=3D 0)
> > +                       return NULL;
> > +
> > +               seq =3D kmalloc_array(seq_size, sizeof(int), GFP_KERNEL=
);
> > +
> > +               if (!seq)
> > +                       return NULL;
> > +
> > +               if (seq_size >=3D 1)
> > +                       seq[0] =3D 0;
> > +               if (seq_size >=3D 2)
> > +                       seq[1] =3D 1;
> > +               for (int i =3D 2; i < seq_size; i++)
> > +                       seq[i] =3D seq[i - 1] + seq[i - 2];
> > +               return seq;
> > +       }
> > +
> > +       // This is an example of a function that provides a description=
 for each of the
> > +       // parameters.
> > +       static void example_param_dynamic_arr_get_desc(const void *p, c=
har *desc)
> > +       {
> > +               const int *fib_num =3D p;
> > +
> > +               snprintf(desc, KUNIT_PARAM_DESC_SIZE, "fibonacci param:=
 %d", *fib_num);
> > +       }
> > +
> > +       // Example of a parameterized test init function that registers=
 a dynamic array.
> > +       static int example_param_init_dynamic_arr(struct kunit *test)
> > +       {
> > +               int seq_size =3D 6;
> > +               int *fibonacci_params =3D make_fibonacci_params(seq_siz=
e);
> > +
> > +               if (!fibonacci_params)
> > +                       return -ENOMEM;
> > +
> > +               /*
> > +                * Passes the dynamic parameter array information to th=
e parent struct kunit.
> > +                * The array and its metadata will be stored in test->p=
arent->params_data.
> > +                * The array itself will be located in params_data.para=
ms.
> > +                */
> > +               kunit_register_params_array(test, fibonacci_params, seq=
_size,
> > +                                           example_param_dynamic_arr_g=
et_desc);
> > +               return 0;
> > +       }
> > +
> > +       // Function to clean up the parameterized test's parent kunit s=
truct if
> > +       // there were custom allocations.
> > +       static void example_param_exit_dynamic_arr(struct kunit *test)
> > +       {
> > +               /*
> > +                * We allocated this array, so we need to free it.
> > +                * Since the parent parameter instance is passed here,
> > +                * we can directly access the array via `test->params_d=
ata.params`
> > +                * instead of `test->parent->params_data.params`.
> > +                */
> > +               kfree(test->params_data.params);
> > +       }
> > +
> > +       /*
> > +        * Example of test that uses the registered dynamic array to pe=
rform assertions
> > +        * and expectations.
> > +        */
> > +       static void example_params_test_with_init_dynamic_arr(struct ku=
nit *test)
> > +       {
> > +               const int *param =3D test->param_value;
> > +               int param_val;
> > +
> > +               /* By design, param pointer will not be NULL. */
> > +               KUNIT_ASSERT_NOT_NULL(test, param);
> > +
> > +               param_val =3D *param;
> > +               KUNIT_EXPECT_EQ(test, param_val - param_val, 0);
> > +       }
> > +
> > +       static struct kunit_case example_tests[] =3D {
> > +               // The NULL here stands in for the generate_params func=
tion
> > +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_ini=
t_dynamic_arr, NULL,
> > +                                          example_param_init_dynamic_a=
rr,
> > +                                          example_param_exit_dynamic_a=
rr),
> > +               {}
> > +       };
> > +
>
> This is a long example, which already exists in the source code
> (kunit-example-test.c). Could we just include some highlights (e.g.,
> the init function and the KUNIT_CASE_PARAM_WITH_INIT call), and link
> to the source code for the rest?

Thank you for the suggestion! I will do that in v2.

>
> > +Adding Shared Resources
> > +^^^^^^^^^^^^^^^^^^^^^^^
> > +All parameterized test executions in this framework have a parent test=
 of type
> > +``struct kunit``. This parent is not used to execute any test logic it=
self;
> > +instead, it serves as a container for shared context that can be acces=
sed by
> > +all its individual test executions (or parameters). Therefore, each in=
dividual
> > +test execution holds a pointer to this parent, accessible via a field =
named
> > +``parent``.
> > +
> > +It's possible to add resources to share between the individual test ex=
ecutions
> > +within a parameterized test series by using the ``KUNIT_CASE_PARAM_WIT=
H_INIT``
> > +macro, to which you pass custom ``param_init`` and ``param_exit`` func=
tions.
> > +These functions run once before and once after the entire parameterize=
d test
> > +series, respectively. The ``param_init`` function can be used for addi=
ng any
> > +resources to the resources field of a parent test and also provide an =
additional
> > +way of setting the parameter array. The ``param_exit`` function can be=
 used
> > +release any resources that were not test managed i.e. not automaticall=
y cleaned
> > +up after the test ends.
> > +
> > +.. note::
> > +   If both a ``generate_params`` function is passed to ``KUNIT_CASE_PA=
RAM_WITH_INIT``
> > +   and an array is registered via ``kunit_register_params_array`` in
> > +   ``param_init``, the ``generate_params`` function will be used to ge=
t
> > +   the parameters.
>
> Maybe note that the ``generate_params`` function can use the array
> passed, though?

Will make this edit in v2

>
> > +
> > +Both ``param_init`` and ``param_exit`` are passed the parent instance =
of a test
> > +(parent ``struct kunit``) behind the scenes. However, the test case fu=
nction
> > +receives the individual instance of a test for each parameter. Therefo=
re, to
> > +manage and access shared resources from within a test case function, y=
ou must use
> > +``test->parent``.
> > +
> > +.. note::
> > +   The ``suite->init()`` function, which runs before each parameter ex=
ecution,
> > +   receives the individual instance of a test for each parameter. Ther=
efore,
> > +   resources set up in ``suite->init()`` are reset for each individual
> > +   parameterized test execution and are only visible within that speci=
fic test.
> > +
> > +For instance, finding a shared resource allocated by the Resource API =
requires
> > +passing ``test->parent`` to ``kunit_find_resource()``. This principle =
extends to
> > +all other APIs that might be used in the test case function, including
> > +``kunit_kzalloc()``, ``kunit_kmalloc_array()``, and others (see
> > +Documentation/dev-tools/kunit/api/test.rst and the
> > +Documentation/dev-tools/kunit/api/resource.rst).
> > +
> > +The code below shows how you can add the shared resources. Note that t=
his code
> > +utilizes the Resource API, which you can read more about here:
> > +Documentation/dev-tools/kunit/api/resource.rst.
> > +
> > +.. code-block:: c
> > +
> > +       /* An example parameter array. */
> > +       static const struct example_param {
> > +               int value;
> > +       } example_params_array[] =3D {
> > +               { .value =3D 3, },
> > +               { .value =3D 2, },
> > +               { .value =3D 1, },
> > +               { .value =3D 0, },
> > +       };
> > +
> > +       /*
> > +        * This custom function allocates memory for the kunit_resource=
 data field.
> > +        * The function is passed to kunit_alloc_resource() and execute=
d once
> > +        * by the internal helper __kunit_add_resource().
> > +        */
> > +       static int example_resource_init(struct kunit_resource *res, vo=
id *context)
> > +       {
> > +               int *info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> > +
> > +               if (!info)
> > +                       return -ENOMEM;
> > +               *info =3D *(int *)context;
> > +               res->data =3D info;
> > +               return 0;
> > +       }
> > +
> > +       /*
> > +        * This function deallocates memory for the 'kunit_resource' da=
ta field.
> > +        * The function is passed to kunit_alloc_resource() and automat=
ically
> > +        * executes within kunit_release_resource() when the resource's=
 reference
> > +        * count, via kunit_put_resource(), drops to zero. KUnit uses r=
eference
> > +        * counting to ensure that resources are not freed prematurely.
> > +        */
> > +       static void example_resource_free(struct kunit_resource *res)
> > +       {
> > +               kfree(res->data);
> > +       }
> > +
> > +       /*
> > +        * This match function is invoked by kunit_find_resource() to l=
ocate
> > +        * a test resource based on defined criteria. The current examp=
le
> > +        * uniquely identifies the resource by its free function; howev=
er,
> > +        * alternative custom criteria can be implemented. Refer to
> > +        * lib/kunit/platform.c and lib/kunit/static_stub.c for further=
 examples.
> > +        */
> > +       static bool example_resource_alloc_match(struct kunit *test,
> > +                                                struct kunit_resource =
*res,
> > +                                                void *match_data)
> > +       {
> > +               return res->data && res->free =3D=3D example_resource_f=
ree;
> > +       }
> > +
> > +       /*
> > +        * This is an example of a function that provides a description=
 for each of the
> > +        * parameters.
> > +       */
> > +       static void example_param_array_get_desc(const void *p, char *d=
esc)
> > +       {
> > +               const struct example_param *param =3D p;
> > +
> > +               snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> > +                       "example check if %d is less than or equal to 3=
", param->value);
> > +       }
> > +
> > +       /*
> > +        * Initializes the parent kunit struct for parameterized KUnit =
tests.
> > +        * This function enables sharing resources across all parameter=
ized
> > +        * tests by adding them to the `parent` kunit test struct. It a=
lso supports
> > +        * registering either static or dynamic arrays of test paramete=
rs.
> > +        */
> > +       static int example_param_init(struct kunit *test)
> > +       {
> > +               int ctx =3D 3; /* Data to be stored. */
> > +               int arr_size =3D ARRAY_SIZE(example_params_array);
> > +
> > +               /*
> > +                * This allocates a struct kunit_resource, sets its dat=
a field to
> > +                * ctx, and adds it to the kunit struct's resources lis=
t. Note that
> > +                * this is test managed so we don't need to have a cust=
om exit function
> > +                * to free it.
> > +                */
> > +               void *data =3D kunit_alloc_resource(test, example_resou=
rce_init, example_resource_free,
> > +                                                 GFP_KERNEL, &ctx);
> > +
> > +               if (!data)
> > +                       return -ENOMEM;
> > +               /* Pass the static param array information to the paren=
t struct kunit. */
> > +               kunit_register_params_array(test, example_params_array,=
 arr_size,
> > +                                           example_param_array_get_des=
c);
> > +               return 0;
> > +       }
> > +
> > +       /*
> > +       * This is an example of a parameterized test that uses shared r=
esources
> > +       * available from the struct kunit parent field of the kunit str=
uct.
> > +       */
> > +       static void example_params_test_with_init(struct kunit *test)
> > +       {
> > +               int threshold;
> > +               struct kunit_resource *res;
> > +               const struct example_param *param =3D test->param_value=
;
> > +
> > +               /* By design, param pointer will not be NULL. */
> > +               KUNIT_ASSERT_NOT_NULL(test, param);
> > +
> > +               /* Here we need to access the parent pointer of the tes=
t to find the shared resource. */
> > +               res =3D kunit_find_resource(test->parent, example_resou=
rce_alloc_match, NULL);
> > +
> > +               KUNIT_ASSERT_NOT_NULL(test, res);
> > +
> > +               /* Since the data field in kunit_resource is a void poi=
nter we need to typecast it. */
> > +               threshold =3D *((int *)res->data);
> > +
> > +               /* Assert that the parameter is less than or equal to a=
 certain threshold. */
> > +               KUNIT_ASSERT_LE(test, param->value, threshold);
> > +
> > +               /* This decreases the reference count after calling kun=
it_find_resource(). */
> > +               kunit_put_resource(res);
> > +       }
> > +
> > +
> > +       static struct kunit_case example_tests[] =3D {
> > +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_ini=
t, NULL,
> > +                                          example_param_init, NULL),
> > +               {}
> > +       };
> > +
>
> This is a really long example, which already exists in
> kunit-example-test.c. Can we either link to it there (and just include
> the most critical lines here), or have a smaller, less-complete
> example inline here?

Yes, I will do that in v2.

>
>
> > +As an alternative to using the KUnit Resource API for shared resources=
, you can
> > +place them in ``test->parent->priv``. It can store data that needs to =
persist
> > +and be accessible across all executions within a parameterized test se=
ries.
> > +
> > +As stated previously ``param_init`` and ``param_exit`` receive the par=
ent
> > +``struct kunit`` instance. So, you can directly use ``test->priv`` wit=
hin them
> > +to manage shared resources. However, from within the test case functio=
n, you must
> > +navigate up to the parent i.e. use ``test->parent->priv`` to access th=
ose same
> > +resources.
> > +
> > +The resources placed in ``test->parent-priv`` will also need to be all=
ocated in
> > +memory to persist across the parameterized tests executions. If memory=
 is
>
> Nit: 'parameterized test executions' singular?

Thank you for catching this! Though I will be changing all references to
parameter executions to "parameter runs" to be consistent with the
terminology in v2.

>
> > +allocated using the memory allocation APIs provided by KUnit (describe=
d more in
> > +the section below), you will not need to worry about deallocating them=
 as they
> > +will be managed by the parent parameterized test that gets automatical=
ly cleaned
> > +up upon the end of the parameterized test series.
> > +
> > +The code below demonstrates example usage of the ``priv`` field for sh=
ared
> > +resources:
> > +
> > +.. code-block:: c
> > +
> > +       /* An example parameter array. */
> > +       static const struct example_param {
> > +               int value;
> > +       } example_params_array[] =3D {
> > +               { .value =3D 3, },
> > +               { .value =3D 2, },
> > +               { .value =3D 1, },
> > +               { .value =3D 0, },
> > +       };
> > +
> > +       /*
> > +        * Initializes the parent kunit struct for parameterized KUnit =
tests.
> > +        * This function enables sharing resources across all parameter=
ized
> > +        * tests.
> > +        */
> > +       static int example_param_init_priv(struct kunit *test)
> > +       {
> > +               int ctx =3D 3; /* Data to be stored. */
> > +               int arr_size =3D ARRAY_SIZE(example_params_array);
> > +
> > +               /*
> > +                * Allocate memory using kunit_kzalloc(). Since the `pa=
ram_init`
> > +                * function receives the parent instance of test, this =
memory
> > +                * allocation will be scoped to the lifetime of the who=
le
> > +                * parameterized test series.
> > +                */
> > +               test->priv =3D kunit_kzalloc(test, sizeof(int), GFP_KER=
NEL);
> > +
> > +               /* Assign the context value to test->priv.*/
> > +               *((int *)test->priv) =3D ctx;
> > +
> > +               /* Pass the static param array information to the paren=
t struct kunit. */
> > +               kunit_register_params_array(test, example_params_array,=
 arr_size, NULL);
> > +               return 0;
> > +       }
> > +
> > +       /*
> > +       * This is an example of a parameterized test that uses shared r=
esources
> > +       * available from the struct kunit parent field of the kunit str=
uct.
> > +       */
> > +       static void example_params_test_with_init_priv(struct kunit *te=
st)
> > +       {
> > +               int threshold;
> > +               const struct example_param *param =3D test->param_value=
;
> > +
> > +               /* By design, param pointer will not be NULL. */
> > +               KUNIT_ASSERT_NOT_NULL(test, param);
> > +
> > +               /* By design, test->parent will also not be NULL. */
> > +               KUNIT_ASSERT_NOT_NULL(test, test->parent);
> > +
> > +               /* Assert that test->parent->priv has data. */
> > +               KUNIT_ASSERT_NOT_NULL(test, test->parent->priv);
> > +
> > +               /* Here we need to use test->parent->priv to access the=
 shared resource. */
> > +               threshold =3D *(int *)test->parent->priv;
> > +
> > +               /* Assert that the parameter is less than or equal to a=
 certain threshold. */
> > +               KUNIT_ASSERT_LE(test, param->value, threshold);
> > +       }
> > +
> > +
> > +       static struct kunit_case example_tests[] =3D {
> > +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_ini=
t_priv, NULL,
> > +                                          example_param_init_priv, NUL=
L),
> > +               {}
> > +       };
> > +
>
> Again, this is a little long, but it's not as bad as the others, and
> isn't in the example tests, so I'm okay with leaving it. Though maybe
> we could get rid of some of the asserts for the purpose of keeping the
> documentation focused and readable.

Sounds good!


>
>
> >  Allocating Memory
> >  -----------------
> >
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

