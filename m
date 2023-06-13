Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF072ED20
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 22:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjFMUiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFMUiD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 16:38:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF6E0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:38:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so426a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686688680; x=1689280680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM0dD9HmZngFj+rHh9bzUnCqU30kIvbLIPJ4xkHbBX0=;
        b=gYEHffXt979nseqDhIp7OaRs37j7pHA/CAoeFu9/1JCgt/Gs/MEaYovjF7TsjryPz4
         xHQB9D6AhxD+qEyq2/58CjNEtV2bC1+HReT451YXnNUqDdi6519i/nS+GmI0n6aXKrLv
         az8KvDZEEmu1PlNjfLDTyaVSo7orbgFxj0dtvZ1bpePbcRxfOZiarRrb59GuuMysoui8
         UFvluFNExhtWY5gRw4+2U++bAobzCRoYaYNz49IKIECdMvzk+Uzv3xD9W5hLIpd/O9Kh
         xnbrfUTe7fBps8fn58d9e7Gk5q+UbXSkl46CUTbgAuYYBKyeg/BFRI476Vkzmn/YD9/S
         8rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688680; x=1689280680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM0dD9HmZngFj+rHh9bzUnCqU30kIvbLIPJ4xkHbBX0=;
        b=NOiRTFqJWhP7xtKfwsIA455+t5/6q6r7ni0uJHaBuCP3hZzO/Yx5ZHFQEje+KLnmgK
         XR0yyjJ+m+ntGxkjkdSaB+Q9EYUB0k26QeLcW/TjOeXFO/nQ2gVfNADOWbrie7ztmLX/
         FzRdLJfqabzT6IlqlV0YHOwxx8kKfpc/mzzCCDxEjHl6ogJ+wI6gMAkneUb/vjsGBxa8
         msBGStLEcY2bz1k/SuIfzi49xbDqGR5J/Fc6z4SUPJdTSx8VzfJi3uQO4ddDUTE5zG+f
         o0DT+O7VF6cJrgCv5kq3Hz9680jQMi1LoM9Qnob4X1RFRoC7Y5jiNQG0ZPOxtVu/+Usj
         ebxQ==
X-Gm-Message-State: AC+VfDwATIEaXOhc+69qqBeZOMn36tMntIsHb+Blz0ly2x6oQoXOwxRe
        UWWbUSlKPNGNxVpKcOt9/eSg/jwu9DBJ9wD8aT+F5g==
X-Google-Smtp-Source: ACHHUZ6Xp0QI5ZsiN4lliLv43uJ3wzAKKeZKRkYZpOB+L5Ls0016S4i3atSIvznsQLPdX28k7BkC1SJrJoWrfYsezFk=
X-Received: by 2002:a50:9ee3:0:b0:502:2af:7b1d with SMTP id
 a90-20020a509ee3000000b0050202af7b1dmr15359edf.3.1686688680354; Tue, 13 Jun
 2023 13:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-3-rmoar@google.com>
 <CABVgOS=4ioKpNOh-hPGEv70LSVwFh2SC0BL_dK1pWZR3pLwrtQ@mail.gmail.com>
In-Reply-To: <CABVgOS=4ioKpNOh-hPGEv70LSVwFh2SC0BL_dK1pWZR3pLwrtQ@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 13 Jun 2023 16:37:49 -0400
Message-ID: <CA+GJov5Uhxh8r=suXXjeGD7eHsnzo_Fu8+_w2UJRkw=jVYbnBA@mail.gmail.com>
Subject: Re: [RFC v1 2/6] kunit: Add speed attribute
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 10, 2023 at 4:29=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
> >
> > Add speed attribute to the test attribute API. This attribute will allo=
w
> > users to mark tests with a category of speed.
> >
> > Currently the categories of speed proposed are: fast, normal, slow, and
> > very_slow. These are outlined in the enum kunit_speed. Note the speed
> > attribute can also be left as unset and then, will act as the default w=
hich
> > is "normal", during filtering.
>
> Do we need both "fast" and "normal". KUnit tests are normally very
> fast: I'm not sure there's a way to make them faster enough to make a
> separate category here useful.
>

