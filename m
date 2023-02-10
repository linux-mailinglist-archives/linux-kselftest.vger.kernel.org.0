Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A95692763
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 20:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjBJTs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 14:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjBJTs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 14:48:26 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B027FEE7
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 11:47:32 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so1863026otj.4
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/PBQsQs1ghoyck5G4YKo5wjZXEL9Pve2gHHX+BptzYI=;
        b=QMLkAAhL/XFCq5BdBspcsntMgvqCBo1wICtpxC8ZvzOFDIkXVjl1XreoPtZRKrEz2u
         KIQOItUhWzXa95LFNV+abUI0RnpySECOej0W744Qzw/mqURianZkZ5vBqsCpHTGhlTyI
         2F0DkqWYr3jKh/gxLDBxbh6kBqLUg/8JbAlDNKJ07+ihFXcF6wn9tu/3Gp5tBP2Hfy4v
         FZke6i1c0gImx/WyyEQtgeHnM5YWGRhPIDyS4UUiEtn/vj0yevWOeimVWvK5AIMn6+Zi
         7B8BGbfL3kK3Co+W7YeOsgNhVsr029SueC0iusgoh42nQzD44ewnMxZLjo/kZdFN39cs
         OLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PBQsQs1ghoyck5G4YKo5wjZXEL9Pve2gHHX+BptzYI=;
        b=DOLXQm0BefcGlktw3rI1XZoCl/OkK7oPdvwChUJIPkRPiJQiWTefrRtTaMCsbrOymP
         RKeTl+8ytmAAS+6KSLRBWvin3xPX7yAKabGLvQ1I5D97/VkHDFyb/ir+T6/rGd5VgfA4
         Qrmxdj40TqaZM9xxzNzqqJ8n8qJfLKxSwxxoSLJtYc8XarYUy1iJ1/rdAB5LkaUUqeLg
         eP21TsAbIqgF7kUNyD5vvwNOa76QvuzC8RU+UnODNoTCzBtpMBnxbPTbNceXmvminBHk
         Nnb7dHwMXZ27NpIHJYLbXVXSRLqkYFkFOHEH4wP9kw6ZsWS8daU3PMJcjP7CZfCsnMIr
         eD+w==
X-Gm-Message-State: AO0yUKU7VvDWKtUz1haz+Oq4C27ruNiu3i0CHD6YkXbs5td/5LeCw4fv
        AHIPPObm7QBoyGHa5Lxr/RyRuYKFQP0e/SN2bfPNXzaILmDKgWhk
X-Google-Smtp-Source: AK7set/2TdLhFb95nfn832Tj3Ud3QPjqZ++ec3/IpCLmB7FMRJ47GvktUIwDdZbVBQkoiIzhpNiQ7RTZAdnte3nSLr4=
X-Received: by 2002:a05:6830:4414:b0:68b:cd2c:d16 with SMTP id
 q20-20020a056830441400b0068bcd2c0d16mr1575661otv.53.1676058386639; Fri, 10
 Feb 2023 11:46:26 -0800 (PST)
MIME-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com> <20230131220355.1603527-4-rmoar@google.com>
 <CABVgOSngiZZ6HTAOTriB=TveYOPoZVChqyeNfaBsDzFCY+_A2A@mail.gmail.com>
In-Reply-To: <CABVgOSngiZZ6HTAOTriB=TveYOPoZVChqyeNfaBsDzFCY+_A2A@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Fri, 10 Feb 2023 14:46:15 -0500
Message-ID: <CA+GJov6QmmbTOV400PEtsZtpLM7-3SVN4A67ED5Jnoca0D9LCw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] kunit: fix bug of extra newline characters in
 debugfs logs
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
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
> > Fix bug of the extra newline characters in debugfs logs. When a
> > line is added to debugfs with a newline character at the end,
> > an extra line appears in the debugfs log. Remove these extra lines.
> >
> > Add kunit_log_newline_test to provide test coverage for this issue.
> > (Also, move kunit_log_test above suite definition to remove the
> > unnecessary declaration prior to the suite definition)
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---

Hi David!

>
> I've got some reservations about this patch.
>
> Firstly, could we have an example of the problem in the commit
> message, so we know what we're fixing?

Yes, as mentioned in the second patch, I will add an individual
"before and after" comparison to each of the patches in v2. This is
much clearer than just the overall comparison in the cover letter.

