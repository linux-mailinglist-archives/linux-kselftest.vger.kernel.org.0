Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF634F1FF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Apr 2022 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiDDXOc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 19:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243560AbiDDXLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 19:11:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CE810A3
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 15:48:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id yy13so23057367ejb.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Apr 2022 15:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmQtSeoAc+Nq1zeZ+fcOy7GISIYvQy3s9Qy54NdzuHU=;
        b=o04wJ+0ZKldbQAUg1OrIlnIW+Sx2rrgZN889EJaxXOUiYl1aFr9M2h/mAs5Hq/qfKP
         TTsqt/3k7wIv4hpJjvaqoJLYI8N+Bs3w+hQCNbH+TXLubgXpeWh9UMVwIGRxTbT+0HRe
         OYkEmZn4RdjGxdIuFmDsnKDyQOrtx7luLwYQu2jkxEZvv0Yiu0qJGhOT3Zb7QdH6VHX4
         lyfyTbnXIgPDJjdPXj+suT0Ge2pmL/GV7WS9mY3h2pmqDceIKSocUZYNRQa/uR3YhX2e
         7ywzIGVVVuGNqcwOXumeP3m+tRQvyS2P01JKNHoObHinqn6TKWcZZ9J4CRbY+KGcDH/K
         P29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmQtSeoAc+Nq1zeZ+fcOy7GISIYvQy3s9Qy54NdzuHU=;
        b=swacwv/biaXIu2WlYBnKcAoH2su3gQaWw1rf1CJEg4dcEhMUIjFunAdQVMp4cUDsS1
         1XPGG+Mwlffo4xlL/1pvM9kftjj9MsEyLi0HE//JLbYVc+efij1Wu8sWokvv0Sv55nv7
         BbAMxMR41J0tlW8XB0fbYZz3d2cMzCpaGg946M9ER+Y/7gbisIXeQE3tRzwhd3gnIPjT
         lkpyxkQHVWfmOb6Jy47TLncqV7lD14qdAUI4VMDiANcghXBY58/kL6Ti0fDk0nhfCRJT
         eZFBw49RI5r7gk8cwHtWNDuungYV5XMIDaiIhX5jYJ2f7amUBYvxjcO6SpfCdgsDAwl9
         HyZA==
X-Gm-Message-State: AOAM533gggguH7wLjJfIjxAVl3GwYvtmwtMhf1+6xhQXFOqLF8EX/xrv
        rfnKCkmYMyEC9wCzQ9tOWQy/f9EVp/LHrdGZgPXWTw==
X-Google-Smtp-Source: ABdhPJzdIQ4vB761RUi6v1HI1p4UzqyOOA0GSKBjTMp6EdtjdhHQq8XELB1I6aQFcv0w/hp4QKxJhGCbQx/1j27ysbA=
X-Received: by 2002:a17:906:37cd:b0:6e0:bdb6:f309 with SMTP id
 o13-20020a17090637cd00b006e0bdb6f309mr500240ejc.394.1649112523031; Mon, 04
 Apr 2022 15:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220311072859.2174624-1-brendanhiggins@google.com> <1e1472e8-1813-3903-f934-cb0ae7f09864@linuxfoundation.org>
In-Reply-To: <1e1472e8-1813-3903-f934-cb0ae7f09864@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Apr 2022 18:48:31 -0400
Message-ID: <CAFd5g46JiiddNxHW_jK6fjdfjGMjWsXsFuvL6H9xcZc98HWQyQ@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: add support for kunit_suites that reference
 init code
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jk@codeconstruct.com.au
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

On Mon, Apr 4, 2022 at 6:37 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Brendan,
>
> On 3/11/22 12:28 AM, Brendan Higgins wrote:
> > Add support for a new kind of kunit_suite registration macro called
> > kunit_test_init_suite(); this new registration macro allows the
> > registration of kunit_suites that reference functions marked __init and
> > data marked __initdata.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: David Gow <davidgow@google.com>
> > ---
> >
>
> I almost applied it ...
>
> > This is a follow-up to the RFC here[1].
> >
> > This patch is in response to a KUnit user issue[2] in which the user was
> > attempting to test some init functions; although this is a functional
> > solution as long as KUnit tests only run during the init phase, we will
> > need to do more work if we ever allow tests to run after the init phase
> > is over; it is for this reason that this patch adds a new registration
> > macro rather than simply modifying the existing macros.
> >
> > Changes since last version:
> >   - I added more to the kunit_test_init_suites() kernel-doc comment
> >     detailing "how" the modpost warnings are suppressed in addition to
> >     the existing information regarding "why" it is OK for the modpost
> >     warnings to be suppressed.
> >
> > [1] https://lore.kernel.org/linux-kselftest/20220310210210.2124637-1-brendanhiggins@google.com/
> > [2] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
> >
> > ---
> >   include/kunit/test.h | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index b26400731c02..7f303a06bc97 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -379,6 +379,32 @@ static inline int kunit_run_all_tests(void)
> >
> >   #define kunit_test_suite(suite)     kunit_test_suites(&suite)
> >
> > +/**
> > + * kunit_test_init_suites() - used to register one or more &struct kunit_suite
> > + *                         containing init functions or init data.
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
> > + *
> > + * The only thing this macro does that's different from kunit_test_suites is
> > + * that it suffixes the array and suite declarations it makes with _probe;
> > + * modpost suppresses warnings about referencing init data for symbols named in
> > + * this manner.
> > + */
> > +#define kunit_test_init_suites(__suites...)                          \
> > +     __kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),    \
> > +                         CONCATENATE(__UNIQUE_ID(suites), _probe),   \
> > +                         ##__suites)
> > +
> > +#define kunit_test_init_suite(suite) kunit_test_init_suites(&suite)
> > +
> >   #define kunit_suite_for_each_test_case(suite, test_case)            \
> >       for (test_case = suite->test_cases; test_case->run_case; test_case++)
> >
> >
>
> The naming of the function and macro are rather confusing and can become
> error prone. Let's find better naming scheme.

Yeah, I wasn't sure about the name. I didn't have any better ideas
initially though. Any suggestions?

> > base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
> >
>
> thanks,
> -- Shuah
