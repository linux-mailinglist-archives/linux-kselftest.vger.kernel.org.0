Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13E9312B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2019 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfEaQqP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 May 2019 12:46:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54506 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfEaQqP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 May 2019 12:46:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DFE0A78;
        Fri, 31 May 2019 09:46:14 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48A043F59C;
        Fri, 31 May 2019 09:46:08 -0700 (PDT)
Date:   Fri, 31 May 2019 17:46:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Evgenii Stepanov <eugenis@google.com>,
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
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elliott Hughes <enh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190531164605.GC3568@arrakis.emea.arm.com>
References: <6049844a-65f5-f513-5b58-7141588fef2b@oracle.com>
 <20190523201105.oifkksus4rzcwqt4@mbp>
 <ffe58af3-7c70-d559-69f6-1f6ebcb0fec6@oracle.com>
 <20190524101139.36yre4af22bkvatx@mbp>
 <c6dd53d8-142b-3d8d-6a40-d21c5ee9d272@oracle.com>
 <CAAeHK+yAUsZWhp6xPAbWewX5Nbw+-G3svUyPmhXu5MVeEDKYvA@mail.gmail.com>
 <20190530171540.GD35418@arrakis.emea.arm.com>
 <CAAeHK+y34+SNz3Vf+_378bOxrPaj_3GaLCeC2Y2rHAczuaSz1A@mail.gmail.com>
 <20190531161954.GA3568@arrakis.emea.arm.com>
 <CAAeHK+zRDD7ZPPUA9cpwHOdgTRrJLWAby8Wg9oPgmhqMpHwvFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zRDD7ZPPUA9cpwHOdgTRrJLWAby8Wg9oPgmhqMpHwvFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 31, 2019 at 06:24:06PM +0200, Andrey Konovalov wrote:
> On Fri, May 31, 2019 at 6:20 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, May 31, 2019 at 04:29:10PM +0200, Andrey Konovalov wrote:
> > > On Thu, May 30, 2019 at 7:15 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > On Tue, May 28, 2019 at 04:14:45PM +0200, Andrey Konovalov wrote:
> > > > > Thanks for a lot of valuable input! I've read through all the replies
> > > > > and got somewhat lost. What are the changes I need to do to this
> > > > > series?
> > > > >
> > > > > 1. Should I move untagging for memory syscalls back to the generic
> > > > > code so other arches would make use of it as well, or should I keep
> > > > > the arm64 specific memory syscalls wrappers and address the comments
> > > > > on that patch?
> > > >
> > > > Keep them generic again but make sure we get agreement with Khalid on
> > > > the actual ABI implications for sparc.
> > >
> > > OK, will do. I find it hard to understand what the ABI implications
> > > are. I'll post the next version without untagging in brk, mmap,
> > > munmap, mremap (for new_address), mmap_pgoff, remap_file_pages, shmat
> > > and shmdt.
> >
> > It's more about not relaxing the ABI to accept non-zero top-byte unless
> > we have a use-case for it. For mmap() etc., I don't think that's needed
> > but if you think otherwise, please raise it.
> >
> > > > > 2. Should I make untagging opt-in and controlled by a command line argument?
> > > >
> > > > Opt-in, yes, but per task rather than kernel command line option.
> > > > prctl() is a possibility of opting in.
> > >
> > > OK. Should I store a flag somewhere in task_struct? Should it be
> > > inheritable on clone?
> >
> > A TIF flag would do but I'd say leave it out for now (default opted in)
> > until we figure out the best way to do this (can be a patch on top of
> > this series).
> 
> You mean leave the whole opt-in/prctl part out? So the only change
> would be to move untagging for memory syscalls into generic code?

Yes (or just wait until next week to see if the discussion settles
down).

-- 
Catalin
