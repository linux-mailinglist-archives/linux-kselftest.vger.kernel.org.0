Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616CF2D8003
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391739AbgLKU2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 15:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbgLKU2Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 15:28:24 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94CCC0613CF
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Dec 2020 12:27:43 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id k4so7407349qtj.10
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Dec 2020 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxQRcgZ57qjzJh7BvMLhV37MMlxNs43EUrF1vU/yGZU=;
        b=nrurt71go8dURqiLI/e2i4djK7ea0xPI4EmUSTnhhQsdi3clEfJKra77IRz0wg6yUN
         UmZtUcmexvGmbBIP1vU/F64/PR7ayXLawLHrEL6no6KluITNweWUcdErlUnFrRNclvhX
         uFX/HT5Ss1pq0WRbDc1RpzOA5nz8nPSlMIgrB/+NaoNbykJlJC+o20NZXmSipI2VuXUq
         FyLnQtqBJV4O0FddEE8D4/V2DuR/HdtsJ8CdoObOksUnlWN/cCPken9kLV9lPU6NJPGH
         X82kStUmE6BZaZS+RT8NUmyI/5UiNHV7lAQv0OjtNucRhilbptk0SyAW32lH5Ukwibw9
         xXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxQRcgZ57qjzJh7BvMLhV37MMlxNs43EUrF1vU/yGZU=;
        b=QZcoAs50P7ENYKAVAotU2HeZBnd/47PuVM8bBH0/0Hjb60z8wzj7Hlf7YCeSCpxdOF
         3SXBWXZBX+HixTr2g7+6eptOaoy5BFT2DRcc1xb85kKFtUIoOJd9ayKUeamCj1TsdwA3
         cl/oCQte9hl9CAkBzjKNdhDyDRz1b0wcX3uGrDnSOjguuTDcRbUj40k5jSXPhBpZRYJW
         7hiuh6LHxup7R+e3A954K6xRiFoiR88zb9rk9zxAuGeg186IYsAsi2zWt8Jexse5PfQI
         CwK+ATMdqWYbx5hHKrRHja2PWRhA+q0+LTZetgW+uAD6lvZbjOAq32wEZLg7R19trO8Z
         1DJg==
X-Gm-Message-State: AOAM532Oo+LsvwS+QWwUYiW7JK6lWrxqRrfIZAAlo+Ir+iIQk1paeNsS
        YYGAkJkIQGYHaRDuPaPTV0xyfXgqFPPb3s9sP2tBkw==
X-Google-Smtp-Source: ABdhPJwKhJkjDBa/HBYQWBJavEqlSMqWfgTRJzP4rY1FNqLCK7OjrhsPb+JhGumknOwKFJu6fFFVYNlks6t97T4fAYU=
X-Received: by 2002:ac8:5802:: with SMTP id g2mr17284210qtg.383.1607718462773;
 Fri, 11 Dec 2020 12:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20201203221005.2813159-1-adelg@google.com> <CAKwvOdk6=TgL+f2-WvE7tsK0rN1XQ+NdXmeJfDkLsa8xPmgipA@mail.gmail.com>
 <CAEHm+vHtMQtMThgE_BwpiBS5v0a61L_TW9vgKLaFTtcgg9HSgA@mail.gmail.com> <e78c3b86-78ab-2b2e-d8be-e9118d7d2392@linuxfoundation.org>
In-Reply-To: <e78c3b86-78ab-2b2e-d8be-e9118d7d2392@linuxfoundation.org>
From:   Andrew Delgadillo <adelg@google.com>
Date:   Fri, 11 Dec 2020 12:27:31 -0800
Message-ID: <CAEHm+vHXeuo6cPKOyCgCqLA1a8O8g9wgKVMi+4ifLN__BPVQbA@mail.gmail.com>
Subject: Re: [PATCH] selftests: propagate CC to selftest submakes
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 4:31 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 12/10/20 5:10 PM, Andrew Delgadillo wrote:
> > On Thu, Dec 10, 2020 at 3:08 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >>
> >> On Thu, Dec 3, 2020 at 2:10 PM Andrew Delgadillo <adelg@google.com> wrote:
> >>>
> >>> lib.mk defaults to gcc when CC is not set. When building selftests
> >>> as part of a kernel compilation, MAKEFLAGS is cleared to allow implicit
> >>> build rules to be used. This has the side-effect of clearing the CC
> >>> variable, which will cause selftests to be built with gcc regardless of
> >>> if we are using gcc or clang. To remedy this, propagate the CC variable
> >>> when clearing makeflags to ensure the correct compiler is used.
> >>>
> >>> Signed-off-by: Andrew Delgadillo <adelg@google.com>
> >>
> >> Hi Andrew, thanks for the patch. Can you walk me through how to build
> >> the selftests?
> >>
> >> Documentation/dev-tools/kselftest.rst says:
> >> $ make -C tools/testing/selftests
> >>
> >> And if I do:
> >> $ make CC=clang defconfig
> >> $ make CC=clang -C tools/testing/selftests -j
> >>
> >> I observe a spew of errors.  If I apply your patch and rerun the
> >> above, I see what looks like the same spew of errors.  Am I "holding
> >> it wrong" or could the docs use a refresh?
> >>
> >
> > Hi Nick, sure thing!
> >
> > I also see a slew of errors when building with make -C
> > tools/testing/selftests. However, that is not the problem I am trying
> > to solve. I believe we are seeing errors building that way because it
> > is missing some make variables that are normally set up when building
> > from the kernel's top level makefile.
> >
>
> Both options are supported and should work.
>
> make -C tools/testing/selftests
> make kselftest
>
> That being said, I use gcc. Can you send the errors you are seeing?
> It is possible, a few tests aren't building and need to be fixed
> for clang and gcc.
Most of the errors I saw, I was able to fix by installing the correct
packages to get some missing headers, so in those cases nothing is
broken about the tests. However, after that the errors still remaining
look like so (I've done my best to deduplicate similar errors):

clone3_cap_checkpoint_restore.c: In function 'clone3_cap_checkpoint_restore':
clone3_cap_checkpoint_restore.c:148:9: error: expected expression
before 'return'
   XFAIL(return, "Skipping all tests as non-root\n");
         ^
make[3]: *** [../lib.mk:139:
/usr/local/google/home/adelg/projects/upstream/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore]
Error 1

memfd_test.c: In function 'test_seal_future_write':
memfd_test.c:783:27: error: 'F_SEAL_FUTURE_WRITE' undeclared (first
use in this function)
  mfd_assert_add_seals(fd, F_SEAL_FUTURE_WRITE);
                           ^
memfd_test.c:783:27: note: each undeclared identifier is reported only
once for each function it appears in

/usr/local/***/lib/../lib64/librt.so: undefined reference to
`pthread_attr_setstacksize@GLIBC_2.2.5'
collect2: error: ld returned 1 exit status

There are also bpf selftest errors, but I know for a fact those are
just an artifact of me not having llvm-readelf and other binaries in
my PATH as I've compiled those successfully before.
>
> thanks,
> -- Shuah
>
