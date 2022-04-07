Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284534F89A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 00:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiDGVhB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiDGVhA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 17:37:00 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215FA1A1281
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 14:34:59 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id x21so11857861ybd.6
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yaGos3SERrC2jdiQiJ/85vABo3kZeiwvqRtqI7sWR/o=;
        b=UnoHu1EK+12NpKKA6uHxlvH9RUZbPSgYKriZSpsoZk125w5ipGaiJ7sTtSTGJbeMdp
         Di350AKk06PeKhYE+MJWSKTJDYk4A7TfEFWKJ92lqYXLXG0/bkkDCtMSY4ru7ns8Cs30
         0NIEgnHab0r5/k/hTOZPAKpTGMTGQGQyTK33Uukp8gs2IzZlnPz6LrjMGmCnCqLwUZ25
         18itwsp3ELXHwK29xjTTLEMg8uzfg7NH4o8JLk0FisLvmB12XKsQ7g2lpr3Ncu5s+INw
         N+bbiivMFNquAbOtNEkdbNn0yw4WP/NnDLWLnUCQIm4OAwysRaQ56esx+QbJW1tI3C1l
         7+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yaGos3SERrC2jdiQiJ/85vABo3kZeiwvqRtqI7sWR/o=;
        b=kY2qrK0ys10GW7tAYEqFIuUFvSoOU07tt/1Aq1B2BKtgmkxpeLFI0la59E/foiZbV2
         a8KPT5CjScYdZ4IBZ/ZU+cRkcxOxvV/TxjVnEVoukjpKSgWg4kSPj4xeiL8Nwg70CCQp
         inwXwm8gpIRgeL4OeyBBPZ25NSnNuwtdRXJ1AsUQcecAhswg+cU48aiH9uC2QH0h6yVi
         tT+78Q1U3scOWvV5wdw4esq+Bnh12xp9AtgH8MqLxU5ufnt7sod5r18M70DLJFVhrYi7
         NhxpLW4iPnZ9y4fc2dZovy5/+IUeDHNz4gDkuEj8wWXkurYx3+8+V2PK9l+aNm+D/tD3
         GXWg==
X-Gm-Message-State: AOAM530SPMQ1qILaLpwrSxTVf2YHlD/fpNrbCDJmHTVEXDPr6uLkZOTn
        Buv1tOzi8MCQx3OC52PKyJh3SpIa+95uNV4pRU1LygifFCs=
X-Google-Smtp-Source: ABdhPJwJEywGIqQdg8hh0sUZXnA5G8Sb7DVlb0w1/35HRGGNTC17jceSOFtlb3SQWN4PMoqW6FMkZ+50oK/6iZFFy60=
X-Received: by 2002:a25:e689:0:b0:63e:4f58:d27 with SMTP id
 d131-20020a25e689000000b0063e4f580d27mr4753250ybh.341.1649367298317; Thu, 07
 Apr 2022 14:34:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:10a:0:0:0:0:0 with HTTP; Thu, 7 Apr 2022 14:34:57 -0700 (PDT)
In-Reply-To: <CAFd5g46JiiddNxHW_jK6fjdfjGMjWsXsFuvL6H9xcZc98HWQyQ@mail.gmail.com>
References: <20220311072859.2174624-1-brendanhiggins@google.com>
 <1e1472e8-1813-3903-f934-cb0ae7f09864@linuxfoundation.org> <CAFd5g46JiiddNxHW_jK6fjdfjGMjWsXsFuvL6H9xcZc98HWQyQ@mail.gmail.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Thu, 7 Apr 2022 18:34:57 -0300
