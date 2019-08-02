Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 933717F57C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2019 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbfHBKuq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Aug 2019 06:50:46 -0400
Received: from foss.arm.com ([217.140.110.172]:49624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHBKuq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Aug 2019 06:50:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CBE3344;
        Fri,  2 Aug 2019 03:50:45 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF973F71F;
        Fri,  2 Aug 2019 03:50:40 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:50:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v19 02/15] arm64: Introduce prctl() options to control
 the tagged user addresses ABI
Message-ID: <20190802105038.GC4175@arrakis.emea.arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <1c05651c53f90d07e98ee4973c2786ccf315db12.1563904656.git.andreyknvl@google.com>
 <7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com>
 <2b274c6f-6023-8eb8-5a86-507e6000e13d@arm.com>
 <88c59d1e-eda9-fcfe-5ee3-64a331f34313@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c59d1e-eda9-fcfe-5ee3-64a331f34313@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 01, 2019 at 09:45:05AM -0700, Dave Hansen wrote:
> On 8/1/19 5:38 AM, Kevin Brodsky wrote:
> > This patch series only changes what is allowed or not at the syscall
> > interface. It does not change the address space size. On arm64, TBI (Top
> > Byte Ignore) has always been enabled for userspace, so it has never been
> > possible to use the upper 8 bits of user pointers for addressing.
> 
> Oh, so does the address space that's available already chop that out?

Yes. Currently the hardware only supports 52-bit virtual addresses. It
could be expanded (though it needs a 5th page table level) to 56-bit VA
but it's not currently on our (hardware) plans. Beyond 56-bit, it cannot
be done without breaking the software expectations (and hopefully I'll
retire before we need this ;)).

> > If other architectures were to support a similar functionality, then I
> > agree that a common and more generic interface (if needed) would be
> > helpful, but as it stands this is an arm64-specific prctl, and on arm64
> > the address tag is defined by the architecture as bits [63:56].
> 
> It should then be an arch_prctl(), no?

I guess you just want renaming SET_TAGGED_ADDR_CTRL() to
arch_prctl_tagged_addr_ctrl_set()? (similarly for 'get')

-- 
Catalin
