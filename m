Return-Path: <linux-kselftest+bounces-38304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA8B1B75E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3BA18A5C2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AE279DB6;
	Tue,  5 Aug 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVSA/M/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862227A13D
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407182; cv=none; b=eg1SsqhcjjQj96FblJ4CFCmfQ6BuKRmkPzUAX8bqHj1itDhCKQzA47eX+BFGNE+6mOQaioC6/0ZcxxGQkHqJnkgRcB+l6UWKzNlMMJGIw3MRX6eLvc/IsZG0pXEqj9ANraohgvVTT+BsUt4wMa1TkVcNOcH2MLFiKI4YkiutMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407182; c=relaxed/simple;
	bh=oSl/eSDDp8epMgXZfcVXCDKA7HJHPtbXoHqN/VossqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zuhhnkm/9r2i44Ul1a9A/+NDX6u6UStIC/WU/wmALOSINyjGmyuL8F8it3fPzhqD/YHVY7lkFzMJT7uLhFpBlxsliFPs2aNfEuZZBARPButrl75+EBQ0AUdQ9GPlBJQ5Ygq2WZ7lZvtJiKgCB1zDocO5QjXE4H989o2z6XkuClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVSA/M/z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4af21689d1dso24690351cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754407178; x=1755011978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/zN/Iw+mbc9m0aZ/VoboIauT8chB+SQVkzXgCKtaFY=;
        b=NVSA/M/zXHUKEjJIq3t/HNWdxh16yC5rjMTtFAggHYH6b6LAxK/6kk99PC0UHBB/gX
         FvnXwspp5zQ7VCpX01hzqhMbcz0H4q214dPUPk9a0GxEwUJwsu6/fmoAMu0gLdlflGRp
         pkSDSU6HxT/OQ8ry1ySAtYnYJwdNinRscsn+mOZYC6M7CcM7ESuMnsiQc/haEFZUc8vb
         Co2/Z5PLAt1c97pod4/C8x4iNwUFyWmiGU9TOHFqeoMK6RqJDOZ7G0dBLK3TELt2rsU2
         UBs0AzbT2CvL9NZhZzb4PfAimHyoz1+nz0mi8dvC/q+KUxsD9MqPFCUqn/HWBkJ9B9Lt
         W+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407178; x=1755011978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/zN/Iw+mbc9m0aZ/VoboIauT8chB+SQVkzXgCKtaFY=;
        b=E2l65DrxNHy2e41tMPOBe77TlitB7kmvnPKovHSyXWGgbRjnKWFccGT9kaA3h+IfCx
         BcO+P5IzVzhsdWZbrYXLVJ3p+d16E0QRGTS4Aa+wlkGnLv4hmppMANguqWDW0yMig6De
         bH1z5PXn5Nb3ooCbugVhF8nZDV4HuChWN4wxm2Tikz8/tovD75FPZ570x/IKcd2tefv4
         /2LfXo61u4DtUxjf+QUomTG/p9tiZjW548+1K0xKunS9fVZTylnnPMtV2T9QI61V2zkR
         SQ4gZ6i+/wltOFMLErKzCGFrZAiKOcXoYLUPfxusgO/k564q63NJ9IFlkeH2xlTjeOGs
         CFkw==
X-Forwarded-Encrypted: i=1; AJvYcCXXL4/mG08CWeWsk41wzpJzt2X7sUAM2B3ENZ/nW6y16b45dGiy7emdXsRbAdMeXugtj3dOH8RibdYKAm5iOB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+R1ynpswfitY530WzGeZo3nKycoWixYl9L2APZRwoiQO1zar
	PcCMerTxTQHvjK/6RYjAI50YsKOPPn/frR/THp8b0fTA9pnpv22lCDv5VepVKemwhPjdmP7Lh8b
	FiXjS2vuMeqRrgl/0TfyznwcYWjFjsWy4mCfoL2ac
