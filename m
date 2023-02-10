Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F591692652
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 20:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjBJT27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 14:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBJT26 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 14:28:58 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D4E63109
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 11:28:57 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-16346330067so7995006fac.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 11:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QnFhEMcPPEP0O0xLg8j6PWrQGKllGaFswnof6Ao8II=;
        b=obbP9CUsIN+o+GcuEdB6W00oWDZV3vrht/AeGKmWlLbavWt2/jmBX7clglJDbLVUbB
         vDm0DtYpPFEJy1zIpI+RljlFwn4wPA+BKj5pf+UZmOFV1c+kRRz5or0COegws6Op8wrk
         vN8thBQ4so/H9LAguljqEOuoV4RgCiBAY4Sc4zoALDE1ety5W8YiIjNw3QhSqTXxYL1s
         W+OJmW7jC4+fYMpehgxuIexQNb14L3XhiQ66oeqqp2Gykpn8QC7+2HPZ6vIhUSxThHlz
         0FaIw2u4CfdNCJ/Nfr8wKQTJSi4jTFrzL9+t3r+2BQEe+Lh6DrUYER5oD3HaW9DELj5y
         DBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QnFhEMcPPEP0O0xLg8j6PWrQGKllGaFswnof6Ao8II=;
        b=SYHrd7cNQR1fqdZGuHgKFah57C3S7hfOh2HjVVNeLrk4NS/G6vLwLYKhnOlLTQfVrl
         NJiH0LEKAnKm7jfwZIjWy2KazUvPqInv7FJnAHoxzW1FF+xOLsYVvmwD9zssIhPEPCVO
         nipeKeh6C5O9Jq8KzJrzvHHHuFPGaPxuUe3FWJrHh5B64s90eEUPHeEzkalRAc+i/cbR
         1+uVR4sCi+05shdm6CdewCLzceNY1wsjuaS2gJo3TSZhSV+Z5YANEnHbPzyztDWvdhOq
         Rk8U8hzqVAo5ad2bn/b6kVBkYhEMBb6iwnh/zeHzINpMwM8I8qhh6NbQOeH4OxJKiQ54
         JWCQ==
X-Gm-Message-State: AO0yUKWexbXaMJCrHFcD0cPjfOyghTQs5ufZ2V//wPEvEdNxTdL8VtNY
        QMYN/08rEDvCCPZQyNAo7cHB0JkiXMlPAJmkj3vg9A==
X-Google-Smtp-Source: AK7set9FhO6ODVeYpYuU7r3c1yFt4Ew4aZNMdHvKpMd8vVZ0g1n+1IPAOnp6pnOZxCZL6/VFGuMGQBZTcOb+kL8UJSU=
X-Received: by 2002:a05:6870:c211:b0:169:e996:9cb0 with SMTP id
 z17-20020a056870c21100b00169e9969cb0mr2176030oae.122.1676057336378; Fri, 10
 Feb 2023 11:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com> <20230131220355.1603527-3-rmoar@google.com>
 <CABVgOSk_jWzywAKASy1U2mQOC=SM_TDt753VyF1hUtwWzoszPw@mail.gmail.com>
In-Reply-To: <CABVgOSk_jWzywAKASy1U2mQOC=SM_TDt753VyF1hUtwWzoszPw@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Fri, 10 Feb 2023 14:28:44 -0500
Message-ID: <CA+GJov5OCM4VNZ4QsEEcH-V+S+sPoUN8B9b_stFD-r00RYF2hw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] kunit: fix bug in the order of lines in debugfs logs
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
> > Fix bug in debugfs logs that causes an incorrect order of lines in the
> > debugfs log.
> >
> > Currently, any suite diagnostic lines, including the test counts lines
> > that show the number of tests passed, failed, and skipped,
> > appear prior to the individual results, which is a bug.
> >
> > Ensure the order of printing for the debugfs log is correct.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> I think this is overall an improvement, but there are a few remaining
> issues (some new, some old).

Hi David!

Thanks for your comments.

>
> First, as with the previous patches, could we have a before/after
> comparison in the commit description?

Yes, this sounds like a great idea. I originally thought the before
and after comparison in the cover letter would be sufficient but an
individual comparison for each patch is clearer. I will add this in
v2.

