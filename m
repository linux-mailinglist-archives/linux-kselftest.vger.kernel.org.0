Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693FB4F9BC5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 19:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiDHRgk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiDHRgd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 13:36:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44030AACAA
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 10:34:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bq8so18658898ejb.10
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n5q8/1C+/LCbS5CGbOTUmNklFZ3s8en/gT9RzZm5DDc=;
        b=RkdT3bAfCsYXfpYn3lLDYi0cSQYw5M7wL2Dtjp+OeAWeABPG+zU7s1FrQqWG3rEgIH
         2plHifG930QHOJt+6Db04vhR+Be4ww9DOKsmVfxE5mjk86shotqKwsriKGoJvX05nGFP
         9GywnNWyFrNXlD8QyRq/CdJw0XY7GLSxy2WxbWmZgO3OXS78uDYp+hpTz8E410y2KwRW
         oMFG/FkNVnvd4nNQeKSf4wQJspfWrRDDQpV9suKKvyOvGDJATYr+vh3NyonqtEl177T9
         g/wPvaSvxoG6SRXy8AxWT6uM3eJcIA8HAclf+ABYD54bJGBG/acxBZLDcwykZ33OOFsV
         hSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5q8/1C+/LCbS5CGbOTUmNklFZ3s8en/gT9RzZm5DDc=;
        b=qkGpQK0r0HeqyQPa5CCu4D0IR1WulyjsvRyJtSTO8nahb0Xwil2Kc8LrQF45WrPyTX
         /YOtuHQb5HbhhB1FltW2HjdKfPcOA0LWhQvEwI1ZRL1R7hd/rCV+CgxWrEWNw5g/8/Ef
         f4Xu/77QzQc2hcPoR5UraQhODJd6jO4eo0oFpDTcVK09SoTKBmeEG2VqJgszD5SlhnTK
         aJA+n+S9UOY2EEK134E84ViJsU+9aXXoIkn/9Psd5QIznz8vOND/8bSdrp+YGtQjp7n0
         U0dskSYAs9tg55aOK2yETGMmYvlqJHDbQaiBXXYGlJREyASt5i5+ZcId8h2OM0d+Qq3U
         p2nA==
X-Gm-Message-State: AOAM5311Aet2sqn7yUT8V6M+bxbqiQV7HJVA9ze/K4XR3ZdndQtwVIfY
        lLe99/lr5Itlirs61byA/i8I19mpAgmF/LizTLxrFw==
X-Google-Smtp-Source: ABdhPJxUdTTfOC8xk8IxPqBula9pbr5FFbrrkvwV/bYi8BkwLA/q8/uH+2yVpXjm2fATL/FjeejHnbxi3qwMFMHID80=
X-Received: by 2002:a17:907:d06:b0:6e0:e2f5:4f55 with SMTP id
 gn6-20020a1709070d0600b006e0e2f54f55mr20243918ejc.618.1649439265440; Fri, 08
 Apr 2022 10:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220311072859.2174624-1-brendanhiggins@google.com>
 <1e1472e8-1813-3903-f934-cb0ae7f09864@linuxfoundation.org>
 <CAFd5g46JiiddNxHW_jK6fjdfjGMjWsXsFuvL6H9xcZc98HWQyQ@mail.gmail.com> <CAKgze5bCf+v4PoS92XCDV2cD7d0iUvCvxHbPqAnLoW8pwoKbtQ@mail.gmail.com>
