Return-Path: <linux-kselftest+bounces-38806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD49B23BC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 00:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210725830BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76028850F;
	Tue, 12 Aug 2025 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGm8MuVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258F21CC5B
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037355; cv=none; b=dOKTfM7OH1xZoVQBigWB9VnYJMQ+o3sDxkozWiLDm0u1RNRDI/mtTMeVEjmRVG7QgBOp+h3PBNM78w3twEVjH2AI7MJhNS8g39aNQhhl9fF3RrNKcxyo00yC24sxzhtbGyZJznC3Esaraulu8U72R7nxPvF2itYObnnqHhTFy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037355; c=relaxed/simple;
	bh=3cP6tCGU9Omsi9P7w2WAaVQkBD9/rboAaxMY/TB8rJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnpPEGSKr6QwzaxznHMXrQ2eHGFmMbl7/4hqdsVClNRclvfRBTlvq3BSiruluKrhOzN+W5sAE8B50SApD7mzbSnepbXT74OxzVbmKGuo7DwssOjVZaYlOzdYme/ATj4kcER604pPRJ8izCPA382rZwg1PtGxptlIJixe4W0qBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGm8MuVs; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70884da4b55so62077466d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755037352; x=1755642152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opcJeE+7tPfMMHi8foMn39Eit1OmyT4Dsk8XguKPJ60=;
        b=nGm8MuVsiRM8C7mCQHwV4kWjILopeac23rJpymXHPipbnhN8C0vryKLYToUppmFx7C
         z8vMBsEkKAOPK812nivRiij8xc6mfuEqV5PFz+Pue/NWIVaBaR6j0guqQ6XD0uBMkkBb
         6E9q1zW+TEnf501XTczc++GAl8toHm9eUM4SIyWUtcFlrMBLpK6TGdaDQemUVmvvnIgc
         df5UjByAAdsI7DWbGEIVrwhVNG7IZunyorUQ4xM28UILrTd4CYWRVBeRwaiYZQjbZHnU
         tWFRb3//hkRRJ+8LFj3PW9UHNn33qsxoyZmhNemvWTLMZEVV+kvtLeShB1XJDqV8OfB9
         9xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037352; x=1755642152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opcJeE+7tPfMMHi8foMn39Eit1OmyT4Dsk8XguKPJ60=;
        b=RQpHbI75MTIvFNKPt9qjLcNPau9RrHa2LxJph7zXTeasgG6KGxB8Vyo1iJdWh3TNCq
         zZCMz8Xol7t1Tl6nHV3UCYGavT0gKNCowuDiaJiq0w8GMR3Q+m331+DKQa0ReAeZKC4S
         wQrvAwTLI2YaqU12QV/p2ozRQmoVFRcgGdJ4/eyUM4owCes0r+uNc23xBLUbcHCiS2Bx
         n2eIGsxNgQQE002edisGUA2gMtqFTkJnJIJj8EF8IVmEC6PQQUw8DrGGMz6iV33vLodw
         TmuqiMN/qiiX5dr4A5nIxmB21VwHJTRsqrC1skYWxmEvidr08yd2ZWDh1OZTRSJsCPt/
         1qMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnAHCfe9oxTToj2xXAybA9bGpNIUF1I92mDSj7mlt90+FdgxPjdtEChgGmSRCb4nMNv2c9qFfpasVij4zUd0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgv7nDanlWL06+Xf6mrf4exXY0ETMvrC2tHWFPyJKesxqr0is
	P6ECQdXOsGN+cIs1D9islvpk6ZQhTaI+VkKhpkkSjZaeB9QiOe0CIDqQ3vpTeWmg9vTsticJzJm
	JP7BmFClB8hvFXuZZlymcXs0WqOXo/gTphuHftGjF
X-Gm-Gg: ASbGncuxkx5/jBtk5WO4oVccr4Zl3M2azWPufEXprrRa1Eic70CugVGXynKD39udo+u
	LrgGB6vXY+9Kr1MeEXrpulKI/bm7HiAz7Tiw204rhmSgh9e44xQ3HHsjhiA/Jrd6Fd2hvDupBXB
	dtwqAlvMyq2feASmc8Uz6I3tSbCv8JePCgDdhaODs/k1E9KCKmZjJiS0KlQR/y84MawujHU/T3/
	MxElg==
X-Google-Smtp-Source: AGHT+IF10u+V+6ugaROze/dqCwMn9zJ3gAi07zy1b/fQ85QR35AUmm0vCptr5zWftPCDsCOQ7K1lmJXcG2tjBJlFL8Y=
X-Received: by 2002:ad4:4ee4:0:b0:709:995d:d4a8 with SMTP id
 6a1803df08f44-709e89fbe74mr11993096d6.45.1755037352008; Tue, 12 Aug 2025
 15:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-3-marievic@google.com>
In-Reply-To: <20250811221739.2694336-3-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 12 Aug 2025 18:22:20 -0400
X-Gm-Features: Ac12FXwV9IiY0435kgKra-rYAqebBZvna6EsVJ_KwFDNUaF3nei7y9HV2jQMX64
Message-ID: <CA+GJov6zSuMrPU3PLsdZofDw4Gegrqnp=gCxY5AOwZHtqB2cSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kunit: Introduce param_init/exit for parameterized
 test context management
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
> Add (*param_init) and (*param_exit) function pointers to
> `struct kunit_case`. Users will be able to set them
> via the new KUNIT_CASE_PARAM_WITH_INIT() macro.
>
> param_init/exit will be invoked by kunit_run_tests() once before
> and once after the parameterized test, respectively.
> They will receive the `struct kunit` that holds the parameterized
> test context; facilitating init and exit for shared state.
>
> This patch also sets param_init/exit to None in
> rust/kernel/kunit.rs.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---
>
> Changes in v2:
>
> - param init/exit were set to None
>   in rust/kernel/kunit.rs to fix the Rust breakage.
> - The name of __kunit_init_parent_test was
>   changed to kunit_init_parent_param_test and
>   its call was changed to happen only if the
>   test is parameterized.
> - The param_exit call was also moved inside
>   the check for if the test is parameterized.
> - KUNIT_CASE_PARAM_WITH_INIT() macro logic was changed
>   to not automatically set generate_params() to KUnit's
>   built-in generator function. Instead, the test user
>   will be asked to provide it themselves.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.

