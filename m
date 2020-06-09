Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C451F471F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 21:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFITcd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 15:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgFITcc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 15:32:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3DC05BD1E
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Jun 2020 12:32:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so1847084pjd.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rS0PjS0rxiYFFA6NkJOsLiVgpILALWXqX0+c6m8rUY=;
        b=OJfv/PGGjziwHlWGLl+f5814ZzqprpOKgo0vPYSNCO/nX2sijtaq5FNv2gvbWNkhmp
         ukFbQ40AvJEaCjIAoONUN7rBXUFQtFBC59T6RYgZf6/g+ZOE30WUE3PG/CzZUVuCMG2F
         xYPtOViIgO4UXi78VEBAlZF2PZmzgpXAibdXz32MwoE5ZnUNKhuYdjOdPa3tRcIPJuPD
         NI8Zjw7xlv97Ssky633X8+kf83KMTUNzd2Lvt3fH2AJwCNE2X+GxhWoqijUCJyQYRMZy
         PvSNcDANXeakfxifbFaKVQtiKdwY6rLQetiJl79W0EhnNinpGxBPO9DxW5/K8v3jyoxD
         VEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rS0PjS0rxiYFFA6NkJOsLiVgpILALWXqX0+c6m8rUY=;
        b=pkMgoR2nKovAwVbs6LtII3TGfUg7sv7pB1jsustagyxnIo/V+rCOpd83VfNl0/dvyM
         lbDx77gHXvAffOwNUWAm1s+72SV15zFdUrGfpieWpPUqGKSuAyn+ZhvZMgFmQBmu251T
         kUdFnVcvSc5IAtURsY4abJZc+A4XgF6YOZ+nI1wTzTZe3EbV3Pg+kkKlGUnvh8VM9Nqx
         K6thojn1FIGiz/b7jiX7B2pMLDMtu5342HrFbKRA9jcDaOvTA6DXF6urQdUJgDN9+ZJp
         B6kedK7Y5cGRft1b3B2IAQ6y9hkWpzqY5bBHGLRNothOQrdGy+2ryhne0cp4yTbOMwfB
         /Oog==
X-Gm-Message-State: AOAM532prLfPKa5uXNa5X8X492QI11t8lbQbrriY43tAohNd+FbIgHKq
        6014PoCeA9G6kjSr6wGekxOym86RSJWCVjxGtJEn9Q==
X-Google-Smtp-Source: ABdhPJzT/ray+2iwWCZt/bmbUFyJRHb3+cB2WcthZLy3Trleot/HATDwSXKrTU7Vy+g0WzyotOm2sfBvvFzmrrJfW+E=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr6575703pjv.217.1591731151274;
 Tue, 09 Jun 2020 12:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com> <20200606040349.246780-6-davidgow@google.com>
In-Reply-To: <20200606040349.246780-6-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Jun 2020 12:32:20 -0700
Message-ID: <CAFd5g44KHLV3EV+At3tsnbcagbW5Yc-fRXoTBae8no=peCJsmQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        andreyknvl@google.com, shuah <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 5, 2020 at 9:04 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> KASAN errors will currently trigger a panic when panic_on_warn is set.
> This renders kasan_multishot useless, as further KASAN errors won't be
> reported if the kernel has already paniced. By making kasan_multishot
> disable this behaviour for KASAN errors, we can still have the benefits
> of panic_on_warn for non-KASAN warnings, yet be able to use
> kasan_multishot.
>
> This is particularly important when running KASAN tests, which need to
> trigger multiple KASAN errors: previously these would panic the system
> if panic_on_warn was set, now they can run (and will panic the system
> should non-KASAN warnings show up).
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
