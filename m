Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71624201BA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbgFSTuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390220AbgFSTuy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 15:50:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133BFC06174E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 12:50:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j1so4868602pfe.4
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNT64JH4pEFGIW/zOKuYzIi+PxEqhWFih4V3DtMG5uw=;
        b=KG3HLTZqAizhXno+SvHB3QU8UgG5DSs2DDiK4JSvYwT0dXUgdjLm+SzEy0nDs63BIa
         6nJQ42blal7wAjbcLi+3pwKuL2BNdtMif3R9vV0ibh49nqpYHmUuEaFY453sFeTi8TMB
         qv69DHklzRs7nQLdJNwaPCpK60msvzUoo/gUUk9uKpfDs5IlJjVPciyOzPbqezC/pT83
         n/GIY/O0eEoMNHtLityMrxCgGATz4U4a7V854f79pKWRIwbEQwZ5h054cJKi4gFHrnVf
         BeGgliaDqVJlPkhqH6xDv3w7Q99uO8xiJToRdQmKvd1hjx0e/Cc37+pezgu9mrB+xhSp
         HlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNT64JH4pEFGIW/zOKuYzIi+PxEqhWFih4V3DtMG5uw=;
        b=nQayx+2InhQr15UEaUr909Zs0/hKd9RrBPX8CSXmyfRE9uryT3DnU0KPnn68vsryzA
         tVhxSaI7n81LnBtsk/YiJcTmlU/0pMdxEl95m09G0EGjfxPIKuhg7fBDFclgxt0EhZkY
         csVchOw6ViwJvh/HGDnd/pSJpfiY0d3if8jXxqWT0AZ73cw207dAPfJEWXSHg1dbtXUd
         Q0Zty8zPNQMgs8T2RPvZc84DtoKTP3xJx9PbrUjXGia+oiSAAevUuA79kBnEsh/Y6OpB
         IClZeLfVXZ9VdG0p5uT7jUHZOQDcuYi0oq63R9WNoLF2YlL61WtgrwCKY6R2qwqG2VS7
         gHUg==
X-Gm-Message-State: AOAM533wTlmGsZKk9bXqRb3qpZ8Cs21TYKkJurFAeKZceNm4Ayfgmb4d
        /mTHrCrHukaC+NequgKRwVUlIgsXDb2UPgmIO6MgCQ==
X-Google-Smtp-Source: ABdhPJzCbeGw8aqUSCSne4JgLyCwGUWXAGu/3y8GGUrbwN50PA0lsKp01F63TLMxspcEfPHDiA2gG1W3jqhNDrBn270=
X-Received: by 2002:a63:4c08:: with SMTP id z8mr4188941pga.201.1592596253398;
 Fri, 19 Jun 2020 12:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook> <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006161642.A5F50ED07@keescook>
In-Reply-To: <202006161642.A5F50ED07@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 19 Jun 2020 12:50:42 -0700
Message-ID: <CAFd5g46VkEbYemSv2PC28GyGTSipoFG+e6yqO--H9e2Sa+UdbQ@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Kees Cook <keescook@chromium.org>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 4:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 15, 2020 at 07:07:34PM +0000, Bird, Tim wrote:
> > From: Kees Cook <keescook@chromium.org>
> > > Note: making the plan line required differs from TAP13 and TAP14. I
> > > think it's the right choice, but we should be clear.
> >
> > [...]
> > With regards to making it optional or not, I don't have a strong
> > preference.  The extra info seems helpful in some circumstances.
> > I don't know if it's too onerous to make it a requirement or not.
> > I'd prefer if it was always there (either at the beginning or the end),
> > but if there is some situation where it's quite difficult to calculate,
> > then it would be best not to mandate it. I can't think of any impossible
> > situations at the moment.
>
> I think we should require one of:
>
> - starting plan line
> - ending plan line
> - ending with something that indicates "I'm done, but I have no idea how
>   many tests actually ran" (Maybe "1..?")
>
> To me, the point of the plan line is to be able to say "this test did,
> in fact, finish". So even if some test can't even count how many tests
> it _ran_, it can at least say "I am now finished".

So the counting is actually not the hard part for us, it's figuring
out when we have finished. Again, the change that I am working on (I
REALLY need to get that out) should fix that, but until we get that
upstream, KUnit doesn't actually know when it is done running tests.

> > > TAP13/14 makes description optional, are we making it required (I think
> > > we should). There seems to be a TAP13/14 "convention" of starting
> > > <description> with "- ", which I'm on the fence about it. It does make
> > > parsing maybe a little easier.
> >
> > I would like the description to be required.
> > I don't have a strong opinion on the dash.  I'm OK with either one (dash
> > or no dash), but we should make kselftest and KUnit consistent.
>
> I find the dash to be distracting -- it doesn't help me scan it, and it
> doesn't help a parser (which only needs to find "#").

Yeah, I also prefer spaces and/or "#". I am okay if spaces are
optional only to aid human readability. And honestly I don't care
about this point too much. Just offering my 2 cents.

> > > > Differences between kernel test result format and TAP13:
> > > >  - in KTAP the "# SKIP" directive is placed after the description on
> > > >    the test result line
>
> I sent a bunch of clean-ups for kselftest.h recently[1], but it looks
> like we'll need more for adding "description" to skip (right now it only
> prints the SKIP reason).
>
> [1] https://lore.kernel.org/lkml/20200611224028.3275174-1-keescook@chromium.org/
>
> > > Yes Documentation/*.rst Not sure on name yet, but where do kselftest
> > > docs live? :)
> > Documentation/dev-tools/kselftest.rst
> >
> > I'll put this at: Documentation/dev-tools/test-results-format.rst
>
> Sounds good!
>
> --
> Kees Cook
