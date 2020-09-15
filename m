Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C765426B91E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Sep 2020 02:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIOLM6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 07:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIOLMp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 07:12:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F6C06174A;
        Tue, 15 Sep 2020 04:12:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z22so4437072ejl.7;
        Tue, 15 Sep 2020 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4bOYSHsWHocnYArElpYthybN5SxC006LAFmz/36FHU=;
        b=Z/MAEsVTEnQKv9yb0HSOEZbJscLkrEI2KA6jePSwMg1TwHWUG2zmL/K+AbtjHO6/2o
         aIcnbhckWr6rgCmNGSrXn/T9XMsHZZKm/PsdMekg45hebYJEoEh6DtSQc6AwPL0FexMQ
         QEcy40U+GKpucQlCREx876BJYFzTaICPrYW4syFH6C95NZecWVgDFi7ziO/VvX17lotJ
         DDZY+9PHfKcooxB486MYcbnHky26yYukszeQjs76Kwm/6X3Co9rV5HLW0BzJkHQ4SNlQ
         948TjdNG8+d8rKLvuzJokO+1T8T3AZzYmxIxeK7CMSgHmOVQw0cHLexkCCkg+JNIGJLn
         Ny/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4bOYSHsWHocnYArElpYthybN5SxC006LAFmz/36FHU=;
        b=JylZ1zrcUFvjjAjzNM5oeIOUN2UCaOTkDESSxSRb0bPB6Sr/IPrjM2RqcNIuNaTFnt
         szDWL0/a6c4VmpMkajWoh3G1f4fkUb23pNscttHfyE5YcXsOqt6s80T0vW0oEgrYQax7
         w1A07oRnsYzJMWjMhllr8KHaFPjQcpyVkCeRj6Yty5PvvIPgB4AUuekP4WiKsbKxnesL
         lxAYhQ8arCoNJB9vEE04yzmS8keenNT6wgRzridBEJ2HnM9cErNU9e9gMeOQtqVmnTfH
         wsQvvrP+AqL7MnBfWER0VAziN3AcStVoLpb8lJ84P+x0UR5o/lI18gPS0WIrXgJdxdAa
         SGyQ==
X-Gm-Message-State: AOAM531bmONJCFQT3H+0vuqNMhZjJHmHf9YY4WRJsVsYEancMGo3B0rm
        yOGQWs2HemLZdlxzimQ+Pf+7rsOmJ/IIF3x3z+rJrYgo
X-Google-Smtp-Source: ABdhPJwPU+9ZWIwNO56zgtgygOIdmPreND4z7Ge5DlUnTt0Tfg9IxfvCSMJOXmsXBV/ZabpWxbhtETys6v+wayV6BRQ=
X-Received: by 2002:a17:906:30c5:: with SMTP id b5mr19838526ejb.98.1600168356388;
 Tue, 15 Sep 2020 04:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200912110820.597135-1-keescook@chromium.org>
 <87wo0wpnah.fsf@mpe.ellerman.id.au> <202009141321.366935EF52@keescook>
In-Reply-To: <202009141321.366935EF52@keescook>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 15 Sep 2020 04:12:24 -0700
Message-ID: <CAMo8BfK0Jcmt4EJ1R2d_4Hp9siSRrBsgaNDqCVjcQ0GK8XBGZA@mail.gmail.com>
Subject: Re: [PATCH 00/15] selftests/seccomp: Refactor change_syscall()
To:     Kees Cook <keescook@chromium.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 14, 2020 at 1:32 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Sep 14, 2020 at 10:15:18PM +1000, Michael Ellerman wrote:
> > Kees Cook <keescook@chromium.org> writes:
> However...
>
> >
> > cheers
> >
> >
> > ./seccomp_bpf
> > TAP version 13
> > 1..86
> > # Starting 86 tests from 7 test cases.
> > #  RUN           global.kcmp ...
> > #            OK  global.kcmp
> > ok 1 global.kcmp
> > [...]
> > #  RUN           global.KILL_thread ...
> > TAP version 13
> > 1..86
> > # Starting 86 tests from 7 test cases.
>
> Was this a mis-paste, or has something very very bad happened here in
> global.KILL_one_arg_six finishes?

I observe similar output corruption on xtensa when I redirect test output
into a file or pipe it to 'cat'. When it goes to the terminal it looks normal.

-- 
Thanks.
-- Max
