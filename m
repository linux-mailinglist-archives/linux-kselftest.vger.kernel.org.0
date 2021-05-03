Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FEC372234
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhECVGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhECVGa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 17:06:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A8C06174A
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 14:05:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so9955040ejc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOjmQR5kBAFdBDbYveZuEC6BseQsZK+ckrTSDqGN9/I=;
        b=azV4c4J8ymVHKGTJPUBc1h3WqHlhjpQHviJ3CZZsYS3PABVZtTLIjvj0T+5A9r4Won
         K6LoX7fl5EbTod2HKj4X608DISAMJ9sh+i5azaoEuVCIt2MGN85UBkjM2LtfrXQk5KJ4
         HcOilRAZmjvrwfdRhArESU/6xY0d2OX15bXGyQAqma8rOamiN3p2v8xoQ8TbnqOYxCgv
         i69Z6/dsrFORgmB6sveCQNax2NbWptj34iHpJTe/3V55NPXmZoihb86F2njaDAdr9pnn
         6G0p+aq37MzHyDhBx/UTn9WxuZPZb55Z2rcUWRqkqoOm2qGndt4MZxm0397GLt96CO/l
         x5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOjmQR5kBAFdBDbYveZuEC6BseQsZK+ckrTSDqGN9/I=;
        b=X2ETIOem1wWJjvOwP4MThAiDDEQ3xFYR3glMP1BJ8aVsBHELF084VMKltfKRO/LJOn
         eyMCgpKCSbRFO+DpOS7w00VTSwXGEz04Mi7qSM7M+j33n3+fh/tnHGl+l0SKbSBHbtk2
         RO7XhBIfxTibAuLtxnMgTK/nov7heE3+2WiTcwyxrsF9yp3aXWO+sPrI+bunDXFqtqD3
         Glvh76LoCP5nQqCLCDMGQWYWdfIpwGqVjJ7bJOqpMQRIHGPJqdh81RH3piTotSmCYbOs
         V5UBmoWwNESFeS3mzLNxXJlN/3fLyf6KNsmaJLOwdYDUpilSSScxgNvHo94QJreikHkp
         A66g==
X-Gm-Message-State: AOAM530gAYyZx1nZnHxQW8JPj0+rFejkXjx7FSbQ2prc6eTl5Z4/++L5
        5wYkooxPBy2tFcilxM6PfZc7IHgXjZxSY1KGVMx1Tw==
X-Google-Smtp-Source: ABdhPJwfkThUt27PdTlf6DFzWeV5iBHK4UeXK2KZJV06DcxJdBGgf36xSDneFqbZSf/dNff+L+xzWlZWpJq9uZpHPTc=
X-Received: by 2002:a17:906:9990:: with SMTP id af16mr18149564ejc.195.1620075933866;
 Mon, 03 May 2021 14:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210421183222.2557747-1-dlatypov@google.com> <d7b2b598-7087-0445-4647-8521f3238dc2@redhat.com>
 <CAGS_qxp6jNDaEjsZKPeJJVYasXqrfvY5KK0QhXaBh68S7anMRQ@mail.gmail.com>
In-Reply-To: <CAGS_qxp6jNDaEjsZKPeJJVYasXqrfvY5KK0QhXaBh68S7anMRQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 3 May 2021 14:05:23 -0700
Message-ID: <CAGS_qxoqFHdqoqFEnNJc5_2jspzaHy+WoctiUnRndScXyrKbew@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/test: convert lib/test_list_sort.c to use KUnit
To:     Nico Pache <npache@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I've left the names as-is for now in v2,
https://lore.kernel.org/linux-kselftest/20210503205835.1370850-2-dlatypov@google.com
I could send a v3 w/ the rename and see if anyone complains, but I'm
tempted to push that off.


On Thu, Apr 22, 2021 at 1:43 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Apr 22, 2021 at 1:16 PM Nico Pache <npache@redhat.com> wrote:
> >
> > Hi,
> >
> > Can we change this to CONFIG_LIST_SORT_KUNIT_TEST to follow the convention used by other KUNIT tests?
>
> I mentioned this in the commit description briefly, but I don't know
> who is using this test. Nor do I really know who to ask.
> So I didn't want to risk breaking anyone's workflow for now (more than
> now requiring them to set CONFIG_KUNIT=y/m).
>
> Side note: maybe CONFIG_KUNIT can default to =y when DEBUG_KERNEL is set?
> Then there'd be even less change than how this worked before...
>
> If it's not a concern, I'll happily update the file name and config
> option to follow the conventions.
>
> >
> > Maintainers? thoughts? I recently posted patches to convert some of the other tests that break this format [1].
> >
> > Cheers,
> >
> > -- Nico
> >
> > [1] - https://lkml.org/lkml/2021/4/14/310
> >
> > On 4/21/21 2:32 PM, Daniel Latypov wrote:
> > > [SNIP...]
> > >  config TEST_LIST_SORT
> > > -     tristate "Linked list sorting test"
> > > -     depends on DEBUG_KERNEL || m
> > > +     tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
> > > +     depends on KUNIT
> > > +     default KUNIT_ALL_TESTS
> > > [SNAP...]
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/d7b2b598-7087-0445-4647-8521f3238dc2%40redhat.com.
