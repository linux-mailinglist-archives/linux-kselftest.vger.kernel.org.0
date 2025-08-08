Return-Path: <linux-kselftest+bounces-38555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3EB1E837
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E513B582797
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BAB277029;
	Fri,  8 Aug 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMB42hKl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F55275B17
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655639; cv=none; b=JoZWzCAzfMIjKmN7aMG5xKJTyVw+psV0YbbVWc1QPH5eqeq1ny1RPRv3/XucAwIENKJSutT4fhLTOMSOX3GHMX+s7eTCuT9JX1xwMBcqJCKi3j3RJDEpdNBHxFiryUvSxHUcytG5Zx0EzLKK7crV0yb78T3DcWX7H+7MZjvKyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655639; c=relaxed/simple;
	bh=d/HSvy18/PzpVXX8m8PFtvvfHgZD6mp8P9B6y9ruRS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5ACGzBdF+TZcABq3jHG5yCpVFJteYCZNdcgITpq2poHcPacGubmpOkmHYrsJZGpGaa89t4IYzQdjqsmirbayiK4YCFi/Aokr+B9SHomMgw6KvjDVrFHWEZg9i7pVCpzpX0PiH60qIzZrWvJUPLrjkZkkbdldgs46Vq0/8Ad8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TMB42hKl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso7869a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Aug 2025 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754655634; x=1755260434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rzYVptOKE6RcZ0qvjvmsPnga1215NKTSv+ot9kbgm8=;
        b=TMB42hKlSxywBDWCtomYtx+3BAEn++e/9EH//w5NhDkzOLk/PShUFSIqWRjwI5uKi/
         Hc/fR9dz5Q7iR9VC1qlp2UXCU9FnNVBczck8mVhVO5rGO02DZKSNwO1PTUx+THsQ/NxR
         Z3DGdxE7E/u97GrzUVAFtupsmcqH9eZ1uKQcu4Uh2dnNhNsjwMP9+DHfxMsVxhQy2mZx
         otyNuQovP6Vgw+sY7RWKNZlpxy1ZjBf6ZGoYpE7Gq3LRHPxRAEu4q7ZQt7mYleK8Tfh0
         JBXVPLyy+NlpqWhB8S5PWN/ZbztjTlkOtJZHSJMBfJhKEw1nyHzEzcYsG4/o+rHxYIYv
         tufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754655634; x=1755260434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rzYVptOKE6RcZ0qvjvmsPnga1215NKTSv+ot9kbgm8=;
        b=ElmIr/wCjmlZADq0ORQwrsOed1VPue5chkBNyF28S2F57L49AqNxEZcVTM4Y4pSeHU
         +n6kDJeAz0YiNzhSZ6jpeF33X5ps9Z5zCDxsmfASOesr5AisrO1iORivUlQwoG8JwUPi
         WjhftkC/7MMfC3caip8FGUz4oEV2zCj4nJq0YJAaMzBqY+SDShLLcOQ2gGk8UTJaYEc8
         Bc8ViXsGHUKNRRr6lVHMZm/B6oM0HIys1/CrFjyjzX9Fu5GbMkKclADas2LcDbwfA9iM
         UsL+9spGbTcfJQbHmVh+ZeQCKyR4cISLZO+vT7G6vKlsA+2u7deZAPeucLR0WVSG3cCb
         Zcag==
X-Forwarded-Encrypted: i=1; AJvYcCWPVRXSrGfgN/iGIUZTM1SKab/WxDNxHboW+IBA3PuXcXB9cJG7F9z7TV1D/AU/aJq0XMZrOTgCtxe9rLG0tYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMp24rYMpxDHyxrW+DWRBV5qpZnFyIbM0t/NdLUoNXO9STcZZ
	LEqVYr9sJvtnSujSdWPMNNDsUg8y95PK6K/HK3ajH7RiaqAJPCvEBRbGzmjE2FWEn+O9wYI5aa9
	LoHUqnNnV9ZDRcMA3FCZWa8OTTm9ZyB6xvlgIAzKz
