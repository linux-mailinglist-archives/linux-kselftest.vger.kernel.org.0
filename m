Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF92A9CA2
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgKFSqK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 13:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgKFSqK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 13:46:10 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838BFC0613D2
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 10:46:10 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id k3so2124714otp.12
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElN3AyTjh5aMXmGHUFTcrTsMazikTf7o2LtiuSniYZ4=;
        b=D5+Q8S8gQ/D72X/54r2aCENNdmG3qQ/uSOs4qlrC+meTGrBxWzyUhbGN5AcVRTbEoX
         aBSlJSl6MMdPmek/r8GTKw7FWl8xaY2+bPHhNZzTHG/0p2owpuWq/aKHsdju2u8Fnvzi
         vUDnyU57uiirO5PL4roeYjBl10DFZqt4pZ5UO/cJGeBRMCpUP0Hh/3nCf1LJ50MLGTOb
         1mRyWLZT4mNkiGXwj1Y4seayHJZR0/rogLS8o4xfuxPZsiC75TDzUe7IbEPkul49oP6t
         YZmd+0T8fWEzyfDN/uM1DegNmzRu9xJlEABocHUEQaG6ygy2Lvg9lKy3Vb+HQqWkvMXg
         lY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElN3AyTjh5aMXmGHUFTcrTsMazikTf7o2LtiuSniYZ4=;
        b=qAzVT/MrBrcGxQLmi5PAM8mL2QGInNB7ukei2r4oW7JoLpDr99uPWPgmmh8jWfVn4c
         r4FctwRZIM83GUdlMEHtT1yruTNkOGVYWHVY2AT916exUXDGMb04KgPmJb/A1kHwYImW
         itZn1pQC+q9JWdYYfbs/aTC9S2trawcWWi6OgeL33+gjKmjln28JEKB4qM24Y/xrMD1H
         ca6bLYWIvUs+kXUdZsYDk1MOzCtfCX3DYOrgvbSPZU+Klxj3298mLqv271oVKQxc9rCg
         RgoWH35R1bT7bUY9eJaftKm8Do5LSjHF1Fi454pZoXHwmYOLNMvRMhI7ZVH4QhwnZ6IL
         09gA==
X-Gm-Message-State: AOAM5339NEZQJAuaJbaDWcesCZZNaN2fUI7ef4/CYwcuHfK6hd0Dw+4B
        /kzz6Rb63uQhEqhSfmQVee1W2VicYvg0aOD4csluDg==
X-Google-Smtp-Source: ABdhPJyh/Y4j/Wq2GsZz2D7bg/jo7/og/6yXxY6CRqxe+L0UEXv1UfKub2quFBwezIXP7sjaOGFzFmPQYxb0C85z3RU=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr1868950oth.251.1604688369657;
 Fri, 06 Nov 2020 10:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20201106182657.30492-1-98.arpi@gmail.com>
In-Reply-To: <20201106182657.30492-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 19:45:58 +0100
Message-ID: <CANpmjNPsACW1mZmkWiCSeXfvAGaxAS5sHtYMu0-DfE7ec2pFMA@mail.gmail.com>
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

On Fri, 6 Nov 2020 at 19:28, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit.
> This approach requires the creation of a test case using the
> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides
> a macro to generate common-case generators.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
[...]
> -       kunit_suite_for_each_test_case(suite, test_case)
> -               kunit_run_case_catch_errors(suite, test_case);
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               struct kunit test = { .param_value = NULL, .param_index = 0 };
> +               bool test_success = true;
> +
> +               if (test_case->generate_params)
> +                       test.param_value = test_case->generate_params(NULL);
> +
> +               do {
> +                       kunit_run_case_catch_errors(suite, test_case, &test);
> +                       test_success &= test_case->success;
> +
> +                       if (test_case->generate_params) {
> +                               kunit_log(KERN_INFO, &test,
> +                                       KUNIT_SUBTEST_INDENT
> +                                       "# %s: param-%d %s",
> +                                       test_case->name, test.param_index,
> +                                       kunit_status_to_string(test.success));

Sorry, I still found something. The patch I sent had this aligned with
the '(', whereas when I apply this patch it no longer is aligned. Why?

I see the rest of the file also aligns arguments with opening '(', so
I think your change is inconsistent.

Thanks,
-- Marco
