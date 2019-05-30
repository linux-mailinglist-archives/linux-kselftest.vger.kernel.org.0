Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3709430074
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2019 18:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfE3Q51 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 May 2019 12:57:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3Q51 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 May 2019 12:57:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B60E3341;
        Thu, 30 May 2019 09:57:26 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9E133F5AF;
        Thu, 30 May 2019 09:57:20 -0700 (PDT)
Date:   Thu, 30 May 2019 17:57:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
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
Subject: Re: [PATCH v15 05/17] arms64: untag user pointers passed to memory
 syscalls
Message-ID: <20190530165717.GC35418@arrakis.emea.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
 <20190527143719.GA59948@MBP.local>
 <20190528145411.GA709@e119886-lin.cambridge.arm.com>
 <20190528154057.GD32006@arrakis.emea.arm.com>
 <11193998209cc6ff34e7d704f081206b8787b174.camel@oracle.com>
 <20190529142008.5quqv3wskmpwdfbu@mbp>
 <b2753e81-7b57-481f-0095-3c6fecb1a74c@oracle.com>
 <20190530151105.GA35418@arrakis.emea.arm.com>
 <f79336b5-46b4-39c0-b754-23366207e32d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79336b5-46b4-39c0-b754-23366207e32d@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 30, 2019 at 10:05:55AM -0600, Khalid Aziz wrote:
> On 5/30/19 9:11 AM, Catalin Marinas wrote:
> > So if a database program is doing an anonymous mmap(PROT_TBI) of 100GB,
> > IIUC for sparc the faulted-in pages will have random colours (on 64-byte
> > granularity). Ignoring the information leak from prior uses of such
> > pages, it would be the responsibility of the db program to issue the
> > stxa. On arm64, since we also want to do this via malloc(), any large
> > allocation would require all pages to be faulted in so that malloc() can
> > set the write colour before being handed over to the user. That's what
> > we want to avoid and the user is free to repaint the memory as it likes.
> 
> On sparc, any newly allocated page is cleared along with any old tags on
> it. Since clearing tag happens automatically when page is cleared on
> sparc, clear_user_page() will need to execute additional stxa
> instructions to set a new tag. It is doable. In a way it is done already
> if page is being pre-colored with tag 0 always ;)

Ah, good to know. On arm64 we'd have to use different instructions,
although the same loop.

> Where would the pre-defined tag be stored - as part of address stored
> in vm_start or a new field in vm_area_struct?

I think we can discuss the details when we post the actual MTE patches.
In our internal hack we overloaded the VM_HIGH_ARCH_* flags and selected
CONFIG_ARCH_USES_HIGH_VMA_FLAGS (used for pkeys on x86).

For the time being, I'd rather restrict tagged addresses passed to
mmap() until we agreed that they have any meaning. If we allowed them
now but get ignored (though probably no-one would be doing this), I feel
it's slightly harder to change the semantics afterwards.

Thanks.

-- 
Catalin