X-Gm-Gg: ASbGncvi28EGKDLqyWK7FQKeB+gKd+4folG+5ufibSxYBQvm1Ny7QlaXbNEfa0Y4lul
	yOi7cIteg0wenVTUu6Tx/xgO/m6cCii5WUduy0aa6alStazmmEahkEzFBMM+Q8YpRAtkk+iVtVm
	z+viylwSZ2ovrUYf8vX5vJUsh1Auwd5LQ0BzQt3sCc+CD4tQDm4OaE1wrrd7m1OkqTyd3j850B0
	9TKRJIP
X-Google-Smtp-Source: AGHT+IG4063AzftLr2nNg6LP2eisixxrOm1cn9iuvLVn3oLVwkWGVefZC3UWEn6Yr/d0q/zLPSnZ+hF/HN7uvjRhvSY=
X-Received: by 2002:a50:9351:0:b0:615:60d2:c013 with SMTP id
 4fb4d7f45d1cf-617e48ffd8cmr60281a12.3.1754655633629; Fri, 08 Aug 2025
 05:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-2-marievic@google.com>
 <CA+GJov4BQ1mRa-JaHoML+gF7rk=XY=hCRL+Shag6Aj6VbUgUeg@mail.gmail.com>
In-Reply-To: <CA+GJov4BQ1mRa-JaHoML+gF7rk=XY=hCRL+Shag6Aj6VbUgUeg@mail.gmail.com>
From: Marie Zhussupova <marievic@google.com>
Date: Fri, 8 Aug 2025 08:20:20 -0400
X-Gm-Features: Ac12FXxk_i-p3y5IMbqA_cUeg1wd-aJHm01gFGsskeUDN6bJI53lY7PD-TwOzYw
Message-ID: <CAAkQn5JNmbuv=nj3Z5hDQNE0sAzrRNE_rJXrZVN4EqUDikV9=Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] kunit: Add parent kunit for parameterized test context
To: Rae Moar <rmoar@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 11:17=E2=80=AFAM Rae Moar <rmoar@google.com> wrote:
>
> On Tue, Jul 29, 2025 at 3:37=E2=80=AFPM Marie Zhussupova <marievic@google=
.com> wrote:
> >
> > Currently, KUnit parameterized tests lack a mechanism
> > to share resources across individual test invocations
> > because the same `struct kunit` instance is reused for
> > each test.
> >
> > This patch refactors kunit_run_tests() to provide each
> > parameterized test with its own `struct kunit` instance.
> > A new parent pointer is added to `struct kunit`, allowing
> > individual parameterized tests to reference a shared
> > parent kunit instance. Resources added to this parent
> > will then be accessible to all individual parameter
> > test executions.
> >
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
>
> Hello!
>
> Thank you so much for sending out this series. I have wanted to see an
> update of our parameterized test framework for a while. I have a few
> comments below for this patch. But otherwise it is looking good.
>
> Reviewed-by: Rae Moar <rmoar@google.com>
>
> Thanks!
> -Rae
>
> > ---
> >  include/kunit/test.h | 12 ++++++++++--
> >  lib/kunit/test.c     | 32 +++++++++++++++++++-------------
> >  2 files changed, 29 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 39c768f87dc9..a42d0c8cb985 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -268,14 +268,22 @@ struct kunit_suite_set {
> >   *
> >   * @priv: for user to store arbitrary data. Commonly used to pass data
> >   *       created in the init function (see &struct kunit_suite).
> > + * @parent: for user to store data that they want to shared across
> > + *         parameterized tests.
> >   *
>
> As David mentioned, I would also prefer that this provides a more
> general description of the @parent field here. Although this is
> currently only used for parameterized tests, it could have other use
> cases in the future.
>

Will edit this in v2.

> >   * Used to store information about the current context under which the=
 test
> >   * is running. Most of this data is private and should only be accesse=
d
> > - * indirectly via public functions; the one exception is @priv which c=
an be
> > - * used by the test writer to store arbitrary data.
> > + * indirectly via public functions; the two exceptions are @priv and @=
parent
> > + * which can be used by the test writer to store arbitrary data or dat=
a that is
> > + * available to all parameter test executions, respectively.
>
> In addition, I would prefer that the call out to @parent here is also
> changed to a more general description of the @parent field. However,
> feel free to also include the description of the use case for the
> parameterized tests.
>

I will edit this in v2, as well.

> >   */
> >  struct kunit {
> >         void *priv;
> > +       /*
> > +        * Reference to the parent struct kunit for storing shared reso=
urces
> > +        * during parameterized testing.
> > +        */
>
> I am more 50/50 on changing this description. Could change it just to:
> "Reference to the parent struct kunit for storing shared resources."

Thank you for the suggestion! The description would sound good.

>
> > +       struct kunit *parent;
> >
> >         /* private: internal use only. */
> >         const char *name; /* Read only after initialization! */
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index f3c6b11f12b8..4d6a39eb2c80 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -647,6 +647,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> >         struct kunit_case *test_case;
> >         struct kunit_result_stats suite_stats =3D { 0 };
> >         struct kunit_result_stats total_stats =3D { 0 };
> > +       const void *curr_param;
> >
> >         /* Taint the kernel so we know we've run tests. */
> >         add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
> > @@ -679,36 +680,39 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                 } else {
> >                         /* Get initial param. */
> >                         param_desc[0] =3D '\0';
> > -                       test.param_value =3D test_case->generate_params=
(NULL, param_desc);
> > +                       /* TODO: Make generate_params try-catch */
> > +                       curr_param =3D test_case->generate_params(NULL,=
 param_desc);
> >                         test_case->status =3D KUNIT_SKIPPED;
> >                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDEN=
T KUNIT_SUBTEST_INDENT
> >                                   "KTAP version 1\n");
> >                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDEN=
T KUNIT_SUBTEST_INDENT
> >                                   "# Subtest: %s", test_case->name);
> >
> > -                       while (test.param_value) {
> > -                               kunit_run_case_catch_errors(suite, test=
_case, &test);
> > +                       while (curr_param) {
> > +                               struct kunit param_test =3D {
> > +                                       .param_value =3D curr_param,
> > +                                       .param_index =3D ++test.param_i=
ndex,
> > +                                       .parent =3D &test,
> > +                               };
> > +                               kunit_init_test(&param_test, test_case-=
>name, test_case->log);
> > +                               kunit_run_case_catch_errors(suite, test=
_case, &param_test);
> >
> >                                 if (param_desc[0] =3D=3D '\0') {
> >                                         snprintf(param_desc, sizeof(par=
am_desc),
> >                                                  "param-%d", test.param=
_index);
>
> This probably doesn't matter too much either way but should this be
> param_test.param_index instead? This would cover the case where the
> param_index is changed during the test run even though it shouldn't.
>

Thank you for catching this!

> >                                 }
> >
> > -                               kunit_print_ok_not_ok(&test, KUNIT_LEVE=
L_CASE_PARAM,
> > -                                                     test.status,
> > -                                                     test.param_index =
+ 1,
> > +                               kunit_print_ok_not_ok(&param_test, KUNI=
T_LEVEL_CASE_PARAM,
> > +                                                     param_test.status=
,
> > +                                                     param_test.param_=
index,
> >                                                       param_desc,
> > -                                                     test.status_comme=
nt);
> > +                                                     param_test.status=
_comment);
> >
> > -                               kunit_update_stats(&param_stats, test.s=
tatus);
> > +                               kunit_update_stats(&param_stats, param_=
test.status);
> >
> >                                 /* Get next param. */
> >                                 param_desc[0] =3D '\0';
> > -                               test.param_value =3D test_case->generat=
e_params(test.param_value, param_desc);
> > -                               test.param_index++;
> > -                               test.status =3D KUNIT_SUCCESS;
> > -                               test.status_comment[0] =3D '\0';
> > -                               test.priv =3D NULL;
> > +                               curr_param =3D test_case->generate_para=
ms(curr_param, param_desc);
> >                         }
> >                 }
> >
> > @@ -723,6 +727,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> >
> >                 kunit_update_stats(&suite_stats, test_case->status);
> >                 kunit_accumulate_stats(&total_stats, param_stats);
> > +               /* TODO: Put this kunit_cleanup into a try-catch. */
> > +               kunit_cleanup(&test);
>
> I might be missing something here but why not do this cleanup before
> the printing stage and only if the test was a parent param test?
>

Thank you for catching this too, it should be only for the parent param tes=
t.

>
>
> >         }
> >
> >         if (suite->suite_exit)
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

