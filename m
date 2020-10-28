Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF0529DBA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 01:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbgJ1Xsa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 19:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733125AbgJ1WrW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:47:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267D4C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:47:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w25so1213014edx.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuoPSJL9a9Llau2UXEgfkl0HpQ/DKvQdECe1ilSylE0=;
        b=SU0bPUwNgaf82jTxAAZckYAx1NgNbOcubMzF+S2FnlA4xER8B5/yoi/oSK6VGe6G9j
         5XwoS4fngBwVaxoU1oPYlEkqhj8lj3ZqDLVJa8iPRrzCtC2m6h+9U+BbnJZPF/t/s5SS
         bxphgL8sUy+ETj5DIaEWJpaCo+sbLVCYdDSWX/jsDFDEvZ0a1SnXAiiI8+nkzE9Ox0r5
         9vug7Rp6xI0TJV8LU+87Is52Ryf/I1XjFiYjUzyEERDOHbgXH4Fti3w7Vw2qK0Ndzpqx
         jS1LqJw22ah7c5fzmTQ0TfLyvBHEnDumrUHOVi15ZZXVAxOjhtBxUAJTJ2udtPSAatSX
         UuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuoPSJL9a9Llau2UXEgfkl0HpQ/DKvQdECe1ilSylE0=;
        b=OwmxbjhHGmkrMglpoMjnMiwY2H2DCrFlFYlsDE612Ogb1ooVGvBPxFDdsvIPDL5v1m
         +sAkZXyLN90bhx4RV9MFGnQjCFIm9pQCHfxjVZunWMjb5tc0JLTn6tMAbR2jQrzju/8v
         RI2SoeBDyx6vXJBFcW8ZXowGj8XeVPJTtASEXqmoMdmMHfsk4w5btCfsOAvyVzgklwNo
         dsB5Aqp20w1f93Yeur/G87kLQ754AQIqE1a19+3dxOhNgSMiVFoW8g+/0uZhw/+2Tf55
         h/zL82hC8/Hgja767pMfOctMoUEpYR70FsKkq+A3NxPxoRdD8aH63xZEyltvsWpYpo5n
         88tw==
X-Gm-Message-State: AOAM532w8BKDzCd/TiWQVtHcIfBAWDdlj82Dm3sqCoFGLhw4vV1+BocA
        yny0fLEeSYxwWc6EhqUhl8FDcWPYg7pV6dN+elF5FC1O5/DRwg==
X-Google-Smtp-Source: ABdhPJxH+C6OnKyOuUeUUclASm3kpIHa3cJoLqE53vmoeQQE73F7u+W9qwUpyZV5c2DZjx49pGpPS/jMn50TSC3eYO8=
X-Received: by 2002:a2e:9789:: with SMTP id y9mr2453060lji.456.1603864589489;
 Tue, 27 Oct 2020 22:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201027184909.20881-1-rdunlap@infradead.org> <CABVgOSmtTK=V8EFL8KTmN+e+pP6HKZQo+LMsmqG3PnxuhFtZ9A@mail.gmail.com>
 <07963645-1644-53c2-b1da-8f89fe865eda@infradead.org>
In-Reply-To: <07963645-1644-53c2-b1da-8f89fe865eda@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 28 Oct 2020 13:56:18 +0800
Message-ID: <CABVgOSmg9pq_stK4qbGpd6ceOrp5pBBAk3K_m8kHpbxaxPpeag@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: style: fix some Kconfig example issues
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 28, 2020 at 1:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/27/20 8:00 PM, David Gow wrote:
> > On Wed, Oct 28, 2020 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> Fix the Kconfig example to be closer to Kconfig coding style.
> >> (Except that it still uses spaces instead of tabs for indentation;
> >> I guess that Sphinx wants it that way.)
> >>
> >> Also add punctuation and a trailing slash ('/') to a sub-directory
> >> name -- this is how the text mostly appears in other Kconfig files.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: David Gow <davidgow@google.com>
> >> Cc: linux-kselftest@vger.kernel.org
> >> Cc: kunit-dev@googlegroups.com
> >> Cc: Shuah Khan <shuah@kernel.org>
> >> Cc: Shuah Khan <skhan@linuxfoundation.org>
> >> Cc: Brendan Higgins <brendanhiggins@google.com>
> >> ---
> >
> > Thanks for fixing this!
> >
> > For what it's worth, I _think_ we could get away with tabs for
> > indentation in the file without Sphinx actually complaining, but it
> > does annoy some of the editors, and as far as I can tell, Sphinx
> > converts them back to spaces in its output. I'm far from an expert,
> > though...
> >
> > Regardless, this is:
> >
> > Reviewed-by: David Gow <davidgow@google.com>
>
> I tested with tabs for indentation and it's no problem with Sphinx.
> Some editors care?  I am surprised.  and don't much care.

Neat!

As for editors, I think it was just some aggressively set per-filetype
defaults, so I'm not particularly concerned either.

> I would be happy to submit a v2 using tabs for indentation.

That sounds good to me if it works, thanks!

Cheers,
-- David
