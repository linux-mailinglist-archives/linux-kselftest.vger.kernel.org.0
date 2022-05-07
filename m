Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9751E7FB
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 May 2022 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443019AbiEGPHb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 May 2022 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244346AbiEGPHa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 May 2022 11:07:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5699240931;
        Sat,  7 May 2022 08:03:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r27so10970950iot.1;
        Sat, 07 May 2022 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnjdUOz3duiKD1Uau0ijtSb5UBL+OJmQOYvavWmoZQ0=;
        b=Goshd/Luda+YskWKjL4mFxR2CewMKg4Ngp0zTFvr681Uze/6UoYKLSsCuvwyykKdoV
         eJgShn/IfVaDwDxxqtuVaiypmwMCNkgs3U7eD/IHcA+NTKJnwNJDfV75hCAxJn6fhlbn
         65xdlhRV1o+T88gQd3VVfV6lPkB4h/kQdWVILeyrrRGThVgkiWqwoup9fFr2v39EUzxX
         2bCMEg8qAMivg4zNvG6un1RFKMTRIwY+K2H9Et54yjnONGwjlXCMIgrhaWsbrSHJ3CbF
         dLPxj2t56sOAmQTcpErCwm8om2QTvopW9vHpR2ZQYiHU3j7DhQkX5H4ADEhJCh74VYJo
         UmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnjdUOz3duiKD1Uau0ijtSb5UBL+OJmQOYvavWmoZQ0=;
        b=uQwl1WcM4hqKqDf/VXMysjxebO7MTn1UD6SXOt3RW0duYIbmJUeqnxie2UlzxG14Q3
         hSZFC9JFwoHjThRJ/t1VAkctljPRI4lnyX47cPLHU/93w/2twGX/5eIG9ME/0mm/GUgM
         /vMm7ms7dfk6gZkawROjKuea6x1hIXd2eSD8PWe87ZzIJoOq6XZca1Tr7YvAFh42IlkV
         ZZxyMonpdkXYiY/hFBgzfuXGD+0Up8E8qOvSDbjbQHFvwvmMVt8KO2wD/Rmb9WxbPQed
         ZjAzVQopu9P+YbARGPu7+YqAYaQ7XXavSFF1HNz+WPYdA6ybDItBrf5X+6EEAfKb1M0Z
         y98g==
X-Gm-Message-State: AOAM532XvPJhbYgjGxqij3RnHWVZFflzi6UlgJNwdFzcG6QV02+og18C
        efdU+g7OJnBOCHCIl9ZJMvNY5O3ba7tLgUwy8O1cqjt/hjw=
X-Google-Smtp-Source: ABdhPJyqVxv4uPynhji9t5jG0pJBv2D9XRWPEuRPww2y6vJC30NvmsubB9I6YkkamF8cCOWGkn9Xe0Ihs9a1gxmTp/4=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr3321613iow.172.1651935822769; Sat, 07
 May 2022 08:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <CABVgOSm5S2=QYnHJ+B0JbYtFYKBDRZiOhE5YMKKUKZU56d17HQ@mail.gmail.com>
In-Reply-To: <CABVgOSm5S2=QYnHJ+B0JbYtFYKBDRZiOhE5YMKKUKZU56d17HQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 May 2022 17:03:31 +0200
Message-ID: <CANiq72=0ft6+QLbdwWD6cLm4FhWfv53GSg6HKEwxQ-q2N-UkOw@mail.gmail.com>
Subject: Re: [PATCH v6 00/23] Rust support
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Sat, May 7, 2022 at 11:29 AM David Gow <davidgow@google.com> wrote:
>
> It's great to see some KUnit support here!

Thanks!

> It's also possible to run these tests using the KUnit wrapper tool with:
> $ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_RUST=y
> --make_options LLVM=1 --arch x86_64 'rust_kernel_doctests'
>
> That also nicely formats the results.

Indeed!

    [16:55:52] ============ rust_kernel_doctests (70 subtests) ============
    [16:55:52] [PASSED] rust_kernel_doctest_build_assert_rs_12_0
    [16:55:52] [PASSED] rust_kernel_doctest_build_assert_rs_55_0
    ...
    [16:55:52] [PASSED] rust_kernel_doctest_types_rs_445_0
    [16:55:52] [PASSED] rust_kernel_doctest_types_rs_509_0
    [16:55:52] ============== [PASSED] rust_kernel_doctests ===============
    [16:55:52] ============================================================
    [16:55:52] Testing complete. Passed: 70, Failed: 0, Crashed: 0,
    Skipped: 0, Errors: 0

> That all being said, I can't say I'm thrilled with the test names
> here: none of them are particularly descriptive, and they'll probably
> not be static (which would make it difficult to track results /
> regressions / etc between kernel versions). Neither of those are

Yeah, the names are not great and would change from time to time
across kernel versions.

We could ask example writers to give each example a name, but that
would make them fairly less convenient. For instance, sometimes they
may be very small snippets interleaved with docs' prose (where giving
a name may feel a bit of a burden, and people may end writing
`foo_example1`, `foo_example2` etc. for each small "step" of an
explanation). In other cases they may be very long, testing a wide API
surface (e.g. when describing a module or type), where it is also hard
to give non-generic names like `rbtree_doctest`. In those kind of
cases, I think we would end up with not much better names than
automatically generated ones.

The other aspect is that, given they are part of the documentation,
the prose or how things are explained/split may change, thus the
doctests as well. For instance, one may need to split a very long
`rbtree_doctest` in pieces, and then the name would need to change
anyway.

So I think we should avoid asking documentation writers to add a
manual name, even if that means a bit ugly test names. Also this way
they are consistently named. What do you think?

One idea could be giving them a name based on the hash of the content
and avoiding the line number, so that there is a higher chance for the
name to stay the same even when the file gets modified for other
reasons.

> necessarily deal breakers, though it might make sense to hide them
> behind a kernel option (like all other KUnit tests) so that they can
> easily be excluded where they would otherwise clutter up results. (And

Currently they are under `CONFIG_RUST_KERNEL_KUNIT_TEST` -- or do you
mean something else?

> if there's a way to properly name them, or maybe even split them into
> per-file or per-module suites, that would make them a bit easier to
> deal.) Additionally, there are some plans to taint the kernel[1] when

Yeah, splitting them further is definitely possible. We are also
likely splitting the `kernel` crate into several, which would also
make the suites smaller etc. so perhaps further splits may not be
needed.

> Regardless, this is very neat, and I'm looking forward to taking a
> closer look at it.

Thanks again for taking a look and playing with it, I am glad you
liked it! (even if it is just a first approximation, and only supports
the `kernel` crate, etc.).

Cheers,
Miguel