This is a really interesting discussion. I see your point here. I will
remove the "fast" category unless there are any objections.

> >
> > Note speed is intended to be marked based on relative speeds rather tha=
n
> > quantitative speeds of KUnit tests. This is because tests may run on
> > various architectures at different speeds.
>
> My rule of thumb here is that a test is slow if it takes more than a
> "trivial" amount of time (<1s), regardless of the machine it's running
> on.
>
> While the actual speed taken varies a lot (the time_test_cases take ~3
> seconds on most fast, modern machines, even under something like qemu,
> but ~15 minutes on an old 486), it's the idea that a test is doing
> some significant amount of work (loops over many thousands or millions
> of entries, etc) that pretty comfortably divides these into "normal"
> and "slow".
>
> Most tests run very, very quickly on even very slow systems, as all
> they're doing is checking the result of one or two trivial
> calculations or functions.

This seems like a great rule of thumb to add to the documentation.

>
> > Add the macro KUNIT_CASE_SLOW to set a test as slow, as this is likely =
a
> > common use of the attributes API.
>
> I'd ask if we need a KUNIT_CASE_VERY_SLOW() as well, but let's leave
> that until we have something which uses it.
>

I would be happy to add this once something uses the "very_slow" attribute.

>
> > Add an example of marking a slow test to kunit-example-test.c.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >  include/kunit/test.h           | 31 ++++++++++++++++++++++-
> >  lib/kunit/attributes.c         | 45 +++++++++++++++++++++++++++++++++-
> >  lib/kunit/kunit-example-test.c |  9 +++++++
> >  3 files changed, 83 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 1fc9155988e9..3d684723ae57 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -63,8 +63,26 @@ enum kunit_status {
> >         KUNIT_SKIPPED,
> >  };
> >
> > +/* Attribute struct/enum definitions */
> > +
> > +/*
> > + * Speed Attribute is stored as an enum and separated into categories =
of
> > + * speed: very_slowm, slow, normal, and fast. These speeds are relativ=
e
> > + * to other KUnit tests.
> > + */
> > +enum kunit_speed {
> > +       KUNIT_SPEED_UNSET,
> > +       KUNIT_SPEED_VERY_SLOW,
> > +       KUNIT_SPEED_SLOW,
> > +       KUNIT_SPEED_NORMAL,
> > +       KUNIT_SPEED_FAST,
> > +       KUNIT_SPEED_MAX =3D KUNIT_SPEED_FAST,
> > +};
>
> Question: Does it make sense to have these in this order: slow ->
> fast? I think it does ("speed>slow" seems more correct than
> "speed<slow"), but it'd be the other way round if we wanted to call
> this, e.g., size instead of speed.
>
> That being said, if it went the other way, we could rely on the fact
> that the default is fast, and not need a separate "unset" default...
>

Oh interesting. I hadn't considered changing the order. To me
"speed>slow" seems a bit more intuitive but I can see how "speed<slow"
would also make sense.  Hmm this is an interesting idea. Let me know
if anyone has an opinion here else I will most likely keep it this
order.