X-Gm-Gg: ASbGncupy/kCBwQvXW2F2/G9VkZzWEEpFFOYjvfybjBBCXfMAQfn23EkEIHXf0PekYe
	1GXL9FgNjgRxOurNIduAJ2C6umXvfl0CuS/cXX3jP+tWzGu3aWzOHAy9Ai3K4W8WTENQiezMEWB
	NdIw8a47GAcyrZDewFnKq/YVpRobc+sZ7E0Q+ztzFxuJKgzUb5Vns6ct5FFWLrfKNgCBCuHkSmb
	SkxQNDZqEKtYcg27t5bzUqm+5MpkfSulyv0ghG2uQ==
X-Google-Smtp-Source: AGHT+IFMHqdOAH6YmPTnAKajVj2j+MN1mSgwqYyNrXklbX1NwGvfhUCPAKfc4uUw+kl62X6GgjvjuU7u8Xl18LPzagg=
X-Received: by 2002:a05:620a:a116:b0:7e6:38a8:bbd1 with SMTP id
 af79cd13be357-7e80ac4bb47mr585290385a.2.1754407177366; Tue, 05 Aug 2025
 08:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-10-marievic@google.com>
In-Reply-To: <20250729193647.3410634-10-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Aug 2025 11:19:26 -0400
X-Gm-Features: Ac12FXzb8E9oY6BCewcT9Ms7A5F3Fn9upcwWL-ZUIRDMMrjcR8bruiykdaRbHrg
Message-ID: <CA+GJov5q-mAHuchZNqS6DEv1zFmDzhF1SSdjBfJyB0ZnqUCQfg@mail.gmail.com>
Subject: Re: [PATCH 9/9] Documentation: kunit: Document new parameterized test features
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
> -Update the KUnit documentation to explain the concept
> of a parent parameterized test.
> -Add examples demonstrating different ways of passing
> parameters to parameterized tests and how to manage
> shared resources between them.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>

Hello!

This is amazing! I have a few comments below but I appreciate the
effort to document this new feature. It is always incredibly helpful
to have documentation to go along with the code.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  Documentation/dev-tools/kunit/usage.rst | 455 +++++++++++++++++++++++-
>  1 file changed, 449 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-=
tools/kunit/usage.rst
> index 066ecda1dd98..be1d656053cf 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -542,11 +542,21 @@ There is more boilerplate code involved, but it can=
:
>  Parameterized Testing
>  ~~~~~~~~~~~~~~~~~~~~~
>
> -The table-driven testing pattern is common enough that KUnit has special
> -support for it.
> -
> -By reusing the same ``cases`` array from above, we can write the test as=
 a
> -"parameterized test" with the following.
> +To efficiently and elegantly validate a test case against a variety of i=
nputs,
> +KUnit also provides a parameterized testing framework. This feature form=
alizes
> +and extends the concept of table-driven tests discussed previously, offe=
ring
> +a more integrated and flexible way to handle multiple test scenarios wit=
h
> +minimal code duplication.
> +
> +Passing Parameters to the Test Cases
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +There are three main ways to provide the parameters to a test case:
> +
> +Array Parameter Macros (``KUNIT_ARRAY_PARAM`` or ``KUNIT_ARRAY_PARAM_DES=
C``):
> +   KUnit provides special support for the common table-driven testing pa=
ttern.
> +   By applying either ``KUNIT_ARRAY_PARAM`` or ``KUNIT_ARRAY_PARAM_DESC`=
` to the
> +   ``cases`` array from the previous section, we can create a parameteri=
zed test
> +   as shown below:

Is it possible to bold the titles of the ways to pass in parameters:
Array Parameter Macros, etc.? I feel like they should stand out more
from the rest of the text. Also I think I would prefer if there was an
empty line between the title and the rest of the indented text, to
again further separate these titles from the rest of the text.

