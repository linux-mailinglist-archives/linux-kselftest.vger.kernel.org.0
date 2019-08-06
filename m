Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C8F837B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2019 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbfHFRNr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Aug 2019 13:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfHFRNq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Aug 2019 13:13:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACF82086D;
        Tue,  6 Aug 2019 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565111625;
        bh=GcwPgkJicx4YCfVs1IPwu6WwyqpK78qeXeT/YMfDkko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rTAT9bH7GKNJUZdS8BRtbH8phw4qgZ5+dRNFkldjVWk6dGxX0O1d/RnE/0V20gryu
         PTJMl31RRRdUsoRUBPiBr87DgRaB/HWSPKLtCibTJQQUtSYBOvQ2oBVDM1HUaAlT2q
         mkbOtB7+YYYk5DiFCNquMbqioXWuU2alu3yKrGRo=
Date:   Tue, 6 Aug 2019 18:13:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Kees Cook <keescook@chromium.org>,
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
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Message-ID: <20190806171335.4dzjex5asoertaob@willie-the-truck>
References: <cover.1563904656.git.andreyknvl@google.com>
 <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
 <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
 <20190724142059.GC21234@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724142059.GC21234@fuggles.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 24, 2019 at 03:20:59PM +0100, Will Deacon wrote:
> On Wed, Jul 24, 2019 at 04:16:49PM +0200, Andrey Konovalov wrote:
> > On Wed, Jul 24, 2019 at 4:02 PM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Jul 23, 2019 at 08:03:29PM +0200, Andrey Konovalov wrote:
> > > > Should this go through the mm or the arm tree?
> > >
> > > I would certainly prefer to take at least the arm64 bits via the arm64 tree
> > > (i.e. patches 1, 2 and 15). We also need a Documentation patch describing
> > > the new ABI.
> > 
> > Sounds good! Should I post those patches together with the
> > Documentation patches from Vincenzo as a separate patchset?
> 
> Yes, please (although as you say below, we need a new version of those
> patches from Vincenzo to address the feedback on v5). The other thing I
> should say is that I'd be happy to queue the other patches in the series
> too, but some of them are missing acks from the relevant maintainers (e.g.
> the mm/ and fs/ changes).

Ok, I've queued patches 1, 2, and 15 on a stable branch here:

  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/tbi

which should find its way into -next shortly via our for-next/core branch.
If you want to make changes, please send additional patches on top.

This is targetting 5.4, but I will drop it before the merge window if
we don't have both of the following in place:

  * Updated ABI documentation with Acks from Catalin and Kevin
  * The other patches in the series either Acked (so I can pick them up)
    or queued via some other tree(s) for 5.4.

Make sense?

Cheers,

Will
