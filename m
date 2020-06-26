Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29C20B542
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgFZPug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgFZPug (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 11:50:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11775C03E97A
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 08:50:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x18so10875938lji.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gk7pt4o52R1i8UxPya9K/JTWryM486pinPKkTZZgiYo=;
        b=AIYwRD6MrE8AA7Ha12CddBuKx+00cURYa3xqNdHtCTmTW6RwVBMoR2saeKN//BMwdd
         1xn80jwdYnoAmfgvlsGrSChT0+xcx79vwYvma+GGVruZ/zYG9sb7D+R1o3oieOJoxHdG
         +kG1ZfV+LyJF56gGqqXi19Y57JW1r1QXW+VynSq89mzSz/YtugCUI3qUnEDKUaH3RAcl
         m6dNKfNHus0xeiqMTgRMganFy1wOYQJzHS/qCZ6nkY/pLph6RXjPCxWfFuAARtLTCZen
         JxsBSnD7V3y43vppubOalQ1RJoFHfRqSHxI7WiVGbSFYt4GHYllGuk01AnBqWKNuh0wE
         YWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gk7pt4o52R1i8UxPya9K/JTWryM486pinPKkTZZgiYo=;
        b=dLIuo5ZHC8F/a8/cKVOkVBGInOkBTrVg4TZuba7SK3V2jJfa0EoaLIncNiRFHzCdz7
         h30Jle4cABsTOyPaIMQU0t27tBnslhj9jC3cLO7HNcl2gFzX03gqo+gofUMTlYJQGbwD
         x8ITGhRs+t3Wrrhw/O84vrp6HXaCkrDAbI6VN3E/jNeANwUnwe9tSbvUJelHXK12REXu
         xzwcgSV/pvHuZGFVpWJYfPDBfIfYKjs2VF36rnVo6qq8XxIb+4DsRX5TQ2svuS5goMk2
         rYgwbaWaWXtVv2SpF1AQljsPrvpk1T7Uus6Daoi0/EJLtLPAwbJvvE5R4VSLHFaCKgjX
         y9tA==
X-Gm-Message-State: AOAM532f++bDWq32/6qUlIoAiu8A6YKeAsa7PCUpJV1yNXgaampEBiRX
        iXU4f+2ALXgOb22tewRQltnYuNgZ0kMsuYOiPghMAw==
X-Google-Smtp-Source: ABdhPJy007mkSDmCwqlRe0fuiCkW8krkuhDJ/3AKsVcjZLlDeZrfFysXPMdILGkTR9Zmd6tfShRU1ijZRDNdeUmnAwo=
X-Received: by 2002:a2e:9116:: with SMTP id m22mr1780104ljg.431.1593186634379;
 Fri, 26 Jun 2020 08:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200508065356.2493343-1-mpe@ellerman.id.au> <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
 <202006242312.8888AAFE@keescook>
In-Reply-To: <202006242312.8888AAFE@keescook>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 26 Jun 2020 21:20:22 +0530
Message-ID: <CA+G9fYtdF__9bGneXkuv3E7djg1rbhrQ=DCf6d7_t9hyBZRL2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
To:     Kees Cook <keescook@chromium.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 25 Jun 2020 at 11:46, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 02:21:38PM +0530, Naresh Kamboju wrote:
> > On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >  # Record and dump the results
> > > -dmesg -c >"$LOG"
> > > +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> >
> > We are facing problems with the diff `=%>` part of the option.
> > This report is from the OpenEmbedded environment.
> > We have the same problem from livepatch_testcases.
>
> Does "comm" exists in those environments?
>
> dmesg | comm -13 "$DMESG" - > "$LOG" || true

"comm" works in our environment.

- Naresh
