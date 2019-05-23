Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6A2845F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfEWQ5X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 12:57:23 -0400
Received: from foss.arm.com ([217.140.101.70]:50904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfEWQ5W (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 12:57:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0774C374;
        Thu, 23 May 2019 09:57:22 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B06C3F5AF;
        Thu, 23 May 2019 09:57:15 -0700 (PDT)
Date:   Thu, 23 May 2019 17:57:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Christian Koenig <Christian.Koenig@amd.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
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
Message-ID: <20190523165708.q6ru7xg45aqfjzpr@mbp>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <20190521184856.GC2922@ziepe.ca>
 <20190522134925.GV28398@e103592.cambridge.arm.com>
 <20190523002052.GF15389@ziepe.ca>
 <20190523104256.GX28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523104256.GX28398@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 11:42:57AM +0100, Dave P Martin wrote:
> On Wed, May 22, 2019 at 09:20:52PM -0300, Jason Gunthorpe wrote:
> > On Wed, May 22, 2019 at 02:49:28PM +0100, Dave Martin wrote:
> > > If multiple people will care about this, perhaps we should try to
> > > annotate types more explicitly in SYSCALL_DEFINEx() and ABI data
> > > structures.
> > > 
> > > For example, we could have a couple of mutually exclusive modifiers
> > > 
> > > T __object *
> > > T __vaddr * (or U __vaddr)
> > > 
> > > In the first case the pointer points to an object (in the C sense)
> > > that the call may dereference but not use for any other purpose.
> > 
> > How would you use these two differently?
> > 
> > So far the kernel has worked that __user should tag any pointer that
> > is from userspace and then you can't do anything with it until you
> > transform it into a kernel something
> 
> Ultimately it would be good to disallow casting __object pointers execpt
> to compatible __object pointer types, and to make get_user etc. demand
> __object.
> 
> __vaddr pointers / addresses would be freely castable, but not to
> __object and so would not be dereferenceable even indirectly.

I think it gets too complicated and there are ambiguous cases that we
may not be able to distinguish. For example copy_from_user() may be used
to copy a user data structure into the kernel, hence __object would
work, while the same function may be used to copy opaque data to a file,
so __vaddr may be a better option (unless I misunderstood your
proposal).

We currently have T __user * and I think it's a good starting point. The
prior attempt [1] was shut down because it was just hiding the cast
using __force. We'd need to work through those cases again and rather
start changing the function prototypes to avoid unnecessary casting in
the callers (e.g. get_user_pages(void __user *) or come up with a new
type) while changing the explicit casting to a macro where it needs to
be obvious that we are converting a user pointer, potentially typed
(tagged), to an untyped address range. We may need a user_ptr_to_ulong()
macro or similar (it seems that we have a u64_to_user_ptr, wasn't aware
of it).

It may actually not be far from what you suggested but I'd keep the
current T __user * to denote possible dereference.

[1] https://lore.kernel.org/lkml/5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com/

-- 
Catalin
