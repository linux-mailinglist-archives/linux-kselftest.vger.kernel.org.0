Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A432B37A9
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Nov 2020 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKOSLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Nov 2020 13:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOSLo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Nov 2020 13:11:44 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A06C0617A6
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Nov 2020 10:11:43 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id t142so3345008oot.7
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Nov 2020 10:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Tbq1vEgEMTBoexcFc2qtiD/aGn5ZlYHghcweLEeR5g=;
        b=GvBBVq2j1thxIqxLdyh/HEf7BXC3CObT+/mfmrC30J+QwTdZyhYZjSCBekIL96rBZc
         wVPDnehbUiyoUVUAny2epI2cffKCh2efQd5xyfHAdzZX7pgwf24X0wRyRphzDJ7eN2MH
         wHSECWBN8pDj1WP9I/SM5tdDQpHnb8bQ+9L805Jv77OEbrBu7eIIVOz5UXgHk0RGGB0l
         fUieg48jSeflZkjQGJPFVex7yqtXVwOopn+WLiHcBUdX2bUZ1tk002IVpPRzgWpGVp/p
         YSl4X8DkPhqT/cnxCrGpm+VsZ77HumFBCgqe3OlpKuZW3e/EMJ8lBkcvLn324A/+rBut
         q6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Tbq1vEgEMTBoexcFc2qtiD/aGn5ZlYHghcweLEeR5g=;
        b=jWaGI78FAiL3dMDvOSkg0py9jRKydtsUJ0lz0DHilU9GpoMu2o1pps6e/fGKMGAhij
         oMYDf2VfAVn6QI3Fz1j84nNYVRt+F43YR/EAerca/o/Sr/jc5Rp/zyxMWjLW35StdVXi
         y4tUkk0ijQc+qA4g70uO34X79q5xa0PWyptn2COiljPVu73MwFqGBUDHMKqEHIIa+z1U
         dNL7UgJXPg485fcJnr7wwNNZIaEiX5ZQ0quE2TpDpnkJWHNl2btsDF5gAuquIfs8l2FY
         AQEoncet0V800rPK1RSO0W8MYITFxmRUqJIVW4jOaS93Rubahk7g7RGiCLdzoyVHDvug
         BNjg==
X-Gm-Message-State: AOAM530QMRr+5lcRKXAGuQe3TkzelzAl5yQUfZHLWMVLBrWs/l9nf+BG
        hJvauSwClzndE7kNCsqL0IIZjNc4NFJMfiu07nJboQ==
X-Google-Smtp-Source: ABdhPJzrKFcXvD8UGQex6ifrdPRSCJj6pNP9xshWqtwRuGwJwtq2eT4lnG+g4FskuKifR3eZvCCdsbEFzC8e4EL9GPI=
X-Received: by 2002:a4a:b28b:: with SMTP id k11mr7938155ooo.54.1605463902926;
 Sun, 15 Nov 2020 10:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20201114123648.97857-1-98.arpi@gmail.com> <CANpmjNNsVxGiGWeij-EsDUpc_fBBYg7iBynis1tQKwh8ks5jQw@mail.gmail.com>
 <3c0eb37e-aa9b-876c-6635-1f32181f4e5d@gmail.com>
In-Reply-To: <3c0eb37e-aa9b-876c-6635-1f32181f4e5d@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 15 Nov 2020 19:11:31 +0100
Message-ID: <CANpmjNNhpe6TYt0KmBCCR-Wfz1Bxd8qnhiwegwnDQsxRAWmUMg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Tim Bird <Tim.Bird@sony.com>, David Gow <davidgow@google.com>,
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

