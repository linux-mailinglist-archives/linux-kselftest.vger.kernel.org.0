Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A22352FBF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhDBT2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhDBT2G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 15:28:06 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23090C0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 12:28:05 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h7so5375045ilj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvLOmR8hOfY+uCNhb7dxbq3LfXDPCC5IsmH1087GMzs=;
        b=PdXbMsh17ip1drpwdORfoUdC4HWO0D78cliNxc/WjvcT1H1MaW2oEHRjcs1ILKaJhQ
         If9L2kSbzXWZVsf/uI7u6q4UupZy8aJsryWS1EC3VazyNrfHQzCJtZq+8gkxhIjt4z1k
         94vlhikIqGwZiGvF+/Z0MDwULsSYqMBbj/4xLh8+xhhAF9Vv/wxzOtHiHud1d2FKCEzq
         QADzf+SaAVvaKFpgBMzE41ZxfN6/FYNMHYOFPk84Rw6JWptzFk3SqxN5LjxZjLNeLmlV
         PwEt8aKKcNVuCkh1e1y6NSXHhwXxM72Ej2zdJrdgakep8rACDggA2QT1viLIMONintjd
         P6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvLOmR8hOfY+uCNhb7dxbq3LfXDPCC5IsmH1087GMzs=;
        b=p5dhDLNcfZw6uo6EhE4B2BpmpPdZDHq/Ct9ZeVm8BDvB++A47Q15cDe0Wj/85fssSO
         s8ZPZ9PCigxfFJGQmrDeaxTAMCJPCqY+a6KOIUx8IrjHD9ueq9AzvbGM9OoUhLrNkx14
         oEEbHqsrKrMuEDTI67qNA79tU+Rx+1V2pjOqp/kIZtKnFLBUNcsyTLuG39W9/dwkZYZP
         P2kRxu40S7uSCACU0CTObVGeC6ylyqCWwHR9cfdJLfcRDxahIxrYed6xbDyzVUA7ASGr
         4RF6QGqbSilG0UKZCn1STPwSasSvw4YlSI+FIgzvQ7unSmHanru3PbtlNEGl4H0tuuKb
         XxRA==
X-Gm-Message-State: AOAM533BfjzvemhGLvyJDkmb46ohlU1625lwf18xnZ2FYEhmnbiZFq8w
        QghzmIbWw1rxgAFvTLaASdRJcajr/WOZXjKzr3CiSw==
X-Google-Smtp-Source: ABdhPJxo3cErWejISZ/m6a/GDZoXcDfi1vEQnReSm0d00ojIV2HtWGoMVKSAfjRfCy8lFoBxhK7FxHR4P6snFdd70QQ=
X-Received: by 2002:a05:6e02:d52:: with SMTP id h18mr482108ilj.133.1617391684442;
 Fri, 02 Apr 2021 12:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210222225241.201145-1-dlatypov@google.com> <20210402093228.755260-1-brendanhiggins@google.com>
 <38510e93-843c-b0e0-5ad5-4953660de79b@linuxfoundation.org>
In-Reply-To: <38510e93-843c-b0e0-5ad5-4953660de79b@linuxfoundation.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 2 Apr 2021 12:27:53 -0700
Message-ID: <CAGS_qxqoXhZo6hV_1BsqrpXBJTuBhXERUnW75U6aCtS382aNjg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make --kunitconfig accept dirs, add
 lib/kunit fragment
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 2, 2021 at 11:00 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/2/21 3:32 AM, Brendan Higgins wrote:
> >> TL;DR
> >> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
> >>
> >> Per suggestion from Ted [1], we can reduce the amount of typing by
> >> assuming a convention that these files are named '.kunitconfig'.
> >>
> >> In the case of [1], we now have
> >> $ ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4
> >>
> >> Also add in such a fragment for kunit itself so we can give that as an
> >> example more close to home (and thus less likely to be accidentally
> >> broken).
> >>
> >> [1] https://lore.kernel.org/linux-ext4/YCNF4yP1dB97zzwD@mit.edu/
> >>
> >> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
>
> Should this be captured in  documentation. Especially since this
> is file is .* file.
>
> Do you want to include doc in this patch? Might be better that way.

It definitely should be documented, yes.
The only real example hadn't landed yet when I sent this patch
(fs/ext4/.kunitconfig was going in through the ext4 tree), but now
it's in linus/master.

There's still some uncertainties about what best practices for this
feature should be, i.e.
* how granular should these be?
* how should configs in parent dirs be handled? Should they be
supersets of all the subdirs?
    * E.g. should fs/.kunitconfig be a superset of
fs/ext4/.kunitconfig and any other hypothetical subdir configs?
    * Should we wait on saying "you should do this" until we have
"import" statements/other mechanisms to make this less manual?
* how should we handle non-UML tests, like the KASAN tests?
  * ideally, kunit.py run will eventually support running tests on x86
(using qemu)

If it's fine with you, I was hoping to come back and add a section to
kunit/start.rst when we've had some of those questions more figured
out.

>
> thanks,
> -- Shuah
