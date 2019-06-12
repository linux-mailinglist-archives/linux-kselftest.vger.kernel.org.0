Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE3A42362
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408335AbfFLLDX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:03:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406078AbfFLLDX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:03:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so9447512pfg.10
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+WRAXF2ARmkxSGAjp/c6etYCd0hTSbOs0DZi8MzR6Q=;
        b=Au7VJqK1ojAhcfG23jRBnNIRm8KjejR34yLBYxx+tHyOH3UOEnqAeA+8NqPGB0xERC
         iEkWFkgDGC2bVn5/OIaA4Iaj0a8vwuQDB61IL+0H9Fwkx9OFXo7fvyXQ9pDMhbYVG+Nt
         NAfcfgs6HTAivxcJGzmU1GQcMJKjdgGsV4PVoEwVpmDo71FYYp7iRopdo3JqiipS6Pbm
         g0FK+P1R3xn5BU9DYN7tw7p2D7DXBRHK9wtsmdaKDKErjouHvoT1Xsa2liBK45bWDlUw
         nn9WdHLDyGhILUMAD8+oKvlF/Link+W8NA8UTm3/U+VTclr5XHE7a99we7HZ74tOwnVu
         i1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+WRAXF2ARmkxSGAjp/c6etYCd0hTSbOs0DZi8MzR6Q=;
        b=ZEeP2+CZnLMmUH0oL5aHHszT3tykENqdiQsc5+3dKLNLyvZEMOE3BH3DuGs5NattY8
         692e2OfhGnLiruogU1aqi2/SLKEXwCmm59966JfZ/DEG3m1S7sMJhHsk13t+KWsecAK8
         nndnptUhOAPK+vG+SSucx7L9P9W3KXO/gjhlYNwnQttkQo1U2ANV6u3SwDDDrVFhFfcF
         HtBbyjQReicArj/YDlVDjiHggH0pji9PW68Q8GMCf5RIRM53X5GKTvIFylTiRBk40O6X
         gmm1pscY1TymUOutlMo1KwVUHhTDzJw+7GzlTxFLC154dOsg7i8hEsEiE181JkGeTPP0
         WMeQ==
X-Gm-Message-State: APjAAAVtSYmED7TyQlPzsWl/baKYZP2JRZzp3W/y3RvxN64O/4+s1z/d
        c16jK33XWjSrOuxHoF3ClLjBW06+R477u9S88V3lMw==
X-Google-Smtp-Source: APXvYqzWmxUbLyuGmwxZVdNOTNeaNzhhuMrhwfH+eyIre2cUwA02gvKzU0bgN3Cy01oTn1PiBJVwgb5PwMcG3EUFGXg=
X-Received: by 2002:a65:64d9:: with SMTP id t25mr24706277pgv.130.1560337402181;
 Wed, 12 Jun 2019 04:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
 <20190610175326.GC25803@arrakis.emea.arm.com> <20190611145720.GA63588@arrakis.emea.arm.com>
 <CAAeHK+z5nSOOaGfehETzznNcMq5E5U+Eb1rZE16UVsT8FWT0Vg@mail.gmail.com> <20190611173903.4icrfmoyfvms35cy@mbp>
In-Reply-To: <20190611173903.4icrfmoyfvms35cy@mbp>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 12 Jun 2019 13:03:10 +0200
Message-ID: <CAAeHK+ysoiCSiCNrrvXqffK53WwBMHbc3bk69uU0vY0+R4_JvQ@mail.gmail.com>
Subject: Re: [PATCH v16 02/16] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 11, 2019 at 7:39 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jun 11, 2019 at 07:09:46PM +0200, Andrey Konovalov wrote:
> > On Tue, Jun 11, 2019 at 4:57 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Mon, Jun 10, 2019 at 06:53:27PM +0100, Catalin Marinas wrote:
> > > > On Mon, Jun 03, 2019 at 06:55:04PM +0200, Andrey Konovalov wrote:
> > > > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > > > index e5d5f31c6d36..9164ecb5feca 100644
> > > > > --- a/arch/arm64/include/asm/uaccess.h
> > > > > +++ b/arch/arm64/include/asm/uaccess.h
> > > > > @@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
> > > > >     return ret;
> > > > >  }
> > > > >
> > > > > -#define access_ok(addr, size)      __range_ok(addr, size)
> > > > > +#define access_ok(addr, size)      __range_ok(untagged_addr(addr), size)
> > > >
> > > > I'm going to propose an opt-in method here (RFC for now). We can't have
> > > > a check in untagged_addr() since this is already used throughout the
> > > > kernel for both user and kernel addresses (khwasan) but we can add one
> > > > in __range_ok(). The same prctl() option will be used for controlling
> > > > the precise/imprecise mode of MTE later on. We can use a TIF_ flag here
> > > > assuming that this will be called early on and any cloned thread will
> > > > inherit this.
> > >
> > > Updated patch, inlining it below. Once we agreed on the approach, I
> > > think Andrey can insert in in this series, probably after patch 2. The
> > > differences from the one I posted yesterday:
> > >
> > > - renamed PR_* macros together with get/set variants and the possibility
> > >   to disable the relaxed ABI
> > >
> > > - sysctl option - /proc/sys/abi/tagged_addr to disable the ABI globally
> > >   (just the prctl() opt-in, tasks already using it won't be affected)
> > >
> > > And, of course, it needs more testing.
> >
> > Sure, I'll add it to the series.
> >
> > Should I drop access_ok() change from my patch, since yours just reverts it?
>
> Not necessary, your patch just relaxes the ABI for all apps, mine
> tightens it. You could instead move the untagging to __range_ok() and
> rebase my patch accordingly.

OK, will do. I'll also add a comment next to TIF_TAGGED_ADDR as Vincenzo asked.

>
> --
> Catalin