>
>  .. code-block:: c
>
> @@ -555,7 +565,7 @@ By reusing the same ``cases`` array from above, we ca=
n write the test as a
>                 const char *str;
>                 const char *sha1;
>         };
> -       const struct sha1_test_case cases[] =3D {
> +       static const struct sha1_test_case cases[] =3D {
>                 {
>                         .str =3D "hello world",
>                         .sha1 =3D "2aae6c35c94fcfb415dbe95f408b9ce91ee846=
ed",
> @@ -590,6 +600,439 @@ By reusing the same ``cases`` array from above, we =
can write the test as a
>                 {}
>         };
>
> +Custom Parameter Generator (``generate_params``):
> +   You can pass your own ``generate_params`` function to the ``KUNIT_CAS=
E_PARAM``
> +   or ``KUNIT_CASE_PARAM_WITH_INIT`` macros. This function is responsibl=
e for
> +   generating parameters one by one. It receives the previously generate=
d parameter
> +   as the ``prev`` argument (which is ``NULL`` on the first call) and ca=
n also
> +   access any context available from the parent ``struct kunit`` passed =
as the
> +   ``test`` argument. KUnit calls this function repeatedly until it retu=
rns
> +   ``NULL``. Below is an example of how it works:
> +
> +.. code-block:: c
> +
> +       #define MAX_TEST_BUFFER_SIZE 8
> +
> +       // Example generator function. It produces a sequence of buffer s=
izes that
> +       // are powers of two, starting at 1 (e.g., 1, 2, 4, 8).
> +       static const void *buffer_size_gen_params(struct kunit *test, con=
st void *prev, char *desc)
> +       {
> +               long prev_buffer_size =3D (long)prev;
> +               long next_buffer_size =3D 1; // Start with an initial siz=
e of 1.
> +
> +               // Stop generating parameters if the limit is reached or =
exceeded.
> +               if (prev_buffer_size >=3D MAX_TEST_BUFFER_SIZE)
> +                       return NULL;
> +
> +               // For subsequent calls, calculate the next size by doubl=
ing the previous one.
> +               if (prev)
> +                       next_buffer_size =3D prev_buffer_size << 1;
> +
> +               return (void *)next_buffer_size;
> +       }
> +
> +       // Simple test to validate that kunit_kzalloc provides zeroed mem=
ory.
> +       static void buffer_zero_test(struct kunit *test)
> +       {
> +               long buffer_size =3D (long)test->param_value;
> +               // Use kunit_kzalloc to allocate a zero-initialized buffe=
r. This makes the
> +               // memory "parameter managed," meaning it's automatically=
 cleaned up at
> +               // the end of each parameter execution.
> +               int *buf =3D kunit_kzalloc(test, buffer_size * sizeof(int=
), GFP_KERNEL);
> +
> +               // Ensure the allocation was successful.
> +               KUNIT_ASSERT_NOT_NULL(test, buf);
> +
> +               // Loop through the buffer and confirm every element is z=
ero.
> +               for (int i =3D 0; i < buffer_size; i++)
> +                       KUNIT_EXPECT_EQ(test, buf[i], 0);
> +       }
> +
> +       static struct kunit_case buffer_test_cases[] =3D {
> +               KUNIT_CASE_PARAM(buffer_zero_test, buffer_size_gen_params=
),
> +               {}
> +       };
> +
> +Direct Registration in Parameter Init Function (using ``kunit_register_p=
arams_array``):
> +   For more complex scenarios, you can directly register a parameter arr=
ay with
> +   a test case instead of using a ``generate_params`` function. This is =
done by
> +   passing the array to the ``kunit_register_params_array`` macro within=
 an
> +   initialization function for the parameterized test series
> +   (i.e., a function named ``param_init``). To better understand this me=
chanism
> +   please refer to the "Adding Shared Resources" section below.
> +
> +   This method supports both dynamically built and static arrays.
> +
> +   As the following code shows, the ``example_param_init_dynamic_arr`` f=
unction
> +   utilizes ``make_fibonacci_params`` to create a dynamic array, which i=
s then
> +   registered using ``kunit_register_params_array``. The corresponding e=
xit
> +   function, ``example_param_exit``, is responsible for freeing this dyn=
amically
> +   allocated params array after the parameterized test series ends.
> +
> +.. code-block:: c

As David mentioned, this example code is a bit long. I would also
prefer if this example had just the highlights and then a link to the
source code.

> +
> +       /*
> +        * Helper function to create a parameter array of Fibonacci numbe=
rs. This example
> +        * highlights a parameter generation scenario that is:
> +        * 1. Not feasible to fully pre-generate at compile time.
> +        * 2. Challenging to implement with a standard 'generate_params' =
function,
> +        * as it typically only provides the immediately 'prev' parameter=
, while
> +        * Fibonacci requires access to two preceding values for calculat=
ion.
> +        */
> +       static void *make_fibonacci_params(int seq_size)
> +       {
> +               int *seq;
> +
> +               if (seq_size <=3D 0)
> +                       return NULL;
> +
> +               seq =3D kmalloc_array(seq_size, sizeof(int), GFP_KERNEL);
> +
> +               if (!seq)
> +                       return NULL;
> +
> +               if (seq_size >=3D 1)
> +                       seq[0] =3D 0;
> +               if (seq_size >=3D 2)
> +                       seq[1] =3D 1;
> +               for (int i =3D 2; i < seq_size; i++)
> +                       seq[i] =3D seq[i - 1] + seq[i - 2];
> +               return seq;
> +       }
> +
> +       // This is an example of a function that provides a description f=
or each of the
> +       // parameters.
> +       static void example_param_dynamic_arr_get_desc(const void *p, cha=
r *desc)
> +       {
> +               const int *fib_num =3D p;
> +
> +               snprintf(desc, KUNIT_PARAM_DESC_SIZE, "fibonacci param: %=
d", *fib_num);
> +       }
> +
> +       // Example of a parameterized test init function that registers a=
 dynamic array.
> +       static int example_param_init_dynamic_arr(struct kunit *test)
> +       {
> +               int seq_size =3D 6;
> +               int *fibonacci_params =3D make_fibonacci_params(seq_size)=
;
> +
> +               if (!fibonacci_params)
> +                       return -ENOMEM;
> +
> +               /*
> +                * Passes the dynamic parameter array information to the =
parent struct kunit.
> +                * The array and its metadata will be stored in test->par=
ent->params_data.
> +                * The array itself will be located in params_data.params=
.
> +                */
> +               kunit_register_params_array(test, fibonacci_params, seq_s=
ize,
> +                                           example_param_dynamic_arr_get=
_desc);
> +               return 0;
> +       }
> +
> +       // Function to clean up the parameterized test's parent kunit str=
uct if
> +       // there were custom allocations.
> +       static void example_param_exit_dynamic_arr(struct kunit *test)
> +       {
> +               /*
> +                * We allocated this array, so we need to free it.
> +                * Since the parent parameter instance is passed here,
> +                * we can directly access the array via `test->params_dat=
a.params`
> +                * instead of `test->parent->params_data.params`.
> +                */
> +               kfree(test->params_data.params);
> +       }
> +
> +       /*
> +        * Example of test that uses the registered dynamic array to perf=
orm assertions
> +        * and expectations.
> +        */
> +       static void example_params_test_with_init_dynamic_arr(struct kuni=
t *test)
> +       {
> +               const int *param =3D test->param_value;
> +               int param_val;
> +
> +               /* By design, param pointer will not be NULL. */
> +               KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +               param_val =3D *param;
> +               KUNIT_EXPECT_EQ(test, param_val - param_val, 0);
> +       }
> +
> +       static struct kunit_case example_tests[] =3D {
> +               // The NULL here stands in for the generate_params functi=
on
> +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_=
dynamic_arr, NULL,
> +                                          example_param_init_dynamic_arr=
,
> +                                          example_param_exit_dynamic_arr=
),
> +               {}
> +       };
> +
> +
> +Adding Shared Resources
> +^^^^^^^^^^^^^^^^^^^^^^^
> +All parameterized test executions in this framework have a parent test o=
f type
> +``struct kunit``. This parent is not used to execute any test logic itse=
lf;
> +instead, it serves as a container for shared context that can be accesse=
d by
> +all its individual test executions (or parameters). Therefore, each indi=
vidual
> +test execution holds a pointer to this parent, accessible via a field na=
med
> +``parent``.
> +
> +It's possible to add resources to share between the individual test exec=
utions
> +within a parameterized test series by using the ``KUNIT_CASE_PARAM_WITH_=
INIT``
> +macro, to which you pass custom ``param_init`` and ``param_exit`` functi=
ons.
> +These functions run once before and once after the entire parameterized =
test
> +series, respectively. The ``param_init`` function can be used for adding=
 any
> +resources to the resources field of a parent test and also provide an ad=
ditional
> +way of setting the parameter array. The ``param_exit`` function can be u=
sed
> +release any resources that were not test managed i.e. not automatically =
cleaned
> +up after the test ends.
> +
> +.. note::
> +   If both a ``generate_params`` function is passed to ``KUNIT_CASE_PARA=
M_WITH_INIT``
> +   and an array is registered via ``kunit_register_params_array`` in
> +   ``param_init``, the ``generate_params`` function will be used to get
> +   the parameters.
> +
> +Both ``param_init`` and ``param_exit`` are passed the parent instance of=
 a test
> +(parent ``struct kunit``) behind the scenes. However, the test case func=
tion
> +receives the individual instance of a test for each parameter. Therefore=
, to
> +manage and access shared resources from within a test case function, you=
 must use
> +``test->parent``.
> +
> +.. note::
> +   The ``suite->init()`` function, which runs before each parameter exec=
ution,
> +   receives the individual instance of a test for each parameter. Theref=
ore,
> +   resources set up in ``suite->init()`` are reset for each individual
> +   parameterized test execution and are only visible within that specifi=
c test.
> +
> +For instance, finding a shared resource allocated by the Resource API re=
quires
> +passing ``test->parent`` to ``kunit_find_resource()``. This principle ex=
tends to
> +all other APIs that might be used in the test case function, including
> +``kunit_kzalloc()``, ``kunit_kmalloc_array()``, and others (see
> +Documentation/dev-tools/kunit/api/test.rst and the
> +Documentation/dev-tools/kunit/api/resource.rst).
> +
> +The code below shows how you can add the shared resources. Note that thi=
s code
> +utilizes the Resource API, which you can read more about here:
> +Documentation/dev-tools/kunit/api/resource.rst.

It would be nice if these references to the Documentation files were
actual links to the webpages. This would look something like -
":ref:`kunit-resource`" and then also labeling that section: "..
_kunit-resource:".

> +
> +.. code-block:: c
> +
> +       /* An example parameter array. */
> +       static const struct example_param {
> +               int value;
> +       } example_params_array[] =3D {
> +               { .value =3D 3, },
> +               { .value =3D 2, },
> +               { .value =3D 1, },
> +               { .value =3D 0, },
> +       };
> +
> +       /*
> +        * This custom function allocates memory for the kunit_resource d=
ata field.
> +        * The function is passed to kunit_alloc_resource() and executed =
once
> +        * by the internal helper __kunit_add_resource().
> +        */
> +       static int example_resource_init(struct kunit_resource *res, void=
 *context)
> +       {
> +               int *info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> +
> +               if (!info)
> +                       return -ENOMEM;
> +               *info =3D *(int *)context;
> +               res->data =3D info;
> +               return 0;
> +       }
> +
> +       /*
> +        * This function deallocates memory for the 'kunit_resource' data=
 field.
> +        * The function is passed to kunit_alloc_resource() and automatic=
ally
> +        * executes within kunit_release_resource() when the resource's r=
eference
> +        * count, via kunit_put_resource(), drops to zero. KUnit uses ref=
erence
> +        * counting to ensure that resources are not freed prematurely.
> +        */
> +       static void example_resource_free(struct kunit_resource *res)
> +       {
> +               kfree(res->data);
> +       }
> +
> +       /*
> +        * This match function is invoked by kunit_find_resource() to loc=
ate
> +        * a test resource based on defined criteria. The current example
> +        * uniquely identifies the resource by its free function; however=
,
> +        * alternative custom criteria can be implemented. Refer to
> +        * lib/kunit/platform.c and lib/kunit/static_stub.c for further e=
xamples.
> +        */
> +       static bool example_resource_alloc_match(struct kunit *test,
> +                                                struct kunit_resource *r=
es,
> +                                                void *match_data)
> +       {
> +               return res->data && res->free =3D=3D example_resource_fre=
e;
> +       }
> +
> +       /*
> +        * This is an example of a function that provides a description f=
or each of the
> +        * parameters.
> +       */
> +       static void example_param_array_get_desc(const void *p, char *des=
c)
> +       {
> +               const struct example_param *param =3D p;
> +
> +               snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> +                       "example check if %d is less than or equal to 3",=
 param->value);
> +       }
> +
> +       /*
> +        * Initializes the parent kunit struct for parameterized KUnit te=
sts.
> +        * This function enables sharing resources across all parameteriz=
ed
> +        * tests by adding them to the `parent` kunit test struct. It als=
o supports
> +        * registering either static or dynamic arrays of test parameters=
.
> +        */
> +       static int example_param_init(struct kunit *test)
> +       {
> +               int ctx =3D 3; /* Data to be stored. */
> +               int arr_size =3D ARRAY_SIZE(example_params_array);
> +
> +               /*
> +                * This allocates a struct kunit_resource, sets its data =
field to
> +                * ctx, and adds it to the kunit struct's resources list.=
 Note that
> +                * this is test managed so we don't need to have a custom=
 exit function
> +                * to free it.
> +                */
> +               void *data =3D kunit_alloc_resource(test, example_resourc=
e_init, example_resource_free,
> +                                                 GFP_KERNEL, &ctx);
> +
> +               if (!data)
> +                       return -ENOMEM;
> +               /* Pass the static param array information to the parent =
struct kunit. */
> +               kunit_register_params_array(test, example_params_array, a=
rr_size,
> +                                           example_param_array_get_desc)=
;
> +               return 0;
> +       }
> +
> +       /*
> +       * This is an example of a parameterized test that uses shared res=
ources
> +       * available from the struct kunit parent field of the kunit struc=
t.
> +       */
> +       static void example_params_test_with_init(struct kunit *test)
> +       {
> +               int threshold;
> +               struct kunit_resource *res;
> +               const struct example_param *param =3D test->param_value;
> +
> +               /* By design, param pointer will not be NULL. */
> +               KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +               /* Here we need to access the parent pointer of the test =
to find the shared resource. */
> +               res =3D kunit_find_resource(test->parent, example_resourc=
e_alloc_match, NULL);
> +
> +               KUNIT_ASSERT_NOT_NULL(test, res);
> +
> +               /* Since the data field in kunit_resource is a void point=
er we need to typecast it. */
> +               threshold =3D *((int *)res->data);
> +
> +               /* Assert that the parameter is less than or equal to a c=
ertain threshold. */
> +               KUNIT_ASSERT_LE(test, param->value, threshold);
> +
> +               /* This decreases the reference count after calling kunit=
_find_resource(). */
> +               kunit_put_resource(res);
> +       }
> +
> +
> +       static struct kunit_case example_tests[] =3D {
> +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init,=
 NULL,
> +                                          example_param_init, NULL),
> +               {}
> +       };
> +
> +As an alternative to using the KUnit Resource API for shared resources, =
you can
> +place them in ``test->parent->priv``. It can store data that needs to pe=
rsist
> +and be accessible across all executions within a parameterized test seri=
es.
> +
> +As stated previously ``param_init`` and ``param_exit`` receive the paren=
t
> +``struct kunit`` instance. So, you can directly use ``test->priv`` withi=
n them
> +to manage shared resources. However, from within the test case function,=
 you must
