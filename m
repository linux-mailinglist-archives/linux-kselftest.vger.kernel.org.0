Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3810927AF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 12:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfEWKnG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 06:43:06 -0400
Received: from foss.arm.com ([217.140.101.70]:43642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWKnG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 06:43:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84A77341;
        Thu, 23 May 2019 03:43:05 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A023F718;
        Thu, 23 May 2019 03:42:59 -0700 (PDT)
Date:   Thu, 23 May 2019 11:42:57 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Christian Koenig <Christian.Koenig@amd.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Lee Smith <Lee.Smith@arm.com>, linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190523104256.GX28398@e103592.cambridge.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <20190521184856.GC2922@ziepe.ca>
 <20190522134925.GV28398@e103592.cambridge.arm.com>
 <20190523002052.GF15389@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523002052.GF15389@ziepe.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 09:20:52PM -0300, Jason Gunthorpe wrote:
> On Wed, May 22, 2019 at 02:49:28PM +0100, Dave Martin wrote:
> > On Tue, May 21, 2019 at 03:48:56PM -0300, Jason Gunthorpe wrote:
> > > On Fri, May 17, 2019 at 03:49:31PM +0100, Catalin Marinas wrote:
> > > 
> > > > The tagged pointers (whether hwasan or MTE) should ideally be a
> > > > transparent feature for the application writer but I don't think we can
> > > > solve it entirely and make it seamless for the multitude of ioctls().
> > > > I'd say you only opt in to such feature if you know what you are doing
> > > > and the user code takes care of specific cases like ioctl(), hence the
> > > > prctl() proposal even for the hwasan.
> > > 
> > > I'm not sure such a dire view is warrented.. 
> > > 
> > > The ioctl situation is not so bad, other than a few special cases,
> > > most drivers just take a 'void __user *' and pass it as an argument to
> > > some function that accepts a 'void __user *'. sparse et al verify
> > > this. 
> > > 
> > > As long as the core functions do the right thing the drivers will be
> > > OK.
> > > 
> > > The only place things get dicy is if someone casts to unsigned long
> > > (ie for vma work) but I think that reflects that our driver facing
> > > APIs for VMAs are compatible with static analysis (ie I have no
> > > earthly idea why get_user_pages() accepts an unsigned long), not that
> > > this is too hard.
> > 
> > If multiple people will care about this, perhaps we should try to
> > annotate types more explicitly in SYSCALL_DEFINEx() and ABI data
> > structures.
> > 
> > For example, we could have a couple of mutually exclusive modifiers
> > 
> > T __object *
> > T __vaddr * (or U __vaddr)
> > 
> > In the first case the pointer points to an object (in the C sense)
> > that the call may dereference but not use for any other purpose.
> 
> How would you use these two differently?
> 
> So far the kernel has worked that __user should tag any pointer that
> is from userspace and then you can't do anything with it until you
> transform it into a kernel something

Ultimately it would be good to disallow casting __object pointers execpt
to compatible __object pointer types, and to make get_user etc. demand
__object.

__vaddr pointers / addresses would be freely castable, but not to
__object and so would not be dereferenceable even indirectly.

Or that's the general idea.  Figuring out a sane set of rules that we
could actually check / enforce would require a bit of work.

(Whether the __vaddr base type is a pointer or an integer type is
probably moot, due to the restrictions we would place on the use of
these anyway.)

> > to tell static analysers the real type of pointers smuggled through
> > UAPI disguised as other types (*cough* KVM, etc.)
> 
> Yes, that would help alot, we often have to pass pointers through a
> u64 in the uAPI, and there is no static checker support to make sure
> they are run through the u64_to_user_ptr() helper.

Agreed.

Cheers
---Dave