Hello!

This patch looks good to me. Thank you for fixing the Rust breakage! I
also appreciate the terminology changes here as well.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

>
> ---
>  include/kunit/test.h | 25 +++++++++++++++++++++++++
>  lib/kunit/test.c     | 20 ++++++++++++++++++++
>  rust/kernel/kunit.rs |  4 ++++
>  3 files changed, 49 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b47b9a3102f3..d2e1b986b161 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -92,6 +92,8 @@ struct kunit_attributes {
>   * @name:     the name of the test case.
>   * @generate_params: the generator function for parameterized tests.
>   * @attr:     the attributes associated with the test
> + * @param_init: The init function to run before a parameterized test.
> + * @param_exit: The exit function to run after a parameterized test.
>   *
>   * A test case is a function with the signature,
>   * ``void (*)(struct kunit *)``
> @@ -128,6 +130,8 @@ struct kunit_case {
>         const char *name;
>         const void* (*generate_params)(const void *prev, char *desc);
>         struct kunit_attributes attr;
> +       int (*param_init)(struct kunit *test);
> +       void (*param_exit)(struct kunit *test);
>
>         /* private: internal use only. */
>         enum kunit_status status;
> @@ -218,6 +222,27 @@ static inline char *kunit_status_to_ok_not_ok(enum k=
unit_status status)
>                   .generate_params =3D gen_params,                       =
         \
>                   .attr =3D attributes, .module_name =3D KBUILD_MODNAME}
>
> +/**
> + * KUNIT_CASE_PARAM_WITH_INIT - Define a parameterized KUnit test case w=
ith custom
> + * param_init() and param_exit() functions.
> + * @test_name: The function implementing the test case.
> + * @gen_params: The function to generate parameters for the test case.
> + * @init: A reference to the param_init() function to run before a param=
eterized test.
> + * @exit: A reference to the param_exit() function to run after a parame=
terized test.
> + *
> + * Provides the option to register param_init() and param_exit() functio=
ns.
> + * param_init/exit will be passed the parameterized test context and run=
 once
> + * before and once after the parameterized test. The init function can b=
e used
> + * to add resources to share between parameter runs, and any other setup=
 logic.
> + * The exit function can be used to clean up resources that were not man=
aged by
> + * the parameterized test, and any other teardown logic.
> + */
> +#define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit)   =
       \
> +               { .run_case =3D test_name, .name =3D #test_name,         =
           \
> +                 .generate_params =3D gen_params,                       =
         \
> +                 .param_init =3D init, .param_exit =3D exit,            =
           \
> +                 .module_name =3D KBUILD_MODNAME}
> +
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_=
case
>   *
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 14a8bd846939..49a5e6c30c86 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -641,6 +641,19 @@ static void kunit_accumulate_stats(struct kunit_resu=
lt_stats *total,
>         total->total +=3D add.total;
>  }
>
> +static void kunit_init_parent_param_test(struct kunit_case *test_case, s=
truct kunit *test)
> +{
> +       if (test_case->param_init) {
> +               int err =3D test_case->param_init(test);
> +
> +               if (err) {
> +                       kunit_err(test_case, KUNIT_SUBTEST_INDENT KUNIT_S=
UBTEST_INDENT
> +                               "# failed to initialize parent parameter =
test.");
> +                       test_case->status =3D KUNIT_FAILURE;
> +               }
> +       }
> +}
> +
>  int kunit_run_tests(struct kunit_suite *suite)
>  {
>         char param_desc[KUNIT_PARAM_DESC_SIZE];
> @@ -678,6 +691,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         kunit_run_case_catch_errors(suite, test_case, &te=
st);
>                         kunit_update_stats(&param_stats, test.status);
>                 } else {
> +                       kunit_init_parent_param_test(test_case, &test);
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
>                         /* TODO: Make generate_params try-catch */
> @@ -714,6 +728,12 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 param_desc[0] =3D '\0';
>                                 curr_param =3D test_case->generate_params=
(curr_param, param_desc);
>                         }
> +                       /*
> +                        * TODO: Put into a try catch. Since we don't nee=
d suite->exit
> +                        * for it we can't reuse kunit_try_run_cleanup fo=
r this yet.
> +                        */
> +                       if (test_case->param_exit)
> +                               test_case->param_exit(&test);
>                         /* TODO: Put this kunit_cleanup into a try-catch.=
 */
>                         kunit_cleanup(&test);
>                 }
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 4b8cdcb21e77..cda64574b44d 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -207,6 +207,8 @@ pub const fn kunit_case(
>          status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
>          module_name: core::ptr::null_mut(),
>          log: core::ptr::null_mut(),
> +        param_init: None,
> +        param_exit: None,
>      }
>  }
>
> @@ -226,6 +228,8 @@ pub const fn kunit_case_null() -> kernel::bindings::k=
unit_case {
>          status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
>          module_name: core::ptr::null_mut(),
>          log: core::ptr::null_mut(),
> +        param_init: None,
> +        param_exit: None,
>      }
>  }
>
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

