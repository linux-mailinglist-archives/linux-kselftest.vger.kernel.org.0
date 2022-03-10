Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420634D54E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 23:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbiCJWvi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 17:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344487AbiCJWvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 17:51:36 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DBEF744D
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:50:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so15308615eje.10
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6DiS3HvNB3XgupfAzrlzQDEfuL1+s8kw8SCCmZzvX8=;
        b=fpYxgk9RH2ab6hvmVb9/ov9lQ+JgBzr5TqAaihSEmiJ3D57s0jIjbcABmlkmovhSO2
         qD2xfiQl2FtTaWXnWEX9OwSJBDVIPAO+uVMyh1npheHkqAuxbNKTvTBjrY201Yxm2rbj
         1kv4UGFVHi9t0OITt44ijiJTvojiEKAZeM3VcBXUEO5r4VcM7BInDliaGemJkHw7cZ6W
         Rm0gLXSqRfegKgtJiooWXgiMrvZwEYK4ed4BWsGaTjH0Y1qRIAsXGURQYWrr/s8S/89i
         lK40eOrGfNViYgDwMOwDOK2eICeUaaldQjmdsFmbPxyczsq8ZtSTmAkXf4NGr+z1rYdE
         1gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6DiS3HvNB3XgupfAzrlzQDEfuL1+s8kw8SCCmZzvX8=;
        b=rwM/zsLj9a/OfRWKvIH4LAzRbi2bYZXZTiKklLhkreGGuIMivurL6YR4hOUhYgVrSh
         c0DNCtb3SfbR/NrjxIyEFIPOL4aLB9rzHsGt7dsnxf37xLgSQxwFiRPP3WSOfXkAkBaH
         Y1P9hvbo+K4V2vZPqvSZzEsYqAlSUTHOSNcci2wFjzi7qU7C7HpxN1K2AFrJQxX4BXPx
         vKdglkb48/C+fgl7zC+oHxvDmG+A6OwrTRccJu+r8uxgQkxOvzeAFCXLI20rCmFwvBk1
         NBSO9Ffz/U0bsvPFpsGm5MUsExOMQHxAGHLPRKSE49d4a0ESJ6WlIW/+VZ4bk2pe5xe6
         XR+A==
X-Gm-Message-State: AOAM530h1mMKb2R4ma2PBCr8QBWDACqjuf+QWJKiwWAvqmfJ6mhXkQcj
        T+hUzsliBHgS1BpDRPfUdlNrg4H1S+IljvHXM8193w==
X-Google-Smtp-Source: ABdhPJx2BrCirzf8BNqtiYRHq46BHPKGG9uryr6deERfMsnTN2xJl+L6XkTbCnHLms5mV0NxtFt+bbp7T5cVO4F0Ax0=
X-Received: by 2002:a17:906:2899:b0:6d6:e479:1fe2 with SMTP id
 o25-20020a170906289900b006d6e4791fe2mr6278183ejd.394.1646952633447; Thu, 10
 Mar 2022 14:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20220310210210.2124637-1-brendanhiggins@google.com> <CAFd5g46NmmNy5ueRjDnCkgjHy75KVUXA0xcTXtXjxLg7mgKJng@mail.gmail.com>
In-Reply-To: <CAFd5g46NmmNy5ueRjDnCkgjHy75KVUXA0xcTXtXjxLg7mgKJng@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 10 Mar 2022 17:50:22 -0500
Message-ID: <CAFd5g45MXXi_iBjJrTSUze-jjMXU18e4oN1Yo5Qg71wac6Uzjg@mail.gmail.com>
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init code
To:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Daniel Gutson <daniel.gutson@eclypsium.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Actually add Jeremy this time. Sorry for the spam.

On Thu, Mar 10, 2022 at 5:49 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> +Jeremy Kerr - Just remembered that Jeremy is doing some work here and
> might be somewhat interested.
>
> On Thu, Mar 10, 2022 at 4:02 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Add support for a new kind of kunit_suite registration macro called
> > kunit_test_init_suite(); this new registration macro allows the
> > registration of kunit_suites that reference functions marked __init and
> > data marked __initdata.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >
> > This patch is in response to a KUnit user issue[1] in which the user was
> > attempting to test some init functions; although this is a functional
> > solution as long as KUnit tests only run during the init phase, we will
> > need to do more work if we ever allow tests to run after the init phase
> > is over; it is for this reason that this patch adds a new registration
> > macro rather than simply modifying the existing macros.
> >
> > [1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
> >
> > ---
> >  include/kunit/test.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index b26400731c02..1878e585f6d3 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -379,6 +379,27 @@ static inline int kunit_run_all_tests(void)
> >
> >  #define kunit_test_suite(suite)        kunit_test_suites(&suite)
> >
> > +/**
> > + * kunit_test_init_suites() - used to register one or more &struct kunit_suite
> > + *                           containing init functions or init data.
> > + *
> > + * @__suites: a statically allocated list of &struct kunit_suite.
> > + *
> > + * This functions identically as &kunit_test_suites() except that it suppresses
> > + * modpost warnings for referencing functions marked __init or data marked
> > + * __initdata; this is OK because currently KUnit only runs tests upon boot
> > + * during the init phase or upon loading a module during the init phase.
> > + *
> > + * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after boot, these
> > + * tests must be excluded.
> > + */
> > +#define kunit_test_init_suites(__suites...)                            \
> > +       __kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),    \
> > +                           CONCATENATE(__UNIQUE_ID(suites), _probe),   \
> > +                           ##__suites)
> > +
> > +#define kunit_test_init_suite(suite)   kunit_test_init_suites(&suite)
> > +
> >  #define kunit_suite_for_each_test_case(suite, test_case)               \
> >         for (test_case = suite->test_cases; test_case->run_case; test_case++)
> >
> >
> > base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
> > --
> > 2.35.1.723.g4982287a31-goog
> >
