Return-Path: <linux-kselftest+bounces-38298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5F1B1B73C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015843B58F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDAC275B15;
	Tue,  5 Aug 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyGJnCnV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11856C8CE
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407067; cv=none; b=l9EVx2A2VdCf6o/TVoz9bojckPNNr7MGlFaLQE413uX0mMhyyUoaIpnFuoOfBivwH4HFeoew/wfoPTHdGwPK352o30zVwnX8RxagHzLHZep8AJU05+OCQFPkg9jItMjoXJRtImW8RBgqQsL9gbtdwESnoInuTf/lZxdSbkJ/Whw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407067; c=relaxed/simple;
	bh=4uTGqFw4J++VGhGxbRFCBduEWyWz/aIs8wS094wvPZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvMvqkfSnxii9Dx8iPzGvHRtRTpxRN2NyU5bcgo+XWwD+vyEnksFDfozbBYiRh4a8tpxL9t0WQYz80A2HxB+PVBBWhdYh0/sp3csQWp3/tWPwvCCjfkn3hRJSgX1a409YBUhhbaJq9wylLHFfXmTSUvVebf+Yxz76f0h4gwo/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IyGJnCnV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-707389a2fe3so55383506d6.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754407065; x=1755011865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IXs2Kr/JIndnkNpfZSfduZvVHbFnK3EtPg4aqdOsRc=;
        b=IyGJnCnVWr6LUH6Eq53gxZ69P7Bu1k6W1K43xwWrYr7hkj3PTVHlSIXy3mn1W3o7l/
         OFgQqGipejhfS8YGTv1gt5uEWive2pgm+8l4gOgUlyFY7AEtFye7OoiIBFuYehvDsu6Y
         9RC3mswKNLdXubMuBjufOcD2DPq4L5v/LrRxJRH//RWnZvdGrxs28CtPuid8t9/zbQME
         m4q49GRRE+PkXEr4PgHMO50iG/ZaTmca0yoPvKxeCKVJ2WcUV0vgvz8RLdJI4+f9gI+2
         f6KHK52VZwrWcBaq9VTphIEh5XecIjcy1DV27lEf4B1AxblI6MKemTOfdhTmCXnY5/Mr
         WDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407065; x=1755011865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IXs2Kr/JIndnkNpfZSfduZvVHbFnK3EtPg4aqdOsRc=;
        b=gYo9XcZ5i9ZsCmwU0UkacxlXXfcP++5CpEqBSGhmRPq2mZByc2/8RTUJXE4n9D7djL
         kJe6Phvt6IeNHZlwoFZN+V+nISObkLrZdTvkMdEnmB0b3isRgVY94gJpE7wXRfcz4B+Z
         zba9fViTq1Ex5XoAO2zQVtM5BZ2yQvwpn/kx9YO475pkXhbPJr+nxnTPHdCptkHTJmGG
         ERkpBo11bxYormLJbAWeN9ejbFeJZ5PTRr/zHkn5XvF/aR4/BYKJ9/3gpQtyVx+Ua88h
         hwvmAkmCvQW4YuIHZcIJl0i70FyW8LeczlmXDH6yPdC+303zmcxvwnRocbQnRqGuVIhq
         ezrA==
X-Forwarded-Encrypted: i=1; AJvYcCX+3rtODWKjGxz3CtmQmkqoy3ZMjaR/iMgbvorQclSuRU8bRAmM97AdMlVN9PYVDfEjlCHu04EKdkzxR8REuI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnsu9BGV5rl0A3Gycu0FfHjB2RAVL0gLBLZ3guZqVNoMETuE0
	sHemF6PeyLm6ZGuDLcbDA2wjIhhjK6UIAa3WkFUMn/z93ySB+kgsRViVrxe0cebQew2oWTM3ZyZ
	dJWtaoIgvBfKtR2ahM5oYWH35IGxsr/tsVTg1IJOI
X-Gm-Gg: ASbGncvjk6HNBYzgMwIL2oc/1ILJcz12E0pSQKOfFgwkotTTTvPlDzx/2KBmVqlLOFc
	niVYgKrLzCJ/P/5H3RIbzaQUyYI7qD8rMyhc9QZ18BcfpKPUJMBldMPY44F9FgYbMDnv29KuBb2
	FeVh4YonFXHppg9PvI5nd3WRSkrxMS1UEgxuZ4Xv4BLlNDpAIUGCcdXoKt6e0JnU3K9liX6RCTw
	XSw2qNGBH0Pm68PX+mU4huaO6NrhTMuheM6B3pXCw==
X-Google-Smtp-Source: AGHT+IHa9Nch2FIZBNvQFdt72fBtGdTNiWpLK+36OZqHE3rAqtd4pqYuQh8Gb7ugOeLVkjRMznl5Qph/PIQV3EAFD/c=
X-Received: by 2002:ad4:5765:0:b0:706:f753:6b1f with SMTP id
 6a1803df08f44-70935fb3038mr189139186d6.21.1754407064119; Tue, 05 Aug 2025
 08:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-2-marievic@google.com>
