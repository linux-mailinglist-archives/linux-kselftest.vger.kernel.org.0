Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136B6244CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 01:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfETXxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 19:53:35 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34568 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfETXxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 19:53:20 -0400
Received: by mail-vs1-f65.google.com with SMTP id q64so10061593vsd.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2019 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOow0La3W2Essx5H031uTOWFbAnDcBGJlXVfamcoL3w=;
        b=Dx4+lU9jqXDtln/17Mrd8EV4Dxp/5zASL+1Y8Niio9Pqb06rC0aI8wedP3ohgziyEW
         jppEZzDyXiAo/njLuzUnS0cZqB4tlCDf5SInO7A6W3spDccr9FtwpNa39rs9vTjn9Pol
         gFjx66w14oqATAsCg/4xevDnAIAQo2Q0YzZMa3Njt5yFKOelm+SuxVUsWhk4woonxC/+
         9D5FC/UAWBXCau72ARfrLZBFx2zGvzGs/3QYXrUb8NFYR9FnDOYRxbwkdocqirkPGsSw
         AxoIYh3MeUP070fRiIy388VcetefsVsnX0FjFahzGTgGe2zBg5LkCE8dqpCaiB/D65kK
         79Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOow0La3W2Essx5H031uTOWFbAnDcBGJlXVfamcoL3w=;
        b=aWNgH0peRI4gWu7p8YeMKn8zJwJlaAe5pseVpZN3ME7StVjrNCRpss04mZm1LDkQMf
         +8E8y4PCYpj3zBVGfrn5HI1gy4TSZ49qJFRwI8aC8PW0wloJHambEc72jFrT9qApLu/V
         lBtmgkwwvGEybqZI3/2tYQoWDtvyOfib8200hIL90rMLly2MhX3IZ7xER8mLQj1wcMkr
         /C/pBIyMOURP9YhnJJImTHWVWbxixCbWYe5hrpYEB7qQEcxqbnNMOpAiY1f6br229MFu
         2tj+PH0t1ENRH2Dz6y5+aNBLuLVGRvHd2rhQxtIjs/mVsSmzY1/lHto+kdes8ukJrYsC
         qTkg==
X-Gm-Message-State: APjAAAWX0J15sEr2PGl8sdcZJcRUnYIJC7dTiHTj+q8L/HpDqXYHqknT
        cVrX7+cBcdFKzuFdTclKMLhU2/UVBSfgvN35+owv7w==
X-Google-Smtp-Source: APXvYqyR0JsazypV3hCmWgdEzYpNKlJ3PjKF8ENA0Fjbz+eEGES/3XAyQs/kAm4YlbOIpNAtAAzvW9GW3+g1GtceCfY=
X-Received: by 2002:a67:be17:: with SMTP id x23mr26047761vsq.173.1558396399029;
 Mon, 20 May 2019 16:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com> <20190517144931.GA56186@arrakis.emea.arm.com>
In-Reply-To: <20190517144931.GA56186@arrakis.emea.arm.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Mon, 20 May 2019 16:53:07 -0700
Message-ID: <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 17, 2019 at 7:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Andrey,
>
> On Mon, May 06, 2019 at 06:30:46PM +0200, Andrey Konovalov wrote:
> > One of the alternative approaches to untagging that was considered is to
> > completely strip the pointer tag as the pointer enters the kernel with
> > some kind of a syscall wrapper, but that won't work with the countless
> > number of different ioctl calls. With this approach we would need a custom
> > wrapper for each ioctl variation, which doesn't seem practical.
>
> The more I look at this problem, the less convinced I am that we can
> solve it in a way that results in a stable ABI covering ioctls(). While
> for the Android kernel codebase it could be simpler as you don't upgrade
> the kernel version every 2.5 months, for the mainline kernel this
> doesn't scale. Any run-time checks are relatively limited in terms of
> drivers covered. Better static checking would be nice as a long term
> solution but we didn't get anywhere with the discussion last year.
>
> IMO (RFC for now), I see two ways forward:
>
> 1. Make this a user space problem and do not allow tagged pointers into
>    the syscall ABI. A libc wrapper would have to convert structures,
>    parameters before passing them into the kernel. Note that we can
>    still support the hardware MTE in the kernel by enabling tagged
>    memory ranges, saving/restoring tags etc. but not allowing tagged
>    addresses at the syscall boundary.
>
> 2. Similar shim to the above libc wrapper but inside the kernel
>    (arch/arm64 only; most pointer arguments could be covered with an
>    __SC_CAST similar to the s390 one). There are two differences from
>    what we've discussed in the past:
>
>    a) this is an opt-in by the user which would have to explicitly call
>       prctl(). If it returns -ENOTSUPP etc., the user won't be allowed
>       to pass tagged pointers to the kernel. This would probably be the
>       responsibility of the C lib to make sure it doesn't tag heap
>       allocations. If the user did not opt-in, the syscalls are routed
>       through the normal path (no untagging address shim).
>
>    b) ioctl() and other blacklisted syscalls (prctl) will not accept
>       tagged pointers (to be documented in Vicenzo's ABI patches).
>
> It doesn't solve the problems we are trying to address but 2.a saves us
> from blindly relaxing the ABI without knowing how to easily assess new
> code being merged (over 500K lines between kernel versions). Existing
> applications (who don't opt-in) won't inadvertently start using the new
> ABI which could risk becoming de-facto ABI that we need to support on
> the long run.
>
> Option 1 wouldn't solve the ioctl() problem either and while it makes
> things simpler for the kernel, I am aware that it's slightly more
> complicated in user space (but I really don't mind if you prefer option
> 1 ;)).
>
> The tagged pointers (whether hwasan or MTE) should ideally be a
> transparent feature for the application writer but I don't think we can
> solve it entirely and make it seamless for the multitude of ioctls().
> I'd say you only opt in to such feature if you know what you are doing
> and the user code takes care of specific cases like ioctl(), hence the
> prctl() proposal even for the hwasan.
>
> Comments welcomed.

Any userspace shim approach is problematic for Android because of the
apps that use raw system calls. AFAIK, all apps written in Go are in
that camp - I'm not sure how common they are, but getting them all
recompiled is probably not realistic.

The way I see it, a patch that breaks handling of tagged pointers is
not that different from, say, a patch that adds a wild pointer
dereference. Both are bugs; the difference is that (a) the former
breaks a relatively uncommon target and (b) it's arguably an easier
mistake to make. If MTE adoption goes well, (a) will not be the case
for long.

This is a bit of a chicken-and-egg problem. In a world where memory
allocators on one or several popular platforms generate pointers with
non-zero tags, any such breakage will be caught in testing.
Unfortunately to reach that state we need the kernel to start
accepting tagged pointers first, and then hold on for a couple of
years until userspace catches up.

Perhaps we can start by whitelisting ioctls by driver?
