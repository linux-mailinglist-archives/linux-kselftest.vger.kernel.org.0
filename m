Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67623D45F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406426AbfFKRjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 13:39:13 -0400
Received: from foss.arm.com ([217.140.110.172]:38942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406416AbfFKRjM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 13:39:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF6D337;
        Tue, 11 Jun 2019 10:39:11 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B7793F73C;
        Tue, 11 Jun 2019 10:39:06 -0700 (PDT)
Date:   Tue, 11 Jun 2019 18:39:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
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
Subject: Re: [PATCH v16 02/16] arm64: untag user pointers in access_ok and
 __uaccess_mask_ptr
Message-ID: <20190611173903.4icrfmoyfvms35cy@mbp>
References: <cover.1559580831.git.andreyknvl@google.com>
 <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
 <20190610175326.GC25803@arrakis.emea.arm.com>
 <20190611145720.GA63588@arrakis.emea.arm.com>
 <CAAeHK+z5nSOOaGfehETzznNcMq5E5U+Eb1rZE16UVsT8FWT0Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+z5nSOOaGfehETzznNcMq5E5U+Eb1rZE16UVsT8FWT0Vg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 11, 2019 at 07:09:46PM +0200, Andrey Konovalov wrote:
> On Tue, Jun 11, 2019 at 4:57 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Mon, Jun 10, 2019 at 06:53:27PM +0100, Catalin Marinas wrote:
> > > On Mon, Jun 03, 2019 at 06:55:04PM +0200, Andrey Konovalov wrote:
> > > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > > index e5d5f31c6d36..9164ecb5feca 100644
> > > > --- a/arch/arm64/include/asm/uaccess.h
> > > > +++ b/arch/arm64/include/asm/uaccess.h
> > > > @@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
> > > >     return ret;
> > > >  }
> > > >
> > > > -#define access_ok(addr, size)      __range_ok(addr, size)
> > > > +#define access_ok(addr, size)      __range_ok(untagged_addr(addr), size)
> > >
> > > I'm going to propose an opt-in method here (RFC for now). We can't have
> > > a check in untagged_addr() since this is already used throughout the
> > > kernel for both user and kernel addresses (khwasan) but we can add one
> > > in __range_ok(). The same prctl() option will be used for controlling
> > > the precise/imprecise mode of MTE later on. We can use a TIF_ flag here
> > > assuming that this will be called early on and any cloned thread will
> > > inherit this.
> >
> > Updated patch, inlining it below. Once we agreed on the approach, I
> > think Andrey can insert in in this series, probably after patch 2. The
> > differences from the one I posted yesterday:
> >
> > - renamed PR_* macros together with get/set variants and the possibility
> >   to disable the relaxed ABI
> >
> > - sysctl option - /proc/sys/abi/tagged_addr to disable the ABI globally
> >   (just the prctl() opt-in, tasks already using it won't be affected)
> >
> > And, of course, it needs more testing.
> 
> Sure, I'll add it to the series.
> 
> Should I drop access_ok() change from my patch, since yours just reverts it?

Not necessary, your patch just relaxes the ABI for all apps, mine
tightens it. You could instead move the untagging to __range_ok() and
rebase my patch accordingly.

-- 
Catalin
