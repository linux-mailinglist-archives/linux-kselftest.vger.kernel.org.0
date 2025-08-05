Return-Path: <linux-kselftest+bounces-38303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B569B1B75B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC5C18A4CDF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A99D279DC5;
	Tue,  5 Aug 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzmh8U4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4B279DCF
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407171; cv=none; b=AgKXxTXiN73lbZWFKTlhTiKlYXjtFTrz8cdXeeYahh2U6s5pa3fJ64meVYI/aQOOXswHJD/gkdBJPA1In6XrtdvphsIx7IUE+Y3I5J4bp5aw6cHs7ee30ZbRs0alPIdi5vTzwtkZ39mvuWBg6d/IXp1gHVzzrEfrN7e3MSZx32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407171; c=relaxed/simple;
	bh=XDwVWyBsPzYs87Fct/ol9hNjk1XBJXy0uF6jx/zPqe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyA5PFvhNpGDjXToAydCk+Ag/BqvGDwzOFyEjV7M9Mfu/9JEp7iIz9EEymXAwdb/RxKu3fYSTEKyt4WglUa7qAqOEwDE4bxRUh5eiorQ34aPjpUv7Qle01ti1FAG3m3r5Ewr2VwyzBwEiZh6tCoPukCe72xXMuBOujoonLrWcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzmh8U4M; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4fc05b4a25eso3589597137.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754407168; x=1755011968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/M4EHqiBN5lPxOAQu9DhSS4CshVThGJ9tZazXfyjBo=;
        b=lzmh8U4MYX2cf/2iJmZ6NvoboGk2ysBgF9Ky49fJbsg50zfU0ZFZrNGMkuprQntQbk
         BFI40LxS01AWote3z8X7pvsQT+cMiK16XlMDxHoTKPBNh2BkFeMr5P8r/LjelOFZMItE
         IcuLyh8mmOdbuf2iF+6aRQlTKKVuoVpEn7pSgog30GA0QytPllNeIEaGigEn5nMxYxXy
         WJiLUU3ULhv4Pwxz4Ad0l2f/VyLa3M6D7fz8iA8ijDbe96fFPRrb0eaZd0YzmA0xUyqI
         QiL2nGfKoybbbLM6u+b3UjObL2P/m+YKUODk1WBwUsQvKTUqyLaxqdnNZR4AnzuoNdxE
         tMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407168; x=1755011968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/M4EHqiBN5lPxOAQu9DhSS4CshVThGJ9tZazXfyjBo=;
        b=Sfld5fR9j9aO3J9o8SLuBvCIiKr7ySFGX97JX2R7xEG+2q2JALAnT0CsCA/u9Oqs3k
         zy/5cBdUg4BKawRDBuEkyXnxsenP7pHiKDh+qpkZfCuMh3qTt/HuS78ha+985tJGgdHn
         VBKDmwwdnTCwAt2PJHuKNvap62XrMiL/ezEKFIq6vbTHMAaLL5ButVufT9xwG01c9Jvb
         Yes0kXO4d5ETLxs7Bm72Nu4wV0KbvJ0TLxxiZBxmEtNJPzf72W0y7zGFwdUMOxpHYd0T
         EJZVf9jptV+HErB9HgxHY+AhRLrNvwVcvVLNK225aTz3zDR++A660XKLJtU0g58iEjf+
         KYbw==
X-Forwarded-Encrypted: i=1; AJvYcCXCuE8ZYWt+/Rd8HhyhPwStVovbU2hTnZX5PUhKMnry5EDvAPx5oOGbGp+VHVZh+4s9yGBniN/uX9ehkr6bGD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5VK41hoBjpbGVkk/jg0YExFXGqjDLBRIYKhwTvQ5D7L0K5QA
	reSsj+RnzNo2AxtDNvBe/iShHl6V12kC78waGLVzR8QYvbbIK0Dp3XMgb1GqNAxb9wIFHrcCWr6
	7bDhIMdREAcBEXE3sal2Wie5THSxH7ge0pBlyY5tY
X-Gm-Gg: ASbGnct8oMSl2XTGl38akSvjR0nrJ0QmObILEXQitXXoZPbaaaRCuk2dWueKtPNw5kM
	TF5h0GxZXB8ouSeLFSpOmkRozOPl9aTLiiBGgE3KSIi9wctF4CubSogNBnR/DgUkivLzrSNe4/o
	K/oU4hMScw/g1qNqk2QBGA8EOl+iPZiba4RGGS6aHhumw5Lr9OAXuvPFuzRyL2FFHCfXYZ/pjY0
	Z0Hod+T0MB209GDPEEoom7iawtj8nrTA1ZEtVuSFw==
