Return-Path: <linux-kselftest+bounces-15926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E695A6AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2611C227A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445217839D;
	Wed, 21 Aug 2024 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="db+ONrFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CE179658
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275951; cv=none; b=m21JEL++Websz5N/c3kdzrw15qKxlLA1FPPua0iP+wwoJGTXHkZHfnur5K5GQdQr0ZfxvG7+xxdDPS6cMxBFEVodqupZkljQraOo/nAswJMx2x1TCdQCWNgzmouS4o5D2hd+BdVxK+pjCIESpmKOJOB/bExnhuCgPNYeEnJXxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275951; c=relaxed/simple;
	bh=eJ4+2fadAs4LhGB7VCBf7v58+awWUPrBYNU9YXLxLsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFzwIQkSlMaCvXtK0ogE8VxL8B3t3Mmnw9NgopF0uL8HlvjXdZr1bAgOhOhQPEr9oRXkiwfh7SnXtpiQ+gwqzE9p4FJ78UFcyxziKPmbPpal2n87YiMLHIvj6KHGzzdjhoZY0Rrf1AmMwheOF2Rc8N9VZWeDSU7LRS9bYpo8Pd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=db+ONrFX; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84300e0ed69so55020241.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724275949; x=1724880749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEfHOpJkWSEaAoCDV0JorHBSnK0Xu4qT0YvqjlEfaBM=;
        b=db+ONrFXJ5cYZPHY7IFMc19fJXBxEgS5YjmHyn4NvsR/ltfwMqb7psv0dJOzVayeNp
         ytAl7dNi3B9a9qtrCs3B4nhw5TDFw1YxzNjNt+s2BINQyQOVcqB+2ep9X1mu0oZTaDyP
         nAUd5QhPDrpJRsAb9jpcx5e5lGSfNt1xJKNm/DNHrYDLg+qMIHof7bQqN7b0hDI/MSfC
         bA3MiIOOP6iEGNwNPjcuqGCJwmFVstL0W2X9DNaZymzCqSyHflC1aEduaTIe2xxmY5Vl
         0VNhsjkgYCZErgs8XD/D74a02HQwSKqSINsU9MVaoY2RvvcdmNZjaniTvJKrsc8DqGf5
         DcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275949; x=1724880749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEfHOpJkWSEaAoCDV0JorHBSnK0Xu4qT0YvqjlEfaBM=;
        b=Sf35C3RkgHrn2gZiKfXapNsEHRPFNnN0eNncLAYcNqEXZipvfnvNkobk5s/vQct1qm
         P/yVPHA77X9JMrh6TNu+qSfEjVIs4V8XxkPmeCYcjR+Lt0U8AkJrhV6FD+Uye3CRpiSH
         CrbEY9sWT3JfA7R+bVTRSUdcp+qScg7tsaoVJIfJ0CsPfU3hZLGuwOIV2kH2T0+v+SnN
         VFKxbNm8dQQzF33psEoUJuf2MJZEVuOODjewRXZQ3F8xHx38rZVI2g/Z2mzy1Z6LH/rD
         2qzbHKSd8iJOSsYxAH0ZKCmeOQye8rfzWzpS89A3NwgiNslq2FRpqivZnec+oTyhXaDO
         a3gg==
X-Gm-Message-State: AOJu0YzUIc32efCr7NQZvGta+a+PhMHukiqF3jcvZgmpbwdYMAUTIgos
	iuXvPXJKFikJtWE5IbvefKa38Avv0eaSt1J+EC0/HaJBjqOO3Tl+QbuMfIMCAN8SIiiyP04/fop
	7BOUdi79AktGqKMLlEy+0Ln4VGBsdNTyz4H+t
X-Google-Smtp-Source: AGHT+IHejLMDeOcYcUsf82hxqhRQiSa02jvpjvqyVxzerHPrFs5Ly9ER3r7vEyK9DtstFORwAUmj1wzesNyB01xMq1s=
X-Received: by 2002:a05:6102:c88:b0:48f:966c:eee3 with SMTP id
 ada2fe7eead31-498d2fc8f64mr5124058137.24.1724275948559; Wed, 21 Aug 2024
 14:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821144305.1958-1-michal.wajdeczko@intel.com> <20240821144305.1958-4-michal.wajdeczko@intel.com>
In-Reply-To: <20240821144305.1958-4-michal.wajdeczko@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 21 Aug 2024 17:32:16 -0400
Message-ID: <CA+GJov5yfiQJhcCKUfSX0+-z1w=gZ-LPMUyq3tcNUrSuKDTgeQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: Allow function redirection outside of the
 KUnit thread
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:43=E2=80=AFAM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
Hello!

This is looking good and seems to be working well. I just had some
questions below.

Thanks!
-Rae

> Currently, the 'static stub' API only allows function redirection
> for calls made from the kthread of the current test, which prevents
> the use of this functionalty when the tested code is also used by

A slight typo here: functionality

