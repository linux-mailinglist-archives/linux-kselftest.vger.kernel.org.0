Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381E56A123A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 22:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBWVpW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 16:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWVpV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 16:45:21 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1BD199C2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 13:45:20 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id t7-20020a9d7487000000b00693d565b852so818723otk.5
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 13:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677188719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OfiwbKNrqZqdva9KRQDaA1tAlOSC4p+inOs83fHUCo=;
        b=SfBdi2Sy7cIrVnRA8wIG0sAfShM4PckxXaDeF4xGX2gLoYJIVUMJfQNH5c9Cr5xjIt
         tTZkD0BtIrJYr1b6lxKoeAojqR5kTHOPziBCM/mCtIm7qtUO34tWcWroKnvHZ96h6yYH
         SCn3YGdgouGe5X3BtJc1t3txep/d4v7J7lY948sxpfm7bGRUHwNqaUdCqqDXsx89Ur+M
         yC51Drlbszy9BVYOxI5mjqMbw4Dg4bAUAvLMOx7ER9aJAwb4l7Jjobhg+9p5CVLWyacD
         IsrmH36niQ9Y1JkJRwesM16cFIIrhMmvCQTHySxkp+rAL5yAcw7Elgm8uQ/RJlM+Q4Iz
         GzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677188719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OfiwbKNrqZqdva9KRQDaA1tAlOSC4p+inOs83fHUCo=;
        b=B7bF/afJsZGlhqdYsH0LN70gse4bY9f5VSaieiv1cZ9jITPW8PFj6CxCXs1RcpJusl
         g2mWYHYa1WEXQ0G2tpXp89OBnOZjrdX9Qo8r8JKC5JCcus+yNbB1d/pzM8qJ59YEOwFm
         zR79AvMZYtOBNg86AEW3MKoH9NFX3Or6TlplPYFwPBPdXiU4jbJVKl9vb6QuZWt/G7b6
         zvfFGCHxuV8Ks9Gwr/IxthNPavks0jUaDBFajTZZbBB6Lv+7bVs4lXq0zAk2rC/DlUrb
         SJyX2hbJEnw1Y3r+IgFMHh+IoAH+KqoNwHwYpSDPw4LLIaSudDRq9Vl3QJj8/p5ZmROO
         xd/g==
X-Gm-Message-State: AO0yUKULzh2OSrjpSXeQLVez0ATsKmea12JJHZ+cQVMWY+SnRhH0+igY
        WKmjEImLcVi3aZ7SXs+0GlaPog4quClALjtWwFc5iQ==
X-Google-Smtp-Source: AK7set8FZ7qRWd1aOZ2OeE1vGBCfqUYTK06Q1pg5RF8MtU9Dq4n+YFV15FAPfTDrSNqr2fBaCFbKsAf7Z8/EhYOncuw=
X-Received: by 2002:a05:6830:33d1:b0:693:c98d:f9fd with SMTP id
 q17-20020a05683033d100b00693c98df9fdmr586581ott.5.1677188719449; Thu, 23 Feb
 2023 13:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20230222182740.254087-1-rmoar@google.com> <20230222182740.254087-3-rmoar@google.com>
 <CABVgOSmJRxCT=NZ7ZWMwCrpHJHnHBAa=XmuNcLAJd_FrBvMZBw@mail.gmail.com>
In-Reply-To: <CABVgOSmJRxCT=NZ7ZWMwCrpHJHnHBAa=XmuNcLAJd_FrBvMZBw@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 23 Feb 2023 16:45:07 -0500
Message-ID: <CA+GJov6cGOu0+F=N9qvv2NTCro7YhHZJxi1UuJCCus9a17yH=g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: fix bug of extra newline characters in
 debugfs logs
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Feb 23, 2023 at 12:51 AM David Gow <davidgow@google.com> wrote:
>
> On Thu, 23 Feb 2023 at 02:27, Rae Moar <rmoar@google.com> wrote:
> >
> > Fix bug of the extra newline characters in debugfs logs. When a line is
> > added to debugfs with a newline character at the end, an extra line app=
ears
> > in the debugfs log.
> >
> > This is due to a discrepancy between how the lines are printed and how =
they
> > are added to the logs. Remove this discrepancy by checking if the a new=
line
>
> Nit: "if the a"?