X-Google-Smtp-Source: AGHT+IHjJEw8sVdTHte54J+p7uJGtRguCx8AzAoiQ6fVM5yxU1E8YQ+6+xI4HY35yRy2zOsQxlr1JCh0pO85w5p+dko=
X-Received: by 2002:a05:6102:5ccb:b0:4e5:9380:9c20 with SMTP id
 ada2fe7eead31-4fdc1b4ebdbmr6328940137.2.1754407168016; Tue, 05 Aug 2025
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-9-marievic@google.com>
In-Reply-To: <20250729193647.3410634-9-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Aug 2025 11:19:16 -0400
X-Gm-Features: Ac12FXyMmUl4gu7cWRijQYgUuECjdwsoCyIrsthniHfiJ52BVbgwKDdOONRK8UA
Message-ID: <CA+GJov6Xcn_X8iDz9wQhpSo_O+v4DyaqYfW8heQ_+q-DxdOK9Q@mail.gmail.com>
Subject: Re: [PATCH 8/9] kunit: Add example parameterized test with direct
 dynamic parameter array setup
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
> Introduce `example_params_test_with_init_dynamic_arr`. This new
> KUnit test demonstrates directly assigning a dynamic parameter
> array using the `kunit_register_params_array` macro. It highlights the
> use of `param_init` and `param_exit` for proper initialization and
> cleanup, and their registration to the test with
> `KUNIT_CASE_PARAM_WITH_INIT`.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>

Hello!

This test is interesting and complex. I am very happy to see this test
accepted. I think it is a good demonstration of the new parameterized
test features.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
>  lib/kunit/kunit-example-test.c | 95 ++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index 5bf559e243f6..3ab121d81bf6 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -387,6 +387,98 @@ static void example_params_test_with_init(struct kun=
it *test)
>         kunit_put_resource(res);
>  }
>
> +/*
> + * Helper function to create a parameter array of Fibonacci numbers. Thi=
s example
> + * highlights a parameter generation scenario that is:
> + * 1. Not feasible to fully pre-generate at compile time.
> + * 2. Challenging to implement with a standard 'generate_params' functio=
n,
> + * as it typically only provides the immediately 'prev' parameter, while
> + * Fibonacci requires access to two preceding values for calculation.
> + */
> +static void *make_fibonacci_params(int seq_size)
> +{
> +       int *seq;
> +
> +       if (seq_size <=3D 0)
> +               return NULL;
> +
> +       seq =3D kmalloc_array(seq_size, sizeof(int), GFP_KERNEL);
> +
> +       if (!seq)
> +               return NULL;
> +
> +       if (seq_size >=3D 1)
> +               seq[0] =3D 0;
> +       if (seq_size >=3D 2)
> +               seq[1] =3D 1;
> +       for (int i =3D 2; i < seq_size; i++)
> +               seq[i] =3D seq[i - 1] + seq[i - 2];
> +       return seq;
> +}
> +
> +/*
> + * This is an example of a function that provides a description for each=
 of the
> + * parameters.
> + */
> +static void example_param_dynamic_arr_get_desc(const void *p, char *desc=
)
> +{
> +       const int *fib_num =3D p;
> +
> +       snprintf(desc, KUNIT_PARAM_DESC_SIZE, "fibonacci param: %d", *fib=
_num);
> +}
> +
> +/*
> + * Example of a parameterized test init function that registers a dynami=
c array.
> + */
> +static int example_param_init_dynamic_arr(struct kunit *test)
> +{
> +       int seq_size =3D 6;
> +       int *fibonacci_params =3D make_fibonacci_params(seq_size);
> +
> +       if (!fibonacci_params)
> +               return -ENOMEM;
> +
> +       /*
> +        * Passes the dynamic parameter array information to the parent s=
truct kunit.
> +        * The array and its metadata will be stored in test->parent->par=
ams_data.
> +        * The array itself will be located in params_data.params.
> +        */
> +       kunit_register_params_array(test, fibonacci_params, seq_size,
> +                                   example_param_dynamic_arr_get_desc);
> +       return 0;
> +}
> +
> +/**
> + * Function to clean up the parameterized test's parent kunit struct if
> + * there were custom allocations.
> + */
> +static void example_param_exit_dynamic_arr(struct kunit *test)
> +{
> +       /*
> +        * We allocated this array, so we need to free it.
> +        * Since the parent parameter instance is passed here,
> +        * we can directly access the array via `test->params_data.params=
`
> +        * instead of `test->parent->params_data.params`.
> +        */
> +       kfree(test->params_data.params);
> +}
> +
> +/*
> + * Example of test that uses the registered dynamic array to perform ass=
ertions
> + * and expectations.
> + */
> +static void example_params_test_with_init_dynamic_arr(struct kunit *test=
)
> +{
> +       const int *param =3D test->param_value;
> +       int param_val;
> +
> +       /* By design, param pointer will not be NULL. */
> +       KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +       param_val =3D *param;
> +       KUNIT_EXPECT_EQ(test, param_val - param_val, 0);
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test =
suite
>   * below.
> @@ -408,6 +500,9 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>         KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, NULL,
>                                    example_param_init, NULL),
> +       KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_dynamic_=
arr, NULL,
> +                                  example_param_init_dynamic_arr,
> +                                  example_param_exit_dynamic_arr),
>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.50.1.552.g942d659e1b-goog
>