> +navigate up to the parent i.e. use ``test->parent->priv`` to access thos=
e same
> +resources.
> +
> +The resources placed in ``test->parent-priv`` will also need to be alloc=
ated in

Nit: I think this is a typo for test->parent->priv.



> +memory to persist across the parameterized tests executions. If memory i=
s
> +allocated using the memory allocation APIs provided by KUnit (described =
more in
> +the section below), you will not need to worry about deallocating them a=
s they
> +will be managed by the parent parameterized test that gets automatically=
 cleaned
> +up upon the end of the parameterized test series.
> +
> +The code below demonstrates example usage of the ``priv`` field for shar=
ed
> +resources:
> +
> +.. code-block:: c
> +
> +       /* An example parameter array. */
> +       static const struct example_param {
> +               int value;
> +       } example_params_array[] =3D {
> +               { .value =3D 3, },
> +               { .value =3D 2, },
> +               { .value =3D 1, },
> +               { .value =3D 0, },
> +       };
> +
> +       /*
> +        * Initializes the parent kunit struct for parameterized KUnit te=
sts.
> +        * This function enables sharing resources across all parameteriz=
ed
> +        * tests.
> +        */
> +       static int example_param_init_priv(struct kunit *test)
> +       {
> +               int ctx =3D 3; /* Data to be stored. */
> +               int arr_size =3D ARRAY_SIZE(example_params_array);
> +
> +               /*
> +                * Allocate memory using kunit_kzalloc(). Since the `para=
m_init`
> +                * function receives the parent instance of test, this me=
mory
> +                * allocation will be scoped to the lifetime of the whole
> +                * parameterized test series.
> +                */
> +               test->priv =3D kunit_kzalloc(test, sizeof(int), GFP_KERNE=
L);
> +
> +               /* Assign the context value to test->priv.*/
> +               *((int *)test->priv) =3D ctx;
> +
> +               /* Pass the static param array information to the parent =
struct kunit. */
> +               kunit_register_params_array(test, example_params_array, a=
rr_size, NULL);
> +               return 0;
> +       }
> +
> +       /*
> +       * This is an example of a parameterized test that uses shared res=
ources
> +       * available from the struct kunit parent field of the kunit struc=
t.
> +       */
> +       static void example_params_test_with_init_priv(struct kunit *test=
)
> +       {
> +               int threshold;
> +               const struct example_param *param =3D test->param_value;
> +
> +               /* By design, param pointer will not be NULL. */
> +               KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +               /* By design, test->parent will also not be NULL. */
> +               KUNIT_ASSERT_NOT_NULL(test, test->parent);
> +
> +               /* Assert that test->parent->priv has data. */
> +               KUNIT_ASSERT_NOT_NULL(test, test->parent->priv);
> +
> +               /* Here we need to use test->parent->priv to access the s=
hared resource. */
> +               threshold =3D *(int *)test->parent->priv;
> +
> +               /* Assert that the parameter is less than or equal to a c=
ertain threshold. */
> +               KUNIT_ASSERT_LE(test, param->value, threshold);
> +       }
> +
> +
> +       static struct kunit_case example_tests[] =3D {
> +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_=
priv, NULL,
> +                                          example_param_init_priv, NULL)=
,
> +               {}
> +       };
> +
>  Allocating Memory
>  -----------------
>
> --
> 2.50.1.552.g942d659e1b-goog
>