Thanks for catching this. I will change this to "if a."

>
> > character is present before adding a newline character to the log. This
> > should closely match the printk behavior.
> >
> > Add kunit_log_newline_test to provide test coverage for this issue. (Al=
so,
> > move kunit_log_test above suite definition to remove the unnecessary
> > declaration prior to the suite definition)
> >
> > As an example, say we add these two lines to the log:
> >
> > kunit_log(..., =E2=80=9CKTAP version 1\n=E2=80=9D);
> > kunit_log(..., =E2=80=9C1..1=E2=80=9D);
>
> Nit: Please use regular quotes here ("), rather than the "smart quotes" (=
=E2=80=9C=E2=80=9D).

Oops. Thanks. I will change these quotes.

>
> >
> > The debugfs log before this fix:
> >
> >  KTAP version 1
> >
> >  1..1
> >
> > The debugfs log after this fix:
> >
> >  KTAP version 1
> >  1..1
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >
> This overall seems better. I haven't finished reviewing the series
> yet, but there are a few obvious issues with this patch still...
>
> Most notably, kunit-log-test.kunit_log_test now fails.
>
> -- David
>
> > Changes from v1 -> v2:
> > - Changed the way extra newlines are removed. Instead of removing extra
> >   newline characters, add a newline if one is not present. This is a bi=
t
> >   cleaner.
> > - Add before and after results to the commit message.
> > - Note: I looked into using KERN_CONT to match the printk behavior to
> >   vsnprintf but this could cause issues with KTAP printing on the same =
line
> >   as interrupting kernel messages. I also looked at adding KERN_CONT
> >   functionality to kunit_log and I did get this to work but it was a bi=
t
> >   messy because it required a few calls to kunit_log_newline in
> >   kunit_run_tests. If this is very desired functionality, happy to add =
this
> >   to version 3.
> >
> >  include/kunit/test.h   |  9 ++++++++-
> >  lib/kunit/kunit-test.c | 35 +++++++++++++++++++++++------------
> >  lib/kunit/test.c       | 14 ++++++++++++++
> >  3 files changed, 45 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 0668d29f3453..3031ad29718b 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -375,6 +375,13 @@ static inline void *kunit_kcalloc(struct kunit *te=
st, size_t n, size_t size, gfp
> >
> >  void kunit_cleanup(struct kunit *test);
> >
> > +/**
> > + * kunit_log_newline() - Add newline to the end of log if not already
> > + * present at the end of the log.
> > + * @log: The log to add the newline to.
> > + */
> > +void kunit_log_newline(char *log);
> > +
>
> I don't think this function needs to be public. Maybe keep it static
> and internal to test.c?

Changing this to static makes sense. I will update this.

>
> >  void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> >
> >  /**
> > @@ -420,7 +427,7 @@ void __printf(2, 3) kunit_log_append(char *log, con=
st char *fmt, ...);
> >  #define kunit_log(lvl, test_or_suite, fmt, ...)                       =
         \
> >         do {                                                           =
 \
> >                 printk(lvl fmt, ##__VA_ARGS__);                        =
 \
> > -               kunit_log_append((test_or_suite)->log,  fmt "\n",      =
 \
> > +               kunit_log_append((test_or_suite)->log,  fmt,    \
> >                                  ##__VA_ARGS__);                       =
 \
> >         } while (0)
> >
> > diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> > index 4df0335d0d06..b63595d3e241 100644
> > --- a/lib/kunit/kunit-test.c
> > +++ b/lib/kunit/kunit-test.c
> > @@ -443,18 +443,6 @@ static struct kunit_suite kunit_resource_test_suit=
e =3D {
> >         .test_cases =3D kunit_resource_test_cases,
> >  };
> >
> > -static void kunit_log_test(struct kunit *test);
> > -
> > -static struct kunit_case kunit_log_test_cases[] =3D {
> > -       KUNIT_CASE(kunit_log_test),
> > -       {}
> > -};
> > -
> > -static struct kunit_suite kunit_log_test_suite =3D {
> > -       .name =3D "kunit-log-test",
> > -       .test_cases =3D kunit_log_test_cases,
> > -};
> > -
> >  static void kunit_log_test(struct kunit *test)
> >  {
> >         struct kunit_suite suite;
> > @@ -481,6 +469,29 @@ static void kunit_log_test(struct kunit *test)
> >  #endif
> >  }
> >
> > +static void kunit_log_newline_test(struct kunit *test)
> > +{
> > +       kunit_info(test, "Add newline\n");
> > +       if (test->log) {
> > +               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add =
newline\n"),
> > +                       "Missing log line, full log:\n%s", test->log);
> > +               KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\=
n\n"));
> > +       } else {
> > +               kunit_skip(test, "only useful when debugfs is enabled")=
;
> > +       }
> > +}
> > +
> > +static struct kunit_case kunit_log_test_cases[] =3D {
> > +       KUNIT_CASE(kunit_log_test),
>
> This test is failing now:
> [13:42:51] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D kunit-log-test (=
2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [13:42:51] put this in log.
> [13:42:51] this too.
> [13:42:51] add to suite log.
> [13:42:51] along with this.
> [13:42:51]     # kunit_log_test: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:459
> [13:42:51]     Expected strstr(test->log, "put this in log.") is not
> null, but is
> [13:42:51]     # kunit_log_test: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:461
> [13:42:51]     Expected strstr(test->log, "this too.") is not null, but i=
s
> [13:42:51]     # kunit_log_test: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:463
> [13:42:51]     Expected strstr(suite.log, "add to suite log.") is not
> null, but is
> [13:42:51]     # kunit_log_test: EXPECTATION FAILED at
> lib/kunit/kunit-test.c:465
> [13:42:51]     Expected strstr(suite.log, "along with this.") is not
> null, but is
> [13:42:51] [FAILED] kunit_log_test
> [13:42:51] [PASSED] kunit_log_newline_test
> [13:42:51] # kunit-log-test: pass:1 fail:1 skip:0 total:2
> [13:42:51] # Totals: pass:1 fail:1 skip:0 total:2
> [13:42:51] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] k=
unit-log-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

Sorry I did not catch this earlier. I must have tested on an outdated
version of my code. The fix here is I am missing a "+ 1" in
kunit_log_append(). This fix is for the first patch in this series and
the specific line change is:

- len =3D vsnprintf(NULL, 0, fmt, args);
+ len =3D vsnprintf(NULL, 0, fmt, args) + 1;

I will update this in the next version.

> > +       KUNIT_CASE(kunit_log_newline_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite kunit_log_test_suite =3D {
> > +       .name =3D "kunit-log-test",
> > +       .test_cases =3D kunit_log_test_cases,
> > +};
> > +
> >  static void kunit_status_set_failure_test(struct kunit *test)
> >  {
> >         struct kunit fake;
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index fb6b39cca0ae..1ea981392af3 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -108,6 +108,17 @@ static void kunit_print_test_stats(struct kunit *t=
est,
> >                   stats.total);
> >  }
> >
> > +void kunit_log_newline(char *log)
> > +{
> > +       int log_len, len_left;
> > +
> > +       log_len =3D strlen(log);
> > +       len_left =3D KUNIT_LOG_SIZE - log_len - 1;
> > +
> > +       if (log_len > 0 && log[log_len - 1] !=3D '\n')
> > +               strncat(log, "\n", len_left);
> > +}
> > +
> >  /*
> >   * Append formatted message to log, size of which is limited to
> >   * KUNIT_LOG_SIZE bytes (including null terminating byte).
> > @@ -134,6 +145,9 @@ void kunit_log_append(char *log, const char *fmt, .=
..)
> >         va_start(args, fmt);
> >         vsnprintf(log + log_len, min(len, len_left), fmt, args);
> >         va_end(args);
> > +
> > +       /* Add newline to end of log if not already present. */
> > +       kunit_log_newline(log);
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_log_append);
> >
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
