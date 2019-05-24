Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFCA29A01
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404044AbfEXOYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 10:24:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404039AbfEXOYD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 10:24:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268E8A78;
        Fri, 24 May 2019 07:24:03 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65CAA3F575;
        Fri, 24 May 2019 07:23:57 -0700 (PDT)
Date:   Fri, 24 May 2019 15:23:54 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190524142352.GY28398@e103592.cambridge.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <20190521184856.GC2922@ziepe.ca>
 <20190522134925.GV28398@e103592.cambridge.arm.com>
 <20190523002052.GF15389@ziepe.ca>
 <20190523104256.GX28398@e103592.cambridge.arm.com>
 <20190523165708.q6ru7xg45aqfjzpr@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523165708.q6ru7xg45aqfjzpr@mbp>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 05:57:09PM +0100, Catalin Marinas wrote:
> On Thu, May 23, 2019 at 11:42:57AM +0100, Dave P Martin wrote:
> > On Wed, May 22, 2019 at 09:20:52PM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 22, 2019 at 02:49:28PM +0100, Dave Martin wrote:
> > > > If multiple people will care about this, perhaps we should try to
> > > > annotate types more explicitly in SYSCALL_DEFINEx() and ABI data
> > > > structures.
> > > > 
> > > > For example, we could have a couple of mutually exclusive modifiers
> > > > 
> > > > T __object *
> > > > T __vaddr * (or U __vaddr)
> > > > 
> > > > In the first case the pointer points to an object (in the C sense)
> > > > that the call may dereference but not use for any other purpose.
> > > 
> > > How would you use these two differently?
> > > 
> > > So far the kernel has worked that __user should tag any pointer that
> > > is from userspace and then you can't do anything with it until you
> > > transform it into a kernel something
> > 
> > Ultimately it would be good to disallow casting __object pointers execpt
> > to compatible __object pointer types, and to make get_user etc. demand
> > __object.
> > 
> > __vaddr pointers / addresses would be freely castable, but not to
> > __object and so would not be dereferenceable even indirectly.
> 
> I think it gets too complicated and there are ambiguous cases that we
> may not be able to distinguish. For example copy_from_user() may be used
> to copy a user data structure into the kernel, hence __object would
> work, while the same function may be used to copy opaque data to a file,
> so __vaddr may be a better option (unless I misunderstood your
> proposal).

Can you illustrate?  I'm not sure of your point here.

> We currently have T __user * and I think it's a good starting point. The
> prior attempt [1] was shut down because it was just hiding the cast
> using __force. We'd need to work through those cases again and rather
> start changing the function prototypes to avoid unnecessary casting in
> the callers (e.g. get_user_pages(void __user *) or come up with a new
> type) while changing the explicit casting to a macro where it needs to
> be obvious that we are converting a user pointer, potentially typed
> (tagged), to an untyped address range. We may need a user_ptr_to_ulong()
> macro or similar (it seems that we have a u64_to_user_ptr, wasn't aware
> of it).
> 
> It may actually not be far from what you suggested but I'd keep the
> current T __user * to denote possible dereference.

This may not have been clear, but __object and __vaddr would be
orthogonal to __user.  Since __object and __vaddr strictly constrain
what can be done with an lvalue, they could be cast on, but not be
cast off without __force.

Syscall arguments and pointer in ioctl structs etc. would typically
be annotated as __object __user * or __vaddr __user *.  Plain old
__user * would work as before, but would be more permissive and give
static analysers less information to go on.

Conversion or use or __object or __vaddr pointers would require specific
APIs in the kernel, so that we can be clear about the semantics.

Doing things this way would allow migration to annotation of most or all
ABI pointers with __object or __vaddr over time, but we wouldn't have to
do it all in one go.  Problem cases (which won't be the majority) could
continue to be plain __user.


This does not magically solve the challenges of MTE, but might provide
tools that are useful to help avoid bitrot and regressions over time.

I agree though that there might be a fair number of of cases that don't
conveniently fall under __object or __vaddr semantics.  It's hard to
know without trying it.

_Most_ syscall arguments seem to be fairly obviously one or another
though, and this approach has some possibility of scaling to ioctls
and other odd interfaces.

Cheers
---Dave
