Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608C842ADCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 22:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhJLU3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 16:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhJLU3o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 16:29:44 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA8C061570
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Oct 2021 13:27:42 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id k3so396450ilu.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Oct 2021 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVITERo9v4+nlxDnJTQtLwh6+ZFxaND/0s7RMl72dZo=;
        b=fVHW5nMY9phbWkMYJul3zH/rSHDKP0O+6cEW4eDRCLWUjg3UBH14TpkqordcVSIubK
         mDik2j+1XKAmrqEE4k7khLU3+hdkA3vFPj2qkxQ5G62lGKtfm3itzsEJ4bUmnhp8m3iK
         hFwIkkjw3mjH4iCYP8pR+D7imTA+Xg9I2sNs40XexBIElMlDhNPrc5k0OQwiG1G+TPG7
         lFhm4cpLDDq/7LpFs58P5M+SnAihSQO2OhvY9wIUqqLbEMj7gzSdfa7/CTsp167qV/5f
         kbfHsI8fqyfXVq0SwZmHMgmSj0YkoaerVeXudC6HCEa5NYoqIKTf3eULI0R3Dx+iiumE
         457g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVITERo9v4+nlxDnJTQtLwh6+ZFxaND/0s7RMl72dZo=;
        b=IFG86hhEwag2lgI8EfqHihXmCeJkbHTywiU6Akvi4ccJsLL+cdsCJ4IXykShzL0i4Q
         SRYV9o5F4mFXwvE60Sl0iFIo6LS4kmuunk58danEIZqtzwGxMMVWy3eA8p81G16mLm+E
         Ddn2g9Q/bchgAiOnqIDjU3VDaXVvo7V34LNRyLpwOQGCzCntaUwXfK5DS+cmmPr1YmFE
         xh+df3x2I8QNNRP6tDVQaeeF7/iuCjdMjGEUoUm7hLRG4bb3O5DuLOJ0fwqLouiIn/6A
         Km615Ezqqr87zlkWbRuuEcaLGOuUGa01iokPMfPeol1rRLylLYht488VhilMy2yJcuv6
         1bJQ==
X-Gm-Message-State: AOAM5332DnDuNzc/3v1uL0ZQA9M5CcZ3SU5bP2A+VBNxzik0lzzLlWIu
        f+qOrdWfVRHx+EWg/Gf4MNIzrRgfE10w6becuTiQRg==
X-Google-Smtp-Source: ABdhPJy0DS8bhz1zPmlsGJqnOJybS1MC42MT2jkXUHDZD12ETYoBGzcOlAqQVoNsUD+u85AuKQQxbGZEB1pBIcmaZf4=
X-Received: by 2002:a05:6e02:1c4e:: with SMTP id d14mr25255946ilg.121.1634070461996;
 Tue, 12 Oct 2021 13:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
 <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
 <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
 <CABVgOSmOFtYMiHWKTbbXST00pbYE88eu3DagD8pHt5=QdmCqyg@mail.gmail.com>
 <de7b75062fbc19824111685a9b8119545ee83e35.camel@codeconstruct.com.au> <CABVgOS=evHzhP5k9EshZM4MG+Zt9qDwn11tf2Q7EaYgVwdWGOQ@mail.gmail.com>
In-Reply-To: <CABVgOS=evHzhP5k9EshZM4MG+Zt9qDwn11tf2Q7EaYgVwdWGOQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 12 Oct 2021 13:27:30 -0700
Message-ID: <CAGS_qxo5Esn6jzgtp1THAWgHC_pPXfYwNigfPVGD_q2mkHNtwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     David Gow <davidgow@google.com>
Cc:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 11, 2021 at 9:38 PM David Gow <davidgow@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 10:10 AM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
> >
> > Hi David,
> >
> > > In any case, thanks a lot -- this is awesome.
> >
> > Oh neat, glad it's useful!

+1

> >
> > I'm happy to keep hacking on this if it's in a direction that makes
> > sense for kunit in general. As an approximate plan, I can fix the UML
> > breakages, then work on some resulting simplifications for tree-wide
> > initialisers (we'd no longer need the null-terminated arrays of suites
> > everywhere, for example).

Getting rid of the arrays of arrays of suites sounds great to me.

I could also pick that bit up, since I'm the person who most recently
added code that depends on it:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=3b29021ddd10cfb6b2565c623595bd3b02036f33

> >
> +dlatypov, +kunit-dev
>
> Yeah, we think this would be a much better direction for KUnit to go
> for modules. If you're happy to work on it, that'd be great! Brendan,
> Daniel (CCed), and I would be more than willing to help out with
> questions, reviews, etc, as well.
>
> On the other hand, if you're really busy and you'd rather we pick this
> up, improved module support has been on the to-do list for ages, so we
> could bump it up the list a bit and finish it off.
>
> The UML breakages were mostly pretty simple: our default config
> doesn't require module support at all, so the various functions should
> just need to go behind the appropriate #ifdefs. A quick way to test it
> is just to run './tools/testing/kunit/kunit.py run' from the kernel
> source directory, which will configure, build, and run everything in
> the .kunit builddir.
>
> Cheers,
> -- David
