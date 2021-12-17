Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48022478455
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 05:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhLQE5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 23:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhLQE5B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 23:57:01 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA801C06173E
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:57:01 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id w23so2192370uao.5
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0UnZ/E6MSTY4JMW+zDDS2950QfrUnxcYxwKwDcRDHw=;
        b=r0eTEk3lQ51qMBgKBl6UU1apOFPCZOycMG7SRxCRqg358r9YS0vKbc2xLbabIm/qBR
         HjMGyFG+Gfn/hO4aTYywIOKW6yVzNxkoeWkfnfZ8XjnBXp9XW7XRBIvijTev1oewUU1j
         vYPBcaFdSjIEi7ECOghIpCY175tkgsgT+YUuB7L0v2OUdo+vzZmAmqv0ybu/DE+wiC+1
         ujIqNqLL9rW/mRDUu6638KVeJuPGZV8aQk/kg5b9/FC8/iNd8skyyf3jT/zqeyMRlSdB
         Ul8E3SXnWi7AFNB1NN0V6sH5MIxJhgtSTybjnRbWPfk3KcHDaHyl+DkAQHOCQ4CZbZBP
         ANiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0UnZ/E6MSTY4JMW+zDDS2950QfrUnxcYxwKwDcRDHw=;
        b=YPM2faT8bLbySyfQP8/gdMazExTO6aVO1dJIyhQqIeEuUjtcCgyupehF8H49vXueSF
         fm/1qKtNT7mGoN3VZfpjwpPag0M0aBiVChzUUW0s+d5yLwnM9seJ2idmF3F6pgt5YKGf
         DtnWhUY3giMQuPYppPK2ZnPJQjQt/SuvVpotOuKTcCD3zJw/eC/iaEqeXA025hOQB/HD
         1NT3uxJH3NoxdsHKzhpCD47nU3PVABicXqkmwL1I6ske4DDn/Y6EC75H6UbiexDnY0Pm
         wFNohVitNTNap55OPLLK2Bm7bzrg6uIbgfDoze9J+gqN2mz/NBxjxXUZSONWRUNDyiMX
         Gdqw==
X-Gm-Message-State: AOAM530Oepp/gkWENgiw6XgERdlvj1kKpfutajVdoWep2CQxmeqbcazz
        dLLecmlZK5cY0kJCRIeSWQCaWLI7y3JT9CvmrojyNgC71djcuw==
X-Google-Smtp-Source: ABdhPJwhZIjT8NNvoPom2Rp6at+2GMoK3wDN//Eb03fRpBR0y4i6QY352WbPDfVufZBXvrkLoOxOGkvqapwyTag0+4Y=
X-Received: by 2002:a67:446:: with SMTP id 67mr431973vse.38.1639717020639;
 Thu, 16 Dec 2021 20:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20211216055958.634097-1-sharinder@google.com> <20211216055958.634097-4-sharinder@google.com>
 <CANpmjNOGaVgP25xNOSGOyjcA9Lmk4uFmU=f6RrRNJBP_CMEVrQ@mail.gmail.com> <87czlwcfav.fsf@meer.lwn.net>
In-Reply-To: <87czlwcfav.fsf@meer.lwn.net>
From:   Harinder Singh <sharinder@google.com>
Date:   Fri, 17 Dec 2021 10:26:49 +0530
Message-ID: <CAHLZCaGh6Z1m50CYMae8AuY_524TzXtv-SP52FbLRj2Ks0fN1g@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] Documentation: KUnit: Added KUnit Architecture
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Marco Elver <elver@google.com>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim.Bird@sony.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Jonathan and Marco,


On Fri, Dec 17, 2021 at 4:45 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > In response to the other email: Adding binary blobs just creates
> > problems, for comparing different versions, and general bloating the
> > whole repo, where better alternatives exist.
> >
> > I suppose an ASCII diagram is a bit primitive. :-)
> >
> > However, SVG files on the other hand are not binary blobs, they are
> > text-markup based (XML), and e.g. diffing them often provides useful
> > information about what changed. SVG also has the benefit of being
> > vector graphics, and not being limited to one resolution.
> >
> > Looking at the diagram you added, I think this can easily be turned
> > into vector graphics, and most likely will not use up 24KiB as a
> > result.
>
> I agree with all of this; we shouldn't be adding binary images to the
> docs, and we've decided at other times that SVG is generally the best
> compromise there.
>
I did not realize that .SVG is in XML format and preferred over .PNG.
Thanks for pointing this out. I replaced .SVG with .PNG.

> Thanks, Marco, for pointing this out and producing an alternative.
>
A big thanks to Marco for creating  this .SVG file for the documentation :-)

> Once this is all settled, do you want it to go through the docs tree?
>
Yeah! that's the plan.

> jon
Thanks,
Harinder Singh
