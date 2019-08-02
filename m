Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DFB7F4E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2019 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391161AbfHBKUk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Aug 2019 06:20:40 -0400
Received: from foss.arm.com ([217.140.110.172]:49040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389243AbfHBKUk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Aug 2019 06:20:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E44A3344;
        Fri,  2 Aug 2019 03:20:38 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26BB63F71F;
        Fri,  2 Aug 2019 03:20:34 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:20:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
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
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Message-ID: <20190802102031.GB4175@arrakis.emea.arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <8c618cc9-ae68-9769-c5bb-67f1295abc4e@intel.com>
 <13b4cf53-3ecb-f7e7-b504-d77af15d77aa@arm.com>
 <CAAeHK+zTFqsLiB3Wf0bAi5A8ukQX5ZuvfUg4td-=r5UhBsUBOQ@mail.gmail.com>
 <96fd8da4-a912-f6cc-2b32-5791027dbbd5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96fd8da4-a912-f6cc-2b32-5791027dbbd5@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 01, 2019 at 08:36:47AM -0700, Dave Hansen wrote:
> On 8/1/19 5:48 AM, Andrey Konovalov wrote:
> > On Thu, Aug 1, 2019 at 2:11 PM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> >> On 31/07/2019 17:50, Dave Hansen wrote:
> >>> On 7/23/19 10:58 AM, Andrey Konovalov wrote:
> >>>> The mmap and mremap (only new_addr) syscalls do not currently accept
> >>>> tagged addresses. Architectures may interpret the tag as a background
> >>>> colour for the corresponding vma.
> >>>
> >>> What the heck is a "background colour"? :)
> >>
> >> Good point, this is some jargon that we started using for MTE, the idea being that
> >> the kernel could set a tag value (specified during mmap()) as "background colour" for
> >> anonymous pages allocated in that range.
> >>
> >> Anyway, this patch series is not about MTE. Andrey, for v20 (if any), I think it's
> >> best to drop this last sentence to avoid any confusion.

Indeed, the part with the "background colour" and even the "currently"
adverb should be dropped.

Also, if we merge the patches via different trees anyway, I don't think
there is a need for Andrey to integrate them with his series. We can
pick them up directly in the arm64 tree (once the review finished).

> OK, but what does that mean for tagged addresses getting passed to
> mmap/mremap?  That sentence read to me like "architectures might allow
> tags for ...something...".  So do we accept tagged addresses into those
> syscalls?

If mmap() does not return a tagged address, the reasoning is that it
should not accept one as an address hint (with or without MAP_FIXED).
Note that these docs should only describe the top-byte-ignore ABI while
leaving the memory tagging for a future patchset.

In that future patchset, we may want to update the mmap() ABI to allow,
only in conjunction with PROT_MTE, a tagged pointer as an address
argument. In such case mmap() will return a tagged address and the pages
pre-coloured (on fault) with the tag requested by the user. As I said,
that's to be discussed later in the year.

-- 
Catalin
