Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D485041CD60
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 22:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346706AbhI2U1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346712AbhI2U1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 16:27:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F1C061767
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 13:25:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y1so2336355plk.10
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUBvo02+e+5GDikUUveOdH1uDHUT9sKYGIFKKqY5fqU=;
        b=SXHyTGNpWjeYTLxcIMpnSmPDFAjptH6ZmfzCgx9YzmZjU1V8uKZu8G3t/G5gEVRgqQ
         ybCdjCPKGm9EUpwMHEJB8/rnNWmV/+nfKszYb9nUEtdsxMGbna3my2JupqTd0pqxz/ck
         LRx8lxH6GYfkV9+xoTRQ266xJ7+TpMqYISBY4tR1o+xnykRnYJ/6clseru7yrlk1m2zM
         ACZFQIsfBD4XAxrElcUsgNEHbdu8xKHCfbHV63ipJdb9czfDsiiyCSUALPdNC66iG+bu
         gIheiodGXBCrjT/nQYttErY+l2+vPfbu9DTuVrNxElKOR7AIzXZ/zyyTO0X1kLdDSqlM
         oDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUBvo02+e+5GDikUUveOdH1uDHUT9sKYGIFKKqY5fqU=;
        b=tqi96TgGK6VBjpMF2T8eYG65JP0pDH/qosjdfZwjtnjV7Rkt9jjb6VfLlLq6hmE0Bo
         e3VejYVRzD41K02EAy6igRXkAk19Fba0n1erlWn+px7eqvY2/5ePw9PiS2KqIHWTmuyq
         kyKV35E1CGS+r6xGboWQGQ2Sg8ZLG/E6/bvahU5DDWBFf/VIXEnpD85MsnOHt05soUwe
         le6M/vwTgj4C5luO5KKgukqq8nndOeSYjhGGOs7U5aAQv7rlm1I/lcejzIJtS8UVxs0p
         06ae0fdMmzIu9y0fPltpsG0BY9po0tAwJdrGhqHR1xijAZw0tCeVxmrf0BE3k5UJZfmJ
         csYg==
X-Gm-Message-State: AOAM530uI33agd57w7sP4SO6NifvD/5OvXsZKORIwkBETU61XfBDpE7O
        3Vo34HcxQ6VNdv/kIIpDSRomLLPlpB83lQi9iUb/NQ==
X-Google-Smtp-Source: ABdhPJxpJOgC3k+TWaoTKANUQVPD/FVHVFgCe1rsICLyPH/Z9FIobrEZqMMPj8b91Xa2Z3xbADXcFUSb99b620EiBS8=
X-Received: by 2002:a17:90b:3108:: with SMTP id gc8mr8269060pjb.63.1632947118847;
 Wed, 29 Sep 2021 13:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-2-brendanhiggins@google.com> <202109170808.629688A460@keescook>
In-Reply-To: <202109170808.629688A460@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 29 Sep 2021 13:25:07 -0700
Message-ID: <CAFd5g47YMnMzR+dtSLy9NvMb4TkeDkbSNt3qs-kvfLo_0y9-eg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] gcc-plugins/structleak: add makefile var for
 disabling structleak
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        rafael@kernel.org, jic23@kernel.org, lars@metafoo.de,
        ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        yehezkelshb@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 17, 2021 at 8:48 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Sep 16, 2021 at 11:10:59PM -0700, Brendan Higgins wrote:
> > KUnit and structleak don't play nice, so add a makefile variable for
> > enabling structleak when it complains.
> >
> > Co-developed-by: Kees Cook <keescook@chromium.org>
>
> For a C-d-b, also include a S-o-b:
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> But otherwise, yes, this is good. :)

Yeah, I know that's necessary for the patch to be accepted, but in
this case, I don't think your original version of this (it wasn't
actually a patch) had a S-o-b on it, so I didn't want to say that you
had signed off on something that you didn't.

I have run into this situation before and handled it this way -
letting the co-developer sign off on the list. Is this something I
should avoid in the future?

In any case, I will resubmit this now that I have your S-o-b.

Thanks!