In-Reply-To: <CAKgze5bCf+v4PoS92XCDV2cD7d0iUvCvxHbPqAnLoW8pwoKbtQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 8 Apr 2022 13:34:12 -0400
Message-ID: <CAFd5g44nSfp=3A+VDCY6o-WzgDtnCw4NCChoXv_RKvmZc7Seog@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: add support for kunit_suites that reference
 init code
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        davidgow@google.com, dlatypov@google.com,
        daniel.gutson@eclypsium.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, jk@codeconstruct.com.au
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Apr 7, 2022 at 5:34 PM Martin Fernandez
<martin.fernandez@eclypsium.com> wrote:
>
> On 4/4/22, Brendan Higgins <brendanhiggins@google.com> wrote:
> > On Mon, Apr 4, 2022 at 6:37 PM Shuah Khan <skhan@linuxfoundation.org>
> > wrote:
> >>
> >> Hi Brendan,
> >>
> >> On 3/11/22 12:28 AM, Brendan Higgins wrote:
> >> > Add support for a new kind of kunit_suite registration macro called
> >> > kunit_test_init_suite(); this new registration macro allows the
> >> > registration of kunit_suites that reference functions marked __init and
> >> > data marked __initdata.
> >> >
> >> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >> > Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> >> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >> > Reviewed-by: David Gow <davidgow@google.com>
> >> > ---
> >> >
> >>
> >> I almost applied it ...
> >>
> >> > This is a follow-up to the RFC here[1].
> >> >
> >> > This patch is in response to a KUnit user issue[2] in which the user
> >> > was
> >> > attempting to test some init functions; although this is a functional
> >> > solution as long as KUnit tests only run during the init phase, we will
> >> > need to do more work if we ever allow tests to run after the init phase
> >> > is over; it is for this reason that this patch adds a new registration
> >> > macro rather than simply modifying the existing macros.
> >> >
> >> > Changes since last version:
> >> >   - I added more to the kunit_test_init_suites() kernel-doc comment
> >> >     detailing "how" the modpost warnings are suppressed in addition to
> >> >     the existing information regarding "why" it is OK for the modpost
> >> >     warnings to be suppressed.
> >> >
> >> > [1]
> >> > https://lore.kernel.org/linux-kselftest/20220310210210.2124637-1-brendanhiggins@google.com/
> >> > [2] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
> >> >
> >> > ---
> >> >   include/kunit/test.h | 26 ++++++++++++++++++++++++++
> >> >   1 file changed, 26 insertions(+)
> >> >
> >> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> >> > index b26400731c02..7f303a06bc97 100644
> >> > --- a/include/kunit/test.h
> >> > +++ b/include/kunit/test.h
> >> > @@ -379,6 +379,32 @@ static inline int kunit_run_all_tests(void)
> >> >
> >> >   #define kunit_test_suite(suite)     kunit_test_suites(&suite)
> >> >
> >> > +/**
> >> > + * kunit_test_init_suites() - used to register one or more &struct
> >> > kunit_suite
> >> > + *                         containing init functions or init data.
> >> > + *
> >> > + * @__suites: a statically allocated list of &struct kunit_suite.
> >> > + *
> >> > + * This functions identically as &kunit_test_suites() except that it
> >> > suppresses
> >> > + * modpost warnings for referencing functions marked __init or data
> >> > marked
> >> > + * __initdata; this is OK because currently KUnit only runs tests upon
> >> > boot
> >> > + * during the init phase or upon loading a module during the init
> >> > phase.
> >> > + *
> >> > + * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after
> >> > boot, these
> >> > + * tests must be excluded.
> >> > + *
> >> > + * The only thing this macro does that's different from
> >> > kunit_test_suites is
> >> > + * that it suffixes the array and suite declarations it makes with
> >> > _probe;
> >> > + * modpost suppresses warnings about referencing init data for symbols
> >> > named in
> >> > + * this manner.
> >> > + */
> >> > +#define kunit_test_init_suites(__suites...)                          \
> >> > +     __kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),    \
> >> > +                         CONCATENATE(__UNIQUE_ID(suites), _probe),   \
> >> > +                         ##__suites)
> >> > +
> >> > +#define kunit_test_init_suite(suite) kunit_test_init_suites(&suite)
> >> > +
> >> >   #define kunit_suite_for_each_test_case(suite, test_case)            \
> >> >       for (test_case = suite->test_cases; test_case->run_case;
> >> > test_case++)
> >> >
> >> >
> >>
> >> The naming of the function and macro are rather confusing and can become
> >> error prone. Let's find better naming scheme.
> >
> > Yeah, I wasn't sure about the name. I didn't have any better ideas
> > initially though. Any suggestions?
> >
>
> What about kunit_test_init_section_suite?

Sounds fine to me. Shuah, does that sound OK to you?

> >> > base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
> >> >
> >>
> >> thanks,
> >> -- Shuah
> >
