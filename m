Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCCD51E60F
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 May 2022 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446166AbiEGJdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 May 2022 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446159AbiEGJdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 May 2022 05:33:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5094A5622E
        for <linux-kselftest@vger.kernel.org>; Sat,  7 May 2022 02:29:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k2so13018247wrd.5
        for <linux-kselftest@vger.kernel.org>; Sat, 07 May 2022 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O46NG4I/Ehd11dycpk2RjsN/cJ86swAD+6NyN8Wu3oM=;
        b=pEJT+rz+VfSx+i3BXIXcXBka/5Yg7AcIDPJqzI64zSkN1WUpTztaU5kum35UgrsfF9
         DzOjJPlOXIfoUzWT5jSe26grmDrcE5y4YRZ4YR+l+KCgM4xNILwg4UsizkKWsczzl+De
         nX6pK3uT0jQrV4KFZSgHFgFeD2qqS/Q51S4GZiQOJ4lfG8T7AE63PEcYjY2oxMoY9aqJ
         KPWdvUwiryRluS9vjmaRgu1H83GjAAQS1C7TsJMRlMrMgQMCmzL3mmrDMbW3OJyOj5Y9
         EQP9LAp0ElcPFJCYbA8qRiTa5YvhVwVsbiztmAuOvi5ZjZGIAm5UQjWZ/T6CG7ioVXxa
         fe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O46NG4I/Ehd11dycpk2RjsN/cJ86swAD+6NyN8Wu3oM=;
        b=0lu9MFAlKOi2ssURMls1ysq1mZppvU6PApWBpVjYtAMAAmS5gGSdij6JX2MJe3MmCy
         ggcMmYXA8rJlLzGeQnERCl/NR5ZeQl2JhWNfnSnNIUzbRbsRfz8h5UT5I5WBGrLU7Axe
         GA92RBpWcnBUIdly/JN/5OQkGP/G0HnU06JtdYShItm5M/KM/U+OYT5062BP2knkJEOc
         Yirfowgferd0unK6zQe42suvUQiOnaQBCFA+btKpE1rfZ/mSptHnOE5Z3GtoOjpkithz
         xwoqeVh/43Ro6PLC+/CSqLrg53xiBFrFAntBwU9HIFwBLAMwv1DrPpoCdcQmbgBnsMZ2
         IDJQ==
X-Gm-Message-State: AOAM533aZW+q2R2+LhDjm+Nh8fr7N9OjIWeDHNpytXpfIbStaJOaIgWD
        4eFvu6Kbn5o3XwNXbUuQ/SxoGvXKjUJxDOhdhiIwUA==
X-Google-Smtp-Source: ABdhPJwmX5iwSt0ucutb+u1FHWUawG0af5FN3nvZMbahKeV3F7Ce0O0VSgqTSlIoIeUQl+Jhb3u7MOWpzqebYk3FohA=
X-Received: by 2002:a5d:4307:0:b0:207:9f82:e238 with SMTP id
 h7-20020a5d4307000000b002079f82e238mr6283084wrq.430.1651915754752; Sat, 07
 May 2022 02:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 May 2022 17:29:03 +0800
Message-ID: <CABVgOSm5S2=QYnHJ+B0JbYtFYKBDRZiOhE5YMKKUKZU56d17HQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/23] Rust support
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 7, 2022 at 1:25 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Rust support
>

<...>

>   - Support running documentation tests in-kernel, based on KUnit.
>
>     Rust documentation tests are typically examples of usage of any
>     item (e.g. function, struct, module...). They are very convenient
>     because they are just written alongside the documentation, e.g.:
>
>         /// Sums two numbers.
>         ///
>         /// # Examples
>         ///
>         /// ```
>         /// assert_eq!(mymod::f(10, 20), 30);
>         /// ```
>         pub fn f(a: i32, b: i32) -> i32 {
>             a + b
>         }
>
>     So far, we were compiling and running them in the host as any
>     other Rust documentation test. However, that meant we could not
>     run tests that used kernel APIs (though we were compile-testing
>     them, which was already useful to keep the documentation in sync
>     with the code).
>
>     Now, the documentation tests for the `kernel` crate are
>     transformed into a KUnit test suite during compilation and run
>     within the kernel at boot time, if enabled. This means now we can
>     run the tests that use kernel APIs.
>
>     They look like this (their name is generated by `rustdoc`, based
>     on the file and line):
>
>         [    0.581961] TAP version 14
>         [    0.582092] 1..1
>         [    0.582267]     # Subtest: rust_kernel_doctests
>         [    0.582358]     1..70
>         [    0.583626]     ok 1 - rust_kernel_doctest_build_assert_rs_12_0
>         [    0.584579]     ok 2 - rust_kernel_doctest_build_assert_rs_55_0
>         [    0.587357]     ok 3 - rust_kernel_doctest_device_rs_361_0
>         [    0.588037]     ok 4 - rust_kernel_doctest_device_rs_386_0
>
>         ...
>
>         [    0.659249]     ok 69 - rust_kernel_doctest_types_rs_445_0
>         [    0.660451]     ok 70 - rust_kernel_doctest_types_rs_509_0
>         [    0.660680] # rust_kernel_doctests: pass:70 fail:0 skip:0 total:70
>         [    0.660894] # Totals: pass:70 fail:0 skip:0 total:70
>         [    0.661135] ok 1 - rust_kernel_doctests
>
>     There are other benefits from this, such as being able to remove
>     unneeded wrapper functions (that were used to avoid running
>     some tests) as well as ensuring test code would actually compile
>     within the kernel (e.g. `alloc` used different `cfg`s).

It's great to see some KUnit support here!

It's also possible to run these tests using the KUnit wrapper tool with:
$ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_RUST=y
--make_options LLVM=1 --arch x86_64 'rust_kernel_doctests'

That also nicely formats the results.

(It obviously doesn't run under UML yet, though I did get it to work
after indiscriminately hacking out everything that wasn't supported.
Assuming we can hide the irq and iomem stuff behind the appropriate
config options, and rework some of the architecture detection to
either support SUBARCH or check for X86_64 instead of X86, it should
be pretty easy to get going.)

That all being said, I can't say I'm thrilled with the test names
here: none of them are particularly descriptive, and they'll probably
not be static (which would make it difficult to track results /
regressions / etc between kernel versions). Neither of those are
necessarily deal breakers, though it might make sense to hide them
behind a kernel option (like all other KUnit tests) so that they can
easily be excluded where they would otherwise clutter up results. (And
if there's a way to properly name them, or maybe even split them into
per-file or per-module suites, that would make them a bit easier to
deal.) Additionally, there are some plans to taint the kernel[1] when
KUnit tests run, so having a way to turn them off would be very
useful.

Regardless, this is very neat, and I'm looking forward to taking a
closer look at it.

Cheers,
-- David

[1]: https://lore.kernel.org/linux-kselftest/20220429043913.626647-1-davidgow@google.com/
