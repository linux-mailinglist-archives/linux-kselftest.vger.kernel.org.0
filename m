Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B5626505
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfEVNth (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 09:49:37 -0400
Received: from foss.arm.com ([217.140.101.70]:51862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfEVNth (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 09:49:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5198E80D;
        Wed, 22 May 2019 06:49:36 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94CFA3F575;
        Wed, 22 May 2019 06:49:30 -0700 (PDT)
Date:   Wed, 22 May 2019 14:49:28 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190522134925.GV28398@e103592.cambridge.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <20190521184856.GC2922@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521184856.GC2922@ziepe.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 21, 2019 at 03:48:56PM -0300, Jason Gunthorpe wrote:
> On Fri, May 17, 2019 at 03:49:31PM +0100, Catalin Marinas wrote:
> 
> > The tagged pointers (whether hwasan or MTE) should ideally be a
> > transparent feature for the application writer but I don't think we can
> > solve it entirely and make it seamless for the multitude of ioctls().
> > I'd say you only opt in to such feature if you know what you are doing
> > and the user code takes care of specific cases like ioctl(), hence the
> > prctl() proposal even for the hwasan.
> 
> I'm not sure such a dire view is warrented.. 
> 
> The ioctl situation is not so bad, other than a few special cases,
> most drivers just take a 'void __user *' and pass it as an argument to
> some function that accepts a 'void __user *'. sparse et al verify
> this. 
> 
> As long as the core functions do the right thing the drivers will be
> OK.
> 
> The only place things get dicy is if someone casts to unsigned long
> (ie for vma work) but I think that reflects that our driver facing
> APIs for VMAs are compatible with static analysis (ie I have no
> earthly idea why get_user_pages() accepts an unsigned long), not that
> this is too hard.

If multiple people will care about this, perhaps we should try to
annotate types more explicitly in SYSCALL_DEFINEx() and ABI data
structures.

For example, we could have a couple of mutually exclusive modifiers

T __object *
T __vaddr * (or U __vaddr)

In the first case the pointer points to an object (in the C sense)
that the call may dereference but not use for any other purpose.

In the latter case the pointer (or other type) is a virtual address
that the call does not dereference but my do other things with.

Also

U __really(T)

to tell static analysers the real type of pointers smuggled through
UAPI disguised as other types (*cough* KVM, etc.)

We could gradually make sparse more strict about the presence of
annotations and allowed conversions, add get/put_user() variants
that demand explicit annotation, etc.

find_vma() wouldn't work with a __object pointer, for example.  A
get_user_pages_for_dereference() might be needed for __object pointers
(embodying a promise from the caller that only the object will be
dereferenced within the mapped pages).

Thoughts?

This kind of thing would need widespread buy-in in order to be viable.

Cheers
---Dave
