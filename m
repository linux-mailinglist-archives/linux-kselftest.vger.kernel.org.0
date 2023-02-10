Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8669769278E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 21:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjBJUCn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 15:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBJUCn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 15:02:43 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0178D7715E
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 12:02:41 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-16dcb07b805so1540088fac.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 12:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dn8jJUxmhSJCRQ2KeeXopMGGe8mROJR+FfacxxhkMFU=;
        b=Z8n30FA5uUBtnkZJ7Z0lfxpwqmPAmBwoI63JhBNKnPQ58VTj0Mz/WS5sGb2XeOsSK8
         axBbJJNTiYvwQtE91QFlz+a2cAcrifJiCdOhSMW0PvWiHmyQiTsqYxGck3b3lSdWsCI/
         Vg9vmtBPodcU0+4PMi8CfJXftsyU+ZUaD0SHcy+lXf4oIkK5riR+FzGh+zFxhKxscMQU
         OV8+rRq7RfrPD37O6pK2d6Q5nYKOcq0dtkggTZxD57s6ISLyHH6UqLQpHgJp6BhZhbGB
         EbpYgrEUsBPgyzwAb/w5Nu1CUucw9IrISe3tRpYc40ZyGPhSoHjMmO0gwUYiNYLUX3ny
         6oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dn8jJUxmhSJCRQ2KeeXopMGGe8mROJR+FfacxxhkMFU=;
        b=i1w7YsF6nOvgtysrmKJe/IIvkzDCOoqECEhUIbaGLi5HpXJq119eVwR8tNR4dAVBlD
         NeP5R5J6wr4wb9vmkqExeEzYRdpGFUE2fwW76QAHybUePe1qo+bt3WkkLZNXUWOxILhu
         N70gCmsBBFb5HQsb7RYFINOLflCZ/2VLRYvpfVRykD3+q14P065RIvAebH1u9AgTQQXS
         jV71WNRmPwu4fBR6+t9U/5or+YISNgW/HpKNz7BzhI2Tb+ZA0pLdw7Kvm1RKGGIwoZ+4
         paclB/BizYeB3yMiTMpcE6eB8DvXv+HC3w5ACHK+tdsClAwhB4WcDx8+ZNuNtN41Xoa7
         OiiQ==
X-Gm-Message-State: AO0yUKUVKngZADopIAstyMSfEDFPgUQNvLl0fX+3zXafTEIHJ9FB4BDt
        0r6UBky52ys86KRJy+q6TaQRNIIEgofKjRwZ8B1uJw==
X-Google-Smtp-Source: AK7set8VFB1oFgobXiEA8CwUJAHpFvhiVJut+0W/YtZUWF6VJL4Bv4kKXlyXkN8tNOaJ8XquuXlP5RSZa+U6UpBCWCQ=
X-Received: by 2002:a05:6870:c211:b0:169:e996:9cb0 with SMTP id
 z17-20020a056870c21100b00169e9969cb0mr2202181oae.122.1676059360188; Fri, 10
 Feb 2023 12:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com> <20230131220355.1603527-2-rmoar@google.com>
 <CABVgOSmYmP+yO1BQ2m8nA+czTjQZrYeOWkn1b47UUiFKG3NUZA@mail.gmail.com>
In-Reply-To: <CABVgOSmYmP+yO1BQ2m8nA+czTjQZrYeOWkn1b47UUiFKG3NUZA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Fri, 10 Feb 2023 15:02:29 -0500
Message-ID: <CA+GJov4kXQBgsxj8_4Z7bn=J16J5BJJcRL+YV=Vpe=TcgXzvoA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kunit: fix bug in debugfs logs of parameterized tests
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 9, 2023 at 12:06 AM David Gow <davidgow@google.com> wrote:
>
> On Wed, 1 Feb 2023 at 06:04, Rae Moar <rmoar@google.com> wrote:
> >
> > Fix bug in debugfs logs that causes parameterized results to not appear
> > in the log because the log is reintialized (cleared) when each parameter is
>

Hi David!

> Nit: s/reintialized/reinitialized
>

Oops. Thanks for pointing this out. Will fix in v2.

> > run.
> >
> > Ensure these results appear in the debugfs logs and increase log size to
> > allow for the size of parameterized results.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> This looks pretty good to me, but we may need to restrict the size of
> a single log line separately from that of the whole log.
>
> (It'd also be nice to include a before/after in the commit description.)

Yes, as mentioned in the other patches, I will add an individual
"before and after" comparison to each of the patches in v2. This is
much clearer than just the overall comparison in the cover letter.

>
> With the stack size issue fixed, though, this looks good to me:
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  include/kunit/test.h | 2 +-
> >  lib/kunit/test.c     | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 87ea90576b50..0a077a4c067c 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
> >  struct kunit;
> >
> >  /* Size of log associated with test. */
> > -#define KUNIT_LOG_SIZE 512
> > +#define KUNIT_LOG_SIZE 1500
>
> This is used both as the overall log size, and the size of a single
> line in kunit_log_append.
>
> As the latter involves a local 'line' array, it can bloat out stack usage.
>
> Could we either restrict the maximum line length separately, or rework
> kunit_log_append() to not use a local variable?
> (I imagine we could just vsnprintf() directly into the log buffer. We
> could make two sprintf calls to calculate the length required to
> maintain some atomicity as well (this could open us up to
> time-of-check/time-of-use vulnerabilities, but I think the
> vulnerability ship has sailed if you're passing untrusted pointers
> into the kunit_log macro anyway))
>

Thanks for your help here. I will play around with these two options.
Although, I think I am leaning toward restricting the maximum line
length separately.

Thanks!

-Rae

> >
> >  /* Maximum size of parameter description string. */
> >  #define KUNIT_PARAM_DESC_SIZE 128
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 51cae59d8aae..66ba93b8222c 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -437,7 +437,6 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
> >         struct kunit_try_catch_context context;
> >         struct kunit_try_catch *try_catch;
> >
> > -       kunit_init_test(test, test_case->name, test_case->log);
> >         try_catch = &test->try_catch;
> >
> >         kunit_try_catch_init(try_catch,
> > @@ -533,6 +532,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                 struct kunit_result_stats param_stats = { 0 };
> >                 test_case->status = KUNIT_SKIPPED;
> >
> > +               kunit_init_test(&test, test_case->name, test_case->log);
> > +
> >                 if (!test_case->generate_params) {
> >                         /* Non-parameterised test. */
> >                         kunit_run_case_catch_errors(suite, test_case, &test);
> > --
> > 2.39.1.456.gfc5497dd1b-goog
> >