> > +
> >  /* Holds attributes for each test case and suite */
> > -struct kunit_attributes {};
> > +struct kunit_attributes {
> > +       enum kunit_speed speed;
> > +};
> >
> >  /**
> >   * struct kunit_case - represents an individual test case.
> > @@ -150,6 +168,17 @@ static inline char *kunit_status_to_ok_not_ok(enum=
 kunit_status status)
> >                 { .run_case =3D test_name, .name =3D #test_name,    \
> >                   .attr =3D attributes }
> >
> > +/**
> > + * KUNIT_CASE_SLOW - A helper for creating a &struct kunit_case
> > + * with the slow attribute
> > + *
> > + * @test_name: a reference to a test case function.
> > + */
> > +
> > +#define KUNIT_CASE_SLOW(test_name)                     \
> > +               { .run_case =3D test_name, .name =3D #test_name,    \
> > +                 .attr.speed =3D KUNIT_SPEED_SLOW }
> > +
> >  /**
> >   * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct ku=
nit_case
> >   *
> > diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> > index 0ea641be795f..e17889f94693 100644
> > --- a/lib/kunit/attributes.c
> > +++ b/lib/kunit/attributes.c
> > @@ -28,9 +28,52 @@ struct kunit_attr {
> >         void *attr_default;
> >  };
> >
> > +/* String Lists for enum Attributes */
> > +
> > +static const char * const speed_str_list[] =3D {"unset", "very_slow", =
"slow", "normal", "fast"};
> > +
> > +/* To String Methods */
> > +
> > +static const char *attr_enum_to_string(void *attr, const char * const =
str_list[], bool *to_free)
> > +{
> > +       long val =3D (long)attr;
> > +
> > +       *to_free =3D false;
> > +       if (!val)
> > +               return NULL;
> > +       return str_list[val];
> > +}
> > +
> > +static const char *attr_speed_to_string(void *attr, bool *to_free)
> > +{
> > +       return attr_enum_to_string(attr, speed_str_list, to_free);
> > +}
> > +
> > +/* Get Attribute Methods */
> > +
> > +static void *attr_speed_get(void *test_or_suite, bool is_test)
> > +{
> > +       struct kunit_suite *suite =3D is_test ? NULL : test_or_suite;
> > +       struct kunit_case *test =3D is_test ? test_or_suite : NULL;
> > +
> > +       if (test)
> > +               return ((void *) test->attr.speed);
> > +       else
> > +               return ((void *) suite->attr.speed);
> > +}
> > +
> > +/* Attribute Struct Definitions */
> > +
> > +static const struct kunit_attr speed_attr =3D {
> > +       .name =3D "speed",
> > +       .get_attr =3D attr_speed_get,
> > +       .to_string =3D attr_speed_to_string,
> > +       .attr_default =3D (void *)KUNIT_SPEED_NORMAL,
> > +};
> > +
> >  /* List of all Test Attributes */
> >
> > -static struct kunit_attr kunit_attr_list[1] =3D {};
> > +static struct kunit_attr kunit_attr_list[1] =3D {speed_attr};
>
> Nit: Can we remove the hardcoded [1] here, and let the compiler do this f=
or us?

Yes, I will change this out.

>
> >
> >  /* Helper Functions to Access Attributes */
> >
> > diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-t=
est.c
> > index b69b689ea850..01a769f35e1d 100644
> > --- a/lib/kunit/kunit-example-test.c
> > +++ b/lib/kunit/kunit-example-test.c
> > @@ -220,6 +220,14 @@ static void example_params_test(struct kunit *test=
)
> >         KUNIT_EXPECT_EQ(test, param->value % param->value, 0);
> >  }
> >
> > +/*
> > + * This test should always pass. Can be used to practice filtering att=
ributes.
> > + */
> > +static void example_slow_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, 1 + 1, 2);
> > +}
>
> Would we want to actually make this test slow? e.g. introduce a delay
> or a big loop or something.
> Probably not (I think it'd be more irritating than illuminating), but
> maybe worth thinking of.
>

I'm thinking not but it would make the concept clearer. I would
definitely change this if it is wanted.

Thanks!
-Rae


>
> > +
> >  /*
> >   * Here we make a list of all the test cases we want to add to the tes=
t suite
> >   * below.
> > @@ -237,6 +245,7 @@ static struct kunit_case example_test_cases[] =3D {
> >         KUNIT_CASE(example_all_expect_macros_test),
> >         KUNIT_CASE(example_static_stub_test),
> >         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> > +       KUNIT_CASE_SLOW(example_slow_test),
> >         {}
> >  };
> >
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