>
> Secondly, I _really_ don't like the way this just removes newlines
> from log lines if there are too many. It feels like a hack, rather
> than a proper fix.
>
> I suspect the actual issue here is in the kunit_log macro in
> include/kunit/test.h:
> https://elixir.bootlin.com/linux/latest/source/include/kunit/test.h#L417
>
> kunit_log_append((test_or_suite)->log, fmt "\n", ##__VA_ARGS__); \
>
> The "\n" concatenated here is probably the issue. The printk statement
> doesn't add a newline, but that's because printk implicitly does if
> KERN_CONT is not added.
>
> So maybe the correct fix here is to use:
> printk(KERN_CONT lvl fmt "\n", ##__VA_ARGS__)
>
> That'd add the newline, rather than get rid of it, but at least should
> make the behaviour more similar between printk and the debugfs log.
> Equally, you could use KERN_CONT and get rid of the "\n" in both
> places, requiring it in log messages.

I understand how this seems a bit hacky. There were quite a few
discussions on how to approach this prior to sending this out on this
list. But changing the printk to be consistent between the debugfs and
normal output is a great idea! This does cause a few tests to have
extra lines in the output but shouldn't cause any issues with the
parser readable output. I will definitely change this in v2.

>
> Thirdly, I don't really like the way the test is skipped if debugfs
> isn't active. Could we skip it if test->log is not valid instead or
> using a compile-time #ifdef?

Yes this makes sense. Happy to change this in v2. The kunit_log_test
also uses this #ifdef statement. Should this be changed as well?

>
> I do like the move of kunit_log_test though. That definitely cleans things up!
>
> Cheers,
> -- David
>

Thanks!

Rae

>
> >  lib/kunit/kunit-test.c | 36 ++++++++++++++++++++++++------------
> >  lib/kunit/test.c       |  9 ++++++++-
> >  2 files changed, 32 insertions(+), 13 deletions(-)
> >
> > diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> > index 4df0335d0d06..e9114a466f1e 100644
> > --- a/lib/kunit/kunit-test.c
> > +++ b/lib/kunit/kunit-test.c
> > @@ -443,18 +443,6 @@ static struct kunit_suite kunit_resource_test_suite = {
> >         .test_cases = kunit_resource_test_cases,
> >  };
> >
> > -static void kunit_log_test(struct kunit *test);
> > -
> > -static struct kunit_case kunit_log_test_cases[] = {
> > -       KUNIT_CASE(kunit_log_test),
> > -       {}
> > -};
> > -
> > -static struct kunit_suite kunit_log_test_suite = {
> > -       .name = "kunit-log-test",
> > -       .test_cases = kunit_log_test_cases,
> > -};
> > -
> >  static void kunit_log_test(struct kunit *test)
> >  {
> >         struct kunit_suite suite;
> > @@ -481,6 +469,30 @@ static void kunit_log_test(struct kunit *test)
> >  #endif
> >  }
> >
> > +static void kunit_log_newline_test(struct kunit *test)
> > +{
> > +#ifdef CONFIG_KUNIT_DEBUGFS
> > +       kunit_info(test, "extra newline\n");
> > +
> > +       KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "extra newline\n"),
> > +               "Missing log line, full log:\n%s", test->log);
> > +       KUNIT_EXPECT_NULL(test, strstr(test->log, "extra newline\n\n"));
> > +#else
> > +       kunit_skip(test, "only useful when debugfs is enabled");
> > +#endif
> > +}
> > +
> > +static struct kunit_case kunit_log_test_cases[] = {
> > +       KUNIT_CASE(kunit_log_test),
> > +       KUNIT_CASE(kunit_log_newline_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite kunit_log_test_suite = {
> > +       .name = "kunit-log-test",
> > +       .test_cases = kunit_log_test_cases,
> > +};
> > +
> >  static void kunit_status_set_failure_test(struct kunit *test)
> >  {
> >         struct kunit fake;
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 27763f0b420c..76d9c31943bf 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -117,6 +117,7 @@ void kunit_log_append(char *log, const char *fmt, ...)
> >         char line[KUNIT_LOG_SIZE];
> >         va_list args;
> >         int len_left;
> > +       int line_len;
> >
> >         if (!log)
> >                 return;
> > @@ -125,10 +126,16 @@ void kunit_log_append(char *log, const char *fmt, ...)
> >         if (len_left <= 0)
> >                 return;
> >
> > +       // Evaluate the length of the line with arguments
> >         va_start(args, fmt);
> > -       vsnprintf(line, sizeof(line), fmt, args);
> > +       line_len = vsnprintf(line, sizeof(line), fmt, args);
> >         va_end(args);
> >
> > +       // If line has two newline characters, do not print
> > +       // second newline character
> > +       if (fmt[strlen(fmt) - 2] == '\n')
> > +               line[line_len - 1] = '\0';
> > +
> >         strncat(log, line, len_left);
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_log_append);
> > --
> > 2.39.1.456.gfc5497dd1b-goog
> >
