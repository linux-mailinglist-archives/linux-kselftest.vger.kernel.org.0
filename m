Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2D874B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406047AbfHIJAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 05:00:25 -0400
Received: from foss.arm.com ([217.140.110.172]:43754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405974AbfHIJAZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 05:00:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F595344;
        Fri,  9 Aug 2019 02:00:24 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 796343F706;
        Fri,  9 Aug 2019 02:00:19 -0700 (PDT)
Date:   Fri, 9 Aug 2019 10:00:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        dri-devel@lists.freedesktop.org,
        Kostya Serebryany <kcc@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Message-ID: <20190809090016.GA23083@arrakis.emea.arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
 <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
 <20190724142059.GC21234@fuggles.cambridge.arm.com>
 <20190806171335.4dzjex5asoertaob@willie-the-truck>
 <CAAeHK+zF01mxU+PkEYLkoVu-ZZM6jNfL_OwMJKRwLr-sdU4Myg@mail.gmail.com>
 <201908081410.C16D2BD@keescook>
 <20190808153300.09d3eb80772515f0ea062833@linux-foundation.org>
 <201908081608.A4F6711@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908081608.A4F6711@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 08, 2019 at 04:09:04PM -0700, Kees Cook wrote:
> On Thu, Aug 08, 2019 at 03:33:00PM -0700, Andrew Morton wrote:
> > On Thu, 8 Aug 2019 14:12:19 -0700 Kees Cook <keescook@chromium.org> wrote:
> > 
> > > > The ones that are left are the mm ones: 4, 5, 6, 7 and 8.
> > > > 
> > > > Andrew, could you take a look and give your Acked-by or pick them up directly?
> > > 
> > > Given the subsystem Acks, it seems like 3-10 and 12 could all just go
> > > via Andrew? I hope he agrees. :)
> > 
> > I'll grab everything that has not yet appeared in linux-next.  If more
> > of these patches appear in linux-next I'll drop those as well.
> > 
> > The review discussion against " [PATCH v19 02/15] arm64: Introduce
> > prctl() options to control the tagged user addresses ABI" has petered
> > out inconclusively.  prctl() vs arch_prctl().
> 
> I've always disliked arch_prctl() existing at all. Given that tagging is
> likely to be a multi-architectural feature, it seems like the controls
> should live in prctl() to me.

It took a bit of grep'ing to figure out what Dave H meant by
arch_prctl(). It's an x86-specific syscall which we do not have on arm64
(and possibly any other architecture). Actually, we don't have any arm64
specific syscalls, only the generic unistd.h, hence the confusion. For
other arm64-specific prctls like SVE we used the generic sys_prctl() and
I can see x86 not being consistent either (PR_MPX_ENABLE_MANAGEMENT).

In general I disagree with adding any arm64-specific syscalls but in
this instance it can't even be justified. I'd rather see some clean-up
similar to arch_ptrace/ptrace_request than introducing new syscall
numbers (but as I suggested in my reply to Dave, that's for another
patch series).

-- 
Catalin
