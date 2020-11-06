Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE3E2A9D57
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgKFTFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 14:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgKFTFg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 14:05:36 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81404C0613D3
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 11:05:36 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id w145so2399352oie.9
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R698vTS3sP7K10LIp+T/pBAzJll3NJN4xvHU3P1DGwg=;
        b=VaEnLf46w5vIExY59a+G9WTSqIbWqj+eUMwZksdIYvwFgg9NYmW6tFJMVSO7nUQ4tD
         ezz/DeLkXzjkhfXUHKcSGlFbUyh42hxCne6/lYXZejfEeetFS3kISHyyD1FgWP5c4qFa
         M9IOzy15cbcppijEQghWGg7j94ijBny6yqeVwvc4HsYgoB6kJ0I+W6Pmtxd6WaPrPufA
         HAmkD9D05NWgQR8UQF6VFzQJkA+/LUIRLx6LPpIkN1mPEKR3unfNWZMF0D5s2hHk0za8
         kI0RIMFIKvratitfXOYU32CibW45aA2MR1uWhaBI8UujKK2eJRIVz+yMbHVQs5UDyUsN
         kEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R698vTS3sP7K10LIp+T/pBAzJll3NJN4xvHU3P1DGwg=;
        b=RFsrv4UZKlDlDq4YC2kIfmrLZtxjhQMJPIo8VzN/J05EAq8DQWgkPGw9ZQOr5Pu8oU
         gKU5NvUvQCPq7eRg73MTZyvotEzSC60Oaxraw/u2f41WE+lqdaTVh7lGFkb+NhbXVX+Y
         6a8UHKfNB6InzazRHpGS0hcbqnjN4WPYX5DT95HIb9UH5e0L2jkJgZmfXFI4QSXgWf6J
         dokic2VO3TQZws0YhK7k6usShwPb4FWbAbFY3yAee6gDaMuVBMWDry2II1P3dHDvIvXg
         lachJgM2A7hLx2aYy86hY8JyBlq9r9IBFmC90pDAeIlNHQox7Ti2ewb6CJybqO3jrU87
         vILg==
X-Gm-Message-State: AOAM530mOiJ2vtOEFOaudWJqCaWEHrg61WR91hQPrfQIXxWKXk/3nzyz
        Wiul7LjwaukG+GoDyAdxyhF1x7xyQvl4toduTSMaew==
X-Google-Smtp-Source: ABdhPJyZWFBrGNICpuwwmJZU0LRFQXm5D2oVyMpcLMzRrOflbicLpntjl2xTCu1rs052y24YptuLj5Ko4AXCh6MZ9Ok=
X-Received: by 2002:aca:6206:: with SMTP id w6mr2060911oib.121.1604689535633;
 Fri, 06 Nov 2020 11:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20201106182657.30492-1-98.arpi@gmail.com> <CANpmjNPsACW1mZmkWiCSeXfvAGaxAS5sHtYMu0-DfE7ec2pFMA@mail.gmail.com>
 <11549107-7247-03a7-2469-f5aa793a0d19@gmail.com>
In-Reply-To: <11549107-7247-03a7-2469-f5aa793a0d19@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 20:05:23 +0100
Message-ID: <CANpmjNM-Wj0fReinwTxBC3GD7p-8qKHeao1cMYMerFd5bO1fqA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 6 Nov 2020 at 20:00, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 07/11/20 12:15 am, Marco Elver wrote:
> > On Fri, 6 Nov 2020 at 19:28, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >>
> >> Implementation of support for parameterized testing in KUnit.
> >> This approach requires the creation of a test case using the
> >> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> >> This generator function should return the next parameter given the
> >> previous parameter in parameterized tests. It also provides
> >> a macro to generate common-case generators.
> >>
> >> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> >> Co-developed-by: Marco Elver <elver@google.com>
> >> Signed-off-by: Marco Elver <elver@google.com>
> > [...]
> >> -       kunit_suite_for_each_test_case(suite, test_case)
> >> -               kunit_run_case_catch_errors(suite, test_case);
> >> +       kunit_suite_for_each_test_case(suite, test_case) {
> >> +               struct kunit test = { .param_value = NULL, .param_index = 0 };
> >> +               bool test_success = true;
> >> +
> >> +               if (test_case->generate_params)
> >> +                       test.param_value = test_case->generate_params(NULL);
> >> +
> >> +               do {
> >> +                       kunit_run_case_catch_errors(suite, test_case, &test);
> >> +                       test_success &= test_case->success;
> >> +
> >> +                       if (test_case->generate_params) {
> >> +                               kunit_log(KERN_INFO, &test,
> >> +                                       KUNIT_SUBTEST_INDENT
> >> +                                       "# %s: param-%d %s",
> >> +                                       test_case->name, test.param_index,
> >> +                                       kunit_status_to_string(test.success));
> >
> > Sorry, I still found something. The patch I sent had this aligned with
> > the '(', whereas when I apply this patch it no longer is aligned. Why?
> >
> > I see the rest of the file also aligns arguments with opening '(', so
> > I think your change is inconsistent.
> >
>
> Ah those lines had spaces instead of tab and I think I messed up the alignment
> fixing that. I will send another version fixing this.
> Thanks!

It was tabs then <8 spaces to align. checkpatch.pl certainly is happy with that.

> > Thanks,
> > -- Marco
> >
>