> other threads, outside of the KUnit test, like from the workqueue.
>
> Add another set of macros to allow redirection to the replacement
> functions, which, unlike the KUNIT_STATIC_STUB_REDIRECT, will
> affect all calls done during the test execution.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  include/kunit/static_stub.h | 80 +++++++++++++++++++++++++++++++++++++
>  lib/kunit/static_stub.c     | 21 ++++++++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
> index bf940322dfc0..3dd98c8f3f1f 100644
> --- a/include/kunit/static_stub.h
> +++ b/include/kunit/static_stub.h
> @@ -12,6 +12,7 @@
>
>  /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
>  #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0=
)
> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {} while (0)
>
>  #else
>
> @@ -109,5 +110,84 @@ void __kunit_activate_static_stub(struct kunit *test=
,
>   */
>  void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr=
);
>
> +/**
> + * KUNIT_FIXED_STUB_REDIRECT() - Call a fixed function stub if activated=
.
> + * @stub: The location of the function stub pointer
> + * @args: All of the arguments passed to this stub
> + *
> + * This is a function prologue which is used to allow calls to the curre=
nt
> + * function to be redirected if a KUnit is running. If the stub is NULL =
or
> + * the KUnit is not running the function will continue execution as norm=
al.
> + *
> + * The function stub pointer must be stored in a place that is accessibl=
e both
> + * from the test code that will activate this stub and from the function=
 where
> + * we will do the redirection.
> + *
> + * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
> + * even if the caller is not in a KUnit context (like a worker thread).
> + *
> + * Example:
> + *
> + * .. code-block:: c
> + *
> + *     static int (*func_stub)(int n);
> + *
> + *     int real_func(int n)
> + *     {
> + *             KUNIT_FIXED_STUB_REDIRECT(func_stub, n);
> + *             return n + 1;
> + *     }
> + *
> + *     int replacement_func(int n)
> + *     {
> + *             return n + 100;
> + *     }
> + *
> + *     void example_test(struct kunit *test)
> + *     {
> + *             KUNIT_EXPECT_EQ(test, real_func(1), 2);
> + *             func_stub =3D replacement_func;
> + *             KUNIT_EXPECT_EQ(test, real_func(1), 101);

I think we should model activating the stub here in the example to
make it a bit clearer.

> + *     }
> + */
> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {                   =
               \
> +       typeof(stub) replacement =3D (stub);                             =
                 \
> +       if (kunit_is_running()) {                                        =
               \
> +               if (unlikely(replacement)) {                             =
               \
> +                       pr_info(KUNIT_SUBTEST_INDENT "# %s: calling stub =
%ps\n",        \
> +                               __func__, replacement);                  =
               \
> +                       return replacement(args);                        =
               \
> +               }                                                        =
               \
> +       }                                                                =
               \
> +} while (0)
> +
> +void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, voi=
d *replacement_func);
> +
> +/**
> + * kunit_activate_fixed_stub() - Setup a fixed function stub.
> + * @test: Test case that wants to activate a fixed function stub
> + * @stub: The location of the function stub pointer
> + * @replacement: The replacement function
> + *
> + * This helper setups a function stub with the replacement function.
> + * It will also automatically restore stub to NULL at the test end.
> + */
> +#define kunit_activate_fixed_stub(test, stub, replacement) do {         =
                       \
> +       typecheck_pointer(stub);                                         =
               \
> +       typecheck_fn(typeof(stub), replacement);                         =
               \
> +       typeof(stub) *stub_ptr =3D &(stub);                              =
                 \
> +       __kunit_activate_fixed_stub((test), stub_ptr, (replacement));    =
               \
> +} while (0)
> +
> +/**
> + * kunit_deactivate_fixed_stub() - Disable a fixed function stub.
> + * @test: Test case that wants to deactivate a fixed function stub (unus=
ed for now)
> + * @stub: The location of the function stub pointer
> + */
> +#define kunit_deactivate_fixed_stub(test, stub) do {                    =
               \
> +       typecheck(struct kunit *, (test));                               =
               \
> +       (stub) =3D NULL;                                                 =
                 \
> +} while (0)
> +
>  #endif
>  #endif
> diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
> index 92b2cccd5e76..1b50cf457e89 100644
> --- a/lib/kunit/static_stub.c
> +++ b/lib/kunit/static_stub.c
> @@ -121,3 +121,24 @@ void __kunit_activate_static_stub(struct kunit *test=
,
>         }
>  }
>  EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
> +
> +static void nullify_stub_ptr(void *data)
> +{
> +       void **ptr =3D data;
> +
> +       *ptr =3D NULL;
> +}
> +
> +/*
> + * Helper function for kunit_activate_static_stub(). The macro does
> + * typechecking, so use it instead.
> + */
> +void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, voi=
d *replacement_func)
> +{
> +       void **stub =3D stub_ptr;
> +
> +       KUNIT_ASSERT_NOT_NULL(test, stub_ptr);

Should we check here if the replacement_func is null and if so
deactivate the stub similar to the static stubbing?

> +       *stub =3D replacement_func;

I do really appreciate this simplicity. But I wonder if David has any
thoughts on the security of direct replacement rather than using the
resource API?

> +       KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, nullify_=
stub_ptr, stub_ptr));
> +}
> +EXPORT_SYMBOL_GPL(__kunit_activate_fixed_stub);
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20240821144305.1958-4-michal.wajdeczko%40intel.com.