On Sun, 15 Nov 2020 at 13:18, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 15/11/20 2:28 pm, Marco Elver wrote:
> > On Sat, 14 Nov 2020 at 13:38, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >> Implementation of support for parameterized testing in KUnit. This
> >> approach requires the creation of a test case using the
> >> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
> >>
> >> This generator function should return the next parameter given the
> >> previous parameter in parameterized tests. It also provides a macro to
> >> generate common-case generators based on arrays. Generators may also
> >> optionally provide a human-readable description of parameters, which is
> >> displayed where available.
> >>
> >> Note, currently the result of each parameter run is displayed in
> >> diagnostic lines, and only the overall test case output summarizes
> >> TAP-compliant success or failure of all parameter runs. In future, when
> >> supported by kunit-tool, these can be turned into subsubtest outputs.
> >>
> >> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> >> Co-developed-by: Marco Elver <elver@google.com>
> >> Signed-off-by: Marco Elver <elver@google.com>
> >> ---
> >> Changes v6->v7:
> >> - Clarify commit message.
> >> - Introduce ability to optionally generate descriptions for parameters;
> >>   if no description is provided, we'll still print 'param-N'.
> >> - Change diagnostic line format to:
> >>         # <test-case-name>: <ok|not ok> N - [<param description>]
> >>
> >> Changes v5->v6:
> >> - Fix alignment to maintain consistency
> >>
> >> Changes v4->v5:
> >> - Update kernel-doc comments.
> >> - Use const void* for generator return and prev value types.
> >> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> >> - Rework parameterized test case execution strategy: each parameter is executed
> >>   as if it was its own test case, with its own test initialization and cleanup
> >>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
> >>   protocol once we have already started execution. Instead, log the result of
> >>   each parameter run as a diagnostic comment.
> >>
> >> Changes v3->v4:
> >> - Rename kunit variables
> >> - Rename generator function helper macro
> >> - Add documentation for generator approach
> >> - Display test case name in case of failure along with param index
> >>
> >> Changes v2->v3:
> >> - Modifictaion of generator macro and method
> >>
> >> Changes v1->v2:
> >> - Use of a generator method to access test case parameters
> >> Changes v6->v7:
> >> - Clarify commit message.
> >> - Introduce ability to optionally generate descriptions for parameters;
> >>   if no description is provided, we'll still print 'param-N'.
> >> - Change diagnostic line format to:
> >>         # <test-case-name>: <ok|not ok> N - [<param description>]
> >> - Before execution of parameterized test case, count number of
> >>   parameters and display number of parameters. Currently also as a
> >>   diagnostic line, but this may be used in future to generate a subsubtest
> >>   plan. A requirement of this change is that generators must generate a
> >>   deterministic number of parameters.
> >>
> >> Changes v5->v6:
> >> - Fix alignment to maintain consistency
> >>
> >> Changes v4->v5:
> >> - Update kernel-doc comments.
> >> - Use const void* for generator return and prev value types.
> >> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> >> - Rework parameterized test case execution strategy: each parameter is executed
> >>   as if it was its own test case, with its own test initialization and cleanup
> >>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
> >>   protocol once we have already started execution. Instead, log the result of
> >>   each parameter run as a diagnostic comment.
> >>
> >> Changes v3->v4:
> >> - Rename kunit variables
> >> - Rename generator function helper macro
> >> - Add documentation for generator approach
> >> - Display test case name in case of failure along with param index
> >>
> >> Changes v2->v3:
> >> - Modifictaion of generator macro and method
> >>
> >> Changes v1->v2:
> >> - Use of a generator method to access test case parameters
> >>
> >>  include/kunit/test.h | 51 ++++++++++++++++++++++++++++++++++++++
> >>  lib/kunit/test.c     | 59 ++++++++++++++++++++++++++++++++++----------
> >>  2 files changed, 97 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >> index db1b0ae666c4..cf5f33b1c890 100644
> >> --- a/include/kunit/test.h
> >> +++ b/include/kunit/test.h
> >> @@ -94,6 +94,9 @@ struct kunit;
> >>  /* Size of log associated with test. */
> >>  #define KUNIT_LOG_SIZE 512
> >>
> >> +/* Maximum size of parameter description string. */
> >> +#define KUNIT_PARAM_DESC_SIZE 64
> >
> > I think we need to make this larger, perhaps 128. I just noticed a few
> > of the inode-test strings are >64 chars (and it should probably also
> > use strncpy() to copy to description, which is my bad).
> >
>
> Okay, I will make the description size larger and use strncpy().

Thanks. There's also a report by the test robot now which noticed this.

> >>  /*
> >>   * TAP specifies subtest stream indentation of 4 spaces, 8 spaces for a
> >>   * sub-subtest.  See the "Subtests" section in
> >> @@ -107,6 +110,7 @@ struct kunit;
> > [...]
> >> +/**
> >> + * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
> >> + * @name:  prefix for the test parameter generator function.
> >> + * @array: array of test parameters.
> >> + * @get_desc: function to convert param to description; NULL to use default
> >> + *
> >> + * Define function @name_gen_params which uses @array to generate parameters.
> >> + */
> >> +#define KUNIT_ARRAY_PARAM(name, array, get_desc)                                               \
> >> +       static const void *name##_gen_params(const void *prev, char *desc)                      \
> >> +       {                                                                                       \
> >> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
> >
> > Why did you reintroduce a space between * and __next? AFAIK, this
> > should follow the same style as the rest of the kernel, and it should
> > just be 'thetype *ptr'.
> >
>
> I introduced this space because checkpatch.pl gave an error without the space:
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #1786: FILE: ./include/kunit/test.h:1786:
> +               typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
>
> But, if this is a mistake as it doesn't recognize __next to be a pointer, I will remove the space.

I think checkpatch.pl thinks this is a multiplication. It's definitely
a false positive. Please do format it like a normal pointer.

Thanks,
-- Marco
