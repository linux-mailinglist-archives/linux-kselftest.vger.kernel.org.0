Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A562696AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 22:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgINUc2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgINUcL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 16:32:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978BAC061788
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Sep 2020 13:32:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gf14so488608pjb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Sep 2020 13:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MAegNs4VOwWv9UrQbG/3KsC+fif9tz3H9h+v9DTenlg=;
        b=fLq43tsj0idL5YeRKTDNHNUi+/bcp9W/YMHPxve4qth42qg71hfTUM5Xq3cazIdDrI
         NFB+4SH1S70GAC48b8DplcyZACd4EXVyXgXskD80RFmDCDa/3pUt9RLyrlu1vxpWwB4f
         i2X0eeheLlVij915s5y5BUr4hEXriYpLc1OPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MAegNs4VOwWv9UrQbG/3KsC+fif9tz3H9h+v9DTenlg=;
        b=hDX/AnQBJkjmH3dG8+gJiC8/dcGMk3JCKt/PRISlbl6bT7yv+jgG0ZKdU5TRdysb6r
         FgUWv5jEcC4r6eL1Rxh9cRyXG/LdCzkti3775w4ovjjCTST6g0tTglIR+9Uvc89sVXha
         d8HN+ui9pU5ypc8FUynscDZadosi2thVuJkqdPe7ZNIbjIlljchp4xfhx5pflzgue7PI
         tfEjAOjLrAN6mXCVHfooYtsLLSlQVcCaeTnTebc4ed/41l/Cud2qkUUHoz0bU+3Z8B1/
         X/JvhGFdhxsHv1MopFgxSDoXeBExt+vkPKSrN/Ss37Mbi4jO6ssDQELX42Dive74iN+A
         jc+A==
X-Gm-Message-State: AOAM532SvP22yXJGRxYCFbdQdpia9hm4mD6wFe+GiwgH42q70Y1nmJOW
        p5GyJorOidBgKka6/ZyZZg56AQ==
X-Google-Smtp-Source: ABdhPJwLrAeD4ZMb7OCOucEtPSfmxZNEDPJonNkzAiZJUR7jlcfwd9QjlJseUiJhoAyO2uqhAGri2A==
X-Received: by 2002:a17:90b:364c:: with SMTP id nh12mr972235pjb.182.1600115531070;
        Mon, 14 Sep 2020 13:32:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j19sm11207357pfi.51.2020.09.14.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:32:10 -0700 (PDT)
Date:   Mon, 14 Sep 2020 13:32:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/15] selftests/seccomp: Refactor change_syscall()
Message-ID: <202009141321.366935EF52@keescook>
References: <20200912110820.597135-1-keescook@chromium.org>
 <87wo0wpnah.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo0wpnah.fsf@mpe.ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 14, 2020 at 10:15:18PM +1000, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > Hi,
> >
> > This refactors the seccomp selftest macros used in change_syscall(),
> > in an effort to remove special cases for mips, arm, arm64, and xtensa,
> > which paves the way for powerpc fixes.
> >
> > I'm not entirely done testing, but all-arch build tests and x86_64
> > selftests pass. I'll be doing arm, arm64, and i386 selftests shortly,
> > but I currently don't have an easy way to check xtensa, mips, nor
> > powerpc. Any help there would be appreciated!
> 
> The series builds fine for me, and all the tests pass (see below).
> 
> Thanks for picking up those changes to deal with powerpc being oddball.
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Awesome; thanks!

However...

> 
> cheers
> 
> 
> ./seccomp_bpf
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> #  RUN           global.kcmp ...
> #            OK  global.kcmp
> ok 1 global.kcmp
> [...]
> #  RUN           global.KILL_thread ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.

Was this a mis-paste, or has something very very bad happened here in
global.KILL_one_arg_six finishes?

> #  RUN           global.kcmp ...
> #            OK  global.kcmp
> ok 1 global.kcmp
> [...]
> #  RUN           global.user_notification_basic ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_basic ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_signal ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_closed_listener ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_child_pid_ns ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_sibling_pid_ns ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_sibling_pid_ns ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_sibling_pid_ns ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_fault_recv ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_continue ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_filter_empty ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_filter_empty_threaded ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_addfd ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_addfd_rlimit ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> # PASSED: 86 / 86 tests passed.
> # Totals: pass:86 fail:0 xfail:0 xpass:0 skip:0 error:0

And after every user_notification test? O_O

-- 
Kees Cook