>
> Secondly, I think it'd be nice to either add an extra KTAP header to
> the start, so that each debugfs results file is a valid KTAP document
> by itself, or at least document that you'll need to prepend one for
> this to work.
> I'm personally leaning towards the latter, even if it loses us the
> ability to just concatenate result files together, because of the
> third issue below.
>
> Finally, with this patch, the final result line's suite number is
> recorded from its initial run, rather than always being '1'. This
> means that if multiple suites are run (e.g. list-test.ko), then the
> result file could contain a single suite, with "ok 2 ..." or similar
> as a result line. This might help a bit if we were concatenating
> result files, but otherwise leaves us with a parse error due to the
> mismatched number.
>
> Personally, I'd prefer we change those to always use suite number 1,
> and to add the KTAP header to the start. Adding the header should be
> easy, the suite number perhaps less so...

My intention was to match the logs with the exact KTAP output of the
test to be consistent. But I see the value in ensuring the logs are
easily parsable. In v2, I will add the KTAP header and change the test
number to be 1 to allow the logs to be parsed without error.

-Rae

>
> Cheers,
> -- David
>
> >  lib/kunit/debugfs.c | 13 ++++++++-----
> >  lib/kunit/test.c    | 24 ++++++++++++------------
> >  2 files changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> > index de0ee2e03ed6..fbc645590701 100644
> > --- a/lib/kunit/debugfs.c
> > +++ b/lib/kunit/debugfs.c
> > @@ -52,19 +52,22 @@ static void debugfs_print_result(struct seq_file *seq,
> >  static int debugfs_print_results(struct seq_file *seq, void *v)
> >  {
> >         struct kunit_suite *suite = (struct kunit_suite *)seq->private;
> > -       enum kunit_status success = kunit_suite_has_succeeded(suite);
> >         struct kunit_case *test_case;
> >
> > -       if (!suite || !suite->log)
> > +       if (!suite)
> >                 return 0;
> >
> > -       seq_printf(seq, "%s", suite->log);
> > +       /* Print suite header because it is not stored in the test logs. */
> > +       seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
>
> We probably want to print this twice, once without the indent, to
> start the whole document, once with it.
>
> > +       seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
> > +       seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
> >
> >         kunit_suite_for_each_test_case(suite, test_case)
> >                 debugfs_print_result(seq, suite, test_case);
> >
> > -       seq_printf(seq, "%s %d %s\n",
> > -                  kunit_status_to_ok_not_ok(success), 1, suite->name);
>
> We probably still want to output the suite number as '1'...
>
> > +       if (suite->log)
> > +               seq_printf(seq, "%s", suite->log);
> > +
> >         return 0;
> >  }
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 66ba93b8222c..27763f0b420c 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -147,10 +147,18 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
> >
> >  static void kunit_print_suite_start(struct kunit_suite *suite)
> >  {
> > -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> > -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
> > +       /*
> > +        * We do not log the test suite header as doing so would
> > +        * mean debugfs display would consist of the test suite
> > +        * header prior to individual test results.
> > +        * Hence directly printk the suite status, and we will
> > +        * separately seq_printf() the suite header for the debugfs
> > +        * representation.
> > +        */
> > +       pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> > +       pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s",
> >                   suite->name);
> > -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
> > +       pr_info(KUNIT_SUBTEST_INDENT "1..%zd",
> >                   kunit_suite_num_test_cases(suite));
> >  }
> >
> > @@ -165,16 +173,8 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
> >         struct kunit *test = is_test ? test_or_suite : NULL;
> >         const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
> >
> > -       /*
> > -        * We do not log the test suite results as doing so would
> > -        * mean debugfs display would consist of the test suite
> > -        * description and status prior to individual test results.
> > -        * Hence directly printk the suite status, and we will
> > -        * separately seq_printf() the suite status for the debugfs
> > -        * representation.
> > -        */
> >         if (suite)
> > -               pr_info("%s %zd %s%s%s\n",
> > +               kunit_log(KERN_INFO, suite, "%s %zd %s%s%s\n",
>
> Changing this breaks the code to ensure the suite number is always '1'...
>
>
> >                         kunit_status_to_ok_not_ok(status),
> >                         test_number, description, directive_header,
> >                         (status == KUNIT_SKIPPED) ? directive : "");
> > --
> > 2.39.1.456.gfc5497dd1b-goog
> >
