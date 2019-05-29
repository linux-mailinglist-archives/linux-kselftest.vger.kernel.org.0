Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4F2E0DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2019 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfE2PSt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 May 2019 11:18:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2PSt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 May 2019 11:18:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95CC8341;
        Wed, 29 May 2019 08:18:48 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9C163F5AF;
        Wed, 29 May 2019 08:18:42 -0700 (PDT)
Date:   Wed, 29 May 2019 16:18:40 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
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
        Yishai Hadas <yishaih@mellanox.com>,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v15 05/17] arms64: untag user pointers passed to memory
 syscalls
Message-ID: <20190529151839.GF28398@e103592.cambridge.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
 <20190527143719.GA59948@MBP.local>
 <20190528145411.GA709@e119886-lin.cambridge.arm.com>
 <20190528154057.GD32006@arrakis.emea.arm.com>
 <20190528155644.GD28398@e103592.cambridge.arm.com>
 <20190528163400.GE32006@arrakis.emea.arm.com>
 <20190529124224.GE28398@e103592.cambridge.arm.com>
 <20190529132341.27t3knoxpb7t7y3g@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529132341.27t3knoxpb7t7y3g@mbp>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 29, 2019 at 02:23:42PM +0100, Catalin Marinas wrote:
> On Wed, May 29, 2019 at 01:42:25PM +0100, Dave P Martin wrote:
> > On Tue, May 28, 2019 at 05:34:00PM +0100, Catalin Marinas wrote:
> > > On Tue, May 28, 2019 at 04:56:45PM +0100, Dave P Martin wrote:
> > > > On Tue, May 28, 2019 at 04:40:58PM +0100, Catalin Marinas wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > My thoughts on allowing tags (quick look):
> > > > >
> > > > > brk - no
> > > > 
> > > > [...]
> > > > 
> > > > > mlock, mlock2, munlock - yes
> > > > > mmap - no (we may change this with MTE but not for TBI)
> > > > 
> > > > [...]
> > > > 
> > > > > mprotect - yes
> > > > 
> > > > I haven't following this discussion closely... what's the rationale for
> > > > the inconsistencies here (feel free to refer me back to the discussion
> > > > if it's elsewhere).
> > > 
> > > _My_ rationale (feel free to disagree) is that mmap() by default would
> > > not return a tagged address (ignoring MTE for now). If it gets passed a
> > > tagged address or a "tagged NULL" (for lack of a better name) we don't
> > > have clear semantics of whether the returned address should be tagged in
> > > this ABI relaxation. I'd rather reserve this specific behaviour if we
> > > overload the non-zero tag meaning of mmap() for MTE. Similar reasoning
> > > for mremap(), at least on the new_address argument (not entirely sure
> > > about old_address).
> > > 
> > > munmap() should probably follow the mmap() rules.
> > > 
> > > As for brk(), I don't see why the user would need to pass a tagged
> > > address, we can't associate any meaning to this tag.
> > > 
> > > For the rest, since it's likely such addresses would have been tagged by
> > > malloc() in user space, we should allow tagged pointers.
> > 
> > Those arguments seem reasonable.  We should try to capture this
> > somewhere when documenting the ABI.
> > 
> > To be clear, I'm not sure that we should guarantee anywhere that a
> > tagged pointer is rejected: rather the behaviour should probably be
> > left unspecified.  Then we can tidy it up incrementally.
> > 
> > (The behaviour is unspecified today, in any case.)
> 
> What is specified (or rather de-facto ABI) today is that passing a user
> address above TASK_SIZE (e.g. non-zero top byte) would fail in most
> cases. If we relax this with the TBI we may end up with some de-facto

I may be being too picky, but "would fail in most cases" sounds like
"unspecified" ?

> ABI before we actually get MTE hardware. Tightening it afterwards may be
> slightly more problematic, although MTE needs to be an explicit opt-in.
> 
> IOW, I wouldn't want to unnecessarily relax the ABI if we don't need to.

So long we don't block foreseeable future developments unnecessarily
either -- I agree there's a balance to be struck.

I guess this can be reviewed when we have nailed down the details a bit
further.

Cheers
---Dave