In-Reply-To: <20250729193647.3410634-2-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Aug 2025 11:17:33 -0400
X-Gm-Features: Ac12FXze3TaZ1ItJhvvsVg6J8U-v3wToEcNYmNz4bKxujCA6Thw0S4iJb4SdDqU
Message-ID: <CA+GJov4BQ1mRa-JaHoML+gF7rk=XY=hCRL+Shag6Aj6VbUgUeg@mail.gmail.com>
Subject: Re: [PATCH 1/9] kunit: Add parent kunit for parameterized test context
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
> Currently, KUnit parameterized tests lack a mechanism
> to share resources across individual test invocations
> because the same `struct kunit` instance is reused for
> each test.
>
> This patch refactors kunit_run_tests() to provide each
> parameterized test with its own `struct kunit` instance.
> A new parent pointer is added to `struct kunit`, allowing
> individual parameterized tests to reference a shared
> parent kunit instance. Resources added to this parent
> will then be accessible to all individual parameter
> test executions.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>

Hello!

Thank you so much for sending out this series. I have wanted to see an
update of our parameterized test framework for a while. I have a few
comments below for this patch. But otherwise it is looking good.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  include/kunit/test.h | 12 ++++++++++--
>  lib/kunit/test.c     | 32 +++++++++++++++++++-------------
>  2 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 39c768f87dc9..a42d0c8cb985 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -268,14 +268,22 @@ struct kunit_suite_set {
>   *
>   * @priv: for user to store arbitrary data. Commonly used to pass data
>   *       created in the init function (see &struct kunit_suite).
> + * @parent: for user to store data that they want to shared across
> + *         parameterized tests.
>   *

As David mentioned, I would also prefer that this provides a more
general description of the @parent field here. Although this is
currently only used for parameterized tests, it could have other use
cases in the future.

>   * Used to store information about the current context under which the t=
est
>   * is running. Most of this data is private and should only be accessed
> - * indirectly via public functions; the one exception is @priv which can=
 be
> - * used by the test writer to store arbitrary data.
> + * indirectly via public functions; the two exceptions are @priv and @pa=
rent
> + * which can be used by the test writer to store arbitrary data or data =
that is
> + * available to all parameter test executions, respectively.

In addition, I would prefer that the call out to @parent here is also
changed to a more general description of the @parent field. However,
feel free to also include the description of the use case for the
parameterized tests.

>   */
>  struct kunit {
>         void *priv;
> +       /*
> +        * Reference to the parent struct kunit for storing shared resour=
ces
> +        * during parameterized testing.
> +        */

I am more 50/50 on changing this description. Could change it just to:
"Reference to the parent struct kunit for storing shared resources."

> +       struct kunit *parent;
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f3c6b11f12b8..4d6a39eb2c80 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -647,6 +647,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>         struct kunit_case *test_case;
>         struct kunit_result_stats suite_stats =3D { 0 };
>         struct kunit_result_stats total_stats =3D { 0 };
> +       const void *curr_param;
>
>         /* Taint the kernel so we know we've run tests. */
>         add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
> @@ -679,36 +680,39 @@ int kunit_run_tests(struct kunit_suite *suite)
>                 } else {
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
> -                       test.param_value =3D test_case->generate_params(N=
ULL, param_desc);
> +                       /* TODO: Make generate_params try-catch */
> +                       curr_param =3D test_case->generate_params(NULL, p=
aram_desc);
>                         test_case->status =3D KUNIT_SKIPPED;
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "# Subtest: %s", test_case->name);
>
> -                       while (test.param_value) {
> -                               kunit_run_case_catch_errors(suite, test_c=
ase, &test);
> +                       while (curr_param) {
> +                               struct kunit param_test =3D {
> +                                       .param_value =3D curr_param,
> +                                       .param_index =3D ++test.param_ind=
ex,
> +                                       .parent =3D &test,
> +                               };
> +                               kunit_init_test(&param_test, test_case->n=
ame, test_case->log);
> +                               kunit_run_case_catch_errors(suite, test_c=
ase, &param_test);
>
>                                 if (param_desc[0] =3D=3D '\0') {
>                                         snprintf(param_desc, sizeof(param=
_desc),
>                                                  "param-%d", test.param_i=
ndex);

This probably doesn't matter too much either way but should this be
param_test.param_index instead? This would cover the case where the
param_index is changed during the test run even though it shouldn't.

>                                 }
>
> -                               kunit_print_ok_not_ok(&test, KUNIT_LEVEL_=
CASE_PARAM,
> -                                                     test.status,
> -                                                     test.param_index + =
1,
> +                               kunit_print_ok_not_ok(&param_test, KUNIT_=
LEVEL_CASE_PARAM,
> +                                                     param_test.status,
> +                                                     param_test.param_in=
dex,
>                                                       param_desc,
> -                                                     test.status_comment=
);
> +                                                     param_test.status_c=
omment);
>
> -                               kunit_update_stats(&param_stats, test.sta=
tus);
> +                               kunit_update_stats(&param_stats, param_te=
st.status);
>
>                                 /* Get next param. */
>                                 param_desc[0] =3D '\0';
> -                               test.param_value =3D test_case->generate_=
params(test.param_value, param_desc);
> -                               test.param_index++;
> -                               test.status =3D KUNIT_SUCCESS;
> -                               test.status_comment[0] =3D '\0';
> -                               test.priv =3D NULL;
> +                               curr_param =3D test_case->generate_params=
(curr_param, param_desc);
>                         }
>                 }
>
> @@ -723,6 +727,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 kunit_update_stats(&suite_stats, test_case->status);
>                 kunit_accumulate_stats(&total_stats, param_stats);
> +               /* TODO: Put this kunit_cleanup into a try-catch. */
> +               kunit_cleanup(&test);

I might be missing something here but why not do this cleanup before
the printing stage and only if the test was a parent param test?



>         }
>
>         if (suite->suite_exit)
> --
> 2.50.1.552.g942d659e1b-goog
>

