Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2109236ACAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Apr 2021 09:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhDZHHc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Apr 2021 03:07:32 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:17394 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhDZHH3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Apr 2021 03:07:29 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 13Q76IZo017712;
        Mon, 26 Apr 2021 16:06:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 13Q76IZo017712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1619420779;
        bh=TQwmFx5qYzKQCr2bCLGzTGQ0ErVGGivC1LugG10SO70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Px1iLyXhYx+tyTEyy/GWZ04rwR9kUXnBybL//ouGmPX0MAlcjfLSrYf31hy2gP9fn
         QpFoMPDSQeqizb9ccBxUBU2smPOFlCh18D0LHKTulvOVhVPjl69l2HVAgz2mbIuIxN
         T6nfpzRs6QBKAjGY/zevEK0iu6Hi1LjBm4EdSeB+O9HzkTdZrs/zuc6RwDuks0PyPr
         eoba9j37aNtTOfnBiYzN8fsxWVAWo1LZ4UGlYDH1xp1VP6jgQU2OHCNTjBer76V9u9
         M0MoP89hP4N9IfKlqneAEpT785PP7rSgAgDXi7EIXK2hzmrIPMok+BZ82WOWK88hUe
         qZvovOE6WIETg==
X-Nifty-SrcIP: [209.85.215.177]
Received: by mail-pg1-f177.google.com with SMTP id p12so39455414pgj.10;
        Mon, 26 Apr 2021 00:06:19 -0700 (PDT)
X-Gm-Message-State: AOAM531p8s36x2SN9wpS57O4BG+2ENSN1i7gwtcV4uLy2n00q2vscnfB
        PbkyhdJA6CZJKKzdt9Dq5zGnFSIQAtogFu0WTmo=
X-Google-Smtp-Source: ABdhPJyosHZAAd3InPOj/5Dpnl4f158mJISS9oyu+OUE6N+z4fTrgTW5NL0STd4f5A1S+IXR2vEK2zu9ncn0dCCHUHw=
X-Received: by 2002:a05:6a00:b4b:b029:276:6388:a3ac with SMTP id
 p11-20020a056a000b4bb02902766388a3acmr4043608pfo.80.1619420778334; Mon, 26
 Apr 2021 00:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <YIRryUf6noodWiqe@smtp.gmail.com>
In-Reply-To: <YIRryUf6noodWiqe@smtp.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 26 Apr 2021 16:05:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATsbkhYHk6NCZJCDrtT0NFfBwe_n9GRSrEvURaXaW+gfg@mail.gmail.com>
Message-ID: <CAK7LNATsbkhYHk6NCZJCDrtT0NFfBwe_n9GRSrEvURaXaW+gfg@mail.gmail.com>
Subject: Re: Running kunit_tool on unclean trees
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andersonreisrosa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 25, 2021 at 4:05 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi, a friend and I were chasing bug 205219 [1] listed in Bugzilla.
> We step into something a little bit different when trying to reproduce
> the buggy behavior. In our try, compilation failed with a message form
> make asking us to clean the source tree. We couldn't run kunit_tool
> after compiling the kernel for x86, as described by Ted in the
> discussion pointed out by the bug report.
>
> Steps to reproduce:
>
> 0) Run kunit_tool
> $ ./tools/testing/kunit/kunit.py run
> Works fine with a clean tree.
>
> 1) Compile the kernel for some architecture (we did it for x86_64).
>
> 2) Run kunit_tool again
> $ ./tools/testing/kunit/kunit.py run
> Fails with a message form make asking us to clean the source tree.

This is probably because
tools/testing/kunit/kunit_kernel.py
runs make with O= option.



> Removing the clean source tree check from the top-level Makefile gives
> us a similar error to what was described in the bug report. We see that
> after running `git clean -fdx` kunit_tool runs nicely again. However,
> this is not a real solution since some kernel binaries are erased by git.
>
> We also had a look into the commit messages of Masahiro Yamada but
> couldn't quite grasp why the check for the tree to be clean was added.
> We could invest more time in this issue but actually don't know how to
> proceed. We'd be glad to receive any comment about it. We could also try
> something else if it's a too hard issue for beginners.

I think you are talking about the following error message.

***
*** The source tree is not clean, please run 'make mrproper'
*** in /home/masahiro/ref/linux
***



Kbuild checks if the source tree is clean
before starting the out-of-tree build
because the out-of-tree build relies on VPATH.

This check has existed for a long time. (at least more than a decade)

If Kbuild started the O= build with a dirty source tree,
some stale generated source files would have been remaining.
(some *.c and *.h are generated by scripts)

Then, Kbuild would wrongly use stale source files in srctree
instead of generating new ones in objtree.





> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=205219
>
>
> Best Regards,
>
> Marcelo



--
Best Regards
Masahiro Yamada