Message-ID: <CAKgze5bCf+v4PoS92XCDV2cD7d0iUvCvxHbPqAnLoW8pwoKbtQ@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: add support for kunit_suites that reference
 init code
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        davidgow@google.com, dlatypov@google.com,
        daniel.gutson@eclypsium.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, jk@codeconstruct.com.au
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/4/22, Brendan Higgins <brendanhiggins@google.com> wrote:
> On Mon, Apr 4, 2022 at 6:37 PM Shuah Khan <skhan@linuxfoundation.org>
> wrote:
>>
>> Hi Brendan,
>>
>> On 3/11/22 12:28 AM, Brendan Higgins wrote:
>> > Add support for a new kind of kunit_suite registration macro called
>> > kunit_test_init_suite(); this new registration macro allows the
>> > registration of kunit_suites that reference functions marked __init and
>> > data marked __initdata.
>> >
>> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> > Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> > Reviewed-by: Kees Cook <keescook@chromium.org>
>> > Reviewed-by: David Gow <davidgow@google.com>
>> > ---
>> >
>>
>> I almost applied it ...
>>
>> > This is a follow-up to the RFC here[1].
>> >
>> > This patch is in response to a KUnit user issue[2] in which the user
>> > was
>> > attempting to test some init functions; although this is a functional
>> > solution as long as KUnit tests only run during the init phase, we will
>> > need to do more work if we ever allow tests to run after the init phase
>> > is over; it is for this reason that this patch adds a new registration
>> > macro rather than simply modifying the existing macros.
>> >
>> > Changes since last version:
>> >   - I added more to the kunit_test_init_suites() kernel-doc comment
>> >     detailing "how" the modpost warnings are suppressed in addition to
>> >     the existing information regarding "why" it is OK for the modpost
>> >     warnings to be suppressed.
>> >
>> > [1]
>> > https://lore.kernel.org/linux-kselftest/20220310210210.2124637-1-brendanhiggins@google.com/
>> > [2] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
>> >
>> > ---
>> >   include/kunit/test.h | 26 ++++++++++++++++++++++++++
>> >   1 file changed, 26 insertions(+)
>> >
>> > diff --git a/include/kunit/test.h b/include/kunit/test.h
>> > index b26400731c02..7f303a06bc97 100644
>> > --- a/include/kunit/test.h
>> > +++ b/include/kunit/test.h
>> > @@ -379,6 +379,32 @@ static inline int kunit_run_all_tests(void)
>> >
>> >   #define kunit_test_suite(suite)     kunit_test_suites(&suite)
>> >
>> > +/**
>> > + * kunit_test_init_suites() - used to register one or more &struct
>> > kunit_suite
>> > + *                         containing init functions or init data.
>> > + *
>> > + * @__suites: a statically allocated list of &struct kunit_suite.
>> > + *
>> > + * This functions identically as &kunit_test_suites() except that it
>> > suppresses
>> > + * modpost warnings for referencing functions marked __init or data
>> > marked
>> > + * __initdata; this is OK because currently KUnit only runs tests upon
>> > boot
>> > + * during the init phase or upon loading a module during the init
>> > phase.
>> > + *
>> > + * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after
>> > boot, these
>> > + * tests must be excluded.
>> > + *
>> > + * The only thing this macro does that's different from
>> > kunit_test_suites is
>> > + * that it suffixes the array and suite declarations it makes with
>> > _probe;
>> > + * modpost suppresses warnings about referencing init data for symbols
>> > named in
>> > + * this manner.
>> > + */
>> > +#define kunit_test_init_suites(__suites...)                          \
>> > +     __kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),    \
>> > +                         CONCATENATE(__UNIQUE_ID(suites), _probe),   \
>> > +                         ##__suites)
>> > +
>> > +#define kunit_test_init_suite(suite) kunit_test_init_suites(&suite)
>> > +
>> >   #define kunit_suite_for_each_test_case(suite, test_case)            \
>> >       for (test_case = suite->test_cases; test_case->run_case;
>> > test_case++)
>> >
>> >
>>
>> The naming of the function and macro are rather confusing and can become
>> error prone. Let's find better naming scheme.
>
> Yeah, I wasn't sure about the name. I didn't have any better ideas
> initially though. Any suggestions?
>

What about kunit_test_init_section_suite?

>> > base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
>> >
>>
>> thanks,
>> -- Shuah
>
